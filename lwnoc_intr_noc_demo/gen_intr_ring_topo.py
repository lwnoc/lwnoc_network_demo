"""
gen_intr_ring_topo.py — Generate the 4-INIU + 2-TNIU interrupt ring NoC.

Usage:
    cd lwnoc_intr_noc_demo
    python gen_intr_ring_topo.py

Outputs:
    intr_ring_logic_topology.json   — serialised topology
    build_logic/                    — generated Verilog
    filelist/filelist.f             — top-level compile filelist
"""
import os
import re
import shutil
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent                                     # lwnoc_network_demo/
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

# Optional: use the local slang binary bundled in the repo
LOCAL_SLANG_BIN = LWNOC_TOPO_ROOT / "uhdl" / "slang" / "build" / "bin"
if os.environ.get("USE_LOCAL_SLANG") == "1" and LOCAL_SLANG_BIN.exists():
    os.environ["PATH"] = f"{LOCAL_SLANG_BIN}:{os.environ.get('PATH', '')}"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.node import reset_global_state
from topo_core.utils.serialization import TopologySerializer

from IntrRingTopo import IntrRingLogicTopo


BOUNDARY_IMPORT_TARGETS = (
    "*_async_sys_side.sv",
    "*_async_top_side.sv",
    "*_top_wrap.sv",
)
LP_TYPE_PORT_RE = re.compile(
    r"^(?P<indent>\s*)(?P<direction>input|output)\s+"
    r"(?P<type>(?:[A-Za-z0-9_]+::)?(?:lwnoc_lp_req_signal_t|lwnoc_pchannel_active_t|lwnoc_pchannel_state_t))"
    r"(?P<spacing>\s+)(?P<name>[A-Za-z0-9_]+)(?P<tail>\s*(?:,|\)\s*;))$",
    re.MULTILINE,
)


def main():
    reset_global_state()

    topo = IntrRingLogicTopo()

    topology_json = THIS_DIR / "intr_ring_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()

    _patch_ring_station_params(build_dir / "intr_ring_noc_4i2t")
    from IntrNode import IntrIniuSysNode, IntrTniuSysNode
    _patch_async_fifo_depths(
        build_dir,
        iniu_depth=IntrIniuSysNode.INIU_ASYNC_FIFO_DEPTH,
        tniu_depth=IntrTniuSysNode.TNIU_ASYNC_FIFO_DEPTH,
    )
    _patch_lp_struct_links(build_dir / "intr_ring_noc_4i2t")
    _normalize_boundary_import_style(build_dir)
    _consolidate_top_side(build_dir)
    _flatten_lp_boundary_typedef_ports(build_dir)
    _publish_top_filelist(
        build_dir / "intr_ring_noc_4i2t" / "filelist.f",
        THIS_DIR / "filelist" / "filelist.f",
    )

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to  {build_dir}")
    print(f"Top filelist written to   {THIS_DIR / 'filelist' / 'filelist.f'}")


# -----------------------------------------------------------------------------
# Post-generation patch: inject per-node ring station parameters.
#
# The UHDL framework instantiates all ring stations without #(.PARAM(value))
# overrides because TemplateComponent kwargs only affect the Python port-width
# model (slang AST parse), not the generated Verilog instantiation text.
# We therefore apply a deterministic string substitution after generation.
#
# Node positions (ring order CW):
#   iniu0=0, iniu1=1, iniu2=2, iniu3=3, tniu0=4, tniu1=5
# -----------------------------------------------------------------------------

def _build_param_override(node_id: int, has_iniu: int, has_tniu: int) -> str:
    return (
        f"\tintr_ring_sta_interrupt_req_ring_station #(\n"
        f"\t\t.NODE_ID    ({node_id}),\n"
        f"\t\t.NODE_COUNT (6),\n"
        f"\t\t.HAS_INIU   (1'b{has_iniu}),\n"
        f"\t\t.HAS_TNIU   (1'b{has_tniu})) ring_sta ("
    )


_RING_NODE_PARAMS = {
    "iniu0_ring.v": _build_param_override(0, 1, 0),
    "iniu1_ring.v": _build_param_override(1, 1, 0),
    "iniu2_ring.v": _build_param_override(2, 1, 0),
    "iniu3_ring.v": _build_param_override(3, 1, 0),
    "tniu0_ring.v": _build_param_override(4, 0, 1),
    "tniu1_ring.v": _build_param_override(5, 0, 1),
}

_UNPARAM_INST = "\tintr_ring_sta_interrupt_req_ring_station ring_sta ("


def _patch_ring_station_params(ring_dir: Path) -> None:
    """Replace bare ring-station instantiation with parameterized version."""
    for fname, replacement in _RING_NODE_PARAMS.items():
        fpath = ring_dir / fname
        if not fpath.exists():
            print(f"  [patch] WARNING: {fpath} not found, skipping")
            continue
        text = fpath.read_text()
        if _UNPARAM_INST in text:
            fpath.write_text(text.replace(_UNPARAM_INST, replacement))
            print(f"  [patch] {fname}: ring station parameterized (NODE_ID={list(_RING_NODE_PARAMS.keys()).index(fname)})")
        else:
            print(f"  [patch] {fname}: already patched or pattern not found, skip")


def _patch_async_fifo_depths(build_dir: Path, iniu_depth: int, tniu_depth: int) -> None:
    """Fix ASYNC_FIFO_DEPTH defaults in generated block .sv files to match design intent.

    ip_builder preserves source RTL parameter defaults, which differ between
    sys-side and top-side (iniu_top=10, tniu_sys=16 from source). The Python
    kwargs in IntrNode.py set the intended depths (INIU=16, TNIU=10), but those
    values are not automatically propagated to the generated .sv parameter defaults.
    This mismatch causes PCWM-W width mismatches at compile time.

    This post-gen patch aligns the baked-in defaults with the design intent.
    """
    import re

    def _replace_depth(path: Path, old_depth: int, new_depth: int) -> bool:
        if not path.exists():
            print(f"  [depth_patch] WARNING: {path} not found, skipping")
            return False
        text = path.read_text()
        # Match any spacing variant: `ASYNC_FIFO_DEPTH = <N>` or `ASYNC_FIFO_DEPTH    = <N>`
        pattern = rf"(ASYNC_FIFO_DEPTH\s*=\s*){old_depth}\b"
        new_text, n = re.subn(pattern, rf"\g<1>{new_depth}", text)
        if n > 0:
            path.write_text(new_text)
            print(f"  [depth_patch] {path.name}: ASYNC_FIFO_DEPTH {old_depth} → {new_depth} ({n} replacement(s))")
            return True
        else:
            print(f"  [depth_patch] {path.name}: pattern not found (already {new_depth}?), skip")
            return False

    # INIU top-side: source RTL default=10, design intent=iniu_depth
    _replace_depth(
        build_dir / "intr_iniu_top_side" / "intr_iniu_top_interrupt_iniu_async_top_side.sv",
        old_depth=10, new_depth=iniu_depth,
    )

    # TNIU sys-side: source RTL default=16, design intent=tniu_depth
    for tniu_sys_dir in sorted(build_dir.glob("tniu*_sys")):
        for sv_path in sorted(tniu_sys_dir.glob("*_interrupt_tniu_async_sys_side.sv")):
            _replace_depth(sv_path, old_depth=16, new_depth=tniu_depth)


def _patch_lp_struct_links(ring_dir: Path) -> None:
    """Restore generated typed-struct LP links inside INIU/TNIU wrappers.

    The wrapper generator currently drops internal connections when the bridge
    signals are `lwnoc_lp_req_signal_t` rather than plain bit-vectors, leaving
    ports such as `s_async_master_hub_*` / `m_async_master_hub_*` disconnected.
    This demo-local post-pass reintroduces the missing typed signals after
    generation so the refreshed demo remains functional.
    """

    def _insert_decl_block(text: str, decl_block: str) -> tuple[str, bool]:
        marker = "\t//Wire define for Inout.\n"
        if decl_block.strip() in text:
            return text, False
        if marker not in text:
            return text, False
        return text.replace(marker, decl_block + marker, 1), True

    def _apply_replacements(text: str, replacements: list[tuple[str, str]]) -> tuple[str, bool]:
        changed = False
        for old, new in replacements:
            if old in text:
                text = text.replace(old, new)
                changed = True
        return text, changed

    iniu_decl_block = (
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req;\n"
        "\n"
    )
    iniu_replacements = [
        (
            ".s_async_master_hub_rx_req(),",
            ".s_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),",
        ),
        (
            ".s_async_master_hub_tx_req(),",
            ".s_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),",
        ),
        (
            ".m_async_master_hub_rx_req(),",
            ".m_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),",
        ),
        (
            ".m_async_master_hub_tx_req(),",
            ".m_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),",
        ),
    ]

    tniu_decl_block = (
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req;\n"
        "\n"
    )
    tniu_replacements = [
        (
            ".s_niu_lp_hub_rx_req(),",
            ".s_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),",
        ),
        (
            ".s_niu_lp_hub_tx_req(),",
            ".s_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req),",
        ),
        (
            ".s_async_master_hub_rx_req(),",
            ".s_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),",
        ),
        (
            ".s_async_master_hub_tx_req(),",
            ".s_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),",
        ),
        (
            ".m_async_master_hub_rx_req(),",
            ".m_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),",
        ),
        (
            ".m_async_master_hub_tx_req(),",
            ".m_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),",
        ),
        (
            ".m_niu_lp_hub_rx_req(),",
            ".m_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),",
        ),
        (
            ".m_niu_lp_hub_tx_req());",
            ".m_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req));",
        ),
    ]

    for fpath in sorted(ring_dir.glob("iniu*.v")):
        if fpath.stem.endswith("_ring"):
            continue
        text = fpath.read_text()
        changed = False
        text, inserted = _insert_decl_block(text, iniu_decl_block)
        changed |= inserted
        text, replaced = _apply_replacements(text, iniu_replacements)
        changed |= replaced
        if changed:
            fpath.write_text(text)
            print(f"  [lp_patch] {fpath.name}: restored internal async LP links")

    for fpath in sorted(ring_dir.glob("tniu*.v")):
        if fpath.stem.endswith("_ring"):
            continue
        text = fpath.read_text()
        changed = False
        text, inserted = _insert_decl_block(text, tniu_decl_block)
        changed |= inserted
        text, replaced = _apply_replacements(text, tniu_replacements)
        changed |= replaced
        if changed:
            fpath.write_text(text)
            print(f"  [lp_patch] {fpath.name}: restored internal LP hub links")


def _normalize_boundary_import_style(build_dir: Path) -> None:
    """Force package-level imports in generated boundary modules."""

    grouped_import_re = re.compile(
        r"(^\s*import\s+([^;]+)::[A-Za-z0-9_]+;\n)+",
        re.MULTILINE,
    )

    def _collapse_group(match: re.Match[str]) -> str:
        raw_lines = [line for line in match.group(0).splitlines() if line.strip()]
        indent = raw_lines[0][: len(raw_lines[0]) - len(raw_lines[0].lstrip())]
        packages: list[str] = []
        seen: set[str] = set()
        for line in raw_lines:
            stripped = line.strip()
            pkg_name = stripped[len("import ") : stripped.rfind("::")].strip()
            if pkg_name not in seen:
                seen.add(pkg_name)
                packages.append(pkg_name)
        return "".join(f"{indent}import {pkg_name}::*;\n" for pkg_name in packages)

    for pattern in BOUNDARY_IMPORT_TARGETS:
        for sv_path in sorted(build_dir.glob(f"**/{pattern}")):
            content = sv_path.read_text()
            updated = grouped_import_re.sub(_collapse_group, content)
            if updated != content:
                sv_path.write_text(updated)
                print(f"  [boundary_import] normalized {sv_path.relative_to(build_dir)}")


def _flatten_lp_boundary_typedef_ports(build_dir: Path) -> None:
    """Flatten LP typedef ports at published demo boundaries to plain vectors."""
    candidate_paths = {
        *build_dir.glob("**/*_async_sys_side.sv"),
        *build_dir.glob("**/*_async_top_side.sv"),
        *build_dir.glob("**/*.v"),
    }

    for path in sorted(candidate_paths):
        if _flatten_lp_boundary_ports_in_file(path):
            print(f"  [lp_flatten] flattened {path.relative_to(build_dir)}")


def _flatten_lp_boundary_ports_in_file(path: Path) -> bool:
    text = path.read_text()
    header_end = text.find(");")
    if header_end == -1:
        return False

    header = text[: header_end + 2]
    body = text[header_end + 2 :]
    if not LP_TYPE_PORT_RE.search(header):
        return False

    port_specs: list[dict[str, str]] = []

    def _replace_port(match: re.Match[str]) -> str:
        type_name = match.group("type")
        name = match.group("name")
        alias = f"{name}__typed"
        width_expr = f"$bits({type_name})"
        port_specs.append(
            {
                "direction": match.group("direction"),
                "type": type_name,
                "name": name,
                "alias": alias,
            }
        )
        return (
            f"{match.group('indent')}{match.group('direction')} logic "
            f"[{width_expr}-1:0]{match.group('spacing')}{name}{match.group('tail')}"
        )

    new_header = LP_TYPE_PORT_RE.sub(_replace_port, header)
    new_body = body
    for spec in port_specs:
        new_body = re.sub(rf"\b{spec['name']}\b", spec["alias"], new_body)

    decl_indent = "\t" if "\n\t//Wire define for this module." in new_body else "    "
    bridge_lines = ["", f"{decl_indent}//Flattened LP boundary typedef bridge."]
    for spec in port_specs:
        bridge_lines.append(f"{decl_indent}{spec['type']} {spec['alias']};")
    bridge_lines.append("")
    for spec in port_specs:
        if spec["direction"] == "input":
            bridge_lines.append(
                f"{decl_indent}assign {spec['alias']} = {spec['type']}'({spec['name']});"
            )
        else:
            bridge_lines.append(f"{decl_indent}assign {spec['name']} = {spec['alias']};")
    bridge_block = "\n".join(bridge_lines) + "\n"

    wire_marker = f"{decl_indent}//Wire define for this module.\n"
    if wire_marker in new_body:
        new_body = new_body.replace(wire_marker, wire_marker + bridge_block, 1)
    else:
        new_body = "\n" + bridge_block + new_body.lstrip("\n")

    updated = new_header + new_body
    if updated == text:
        return False
    path.write_text(updated)
    return True


# ---------------------------------------------------------------------------
# Post-gen: consolidate per-block top-side dirs into ONE combined dir.
# SKILL §1b Principle 1: all top-side content in a single directory.
# ---------------------------------------------------------------------------
_COMBINED_DIR = "intr_ring_noc_4i2t"
_SHARED_ENV = "INTR_RING_NOC_DIR"

_TOP_SIDE_BLOCKS = {
    "intr_iniu_top_side": "INTR_INIU_TOP_OUT_DIR",
    "intr_tniu_top_side": "INTR_TNIU_TOP_OUT_DIR",
    "intr_ring_lnk":     "INTR_RING_LNK_OUT_DIR",
    "intr_ring_sta":     "INTR_RING_STA_OUT_DIR",
    "intr_ring_req_sink": "INTR_RING_REQ_SINK_OUT_DIR",
    "intr_ring_req_zero_source": "INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
}


def _consolidate_top_side(build_dir: Path) -> None:
    """Merge per-block top-side dirs into the combined topo wrapper dir."""
    combined = build_dir / _COMBINED_DIR

    for block_name, old_env in _TOP_SIDE_BLOCKS.items():
        block_dir = build_dir / block_name
        if not block_dir.exists():
            print(f"  [consolidate] WARNING: {block_dir.name}/ not found, skipping")
            continue

        for f in sorted(block_dir.iterdir()):
            if f.name == "expanded_filelist.f":
                f.unlink()
                continue
            dest = combined / f.name
            if f.suffix == ".f":
                content = f.read_text()
                content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
                dest.write_text(content)
                f.unlink()
            else:
                shutil.move(str(f), str(dest))

        block_dir.rmdir()
        print(f"  [consolidate] merged {block_name}/ -> {_COMBINED_DIR}/")

    # Rewrite env vars in the umbrella filelist
    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    """Move the generated umbrella filelist under filelist/ with stable paths."""
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith("intr_ring_noc_4i2t/"):
            out_lines.append(f"$INTR_NOC_DEMO_DIR/build_logic/{line}")
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


if __name__ == "__main__":
    main()

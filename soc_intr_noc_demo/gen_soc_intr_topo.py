"""Generate the SoC-scale interrupt ring NoC demo topology."""

import os
import re
import shutil
import subprocess
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
LOCAL_SLANG_BIN = LWNOC_TOPO_ROOT / "uhdl" / "slang" / "build" / "bin"

if os.environ.get("USE_LOCAL_SLANG") == "1" and LOCAL_SLANG_BIN.exists():
    os.environ["PATH"] = f"{LOCAL_SLANG_BIN}:{os.environ.get('PATH', '')}"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.node import reset_global_state
from topo_core.utils.serialization import TopologySerializer

from SocIntrTopo import SocIntrLogicTopo, TOPO_ID


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

_COMBINED_DIR = TOPO_ID
_SHARED_ENV = "INTR_RING_NOC_DIR"
_TOP_SIDE_BLOCKS = {
    "intr_iniu_top_side": "INTR_INIU_TOP_OUT_DIR",
    "intr_tniu_top_side": "INTR_TNIU_TOP_OUT_DIR",
    "intr_ring_network": "INTR_RING_NETWORK_OUT_DIR",
    "intr_ring_buf": "INTR_RING_BUF_OUT_DIR",
}


def _check_visualization_dependencies() -> None:
    """Pre-flight check for PNG visualization dependencies.
    
    Raises RuntimeError if dependencies are missing, unless explicitly disabled.
    """
    if os.environ.get("SKIP_TOPO_VIZ") == "1":
        print("  [topo_check] PNG visualization skipped (SKIP_TOPO_VIZ=1)")
        return
    
    try:
        import matplotlib.pyplot
        import networkx
    except ImportError as exc:
        cmd_hint = "pip install matplotlib networkx"
        raise RuntimeError(
            f"Topology visualization requires matplotlib and networkx.\n"
            f"  Missing: {exc}\n"
            f"  Install: {cmd_hint}"
        ) from exc


def main():
    reset_global_state()
    
    # Pre-flight checks
    _check_visualization_dependencies()

    topo = SocIntrLogicTopo()

    topology_json = THIS_DIR / "soc_intr_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _emit_topology_visualization(topo, THIS_DIR / "soc_intr_ring_topology.png")

    _patch_async_fifo_depths(build_dir, iniu_depth=16, tniu_depth=10)
    _patch_lp_struct_links(build_dir / _COMBINED_DIR)
    _normalize_boundary_import_style(build_dir)
    _consolidate_top_side(build_dir)
    _tieoff_unused_input_ports(build_dir / _COMBINED_DIR)
    _flatten_lp_boundary_typedef_ports(build_dir)
    _publish_top_filelist(
        build_dir / _COMBINED_DIR / "filelist.f",
        THIS_DIR / "filelist" / "filelist.f",
    )
    _run_top_io_boundary_check(build_dir / _COMBINED_DIR / f"{_COMBINED_DIR}.v")

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to  {build_dir}")
    print(f"Top filelist written to   {THIS_DIR / 'filelist' / 'filelist.f'}")


def _emit_topology_visualization(topo: SocIntrLogicTopo, output_path: Path) -> None:
    """Generate and save topology visualization PNG.

    Controlled by env var SKIP_TOPO_VIZ:
      - default: enabled
      - set to 1 to disable

    Non-blocking: missing deps or graph-API failures print a warning and return.
    """
    if os.environ.get("SKIP_TOPO_VIZ") == "1":
        print("  [topo_viz] skipped by SKIP_TOPO_VIZ=1")
        return

    try:
        import matplotlib.pyplot as plt
        import networkx as nx
    except Exception as exc:
        print(f"  [topo_viz] WARNING: skip visualization (missing deps): {exc}")
        return

    try:
        graph = topo.datatopo.to_networkx(node_level=True)
        if graph.number_of_nodes() == 0:
            print("  [topo_viz] WARNING: graph is empty, skip image output")
            return

        figure = plt.figure(figsize=(24, 16))
        if nx.is_directed_acyclic_graph(graph):
            pos = nx.spring_layout(graph, k=2.5, iterations=120, seed=42)
        else:
            pos = nx.kamada_kawai_layout(graph)
        nx.draw_networkx_nodes(graph, pos, node_color="#87CEEB", node_size=1500, alpha=0.9)
        nx.draw_networkx_labels(graph, pos, font_size=7, font_weight="bold")
        nx.draw_networkx_edges(graph, pos, arrows=True, arrowsize=10, width=1.0, alpha=0.7)
        plt.title(f"SoC Intr Topology Graph ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges)")
        plt.axis("off")
        plt.tight_layout()
        output_path.parent.mkdir(parents=True, exist_ok=True)
        figure.savefig(output_path, dpi=150, bbox_inches="tight")
        plt.close(figure)
        print(f"  [topo_viz] topology graph written to {output_path}")
    except Exception as exc:
        print(f"  [topo_viz] WARNING: failed to render topology graph: {exc}")


def _run_top_io_boundary_check(top_file: Path) -> None:
    checker = THIS_DIR / "sim" / "check_top_io_boundary.py"
    if not checker.exists() or not top_file.exists():
        return
    cmd = [sys.executable, str(checker), "--top-file", str(top_file)]
    print(f"  [boundary_check] running: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=THIS_DIR)
    if result.returncode != 0:
        raise RuntimeError(f"Top-IO boundary check failed (rc={result.returncode}).")


def _patch_async_fifo_depths(build_dir: Path, iniu_depth: int, tniu_depth: int) -> None:
    def _replace_depth(path: Path, old_depth: int, new_depth: int) -> None:
        if not path.exists():
            return
        text = path.read_text()
        pattern = rf"(ASYNC_FIFO_DEPTH\s*=\s*){old_depth}\b"
        updated, count = re.subn(pattern, rf"\g<1>{new_depth}", text)
        if count > 0:
            path.write_text(updated)
            print(f"  [depth_patch] {path.name}: ASYNC_FIFO_DEPTH {old_depth} -> {new_depth}")

    for sv_path in sorted((build_dir / "intr_iniu_top_side").glob("*_interrupt_iniu_async_top_side.sv")):
        _replace_depth(sv_path, old_depth=10, new_depth=iniu_depth)

    for tniu_sys_dir in sorted(build_dir.glob("*_tniu_sys")):
        for sv_path in sorted(tniu_sys_dir.glob("*_interrupt_tniu_async_sys_side.sv")):
            _replace_depth(sv_path, old_depth=16, new_depth=tniu_depth)


def _patch_lp_struct_links(ring_dir: Path) -> None:
    def _insert_decl_block(text: str, decl_block: str) -> tuple[str, bool]:
        marker = "\t//Wire define for Inout.\n"
        if decl_block.strip() in text or marker not in text:
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
        (".s_async_master_hub_rx_req(),", ".s_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),"),
        (".s_async_master_hub_tx_req(),", ".s_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),"),
        (".m_async_master_hub_rx_req(),", ".m_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),"),
        (".m_async_master_hub_tx_req(),", ".m_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),"),
    ]

    tniu_decl_block = (
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req;\n"
        "\tlwnoc_lp_struct_package::lwnoc_lp_req_signal_t tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req;\n"
        "\n"
    )
    tniu_replacements = [
        (".s_niu_lp_hub_rx_req(),", ".s_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),"),
        (".s_niu_lp_hub_tx_req(),", ".s_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req),"),
        (".s_async_master_hub_rx_req(),", ".s_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),"),
        (".s_async_master_hub_tx_req(),", ".s_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),"),
        (".m_async_master_hub_rx_req(),", ".m_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),"),
        (".m_async_master_hub_tx_req(),", ".m_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),"),
        (".m_niu_lp_hub_rx_req(),", ".m_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),"),
        (".m_niu_lp_hub_tx_req());", ".m_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req));"),
    ]

    for fpath in sorted(ring_dir.glob("*_iniu.v")):
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

    for fpath in sorted(ring_dir.glob("*_tniu.v")):
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


def _tieoff_unused_input_ports(ring_dir: Path) -> None:
    for fpath in sorted(ring_dir.glob("*_iniu.v")):
        if fpath.stem.endswith("_ring"):
            continue
        text = fpath.read_text()
        updated = text.replace(".req_threshold());", ".req_threshold(1'b0));")
        if updated != text:
            fpath.write_text(updated)
            print(f"  [tieoff] {fpath.name}: tied off req_threshold input to 1'b0")


def _normalize_boundary_import_style(build_dir: Path) -> None:
    grouped_import_re = re.compile(r"(^\s*import\s+([^;]+)::[A-Za-z0-9_]+;\n)+", re.MULTILINE)

    def _collapse_group(match: re.Match[str]) -> str:
        raw_lines = [line for line in match.group(0).splitlines() if line.strip()]
        indent = raw_lines[0][: len(raw_lines[0]) - len(raw_lines[0].lstrip())]
        packages = []
        seen = set()
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

    port_specs = []

    def _replace_port(match: re.Match[str]) -> str:
        type_name = match.group("type")
        name = match.group("name")
        alias = f"{name}__typed"
        width_expr = f"$bits({type_name})"
        port_specs.append({"direction": match.group("direction"), "type": type_name, "name": name, "alias": alias})
        return f"{match.group('indent')}{match.group('direction')} logic [{width_expr}-1:0]{match.group('spacing')}{name}{match.group('tail')}"

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
            bridge_lines.append(f"{decl_indent}assign {spec['alias']} = {spec['type']}'({spec['name']});")
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


def _consolidate_top_side(build_dir: Path) -> None:
    combined = build_dir / _COMBINED_DIR
    for block_name, old_env in _TOP_SIDE_BLOCKS.items():
        block_dir = build_dir / block_name
        if not block_dir.exists():
            continue
        for entry in sorted(block_dir.iterdir()):
            if entry.name == "expanded_filelist.f":
                entry.unlink()
                continue
            dest = combined / entry.name
            if entry.suffix == ".f":
                content = entry.read_text().replace(f"${old_env}/", f"${_SHARED_ENV}/")
                dest.write_text(content)
                entry.unlink()
            else:
                shutil.move(str(entry), str(dest))
        block_dir.rmdir()
        print(f"  [consolidate] merged {block_name}/ -> {_COMBINED_DIR}/")

    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    if not src_path.exists():
        return
    dst_path.parent.mkdir(parents=True, exist_ok=True)
    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith(f"{_COMBINED_DIR}/"):
            out_lines.append(f"$INTR_NOC_DEMO_DIR/build_logic/{line}")
        else:
            out_lines.append(line)
    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


if __name__ == "__main__":
    main()
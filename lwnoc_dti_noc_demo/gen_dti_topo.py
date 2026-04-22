"""Generate DTI topology artifacts for DV/PD flows.

Flow outputs:
    dv:
        dti_logic_topology_dv.json
        dti_logic_topology_dv.png
        build_logic/
        filelist/filelist.f
    pd:
        dti_logic_topology_pd.json
        dti_logic_topology_pd.png
        build_logic_pd/
        filelist_pd/filelist.f
"""
import os
import re
import shutil
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

from DtiTreeTopo import DtiLogicTopo
from gen_topo_png import generate_png

# Literal bit-widths for known LP types so generated top-level ports need no package import.
_BARE_TYPE_NAME_RE = re.compile(r"(?:[A-Za-z0-9_]+::)?([A-Za-z0-9_]+)$")
_LP_BITS_EXPR_RE = re.compile(r"\$bits\((?P<type>(?:[A-Za-z0-9_]+::)?[A-Za-z0-9_]+)\)")
LP_TYPE_WIDTHS_DEFAULT: dict[str, int] = {
    "lwnoc_lp_req_signal_t": 9,
    "lwnoc_pchannel_active_t": 2,
    "lwnoc_pchannel_state_t": 2,
}
_LP_HEADER_IMPORT_RE = re.compile(r"\n[ \t]+import[ \t]+lwnoc_lp_[A-Za-z0-9_]+::\*;")


def _parse_sv_logic_width(type_decl_text: str) -> int | None:
    """Extract packed logic width from declaration text like 'logic [2:0]' or 'logic'."""
    packed = re.search(r"logic\s*\[(\d+)\s*:\s*(\d+)\]", type_decl_text)
    if packed:
        msb = int(packed.group(1))
        lsb = int(packed.group(2))
        return abs(msb - lsb) + 1
    if re.search(r"\blogic\b", type_decl_text):
        return 1
    return None


def _parse_typedef_enum_widths(lp_define_text: str) -> dict[str, int]:
    widths: dict[str, int] = {}
    enum_re = re.compile(
        r"typedef\s+enum\s+(?P<decl>logic(?:\s*\[[^\]]+\])?)\s*\{[^}]*\}\s*(?P<name>[A-Za-z0-9_]+)\s*;",
        re.DOTALL,
    )
    for match in enum_re.finditer(lp_define_text):
        width = _parse_sv_logic_width(match.group("decl"))
        if width is None:
            continue
        widths[match.group("name")] = width
    return widths


def _parse_typedef_logic_widths(sv_text: str) -> dict[str, int]:
    widths: dict[str, int] = {}
    logic_re = re.compile(
        r"typedef\s+(?P<decl>logic(?:\s*\[[^\]]+\])?)\s*(?P<name>[A-Za-z0-9_]+)\s*;"
    )
    for match in logic_re.finditer(sv_text):
        width = _parse_sv_logic_width(match.group("decl"))
        if width is None:
            continue
        widths[match.group("name")] = width
    return widths


def _bare_type_name(type_name: str) -> str:
    bare = _BARE_TYPE_NAME_RE.search(type_name)
    return bare.group(1) if bare else type_name


def _parse_lp_req_struct_width(lp_struct_text: str, type_widths: dict[str, int]) -> int | None:
    struct_match = re.search(
        r"typedef\s+struct\s+packed\s*\{(?P<body>[^}]*)\}\s*lwnoc_lp_req_signal_t\s*;",
        lp_struct_text,
        re.DOTALL,
    )
    if not struct_match:
        return None

    width = 0
    for raw_line in struct_match.group("body").splitlines():
        line = raw_line.split("//", 1)[0].strip()
        if not line or not line.endswith(";"):
            continue
        line = line[:-1].strip()
        if not line:
            continue
        parts = line.split()
        if len(parts) < 2:
            continue
        decl = " ".join(parts[:-1])
        leaf_type = _bare_type_name(parts[0])

        logic_width = _parse_sv_logic_width(decl)
        if logic_width is not None:
            width += logic_width
            continue

        mapped = type_widths.get(leaf_type)
        if mapped is not None:
            width += mapped

    return width if width > 0 else None


def _detect_lp_type_widths() -> dict[str, int]:
    widths = dict(LP_TYPE_WIDTHS_DEFAULT)

    env_root = os.environ.get("LWNOC_LOWPOWER_COMPONENT")
    candidate_roots = [
        Path(env_root) if env_root else None,
        REPO_ROOT / "subs" / "lwnoc_dti_noc" / "lwnoc_lowpower_component",
        REPO_ROOT / "subs" / "lwnoc_interrupt_noc" / "lwnoc_lowpower_component",
    ]

    for root in candidate_roots:
        if root is None:
            continue
        rtl_dir = root / "src" / "rtl"
        lp_define = rtl_dir / "lwnoc_lp_define_package.sv"
        lp_struct = rtl_dir / "lwnoc_lp_struct_package.sv"
        if not lp_define.exists() or not lp_struct.exists():
            continue

        define_text = lp_define.read_text()
        struct_text = lp_struct.read_text()

        enum_widths = _parse_typedef_enum_widths(define_text)
        enum_widths.update(_parse_typedef_logic_widths(define_text))
        enum_widths.update(_parse_typedef_enum_widths(struct_text))
        enum_widths.update(_parse_typedef_logic_widths(struct_text))
        for key in ("lwnoc_pchannel_active_t", "lwnoc_pchannel_state_t"):
            if key in enum_widths:
                widths[key] = enum_widths[key]

        req_width = _parse_lp_req_struct_width(struct_text, enum_widths)
        if req_width is not None:
            widths["lwnoc_lp_req_signal_t"] = req_width

        break

    return widths


LP_TYPE_WIDTHS: dict[str, int] = _detect_lp_type_widths()


MACRO_DEFINE_RE = re.compile(r"^`define\s+([A-Za-z0-9_]+)\s+(.+)$")
MACRO_TOKEN_RE = re.compile(r"`(DTI_(?:INIU\d+|TNIU)_(?:MIN|MAX))\b")
PREFIX_TOKEN_RE = re.compile(r"`_PREFIX_\((DTI_(?:INIU\d+|TNIU)_(?:MIN|MAX))\)")
NUMERIC_TOKEN_RE = re.compile(r"32'd([A-Za-z_][A-Za-z0-9_]*)")
LP_PACKAGE_SUFFIXES = (
    "lwnoc_lp_define_package",
    "lwnoc_lp_struct_package",
)
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

_TIEOFF_ASSIGN_PATCHES = {
    "DtiIniuTopExtTieoffComponent.v": (
        "assign req_threshold = (1'b1 ^ 1'b1);",
        "assign rsp_qos = (1'b1 ^ 1'b1);",
        "assign rsp_tgtid = (6'b111111 ^ 6'b111111);",
    ),
    "DtiTniuTopExtTieoffComponent.v": (
        "assign req_qos = (1'b1 ^ 1'b1);",
        "assign req_tgtid = (6'b111111 ^ 6'b111111);",
        "assign rsp_threshold = (1'b1 ^ 1'b1);",
    ),
}


def _load_prefixed_macros(macro_file: Path) -> dict[str, str]:
    mapping: dict[str, str] = {}
    for line in macro_file.read_text().splitlines():
        match = MACRO_DEFINE_RE.match(line.strip())
        if not match:
            continue
        full_name = match.group(1)
        suffix_idx = full_name.find("_DTI_")
        if suffix_idx == -1:
            continue
        mapping[full_name[suffix_idx + 1 :]] = full_name
    return mapping


def _normalize_generated_switch_wrappers(build_dir: Path) -> None:
    for wrapper_path in build_dir.glob("**/*_dti_switch_*i1o_wrap.sv"):
        macro_files = sorted(wrapper_path.parent.glob("*_macros_*.sv"))
        if not macro_files:
            continue

        macro_map = _load_prefixed_macros(macro_files[0])
        if not macro_map:
            continue

        content = wrapper_path.read_text()
        content = PREFIX_TOKEN_RE.sub(lambda m: f"`{macro_map.get(m.group(1), m.group(1))}", content)
        content = MACRO_TOKEN_RE.sub(lambda m: f"`{macro_map.get(m.group(1), m.group(1))}", content)
        content = NUMERIC_TOKEN_RE.sub(
            lambda m: f"32'd`{m.group(1)}" if m.group(1) in macro_map.values() else m.group(0),
            content,
        )
        wrapper_path.write_text(content)


def _normalize_generated_lp_packages(build_dir: Path) -> None:
    processed_dirs: set[Path] = set()

    for package_path in build_dir.glob("**/*_lwnoc_lp_define_package.sv"):
        parent_dir = package_path.parent
        if parent_dir in processed_dirs:
            continue

        prefix = package_path.stem[: -len("_lwnoc_lp_define_package")]
        replacements = {
            package_name: f"{prefix}_{package_name}"
            for package_name in LP_PACKAGE_SUFFIXES
        }

        for sv_path in parent_dir.glob("*.sv"):
            content = sv_path.read_text()
            updated = content
            for old_name, new_name in replacements.items():
                updated = re.sub(rf"\b{old_name}\b", new_name, updated)
            if updated != content:
                sv_path.write_text(updated)

        processed_dirs.add(parent_dir)


def _normalize_boundary_import_style(build_dir: Path) -> None:
    """Force package-level imports in generated boundary modules.

    Boundary modules may legitimately import a package for localparam/typedef
    usage, but should not publish long runs of symbol-by-symbol imports.
    Normalize any generated `import pkg::name;` sequences back to
    `import pkg::*;` so regenerated build_logic stays aligned with the raw
    source boundary style.
    """

    grouped_import_re = re.compile(
        r"(^\s*import\s+([^;]+)::[A-Za-z0-9_]+;\n)+",
        re.MULTILINE,
    )

    def _collapse_group(match: re.Match[str]) -> str:
        lines = [line.strip() for line in match.group(0).splitlines() if line.strip()]
        packages: list[str] = []
        seen: set[str] = set()
        indent = match.group(0).splitlines()[0][: len(match.group(0).splitlines()[0]) - len(match.group(0).splitlines()[0].lstrip())]
        for line in lines:
            pkg_name = line[len("import ") : line.rfind("::")].strip()
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


def _replace_known_lp_bits_exprs(path: Path) -> bool:
    text = path.read_text()

    def _replace(match: re.Match[str]) -> str:
        bare = _BARE_TYPE_NAME_RE.search(match.group("type"))
        bare_name = bare.group(1) if bare else match.group("type")
        known_width = LP_TYPE_WIDTHS.get(bare_name)
        if known_width is None:
            return match.group(0)
        return str(known_width)

    updated = _LP_BITS_EXPR_RE.sub(_replace, text)
    if updated == text:
        return False
    path.write_text(updated)
    return True


def _flatten_lp_boundary_ports_in_file(path: Path) -> bool:
    text = path.read_text()
    header_end = text.find(");")
    if header_end == -1:
        return False

    header = text[: header_end + 2]
    body = text[header_end + 2 :]
    if not LP_TYPE_PORT_RE.search(header):
        return _replace_known_lp_bits_exprs(path)

    port_specs: list[dict[str, str]] = []

    def _replace_port(match: re.Match[str]) -> str:
        type_name = match.group("type")
        name = match.group("name")
        alias = f"{name}__typed"
        bare = _BARE_TYPE_NAME_RE.search(type_name)
        bare_name = bare.group(1) if bare else type_name
        known_width = LP_TYPE_WIDTHS.get(bare_name)
        width_expr = str(known_width) if known_width is not None else f"$bits({type_name})"
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
    # Remove LP package imports from the module header — top-level files must not
    # contain wildcard package imports; ports now use plain integer widths.
    if path.suffix == ".v":
        new_header = _LP_HEADER_IMPORT_RE.sub("", new_header)
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


def _patch_generated_tieoff_components(build_dir: Path) -> None:
    combined_dir = build_dir / _COMBINED_DIR
    for file_name, assigns in _TIEOFF_ASSIGN_PATCHES.items():
        path = combined_dir / file_name
        if not path.exists():
            print(f"  [tieoff_patch] WARNING: {path.relative_to(build_dir)} not found")
            continue

        text = path.read_text()
        if all(assign_stmt in text for assign_stmt in assigns):
            continue

        indent = "\t" if "\n\t//Wire sub module connect to this module and inter module connect." in text else "        "
        marker = f"{indent}//Wire sub module connect to this module and inter module connect.\n"
        if marker not in text:
            print(f"  [tieoff_patch] WARNING: marker not found in {path.relative_to(build_dir)}")
            continue

        assign_block = marker + "\n".join([f"{indent}{assign_stmt}" for assign_stmt in assigns]) + "\n\n"
        path.write_text(text.replace(marker, assign_block, 1))
        print(f"  [tieoff_patch] patched {path.relative_to(build_dir)}")


# ---------------------------------------------------------------------------
# Post-gen: consolidate per-switch dirs into ONE combined top-side dir.
# SKILL §1b Principle 1: all top-side content in a single directory.
# ---------------------------------------------------------------------------
_COMBINED_DIR = "dti_logic_topo"
_SHARED_ENV = "DTI_LOGIC_TOPO_DIR"

# block-dir-name → old env_var used in generated filelists
_TOP_SIDE_BLOCKS = {
    "dti_sw_left3":      "DTI_SW_LEFT3_OUT_DIR",
    "dti_sw_left_dsp0":  "DTI_SW_LEFT_DSP0_OUT_DIR",
    "dti_sw_left_dsp1":  "DTI_SW_LEFT_DSP1_OUT_DIR",
    "dti_sw_left_noc1":  "DTI_SW_LEFT_NOC1_OUT_DIR",
    "dti_sw_right4":     "DTI_SW_RIGHT4_OUT_DIR",
    "dti_sw_right_noc0": "DTI_SW_RIGHT_NOC0_OUT_DIR",
    "dti_sw_root":       "DTI_SW_ROOT_OUT_DIR",
    "dti_iniu_top_side": "DTI_INIU_TOP_DIR",
    "dti_tniu_top_side": "DTI_TNIU_TOP_DIR",
}

def _consolidate_top_side(build_dir: Path) -> None:
    """Merge per-switch block dirs into the combined topo wrapper dir."""
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

    # Rewrite env vars in the umbrella filelist (still inside build_logic/<topo>/)
    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _publish_top_filelist(src_path: Path, dst_path: Path, published_build_root: str) -> None:
    """Move the generated umbrella filelist under filelists/ with stable paths."""
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith("dti_logic_topo/"):
            out_lines.append(f"$DTI_TEST_DIR/{published_build_root}/{line}")
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


def _flow_paths(flow: str) -> dict[str, Path | str]:
    normalized = flow.strip().lower()
    if normalized not in {"dv", "pd"}:
        raise ValueError(f"Unsupported flow: {flow}. expected one of: dv, pd")

    if normalized == "dv":
        return {
            "build_dir": THIS_DIR / "build_logic",
            "filelist_out": THIS_DIR / "filelist" / "filelist.f",
            "build_root_name": "build_logic",
        }

    return {
        "build_dir": THIS_DIR / "build_logic_pd",
        "filelist_out": THIS_DIR / "filelist_pd" / "filelist.f",
        "build_root_name": "build_logic_pd",
    }


def generate(flow: str = "dv") -> None:
    reset_global_state()

    flow_paths = _flow_paths(flow)
    build_dir = flow_paths["build_dir"]
    filelist_out = flow_paths["filelist_out"]
    build_root_name = flow_paths["build_root_name"]
    assert isinstance(build_dir, Path)
    assert isinstance(filelist_out, Path)
    assert isinstance(build_root_name, str)

    topo = DtiLogicTopo()
    topology_json = THIS_DIR / f"dti_logic_topology_{flow}.json"
    topology_png = THIS_DIR / f"dti_logic_topology_{flow}.png"

    # Keep legacy default artifact for downstream compatibility.
    if flow == "dv":
        legacy_json = THIS_DIR / "dti_logic_topology.json"
    else:
        legacy_json = None

    TopologySerializer().save_to_file(topo, str(topology_json))
    if legacy_json is not None:
        shutil.copyfile(topology_json, legacy_json)

    generate_png(topology_json, topology_png, title=f"DTI Logic Topology ({flow.upper()})")

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _normalize_generated_switch_wrappers(build_dir)
    _normalize_generated_lp_packages(build_dir)
    _normalize_boundary_import_style(build_dir)
    _consolidate_top_side(build_dir)
    _flatten_lp_boundary_typedef_ports(build_dir)
    _patch_generated_tieoff_components(build_dir)
    _publish_top_filelist(
        build_dir / "dti_logic_topo" / "filelist.f",
        filelist_out,
        build_root_name,
    )

    # Keep legacy top-level filelist path for older tooling.
    legacy_filelist = THIS_DIR / "filelists" / "filelist.f"
    legacy_filelist.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(filelist_out, legacy_filelist)

    print(f"Flow: {flow}")
    print(f"Topology JSON written to {topology_json}")
    print(f"Topology PNG written to {topology_png}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {filelist_out}")
    if legacy_json is not None:
        print(f"Legacy JSON mirror written to {legacy_json}")
    print(f"Legacy filelist mirror written to {legacy_filelist}")


def main() -> None:
    generate("dv")


if __name__ == "__main__":
    main()
"""Generate the SoC-scale DTI merge-tree demo topology."""

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

from SocDtiTreeTopo import SocDtiLogicTopo


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

_COMBINED_DIR = "soc_dti_logic_topo"
_SHARED_ENV = "SOC_DTI_LOGIC_TOPO_DIR"
_TOP_SIDE_BLOCKS = {
    "soc_dti_sw_dsp6": "SOC_DTI_SW_DSP6_OUT_DIR",
    "soc_dti_sw_io5": "SOC_DTI_SW_IO5_OUT_DIR",
    "soc_dti_sw_gpu4": "SOC_DTI_SW_GPU4_OUT_DIR",
    "soc_dti_sw_right": "SOC_DTI_SW_RIGHT_OUT_DIR",
    "soc_dti_sw_root": "SOC_DTI_SW_ROOT_OUT_DIR",
    "dti_iniu_top_side": "DTI_INIU_TOP_DIR",
    "dti_tniu_top_side": "DTI_TNIU_TOP_DIR",
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
    candidate_paths = {
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


def _promote_temp_blocks(build_dir: Path) -> None:
    temp_root = THIS_DIR / "build" / "temp"
    if not temp_root.exists():
        return

    for block_name in _TOP_SIDE_BLOCKS:
        src_dir = temp_root / block_name
        if not src_dir.exists():
            continue

        dst_dir = build_dir / block_name
        if dst_dir.exists() and any(dst_dir.iterdir()):
            continue

        dst_dir.mkdir(parents=True, exist_ok=True)
        for src_path in sorted(src_dir.iterdir()):
            shutil.copy2(src_path, dst_dir / src_path.name)
        print(f"  [temp_promote] staged {block_name}/ from build/temp")


def _consolidate_top_side(build_dir: Path) -> None:
    combined = build_dir / _COMBINED_DIR
    combined.mkdir(parents=True, exist_ok=True)

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

    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith(f"{_COMBINED_DIR}/"):
            out_lines.append(line.replace(f"{_COMBINED_DIR}/", f"${_SHARED_ENV}/", 1))
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


def main() -> None:
    reset_global_state()

    topo = SocDtiLogicTopo()
    topology_json = THIS_DIR / "soc_dti_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _normalize_generated_switch_wrappers(build_dir)
    _normalize_generated_lp_packages(build_dir)
    _normalize_boundary_import_style(build_dir)
    _promote_temp_blocks(build_dir)
    _consolidate_top_side(build_dir)
    _flatten_lp_boundary_typedef_ports(build_dir)
    _patch_generated_tieoff_components(build_dir)
    _publish_top_filelist(
        build_dir / _COMBINED_DIR / "filelist.f",
        THIS_DIR / "filelists" / "soc_dti_logic_topo.f",
    )

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {THIS_DIR / 'filelists' / 'soc_dti_logic_topo.f'}")


if __name__ == "__main__":
    main()

"""Generate the SoC-scale DTI merge-tree demo topology."""

import os
import re
import shutil
import sys
from pathlib import Path
from typing import TypedDict


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

from SocDtiTreeTopo import (
    DN_HARDEN_ID,
    DN_HARDEN_MEMBER_IDS,
    TOPO_ID,
    UP_HARDEN_ID,
    UP_HARDEN_MEMBER_IDS,
    SocDtiDnHardenWrap,
    SocDtiLogicTopo,
    SocDtiUpHardenWrap,
)


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
# Literal bit-widths for known LP types so generated top-level ports need no package import.
_BARE_TYPE_NAME_RE = re.compile(r"(?:[A-Za-z0-9_]+::)?([A-Za-z0-9_]+)$")
_LP_BITS_EXPR_RE = re.compile(r"\$bits\((?P<type>(?:[A-Za-z0-9_]+::)?[A-Za-z0-9_]+)\)")
LP_TYPE_WIDTHS_DEFAULT: dict[str, int] = {
    "lwnoc_lp_req_signal_t": 9,
    "lwnoc_pchannel_active_t": 2,
    "lwnoc_pchannel_state_t": 2,
}
_LP_HEADER_IMPORT_RE = re.compile(r"\n[ \t]+import[ \t]+lwnoc_lp_[A-Za-z0-9_]+::\*;")


class _FlattenedPortSpec(TypedDict):
    direction: str
    type: str
    name: str
    alias: str
    use_alias: bool


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
        REPO_ROOT / "subs" / "lwnoc_dti_noc" / "lwnoc_lowpower_component",
        REPO_ROOT / "subs" / "lwnoc_interrupt_noc" / "lwnoc_lowpower_component",
        Path(env_root) if env_root else None,
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

_COMBINED_DIR = TOPO_ID
_SHARED_ENV = "SOC_DTI_LOGIC_TOPO_DIR"
_LOCAL_BUILD_ROOT = "$DTI_TEST_DIR/build_logic"
_TOP_WRAP_DIR = "soc_dti_top_wrap"
_NETWORK_COMPONENT_DIR = "soc_dti_network_component"
_HARDEN_PREFIX = "soc_dti_harden_"
_HARDEN_WRAPPER_BUILD_ROOT = THIS_DIR / "build" / "temp" / "__harden_wrapper_gen"
_HARDEN_SPECS: dict[str, list[str]] = {
    UP_HARDEN_ID: UP_HARDEN_MEMBER_IDS,
    DN_HARDEN_ID: DN_HARDEN_MEMBER_IDS,
}
_HARDEN_WRAPPER_FACTORIES = {
    UP_HARDEN_ID: SocDtiUpHardenWrap,
    DN_HARDEN_ID: SocDtiDnHardenWrap,
}
_ROLE_PUBLISH_SPECS = {
    "DTI_INIU_TOP_DIR": {
        "dir_name": "dti_iniu_top_side",
        "filelist": "dti_iniu_top_filelist.f",
        "prefixes": ("dti_iniu_top_",),
    },
    "DTI_TNIU_TOP_DIR": {
        "dir_name": "dti_tniu_top_side",
        "filelist": "dti_tniu_top_filelist.f",
        "prefixes": ("dti_tniu_top_",),
    },
}
_TOP_SIDE_BLOCKS = {
    "soc_dti_sw_dsp6": "SOC_DTI_SW_DSP6_OUT_DIR",
    "soc_dti_sw_io5": "SOC_DTI_SW_IO5_OUT_DIR",
    "soc_dti_sw_gpu4": "SOC_DTI_SW_GPU4_OUT_DIR",
    "soc_dti_sw_right": "SOC_DTI_SW_RIGHT_OUT_DIR",
    "soc_dti_sw_root": "SOC_DTI_SW_ROOT_OUT_DIR",
    "dti_iniu_top_side": "DTI_INIU_TOP_DIR",
    "dti_tniu_top_side": "DTI_TNIU_TOP_DIR",
}


def _is_switch_payload(name: str) -> bool:
    return name.startswith("soc_dti_sw_")


def _is_top_side_payload(name: str) -> bool:
    if name in {"dti_iniu_top_filelist.f", "dti_tniu_top_filelist.f"}:
        return True
    return name.startswith("dti_iniu_top_") or name.startswith("dti_tniu_top_")


def _write_filelist(dst_path: Path, lines: list[str]) -> None:
    dst_path.parent.mkdir(parents=True, exist_ok=True)
    dst_path.write_text("\n".join(lines) + "\n")


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
    candidate_paths = set(build_dir.glob("**/*.v"))

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

    def _replace_port(match: re.Match[str]) -> str:
        type_name = match.group("type")
        bare = _BARE_TYPE_NAME_RE.search(type_name)
        bare_name = bare.group(1) if bare else type_name
        known_width = LP_TYPE_WIDTHS.get(bare_name)
        width_expr = str(known_width) if known_width is not None else f"$bits({type_name})"
        return (
            f"{match.group('indent')}{match.group('direction')} logic "
            f"[{width_expr}-1:0]{match.group('spacing')}{match.group('name')}{match.group('tail')}"
        )

    new_header = LP_TYPE_PORT_RE.sub(_replace_port, header)
    # Remove LP package imports from the module header — top-level files must not
    # contain wildcard package imports; ports now use plain integer widths.
    if path.suffix == ".v":
        new_header = _LP_HEADER_IMPORT_RE.sub("", new_header)
    updated = new_header + body
    if updated == text:
        return False
    path.write_text(updated)
    return True


def _patch_generated_tieoff_components(build_dir: Path) -> None:
    combined_dir = build_dir / _COMBINED_DIR
    for file_name, assigns in _TIEOFF_ASSIGN_PATCHES.items():
        path = combined_dir / file_name
        if not path.exists():
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


def _copy_local_file(source_dir: Path, target_dir: Path, filename: str, copied_files: set[str]) -> None:
    if filename in copied_files:
        return

    shutil.copyfile(source_dir / filename, target_dir / filename)
    copied_files.add(filename)


def _copy_local_filelist(
    source_dir: Path,
    target_dir: Path,
    filename: str,
    target_root: str,
    copied_files: set[str],
    copied_filelists: set[str],
) -> None:
    if filename in copied_filelists:
        return

    local_file_prefix = f"${_SHARED_ENV}/"
    local_filelist_prefix = f"-f ${_SHARED_ENV}/"
    out_lines: list[str] = []

    for raw_line in (source_dir / filename).read_text().splitlines():
        line = raw_line.strip()
        if not line:
            continue

        if line.startswith(local_filelist_prefix):
            nested_name = line[len(local_filelist_prefix) :]
            _copy_local_filelist(
                source_dir,
                target_dir,
                nested_name,
                target_root,
                copied_files,
                copied_filelists,
            )
            out_lines.append(f"-f {target_root}/{nested_name}")
            continue

        if line.startswith(local_file_prefix):
            local_name = line[len(local_file_prefix) :]
            _copy_local_file(source_dir, target_dir, local_name, copied_files)
            out_lines.append(f"{target_root}/{local_name}")
            continue

        out_lines.append(line)

    _write_filelist(target_dir / filename, out_lines)
    copied_filelists.add(filename)


def _rewrite_role_filelist_env(line: str) -> str:
    role_rewrites = {
        f"-f ${_SHARED_ENV}/dti_iniu_top_filelist.f": "-f $DTI_INIU_TOP_DIR/dti_iniu_top_filelist.f",
        f"-f ${_SHARED_ENV}/dti_tniu_top_filelist.f": "-f $DTI_TNIU_TOP_DIR/dti_tniu_top_filelist.f",
    }
    return role_rewrites.get(line, line)


def _publish_role_payload_dirs(build_dir: Path) -> None:
    source_dir = build_dir / _COMBINED_DIR
    for env_name, spec in _ROLE_PUBLISH_SPECS.items():
        target_dir = build_dir / spec["dir_name"]
        if target_dir.exists():
            shutil.rmtree(target_dir)
        target_dir.mkdir(parents=True, exist_ok=True)

        selected_names = {spec["filelist"]}
        for file_path in sorted(source_dir.iterdir()):
            if not file_path.is_file():
                continue
            if any(file_path.name.startswith(prefix) for prefix in spec["prefixes"]):
                selected_names.add(file_path.name)

        for name in sorted(selected_names):
            src_path = source_dir / name
            if not src_path.exists():
                continue
            dst_path = target_dir / name
            shutil.copyfile(src_path, dst_path)
            if dst_path.suffix == ".f":
                content = dst_path.read_text().replace(f"${_SHARED_ENV}/", f"${env_name}/")
                dst_path.write_text(content)

        print(f"  [role_publish] published {spec['dir_name']}/")


def _publish_network_component_dir(build_dir: Path) -> None:
    source_dir = build_dir / _COMBINED_DIR
    target_dir = build_dir / _NETWORK_COMPONENT_DIR
    target_root = f"{_LOCAL_BUILD_ROOT}/{_NETWORK_COMPONENT_DIR}"

    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    switch_filelists: list[str] = []
    for src_path in sorted(source_dir.iterdir()):
        if not src_path.is_file() or not _is_switch_payload(src_path.name):
            continue

        dst_path = target_dir / src_path.name
        shutil.copyfile(src_path, dst_path)
        if dst_path.suffix == ".f":
            content = dst_path.read_text().replace(f"${_SHARED_ENV}/", f"{target_root}/")
            dst_path.write_text(content)
            switch_filelists.append(dst_path.name)

    out_lines = [f"-f {target_root}/{name}" for name in sorted(switch_filelists)]
    _write_filelist(target_dir / "filelist.f", out_lines)
    print(f"  [role_publish] published {_NETWORK_COMPONENT_DIR}/")


def _publish_top_wrap_dir(build_dir: Path) -> None:
    source_dir = build_dir / _COMBINED_DIR
    target_dir = build_dir / _TOP_WRAP_DIR
    network_filelist = f"-f {_LOCAL_BUILD_ROOT}/{_NETWORK_COMPONENT_DIR}/filelist.f"

    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    for src_path in sorted(source_dir.iterdir()):
        if not src_path.is_file():
            continue
        if _is_switch_payload(src_path.name) or _is_top_side_payload(src_path.name):
            continue
        shutil.copyfile(src_path, target_dir / src_path.name)

    # OPD FIX: Reorder filelist to avoid duplicate declarations
    # Pattern: common packages first, then specific modules
    out_lines: list[str] = [network_filelist]
    package_lines: list[str] = []  # LP packages from top-side
    iniu_pack_lines: dict[str, str] = {}  # Deduplicate iniu_pack per subsystem
    module_lines: list[str] = []  # Regular module files
    seen_lines: set[str] = {network_filelist}

    for raw_line in (source_dir / "filelist.f").read_text().splitlines():
        line = raw_line.strip()
        if not line:
            continue

        line = _rewrite_role_filelist_env(line)
        if line.startswith(f"-f ${_SHARED_ENV}/"):
            nested_name = line[len(f"-f ${_SHARED_ENV}/") :]
            if _is_switch_payload(nested_name) or _is_top_side_payload(nested_name):
                continue
        elif line.startswith(f"${_SHARED_ENV}/"):
            local_name = line[len(f"${_SHARED_ENV}/") :]
            if _is_switch_payload(local_name) or _is_top_side_payload(local_name):
                continue

        if line in seen_lines:
            continue
        seen_lines.add(line)

        # Categorize lines for better ordering
        if "_iniu_pack.sv" in line or "_tniu_pack.sv" in line or "_define.sv" in line:
            # Subsystem-specific packages: deduplicate by base name
            base_match = re.search(r"(\w+_(?:iniu|tniu)_pack)", line)
            if base_match:
                pack_key = base_match.group(1)
                if pack_key not in iniu_pack_lines:
                    iniu_pack_lines[pack_key] = line
            else:
                package_lines.append(line)
        elif line.startswith("-f "):
            # Filelists (top-side, system-specific)
            if "iniu_top" in line or "tniu_top" in line:
                package_lines.append(line)
            else:
                module_lines.append(line)
        else:
            # Module files
            module_lines.append(line)

    # Assemble in order: network -> common packages -> system packages -> modules
    out_lines.extend(package_lines)
    out_lines.extend(iniu_pack_lines.values())
    out_lines.extend(module_lines)

    _write_filelist(target_dir / "filelist.f", out_lines)
    print(f"  [role_publish] published {_TOP_WRAP_DIR}/")


def _cleanup_internal_combined_dir(build_dir: Path) -> None:
    scratch_dir = build_dir / _COMBINED_DIR
    if not scratch_dir.exists():
        return

    shutil.rmtree(scratch_dir)
    print(f"  [cleanup] removed scratch {_COMBINED_DIR}/")


def _sys_filelist_entry(node_id: str) -> str:
    if node_id == "sys_tcu_tniu_node":
        return "-f $SYS_TCU_TNIU_SYS_DIR/sys_tcu_filelist.f"

    if node_id.endswith("_iniu_node"):
        base_name = node_id[: -len("_iniu_node")]
        env_name = f"SOC_DTI_{base_name.upper()}_INIU_SYS_DIR"
        return f"-f ${env_name}/{base_name}_filelist.f"

    raise ValueError(f"Unsupported harden node system filelist mapping: {node_id}")


def _publish_harden_partition_dir(
    source_dir: Path,
    wrapper_source_dir: Path,
    target_dir: Path,
    partition_id: str,
    member_ids: list[str],
) -> None:
    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    target_root = f"{_LOCAL_BUILD_ROOT}/{partition_id}"
    copied_files: set[str] = set()
    copied_filelists: set[str] = set()
    out_lines: list[str] = []
    seen_entries: set[str] = set()  # OPD FIX: Track seen entries to avoid duplicates

    if any(member_id.endswith("_iniu_top_wrap") for member_id in member_ids):
        filelist_name = "dti_iniu_top_filelist.f"
        _copy_local_filelist(
            source_dir,
            target_dir,
            filelist_name,
            target_root,
            copied_files,
            copied_filelists,
        )
        entry = f"-f {target_root}/{filelist_name}"
        if entry not in seen_entries:
            out_lines.append(entry)
            seen_entries.add(entry)

    if any(member_id.endswith("_tniu_top_wrap") for member_id in member_ids):
        filelist_name = "dti_tniu_top_filelist.f"
        _copy_local_filelist(
            source_dir,
            target_dir,
            filelist_name,
            target_root,
            copied_files,
            copied_filelists,
        )
        entry = f"-f {target_root}/{filelist_name}"
        if entry not in seen_entries:
            out_lines.append(entry)
            seen_entries.add(entry)

    for member_id in member_ids:
        if member_id.endswith("_top_wrap"):
            _copy_local_file(wrapper_source_dir, target_dir, f"{member_id}.v", copied_files)
            entry = f"{target_root}/{member_id}.v"
            if entry not in seen_entries:
                out_lines.append(entry)
                seen_entries.add(entry)
            continue

        if member_id.endswith("_node"):
            sys_entry = _sys_filelist_entry(member_id)
            if sys_entry not in seen_entries:
                out_lines.append(sys_entry)
                seen_entries.add(sys_entry)
            
            _copy_local_file(source_dir, target_dir, f"{member_id}.v", copied_files)
            entry = f"{target_root}/{member_id}.v"
            if entry not in seen_entries:
                out_lines.append(entry)
                seen_entries.add(entry)
            continue

        if member_id.startswith("soc_dti_sw_"):
            continue

        local_filelist = f"{member_id}_filelist.f"
        _copy_local_filelist(
            source_dir,
            target_dir,
            local_filelist,
            target_root,
            copied_files,
            copied_filelists,
        )
        entry = f"-f {target_root}/{local_filelist}"
        if entry not in seen_entries:
            out_lines.append(entry)
            seen_entries.add(entry)

    _copy_local_file(wrapper_source_dir, target_dir, f"{partition_id}.v", copied_files)
    entry = f"{target_root}/{partition_id}.v"
    if entry not in seen_entries:
        out_lines.append(entry)
        seen_entries.add(entry)

    _write_filelist(target_dir / "filelist.f", out_lines)
    print(f"  [harden_publish] published {partition_id}/filelist.f")


def _rewrite_harden_top_filelist(source_dir: Path, partition_ids: list[str]) -> None:
    local_prefix = f"{TOPO_ID}/"
    switch_filelists = {
        f"-f ${_SHARED_ENV}/{switch_id}_filelist.f"
        for switch_id in _TOP_SIDE_BLOCKS
        if switch_id.startswith("soc_dti_sw_")
    }

    def _normalize_line(line: str) -> str:
        if line.startswith("-f "):
            nested = line[3:]
            if nested.startswith(local_prefix):
                return f"-f ${_SHARED_ENV}/{nested[len(local_prefix):]}"
            return line

        if line.startswith(local_prefix):
            return f"${_SHARED_ENV}/{line[len(local_prefix):]}"

        return line

    original_lines = [
        _normalize_line(line.strip())
        for line in (source_dir / "filelist.f").read_text().splitlines()
        if line.strip() and _normalize_line(line.strip()) not in switch_filelists
    ]
    partition_lines = [f"-f {_LOCAL_BUILD_ROOT}/{partition_id}/filelist.f" for partition_id in partition_ids]
    top_line = f"${_SHARED_ENV}/{TOPO_ID}.v"

    if top_line in original_lines:
        top_idx = original_lines.index(top_line)
        out_lines = original_lines[:top_idx] + partition_lines + original_lines[top_idx:]
    else:
        out_lines = original_lines + partition_lines

    _write_filelist(source_dir / "filelist.f", out_lines)
    print("  [harden_publish] rewrote top assembly filelist")


def _generate_harden_wrapper_modules(build_dir: Path) -> None:
    combined_dir = build_dir / _COMBINED_DIR
    if _HARDEN_WRAPPER_BUILD_ROOT.exists():
        shutil.rmtree(_HARDEN_WRAPPER_BUILD_ROOT)
    _HARDEN_WRAPPER_BUILD_ROOT.mkdir(parents=True, exist_ok=True)

    for partition_id, wrapper_factory in _HARDEN_WRAPPER_FACTORIES.items():
        reset_global_state()
        wrapper_node = wrapper_factory()
        wrapper_build_dir = _HARDEN_WRAPPER_BUILD_ROOT / partition_id
        comp = wrapper_node.build_uhdl()
        comp.output_dir = str(wrapper_build_dir)
        comp.generate_verilog(iteration=True)

        wrapper_path = wrapper_build_dir / partition_id / f"{partition_id}.v"
        if not wrapper_path.exists():
            raise FileNotFoundError(f"Generated harden wrapper not found: {wrapper_path}")

        # Flatten LP typedef ports (and strip module-header imports) in ALL .v
        # files in the wrapper output dir — not just the top wrapper itself.
        for v_path in sorted((wrapper_build_dir / partition_id).glob("*.v")):
            _flatten_lp_boundary_ports_in_file(v_path)
        shutil.copyfile(wrapper_path, combined_dir / f"{partition_id}.v")
        print(f"  [harden_publish] generated {partition_id}.v")


def _publish_partitioned_harden_outputs(build_dir: Path) -> None:
    source_dir = build_dir / _COMBINED_DIR
    _generate_harden_wrapper_modules(build_dir)

    harden_specs = _HARDEN_SPECS
    if not harden_specs:
        print("  [harden_publish] WARNING: no harden wrappers found in topology metadata")
        return

    for partition_id, member_ids in harden_specs.items():
        _publish_harden_partition_dir(
            source_dir,
            _HARDEN_WRAPPER_BUILD_ROOT / partition_id / partition_id,
            build_dir / partition_id,
            partition_id,
            member_ids,
        )

    _rewrite_harden_top_filelist(source_dir, list(harden_specs.keys()))


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    out_lines = [
        _rewrite_role_filelist_env(line.strip())
        for line in src_path.read_text().splitlines()
        if line.strip()
    ]
    _write_filelist(dst_path, out_lines)
    print(f"  [filelist] published top filelist to {dst_path}")


def _publish_compile_entry(dst_path: Path) -> None:
    _write_filelist(dst_path, [f"-f $DTI_TEST_DIR/filelists/{TOPO_ID}.f"])
    print(f"  [filelist] published compile entry to {dst_path}")


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
    # Align with soc_intr_noc_wrap: flatten LP typedef ports to vectors
    # without creating per-port __typed cast bridges.
    _flatten_lp_boundary_typedef_ports(build_dir)
    _patch_generated_tieoff_components(build_dir)
    _publish_partitioned_harden_outputs(build_dir)
    _publish_role_payload_dirs(build_dir)
    _publish_network_component_dir(build_dir)
    _publish_top_wrap_dir(build_dir)
    _cleanup_internal_combined_dir(build_dir)
    _publish_top_filelist(
        build_dir / _TOP_WRAP_DIR / "filelist.f",
        THIS_DIR / "filelists" / f"{TOPO_ID}.f",
    )
    _publish_compile_entry(THIS_DIR / "filelists" / "filelist.f")

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {THIS_DIR / 'filelists' / f'{TOPO_ID}.f'}")


if __name__ == "__main__":
    main()

"""Generate the STS SoC-scale demo topology.

Supports a shared flow entry (`generate(flow)`) plus thin DV/PD wrappers,
matching the soc_intr demo script split. Current PD flow reuses DV topology
generation and publishes to a dedicated filelist path as an integration hook.
"""
import argparse
from dataclasses import dataclass
import math
import os
import re
import shutil
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_ROOT = THIS_DIR.parent
REPO_ROOT = DEMO_ROOT.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
LOCAL_SLANG_BIN = LWNOC_TOPO_ROOT / "uhdl" / "slang" / "build" / "bin"

if os.environ.get("USE_LOCAL_SLANG") == "1" and LOCAL_SLANG_BIN.exists():
    os.environ["PATH"] = f"{LOCAL_SLANG_BIN}:{os.environ.get('PATH', '')}"

if str(DEMO_ROOT) not in sys.path:
    sys.path.insert(0, str(DEMO_ROOT))

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.node import reset_global_state
from topo_core.utils.serialization import TopologySerializer

from StsSocTopo import BLUE_CHAIN_LEAF_OWNERSHIP, SOC_STS_NOC_TOP_ID, StsSocLogicTopo


from StsTemplate import (
    aon_ss_iniu_sys_config,
    vpu_ss_tniu_sys_config,
    camera_ss_tniu_sys_config,
    dspss_tniu_sys_config,
)


BOUNDARY_IMPORT_TARGETS = (
    "*_sys.sv",
    "*_top.sv",
    "*_top_wrap.sv",
)


# ---------------------------------------------------------------------------
# Post-gen: consolidate per-block top-side dirs into ONE combined dir.
# SKILL §1b Principle 1: all top-side content in a single directory.
# ---------------------------------------------------------------------------
_COMBINED_DIR = SOC_STS_NOC_TOP_ID
_SHARED_ENV = "SOC_STS_NOC_DIR"
_SOC_TOP_WRAPPER_FILE = f"{SOC_STS_NOC_TOP_ID}.v"
_SOC_TOPOLOGY_STEM = "soc_sts_noc_topology"
_LEGACY_COMBINED_DIR = "sts_soc_logic_topo"
_LEGACY_SHARED_ENV = "STS_SOC_LOGIC_TOPO_DIR"
_LEGACY_TOP_WRAPPER_FILE = "sts_soc_logic_topo.v"
_LEGACY_TOPOLOGY_JSON_STEMS = ("sts_soc_logic_topology",)

_TOP_SIDE_BLOCKS = {
    "sts_demo_iniu_top_side": "STS_DEMO_INIU_TOP_SIDE_OUT_DIR",
    "sts_demo_tniu0_top_side": "STS_DEMO_TNIU0_OUT_DIR",
    "sts_demo_tniu1_top_side": "STS_DEMO_TNIU1_OUT_DIR",
    "sts_demo_tniu2_top_side": "STS_DEMO_TNIU2_OUT_DIR",
    "sts_demo_tniu3_top_side": "STS_DEMO_TNIU3_OUT_DIR",
    "sts_demo_dec4":           "STS_DEMO_DEC4_OUT_DIR",
}

_COMBINED_CONTENT_REWRITES = (
    ("sts_demo_tniu3", "soc_sts_tniu3"),
    ("sts_demo_tniu2", "soc_sts_tniu2"),
    ("sts_demo_tniu1", "soc_sts_tniu1"),
    ("sts_demo_tniu0", "soc_sts_tniu0"),
    ("sts_demo_iniu", "soc_sts_iniu"),
    ("sts_demo_dec4", "soc_sts_dec4"),
    ("STS_DEMO", "SOC_STS"),
    ("fcip_", "soc_sts_util_"),
    ("FCIP_", "SOC_STS_UTIL_"),
)


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
        content = content.replace(f"${_LEGACY_SHARED_ENV}/", f"${_SHARED_ENV}/")
        content = content.replace(f"${_LEGACY_SHARED_ENV}", f"${_SHARED_ENV}")
        content = content.replace(f"{_LEGACY_COMBINED_DIR}/", f"{_COMBINED_DIR}/")
        content = content.replace(_LEGACY_TOP_WRAPPER_FILE, _SOC_TOP_WRAPPER_FILE)
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _rewrite_top_filelist_line(line: str) -> str:
    line = line.replace(f"${_LEGACY_SHARED_ENV}/", f"${_SHARED_ENV}/")
    line = line.replace(f"${_LEGACY_SHARED_ENV}", f"${_SHARED_ENV}")
    line = line.replace(f"{_LEGACY_COMBINED_DIR}/", f"{_COMBINED_DIR}/")
    line = line.replace(
        f"build_logic/{_LEGACY_COMBINED_DIR}/{_LEGACY_TOP_WRAPPER_FILE}",
        f"build_logic/{_COMBINED_DIR}/{_SOC_TOP_WRAPPER_FILE}",
    )
    line = line.replace(_LEGACY_TOP_WRAPPER_FILE, _SOC_TOP_WRAPPER_FILE)
    return line


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    """Move the generated umbrella filelist under filelists/ with stable paths."""
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        line = _rewrite_top_filelist_line(line)
        if line.startswith(f"{_COMBINED_DIR}/"):
            out_lines.append(f"$STS_NOC_DEMO_DIR/build_logic/{line}")
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


def _rewrite_combined_payload_text(content: str) -> str:
    updated = content
    for old, new in _COMBINED_CONTENT_REWRITES:
        updated = updated.replace(old, new)
    return updated


def _rewrite_combined_payload_name(file_name: str) -> str:
    updated = file_name
    for old, new in _COMBINED_CONTENT_REWRITES:
        updated = updated.replace(old, new)
    return updated


def _normalize_combined_publish(build_dir: Path) -> None:
    """Rewrite the combined SoC publish root to semantic, non-legacy names."""
    combined = build_dir / _COMBINED_DIR
    if not combined.exists():
        return

    staged_files: list[tuple[str, str]] = []
    for entry in sorted(combined.iterdir()):
        if entry.is_dir():
            continue
        new_name = _rewrite_combined_payload_name(entry.name)
        new_content = _rewrite_combined_payload_text(entry.read_text(errors="replace"))
        staged_files.append((new_name, new_content))

    for entry in list(combined.iterdir()):
        if entry.is_dir():
            shutil.rmtree(entry)
        else:
            entry.unlink()

    for new_name, new_content in staged_files:
        (combined / new_name).write_text(new_content)

    print(f"  [publish] normalized {_COMBINED_DIR}/ away from legacy sts_demo/fcip names")


def _prune_unused_combined_top_ports(build_dir: Path) -> None:
    """Remove dead top-level ports from the published combined wrapper."""
    wrapper_path = build_dir / _COMBINED_DIR / _SOC_TOP_WRAPPER_FILE
    if not wrapper_path.exists():
        return

    lines = wrapper_path.read_text().splitlines()
    try:
        module_start = next(idx for idx, line in enumerate(lines) if line.startswith("module "))
        header_end = next(idx for idx, line in enumerate(lines[module_start:], start=module_start) if line.strip() == ");")
    except StopIteration:
        return

    removed_ports: list[str] = []
    for port_name in ("clk_noc", "rst_noc_n"):
        if len(re.findall(rf"\b{re.escape(port_name)}\b", "\n".join(lines))) != 1:
            continue
        for idx in range(module_start + 1, header_end):
            if re.search(rf"\b{re.escape(port_name)}\b", lines[idx]):
                lines.pop(idx)
                header_end -= 1
                removed_ports.append(port_name)
                break

    if not removed_ports:
        return

    for idx in range(header_end - 1, module_start, -1):
        if lines[idx].strip() and not lines[idx].strip().startswith("//"):
            lines[idx] = lines[idx].rstrip().rstrip(",")
            break

    wrapper_path.write_text("\n".join(lines) + "\n")
    print(f"  [publish] pruned unused top ports from {_SOC_TOP_WRAPPER_FILE}: {', '.join(removed_ports)}")


# ---------------------------------------------------------------------------
# Per-instance sys-side processing.
# STS sys modules are hierarchically inside their top modules (top instantiates
# sys).  We process sys configs via ip_builder separately from the topology
# to generate per-instance macro-customised dirs without duplicating RTL
# instantiations in the topology wrapper.
# ---------------------------------------------------------------------------
_SYS_CONFIGS = [
    aon_ss_iniu_sys_config,
    vpu_ss_tniu_sys_config,
    camera_ss_tniu_sys_config,
    dspss_tniu_sys_config,
]

_SOC_INIU_ALIAS_NAMES = [
    "aon_ss",
]

_SOC_TNIU_ALIAS_NAMES = [
    "vpu_ss",
    "camera_ss",
    "dspss0",
    "dspss1",
    "dspss2",
    "dspss3",
    "dspss4",
    "dspss5",
]

_PD_HARDEN_DN_LEAVES = (
    "vpu_ss",
    "camera_ss",
)

_PD_HARDEN_UP_LEAVES = (
    "dspss0",
    "dspss1",
    "dspss2",
    "dspss3",
    "dspss4",
    "dspss5",
)

_PD_HARDEN_NON_PARTITIONED_BLUE_CHAIN_LEAVES = ()

_PD_HARDEN_DN_INIU_NODES = (
    "aon_ss",
)

_LEGACY_SYS_DIR_NAMES = (
    "sts_demo_iniu_sys",
    "sts_demo_tniu0_sys",
    "sts_demo_tniu1_sys",
    "sts_demo_tniu2_sys",
    "sts_demo_tniu3_sys",
)

_SOC_OUT_OF_SCOPE_PUBLISH_DIR_NAMES = (
    "sts_logic_topo_1i4t",
    "sts_soc_logic_topo",
)

_INIU_GLOBAL_PORT_MAP = {
    "clk_src": "clk_sys",
    "rstn_src": "rst_sys_n",
    "clk_dst": "clk_noc",
    "rstn_dst": "rst_noc_n",
}

_TNIU_GLOBAL_PORT_MAP = {
    "clk_src": "clk_sys",
    "rstn_src": "rst_sys_n",
    "clk_dst": "clk_noc",
    "rstn_dst": "rst_noc_n",
    "clk_dbg_timer": "clk_dbg_timer",
    "rstn_dbg_timer": "rst_dbg_timer_n",
}

_INIU_ASYNC_INPUT_PORTS = {
    "req_rptr_async",
    "req_rptr_sync",
    "rsp_wptr_async",
    "rsp_pld_sync",
}

_INIU_ASYNC_OUTPUT_PORTS = {
    "req_wptr_async",
    "req_pld_sync",
    "rsp_rptr_async",
    "rsp_rptr_sync",
}

_TNIU_ASYNC_INPUT_PORTS = {
    "req_wptr_async",
    "req_pld_sync",
    "rsp_rptr_async",
    "rsp_rptr_sync",
}

_TNIU_ASYNC_OUTPUT_PORTS = {
    "req_rptr_async",
    "req_rptr_sync",
    "rsp_wptr_async",
    "rsp_pld_sync",
}

_INIU_AXI_VALID_INPUTS = ("s_awvalid", "s_wvalid", "s_arvalid")


def _canonical_iniu_sys_name(alias_node_name: str) -> str:
    """Map SoC-visible INIU alias to source sys payload key.

    This key is only used in staging during generation. Published build_logic
    directories are semantic aliases (for example `aon_ss_iniu_sys`).
    """
    return "iniu0"


def _canonical_tniu_sys_name(alias_leaf_name: str) -> str:
    """Map SoC-visible TNIU alias to source sys payload key.

    Source payload keys are used only in staging for dedup/reuse. Published
    build_logic directories remain semantic aliases.
    """
    if alias_leaf_name == "vpu_ss":
        return "tniu0"
    if alias_leaf_name == "camera_ss":
        return "tniu1"
    if alias_leaf_name.startswith("dspss"):
        return "tniu2"
    raise ValueError(f"Unknown TNIU alias: {alias_leaf_name}")


def _publish_sys_alias_map() -> dict[str, str]:
    """Build release-facing semantic alias dirs mapped to source payload keys."""
    alias_map: dict[str, str] = {}
    for iniu_alias in _SOC_INIU_ALIAS_NAMES:
        alias_map[f"{iniu_alias}_iniu_sys"] = f"{_canonical_iniu_sys_name(iniu_alias)}_sys"

    # Keep one directory for the whole DSP family rather than dspss0~5 fanout.
    tniu_publish_aliases = ("vpu_ss", "camera_ss", "dspss0")
    for tniu_alias in tniu_publish_aliases:
        publish_name = "dspss_tniu_sys" if tniu_alias.startswith("dspss") else f"{tniu_alias}_tniu_sys"
        alias_map[publish_name] = f"{_canonical_tniu_sys_name(tniu_alias)}_sys"

    return alias_map


@dataclass(frozen=True)
class PackageSpec:
    values: dict[str, int]
    typedef_bits: dict[str, int]


@dataclass(frozen=True)
class ModulePort:
    direction: str
    decl: str
    name: str


@dataclass(frozen=True)
class ModuleSpec:
    module_name: str
    package_name: str
    param_defaults: dict[str, str]
    symbol_values: dict[str, int]
    ports: list[ModulePort]


_PACKAGE_SPEC_CACHE: dict[Path, PackageSpec] = {}


def _clog2(value: int) -> int:
    if value <= 1:
        return 0
    return math.ceil(math.log2(value))


def _replace_sv_number_literals(expr: str) -> str:
    updated = expr
    updated = re.sub(r"(?<!\w)'([01])\b", lambda match: match.group(1), updated)

    def _convert(match: re.Match[str]) -> str:
        base = match.group(2).lower()
        digits = match.group(3).replace("_", "")
        digits = re.sub(r"[xXzZ?]", "0", digits)
        radix = {"b": 2, "o": 8, "d": 10, "h": 16}[base]
        return str(int(digits, radix))

    return re.sub(r"(\d+)?'([bBoOdDhH])([0-9a-fA-F_xXzZ?]+)", _convert, updated)


def _eval_sv_int_expr(expr: str, symbols: dict[str, int]) -> int:
    updated = expr.strip().rstrip(",;")
    updated = re.sub(
        r"\$bits\(\s*(?:\w+::)?(\w+)\s*\)",
        lambda match: str(symbols[match.group(1)]),
        updated,
    )
    updated = re.sub(
        r"\b\w+::(\w+)\b",
        lambda match: str(symbols[match.group(1)]),
        updated,
    )
    for name, value in sorted(symbols.items(), key=lambda item: len(item[0]), reverse=True):
        updated = re.sub(rf"\b{re.escape(name)}\b", str(value), updated)
    updated = _replace_sv_number_literals(updated)
    updated = updated.replace("$clog2", "clog2")
    updated = updated.replace("/", "//")
    return int(eval(updated, {"__builtins__": {}, "clog2": _clog2}, {}))


def _packed_range_width(range_expr: str, symbols: dict[str, int]) -> int:
    msb_expr, lsb_expr = [piece.strip() for piece in range_expr.split(":", 1)]
    msb = _eval_sv_int_expr(msb_expr, symbols)
    lsb = _eval_sv_int_expr(lsb_expr, symbols)
    return msb - lsb + 1


def _parse_package_spec(package_path: Path) -> PackageSpec:
    cached = _PACKAGE_SPEC_CACHE.get(package_path)
    if cached is not None:
        return cached

    content = package_path.read_text()
    values: dict[str, int] = {}
    for match in re.finditer(r"localparam\s+[^=;]+?\b(\w+)\s*=\s*([^;]+);", content):
        values[match.group(1)] = _eval_sv_int_expr(match.group(2), values)

    typedef_bits: dict[str, int] = {}
    typedef_bits.update(values)
    for match in re.finditer(
        r"typedef\s+enum\s+logic\s*\[([^\]]+)\]\s*\{.*?\}\s*(\w+)\s*;",
        content,
        re.DOTALL,
    ):
        typedef_bits[match.group(2)] = _packed_range_width(match.group(1), values)

    for match in re.finditer(r"typedef\s+struct\s+packed\s*\{(.*?)\}\s*(\w+)\s*;", content, re.DOTALL):
        body = match.group(1)
        total_width = 0
        for raw_line in body.splitlines():
            line = raw_line.split("//", 1)[0].strip().rstrip(";")
            if not line:
                continue
            range_match = re.search(r"\[([^\]]+)\]", line)
            if line.startswith("logic"):
                if range_match is None:
                    total_width += 1
                else:
                    total_width += _packed_range_width(range_match.group(1), {**values, **typedef_bits})
                continue

            type_name = line.split()[0]
            if type_name not in typedef_bits:
                raise RuntimeError(f"Unable to resolve packed typedef width for {type_name} in {package_path}")
            total_width += typedef_bits[type_name]

        typedef_bits[match.group(2)] = total_width

    spec = PackageSpec(values=values, typedef_bits={name: width for name, width in typedef_bits.items() if name not in values})
    _PACKAGE_SPEC_CACHE[package_path] = spec
    return spec


def _flatten_decl(decl: str, symbol_values: dict[str, int]) -> str:
    updated = decl
    updated = re.sub(
        r"\$bits\(\s*(?:\w+::)?(\w+)\s*\)",
        lambda match: str(symbol_values[match.group(1)]),
        updated,
    )
    updated = re.sub(
        r"\b\w+::(\w+)\b",
        lambda match: str(symbol_values[match.group(1)]),
        updated,
    )
    for name, value in sorted(symbol_values.items(), key=lambda item: len(item[0]), reverse=True):
        updated = re.sub(rf"\b{re.escape(name)}\b", str(value), updated)

    def _range_replace(match: re.Match[str]) -> str:
        range_expr = match.group(1)
        if ":" not in range_expr:
            return f"[{_eval_sv_int_expr(range_expr, symbol_values)}]"
        msb_expr, lsb_expr = [piece.strip() for piece in range_expr.split(":", 1)]
        msb = _eval_sv_int_expr(msb_expr, symbol_values)
        lsb = _eval_sv_int_expr(lsb_expr, symbol_values)
        return f"[{msb}:{lsb}]"

    return re.sub(r"\[([^\[\]]+)\]", _range_replace, updated)


def _canonical_port_package(iniu_nodes: list[str]) -> str:
    base = iniu_nodes[0] if iniu_nodes else "cpu_ss"
    if base.endswith("_iniu"):
        return f"{base}_lwnoc_sts_pack"
    return f"{base}_iniu_lwnoc_sts_pack"


def _parse_module_spec(module_path: Path, package_name: str) -> ModuleSpec:
    content = module_path.read_text()
    package_spec = _parse_package_spec(module_path.with_name(f"{package_name}.sv"))
    module_match = re.search(r"module\s+(\w+)", content)
    if module_match is None:
        raise RuntimeError(f"Unable to parse module name from {module_path}")

    raw_param_defaults: dict[str, str] = {}
    for match in re.finditer(r"(?:parameter|localparam)\s+[^=;]+?\b(\w+)\s*=\s*([^,\n]+)", content):
        raw_param_defaults[match.group(1)] = match.group(2).strip()

    symbol_values = dict(package_spec.values)
    symbol_values.update(package_spec.typedef_bits)
    param_defaults: dict[str, str] = {}
    for name, expr in raw_param_defaults.items():
        try:
            resolved = _eval_sv_int_expr(expr, symbol_values)
        except Exception:
            param_defaults[name] = expr
            continue
        param_defaults[name] = str(resolved)
        symbol_values[name] = resolved

    ports: list[ModulePort] = []
    in_port_block = False
    for raw_line in content.splitlines():
        line = raw_line.strip()
        if not in_port_block:
            if line.endswith(") (") or line == ") (":
                in_port_block = True
            continue
        if line == ");":
            break
        if not line or line.startswith("//"):
            continue
        if not (line.startswith("input") or line.startswith("output")):
            continue
        decl = line.rstrip(",")
        name = decl.split()[-1]
        direction = decl.split()[0]
        ports.append(ModulePort(direction=direction, decl=decl, name=name))

    return ModuleSpec(
        module_name=module_match.group(1),
        package_name=package_name,
        param_defaults=param_defaults,
        symbol_values=symbol_values,
        ports=ports,
    )


def _load_iniu_sys_spec(build_dir: Path, node: str) -> ModuleSpec:
    """Load INIU sys spec from canonical sys directory.
    
    The node parameter is the SoC-visible alias (e.g. 'aon_ss'), which we map
    to the canonical sys config location for spec parsing. We discover the actual
    file prefix by scanning the directory for *_sts_iniu_sys.sv pattern.
    """
    canonical_name = _canonical_iniu_sys_name(node)
    sys_dir = build_dir / f"{canonical_name}_sys"
    
    # Discover actual file prefix by finding *_sts_iniu_sys.sv
    module_files = list(sys_dir.glob("*_sts_iniu_sys.sv"))
    if not module_files:
        raise RuntimeError(f"No module file matching *_sts_iniu_sys.sv in {sys_dir}")
    
    module_path = module_files[0]
    # Extract prefix from filename (e.g., "sts_demo_iniu_sts_iniu_sys.sv" -> "sts_demo_iniu")
    prefix = module_path.stem.replace("_sts_iniu_sys", "").replace("_iniu_sys", "")
    package_name = f"{prefix}_lwnoc_sts_pack"
    
    return _parse_module_spec(module_path, package_name)


def _load_tniu_sys_spec(build_dir: Path, node: str) -> ModuleSpec:
    """Load TNIU sys spec from canonical sys directory.
    
    The node parameter is the SoC-visible alias (e.g. 'dspss0'), which we map
    to one of the 4 canonical sts_demo_tniu configs for spec parsing. We discover
    the actual file prefix by scanning the directory for *_sts_tniu_sys.sv pattern.
    """
    canonical_name = _canonical_tniu_sys_name(node)
    sys_dir = build_dir / f"{canonical_name}_sys"
    
    # Discover actual file prefix by finding *_sts_tniu_sys.sv
    module_files = list(sys_dir.glob("*_sts_tniu_sys.sv"))
    if not module_files:
        raise RuntimeError(f"No module file matching *_sts_tniu_sys.sv in {sys_dir}")
    
    module_path = module_files[0]
    # Extract prefix from filename (e.g., "sts_demo_tniu0_sts_tniu_sys.sv" -> "sts_demo_tniu0")
    prefix = module_path.stem.replace("_sts_tniu_sys", "").replace("_tniu_sys", "")
    package_name = f"{prefix}_lwnoc_sts_pack"
    
    return _parse_module_spec(module_path, package_name)


def _port_decl_with_name(port: ModulePort, new_name: str, spec: ModuleSpec) -> str:
    decl = _flatten_decl(port.decl, spec.symbol_values)
    decl = decl.rstrip()
    pieces = decl.rsplit(port.name, 1)
    if len(pieces) != 2:
        raise RuntimeError(f"Unable to rewrite port declaration: {decl}")
    return pieces[0] + new_name


def _is_iniu_async_port(port_name: str) -> bool:
    return port_name in _INIU_ASYNC_INPUT_PORTS or port_name in _INIU_ASYNC_OUTPUT_PORTS


def _is_tniu_async_port(port_name: str) -> bool:
    return port_name in _TNIU_ASYNC_INPUT_PORTS or port_name in _TNIU_ASYNC_OUTPUT_PORTS


def _external_iniu_ports(spec: ModuleSpec) -> list[ModulePort]:
    return [
        port
        for port in spec.ports
        if port.name not in _INIU_GLOBAL_PORT_MAP and not _is_iniu_async_port(port.name)
    ]


def _external_tniu_ports(spec: ModuleSpec) -> list[ModulePort]:
    return [
        port
        for port in spec.ports
        if port.name not in _TNIU_GLOBAL_PORT_MAP and not _is_tniu_async_port(port.name)
    ]


def _async_iniu_ports(spec: ModuleSpec) -> list[ModulePort]:
    return [port for port in spec.ports if _is_iniu_async_port(port.name)]


def _async_tniu_ports(spec: ModuleSpec) -> list[ModulePort]:
    return [port for port in spec.ports if _is_tniu_async_port(port.name)]


def _iniu_sys_clock_ports(node: str) -> list[str]:
    return [
        f"    input logic {node}_iniu_sys_clk_src",
        f"    input logic {node}_iniu_sys_rstn_src",
    ]


def _tniu_sys_clock_ports(node: str) -> list[str]:
    return [
        f"    input logic {node}_tniu_sys_clk_dst",
        f"    input logic {node}_tniu_sys_rstn_dst",
    ]


def _tniu_sys_clock_signal(node: str) -> str:
    return f"{node}_tniu_sys_clk_dst"


def _tniu_sys_reset_signal(node: str) -> str:
    return f"{node}_tniu_sys_rstn_dst"


def _append_iniu_boundary_ports(
    port_entries: list[str],
    node: str,
    spec: ModuleSpec,
    *,
    include_external: bool,
    include_async: bool,
) -> None:
    port_entries.extend(_iniu_sys_clock_ports(node))
    if include_external:
        for port in _external_iniu_ports(spec):
            port_entries.append(f"    {_port_decl_with_name(port, f'{node}_iniu_sys_{port.name}', spec)}")
    if include_async:
        for port in _async_iniu_ports(spec):
            port_entries.append(f"    {_port_decl_with_name(port, f'{node}_iniu_sys_{port.name}', spec)}")


def _append_tniu_boundary_ports(
    port_entries: list[str],
    node: str,
    spec: ModuleSpec,
    *,
    include_external: bool,
    include_async: bool,
) -> None:
    port_entries.extend(_tniu_sys_clock_ports(node))
    if include_external:
        for port in _external_tniu_ports(spec):
            port_entries.append(f"    {_port_decl_with_name(port, f'{node}_tniu_sys_{port.name}', spec)}")
    if include_async:
        for port in _async_tniu_ports(spec):
            port_entries.append(f"    {_port_decl_with_name(port, f'{node}_tniu_sys_{port.name}', spec)}")


def _iniu_boundary_port_names(
    node: str,
    spec: ModuleSpec,
    *,
    include_external: bool,
    include_async: bool,
) -> list[str]:
    names = [f"{node}_iniu_sys_clk_src", f"{node}_iniu_sys_rstn_src"]
    if include_external:
        names.extend(f"{node}_iniu_sys_{port.name}" for port in _external_iniu_ports(spec))
    if include_async:
        names.extend(f"{node}_iniu_sys_{port.name}" for port in _async_iniu_ports(spec))
    return names


def _tniu_boundary_port_names(
    node: str,
    spec: ModuleSpec,
    *,
    include_external: bool,
    include_async: bool,
) -> list[str]:
    names = [f"{node}_tniu_sys_clk_dst", f"{node}_tniu_sys_rstn_dst"]
    if include_external:
        names.extend(f"{node}_tniu_sys_{port.name}" for port in _external_tniu_ports(spec))
    if include_async:
        names.extend(f"{node}_tniu_sys_{port.name}" for port in _async_tniu_ports(spec))
    return names


def _boundary_port_names(
    iniu_specs: dict[str, ModuleSpec],
    tniu_specs: dict[str, ModuleSpec],
    *,
    expose_iniu_sys_ports: bool,
    expose_iniu_async_ports: bool,
    expose_tniu_sys_ports: bool,
    expose_tniu_async_ports: bool,
) -> list[str]:
    names: list[str] = []
    for node, spec in iniu_specs.items():
        names.extend([f"{node}_iniu_sys_clk_src", f"{node}_iniu_sys_rstn_src"])
        if expose_iniu_sys_ports:
            names.extend(f"{node}_iniu_sys_{port.name}" for port in _external_iniu_ports(spec))
        if expose_iniu_async_ports:
            names.extend(f"{node}_iniu_sys_{port.name}" for port in _async_iniu_ports(spec))
    for node, spec in tniu_specs.items():
        names.extend([f"{node}_tniu_sys_clk_dst", f"{node}_tniu_sys_rstn_dst"])
        if expose_tniu_sys_ports:
            names.extend(f"{node}_tniu_sys_{port.name}" for port in _external_tniu_ports(spec))
        if expose_tniu_async_ports:
            names.extend(f"{node}_tniu_sys_{port.name}" for port in _async_tniu_ports(spec))
    return names


def _render_iniu_instance(
    lines: list[str],
    spec: ModuleSpec,
    node: str,
    domain_clock: str,
    domain_reset: str,
    *,
    expose_sys_ports: bool,
    expose_async_ports: bool,
) -> None:
    lines.extend(
        [
            f"{spec.module_name} u_{node}_iniu_sys (",
            f"    .clk_src ({node}_iniu_sys_clk_src),",
            f"    .clk_dst ({domain_clock}),",
            f"    .rstn_src({node}_iniu_sys_rstn_src),",
            f"    .rstn_dst({domain_reset}),",
        ]
    )

    external_ports = _external_iniu_ports(spec)
    for port in external_ports:
        conn = f"{node}_iniu_sys_{port.name}" if expose_sys_ports else ("'0" if port.direction == "input" else "")
        if port.direction == "output" and not expose_sys_ports:
            conn = ""
        lines.append(f"    .{port.name:16} ({conn}),")

    async_ports = _async_iniu_ports(spec)
    for idx, port in enumerate(async_ports):
        if expose_async_ports:
            conn = f"{node}_iniu_sys_{port.name}"
        elif port.direction == "input":
            conn = "'0"
        else:
            conn = ""
        port_name = port.name
        suffix = "," if idx != len(async_ports) - 1 else ""
        lines.append(f"    .{port_name:16} ({conn}){suffix}")
    lines.extend([" );", ""])


def _render_tniu_instance(
    lines: list[str],
    spec: ModuleSpec,
    node: str,
    domain_clock: str,
    domain_reset: str,
    *,
    expose_sys_ports: bool,
    expose_async_ports: bool,
) -> None:
    lines.extend(
        [
            f"{spec.module_name} u_{node}_tniu_sys (",
            f"    .clk_src       ({domain_clock}),",
            f"    .clk_dst       ({_tniu_sys_clock_signal(node)}),",
            f"    .clk_dbg_timer ({_TNIU_GLOBAL_PORT_MAP['clk_dbg_timer']}),",
            f"    .rstn_src      ({domain_reset}),",
            f"    .rstn_dst      ({_tniu_sys_reset_signal(node)}),",
            f"    .rstn_dbg_timer({_TNIU_GLOBAL_PORT_MAP['rstn_dbg_timer']}),",
        ]
    )

    external_ports = _external_tniu_ports(spec)
    for port in external_ports:
        if expose_sys_ports:
            conn = f"{node}_tniu_sys_{port.name}"
        elif port.direction == "input":
            conn = "'0"
        else:
            conn = ""
        lines.append(f"    .{port.name:16} ({conn}),")

    async_input_ports = sorted(_TNIU_ASYNC_INPUT_PORTS)
    async_output_ports = sorted(_TNIU_ASYNC_OUTPUT_PORTS)
    for port_name in async_input_ports:
        conn = f"{node}_tniu_sys_{port_name}" if expose_async_ports else "'0"
        lines.append(f"    .{port_name:16} ({conn}),")
    for idx, port_name in enumerate(async_output_ports):
        conn = f"{node}_tniu_sys_{port_name}" if expose_async_ports else ""
        suffix = "," if idx != len(async_output_ports) - 1 else ""
        lines.append(f"    .{port_name:16} ({conn}){suffix}")

    lines.extend([" );", ""])


def _build_sys_components(sys_build_dir: Path) -> None:
    """Build canonical sys-side configs into a scratch staging root."""
    sys_build_dir.mkdir(parents=True, exist_ok=True)
    for cfg in _SYS_CONFIGS:
        out_path = sys_build_dir / cfg.name
        if out_path.exists():
            shutil.rmtree(out_path)
        ip = cfg.get_or_create_ip()
        out_dir = str(out_path)
        ip.release_build(path=out_dir)
        print(f"  [sys] built {cfg.name}/")


def _prune_legacy_sys_dirs(build_dir: Path) -> None:
    for dir_name in _LEGACY_SYS_DIR_NAMES:
        legacy_dir = build_dir / dir_name
        if legacy_dir.exists():
            shutil.rmtree(legacy_dir)
            print(f"  [sys] pruned legacy sys dir {legacy_dir.name}/")


def _prune_out_of_scope_publish_dirs(build_dir: Path) -> None:
    for dir_name in _SOC_OUT_OF_SCOPE_PUBLISH_DIR_NAMES:
        stale_dir = build_dir / dir_name
        if stale_dir.exists():
            shutil.rmtree(stale_dir)
            print(f"  [publish] pruned out-of-scope dir {stale_dir.name}/")


def _soc_sys_alias_env_var(alias_dir_name: str) -> str:
    return f"STS_{alias_dir_name.upper()}_OUT_DIR"


def _soc_sys_dir_env_var(dir_name: str) -> str:
    return f"STS_{dir_name.upper()}_OUT_DIR"


def _primary_generated_filelist(source_dir: Path) -> Path | None:
    candidates = [path for path in sorted(source_dir.glob("*_filelist.f")) if path.name != "expanded_filelist.f"]
    if candidates:
        return candidates[0]

    fallback = source_dir / "filelist.f"
    if fallback.exists():
        return fallback
    return None


def _detect_sys_prefix_from_filelist(filelist_name: str) -> str:
    if not filelist_name.endswith("_filelist.f"):
        raise RuntimeError(f"Unexpected sys filelist name: {filelist_name}")
    return filelist_name[: -len("_filelist.f")]


def _alias_prefix_from_dir(alias_dir_name: str) -> str:
    if alias_dir_name.endswith("_iniu_sys"):
        return alias_dir_name[: -len("_sys")]
    if alias_dir_name.endswith("_tniu_sys"):
        return alias_dir_name[: -len("_sys")]
    raise RuntimeError(f"Unsupported alias sys dir naming: {alias_dir_name}")


def _write_soc_compile_ingress(flow: str, build_dir: Path) -> None:
    alias_map = _publish_sys_alias_map()
    ingress_lines: list[str] = []

    common_dep = DEMO_ROOT / "filelists" / "sts_common_dep.f"
    if common_dep.exists():
        ingress_lines.append("-f $STS_NOC_DEMO_DIR/filelists/sts_common_dep.f")

    for alias_dir in sorted(alias_map.keys()):
        source_dir = build_dir / alias_dir
        filelist = _primary_generated_filelist(source_dir)
        if filelist is None:
            raise RuntimeError(f"Missing primary sys filelist for published alias: {source_dir}")
        ingress_lines.append(f"$STS_NOC_DEMO_DIR/build_logic/{alias_dir}/{filelist.name}")

    combined_dir = build_dir / _COMBINED_DIR
    if combined_dir.exists():
        for filelist in sorted(combined_dir.glob("*_filelist.f")):
            ingress_lines.append(f"-f $SOC_STS_NOC_DIR/{filelist.name}")
        top_wrapper = combined_dir / _SOC_TOP_WRAPPER_FILE
        if top_wrapper.exists():
            ingress_lines.append(f"$SOC_STS_NOC_DIR/{_SOC_TOP_WRAPPER_FILE}")

    published_filelist = DEMO_ROOT / "filelists" / f"filelist_soc{('_pd' if flow == 'pd' else '')}.f"
    published_filelist.write_text("\n".join(ingress_lines) + "\n")
    print(f"  [filelist] published compile ingress to {published_filelist}")


def _clone_sys_payload_alias(
    src_dir: Path,
    *,
    src_prefix: str,
    src_env_var: str,
    alias_dir: Path,
    alias_prefix: str,
    alias_env_var: str,
) -> None:
    """Clone one canonical sys build into a release-facing per-SS payload dir."""
    if not src_dir.exists():
        raise RuntimeError(f"Missing canonical sys build for alias publish: {src_dir}")

    if alias_dir.exists() or alias_dir.is_symlink():
        if alias_dir.is_symlink() or alias_dir.is_file():
            alias_dir.unlink()
        else:
            shutil.rmtree(alias_dir)
    alias_dir.mkdir(parents=True, exist_ok=True)
    os.environ[alias_env_var] = str(alias_dir)

    alias_filelist_lines: list[str] = []

    for entry in sorted(src_dir.iterdir()):
        if entry.is_dir() or entry.name == "expanded_filelist.f":
            continue

        dest_name = entry.name.replace(src_prefix, alias_prefix)
        dest_path = alias_dir / dest_name
        updated = entry.read_text(errors="replace")
        updated = updated.replace(src_prefix, alias_prefix)
        updated = updated.replace(f"${src_env_var}/", f"${alias_env_var}/")
        dest_path.write_text(updated)

        if dest_name.endswith("_filelist.f"):
            alias_filelist_lines = updated.splitlines()

    if not alias_filelist_lines:
        raise RuntimeError(f"Alias publish did not produce a local filelist in {alias_dir}")

    expanded_lines = []
    env_prefix = f"${alias_env_var}/"
    for raw_line in alias_filelist_lines:
        line = raw_line.strip()
        if not line or line.startswith("#") or line.startswith("`") or line.startswith("+") or line.startswith("-f "):
            continue
        if line.startswith(env_prefix):
            expanded_lines.append(str(alias_dir / line[len(env_prefix) :]))
        else:
            expanded_lines.append(line)

    (alias_dir / "expanded_filelist.f").write_text("\n".join(expanded_lines) + "\n")


def _publish_canonical_sys_builds(sys_build_dir: Path, build_dir: Path) -> None:
    """Publish only semantic sys directories to build_logic.

    Source payloads are read from staging canonical keys (for example
    `iniu0_sys`, `tniu0_sys`) and rewritten into semantic release directories
    (for example `aon_ss_iniu_sys`, `vpu_ss_tniu_sys`).
    """
    alias_map = _publish_sys_alias_map()

    active_sys_views = set(alias_map.keys())

    # Clean up any stale *_sys directories/symlinks.
    for stale_dir in sorted(build_dir.glob("*_sys")):
        if not stale_dir.exists() and not stale_dir.is_symlink():
            continue
        if stale_dir.name not in active_sys_views:
            if stale_dir.is_symlink() or stale_dir.is_file():
                stale_dir.unlink()
            else:
                shutil.rmtree(stale_dir)
            print(f"  [sys-publish] pruned stale sys dir {stale_dir.name}/")
    
    # Publish topology-readable alias payloads with semantic filenames.
    published_alias = 0
    for alias_name, canonical_name in sorted(alias_map.items()):
        src_dir = sys_build_dir / canonical_name
        alias_dir = build_dir / alias_name
        if not src_dir.exists():
            continue

        src_filelist = _primary_generated_filelist(src_dir)
        if src_filelist is None:
            raise RuntimeError(f"Missing canonical sys filelist for alias publish: {src_dir}")

        src_prefix = _detect_sys_prefix_from_filelist(src_filelist.name)
        alias_prefix = _alias_prefix_from_dir(alias_name)
        src_env_var = _soc_sys_dir_env_var(canonical_name)
        alias_env_var = _soc_sys_alias_env_var(alias_name)

        _clone_sys_payload_alias(
            src_dir,
            src_prefix=src_prefix,
            src_env_var=src_env_var,
            alias_dir=alias_dir,
            alias_prefix=alias_prefix,
            alias_env_var=alias_env_var,
        )

        published_alias += 1
        print(f"  [sys-view] published topo alias payload {alias_name}/ from {canonical_name}/")

    print(f"  [sys-view] published {published_alias} semantic sys directories")


def _dedup_sys_filelists(sys_build_dir: Path) -> set:
    """Remove shared modules from per-instance sys filelists to avoid OPD.

    ip_builder generates each sys build with ALL shared utility modules.
    When multiple builds are compiled together, this causes duplicate module
    declarations.  This function compares MODULE NAMES (not file suffixes)
    to identify true duplicates, since per-instance modules like packages
    have unique prefixed names while shared utility modules (sts_ctm, etc.)
    have identical names across builds.

    Returns the set of shared module names for use by downstream dedup steps.
    """
    if len(_SYS_CONFIGS) < 2:
        return set()

    canon_cfg = _SYS_CONFIGS[0]
    canon_dir = sys_build_dir / canon_cfg.name
    canon_fl = canon_dir / f"{canon_cfg.prefix}filelist.f"
    if not canon_fl.exists():
        return set()

    def _extract_module_name(sv_path: Path) -> str:
        """Extract first module/package name from an SV file."""
        content = sv_path.read_text(errors='replace')
        m = re.search(r'^\s*(?:module|package)\s+(\w+)', content, re.MULTILINE)
        return m.group(1) if m else ""

    # Build module_name -> canon_filename mapping
    canon_mod_to_file = {}  # module_name -> filename
    for sv_file in sorted(canon_dir.glob("*.sv")):
        mod_name = _extract_module_name(sv_file)
        if mod_name:
            canon_mod_to_file[mod_name] = sv_file.name

    # For each other sys build, find files with matching module names
    shared_mod_names = set()
    for cfg in _SYS_CONFIGS[1:]:
        cfg_dir = sys_build_dir / cfg.name
        for sv_file in sorted(cfg_dir.glob("*.sv")):
            mod_name = _extract_module_name(sv_file)
            if mod_name in canon_mod_to_file:
                shared_mod_names.add(mod_name)

    if not shared_mod_names:
        return set()

    # Build reverse mapping: for each build, filename -> module_name
    removed_count = 0
    for cfg in _SYS_CONFIGS[1:]:
        cfg_dir = sys_build_dir / cfg.name
        fl_path = cfg_dir / f"{cfg.prefix}filelist.f"
        if not fl_path.exists():
            continue

        # Map each file to its module name
        file_to_mod = {}
        for sv_file in sorted(cfg_dir.glob("*.sv")):
            mod_name = _extract_module_name(sv_file)
            if mod_name:
                file_to_mod[sv_file.name] = mod_name

        kept_lines = []
        for line in fl_path.read_text().splitlines():
            line_stripped = line.strip()
            if not line_stripped or line_stripped.startswith('#'):
                kept_lines.append(line)
                continue
            fname = line_stripped.rsplit('/', 1)[-1] if '/' in line_stripped else line_stripped
            mod_name = file_to_mod.get(fname, "")
            if mod_name in shared_mod_names:
                removed_count += 1
                continue
            kept_lines.append(line)

        fl_path.write_text('\n'.join(kept_lines) + '\n')

    # Extract common files from canonical filelist
    canon_file_to_mod = {}
    for sv_file in sorted(canon_dir.glob("*.sv")):
        mod_name = _extract_module_name(sv_file)
        if mod_name:
            canon_file_to_mod[sv_file.name] = mod_name

    canon_fl_lines = canon_fl.read_text().splitlines()
    common_lines = []
    kept_lines = []
    for line in canon_fl_lines:
        line_stripped = line.strip()
        if not line_stripped:
            kept_lines.append(line)
            continue
        fname = line_stripped.rsplit('/', 1)[-1] if '/' in line_stripped else line_stripped
        mod_name = canon_file_to_mod.get(fname, "")
        if mod_name in shared_mod_names:
            common_lines.append(line)
        else:
            kept_lines.append(line)

    canon_fl.write_text('\n'.join(kept_lines) + '\n')

    # Write common dep filelist
    common_dep_f = DEMO_ROOT / "filelists" / "sts_common_dep.f"
    common_dep_f.write_text('\n'.join(common_lines) + '\n')
    print(f"  [dedup] {len(shared_mod_names)} shared modules: {', '.join(sorted(shared_mod_names))}")
    print(f"  [dedup] removed {removed_count} duplicate entries from sys filelists")
    print(f"  [dedup] wrote {len(common_lines)} common deps to {common_dep_f}")
    return shared_mod_names


def _dedup_consolidated_filelist(build_dir: Path, shared_mod_names: set) -> None:
    """Remove shared modules from the consolidated top-side filelist.

    After consolidation, the sts_soc_logic_topo/ dir contains all files
    from the 6 top-side builds.  Shared utility modules (sts_ctm, etc.)
    are already provided via sts_common_dep.f from the canonical sys build,
    so duplicates in the top-side filelist must be removed.
    """
    if not shared_mod_names:
        return

    combined = build_dir / _COMBINED_DIR
    # Find all sub-filelists referenced by the umbrella
    umbrella = combined / "filelist.f"
    if not umbrella.exists():
        return

    def _extract_module_name(sv_path: Path) -> str:
        content = sv_path.read_text(errors='replace')
        m = re.search(r'^\s*(?:module|package)\s+(\w+)', content, re.MULTILINE)
        return m.group(1) if m else ""

    # Build file -> module_name map for consolidated dir
    file_to_mod = {}
    for sv_file in sorted(combined.glob("*.sv")):
        mod_name = _extract_module_name(sv_file)
        if mod_name:
            file_to_mod[sv_file.name] = mod_name

    # Process each sub-filelist referenced by umbrella
    removed_count = 0
    for line in umbrella.read_text().splitlines():
        line_stripped = line.strip()
        if not line_stripped.startswith("-f "):
            continue
        # Extract the filelist path (resolve env var to combined dir)
        fl_ref = line_stripped[3:].strip()
        fl_name = fl_ref.rsplit('/', 1)[-1] if '/' in fl_ref else fl_ref
        fl_path = combined / fl_name
        if not fl_path.exists():
            continue

        kept_lines = []
        for fl_line in fl_path.read_text().splitlines():
            fl_line_stripped = fl_line.strip()
            if not fl_line_stripped or fl_line_stripped.startswith('#') or fl_line_stripped.startswith('-') or fl_line_stripped.startswith('+'):
                kept_lines.append(fl_line)
                continue
            fname = fl_line_stripped.rsplit('/', 1)[-1] if '/' in fl_line_stripped else fl_line_stripped
            mod_name = file_to_mod.get(fname, "")
            if mod_name in shared_mod_names:
                removed_count += 1
                continue
            kept_lines.append(fl_line)

        fl_path.write_text('\n'.join(kept_lines) + '\n')

    if removed_count:
        print(f"  [dedup-top] removed {removed_count} shared module entries from consolidated filelist")


def _absorb_async_raw_support_into_combined(build_dir: Path) -> None:
    """Publish FCIP support files under the combined top dir instead of a standalone raw bucket."""
    combined = build_dir / _COMBINED_DIR
    umbrella = combined / "filelist.f"
    if not umbrella.exists():
        return

    raw_specs = (
        ("sts_req_rsp_async_raw", "STS_REQ_RSP_ASYNC_OUT_DIR"),
        ("sts_demo_req_rsp_async_raw", "STS_DEMO_REQ_RSP_ASYNC_OUT_DIR"),
    )

    promoted_refs: list[str] = []



def _print_sys_mapping_info() -> None:
    """Print endpoint-to-source/published sys mapping for transparency."""
    print("  [mapping] endpoint → source payload key")
    
    for iniu_alias in _SOC_INIU_ALIAS_NAMES:
        canonical = _canonical_iniu_sys_name(iniu_alias)
        print(f"  [mapping]   {iniu_alias:20s} → {canonical}_sys")
    
    for tniu_alias in _SOC_TNIU_ALIAS_NAMES:
        canonical = _canonical_tniu_sys_name(tniu_alias)
        print(f"  [mapping]   {tniu_alias:20s} → {canonical}_sys")

    print("  [mapping] published semantic dirs")
    for alias_dir, canonical_dir in sorted(_publish_sys_alias_map().items()):
        print(f"  [mapping]   {alias_dir:20s} → {canonical_dir}")
    
    print("  [mapping-harden] PD partition assignments")
    print(f"  [mapping-harden]   DN (dn_wrap): {', '.join(_PD_HARDEN_DN_LEAVES)}")
    print(f"  [mapping-harden]   UP (up_wrap): {', '.join(_PD_HARDEN_UP_LEAVES)}")


def _build_top_configs_standalone(build_dir: Path) -> None:
    """Fallback when UHDL assembly fails; use bare ip_builder."""
    # Placeholder: this is where UHDL fallback logic would go
    pass


def generate(flow: str = "dv") -> None:
    """Generate SoC STS topology and publish artifacts."""
    build_dir = DEMO_ROOT / "build_logic"
    sys_build_dir = DEMO_ROOT / "build" / "temp"
    published_filelist = DEMO_ROOT / "filelists" / f"filelist_soc{('_pd' if flow == 'pd' else '')}.f"
    topology_json = DEMO_ROOT / f"soc_sts_noc_topology{('_pd' if flow == 'pd' else '')}.json"
    
    build_dir.mkdir(parents=True, exist_ok=True)
    sys_build_dir.mkdir(parents=True, exist_ok=True)
    
    _build_sys_components(sys_build_dir)
    _prune_legacy_sys_dirs(build_dir)
    _prune_out_of_scope_publish_dirs(build_dir)
    _publish_canonical_sys_builds(sys_build_dir, build_dir)
    _normalize_combined_publish(build_dir)
    _prune_unused_combined_top_ports(build_dir)
    _print_sys_mapping_info()  # NEW: Print mapping for transparency
    shared_mods = _dedup_sys_filelists(sys_build_dir)
    _write_soc_compile_ingress(flow, build_dir)
    
    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"SoC top filelist written to {published_filelist}")


if __name__ == "__main__":
    import sys
    flow = sys.argv[1] if len(sys.argv) > 1 else "dv"
    generate(flow)

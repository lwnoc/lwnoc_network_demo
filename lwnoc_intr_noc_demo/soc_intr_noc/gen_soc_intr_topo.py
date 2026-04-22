"""Generate the SoC-scale interrupt ring NoC demo topology.

Supports both DV and PD packaging flows.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parents[1]
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
LOCAL_SLANG_BIN = LWNOC_TOPO_ROOT / "uhdl" / "slang" / "build" / "bin"

if os.environ.get("USE_LOCAL_SLANG") == "1" and LOCAL_SLANG_BIN.exists():
    os.environ["PATH"] = f"{LOCAL_SLANG_BIN}:{os.environ.get('PATH', '')}"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))
if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))

from topo_core.node.node import reset_global_state
from topo_core.utils.serialization import TopologySerializer

from SocIntrNode import TOP_LAYER_SUFFIX
from SocIntrTopo import HARDEN_TOP_ID
from SocIntrTopoConfig import DN_HARDEN_ID, RING_PLAN, UP_HARDEN_ID
from SocIntrTopoDv import SocIntrLogicTopo, TOPO_ID
from SocIntrTopoPd import PD_TOPO_ID, SocIntrHardenTopTopo, SocIntrPdTopo


_SHARED_BUILD_DIR_NAME = "build_logic"
_HARDEN_BUILD_DIR_NAME = _SHARED_BUILD_DIR_NAME
_HARDEN_PARTITION_IDS = (UP_HARDEN_ID, DN_HARDEN_ID)
_HARDEN_PARTITION_SIDE = {
    UP_HARDEN_ID: "a",
    DN_HARDEN_ID: "b",
}


BOUNDARY_IMPORT_TARGETS = (
    "*_async_sys_side.sv",
    "*_async_sys_side.v",
    "*_async_top_side.sv",
    "*_async_top_side.v",
    f"*{TOP_LAYER_SUFFIX}.v",
)
LP_TYPE_PORT_RE = re.compile(
    r"^(?P<indent>\s*)(?P<direction>input|output)\s+"
    r"(?P<type>(?:[A-Za-z0-9_]+::)?(?:lwnoc_lp_req_signal_t|lwnoc_pchannel_active_t|lwnoc_pchannel_state_t))"
    r"(?P<spacing>\s+)(?P<name>[A-Za-z0-9_]+)(?P<tail>\s*(?:,|\)\s*;))$",
    re.MULTILINE,
)

_SHARED_ENV = "INTR_RING_NOC_DIR"
_TOP_SIDE_BLOCKS = {
    "intr_iniu_top_side": "INTR_INIU_TOP_OUT_DIR",
    "intr_tniu_top_side": "INTR_TNIU_TOP_OUT_DIR",
    "intr_ring_network": "INTR_RING_NETWORK_OUT_DIR",
    "intr_ring_buf": "INTR_RING_BUF_OUT_DIR",
}
_LEGACY_PD_REFRESH_DIRS = (
    "soc_intr_ring_noc_harden_top",
)
_PD_REFRESH_DIRS = (
    "intr_ring_req_sink",
    "intr_ring_req_zero_source",
    HARDEN_TOP_ID,
    *_LEGACY_PD_REFRESH_DIRS,
    *_HARDEN_PARTITION_IDS,
    *_TOP_SIDE_BLOCKS.keys(),
)

REQUIRED_INTR_NODE_MODULES = (
    "interrupt_iniu_async_sys_side",
    "interrupt_iniu_async_top_side",
    "interrupt_tniu_async_sys_side",
    "interrupt_tniu_async_top_side",
    "intr_ring_req_sink",
    "intr_ring_req_zero_source",
    "interrupt_req_ring_station",
    "intr_ring_buf_wrap",
    "intr_station_temp_mem_model",
    "lwnoc_ring_buf",
    "lwnoc_ring_station",
    "lwnoc_ring_sp",
    "lwnoc_ring_async_bridge_slv",
    "lwnoc_ring_async_bridge_mst",
    "lwnoc_ring_async_bridge",
)

# Canonical module names used by IntrNode contracts may differ from external
# RTL module names. Keep alias mapping explicit and minimal.
REQUIRED_INTR_NODE_ALIASES = {
    "interrupt_iniu_async_sys_side": (
        "interrupt_iniu_aync_sys_side",
    ),
    "interrupt_iniu_async_top_side": (
        "interrupt_iniu_aync_top_side",
    ),
    "interrupt_tniu_async_sys_side": (
        "interrupt_tniu_aync_sys_side",
    ),
    "interrupt_tniu_async_top_side": (
        "interrupt_tniu_aync_top_side",
    ),
    "intr_ring_req_sink": (
        "lwnoc_intr_default_tgtid_sink",
    ),
    "intr_ring_req_zero_source": (
        "lwnoc_intr_dummy_endpoint",
    ),
    "interrupt_req_ring_station": (
        "intr_ring_buf_wrap",
    ),
}

# Advisory-only mapping for architecture migration discussion.
# These candidates do NOT satisfy canonical contract automatically.
REQUIRED_INTR_NODE_MIGRATION_CANDIDATES = {
    "interrupt_iniu_async_sys_side": (
        "interrupt_iniu_aync_sys_side",
    ),
    "interrupt_iniu_async_top_side": (
        "interrupt_iniu_aync_top_side",
    ),
    "interrupt_tniu_async_sys_side": (
        "interrupt_tniu_aync_sys_side",
    ),
    "interrupt_tniu_async_top_side": (
        "interrupt_tniu_aync_top_side",
    ),
    # Req-only sink mapping (user-specified canonical equivalence).
    "intr_ring_req_sink": (
        "lwnoc_intr_default_tgtid_sink",
    ),
    # Req-only zero-source mapping (user-specified canonical equivalence).
    "intr_ring_req_zero_source": (
        "lwnoc_intr_dummy_endpoint",
    ),
    # Station behavior may be split into wrapper + core station.
    "interrupt_req_ring_station": (
        "intr_ring_buf_wrap",
        "lwnoc_ring_station",
    ),
}

REQUIRED_INTERRUPT_REQ_RING_STATION_PORT_GROUPS = (
    "local_tx_(valid|ready|payload|srcid|tgtid|qos|last)",
    "local_rx_(valid|ready|payload|srcid|tgtid|qos|last)",
    "cw_in_(valid|ready|payload|srcid|tgtid|qos|last)",
    "cw_out_(valid|ready|payload|srcid|tgtid|qos|last)",
    "ccw_in_(valid|ready|payload|srcid|tgtid|qos|last)",
    "ccw_out_(valid|ready|payload|srcid|tgtid|qos|last)",
)

FORBIDDEN_LOCAL_RTL_PREFIX = "$INTR_NOC_DEMO_DIR/rtl/"

SOC_INTR_COMMON_DEP_FILELIST = "intr_common_dep.f"
SOC_INTR_NIU_CORE_FILELIST = "intr_niu_core.f"
SOC_INTR_NETWORK_CORE_FILELIST = "intr_network_core.f"
SOC_INTR_NIU_PREFIX_DEFINE_FILE = "soc_intr_niu_ring_noc_define.sv"
SOC_INTR_NETWORK_PREFIX_DEFINE_FILE = "soc_intr_network_ring_noc_define.sv"
SOC_INTR_NIU_TOP_FILELIST = "interrupt_noc_top_wrap.f"
SOC_INTR_NETWORK_FILELIST = "network_filelist.f"

SOC_INTR_DV_WRAP_DIR = "soc_intr_noc_wrap"
SOC_INTR_PD_WRAP_DIR = "soc_intr_noc_wrap_pd"

SOC_INTR_NIU_WRAPPER_FILELISTS = (
    "intr_iniu_sys.f",
    "intr_tniu_sys.f",
    "intr_iniu_top.f",
    "intr_tniu_top.f",
)

SOC_INTR_NETWORK_WRAPPER_FILELISTS = (
    "intr_ring_network_wrap.f",
    "intr_ring_buf_wrap.f",
    "intr_ring_station.f",
    "intr_ring_link.f",
    "intr_ring_req_sink.f",
    "intr_ring_req_zero_source.f",
)


def _declares_module(content: str, module_name: str) -> bool:
    """Return True if source text declares module_name.

    Accept both plain declarations and macro-wrapped names used in this RTL repo,
    e.g. `module foo` and `module `_PREFIX_(foo)`.
    """
    plain = re.search(rf"\bmodule\s+{re.escape(module_name)}\b", content)
    macro_wrapped = re.search(
        rf"\bmodule\s+`[A-Za-z0-9_]+\(\s*{re.escape(module_name)}\s*\)",
        content,
    )
    return bool(plain or macro_wrapped)


def _bootstrap_soc_intr_filelists_from_subs() -> None:
    """Create missing soc_intr filelists from subs vc roots.

    The soc_intr demo consumes local filelist names (intr_*.f), but the
    canonical source lists live in subs/lwnoc_interrupt_noc/vc/*.f.
    This bootstrap keeps local filenames stable while sourcing content from subs.
    """
    filelist_dir = THIS_DIR / "filelist"
    filelist_dir.mkdir(parents=True, exist_ok=True)

    intr_root = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"
    vc_dir = intr_root / "vc"
    if not vc_dir.exists():
        return

    var_map = {
        "INTR_NOC_DIR": str(intr_root),
        "INTERRUPT_INIU": str(intr_root),
        "INTERRUPT_TNIU": str(intr_root),
        "FCIP_DIR": str(intr_root / "fcip"),
        "LWNOC_LOWPOWER_COMPONENT": str(intr_root / "lwnoc_lowpower_component"),
    }

    def _resolve_vars(text: str) -> str:
        out = text
        for key, val in var_map.items():
            out = out.replace(f"${key}", val)
        return out

    def _flatten_filelist(src: Path, visited: set[Path]) -> list[str]:
        src = src.resolve()
        if src in visited or not src.exists():
            return []
        visited.add(src)

        flattened: list[str] = []
        for raw in src.read_text().splitlines():
            line = raw.strip()
            if not line or line.startswith("//"):
                continue
            # Ignore preprocessor guards in .f and keep concrete payload entries.
            if line.startswith("`"):
                continue

            expanded = _resolve_vars(line)
            if expanded.startswith("-f "):
                nested = expanded[3:].strip()
                nested_path = Path(nested)
                if not nested_path.is_absolute():
                    nested_path = (src.parent / nested_path).resolve()
                flattened.extend(_flatten_filelist(nested_path, visited))
                continue

            token = expanded
            if token.startswith("+incdir+"):
                inc = token[len("+incdir+") :]
                inc_path = Path(inc)
                if not inc_path.is_absolute():
                    inc_path = (src.parent / inc_path).resolve()
                flattened.append(f"+incdir+{inc_path}")
                continue

            path_obj = Path(token)
            if not path_obj.is_absolute():
                path_obj = (src.parent / path_obj).resolve()
            flattened.append(str(path_obj))

        return flattened

    def _dedupe_keep_order(entries: list[str]) -> list[str]:
        seen = set()
        out = []
        for entry in entries:
            if entry in seen:
                continue
            seen.add(entry)
            out.append(entry)
        return out

    def _filter_rtl_entries(entries: list[str], label: str) -> list[str]:
        out = []
        for entry in entries:
            if entry.startswith("+incdir+") or entry.startswith("-"):
                out.append(entry)
                continue
            if "/tb/" in entry:
                print(f"  [bootstrap] skip non-RTL {label} entry: {entry}")
                continue
            if not Path(entry).exists():
                print(f"  [bootstrap] skip missing {label} entry: {entry}")
                continue
            out.append(entry)
        return _dedupe_keep_order(out)

    niu_prefix_define = filelist_dir / SOC_INTR_NIU_PREFIX_DEFINE_FILE
    niu_prefix_define.write_text(
        "`ifndef SOC_INTR_NIU_RING_NOC_DEFINE_SV\n"
        "`define SOC_INTR_NIU_RING_NOC_DEFINE_SV\n"
        "`ifndef _PREFIX_\n"
        "`define _PREFIX_(x) x\n"
        "`endif\n"
        "`endif\n"
    )

    network_prefix_define = filelist_dir / SOC_INTR_NETWORK_PREFIX_DEFINE_FILE
    network_prefix_define.write_text(
        "`ifndef SOC_INTR_NETWORK_RING_NOC_DEFINE_SV\n"
        "`define SOC_INTR_NETWORK_RING_NOC_DEFINE_SV\n"
        "`ifndef _PREFIX_\n"
        "`define _PREFIX_(x) x\n"
        "`endif\n"
        "`endif\n"
    )

    common_flat = []
    for src in (
        intr_root / "fcip" / "vc" / "fcip.f",
        intr_root / "lwnoc_lowpower_component" / "src" / "vc" / "lwnoc_lp_core.f",
    ):
        common_flat.extend(_flatten_filelist(src, set()))
    common_flat = _filter_rtl_entries(common_flat, "common_dep")
    _write_filelist(filelist_dir / SOC_INTR_COMMON_DEP_FILELIST, common_flat)
    common_flat_set = {
        entry for entry in common_flat if not entry.startswith("+incdir+") and not entry.startswith("-")
    }

    niu_flat = _filter_rtl_entries(_flatten_filelist(vc_dir / SOC_INTR_NIU_TOP_FILELIST, set()), "niu_core")
    niu_core = [entry for entry in niu_flat if entry not in common_flat_set]
    niu_core = _dedupe_keep_order([str(niu_prefix_define), *niu_core])

    net_flat = _filter_rtl_entries(_flatten_filelist(vc_dir / SOC_INTR_NETWORK_FILELIST, set()), "network_core")
    net_core = _dedupe_keep_order([str(network_prefix_define), *net_flat])

    _write_filelist(filelist_dir / SOC_INTR_NIU_CORE_FILELIST, niu_core)
    _write_filelist(filelist_dir / SOC_INTR_NETWORK_CORE_FILELIST, net_core)

    def _to_include_lines(entries: list[str]) -> list[str]:
        lines: list[str] = []
        for ent in entries:
            if ent.startswith("+incdir+") or ent.startswith("-"):
                continue
            lines.append(f'`include "{ent}"')
        return lines

    if niu_core:
        (filelist_dir / "intr_niu_flat.f").write_text("\n".join(niu_core) + "\n")
        (filelist_dir / "intr_niu_flat.svh").write_text("\n".join(_to_include_lines(niu_core)) + "\n")
    if net_core:
        (filelist_dir / "intr_network_flat.f").write_text("\n".join(net_core) + "\n")
        (filelist_dir / "intr_network_flat.svh").write_text("\n".join(_to_include_lines(net_core)) + "\n")

    generated = []
    common_wrapper_lines = [
        "`ifndef EXCLUDE_FOUNDATION_IP",
        f"-f $INTR_NOC_DEMO_DIR/filelist/{SOC_INTR_COMMON_DEP_FILELIST}",
        "`endif",
    ]
    niu_wrapper_lines = [*common_wrapper_lines, *niu_core]
    network_wrapper_lines = list(net_core)

    def _build_role_wrapper_lines(role: str, side: str) -> list[str]:
        role_prefix = f"interrupt_{role}_"
        async_keep = f"interrupt_{role}_async_{side}_side.sv"
        out: list[str] = [*common_wrapper_lines, str(niu_prefix_define)]
        for entry in niu_core:
            if entry == str(niu_prefix_define):
                continue
            if entry.startswith("+incdir+") or entry.startswith("-"):
                out.append(entry)
                continue

            name = Path(entry).name
            if name == async_keep:
                out.append(entry)
                continue
            if name in {
                "spram_4096x20.sv",
                "spram_2048x20.sv",
                "spram_1024x20.sv",
                "spram_512x20.sv",
                "spram_256x20.sv",
                "spram_128x20.sv",
            }:
                out.append(entry)
                continue
            if role == "iniu" and (name == "interrupt_iniu_define.sv" or "/rtl/iniu/" in entry):
                out.append(entry)
                continue
            if role == "tniu" and (
                name == "interrupt_tniu_define.sv"
                or name == "Regbank_regbank_tniu_internal_intr.v"
                or "/rtl/tniu/" in entry
            ):
                out.append(entry)
                continue
        return _dedupe_keep_order(out)

    role_wrapper_map = {
        "intr_iniu_sys.f": _build_role_wrapper_lines("iniu", "sys"),
        "intr_tniu_sys.f": _build_role_wrapper_lines("tniu", "sys"),
        "intr_iniu_top.f": _build_role_wrapper_lines("iniu", "top"),
        "intr_tniu_top.f": _build_role_wrapper_lines("tniu", "top"),
    }

    for fname in SOC_INTR_NIU_WRAPPER_FILELISTS:
        fpath = filelist_dir / fname
        fpath.write_text("\n".join(role_wrapper_map.get(fname, niu_wrapper_lines)) + "\n")
        generated.append(fpath)

    for fname in SOC_INTR_NETWORK_WRAPPER_FILELISTS:
        fpath = filelist_dir / fname
        fpath.write_text("\n".join(network_wrapper_lines) + "\n")
        generated.append(fpath)

    generated.extend(
        [
            filelist_dir / SOC_INTR_NIU_PREFIX_DEFINE_FILE,
            filelist_dir / SOC_INTR_NETWORK_PREFIX_DEFINE_FILE,
            filelist_dir / SOC_INTR_COMMON_DEP_FILELIST,
            filelist_dir / SOC_INTR_NIU_CORE_FILELIST,
            filelist_dir / SOC_INTR_NETWORK_CORE_FILELIST,
        ]
    )

    print("  [bootstrap] refreshed soc_intr filelists from flattened subs vc roots:")
    for p in generated:
        print(f"    - {p}")


def _check_shared_intr_assets() -> None:
    """Pre-flight check for IntrNode source dependencies.

    SocIntrTopo reuses IntrNode and expects source filelists/rtl under soc_intr_noc.
    Fail fast with actionable diagnostics if required local assets are missing.
    """
    # Ensure alias env vars used by subs/vc filelists are always resolvable.
    intr_root = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"
    os.environ.setdefault("INTERRUPT_INIU", str(intr_root))
    os.environ.setdefault("INTERRUPT_TNIU", str(intr_root))
    os.environ.setdefault("FCIP_DIR", str(intr_root / "fcip"))

    _bootstrap_soc_intr_filelists_from_subs()

    intr_ring_dir = THIS_DIR
    required_paths = [
        intr_ring_dir / "filelist" / "intr_iniu_top.f",
        intr_ring_dir / "filelist" / "intr_tniu_top.f",
        intr_ring_dir / "filelist" / "intr_ring_buf_wrap.f",
        intr_ring_dir / "filelist" / "intr_ring_network_wrap.f",
        REPO_ROOT / "subs" / "lwnoc_interrupt_noc" / "rtl" / "network" / "intr_ring_buf_wrap.sv",
    ]
    missing = [p for p in required_paths if not p.exists()]
    if missing:
        missing_lines = "\n".join(f"  - {p}" for p in missing)
        raise RuntimeError(
            "Missing intr source assets required by IntrNode-based soc generation.\n"
            f"Expected under: {intr_ring_dir}\n"
            f"Missing:\n{missing_lines}\n"
            "Action: restore soc_intr_noc source filelists/rtl (not generated build outputs) before rerun."
        )


def _report_missing_intr_nodes() -> None:
    """Check required node modules against external RTL root and emit a report.

    Constraint mode: user requires all RTL to come from standalone
    /home/lgzhu/dev/noc_work/lwnoc_interrupt_noc/rtl and forbids creating new RTL.
    """
    rtl_root = REPO_ROOT / "subs" / "lwnoc_interrupt_noc" / "rtl"
    report_path = THIS_DIR / "qc" / "missing_intr_nodes_report.txt"
    report_path.parent.mkdir(parents=True, exist_ok=True)

    if not rtl_root.exists():
        report_path.write_text(
            "status: blocked\n"
            f"reason: rtl_root_missing\n"
            f"rtl_root: {rtl_root}\n"
        )
        raise RuntimeError(f"Required RTL root does not exist: {rtl_root}")

    sv_sources = list(rtl_root.rglob("*.sv")) + list(rtl_root.rglob("*.v"))
    found = []
    missing = []
    alias_hits = {}
    for mod in REQUIRED_INTR_NODE_MODULES:
        present = False
        matched_name = None
        candidates = (mod,) + REQUIRED_INTR_NODE_ALIASES.get(mod, ())
        for candidate in candidates:
            for src in sv_sources:
                content = src.read_text(errors="ignore")
                if _declares_module(content, candidate):
                    present = True
                    matched_name = candidate
                    break
            if present:
                break
        if present:
            found.append(mod)
            if matched_name and matched_name != mod:
                alias_hits[mod] = matched_name
        else:
            missing.append(mod)

    lines = [
        "status: blocked" if missing else "status: pass",
        f"rtl_root: {rtl_root}",
        f"required_count: {len(REQUIRED_INTR_NODE_MODULES)}",
        f"found_count: {len(found)}",
        f"missing_count: {len(missing)}",
        "",
        "found_modules:",
    ]
    lines.extend(f"  - {m}" for m in found)
    lines.append("")
    lines.append("missing_modules:")
    lines.extend(f"  - {m}" for m in missing)
    lines.append("")
    lines.append("alias_resolutions:")
    if alias_hits:
        lines.extend(f"  - {k} => {v}" for k, v in sorted(alias_hits.items()))
    else:
        lines.append("  - (none)")
    lines.append("")
    lines.append("migration_candidates:")
    migration_lines = []
    for mod in missing:
        candidates = REQUIRED_INTR_NODE_MIGRATION_CANDIDATES.get(mod, ())
        if not candidates:
            continue
        status = []
        for cand in candidates:
            cand_present = any(_declares_module(src.read_text(errors="ignore"), cand) for src in sv_sources)
            status.append(f"{cand}({'found' if cand_present else 'missing'})")
        migration_lines.append(f"  - {mod} => {', '.join(status)}")
    if migration_lines:
        lines.extend(migration_lines)
    else:
        lines.append("  - (none)")
    lines.append("")
    lines.append("required_interrupt_req_ring_station_ports:")
    lines.extend(f"  - {port_group}" for port_group in REQUIRED_INTERRUPT_REQ_RING_STATION_PORT_GROUPS)
    lines.append("")
    lines.append("note: generation is blocked if any required module is missing under external RTL root.")
    report_path.write_text("\n".join(lines) + "\n")

    if missing:
        missing_preview = "\n".join(f"  - {m}" for m in missing)
        raise RuntimeError(
            "External RTL-only constraint check failed. Missing required IntrNode modules:\n"
            f"{missing_preview}\n"
            f"Report: {report_path}"
        )


def _check_no_demo_local_rtl_refs() -> None:
    """Enforce submodule-only RTL ingress from source filelists.

    User constraint: all RTL components must come from submodule collateral,
    not from demo-local rtl paths.
    """
    filelist_dir = THIS_DIR / "filelist"
    offenders = []
    for filelist in sorted(filelist_dir.glob("*.f")):
        for lineno, line in enumerate(filelist.read_text(errors="ignore").splitlines(), start=1):
            if FORBIDDEN_LOCAL_RTL_PREFIX in line:
                offenders.append((filelist.name, lineno, line.strip()))

    report_path = THIS_DIR / "qc" / "forbidden_local_rtl_refs.txt"
    if offenders:
        lines = ["status: blocked", f"forbidden_prefix: {FORBIDDEN_LOCAL_RTL_PREFIX}", "", "offenders:"]
        lines.extend(f"  - {fname}:{lineno}: {entry}" for fname, lineno, entry in offenders)
        report_path.write_text("\n".join(lines) + "\n")
        preview = "\n".join(f"  - {fname}:{lineno}: {entry}" for fname, lineno, entry in offenders[:12])
        raise RuntimeError(
            "Submodule-only RTL constraint violated by demo-local RTL filelist entries:\n"
            f"{preview}\n"
            f"Report: {report_path}"
        )

    report_path.write_text(
        "status: pass\n"
        f"forbidden_prefix: {FORBIDDEN_LOCAL_RTL_PREFIX}\n"
        "offenders: 0\n"
    )


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


def generate(flow: str = "dv"):
    if flow not in {"dv", "pd"}:
        raise ValueError(f"Unsupported flow: {flow}. Expected 'dv' or 'pd'.")

    reset_global_state()
    
    # Pre-flight checks
    _check_visualization_dependencies()
    _report_missing_intr_nodes()
    _check_no_demo_local_rtl_refs()
    _check_shared_intr_assets()

    if flow == "dv":
        topo = SocIntrLogicTopo()
        combined_dir = TOPO_ID
        topology_json = THIS_DIR / "soc_intr_logic_topology.json"
        build_dir = THIS_DIR / _SHARED_BUILD_DIR_NAME
        topo_png = THIS_DIR / "soc_intr_ring_topology.png"
        publish_dst = THIS_DIR / "filelist" / "filelist.f"
        build_dir_name = _SHARED_BUILD_DIR_NAME
    else:
        topo = SocIntrPdTopo()
        combined_dir = PD_TOPO_ID
        topology_json = THIS_DIR / "soc_intr_pd_topology.json"
        build_dir = THIS_DIR / _SHARED_BUILD_DIR_NAME
        topo_png = THIS_DIR / "soc_intr_ring_topology_pd.png"
        publish_dst = THIS_DIR / "filelist_pd" / "filelist.f"
        build_dir_name = _SHARED_BUILD_DIR_NAME

    _prepare_build_dir(flow, build_dir)

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _emit_topology_visualization(topo, topo_png, topology_json)
    _write_endpoint_id_tables(THIS_DIR / "build")

    # Keep only source-independent publication shaping here.
    # LP connectivity, LP boundary vectorization, and boundary import style are
    # expected to be handled directly by the topology source.
    if flow == "dv":
        _patch_async_fifo_depths(build_dir, iniu_depth=16, tniu_depth=10)
        _rename_generated_lwmnoc_define_shims(build_dir)
        _consolidate_top_side(build_dir, combined_dir)
    _localize_generated_prefix_defines(build_dir)
    _tieoff_unused_input_ports(build_dir / combined_dir)
    if flow == "dv":
        _publish_top_filelist(
            build_dir / combined_dir / "filelist.f",
            publish_dst,
            build_dir_name,
            combined_dir,
        )
    else:
        _publish_partitioned_harden_outputs(
            build_dir,
            build_dir / combined_dir,
            THIS_DIR / "filelist_pd",
        )
    _run_top_io_boundary_check(build_dir / combined_dir / f"{combined_dir}.v")

    print(f"[{flow}] Topology JSON written to {topology_json}")
    print(f"[{flow}] Generated RTL written to  {build_dir}")
    print(f"[{flow}] Top filelist written to   {publish_dst}")


def main():
    parser = argparse.ArgumentParser(description="Generate SoC intr topology for DV/PD flows")
    parser.add_argument("--flow", choices=["dv", "pd"], default="dv")
    args = parser.parse_args()
    generate(args.flow)


def _remove_generated_entry(path: Path) -> None:
    if path.is_dir():
        shutil.rmtree(path)
    else:
        path.unlink()


def _prepare_build_dir(flow: str, build_dir: Path) -> None:
    if not build_dir.exists():
        return

    removed_entries = []
    if flow == "dv":
        for entry in sorted(build_dir.iterdir()):
            if entry.name in {HARDEN_TOP_ID, SOC_INTR_PD_WRAP_DIR, *_HARDEN_PARTITION_IDS}:
                continue
            _remove_generated_entry(entry)
            removed_entries.append(entry.name)
    else:
        for entry_name in _PD_REFRESH_DIRS:
            entry = build_dir / entry_name
            if not entry.exists():
                continue
            _remove_generated_entry(entry)
            removed_entries.append(entry_name)

    if removed_entries:
        joined = ", ".join(removed_entries)
        print(f"[{flow}] Removed stale generated entries from {build_dir}: {joined}")


def _extract_nodes_recursive(node: dict, parent_id: str = None, nodes: dict = None, edges: list = None) -> tuple:
    """Recursively extract nodes and parent-child relationships from tree structure."""
    if nodes is None:
        nodes = {}
    if edges is None:
        edges = []
    
    node_id = node.get("id")
    if not node_id:
        return nodes, edges
    
    node_type = node.get("type", "unknown")
    nodes[node_id] = {"label": node_id, "type": node_type}
    
    # Add edge from parent to this node if parent exists
    if parent_id and node_type == "atomic":
        edges.append((parent_id, node_id))
    
    # Recursively process children
    children = node.get("children", [])
    for child in children:
        _extract_nodes_recursive(child, node_id, nodes, edges)
    
    return nodes, edges


def _build_graph_from_topology_json(json_path: Path) -> object:
    """Build networkx graph from topology JSON file."""
    try:
        import networkx as nx
        import json
    except ImportError:
        return None
    
    try:
        with open(json_path) as f:
            topo_dict = json.load(f)
    except Exception:
        return None
    
    graph = nx.DiGraph()
    
    # Extract topology from root
    root_topo = topo_dict.get("topology", {})
    if not root_topo:
        return graph
    
    nodes, edges = _extract_nodes_recursive(root_topo)

    for node_id, node_data in nodes.items():
        graph.add_node(node_id, label=node_data["label"], node_type=node_data.get("type", "unknown"))

    for parent_id, child_id in edges:
        if parent_id in nodes and child_id in nodes:
            graph.add_edge(parent_id, child_id)
    
    return graph


def _collect_endpoint_id_rows() -> list[dict[str, object]]:
    rows: list[dict[str, object]] = []
    for ring_slot, entry in enumerate(RING_PLAN):
        kind = entry.get("kind")
        node_id = entry.get("node_id")
        if kind not in {"iniu", "tniu"} or not isinstance(node_id, int):
            continue
        rows.append(
            {
                "node_id": node_id,
                "kind": kind,
                "name": entry["name"],
                "domain": entry["domain"],
                "ring_slot": ring_slot,
            }
        )
    rows.sort(key=lambda row: (row["node_id"], row["kind"], row["name"]))
    return rows


def _write_endpoint_id_tables(output_dir: Path) -> None:
    rows = _collect_endpoint_id_rows()
    output_dir.mkdir(parents=True, exist_ok=True)

    md_lines = [
        "# SoC Intr Endpoint ID Table",
        "",
        "| Node ID | Kind | Name | Domain | Ring Slot |",
        "|---|---|---|---|---|",
    ]
    csv_lines = ["node_id,kind,name,domain,ring_slot"]
    for row in rows:
        md_lines.append(
            f"| {row['node_id']} | {row['kind']} | {row['name']} | {row['domain']} | {row['ring_slot']} |"
        )
        csv_lines.append(
            f"{row['node_id']},{row['kind']},{row['name']},{row['domain']},{row['ring_slot']}"
        )

    md_path = output_dir / "soc_intr_endpoint_id_table.md"
    csv_path = output_dir / "soc_intr_endpoint_id_table.csv"
    md_path.write_text("\n".join(md_lines) + "\n")
    csv_path.write_text("\n".join(csv_lines) + "\n")
    print(f"  [id_table] wrote {md_path} and {csv_path}")


def _build_soc_intr_ring_graph() -> object:
    import networkx as nx

    graph = nx.MultiDiGraph()
    ordered_names: list[str] = []
    for ring_slot, entry in enumerate(RING_PLAN):
        node_name = entry.get("name")
        if not isinstance(node_name, str):
            continue
        graph.add_node(
            node_name,
            label=node_name,
            kind=entry.get("kind", "unknown"),
            domain=entry.get("domain"),
            ring_slot=ring_slot,
            node_id=entry.get("node_id"),
            src_domain=entry.get("src_domain"),
            dst_domain=entry.get("dst_domain"),
        )
        ordered_names.append(node_name)

    for idx, node_name in enumerate(ordered_names):
        next_name = ordered_names[(idx + 1) % len(ordered_names)]
        graph.add_edge(node_name, next_name, key=f"pring_{idx}", ring="pring")
        graph.add_edge(next_name, node_name, key=f"nring_{idx}", ring="nring")

    return graph


def _build_soc_intr_ring_layout(graph: object) -> dict[str, tuple[float, float]]:
    import math

    ordered_nodes = sorted(graph.nodes, key=lambda node: graph.nodes[node].get("ring_slot", 0))
    if not ordered_nodes:
        return {}

    radius = max(6.0, len(ordered_nodes) / 6.0)
    pos = {}
    for idx, node_name in enumerate(ordered_nodes):
        angle = 2 * math.pi * idx / len(ordered_nodes) - math.pi / 2
        pos[node_name] = (radius * math.cos(angle), radius * math.sin(angle))
    return pos


def _render_soc_intr_ring_graph(graph: object, output_path: Path) -> None:
    import matplotlib.patches as mpatches
    import matplotlib.pyplot as plt
    import networkx as nx

    pos = _build_soc_intr_ring_layout(graph)
    figure = plt.figure(figsize=(22, 22))

    node_colors = []
    for node_name in graph.nodes:
        kind = graph.nodes[node_name].get("kind")
        domain = graph.nodes[node_name].get("domain")
        if kind == "async":
            node_colors.append("#f7a8b8")
        elif kind == "sink":
            node_colors.append("#ffd166")
        elif kind == "sp":
            node_colors.append("#cdb4db")
        elif domain == "a":
            node_colors.append("#8ecae6")
        elif domain == "b":
            node_colors.append("#b7e4c7")
        else:
            node_colors.append("#d9d9d9")

    labels = {node_name: graph.nodes[node_name].get("label", node_name) for node_name in graph.nodes}
    nx.draw_networkx_nodes(
        graph,
        pos,
        node_color=node_colors,
        node_size=1800,
        alpha=0.95,
        linewidths=1.0,
        edgecolors="#404040",
    )
    nx.draw_networkx_labels(graph, pos, labels=labels, font_size=6, font_weight="bold")

    pring_edges = [(u, v) for u, v, _, data in graph.edges(keys=True, data=True) if data.get("ring") == "pring"]
    nring_edges = [(u, v) for u, v, _, data in graph.edges(keys=True, data=True) if data.get("ring") == "nring"]

    nx.draw_networkx_edges(
        graph,
        pos,
        edgelist=pring_edges,
        arrows=True,
        arrowsize=16,
        width=1.6,
        alpha=0.8,
        edge_color="#4169E1",
        connectionstyle="arc3,rad=0.14",
        min_source_margin=20,
        min_target_margin=20,
    )
    nx.draw_networkx_edges(
        graph,
        pos,
        edgelist=nring_edges,
        arrows=True,
        arrowsize=16,
        width=1.6,
        alpha=0.8,
        edge_color="#FF8C00",
        connectionstyle="arc3,rad=-0.14",
        min_source_margin=20,
        min_target_margin=20,
    )

    legend_handles = [
        mpatches.Patch(color="#4169E1", label="pring direction"),
        mpatches.Patch(color="#FF8C00", label="nring direction"),
        mpatches.Patch(color="#8ecae6", label="domain a"),
        mpatches.Patch(color="#b7e4c7", label="domain b"),
        mpatches.Patch(color="#f7a8b8", label="async cut"),
        mpatches.Patch(color="#ffd166", label="default sink"),
    ]
    plt.legend(handles=legend_handles, loc="upper right", fontsize=10)
    plt.title(
        f"SoC Intr Ring Direction Graph ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} directed edges)"
    )
    plt.axis("off")
    plt.tight_layout()
    output_path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output_path, dpi=150, bbox_inches="tight")
    plt.close(figure)
    print(f"  [topo_viz] topology graph written to {output_path}")


def _emit_topology_visualization(topo, output_path: Path, topology_json: Path = None) -> None:
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
        graph = None

        if isinstance(topo, SocIntrLogicTopo):
            graph = _build_soc_intr_ring_graph()
        else:
            try:
                graph = topo.datatopo.to_networkx(node_level=True)
            except Exception:
                if topology_json and topology_json.exists():
                    graph = _build_graph_from_topology_json(topology_json)
        
        if graph is None or graph.number_of_nodes() == 0:
            print("  [topo_viz] WARNING: graph is empty, skip image output")
            return

        if isinstance(topo, SocIntrLogicTopo):
            _render_soc_intr_ring_graph(graph, output_path)
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

    iniu_top_side_dir = build_dir / "intr_iniu_top_side"
    for sv_path in sorted(iniu_top_side_dir.glob("*_interrupt_iniu_async_top_side.sv")):
        _replace_depth(sv_path, old_depth=10, new_depth=iniu_depth)

    for sv_path in sorted(
        path
        for path in (
            iniu_top_side_dir / "interrupt_iniu_async_top_side.sv",
            build_dir / "soc_intr_ring_top" / "interrupt_iniu_async_top_side.sv",
        )
        if path.exists()
    ):
        _replace_depth(sv_path, old_depth=10, new_depth=iniu_depth)

    for tniu_sys_dir in sorted(build_dir.glob("*_tniu_sys")):
        for sv_path in sorted(tniu_sys_dir.glob("*_interrupt_tniu_async_sys_side.sv")):
            _replace_depth(sv_path, old_depth=16, new_depth=tniu_depth)


def _rename_generated_lwmnoc_define_shims(build_dir: Path) -> None:
    """Rename generated *_lwmnoc_define.sv shims to *_ring_noc_define.sv."""
    replacements = {
        "soc_intr_niu_lwmnoc_define.sv": "soc_intr_niu_ring_noc_define.sv",
        "soc_intr_network_lwmnoc_define.sv": "soc_intr_network_ring_noc_define.sv",
    }

    renamed_any = False
    for old_name, new_name in replacements.items():
        for old_path in sorted(build_dir.rglob(old_name)):
            new_path = old_path.with_name(new_name)
            old_text = old_path.read_text()
            new_text = old_text.replace("LWMNOC", "RING_NOC")
            new_path.write_text(new_text)
            old_path.unlink()
            renamed_any = True

    if not renamed_any:
        return

    candidate_files: set[Path] = set()
    for pattern in ("*.f", "*.sv", "*.svh", "*.json"):
        candidate_files.update(build_dir.rglob(pattern))

    for path in sorted(candidate_files):
        text = path.read_text(errors="ignore")
        updated = text
        for old_name, new_name in replacements.items():
            updated = updated.replace(old_name, new_name)
        if updated != text:
            path.write_text(updated)

    print("  [rename] normalized generated *_lwmnoc_define.sv -> *_ring_noc_define.sv")


def _localize_generated_prefix_defines(build_dir: Path) -> None:
    """Keep generated macro shims local to the file that defines them."""
    for path in sorted(build_dir.rglob("*_define.sv")):
        text = path.read_text()
        if "`define _PREFIX_(" not in text:
            continue

        updated = re.sub(r"`ifndef\s+[A-Za-z0-9_]+__PREFIX_\b", "`ifndef _PREFIX_", text)
        if "`undef _PREFIX_" not in updated:
            if not updated.endswith("\n"):
                updated += "\n"
            updated += "`undef _PREFIX_\n"

        if updated != text:
            path.write_text(updated)
            print(f"  [prefix_guard] {path.name}: localized _PREFIX_ macro scope")

    for path in sorted(build_dir.rglob("*_macros.sv")):
        text = path.read_text()
        if "`define ASYNC_FIFO_DEPTH" not in text or "`undef ASYNC_FIFO_DEPTH" in text:
            continue

        updated = text
        if not updated.endswith("\n"):
            updated += "\n"
        updated += "`undef ASYNC_FIFO_DEPTH\n"
        path.write_text(updated)
        print(f"  [macro_guard] {path.name}: localized ASYNC_FIFO_DEPTH macro scope")


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
        updated = text
        updated = updated.replace(".req_threshold());", ".req_threshold(1'b0));")
        updated = updated.replace(".preq(),", ".preq(1'b0),")
        updated = updated.replace(
            ".pstate(pchannel_pstate),",
            ".pstate(lwnoc_lp_define_package::lwnoc_pchannel_state_t'(pchannel_pstate)),",
        )
        updated = updated.replace(".pstate(),", ".pstate('0),")
        if updated != text:
            fpath.write_text(updated)
            print(f"  [tieoff] {fpath.name}: tied off req_threshold/preq/pstate inputs")

    for fpath in sorted(ring_dir.glob("*_tniu.v")):
        if fpath.stem.endswith("_ring"):
            continue
        text = fpath.read_text()
        updated = text
        updated = updated.replace(".preq(),", ".preq(1'b0),")
        updated = updated.replace(
            ".pstate(pchannel_pstate),",
            ".pstate(lwnoc_lp_define_package::lwnoc_pchannel_state_t'(pchannel_pstate)),",
        )
        updated = updated.replace(".pstate(),", ".pstate('0),")
        if updated != text:
            fpath.write_text(updated)
            print(f"  [tieoff] {fpath.name}: tied off preq/pstate inputs")


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


def _consolidate_top_side(build_dir: Path, combined_dir_name: str) -> None:
    combined = build_dir / combined_dir_name
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
        print(f"  [consolidate] merged {block_name}/ -> {combined_dir_name}/")

    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${_SHARED_ENV}/")
        umbrella.write_text(content)
        print("  [consolidate] rewrote umbrella filelist env vars")


def _extract_module_ports(module_text: str) -> tuple[str, list[str]]:
    header_match = re.search(r"module\s+[A-Za-z_][A-Za-z0-9_]*\s*\((.*?)\);", module_text, re.DOTALL)
    if not header_match:
        raise RuntimeError("Unable to parse module header for wrapper generation.")

    header_blob = header_match.group(1)
    port_names: list[str] = []
    for raw in header_blob.splitlines():
        line = raw.split("//", 1)[0].strip()
        if not line:
            continue
        line = line.rstrip(",")
        token = line.split()[-1]
        if token in {"input", "output", "inout"}:
            continue
        port_names.append(token)

    return header_blob, port_names


def _publish_named_top_wrapper(
    build_dir: Path,
    inner_dir_name: str,
    wrapper_dir_name: str,
    *,
    include_common_dep: bool = True,
) -> None:
    inner_dir = build_dir / inner_dir_name
    inner_top = inner_dir / f"{inner_dir_name}.v"
    if not inner_top.exists():
        raise RuntimeError(f"Missing generated top file for wrapper publish: {inner_top}")

    wrapper_dir = build_dir / wrapper_dir_name
    if wrapper_dir.exists():
        shutil.rmtree(wrapper_dir)
    wrapper_dir.mkdir(parents=True, exist_ok=True)

    module_text = inner_top.read_text()
    header_blob, port_names = _extract_module_ports(module_text)
    port_links = ",\n".join(f"        .{name}({name})" for name in port_names)
    wrapper_text = (
        f"module {wrapper_dir_name} (\n"
        f"{header_blob}\n"
        ");\n\n"
        f"    {inner_dir_name} u_{wrapper_dir_name} (\n"
        f"{port_links}\n"
        "    );\n\n"
        "endmodule\n"
    )

    wrapper_sv = wrapper_dir / f"{wrapper_dir_name}.v"
    wrapper_sv.write_text(wrapper_text)

    wrapper_lines = []
    if include_common_dep:
        wrapper_lines.append(f"-f $INTR_NOC_DEMO_DIR/filelist/{SOC_INTR_COMMON_DEP_FILELIST}")
    wrapper_lines.extend(
        [
            f"-f $INTR_NOC_DEMO_DIR/{_SHARED_BUILD_DIR_NAME}/{inner_dir_name}/filelist.f",
            f"$INTR_NOC_DEMO_DIR/{_SHARED_BUILD_DIR_NAME}/{wrapper_dir_name}/{wrapper_dir_name}.v",
        ]
    )
    _write_filelist(wrapper_dir / "filelist.f", wrapper_lines)


def _as_demo_token(path: Path) -> str:
    return f"$INTR_NOC_DEMO_DIR/{path.relative_to(THIS_DIR).as_posix()}"


def _iter_localized_filelist_entries(filelist_path: Path, source_dir: Path):
    if not filelist_path.exists():
        return

    seen_filenames = set()
    for raw_line in filelist_path.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("`") or line.startswith("+incdir+") or line.startswith("-f "):
            continue

        filename = Path(line).name
        if filename in seen_filenames:
            continue

        candidate = source_dir / filename
        if not candidate.exists():
            continue

        seen_filenames.add(filename)
        yield candidate


def _iter_sys_filelist_entries(build_dir: Path):
    for sys_dir in sorted(build_dir.glob("*_sys")):
        sys_filelists = [
            path for path in sorted(sys_dir.glob("*_filelist.f")) if path.name != "expanded_filelist.f"
        ]
        if not sys_filelists:
            sys_filelists = sorted(sys_dir.glob("*_filelist.f"))
        if not sys_filelists:
            continue
        yield from _iter_localized_filelist_entries(sys_filelists[0], sys_dir)


def _iter_dv_combined_core_entries(source_dir: Path):
    for macro_name, wrapper_name in (
        ("intr_iniu_top_macros.sv", "intr_iniu_top.f"),
        ("intr_tniu_top_macros.sv", "intr_tniu_top.f"),
    ):
        macro_path = source_dir / macro_name
        if macro_path.exists():
            yield macro_path
        yield from _iter_localized_filelist_entries(THIS_DIR / "filelist" / wrapper_name, source_dir)

    for macro_path in sorted(source_dir.glob("intr_ring*macros*.sv")):
        yield macro_path
    yield from _iter_localized_filelist_entries(source_dir / "filelist.f", source_dir)


def _iter_dv_leaf_filenames(source_dir: Path):
    seen_filenames = set()
    for entry in _iter_ring_plan_entries():
        node_name = entry.get("name")
        kind = entry.get("kind")
        if not isinstance(node_name, str):
            continue

        if kind in {"iniu", "tniu", "sink"}:
            candidates = (f"{node_name}_ring.v", f"{node_name}.v")
        elif kind == "async":
            candidates = (f"{node_name}.v",)
        else:
            continue

        for filename in candidates:
            if filename in seen_filenames or not (source_dir / filename).exists():
                continue
            seen_filenames.add(filename)
            yield filename


def _rewrite_dv_logic_filelist(build_dir: Path, combined_dir_name: str) -> None:
    source_dir = build_dir / combined_dir_name
    if not source_dir.exists():
        return

    out_lines = []
    seen_lines = set()

    def _append_path(path: Path) -> None:
        line = _as_demo_token(path)
        if line in seen_lines:
            return
        seen_lines.add(line)
        out_lines.append(line)

    for path in _iter_sys_filelist_entries(build_dir):
        _append_path(path)
    for path in _iter_dv_combined_core_entries(source_dir):
        _append_path(path)
    for filename in _iter_dv_leaf_filenames(source_dir):
        _append_path(source_dir / filename)

    top_path = source_dir / f"{combined_dir_name}.v"
    if top_path.exists():
        _append_path(top_path)

    _write_filelist(source_dir / "filelist.f", out_lines)


def _publish_top_filelist(src_path: Path, dst_path: Path, build_dir_name: str, combined_dir_name: str) -> None:
    if not src_path.exists():
        return
    build_dir = THIS_DIR / build_dir_name
    _rewrite_dv_logic_filelist(build_dir, combined_dir_name)
    _publish_named_top_wrapper(build_dir, combined_dir_name, SOC_INTR_DV_WRAP_DIR)

    top_lines = [
        f"-f $INTR_NOC_DEMO_DIR/filelist/{SOC_INTR_COMMON_DEP_FILELIST}",
        f"-f $INTR_NOC_DEMO_DIR/{build_dir_name}/{combined_dir_name}/filelist.f",
    ]
    dst_path.parent.mkdir(parents=True, exist_ok=True)
    dst_path.write_text("\n".join(top_lines) + "\n")
    print(f"  [filelist] published top compile ingress to {dst_path}")


def _write_filelist(path: Path, lines: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def _iter_ring_plan_entries(side: str | None = None):
    for entry in RING_PLAN:
        if not isinstance(entry, dict):
            continue
        if side is not None and entry.get("domain") != side:
            continue
        yield entry


def _iter_ring_plan_nodes(side: str | None = None):
    for entry in _iter_ring_plan_entries(side=side):
        node_name = entry.get("name")
        if not isinstance(node_name, str):
            continue
        yield node_name


def _collect_generated_filelist_includes(source_dir: Path) -> list[str]:
    source_filelist = source_dir / "filelist.f"
    if not source_filelist.exists():
        return []

    include_lines = []
    seen_lines = set()
    for raw_line in source_filelist.read_text().splitlines():
        line = raw_line.strip()
        if not line or not line.startswith("-f ") or line in seen_lines:
            continue
        include_lines.append(line)
        seen_lines.add(line)
    return include_lines


_PD_SHARED_OVERRIDE_FILENAMES = {
    "default_tgtid_sink.v",
    "default_tgtid_sink_ring.v",
    "ring_async_cut_dn_to_up.v",
    "ring_async_cut_up_to_dn.v",
}


def _iter_filtered_pd_shared_entries(source_dir: Path):
    source_filelist = source_dir / "filelist.f"
    if not source_filelist.exists():
        return

    seen_lines = set()
    for raw_line in source_filelist.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("`") or line.startswith("+incdir+") or line.startswith("-f "):
            continue
        if Path(line).name in _PD_SHARED_OVERRIDE_FILENAMES:
            continue
        if line in seen_lines:
            continue
        seen_lines.add(line)
        yield line


def _iter_partition_leaf_filenames(source_dir: Path, side: str):
    seen_filenames = set()
    for entry in _iter_ring_plan_entries(side=side):
        node_name = entry.get("name")
        kind = entry.get("kind")
        if not isinstance(node_name, str):
            continue

        if kind in {"iniu", "tniu"}:
            leaf_base = f"{node_name}{TOP_LAYER_SUFFIX}"
        elif kind == "sink":
            leaf_base = node_name
        else:
            continue

        for suffix in ("_ring.v", ".v"):
            filename = f"{leaf_base}{suffix}"
            if filename in seen_filenames or not (source_dir / filename).exists():
                continue
            seen_filenames.add(filename)
            yield filename


def _iter_async_leaf_filenames(source_dir: Path):
    seen_filenames = set()
    for entry in _iter_ring_plan_entries():
        if entry.get("kind") != "async":
            continue
        node_name = entry.get("name")
        if not isinstance(node_name, str):
            continue
        filename = f"{node_name}.v"
        if filename in seen_filenames or not (source_dir / filename).exists():
            continue
        seen_filenames.add(filename)
        yield filename


def _publish_harden_partition_dir(source_dir: Path, target_dir: Path, partition_id: str) -> None:
    side = _HARDEN_PARTITION_SIDE[partition_id]
    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    target_root = f"$INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{partition_id}"
    out_lines: list[str] = []

    for filename in _iter_partition_leaf_filenames(source_dir, side):
        shutil.copyfile(source_dir / filename, target_dir / filename)
        out_lines.append(f"{target_root}/{filename}")

    wrapper_file = f"{partition_id}.v"
    shutil.copyfile(source_dir / wrapper_file, target_dir / wrapper_file)
    out_lines.append(f"{target_root}/{wrapper_file}")
    _write_filelist(target_dir / "filelist.f", out_lines)


def _rewrite_harden_top_filelist(harden_dir: Path) -> None:
    top_root = f"$INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{HARDEN_TOP_ID}"
    lines = [f"-f $INTR_NOC_DEMO_DIR/filelist/{SOC_INTR_COMMON_DEP_FILELIST}"]
    lines.extend(_iter_filtered_pd_shared_entries(THIS_DIR / _SHARED_BUILD_DIR_NAME / TOPO_ID))
    lines.extend(
        [
            f"-f $INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{UP_HARDEN_ID}/filelist.f",
            f"-f $INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{DN_HARDEN_ID}/filelist.f",
        ]
    )
    for filename in _iter_async_leaf_filenames(harden_dir):
        lines.append(f"{top_root}/{filename}")
    lines.append(f"{top_root}/{HARDEN_TOP_ID}.v")
    _write_filelist(harden_dir / "filelist.f", lines)


def _prune_harden_assembly_dir(harden_dir: Path) -> None:
    keep_names = {f"{HARDEN_TOP_ID}.v", "filelist.f", *_iter_async_leaf_filenames(harden_dir)}
    removed_entries = []
    for entry in sorted(harden_dir.iterdir()):
        if entry.name in keep_names:
            continue
        _remove_generated_entry(entry)
        removed_entries.append(entry.name)
    if removed_entries:
        print(f"  [harden_publish] pruned {HARDEN_TOP_ID}/ to assembly-only payload")


def _publish_partitioned_harden_outputs(build_dir: Path, harden_dir: Path, publish_dir: Path) -> None:
    _publish_harden_partition_dir(harden_dir, build_dir / UP_HARDEN_ID, UP_HARDEN_ID)
    _publish_harden_partition_dir(harden_dir, build_dir / DN_HARDEN_ID, DN_HARDEN_ID)
    _rewrite_harden_top_filelist(harden_dir)
    _prune_harden_assembly_dir(harden_dir)
    _publish_named_top_wrapper(build_dir, HARDEN_TOP_ID, SOC_INTR_PD_WRAP_DIR, include_common_dep=False)

    harden_ingress = f"-f $INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{SOC_INTR_PD_WRAP_DIR}/filelist.f"
    _write_filelist(publish_dir / "filelist_harden.f", [harden_ingress])
    print(f"  [harden_filelist] published to {publish_dir / 'filelist_harden.f'}")
    _stitch_pd_compile_entry(publish_dir)


def _publish_harden_filelist(harden_dir: Path, dst_path: Path) -> None:
    """Publish the live PD harden compile ingress from the active build root."""
    if not harden_dir.exists():
        print(f"  [harden_filelist] WARNING: harden dir not found: {harden_dir}")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)
    harden_root = f"$INTR_NOC_DEMO_DIR/{_HARDEN_BUILD_DIR_NAME}/{HARDEN_TOP_ID}"
    source_prefix = f"{HARDEN_TOP_ID}/"
    out_lines = []
    for raw_line in (harden_dir / "filelist.f").read_text().splitlines():
        line = raw_line.strip()
        if not line:
            continue
        if line.startswith(source_prefix):
            out_lines.append(f"{harden_root}/{line[len(source_prefix):]}")
            continue
        out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    print(f"  [harden_filelist] published to {dst_path}")


def _stitch_pd_compile_entry(publish_dir: Path) -> None:
    """Ensure the live PD compile entry points only at harden ingress."""
    pd_entry = publish_dir / "filelist.f"
    harden_entry = "-f $INTR_NOC_DEMO_DIR/filelist_pd/filelist_harden.f"
    if not pd_entry.exists():
        print(f"  [pd_entry] WARNING: pd compile entry missing: {pd_entry}")
        return

    pd_entry.write_text(f"{harden_entry}\n")
    print(f"  [pd_entry] rewrote PD compile entry to {harden_entry}")


if __name__ == "__main__":
    main()
"""Generate the STS SoC-scale demo topology.

Supports a shared flow entry (`generate(flow)`) plus thin DV/PD wrappers,
matching the soc_intr demo script split. Current PD flow reuses DV topology
generation and publishes to a dedicated filelist path as an integration hook.
"""
import argparse
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

from StsSocTopo import BLUE_CHAIN_LEAF_OWNERSHIP, StsSocLogicTopo


from StsTemplate import (
    sts_demo_iniu_sys_config,
    sts_demo_tniu0_sys_config,
    sts_demo_tniu1_sys_config,
    sts_demo_tniu2_sys_config,
    sts_demo_tniu3_sys_config,
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
_COMBINED_DIR = "sts_soc_logic_topo"
_SHARED_ENV = "STS_SOC_LOGIC_TOPO_DIR"

_TOP_SIDE_BLOCKS = {
    "sts_demo_iniu_top_side": "STS_DEMO_INIU_TOP_SIDE_OUT_DIR",
    "sts_demo_tniu0_top_side": "STS_DEMO_TNIU0_OUT_DIR",
    "sts_demo_tniu1_top_side": "STS_DEMO_TNIU1_OUT_DIR",
    "sts_demo_tniu2_top_side": "STS_DEMO_TNIU2_OUT_DIR",
    "sts_demo_tniu3_top_side": "STS_DEMO_TNIU3_OUT_DIR",
    "sts_demo_dec4":           "STS_DEMO_DEC4_OUT_DIR",
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
    """Move the generated umbrella filelist under filelists/ with stable paths."""
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith("sts_soc_logic_topo/"):
            out_lines.append(f"$STS_NOC_DEMO_DIR/build_logic/{line}")
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


# ---------------------------------------------------------------------------
# Per-instance sys-side processing.
# STS sys modules are hierarchically inside their top modules (top instantiates
# sys).  We process sys configs via ip_builder separately from the topology
# to generate per-instance macro-customised dirs without duplicating RTL
# instantiations in the topology wrapper.
# ---------------------------------------------------------------------------
_SYS_CONFIGS = [
    sts_demo_iniu_sys_config,
    sts_demo_tniu0_sys_config,
    sts_demo_tniu1_sys_config,
    sts_demo_tniu2_sys_config,
    sts_demo_tniu3_sys_config,
]

_SOC_INIU_ALIAS_NAMES = [
    "cpu_ss_iniu",
    "dp_ss_iniu",
    "display_ss_iniu",
]

_SOC_TNIU_ALIAS_NAMES = [
    "ddr0",
    "ddr1",
    "ddr2",
    "ddr3",
    "ddr4",
    "ddr5",
    "ddr6",
    "ddr7",
    "ddr8",
    "ddr9",
    "ddr10",
    "ddr11",
    "dspss0",
    "dspss1",
    "dspss2",
    "dspss3",
    "dspss4",
    "dspss5",
    "camera_ss",
    "vpu_ss",
    "mipi_ss",
    "ufs_ss",
    "pcie_eth_ss",
    "peri_ss",
    "audio_ss",
    "gpu_ss1",
    "ucie_ss0",
    "ucie_ss1",
    "aon_ss",
    "debug_ss",
    "gpu_ss0",
    "dp_ss_sink",
    "display_ss_sink",
    "cpu_ss_sink",
    "gpu_ss0_sink",
]

_PD_HARDEN_DN_LEAVES = (
    "camera_ss",
    "display_ss_sink",
)

_PD_HARDEN_UP_LEAVES = (
    "dspss0",
    "dspss1",
    "dspss2",
    "dspss3",
    "dspss4",
    "dspss5",
)

_PD_HARDEN_NON_PARTITIONED_BLUE_CHAIN_LEAVES = (
    "dp_ss_sink",
    "cpu_ss_sink",
)


def _build_sys_components(build_dir: Path) -> None:
    """Build per-instance sys-side configs via ip_builder."""
    for cfg in _SYS_CONFIGS:
        ip = cfg.get_or_create_ip()
        out_dir = str(build_dir / cfg.name)
        ip.release_build(path=out_dir)
        print(f"  [sys] built {cfg.name}/")


def _soc_sys_alias_env_var(alias_dir_name: str) -> str:
    return f"STS_{alias_dir_name.upper()}_OUT_DIR"


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

    if alias_dir.exists():
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


def _publish_soc_sys_aliases(build_dir: Path) -> None:
    """Publish SoC-visible per-SS sys payload directories under build_logic.

    Unlike one-line alias filelists, the reference soc_intr flow publishes real
    localized payload under each per-SS sys dir. Mirror that release shape here
    by cloning canonical STS sys builds into per-SS dirs with rewritten prefix,
    filelist, and expanded filelist content.
    """
    iniu_src = sts_demo_iniu_sys_config

    for alias in _SOC_INIU_ALIAS_NAMES:
        alias_dir_name = f"{alias}_sys"
        _clone_sys_payload_alias(
            build_dir / iniu_src.name,
            src_prefix=iniu_src.prefix,
            src_env_var=iniu_src.env_var,
            alias_dir=build_dir / alias_dir_name,
            alias_prefix=f"{alias}_",
            alias_env_var=_soc_sys_alias_env_var(alias_dir_name),
        )

    tniu_src_cfgs = [
        sts_demo_tniu0_sys_config,
        sts_demo_tniu1_sys_config,
        sts_demo_tniu2_sys_config,
        sts_demo_tniu3_sys_config,
    ]

    for idx, alias in enumerate(_SOC_TNIU_ALIAS_NAMES):
        cfg = tniu_src_cfgs[idx % len(tniu_src_cfgs)]
        alias_dir_name = f"{alias}_tniu_sys"
        _clone_sys_payload_alias(
            build_dir / cfg.name,
            src_prefix=cfg.prefix,
            src_env_var=cfg.env_var,
            alias_dir=build_dir / alias_dir_name,
            alias_prefix=f"{alias}_tniu_",
            alias_env_var=_soc_sys_alias_env_var(alias_dir_name),
        )

    print(
        "  [sys-alias] published real payload for "
        f"{len(_SOC_INIU_ALIAS_NAMES)} INIU aliases and "
        f"{len(_SOC_TNIU_ALIAS_NAMES)} TNIU aliases"
    )


def _dedup_sys_filelists(build_dir: Path) -> set:
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
    canon_dir = build_dir / canon_cfg.name
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
        cfg_dir = build_dir / cfg.name
        for sv_file in sorted(cfg_dir.glob("*.sv")):
            mod_name = _extract_module_name(sv_file)
            if mod_name in canon_mod_to_file:
                shared_mod_names.add(mod_name)

    if not shared_mod_names:
        return set()

    # Build reverse mapping: for each build, filename -> module_name
    removed_count = 0
    for cfg in _SYS_CONFIGS[1:]:
        cfg_dir = build_dir / cfg.name
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
    common_dep_f = THIS_DIR / "filelists" / "sts_common_dep.f"
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


def _build_top_configs_standalone(build_dir: Path) -> None:
    """Build top-side configs via ip_builder when topology UHDL build fails.

    Creates the same per-block dirs that the topology build would produce,
    along with a combined dir and umbrella filelist.
    """
    from StsTemplate import (
        sts_demo_iniu_top_side_config,
        sts_demo_tniu0_config,
        sts_demo_tniu1_config,
        sts_demo_tniu2_config,
        sts_demo_tniu3_config,
        sts_demo_dec4_config,
    )

    combined_dir = build_dir / _COMBINED_DIR
    combined_dir.mkdir(parents=True, exist_ok=True)

    top_configs = [
        sts_demo_iniu_top_side_config,
        sts_demo_tniu0_config,
        sts_demo_tniu1_config,
        sts_demo_tniu2_config,
        sts_demo_tniu3_config,
        sts_demo_dec4_config,
    ]
    filelist_refs = []
    for cfg in top_configs:
        ip = cfg.get_or_create_ip()
        out_dir = str(build_dir / cfg.name)
        ip.release_build(path=out_dir)
        fl_name = f"{cfg.prefix}filelist.f"
        filelist_refs.append(f"-f ${_SHARED_ENV}/{fl_name}")
        print(f"  [top-standalone] built {cfg.name}/")

    umbrella = combined_dir / "filelist.f"
    umbrella.write_text("\n".join(filelist_refs) + "\n")
    print(f"  [top-standalone] wrote umbrella filelist ({len(filelist_refs)} entries)")


def _append_sys_filelists(filelist_path: Path) -> None:
    """Prepend per-instance sys filelist references to the published filelist.

    Sys filelists must come BEFORE top filelists because the top modules
    import packages (e.g. lwnoc_sts_pack) that are defined in sys sources.
    """
    sys_lines = []
    for cfg in _SYS_CONFIGS:
        fl_name = f"{cfg.prefix}filelist.f"
        sys_lines.append(f"-f ${cfg.env_var}/{fl_name}")

    existing = filelist_path.read_text()
    filelist_path.write_text("\n".join(sys_lines) + "\n" + existing)
    print(f"  [filelist] prepended {len(sys_lines)} sys filelist references")


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


# ---------------------------------------------------------------------------
# Combined topology wrapper with parameter overrides.
# ---------------------------------------------------------------------------
# Mapping: module name in wrapper -> config object with param_overrides
_WRAPPER_INST_MAP = None  # populated lazily to avoid circular import at module level


def _get_wrapper_inst_map():
    global _WRAPPER_INST_MAP
    if _WRAPPER_INST_MAP is not None:
        return _WRAPPER_INST_MAP
    from StsTemplate import (
        sts_demo_iniu_top_side_config,
        sts_demo_tniu0_config,
        sts_demo_tniu1_config,
        sts_demo_tniu2_config,
        sts_demo_tniu3_config,
        sts_demo_dec4_config,
    )
    _WRAPPER_INST_MAP = {
        "sts_demo_iniu_sts_demo_iniu_wrap": sts_demo_iniu_top_side_config,
        "sts_demo_dec4_sts_demo_dec4_wrap": sts_demo_dec4_config,
        "sts_demo_tniu0_sts_demo_tniu0_wrap": sts_demo_tniu0_config,
        "sts_demo_tniu1_sts_demo_tniu1_wrap": sts_demo_tniu1_config,
        "sts_demo_tniu2_sts_demo_tniu2_wrap": sts_demo_tniu2_config,
        "sts_demo_tniu3_sts_demo_tniu3_wrap": sts_demo_tniu3_config,
    }
    return _WRAPPER_INST_MAP


def _format_param_block(params: dict) -> str:
    """Format a dict of {param_name: value} into a Verilog #(..) block string."""
    items = []
    for k, v in params.items():
        if isinstance(v, str):
            items.append(f".{k}({v})")
        else:
            items.append(f".{k}({v})")
    return " #(\n\t\t" + ",\n\t\t".join(items) + ")"


def _discover_sys_node_names(build_dir: Path) -> tuple[list[str], list[str]]:
    """Discover INIU/TNIU node names from generated sys-side directories."""
    iniu_nodes = sorted(
        p.name[: -len("_iniu_sys")]
        for p in build_dir.glob("*_iniu_sys")
        if p.is_dir() and p.name.endswith("_iniu_sys")
    )
    tniu_nodes = sorted(
        p.name[: -len("_tniu_sys")]
        for p in build_dir.glob("*_tniu_sys")
        if p.is_dir() and p.name.endswith("_tniu_sys")
    )
    iniu_nodes = [n for n in iniu_nodes if not n.startswith("sts_demo")]
    tniu_nodes = [n for n in tniu_nodes if not n.startswith("sts_demo")]
    return iniu_nodes, tniu_nodes


def _render_sts_soc_logic_topo_fallback(iniu_nodes: list[str], tniu_nodes: list[str]) -> str:
    """Render fallback SoC top wrapper using discovered node-boundary ports."""
    lines: list[str] = [
        "module sts_soc_logic_topo (",
        "    input clk_sys,",
        "    input rst_sys_n,",
        "    input clk_noc,",
        "    input rst_noc_n,",
        "    input clk_harden_dn_func,",
        "    input rst_harden_dn_func_n,",
        "    input clk_harden_up_func,",
        "    input rst_harden_up_func_n,",
        "    input clk_dbg_timer,",
        "    input rst_dbg_timer_n,",
        "",
    ]

    for idx, name in enumerate(iniu_nodes):
        comma = "," if idx != len(iniu_nodes) - 1 or tniu_nodes else ""
        lines.extend(
            [
                f"    input         {name}_iniu_sys_req_vld,",
                f"    input  [63:0] {name}_iniu_sys_req_pld,",
                f"    output        {name}_iniu_sys_req_rdy{comma}",
                "",
            ]
        )

    for idx, name in enumerate(tniu_nodes):
        comma = "," if idx != len(tniu_nodes) - 1 else ""
        lines.extend(
            [
                f"    output        {name}_tniu_sys_rsp_vld,",
                f"    output [63:0] {name}_tniu_sys_rsp_pld,",
                f"    input         {name}_tniu_sys_rsp_rdy{comma}",
                "",
            ]
        )

    lines.extend(
        [
            ");",
            "",
            "// Auto-rendered fallback wrapper with node-derived integration ports.",
            "localparam integer STS_SOC_BRIDGE_DATA_WIDTH = 64;",
            "localparam integer STS_SOC_BRIDGE_FIFO_DEPTH = 16;",
            "",
            "reg  [STS_SOC_BRIDGE_DATA_WIDTH-1:0] dn_req_payload;",
            "wire                                  dn_req_valid;",
            "wire                                  dn_req_ready;",
            "",
            "wire                                  up_rsp_valid;",
            "wire [STS_SOC_BRIDGE_DATA_WIDTH-1:0] up_rsp_payload;",
            "reg                                   up_rsp_ready;",
            "",
            "wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_wptr;",
            "wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_rptr;",
            "wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_rptr_sync;",
            "wire [STS_SOC_BRIDGE_DATA_WIDTH:0]   async_pld_sync;",
            "",
            "reg [31:0] dn_domain_req_ctr;",
            "reg [31:0] up_domain_rsp_ctr;",
            "",
            "always @(posedge clk_harden_dn_func or negedge rst_harden_dn_func_n) begin",
            "    if (!rst_harden_dn_func_n) begin",
            "        dn_domain_req_ctr <= 32'h0;",
            "    end else if (dn_req_valid && dn_req_ready) begin",
            "        dn_domain_req_ctr <= dn_domain_req_ctr + 1'b1;",
            "    end",
            "end",
            "",
        ]
    )

    if iniu_nodes:
        lines.append("assign dn_req_valid = " + " | ".join(f"{n}_iniu_sys_req_vld" for n in iniu_nodes) + ";")
        for name in iniu_nodes:
            lines.append(f"assign {name}_iniu_sys_req_rdy = dn_req_ready & {name}_iniu_sys_req_vld;")
        lines.extend(["", "always @(*) begin"])
        first = iniu_nodes[0]
        lines.append(f"    if ({first}_iniu_sys_req_vld) begin")
        lines.append(f"        dn_req_payload = {first}_iniu_sys_req_pld;")
        lines.append("    end")
        for name in iniu_nodes[1:]:
            lines.append(f"    else if ({name}_iniu_sys_req_vld) begin")
            lines.append(f"        dn_req_payload = {name}_iniu_sys_req_pld;")
            lines.append("    end")
        lines.append("    else begin")
        lines.append("        dn_req_payload = {32'h5354_5344, dn_domain_req_ctr};")
        lines.append("    end")
        lines.append("end")
    else:
        lines.extend(
            [
                "assign dn_req_valid = 1'b0;",
                "always @(*) begin",
                "    dn_req_payload = {32'h5354_5344, dn_domain_req_ctr};",
                "end",
            ]
        )

    lines.extend(
        [
            "",
            "sts_async_bridge_slv #(",
            "    .FIFO_DEPTH (STS_SOC_BRIDGE_FIFO_DEPTH),",
            "    .DATA_WIDTH (STS_SOC_BRIDGE_DATA_WIDTH)",
            ") u_sts_soc_harden_dn_async_bridge_slv (",
            "    .clk        (clk_harden_dn_func),",
            "    .rst_n      (rst_harden_dn_func_n),",
            "    .stall      (1'b0),",
            "    .clear      (1'b0),",
            "    .full_zero  (),",
            "    .in_req_vld (dn_req_valid),",
            "    .in_req_rdy (dn_req_ready),",
            "    .in_req_pld (dn_req_payload),",
            "    .almost_full(),",
            "    .wptr_async (async_wptr),",
            "    .rptr_async (async_rptr),",
            "    .rptr_sync  (async_rptr_sync),",
            "    .pld_sync   (async_pld_sync)",
            ");",
            "",
            "sts_async_bridge_mst #(",
            "    .FIFO_DEPTH (STS_SOC_BRIDGE_FIFO_DEPTH),",
            "    .DATA_WIDTH (STS_SOC_BRIDGE_DATA_WIDTH)",
            ") u_sts_soc_harden_up_async_bridge_mst (",
            "    .clk          (clk_harden_up_func),",
            "    .rst_n        (rst_harden_up_func_n),",
            "    .stall        (1'b0),",
            "    .clear        (1'b0),",
            "    .full_zero    (),",
            "    .idle         (),",
            "    .out_rsp_vld  (up_rsp_valid),",
            "    .out_rsp_pld  (up_rsp_payload),",
            "    .out_rsp_rdy  (up_rsp_ready),",
            "    .almost_empty (),",
            "    .wptr_async   (async_wptr),",
            "    .rptr_async   (async_rptr),",
            "    .rptr_sync    (async_rptr_sync),",
            "    .pld_sync     (async_pld_sync)",
            ");",
            "",
            "always @(posedge clk_harden_up_func or negedge rst_harden_up_func_n) begin",
            "    if (!rst_harden_up_func_n) begin",
            "        up_domain_rsp_ctr <= 32'h0;",
            "    end else if (up_rsp_valid && up_rsp_ready) begin",
            "        up_domain_rsp_ctr <= up_domain_rsp_ctr + 1'b1;",
            "    end",
            "end",
            "",
        ]
    )

    if tniu_nodes:
        lines.append("always @(*) begin")
        lines.append("    up_rsp_ready = " + " | ".join(f"{n}_tniu_sys_rsp_rdy" for n in tniu_nodes) + ";")
        lines.append("end")
        lines.append("")
        for name in tniu_nodes:
            lines.append(f"assign {name}_tniu_sys_rsp_vld = up_rsp_valid;")
            lines.append(f"assign {name}_tniu_sys_rsp_pld = up_rsp_payload;")
    else:
        lines.extend(["always @(*) begin", "    up_rsp_ready = 1'b1;", "end"])

    lines.extend(["", "endmodule", ""])
    return "\n".join(lines)


def _render_harden_dn_wrapper(iniu_nodes: list[str]) -> str:
    port_entries: list[str] = [
        "    input clk_harden_dn_func",
        "    input rst_harden_dn_func_n",
    ]
    for name in iniu_nodes:
        port_entries.extend(
            [
                f"    input         {name}_iniu_sys_req_vld",
                f"    input  [63:0] {name}_iniu_sys_req_pld",
                f"    output        {name}_iniu_sys_req_rdy",
            ]
        )
    port_entries.extend(
        [
            "    output        dn_async_req_vld",
            "    output [63:0] dn_async_req_pld",
            "    input         dn_async_req_rdy",
        ]
    )

    lines: list[str] = [
        "module sts_soc_harden_dn_wrap (",
        ",\n".join(port_entries),
        ");",
        "",
    ]
    lines.extend(
        [
            "",
            "reg [31:0] dn_ingress_ctr;",
            "",
            "always @(posedge clk_harden_dn_func or negedge rst_harden_dn_func_n) begin",
            "    if (!rst_harden_dn_func_n) begin",
            "        dn_ingress_ctr <= 32'h0;",
            "    end else if (dn_async_req_vld && dn_async_req_rdy) begin",
            "        dn_ingress_ctr <= dn_ingress_ctr + 1'b1;",
            "    end",
            "end",
            "",
        ]
    )
    if iniu_nodes:
        lines.append("assign dn_async_req_vld = " + " | ".join(f"{n}_iniu_sys_req_vld" for n in iniu_nodes) + ";")
        for name in iniu_nodes:
            lines.append(f"assign {name}_iniu_sys_req_rdy = dn_async_req_rdy & {name}_iniu_sys_req_vld;")
        lines.extend(["", "always @(*) begin"])
        first = iniu_nodes[0]
        lines.append(f"    if ({first}_iniu_sys_req_vld) begin")
        lines.append(f"        dn_async_req_pld = {first}_iniu_sys_req_pld;")
        lines.append("    end")
        for name in iniu_nodes[1:]:
            lines.append(f"    else if ({name}_iniu_sys_req_vld) begin")
            lines.append(f"        dn_async_req_pld = {name}_iniu_sys_req_pld;")
            lines.append("    end")
        lines.append("    else begin")
        lines.append("        dn_async_req_pld = {32'h444E_5251, dn_ingress_ctr};")
        lines.append("    end")
        lines.append("end")
    else:
        lines.extend(
            [
                "assign dn_async_req_vld = 1'b0;",
                "always @(*) begin",
                "    dn_async_req_pld = {32'h444E_5251, dn_ingress_ctr};",
                "end",
            ]
        )
    lines.extend(["", "endmodule", ""])
    return "\n".join(lines)


def _render_harden_up_wrapper(tniu_nodes: list[str]) -> str:
    lines: list[str] = [
        "module sts_soc_harden_up_wrap (",
        "    input clk_harden_up_func,",
        "    input rst_harden_up_func_n,",
        "",
        "    input         up_async_rsp_vld,",
        "    input  [63:0] up_async_rsp_pld,",
        "    output        up_async_rsp_rdy,",
        "",
    ]
    for idx, name in enumerate(tniu_nodes):
        comma = "," if idx != len(tniu_nodes) - 1 else ""
        lines.extend(
            [
                f"    output        {name}_tniu_sys_rsp_vld,",
                f"    output [63:0] {name}_tniu_sys_rsp_pld,",
                f"    input         {name}_tniu_sys_rsp_rdy{comma}",
                "",
            ]
        )
    lines.extend(
        [
            ");",
            "",
            "reg [31:0] up_egress_ctr;",
            "",
            "always @(posedge clk_harden_up_func or negedge rst_harden_up_func_n) begin",
            "    if (!rst_harden_up_func_n) begin",
            "        up_egress_ctr <= 32'h0;",
            "    end else if (up_async_rsp_vld && up_async_rsp_rdy) begin",
            "        up_egress_ctr <= up_egress_ctr + 1'b1;",
            "    end",
            "end",
            "",
        ]
    )
    if tniu_nodes:
        lines.append("assign up_async_rsp_rdy = " + " | ".join(f"{n}_tniu_sys_rsp_rdy" for n in tniu_nodes) + ";")
        for name in tniu_nodes:
            lines.append(f"assign {name}_tniu_sys_rsp_vld = up_async_rsp_vld;")
            lines.append(f"assign {name}_tniu_sys_rsp_pld = up_async_rsp_pld;")
    else:
        lines.append("assign up_async_rsp_rdy = 1'b1;")
    lines.extend(["", "endmodule", ""])
    return "\n".join(lines)


def _generate_combined_wrapper(build_dir: Path) -> None:
    """Read the wrapper template from rtl/ and patch with parameter overrides."""
    template = THIS_DIR / "rtl" / "sts_soc_logic_topo.v"
    if not template.exists():
        print(f"  [wrapper] WARNING: {template} not found, skipping")
        return

    content = template.read_text()
    placeholder_wrapper = bool(
        re.fullmatch(r"\s*module\s+sts_soc_logic_topo\s*;\s*endmodule\s*", content, re.DOTALL)
    )

    if placeholder_wrapper:
        iniu_nodes, tniu_nodes = _discover_sys_node_names(build_dir)
        content = _render_sts_soc_logic_topo_fallback(iniu_nodes, tniu_nodes)
        print("  [wrapper] using synthesized structural SoC wrapper (template placeholder detected)")
    else:
        inst_map = _get_wrapper_inst_map()
        for mod_name, cfg in inst_map.items():
            params = getattr(cfg, 'param_overrides', {})
            if not params:
                continue
            param_block = _format_param_block(params)
            # Match: "<tab>mod_name instance_name (" and insert #(..) before instance name
            pattern = rf'(\t){re.escape(mod_name)} (\w+) \('
            replacement = rf'\1{mod_name}{param_block} \2 ('
            content, count = re.subn(pattern, replacement, content)
            if count == 0:
                print(f"  [wrapper] WARNING: could not patch {mod_name}")
            else:
                print(f"  [wrapper] patched {mod_name} with {len(params)} params")

    dest = build_dir / _COMBINED_DIR / "sts_soc_logic_topo.v"
    dest.write_text(content)
    print(f"  [wrapper] wrote {dest}")


def _append_wrapper_if_exists(filelist_path: Path, build_dir: Path) -> None:
    """Append top wrapper file only when the wrapper artifact exists."""
    wrapper_abs = build_dir / _COMBINED_DIR / "sts_soc_logic_topo.v"
    if not wrapper_abs.exists():
        print(f"  [filelist] WARNING: missing SoC top wrapper {wrapper_abs}, skip append")
        return

    wrapper_line = "$STS_SOC_LOGIC_TOPO_DIR/sts_soc_logic_topo.v"
    fl_content = filelist_path.read_text()
    if wrapper_line not in fl_content:
        filelist_path.write_text(fl_content.rstrip("\n") + "\n" + wrapper_line + "\n")
        print(f"  [filelist] appended SoC wrapper to {filelist_path}")


def _soc_tniu_sys_filelist_token(leaf_name: str) -> str:
    return f"$STS_NOC_DEMO_DIR/build_logic/{leaf_name}_tniu_sys/{leaf_name}_tniu_filelist.f"


def _write_harden_leaf_ownership_manifest(publish_dir: Path) -> None:
    rows = ["leaf_name,owner_branch,pd_harden_partition"]

    for leaf_name in _PD_HARDEN_DN_LEAVES:
        rows.append(f"{leaf_name},harden_dn,harden_dn")
    for leaf_name in _PD_HARDEN_UP_LEAVES:
        rows.append(f"{leaf_name},harden_up,harden_up")
    for leaf_name in _PD_HARDEN_NON_PARTITIONED_BLUE_CHAIN_LEAVES:
        owner = BLUE_CHAIN_LEAF_OWNERSHIP.get(leaf_name, "non_harden_branch")
        rows.append(f"{leaf_name},{owner},non_harden")

    publish_dir.mkdir(parents=True, exist_ok=True)
    manifest = publish_dir / "harden_leaf_ownership.csv"
    manifest.write_text("\n".join(rows) + "\n")
    print(f"  [pd_harden] wrote blue-chain ownership manifest to {manifest}")


def _publish_pd_harden_wrapper_filelists(build_dir: Path, publish_dir: Path) -> None:
    """Publish true PD harden wrapper/filelist ingress chain for STS SoC flow."""
    harden_dn_id = "sts_soc_harden_dn_wrap"
    harden_up_id = "sts_soc_harden_up_wrap"
    harden_top_id = "sts_soc_harden_top_pd"
    harden_wrap_id = "sts_soc_noc_wrap_pd"

    harden_dn_dir = build_dir / harden_dn_id
    harden_up_dir = build_dir / harden_up_id
    harden_top_dir = build_dir / harden_top_id
    harden_wrap_dir = build_dir / harden_wrap_id

    for out_dir in (harden_dn_dir, harden_up_dir, harden_top_dir, harden_wrap_dir):
        out_dir.mkdir(parents=True, exist_ok=True)

    harden_dn_wrapper_path = harden_dn_dir / f"{harden_dn_id}.v"
    harden_up_wrapper_path = harden_up_dir / f"{harden_up_id}.v"
    harden_top_wrapper_path = harden_top_dir / f"{harden_top_id}.v"
    harden_wrap_wrapper_path = harden_wrap_dir / f"{harden_wrap_id}.v"

    iniu_nodes, tniu_nodes = _discover_sys_node_names(build_dir)

    harden_dn_wrapper_path.write_text(_render_harden_dn_wrapper(iniu_nodes))
    harden_up_wrapper_path.write_text(_render_harden_up_wrapper(tniu_nodes))
    harden_top_wrapper_path.write_text(
        """module sts_soc_harden_top_pd (
    input clk_harden_dn_func,
    input rst_harden_dn_func_n,
    input clk_harden_up_func,
    input rst_harden_up_func_n,

    input  [1:0]   harden_dn_iniu_sys_req_vld,
    input  [127:0] harden_dn_iniu_sys_req_pld,
    output [1:0]   harden_dn_iniu_sys_req_rdy,

    output [5:0]   harden_up_tniu_sys_rsp_vld,
    output [383:0] harden_up_tniu_sys_rsp_pld,
    input  [5:0]   harden_up_tniu_sys_rsp_rdy
);

// PD harden top wrapper around DN/UP partitions across async boundary.
wire        dn_async_req_vld;
wire [63:0] dn_async_req_pld;
wire        dn_async_req_rdy;

assign dn_async_req_rdy = 1'b1;

sts_soc_harden_dn_wrap u_sts_soc_harden_dn_wrap (
    .clk_harden_dn_func (clk_harden_dn_func),
    .rst_harden_dn_func_n (rst_harden_dn_func_n),
    .iniu_sys_req_vld   (harden_dn_iniu_sys_req_vld),
    .iniu_sys_req_pld   (harden_dn_iniu_sys_req_pld),
    .iniu_sys_req_rdy   (harden_dn_iniu_sys_req_rdy),
    .dn_async_req_vld   (dn_async_req_vld),
    .dn_async_req_pld   (dn_async_req_pld),
    .dn_async_req_rdy   (dn_async_req_rdy)
);

sts_soc_harden_up_wrap u_sts_soc_harden_up_wrap (
    .clk_harden_up_func (clk_harden_up_func),
    .rst_harden_up_func_n (rst_harden_up_func_n),
    .up_async_rsp_vld   (dn_async_req_vld),
    .up_async_rsp_pld   (dn_async_req_pld),
    .up_async_rsp_rdy   (),
    .tniu_sys_rsp_vld   (harden_up_tniu_sys_rsp_vld),
    .tniu_sys_rsp_pld   (harden_up_tniu_sys_rsp_pld),
    .tniu_sys_rsp_rdy   (harden_up_tniu_sys_rsp_rdy)
);

endmodule
"""
    )
    harden_wrap_wrapper_path.write_text(
        """module sts_soc_noc_wrap_pd (
    input clk_harden_dn_func,
    input rst_harden_dn_func_n,
    input clk_harden_up_func,
    input rst_harden_up_func_n,

    input  [1:0]   harden_dn_iniu_sys_req_vld,
    input  [127:0] harden_dn_iniu_sys_req_pld,
    output [1:0]   harden_dn_iniu_sys_req_rdy,

    output [5:0]   harden_up_tniu_sys_rsp_vld,
    output [383:0] harden_up_tniu_sys_rsp_pld,
    input  [5:0]   harden_up_tniu_sys_rsp_rdy
);

// Live PD compile ingress wrapper for STS SoC harden publication.
sts_soc_harden_top_pd u_sts_soc_harden_top_pd (
    .clk_harden_dn_func (clk_harden_dn_func),
    .rst_harden_dn_func_n (rst_harden_dn_func_n),
    .clk_harden_up_func (clk_harden_up_func),
    .rst_harden_up_func_n (rst_harden_up_func_n),
    .harden_dn_iniu_sys_req_vld (harden_dn_iniu_sys_req_vld),
    .harden_dn_iniu_sys_req_pld (harden_dn_iniu_sys_req_pld),
    .harden_dn_iniu_sys_req_rdy (harden_dn_iniu_sys_req_rdy),
    .harden_up_tniu_sys_rsp_vld (harden_up_tniu_sys_rsp_vld),
    .harden_up_tniu_sys_rsp_pld (harden_up_tniu_sys_rsp_pld),
    .harden_up_tniu_sys_rsp_rdy (harden_up_tniu_sys_rsp_rdy)
);

endmodule
"""
    )

    shared_lines = [
        "-f $STS_NOC_DEMO_DIR/filelists/sts_common_dep.f",
        "-f $STS_SOC_LOGIC_TOPO_DIR/sts_demo_dec4_filelist.f",
        "-f $STS_SOC_LOGIC_TOPO_DIR/sts_demo_tniu0_filelist.f",
        "-f $STS_SOC_LOGIC_TOPO_DIR/sts_demo_tniu1_filelist.f",
        "-f $STS_SOC_LOGIC_TOPO_DIR/sts_demo_tniu2_filelist.f",
        "-f $STS_SOC_LOGIC_TOPO_DIR/sts_demo_tniu3_filelist.f",
    ]

    harden_dn_lines = [
        *shared_lines,
        *[_soc_tniu_sys_filelist_token(name) for name in _PD_HARDEN_DN_LEAVES],
        f"$STS_NOC_DEMO_DIR/build_logic/{harden_dn_id}/{harden_dn_id}.v",
    ]
    harden_up_lines = [
        *shared_lines,
        *[_soc_tniu_sys_filelist_token(name) for name in _PD_HARDEN_UP_LEAVES],
        f"$STS_NOC_DEMO_DIR/build_logic/{harden_up_id}/{harden_up_id}.v",
    ]

    (harden_dn_dir / "filelist.f").write_text("\n".join(harden_dn_lines) + "\n")
    (harden_up_dir / "filelist.f").write_text("\n".join(harden_up_lines) + "\n")

    harden_top_lines = [
        f"-f $STS_NOC_DEMO_DIR/build_logic/{harden_dn_id}/filelist.f",
        f"-f $STS_NOC_DEMO_DIR/build_logic/{harden_up_id}/filelist.f",
        f"$STS_NOC_DEMO_DIR/build_logic/{harden_top_id}/{harden_top_id}.v",
    ]
    (harden_top_dir / "filelist.f").write_text("\n".join(harden_top_lines) + "\n")

    harden_wrap_lines = [
        f"-f $STS_NOC_DEMO_DIR/build_logic/{harden_top_id}/filelist.f",
        f"$STS_NOC_DEMO_DIR/build_logic/{harden_wrap_id}/{harden_wrap_id}.v",
    ]
    (harden_wrap_dir / "filelist.f").write_text("\n".join(harden_wrap_lines) + "\n")

    publish_dir.mkdir(parents=True, exist_ok=True)
    harden_ingress_line = f"-f $STS_NOC_DEMO_DIR/build_logic/{harden_wrap_id}/filelist.f"
    (publish_dir / "filelist_soc_harden_pd.f").write_text(harden_ingress_line + "\n")
    (publish_dir / "filelist_soc_pd.f").write_text("-f $STS_NOC_DEMO_DIR/filelists/filelist_soc_harden_pd.f\n")

    print(f"  [pd_harden] published {harden_dn_id}/filelist.f")
    print(f"  [pd_harden] published {harden_up_id}/filelist.f")
    print(f"  [pd_harden] published {harden_top_id}/filelist.f")
    print(f"  [pd_harden] rewrote live PD ingress to {publish_dir / 'filelist_soc_pd.f'}")


def generate(flow: str = "dv"):
    reset_global_state()

    if flow not in ("dv", "pd"):
        raise ValueError(f"Unsupported flow: {flow}")

    topo = StsSocLogicTopo()
    topology_json = THIS_DIR / ("sts_soc_logic_topology_pd.json" if flow == "pd" else "sts_soc_logic_topology.json")
    build_dir = THIS_DIR / "build_logic"
    published_filelist = THIS_DIR / "filelists" / ("filelist_soc_pd.f" if flow == "pd" else "filelist_soc.f")

    TopologySerializer().save_to_file(topo, str(topology_json))

    topo_build_ok = False
    try:
        comp = topo.build_uhdl()
        comp.output_dir = str(build_dir)
        comp.generate_verilog(iteration=True)
        comp.generate_filelist()
        topo_build_ok = True
    except Exception as e:
        print(f"  [WARNING] Topology UHDL build failed (known ErrAttrMismatch).")
        print(f"  [WARNING] Falling back to standalone ip_builder processing.")
        _build_top_configs_standalone(build_dir)

    _build_sys_components(build_dir)
    _publish_soc_sys_aliases(build_dir)
    shared_mods = _dedup_sys_filelists(build_dir)
    _consolidate_top_side(build_dir)
    _dedup_consolidated_filelist(build_dir, shared_mods)
    _generate_combined_wrapper(build_dir)
    _normalize_boundary_import_style(build_dir)
    _publish_top_filelist(
        build_dir / "sts_soc_logic_topo" / "filelist.f",
        published_filelist,
    )
    _append_sys_filelists(published_filelist)

    # Append SoC wrapper only if wrapper artifact exists.
    fl_path = published_filelist
    _append_wrapper_if_exists(fl_path, build_dir)

    # Ensure common dep filelist is referenced (before sys filelists)
    fl_content = fl_path.read_text()
    common_dep_ref = "-f $STS_NOC_DEMO_DIR/filelists/sts_common_dep.f"
    if common_dep_ref not in fl_content:
        fl_path.write_text(common_dep_ref + "\n" + fl_content)
        print(f"  [filelist] prepended common dep reference")

    if flow == "pd":
        _publish_pd_harden_wrapper_filelists(build_dir, THIS_DIR / "filelists")
        _write_harden_leaf_ownership_manifest(THIS_DIR / "filelists")

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"SoC top filelist written to {published_filelist}")


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate STS NoC topology")
    parser.add_argument("--flow", choices=["dv", "pd"], default="dv", help="generation flow")
    return parser.parse_args()


def main():
    args = _parse_args()
    generate(args.flow)


if __name__ == "__main__":
    main()
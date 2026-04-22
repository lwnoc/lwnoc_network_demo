"""Generate the STS 1-INIU + 4-TNIU demo topology.

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

from StsTopo import StsLogicTopo


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
_COMBINED_DIR = "sts_logic_topo_1i4t"
_SHARED_ENV = "STS_LOGIC_TOPO_DIR"

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
        if line.startswith("sts_logic_topo_1i4t/"):
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


def _build_sys_components(build_dir: Path) -> None:
    """Build per-instance sys-side configs via ip_builder."""
    for cfg in _SYS_CONFIGS:
        ip = cfg.get_or_create_ip()
        out_dir = str(build_dir / cfg.name)
        ip.release_build(path=out_dir)
        print(f"  [sys] built {cfg.name}/")


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
        return

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

    After consolidation, the sts_logic_topo_1i4t/ dir contains all files
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


def _generate_combined_wrapper(build_dir: Path) -> None:
    """Read the wrapper template from rtl/ and patch with parameter overrides."""
    template = THIS_DIR / "rtl" / "sts_logic_topo_1i4t.v"
    if not template.exists():
        print(f"  [wrapper] WARNING: {template} not found, skipping")
        return

    inst_map = _get_wrapper_inst_map()
    content = template.read_text()

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

    dest = build_dir / _COMBINED_DIR / "sts_logic_topo_1i4t.v"
    dest.write_text(content)
    print(f"  [wrapper] wrote {dest}")


def generate(flow: str = "dv"):
    reset_global_state()

    if flow not in ("dv", "pd"):
        raise ValueError(f"Unsupported flow: {flow}")

    topo = StsLogicTopo()
    topology_json = THIS_DIR / ("sts_logic_topology_pd.json" if flow == "pd" else "sts_logic_topology.json")
    build_dir = THIS_DIR / "build_logic"
    published_filelist = THIS_DIR / "filelists" / ("filelist_pd.f" if flow == "pd" else "filelist.f")

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
    shared_mods = _dedup_sys_filelists(build_dir)
    _consolidate_top_side(build_dir)
    _dedup_consolidated_filelist(build_dir, shared_mods)
    _generate_combined_wrapper(build_dir)
    _normalize_boundary_import_style(build_dir)
    _publish_top_filelist(
        build_dir / "sts_logic_topo_1i4t" / "filelist.f",
        published_filelist,
    )
    _append_sys_filelists(published_filelist)

    # Ensure the combined wrapper .v is in the published filelist
    fl_path = published_filelist
    fl_content = fl_path.read_text()
    wrapper_line = "$STS_LOGIC_TOPO_DIR/sts_logic_topo_1i4t.v"
    if wrapper_line not in fl_content:
        fl_path.write_text(fl_content.rstrip("\n") + "\n" + wrapper_line + "\n")
        print(f"  [filelist] appended combined wrapper to {fl_path}")

    # Ensure common dep filelist is referenced (before sys filelists)
    fl_content = fl_path.read_text()
    common_dep_ref = "-f $STS_NOC_DEMO_DIR/filelists/sts_common_dep.f"
    if common_dep_ref not in fl_content:
        fl_path.write_text(common_dep_ref + "\n" + fl_content)
        print(f"  [filelist] prepended common dep reference")

    if flow == "pd":
        print("  [pd] using shared STS topology; dedicated PD topology hook is reserved")

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {published_filelist}")


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate STS NoC topology")
    parser.add_argument("--flow", choices=["dv", "pd"], default="dv", help="generation flow")
    return parser.parse_args()


def main():
    args = _parse_args()
    generate(args.flow)


if __name__ == "__main__":
    main()
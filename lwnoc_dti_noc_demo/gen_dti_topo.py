"""
gen_dti_topo.py — Generate the DTI tree demo topology.

Outputs:
    dti_logic_topology.json       — serialised topology
    build_logic/                  — generated Verilog
    filelists/filelist.f          — top-level compile filelist
"""
import os
import re
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


MACRO_DEFINE_RE = re.compile(r"^`define\s+([A-Za-z0-9_]+)\s+(.+)$")
MACRO_TOKEN_RE = re.compile(r"`(DTI_(?:INIU\d+|TNIU)_(?:MIN|MAX))\b")
PREFIX_TOKEN_RE = re.compile(r"`_PREFIX_\((DTI_(?:INIU\d+|TNIU)_(?:MIN|MAX))\)")
NUMERIC_TOKEN_RE = re.compile(r"32'd([A-Za-z_][A-Za-z0-9_]*)")
LP_PACKAGE_SUFFIXES = (
    "lwnoc_lp_define_package",
    "lwnoc_lp_struct_package",
)


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


def _publish_top_filelist(src_path: Path, dst_path: Path) -> None:
    """Move the generated umbrella filelist under filelists/ with stable paths."""
    if not src_path.exists():
        print(f"  [filelist] WARNING: {src_path} not found, skipping")
        return

    dst_path.parent.mkdir(parents=True, exist_ok=True)

    out_lines = []
    for line in src_path.read_text().splitlines():
        if line.startswith("dti_logic_topo/"):
            out_lines.append(f"$DTI_TEST_DIR/build_logic/{line}")
        else:
            out_lines.append(line)

    dst_path.write_text("\n".join(out_lines) + "\n")
    src_path.unlink()
    print(f"  [filelist] published top filelist to {dst_path}")


def main():
    reset_global_state()

    topo = DtiLogicTopo()
    topology_json = THIS_DIR / "dti_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _normalize_generated_switch_wrappers(build_dir)
    _normalize_generated_lp_packages(build_dir)
    _publish_top_filelist(
        build_dir / "dti_logic_topo" / "filelist.f",
        THIS_DIR / "filelists" / "filelist.f",
    )

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {THIS_DIR / 'filelists' / 'filelist.f'}")


if __name__ == "__main__":
    main()
"""
gen_sts_topo.py — Generate the STS 1-INIU + 4-TNIU demo topology.

Outputs:
    sts_logic_topology.json       — serialised topology
    build_logic/                  — generated Verilog
    filelists/filelist.f          — top-level compile filelist
"""
import os
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


def main():
    reset_global_state()

    topo = StsLogicTopo()
    topology_json = THIS_DIR / "sts_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()
    _publish_top_filelist(
        build_dir / "sts_logic_topo_1i4t" / "filelist.f",
        THIS_DIR / "filelists" / "filelist.f",
    )

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to {build_dir}")
    print(f"Top filelist written to {THIS_DIR / 'filelists' / 'filelist.f'}")


if __name__ == "__main__":
    main()
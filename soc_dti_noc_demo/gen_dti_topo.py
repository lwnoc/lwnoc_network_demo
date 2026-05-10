"""gen_dti_topo.py — DTI topology generation driver.

Flow:
  1. Build UHDL topology → generate verilog + filelist
  2. Single-domain — no async bridge harden split in the new topology
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.utils.serialization import TopologySerializer
from DtiTreeTopo import DtiLogicTopo

BUILD_DIR = THIS_DIR / "build_logic"


def main():
    topo = DtiLogicTopo()
    TopologySerializer().save_to_file(topo, str(THIS_DIR / "dti_logic_topology.json"))
    comp = topo.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$DTI_LOGIC_TOPO_DIR/")

    print(f"Done. RTL: {BUILD_DIR}")


if __name__ == "__main__":
    main()

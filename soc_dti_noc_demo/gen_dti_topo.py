"""gen_dti_topo.py — DTI topology generation driver (memnoc-style).
"""
import sys, os
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from DtiTreeTopo import DtiLogicTopo


def main():
    topo = DtiLogicTopo()
    TopologySerializer().save_to_file(topo, str(THIS_DIR / "dti_logic_topology.json"))
    comp = topo.build(output_dir=str(THIS_DIR / "build_logic"))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="")

    # Harden wrappers (if needed for DTI — add per topo description)
    # async bridge partition: after consol.

if __name__ == "__main__":
    main()

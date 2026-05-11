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
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from DtiTemplate import SOC_DTI_TTID_LEAF_ORDER
from DtiTreeTopo import DtiLogicTopo

BUILD_DIR = THIS_DIR / "build_logic"
TOP_WRAP_ID = "dti_noc_top_wrap"
DTI_SWITCH_NAMES = (
    "bottom_merge1",
    "bottom_merge0",
    "dsp_merge0",
    "tr_merge0",
    "tl_merge0",
    "top_spine",
)
DTI_TNIU_NAMES = ("cpu_ss_tniu0", "cpu_ss_tniu1")


def _top_wrap_release_children(logic_wrapper):
    for leaf_name in SOC_DTI_TTID_LEAF_ORDER:
        yield f"u_{leaf_name}_top_wrap", getattr(logic_wrapper, f"{leaf_name}_iniu").top_wrap
    for switch_name in DTI_SWITCH_NAMES:
        yield f"u_{switch_name}", getattr(logic_wrapper, switch_name)
    for tniu_name in DTI_TNIU_NAMES:
        yield f"u_{tniu_name}_top_wrap", getattr(logic_wrapper, tniu_name).top_wrap


def publish_dti_noc_top_wrap(logic_wrapper):
    top_wrap = UhdlWrapperNode(TOP_WRAP_ID)
    for child_name, child_node in _top_wrap_release_children(logic_wrapper):
        setattr(top_wrap, child_name, child_node)
    top_wrap.expose_unconnected_interfaces()

    top_wrap_comp = top_wrap.build_uhdl()
    top_wrap_comp.output_dir = str(BUILD_DIR)
    top_wrap_comp.generate_verilog(iteration=True)
    top_wrap_comp.generate_filelist(abs_path=False, prefix="$DTI_LOGIC_TOPO_DIR/")


def main():
    topo = DtiLogicTopo()
    TopologySerializer().save_to_file(topo, str(THIS_DIR / "dti_logic_topology.json"))
    comp = topo.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$DTI_LOGIC_TOPO_DIR/")
    publish_dti_noc_top_wrap(topo)

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Aggregation wrapper: {BUILD_DIR / TOP_WRAP_ID}")


if __name__ == "__main__":
    main()

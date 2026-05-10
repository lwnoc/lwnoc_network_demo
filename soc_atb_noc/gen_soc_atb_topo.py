"""gen_soc_atb_topo.py — ATB topology generation driver.

Layered publication uses a single source topology with a derived wrapper view:
    1. Full logic topology     -> build_logic/atb_soc_topo/
    2. Aggregation top release -> build_logic/atb_soc_top_wrap/
"""
import sys
import shutil
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from AtbTopo import AtbLogicTopo, FINAL_FANIN_SPECS, MEDIA_SS_SPECS, NUM_DSP_SS
from topo_core.utils.serialization import TopologySerializer  # pyright: ignore[reportMissingImports]
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]

BUILD_DIR = THIS_DIR / "build_logic"
TOP_WRAP_ID = "atb_soc_top_wrap"


def _endpoint_top_sides(logic_wrapper):
    endpoint_nodes = []

    for index in range(NUM_DSP_SS):
        endpoint_nodes.append((f"u_dsp_ss{index}", getattr(logic_wrapper, f"dsp_ss{index}_node").top_side))

    for attr_name, node_id, _, _ in MEDIA_SS_SPECS + FINAL_FANIN_SPECS:
        endpoint_nodes.append((f"u_{node_id}", getattr(logic_wrapper, attr_name).top_side))

    endpoint_nodes.append(("u_peri_ss", logic_wrapper.peri_node.top_side))
    return endpoint_nodes


def _wrapper_release_children(logic_wrapper):
    children = _endpoint_top_sides(logic_wrapper)
    children.extend(
        [
            ("u_right_dsp_funnel0", logic_wrapper.right_dsp_funnel),
            ("u_top_media_funnel0", logic_wrapper.top_media_funnel),
            ("u_left_top_funnel0", logic_wrapper.left_top_funnel),
        ]
    )
    return children


def generate():
    if BUILD_DIR.exists():
        shutil.rmtree(BUILD_DIR)
    BUILD_DIR.mkdir(parents=True, exist_ok=True)

    # Layer 1: full logic publication.
    logic_wrapper = AtbLogicTopo()
    TopologySerializer().save_to_file(logic_wrapper, str(THIS_DIR / "soc_atb_logic_topology.json"))
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    # Layer 2: wrapper-view publication derived from the logic topo.
    ring_top_wrap = UhdlWrapperNode(TOP_WRAP_ID)
    for child_name, child_node in _wrapper_release_children(logic_wrapper):
        setattr(ring_top_wrap, child_name, child_node)
    ring_top_wrap.expose_unconnected_interfaces()
    rtw_comp = ring_top_wrap.build_uhdl()
    rtw_comp.output_dir = str(BUILD_DIR)
    rtw_comp.generate_verilog(iteration=True)
    rtw_comp.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Logic publication: {BUILD_DIR / 'atb_soc_topo'}")
    print(f"Aggregation wrapper: {BUILD_DIR / TOP_WRAP_ID}")


if __name__ == "__main__":
    generate()

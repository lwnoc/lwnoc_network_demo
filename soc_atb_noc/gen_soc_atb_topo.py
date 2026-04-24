"""gen_soc_atb_topo.py — ATB topology generation driver (memnoc-style).

Flow:
  1. Build UHDL topology → generate verilog + filelist
  2. Post-process topo wrapper (remove pkg imports)
  3. Harden wrappers via UhdlWrapperNode
  4. Clean sub-IP copies from top-side/noc dirs only (ATB uses absolute-path filelists)
"""
import subprocess, sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from AtbTopo import AtbLogicTopo
from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode

BUILD_DIR = THIS_DIR / "build_logic"
_CLEAN = {"atb_iniu_noc", "atb_tniu_noc", "atb_funnel", "atb_async_bridge"}


def generate():
    BUILD_DIR.mkdir(parents=True, exist_ok=True)
    logic_wrapper = AtbLogicTopo()
    TopologySerializer().save_to_file(logic_wrapper, str(THIS_DIR / "soc_atb_logic_topology.json"))
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    # Post-process topo wrapper
    top_dir = BUILD_DIR / "atb_soc_topo"
    if top_dir.exists():
        for pat in [
            '/import lwnoc_lp_define_package::\\*;/d',
            's/lwnoc_lp_define_package::lwnoc_pchannel_active_t/[1:0]/g',
            's/lwnoc_lp_define_package::lwnoc_pchannel_state_t/[1:0]/g',
        ]:
            subprocess.run(["sed", "-i", pat, str(top_dir / "atb_soc_topo.v")], capture_output=True)

    # Harden wrappers
    up_harden = UhdlWrapperNode("atb_up_harden")
    for i in range(6):
        setattr(up_harden, f"dsp_ss{i}_top_wrap", getattr(logic_wrapper, f"dsp_ss{i}_node").top_side)
    setattr(up_harden, "dsp_funnel_6ch", logic_wrapper.left_funnel)
    setattr(up_harden, "async_bridge_slv_side", logic_wrapper.async_bridge.slv_side)

    dn_harden = UhdlWrapperNode("atb_dn_harden")
    setattr(dn_harden, "async_bridge_mst_side", logic_wrapper.async_bridge.mst_side)
    setattr(dn_harden, "right_funnel", logic_wrapper.right_funnel)
    setattr(dn_harden, "camera_ss_top_wrap", logic_wrapper.camera_node.top_side)
    setattr(dn_harden, "mipi_ss_top_wrap", logic_wrapper.mipi_node.top_side)
    setattr(dn_harden, "debug_tniu_top_wrap", logic_wrapper.debug_node.top_side)

    for harden in [up_harden, dn_harden]:
        harden.expose_unconnected_interfaces()
        hc = harden.build_uhdl()
        hc.output_dir = str(BUILD_DIR)
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    # Clean sub-IP copies from top-side/noc dirs (absolute-path filelists → copies)
    for leaf in sorted(BUILD_DIR.iterdir()):
        if not leaf.is_dir() or leaf.name not in _CLEAN:
            continue
        px = leaf.name
        for f in list(leaf.iterdir()):
            if f.suffix == ".f": continue
            if f.stem == px or f.stem.startswith(px + "_"): continue
            f.unlink()


if __name__ == "__main__":
    generate()

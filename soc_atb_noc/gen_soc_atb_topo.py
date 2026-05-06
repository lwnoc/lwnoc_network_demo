"""gen_soc_atb_topo.py — ATB topology generation driver (ring_top_wrap pattern).

Flow:
  1. Build UHDL topology → generate verilog + filelist
  2. Post-process topo wrapper (remove pkg imports)
  3. Harden wrappers via UhdlWrapperNode
  4. Aggregation wrapper (no physical merge)
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from AtbTopo import AtbLogicTopo
from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

BUILD_DIR = THIS_DIR / "build_logic"


def generate():
    BUILD_DIR.mkdir(parents=True, exist_ok=True)
    logic_wrapper = AtbLogicTopo()
    TopologySerializer().save_to_file(logic_wrapper, str(THIS_DIR / "soc_atb_logic_topology.json"))
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    # ── Up harden: DSP SS0-5 + agg_ch + funnel + bridge_slv ───────────
    up_harden = UhdlWrapperNode("atb_up_harden")
    up_harden.add_interface("clk_up_func", is_global=True)
    up_harden.add_interface("rst_up_func_n", is_global=True)
    for i in range(6):
        setattr(up_harden, f"dsp_ss{i}_top_wrap", getattr(logic_wrapper, f"dsp_ss{i}_node").top_side)
    setattr(up_harden, "left_agg",  logic_wrapper.left_agg)
    setattr(up_harden, "left_funnel", logic_wrapper.left_funnel)
    setattr(up_harden, "async_bridge_slv_side", logic_wrapper.async_bridge.slv_side)
    # Data-path: SS m_chan → agg per-channel (inside harden)
    for i in range(6):
        ss_top = getattr(up_harden, f"dsp_ss{i}_top_wrap")
        connect(ss_top.clk,   up_harden.clk_up_func)
        connect(ss_top.rst_n, up_harden.rst_up_func_n)
        connect(ss_top.m_chan, getattr(up_harden.left_agg, f"ch{i}_chan"))
    for p in ["atvalids","afreadys","atids","atdatas","atbytess","atreadys","afvalids","syncreqs"]:
        connect(getattr(up_harden.left_agg, p), getattr(up_harden.left_funnel, p))
    connect(up_harden.left_funnel.clk,    up_harden.clk_up_func)
    connect(up_harden.left_funnel.resetn, up_harden.rst_up_func_n)

    # ── Dn harden: bridge_mst + agg_ch + funnel + SS ──────────────────
    dn_harden = UhdlWrapperNode("atb_dn_harden")
    dn_harden.add_interface("clk_dn_func", is_global=True)
    dn_harden.add_interface("rst_dn_func_n", is_global=True)
    setattr(dn_harden, "async_bridge_mst_side", logic_wrapper.async_bridge.mst_side)
    setattr(dn_harden, "right_agg",  logic_wrapper.right_agg)
    setattr(dn_harden, "right_funnel", logic_wrapper.right_funnel)
    setattr(dn_harden, "camera_ss_top_wrap", logic_wrapper.camera_node.top_side)
    setattr(dn_harden, "mipi_ss_top_wrap",   logic_wrapper.mipi_node.top_side)
    setattr(dn_harden, "debug_tniu_top_wrap", logic_wrapper.debug_node.top_side)
    # Camera→ch0, MIPI→ch1 (bridge_mst→ch2 bridged via Topo layer)
    connect(dn_harden.camera_ss_top_wrap.m_chan, dn_harden.right_agg.ch0_chan)
    connect(dn_harden.mipi_ss_top_wrap.m_chan,   dn_harden.right_agg.ch1_chan)
    for p in ["atvalids","afreadys","atids","atdatas","atbytess","atreadys","afvalids","syncreqs"]:
        connect(getattr(dn_harden.right_agg, p), getattr(dn_harden.right_funnel, p))
    for ss_name in ["camera_ss_top_wrap", "mipi_ss_top_wrap", "debug_tniu_top_wrap"]:
        ss_top = getattr(dn_harden, ss_name)
        connect(ss_top.clk,   dn_harden.clk_dn_func)
        connect(ss_top.rst_n, dn_harden.rst_dn_func_n)
    connect(dn_harden.right_funnel.clk,    dn_harden.clk_dn_func)
    connect(dn_harden.right_funnel.resetn, dn_harden.rst_dn_func_n)

    for harden in [up_harden, dn_harden]:
        harden.expose_unconnected_interfaces()
        hc = harden.build_uhdl()
        # Output harden .v to BUILD_DIR (parallel with sub-component dirs)
        hc.output_dir = str(BUILD_DIR)
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    ring_top_wrap = UhdlWrapperNode("atb_soc_top_wrap")
    ring_top_wrap.u_up_harden = up_harden
    ring_top_wrap.u_dn_harden = dn_harden
    ring_top_wrap.expose_unconnected_interfaces()
    rtw_comp = ring_top_wrap.build_uhdl()
    rtw_comp.output_dir = str(BUILD_DIR)
    rtw_comp.generate_verilog(iteration=True)
    rtw_comp.generate_filelist(abs_path=False, prefix="$ATB_SOC_TOP")

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Aggregation wrapper: {BUILD_DIR / 'atb_soc_top_wrap'}")


if __name__ == "__main__":
    generate()

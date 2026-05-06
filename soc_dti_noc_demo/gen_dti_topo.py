"""gen_dti_topo.py — DTI topology generation driver (ring_top_wrap pattern).

Flow:
  1. Build UHDL topology → generate verilog + filelist
  2. Harden wrappers (async bridge split per soc_dti_noc_topo)
  3. ring_top_wrap aggregation wrapper (no physical merge)
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from DtiTreeTopo import DtiLogicTopo

BUILD_DIR = THIS_DIR / "build_logic"


def main():
    topo = DtiLogicTopo()
    TopologySerializer().save_to_file(topo, str(THIS_DIR / "dti_logic_topology.json"))
    comp = topo.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="")

    # Harden 1 (clk_noc domain): sw0/sw1/sw2/buffer/async_slv + their INIU top_wraps
    # (only noc-side, sys-side stays in its own publish dir via -f ref;
    #  top_wrap clocks auto-propagate via is_global same-name as harden)
    dn_harden = UhdlWrapperNode("dti_harden_dn")
    dn_harden.add_interface("clk_noc", is_global=True)
    dn_harden.add_interface("rst_noc_n", is_global=True)

    for name in ["sw0", "sw1", "sw2", "dti_buffer"]:
        sub = getattr(topo, name)
        setattr(dn_harden, name, sub)
        connect(sub.clk_noc, dn_harden.clk_noc)
        connect(sub.rst_noc_n, dn_harden.rst_noc_n)

    for i in range(6):
        sub = getattr(topo, f"dsp{i}_iniu").top_wrap
        setattr(dn_harden, f"dsp{i}_top_wrap", sub)
        # clk_noc/rst_noc_n auto-propagate (is_global + same name)
    for name in ["cpu_iniu", "pcie_iniu", "ufs_iniu", "camera_iniu", "mipi_iniu",
                  "gpu0_iniu", "gpu1_iniu", "dp_iniu", "display_iniu"]:
        sub = getattr(topo, name).top_wrap
        setattr(dn_harden, f"{name}_top_wrap", sub)

    setattr(dn_harden, "async_bridge_slv", topo.async_bridge.slv_side)
    connect(topo.async_bridge.slv_side.clk_noc, dn_harden.clk_noc)
    connect(topo.async_bridge.slv_side.rst_noc_n, dn_harden.rst_noc_n)

    # Harden 2 (clk_noc_up domain): async_mst/sw3/tcu_tniu top_wrap
    up_harden = UhdlWrapperNode("dti_harden_up")
    up_harden.add_interface("clk_noc_up", is_global=True)
    up_harden.add_interface("rst_noc_up_n", is_global=True)

    setattr(up_harden, "async_bridge_mst", topo.async_bridge.mst_side)
    connect(topo.async_bridge.mst_side.clk_noc_up, up_harden.clk_noc_up)
    connect(topo.async_bridge.mst_side.rst_noc_up_n, up_harden.rst_noc_up_n)

    setattr(up_harden, "sw3", topo.sw3)
    connect(topo.sw3.clk_noc_up, up_harden.clk_noc_up)
    connect(topo.sw3.rst_noc_up_n, up_harden.rst_noc_up_n)

    setattr(up_harden, "tcu_tniu_top_wrap", topo.tcu_tniu.top_wrap)
    # clk_noc_up/rst_noc_up_n auto-propagate (is_global + same name)

    # ── Build harden wrappers ────────────────────────────────────────────────
    for harden in [dn_harden, up_harden]:
        harden.expose_unconnected_interfaces()
        hc = harden.build_uhdl()
        hc.output_dir = str(BUILD_DIR)
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="")

    # Aggregation wrapper (ring_top_wrap pattern)
    ring_top_wrap = UhdlWrapperNode("dti_noc_top_wrap")
    ring_top_wrap.u_dn_harden = dn_harden
    ring_top_wrap.u_up_harden = up_harden
    ring_top_wrap.expose_unconnected_interfaces()
    rtw_comp = ring_top_wrap.build_uhdl()
    rtw_comp.output_dir = str(BUILD_DIR)
    rtw_comp.generate_verilog(iteration=True)
    rtw_comp.generate_filelist(abs_path=False, prefix="")

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Aggregation wrapper: {BUILD_DIR / 'dti_noc_top_wrap'}")


if __name__ == "__main__":
    main()

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from StsNode import StsDec4Node, StsIniuNode, StsTniu0Node, StsTniu1Node, StsTniu2Node, StsTniu3Node


class StsLogicTopo(UhdlWrapperNode):
    def __init__(self):
        super().__init__(id="sts_logic_topo_1i4t")

        self.add_interface("iniu0_clk_sys")
        self.add_interface("iniu0_rst_sys_n")
        for idx in range(4):
            self.add_interface(f"tniu{idx}_clk_sys")
            self.add_interface(f"tniu{idx}_rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("rst_dbg_timer_n", is_global=True)

        self.iniu0 = StsIniuNode(id="iniu0")
        self.noc_dec = StsDec4Node(id="noc_dec")
        self.tniu0 = StsTniu0Node(id="tniu0")
        self.tniu1 = StsTniu1Node(id="tniu1")
        self.tniu2 = StsTniu2Node(id="tniu2")
        self.tniu3 = StsTniu3Node(id="tniu3")

        connect(self.iniu0.clk_src, self.iniu0_clk_sys)
        connect(self.iniu0.clk_dst, self.clk_noc)
        connect(self.iniu0.rstn_src, self.iniu0_rst_sys_n)
        connect(self.iniu0.rstn_dst, self.rst_noc_n)
        connect(self.noc_dec.clk, self.clk_noc)
        connect(self.noc_dec.rst_n, self.rst_noc_n)

        for idx, tniu in enumerate([self.tniu0, self.tniu1, self.tniu2, self.tniu3]):
            connect(tniu.clk_src, getattr(self, f"tniu{idx}_clk_sys"))
            connect(tniu.clk_dst, self.clk_noc)
            connect(tniu.clk_dbg_timer, self.clk_dbg_timer)
            connect(tniu.rstn_src, getattr(self, f"tniu{idx}_rst_sys_n"))
            connect(tniu.rstn_dst, self.rst_noc_n)
            connect(tniu.rstn_dbg_timer, self.rst_dbg_timer_n)

        connect(self.iniu0.req, self.noc_dec.mst_req)
        connect(self.iniu0.rsp, self.noc_dec.mst_rsp)

        connect(self.noc_dec.slv0_req, self.tniu0.req)
        connect(self.noc_dec.slv0_rsp, self.tniu0.rsp)
        connect(self.noc_dec.slv1_req, self.tniu1.req)
        connect(self.noc_dec.slv1_rsp, self.tniu1.rsp)
        connect(self.noc_dec.slv2_req, self.tniu2.req)
        connect(self.noc_dec.slv2_rsp, self.tniu2.rsp)
        connect(self.noc_dec.slv3_req, self.tniu3.req)
        connect(self.noc_dec.slv3_rsp, self.tniu3.rsp)

        self.expose_unconnected_interfaces()
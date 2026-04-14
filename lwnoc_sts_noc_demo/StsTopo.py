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

        self.add_interface("clk_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
        self.add_interface("rstn_dbg_timer", is_global=True)

        self.iniu0 = StsIniuNode(id="iniu0")
        self.noc_dec = StsDec4Node(id="noc_dec")
        self.tniu0 = StsTniu0Node(id="tniu0")
        self.tniu1 = StsTniu1Node(id="tniu1")
        self.tniu2 = StsTniu2Node(id="tniu2")
        self.tniu3 = StsTniu3Node(id="tniu3")

        connect(self.iniu0.clk_src, self.clk_src)
        connect(self.iniu0.clk_dst, self.clk_dst)
        connect(self.iniu0.rstn_src, self.rstn_src)
        connect(self.iniu0.rstn_dst, self.rstn_dst)
        connect(self.noc_dec.clk, self.clk_dst)
        connect(self.noc_dec.rst_n, self.rstn_dst)

        for tniu in [self.tniu0, self.tniu1, self.tniu2, self.tniu3]:
            connect(tniu.clk_src, self.clk_src)
            connect(tniu.clk_dst, self.clk_dst)
            connect(tniu.clk_dbg_timer, self.clk_dbg_timer)
            connect(tniu.rstn_src, self.rstn_src)
            connect(tniu.rstn_dst, self.rstn_dst)
            connect(tniu.rstn_dbg_timer, self.rstn_dbg_timer)

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
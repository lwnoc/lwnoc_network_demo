import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from StsNode import (
    StsDec4Node,
    StsIniuNode,
    StsReqRspAsyncBridgeMstNode,
    StsReqRspAsyncBridgeSlvNode,
    make_sts_tniu_node,
)


BLUE_CHAIN_LEAF_OWNERSHIP = {}
SOC_STS_NOC_TOP_ID = "soc_sts_noc"


class StsSocLogicTopo(UhdlWrapperNode):
    """SoC-scale STS topology rooted at aon_ss_iniu."""

    def __init__(self):
        super().__init__(id=SOC_STS_NOC_TOP_ID)

        self.add_interface("clk_sys", is_global=True)
        self.add_interface("rst_sys_n", is_global=True)
        self.add_interface("clk_harden_dn_func", is_global=True)
        self.add_interface("rst_harden_dn_func_n", is_global=True)
        self.add_interface("clk_harden_up_func", is_global=True)
        self.add_interface("rst_harden_up_func_n", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rst_dbg_timer_n", is_global=True)

        self.aon_ss_iniu = StsIniuNode(id="aon_ss_iniu")
        connect(self.aon_ss_iniu.clk_src, self.clk_sys)
        connect(self.aon_ss_iniu.rstn_src, self.rst_sys_n)
        connect(self.aon_ss_iniu.clk_dst, self.clk_harden_dn_func)
        connect(self.aon_ss_iniu.rstn_dst, self.rst_harden_dn_func_n)

        self.dec0 = StsDec4Node(id="dec0", slave_num=2)
        self.dec1 = StsDec4Node(id="dec1", slave_num=2)
        self.dec2 = StsDec4Node(id="dec2")
        self.dec2_ext = StsDec4Node(id="dec2_ext", slave_num=3)

        self.harden_dn_async_bridge_slv = StsReqRspAsyncBridgeSlvNode(
            id="harden_dn_async_bridge_slv"
        )
        self.harden_up_async_bridge_mst = StsReqRspAsyncBridgeMstNode(
            id="harden_up_async_bridge_mst"
        )

        harden_dn_decs = (self.dec0, self.dec1)
        for dec in harden_dn_decs:
            connect(dec.clk, self.clk_harden_dn_func)
            connect(dec.rst_n, self.rst_harden_dn_func_n)

        harden_up_decs = (self.dec2, self.dec2_ext)
        for dec in harden_up_decs:
            connect(dec.clk, self.clk_harden_up_func)
            connect(dec.rst_n, self.rst_harden_up_func_n)

        connect(self.harden_dn_async_bridge_slv.clk, self.clk_harden_dn_func)
        connect(self.harden_dn_async_bridge_slv.rst_n, self.rst_harden_dn_func_n)
        connect(self.harden_up_async_bridge_mst.clk, self.clk_harden_up_func)
        connect(self.harden_up_async_bridge_mst.rst_n, self.rst_harden_up_func_n)
        connect(self.harden_dn_async_bridge_slv.sync, self.harden_up_async_bridge_mst.sync)

        leaf_names = [
            "vpu_ss",
            "camera_ss",
            "dspss0",
            "dspss1",
            "dspss2",
            "dspss3",
            "dspss4",
            "dspss5",
        ]
        harden_dn_leaf_names = {"vpu_ss", "camera_ss"}
        harden_up_leaf_names = {"dspss0", "dspss1", "dspss2", "dspss3", "dspss4", "dspss5"}

        self.harden_dn_leaf_names = tuple(sorted(harden_dn_leaf_names))
        self.harden_up_leaf_names = tuple(sorted(harden_up_leaf_names))

        self.tniu_nodes = {}
        for idx, name in enumerate(leaf_names):
            node = make_sts_tniu_node(idx % 4, id=f"{name}_tniu")
            setattr(self, f"{name}_tniu", node)
            self.tniu_nodes[name] = node
            connect(node.clk_src, self.clk_sys)
            connect(node.rstn_src, self.rst_sys_n)
            if name in harden_dn_leaf_names:
                connect(node.clk_dst, self.clk_harden_dn_func)
                connect(node.rstn_dst, self.rst_harden_dn_func_n)
            else:
                connect(node.clk_dst, self.clk_harden_up_func)
                connect(node.rstn_dst, self.rst_harden_up_func_n)
            connect(node.clk_dbg_timer, self.clk_dbg_timer)
            connect(node.rstn_dbg_timer, self.rst_dbg_timer_n)

        def connect_leaf(dec: StsDec4Node, slot: int, leaf_name: str):
            leaf = self.tniu_nodes[leaf_name]
            connect(getattr(dec, f"slv{slot}_req"), leaf.req)
            connect(getattr(dec, f"slv{slot}_rsp"), leaf.rsp)

        def connect_dec(parent: StsDec4Node, slot: int, child: StsDec4Node):
            connect(getattr(parent, f"slv{slot}_req"), child.mst_req)
            connect(getattr(parent, f"slv{slot}_rsp"), child.mst_rsp)

        connect(self.aon_ss_iniu.req, self.dec0.mst_req)
        connect(self.aon_ss_iniu.rsp, self.dec0.mst_rsp)

        connect_leaf(self.dec0, 0, "vpu_ss")
        connect_dec(self.dec0, 1, self.dec1)

        connect_leaf(self.dec1, 0, "camera_ss")
        connect(self.dec1.slv1_req, self.harden_dn_async_bridge_slv.s_chan)
        connect(self.harden_up_async_bridge_mst.m_chan, self.dec2.mst_req)
        connect(self.dec2.mst_rsp, self.dec1.slv1_rsp)

        connect_leaf(self.dec2, 0, "dspss0")
        connect_leaf(self.dec2, 1, "dspss1")
        connect_leaf(self.dec2, 2, "dspss2")
        connect_dec(self.dec2, 3, self.dec2_ext)

        connect_leaf(self.dec2_ext, 0, "dspss3")
        connect_leaf(self.dec2_ext, 1, "dspss4")
        connect_leaf(self.dec2_ext, 2, "dspss5")

        self.expose_unconnected_interfaces()
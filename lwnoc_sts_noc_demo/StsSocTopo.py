import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
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


# Blue-chain ownership policy around harden_dn <-> async <-> harden_up cut.
# - display_ss_sink stays inside harden_dn.
# - dp_ss_sink remains on DP media branch (outside harden).
# - cpu_ss_sink remains on display-misc branch (outside harden).
BLUE_CHAIN_LEAF_OWNERSHIP = {
    "display_ss_sink": "harden_dn",
    "dp_ss_sink": "dp_media_branch",
    "cpu_ss_sink": "display_misc_branch",
}


class StsSocLogicTopo(UhdlWrapperNode):
    """SoC-scale STS topology (diagram-oriented) built from reusable STS demo blocks.

    This topology keeps the same STS primitive wrappers (iniu/tniu/dec4) as the
    1i4t demo, but expands node count and hierarchy to match the SoC-style block
    diagram intent.
    """

    def __init__(self):
        super().__init__(id="sts_soc_logic_topo")

        # Shared domain clocks/resets for SoC-level assembly.
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("clk_harden_dn_func", is_global=True)
        self.add_interface("rst_harden_dn_func_n", is_global=True)
        self.add_interface("clk_harden_up_func", is_global=True)
        self.add_interface("rst_harden_up_func_n", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rst_dbg_timer_n", is_global=True)

        # Multiple initiator slices per diagram labels.
        self.cpu_ss_iniu = StsIniuNode(id="cpu_ss_iniu")
        self.dp_ss_iniu = StsIniuNode(id="dp_ss_iniu")
        self.display_ss_iniu = StsIniuNode(id="display_ss_iniu")

        for iniu in (self.cpu_ss_iniu, self.dp_ss_iniu, self.display_ss_iniu):
            connect(iniu.clk_src, self.clk_sys)
            connect(iniu.rstn_src, self.rst_sys_n)
            if iniu is self.display_ss_iniu:
                connect(iniu.clk_dst, self.clk_harden_dn_func)
                connect(iniu.rstn_dst, self.rst_harden_dn_func_n)
            else:
                connect(iniu.clk_dst, self.clk_noc)
                connect(iniu.rstn_dst, self.rst_noc_n)

        # Decoder hierarchy.
        self.cpu_root_dec = StsDec4Node(id="cpu_root_dec")
        self.cpu_ddr_lo_dec = StsDec4Node(id="cpu_ddr_lo_dec")
        self.cpu_ddr_hi_dec = StsDec4Node(id="cpu_ddr_hi_dec")
        self.cpu_ddr_ext_dec = StsDec4Node(id="cpu_ddr_ext_dec")

        self.dp_root_dec = StsDec4Node(id="dp_root_dec")
        self.dp_media_dec = StsDec4Node(id="dp_media_dec")
        self.dp_io_dec = StsDec4Node(id="dp_io_dec")

        self.display_root_dec = StsDec4Node(id="display_root_dec")
        self.display_misc_dec = StsDec4Node(id="display_misc_dec")
        self.harden_dn_dec = StsDec4Node(id="harden_dn_dec")
        self.harden_up_dec = StsDec4Node(id="harden_up_dec")
        self.harden_up_dsp_ext_dec = StsDec4Node(id="harden_up_dsp_ext_dec")

        self.harden_dn_async_bridge_slv = StsReqRspAsyncBridgeSlvNode(
            id="harden_dn_async_bridge_slv"
        )
        self.harden_up_async_bridge_mst = StsReqRspAsyncBridgeMstNode(
            id="harden_up_async_bridge_mst"
        )

        noc_domain_decs = (
            self.cpu_root_dec,
            self.cpu_ddr_lo_dec,
            self.cpu_ddr_hi_dec,
            self.cpu_ddr_ext_dec,
            self.dp_root_dec,
            self.dp_media_dec,
            self.dp_io_dec,
            self.display_root_dec,
            self.display_misc_dec,
        )
        for dec in noc_domain_decs:
            connect(dec.clk, self.clk_noc)
            connect(dec.rst_n, self.rst_noc_n)

        harden_dn_decs = (
            self.harden_dn_dec,
        )
        for dec in harden_dn_decs:
            connect(dec.clk, self.clk_harden_dn_func)
            connect(dec.rst_n, self.rst_harden_dn_func_n)

        harden_up_decs = (
            self.harden_up_dec,
            self.harden_up_dsp_ext_dec,
        )
        for dec in harden_up_decs:
            connect(dec.clk, self.clk_harden_up_func)
            connect(dec.rst_n, self.rst_harden_up_func_n)

        connect(self.harden_dn_async_bridge_slv.clk, self.clk_harden_dn_func)
        connect(self.harden_dn_async_bridge_slv.rst_n, self.rst_harden_dn_func_n)
        connect(self.harden_up_async_bridge_mst.clk, self.clk_harden_up_func)
        connect(self.harden_up_async_bridge_mst.rst_n, self.rst_harden_up_func_n)
        connect(self.harden_dn_async_bridge_slv.sync, self.harden_up_async_bridge_mst.sync)

        # TNIU leaves (SoC block labels from the provided diagram).
        leaf_names = [
            "ddr0",
            "ddr1",
            "ddr2",
            "ddr3",
            "ddr4",
            "ddr5",
            "ddr6",
            "ddr7",
            "ddr8",
            "ddr9",
            "ddr10",
            "ddr11",
            "dspss0",
            "dspss1",
            "dspss2",
            "dspss3",
            "dspss4",
            "dspss5",
            "camera_ss",
            "vpu_ss",
            "mipi_ss",
            "ufs_ss",
            "pcie_eth_ss",
            "peri_ss",
            "audio_ss",
            "gpu_ss1",
            "ucie_ss0",
            "ucie_ss1",
            "aon_ss",
            "debug_ss",
            "gpu_ss0",
            "dp_ss_sink",
            "display_ss_sink",
            "cpu_ss_sink",
            "gpu_ss0_sink",
        ]

        harden_dn_leaf_names = {
            "camera_ss",
            "display_ss_sink",
        }
        harden_up_leaf_names = {
            "dspss0",
            "dspss1",
            "dspss2",
            "dspss3",
            "dspss4",
            "dspss5",
        }

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
            elif name in harden_up_leaf_names:
                connect(node.clk_dst, self.clk_harden_up_func)
                connect(node.rstn_dst, self.rst_harden_up_func_n)
            else:
                connect(node.clk_dst, self.clk_noc)
                connect(node.rstn_dst, self.rst_noc_n)
            connect(node.clk_dbg_timer, self.clk_dbg_timer)
            connect(node.rstn_dbg_timer, self.rst_dbg_timer_n)

        def connect_leaf(dec: StsDec4Node, slot: int, leaf_name: str):
            leaf = self.tniu_nodes[leaf_name]
            connect(getattr(dec, f"slv{slot}_req"), leaf.req)
            connect(getattr(dec, f"slv{slot}_rsp"), leaf.rsp)

        def connect_dec(parent: StsDec4Node, slot: int, child: StsDec4Node):
            connect(getattr(parent, f"slv{slot}_req"), child.mst_req)
            connect(getattr(parent, f"slv{slot}_rsp"), child.mst_rsp)

        # CPU path: mainly DDR and high-bandwidth memory-facing leaves.
        connect(self.cpu_ss_iniu.req, self.cpu_root_dec.mst_req)
        connect(self.cpu_ss_iniu.rsp, self.cpu_root_dec.mst_rsp)
        connect_dec(self.cpu_root_dec, 0, self.cpu_ddr_lo_dec)
        connect_dec(self.cpu_root_dec, 1, self.cpu_ddr_hi_dec)
        connect_dec(self.cpu_root_dec, 2, self.cpu_ddr_ext_dec)
        connect_leaf(self.cpu_root_dec, 3, "gpu_ss0")

        connect_leaf(self.cpu_ddr_lo_dec, 0, "ddr0")
        connect_leaf(self.cpu_ddr_lo_dec, 1, "ddr1")
        connect_leaf(self.cpu_ddr_lo_dec, 2, "ddr2")
        connect_leaf(self.cpu_ddr_lo_dec, 3, "ddr3")

        connect_leaf(self.cpu_ddr_hi_dec, 0, "ddr6")
        connect_leaf(self.cpu_ddr_hi_dec, 1, "ddr7")
        connect_leaf(self.cpu_ddr_hi_dec, 2, "ddr8")
        connect_leaf(self.cpu_ddr_hi_dec, 3, "ddr9")

        connect_leaf(self.cpu_ddr_ext_dec, 0, "ddr4")
        connect_leaf(self.cpu_ddr_ext_dec, 1, "ddr5")
        connect_leaf(self.cpu_ddr_ext_dec, 2, "ddr10")
        connect_leaf(self.cpu_ddr_ext_dec, 3, "ddr11")

        # DP path: retain the media and IO leaves that stay outside the harden cut.
        # dp_ss_sink ownership is explicitly fixed to DP media branch.
        connect(self.dp_ss_iniu.req, self.dp_root_dec.mst_req)
        connect(self.dp_ss_iniu.rsp, self.dp_root_dec.mst_rsp)
        connect_dec(self.dp_root_dec, 0, self.dp_media_dec)
        connect_dec(self.dp_root_dec, 1, self.dp_io_dec)
        connect_leaf(self.dp_root_dec, 2, "gpu_ss0")

        connect_leaf(self.dp_media_dec, 0, "vpu_ss")
        connect_leaf(self.dp_media_dec, 1, "mipi_ss")
        connect_leaf(self.dp_media_dec, 2, "dp_ss_sink")
        connect_leaf(self.dp_media_dec, 3, "gpu_ss0_sink")

        connect_leaf(self.dp_io_dec, 0, "ufs_ss")
        connect_leaf(self.dp_io_dec, 1, "pcie_eth_ss")
        connect_leaf(self.dp_io_dec, 2, "peri_ss")
        connect_leaf(self.dp_io_dec, 3, "audio_ss")

        # Display/AON path: model the blue async cut as harden_dn -> async -> harden_up.
        # cpu_ss_sink stays on display_misc branch; display_ss_sink stays in harden_dn.
        connect(self.display_ss_iniu.req, self.display_root_dec.mst_req)
        connect(self.display_ss_iniu.rsp, self.display_root_dec.mst_rsp)
        connect_dec(self.display_root_dec, 0, self.display_misc_dec)
        connect_leaf(self.display_root_dec, 1, "gpu_ss1")
        connect_leaf(self.display_root_dec, 2, "ucie_ss0")
        connect_leaf(self.display_root_dec, 3, "ucie_ss1")

        connect_leaf(self.display_misc_dec, 0, "aon_ss")
        connect_leaf(self.display_misc_dec, 1, "debug_ss")
        connect_dec(self.display_misc_dec, 2, self.harden_dn_dec)
        connect_leaf(self.display_misc_dec, 3, "cpu_ss_sink")

        connect_leaf(self.harden_dn_dec, 0, "camera_ss")
        connect(self.harden_dn_dec.slv1_req, self.harden_dn_async_bridge_slv.s_chan)
        connect(self.harden_up_async_bridge_mst.m_chan, self.harden_up_dec.mst_req)
        connect(self.harden_up_dec.mst_rsp, self.harden_dn_dec.slv1_rsp)
        connect_leaf(self.harden_dn_dec, 2, "display_ss_sink")

        connect_leaf(self.harden_up_dec, 0, "dspss0")
        connect_leaf(self.harden_up_dec, 1, "dspss1")
        connect_leaf(self.harden_up_dec, 2, "dspss2")
        connect_dec(self.harden_up_dec, 3, self.harden_up_dsp_ext_dec)

        connect_leaf(self.harden_up_dsp_ext_dec, 0, "dspss3")
        connect_leaf(self.harden_up_dsp_ext_dec, 1, "dspss4")
        connect_leaf(self.harden_up_dsp_ext_dec, 2, "dspss5")

        self.expose_unconnected_interfaces()

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from DtiTemplate import (
    dti_sw_left3_config,
    dti_sw_left_dsp0_config,
    dti_sw_left_dsp1_config,
    dti_sw_left_noc1_config,
    dti_sw_right4_config,
    dti_sw_right_noc0_config,
    dti_sw_root_config,
)
from DtiTreeNode import DtiSwitchNode
from DtiNode import (
    make_pcie_eth_iniu_node,
    make_vpu_iniu_node,
    make_dsp2_iniu_node,
    make_dsp1_iniu_node,
    make_dsp0_iniu_node,
    make_noc_tbu1_iniu_node,
    make_usb_ufs_iniu_node,
    make_mipi0_iniu_node,
    make_mipi1_iniu_node,
    make_camera_iniu_node,
    make_noc_tbu0_iniu_node,
    make_tcu_tniu_node,
)


class DtiLogicTopo(UhdlWrapperNode):
    def __init__(self, id: str = "dti_logic_topo"):
        super().__init__(id=id)

        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        # ── Switches (7 nodes) ─────────────────────────────────────────────
        self.sw_left3 = DtiSwitchNode(id="sw_left3", cfg=dti_sw_left3_config, top="dti_switch_3i1o_wrap", input_count=3)
        self.sw_left_dsp1 = DtiSwitchNode(id="sw_left_dsp1", cfg=dti_sw_left_dsp1_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_left_dsp0 = DtiSwitchNode(id="sw_left_dsp0", cfg=dti_sw_left_dsp0_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_left_noc1 = DtiSwitchNode(id="sw_left_noc1", cfg=dti_sw_left_noc1_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_right4 = DtiSwitchNode(id="sw_right4", cfg=dti_sw_right4_config, top="dti_switch_4i1o_wrap", input_count=4)
        self.sw_right_noc0 = DtiSwitchNode(id="sw_right_noc0", cfg=dti_sw_right_noc0_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_root = DtiSwitchNode(id="sw_root", cfg=dti_sw_root_config, top="dti_switch_2i1o_wrap", input_count=2)

        for node in [
            self.sw_left3,
            self.sw_left_dsp1,
            self.sw_left_dsp0,
            self.sw_left_noc1,
            self.sw_right4,
            self.sw_right_noc0,
            self.sw_root,
        ]:
            connect(node.clk, self.clk_noc)
            connect(node.rst_n, self.rst_noc_n)

        # ── Switch internal tree wiring ────────────────────────────────────
        connect(self.sw_left3.tniu_req, self.sw_left_dsp1.iniu0_req)
        connect(self.sw_left3.tniu_rsp, self.sw_left_dsp1.iniu0_rsp)

        connect(self.sw_left_dsp1.tniu_req, self.sw_left_dsp0.iniu0_req)
        connect(self.sw_left_dsp1.tniu_rsp, self.sw_left_dsp0.iniu0_rsp)

        connect(self.sw_left_dsp0.tniu_req, self.sw_left_noc1.iniu0_req)
        connect(self.sw_left_dsp0.tniu_rsp, self.sw_left_noc1.iniu0_rsp)

        connect(self.sw_right4.tniu_req, self.sw_right_noc0.iniu0_req)
        connect(self.sw_right4.tniu_rsp, self.sw_right_noc0.iniu0_rsp)

        connect(self.sw_left_noc1.tniu_req, self.sw_root.iniu0_req)
        connect(self.sw_left_noc1.tniu_rsp, self.sw_root.iniu0_rsp)
        connect(self.sw_right_noc0.tniu_req, self.sw_root.iniu1_req)
        connect(self.sw_right_noc0.tniu_rsp, self.sw_root.iniu1_rsp)

        # ── INIU / TNIU wrapper nodes (11 per-endpoint INIUs + 1 TNIU) ─────
        self.pcie_eth_iniu  = make_pcie_eth_iniu_node()
        self.vpu_iniu       = make_vpu_iniu_node()
        self.dsp2_iniu      = make_dsp2_iniu_node()
        self.dsp1_iniu      = make_dsp1_iniu_node()
        self.dsp0_iniu      = make_dsp0_iniu_node()
        self.noc_tbu1_iniu  = make_noc_tbu1_iniu_node()
        self.usb_ufs_iniu   = make_usb_ufs_iniu_node()
        self.mipi0_iniu     = make_mipi0_iniu_node()
        self.mipi1_iniu     = make_mipi1_iniu_node()
        self.camera_iniu    = make_camera_iniu_node()
        self.noc_tbu0_iniu  = make_noc_tbu0_iniu_node()
        self.tcu_tniu       = make_tcu_tniu_node()

        for niu in [
            self.pcie_eth_iniu, self.vpu_iniu, self.dsp2_iniu, self.dsp1_iniu,
            self.dsp0_iniu, self.noc_tbu1_iniu, self.usb_ufs_iniu, self.mipi0_iniu,
            self.mipi1_iniu, self.camera_iniu, self.noc_tbu0_iniu, self.tcu_tniu,
        ]:
            connect(niu.clk_top, self.clk_noc)
            connect(niu.rst_top_n, self.rst_noc_n)

        # ── INIU top → switch leaf (5-signal, positional zip matched by suffix sort) ──
        connect(self.pcie_eth_iniu.top_req,  self.sw_left3.iniu0_req)
        connect(self.pcie_eth_iniu.top_rsp,  self.sw_left3.iniu0_rsp)
        connect(self.vpu_iniu.top_req,       self.sw_left3.iniu1_req)
        connect(self.vpu_iniu.top_rsp,       self.sw_left3.iniu1_rsp)
        connect(self.dsp2_iniu.top_req,      self.sw_left3.iniu2_req)
        connect(self.dsp2_iniu.top_rsp,      self.sw_left3.iniu2_rsp)

        connect(self.dsp1_iniu.top_req,      self.sw_left_dsp1.iniu1_req)
        connect(self.dsp1_iniu.top_rsp,      self.sw_left_dsp1.iniu1_rsp)

        connect(self.dsp0_iniu.top_req,      self.sw_left_dsp0.iniu1_req)
        connect(self.dsp0_iniu.top_rsp,      self.sw_left_dsp0.iniu1_rsp)

        connect(self.noc_tbu1_iniu.top_req,  self.sw_left_noc1.iniu1_req)
        connect(self.noc_tbu1_iniu.top_rsp,  self.sw_left_noc1.iniu1_rsp)

        connect(self.usb_ufs_iniu.top_req,   self.sw_right4.iniu0_req)
        connect(self.usb_ufs_iniu.top_rsp,   self.sw_right4.iniu0_rsp)
        connect(self.mipi0_iniu.top_req,     self.sw_right4.iniu1_req)
        connect(self.mipi0_iniu.top_rsp,     self.sw_right4.iniu1_rsp)
        connect(self.mipi1_iniu.top_req,     self.sw_right4.iniu2_req)
        connect(self.mipi1_iniu.top_rsp,     self.sw_right4.iniu2_rsp)
        connect(self.camera_iniu.top_req,    self.sw_right4.iniu3_req)
        connect(self.camera_iniu.top_rsp,    self.sw_right4.iniu3_rsp)

        connect(self.noc_tbu0_iniu.top_req,  self.sw_right_noc0.iniu1_req)
        connect(self.noc_tbu0_iniu.top_rsp,  self.sw_right_noc0.iniu1_rsp)

        # ── Switch root → TNIU (5-signal) ────────────────────────────────
        connect(self.tcu_tniu.top_req, self.sw_root.tniu_req)
        connect(self.tcu_tniu.top_rsp, self.sw_root.tniu_rsp)

        self.expose_unconnected_interfaces()
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


class DtiLogicTopo(UhdlWrapperNode):
    def __init__(self, id: str = "dti_logic_topo"):
        super().__init__(id=id)

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)

        for name in [
            "pcie_eth", "vpu", "dsp2", "dsp1", "dsp0", "noc_tbu1",
            "usb_ufs", "mipi0", "mipi1", "camera", "noc_tbu0", "top_tcu"
        ]:
            self.add_interface(f"{name}_req")
            self.add_interface(f"{name}_rsp")

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
            connect(node.clk, self.clk)
            connect(node.rst_n, self.rst_n)

        connect(self.pcie_eth_req, self.sw_left3.iniu0_req)
        connect(self.pcie_eth_rsp, self.sw_left3.iniu0_rsp)
        connect(self.vpu_req, self.sw_left3.iniu1_req)
        connect(self.vpu_rsp, self.sw_left3.iniu1_rsp)
        connect(self.dsp2_req, self.sw_left3.iniu2_req)
        connect(self.dsp2_rsp, self.sw_left3.iniu2_rsp)

        connect(self.sw_left3.tniu_req, self.sw_left_dsp1.iniu0_req)
        connect(self.sw_left3.tniu_rsp, self.sw_left_dsp1.iniu0_rsp)
        connect(self.dsp1_req, self.sw_left_dsp1.iniu1_req)
        connect(self.dsp1_rsp, self.sw_left_dsp1.iniu1_rsp)

        connect(self.sw_left_dsp1.tniu_req, self.sw_left_dsp0.iniu0_req)
        connect(self.sw_left_dsp1.tniu_rsp, self.sw_left_dsp0.iniu0_rsp)
        connect(self.dsp0_req, self.sw_left_dsp0.iniu1_req)
        connect(self.dsp0_rsp, self.sw_left_dsp0.iniu1_rsp)

        connect(self.sw_left_dsp0.tniu_req, self.sw_left_noc1.iniu0_req)
        connect(self.sw_left_dsp0.tniu_rsp, self.sw_left_noc1.iniu0_rsp)
        connect(self.noc_tbu1_req, self.sw_left_noc1.iniu1_req)
        connect(self.noc_tbu1_rsp, self.sw_left_noc1.iniu1_rsp)

        connect(self.usb_ufs_req, self.sw_right4.iniu0_req)
        connect(self.usb_ufs_rsp, self.sw_right4.iniu0_rsp)
        connect(self.mipi0_req, self.sw_right4.iniu1_req)
        connect(self.mipi0_rsp, self.sw_right4.iniu1_rsp)
        connect(self.mipi1_req, self.sw_right4.iniu2_req)
        connect(self.mipi1_rsp, self.sw_right4.iniu2_rsp)
        connect(self.camera_req, self.sw_right4.iniu3_req)
        connect(self.camera_rsp, self.sw_right4.iniu3_rsp)

        connect(self.sw_right4.tniu_req, self.sw_right_noc0.iniu0_req)
        connect(self.sw_right4.tniu_rsp, self.sw_right_noc0.iniu0_rsp)
        connect(self.noc_tbu0_req, self.sw_right_noc0.iniu1_req)
        connect(self.noc_tbu0_rsp, self.sw_right_noc0.iniu1_rsp)

        connect(self.sw_left_noc1.tniu_req, self.sw_root.iniu0_req)
        connect(self.sw_left_noc1.tniu_rsp, self.sw_root.iniu0_rsp)
        connect(self.sw_right_noc0.tniu_req, self.sw_root.iniu1_req)
        connect(self.sw_right_noc0.tniu_rsp, self.sw_root.iniu1_rsp)

        connect(self.top_tcu_req, self.sw_root.tniu_req)
        connect(self.top_tcu_rsp, self.sw_root.tniu_rsp)

        self.expose_unconnected_interfaces()
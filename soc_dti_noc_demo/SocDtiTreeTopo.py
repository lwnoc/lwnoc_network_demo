import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from DtiNode import DtiSwitchNode
from SocDtiNode import (
    make_iniu_node,
    make_iniu_top_wrap_node,
    make_tniu_node,
    make_tniu_top_wrap_node,
)
from SocDtiTemplate import (
    INIU_NODE_NAMES,
    soc_dti_sw_dsp6_config,
    soc_dti_sw_gpu4_config,
    soc_dti_sw_io5_config,
    soc_dti_sw_right_config,
    soc_dti_sw_root_config,
)


TOPO_ID = "soc_dti_logic_topo"
UP_HARDEN_ID = "soc_dti_harden_up"
DN_HARDEN_ID = "soc_dti_harden_dn"

UP_HARDEN_NODE_NAMES = ["gpu_ss0", "gpu_ss1", "dp_ss", "display_ss"]
DN_HARDEN_NODE_NAMES = [
    "dsp_ss0",
    "dsp_ss1",
    "dsp_ss2",
    "dsp_ss3",
    "dsp_ss4",
    "dsp_ss5",
    "vpu_ss",
    "pcie_eth_ss",
    "ufs_ss",
    "camera_ss",
    "mipi_ss",
]

UP_HARDEN_MEMBER_IDS = [
    "soc_dti_sw_gpu4",
    "gpu_ss0_iniu_top_wrap",
    "gpu_ss1_iniu_top_wrap",
    "dp_ss_iniu_top_wrap",
    "display_ss_iniu_top_wrap",
]

DN_HARDEN_MEMBER_IDS = [
    "soc_dti_sw_dsp6",
    "soc_dti_sw_io5",
    "soc_dti_sw_right",
    "soc_dti_sw_root",
    "dsp_ss0_iniu_top_wrap",
    "dsp_ss1_iniu_top_wrap",
    "dsp_ss2_iniu_top_wrap",
    "dsp_ss3_iniu_top_wrap",
    "dsp_ss4_iniu_top_wrap",
    "dsp_ss5_iniu_top_wrap",
    "vpu_ss_iniu_top_wrap",
    "pcie_eth_ss_iniu_top_wrap",
    "ufs_ss_iniu_top_wrap",
    "camera_ss_iniu_top_wrap",
    "mipi_ss_iniu_top_wrap",
    "sys_tcu_tniu_top_wrap",
]

# TID plan derived from the attached SoC sketch:
#   DSPSS0-5 -> 0..5
#   VPUSS -> 6
#   PCIE_ETHSS -> 7
#   UFS -> 8
#   Camera -> 9
#   MIPI -> 10
#   GPU SS0 -> 11
#   GPU SS1 -> 12
#   DP -> 13
#   Display -> 14
INIU_TID_MAP = {name: idx for idx, name in enumerate(INIU_NODE_NAMES)}


class SocDtiUpHardenWrap(UhdlWrapperNode):
    def __init__(self, id: str = UP_HARDEN_ID):
        super().__init__(id=id)

        self.add_interface("clk_noc_up", is_global=True)
        self.add_interface("rst_noc_up_n", is_global=True)
        self.add_interface("link_req")
        self.add_interface("link_rsp")

        self.sw_gpu4 = DtiSwitchNode(
            id="soc_dti_sw_gpu4",
            cfg=soc_dti_sw_gpu4_config,
            top="dti_switch_4i1o_wrap",
            input_count=4,
        )
        connect(self.sw_gpu4.clk, self.clk_noc_up)
        connect(self.sw_gpu4.rst_n, self.rst_noc_up_n)

        self.iniu_top_wraps = {
            node_name: make_iniu_top_wrap_node(node_name=node_name)
            for node_name in UP_HARDEN_NODE_NAMES
        }

        for node_name in UP_HARDEN_NODE_NAMES:
            node = self.iniu_top_wraps[node_name]
            setattr(self, f"{node_name}_iniu_top_wrap", node)
            connect(node.clk_top, self.clk_noc_up)
            connect(node.rst_top_n, self.rst_noc_up_n)

        connect(self.iniu_top_wraps["gpu_ss0"].top_req, self.sw_gpu4.iniu0_req)
        connect(self.iniu_top_wraps["gpu_ss0"].top_rsp, self.sw_gpu4.iniu0_rsp)
        connect(self.iniu_top_wraps["gpu_ss1"].top_req, self.sw_gpu4.iniu1_req)
        connect(self.iniu_top_wraps["gpu_ss1"].top_rsp, self.sw_gpu4.iniu1_rsp)
        connect(self.iniu_top_wraps["dp_ss"].top_req, self.sw_gpu4.iniu2_req)
        connect(self.iniu_top_wraps["dp_ss"].top_rsp, self.sw_gpu4.iniu2_rsp)
        connect(self.iniu_top_wraps["display_ss"].top_req, self.sw_gpu4.iniu3_req)
        connect(self.iniu_top_wraps["display_ss"].top_rsp, self.sw_gpu4.iniu3_rsp)

        connect(self.sw_gpu4.tniu_req, self.link_req)
        connect(self.sw_gpu4.tniu_rsp, self.link_rsp)

        self.expose_unconnected_interfaces()


class SocDtiDnHardenWrap(UhdlWrapperNode):
    def __init__(self, id: str = DN_HARDEN_ID):
        super().__init__(id=id)

        self.add_interface("clk_noc_dn", is_global=True)
        self.add_interface("rst_noc_dn_n", is_global=True)
        self.add_interface("link_req")
        self.add_interface("link_rsp")

        self.sw_dsp6 = DtiSwitchNode(
            id="soc_dti_sw_dsp6",
            cfg=soc_dti_sw_dsp6_config,
            top="dti_switch_6i1o_wrap",
            input_count=6,
        )
        self.sw_io5 = DtiSwitchNode(
            id="soc_dti_sw_io5",
            cfg=soc_dti_sw_io5_config,
            top="dti_switch_5i1o_wrap",
            input_count=5,
        )
        self.sw_right = DtiSwitchNode(
            id="soc_dti_sw_right",
            cfg=soc_dti_sw_right_config,
            top="dti_switch_2i1o_wrap",
            input_count=2,
        )
        self.sw_root = DtiSwitchNode(
            id="soc_dti_sw_root",
            cfg=soc_dti_sw_root_config,
            top="dti_switch_2i1o_wrap",
            input_count=2,
        )

        for node in [self.sw_dsp6, self.sw_io5, self.sw_right, self.sw_root]:
            connect(node.clk, self.clk_noc_dn)
            connect(node.rst_n, self.rst_noc_dn_n)

        self.iniu_top_wraps = {
            node_name: make_iniu_top_wrap_node(node_name=node_name)
            for node_name in DN_HARDEN_NODE_NAMES
        }
        self.sys_tcu_tniu_top_wrap = make_tniu_top_wrap_node()

        for node_name in DN_HARDEN_NODE_NAMES:
            node = self.iniu_top_wraps[node_name]
            setattr(self, f"{node_name}_iniu_top_wrap", node)
            connect(node.clk_top, self.clk_noc_dn)
            connect(node.rst_top_n, self.rst_noc_dn_n)

        connect(self.sys_tcu_tniu_top_wrap.clk_top, self.clk_noc_dn)
        connect(self.sys_tcu_tniu_top_wrap.rst_top_n, self.rst_noc_dn_n)

        connect(self.iniu_top_wraps["dsp_ss0"].top_req, self.sw_dsp6.iniu0_req)
        connect(self.iniu_top_wraps["dsp_ss0"].top_rsp, self.sw_dsp6.iniu0_rsp)
        connect(self.iniu_top_wraps["dsp_ss1"].top_req, self.sw_dsp6.iniu1_req)
        connect(self.iniu_top_wraps["dsp_ss1"].top_rsp, self.sw_dsp6.iniu1_rsp)
        connect(self.iniu_top_wraps["dsp_ss2"].top_req, self.sw_dsp6.iniu2_req)
        connect(self.iniu_top_wraps["dsp_ss2"].top_rsp, self.sw_dsp6.iniu2_rsp)
        connect(self.iniu_top_wraps["dsp_ss3"].top_req, self.sw_dsp6.iniu3_req)
        connect(self.iniu_top_wraps["dsp_ss3"].top_rsp, self.sw_dsp6.iniu3_rsp)
        connect(self.iniu_top_wraps["dsp_ss4"].top_req, self.sw_dsp6.iniu4_req)
        connect(self.iniu_top_wraps["dsp_ss4"].top_rsp, self.sw_dsp6.iniu4_rsp)
        connect(self.iniu_top_wraps["dsp_ss5"].top_req, self.sw_dsp6.iniu5_req)
        connect(self.iniu_top_wraps["dsp_ss5"].top_rsp, self.sw_dsp6.iniu5_rsp)

        connect(self.iniu_top_wraps["vpu_ss"].top_req, self.sw_io5.iniu0_req)
        connect(self.iniu_top_wraps["vpu_ss"].top_rsp, self.sw_io5.iniu0_rsp)
        connect(self.iniu_top_wraps["pcie_eth_ss"].top_req, self.sw_io5.iniu1_req)
        connect(self.iniu_top_wraps["pcie_eth_ss"].top_rsp, self.sw_io5.iniu1_rsp)
        connect(self.iniu_top_wraps["ufs_ss"].top_req, self.sw_io5.iniu2_req)
        connect(self.iniu_top_wraps["ufs_ss"].top_rsp, self.sw_io5.iniu2_rsp)
        connect(self.iniu_top_wraps["camera_ss"].top_req, self.sw_io5.iniu3_req)
        connect(self.iniu_top_wraps["camera_ss"].top_rsp, self.sw_io5.iniu3_rsp)
        connect(self.iniu_top_wraps["mipi_ss"].top_req, self.sw_io5.iniu4_req)
        connect(self.iniu_top_wraps["mipi_ss"].top_rsp, self.sw_io5.iniu4_rsp)

        connect(self.sw_io5.tniu_req, self.sw_right.iniu0_req)
        connect(self.sw_io5.tniu_rsp, self.sw_right.iniu0_rsp)
        connect(self.link_req, self.sw_right.iniu1_req)
        connect(self.sw_right.iniu1_rsp, self.link_rsp)

        connect(self.sw_dsp6.tniu_req, self.sw_root.iniu0_req)
        connect(self.sw_dsp6.tniu_rsp, self.sw_root.iniu0_rsp)
        connect(self.sw_right.tniu_req, self.sw_root.iniu1_req)
        connect(self.sw_right.tniu_rsp, self.sw_root.iniu1_rsp)

        connect(self.sys_tcu_tniu_top_wrap.top_req, self.sw_root.tniu_req)
        connect(self.sys_tcu_tniu_top_wrap.top_rsp, self.sw_root.tniu_rsp)

        self.expose_unconnected_interfaces()


class SocDtiLogicTopo(UhdlWrapperNode):
    def __init__(self, id: str = TOPO_ID):
        super().__init__(id=id)

        self.add_interface("clk_noc_up", is_global=True)
        self.add_interface("rst_noc_up_n", is_global=True)
        self.add_interface("clk_noc_dn", is_global=True)
        self.add_interface("rst_noc_dn_n", is_global=True)

        self.sw_dsp6 = DtiSwitchNode(
            id="soc_dti_sw_dsp6",
            cfg=soc_dti_sw_dsp6_config,
            top="dti_switch_6i1o_wrap",
            input_count=6,
        )
        self.sw_io5 = DtiSwitchNode(
            id="soc_dti_sw_io5",
            cfg=soc_dti_sw_io5_config,
            top="dti_switch_5i1o_wrap",
            input_count=5,
        )
        self.sw_gpu4 = DtiSwitchNode(
            id="soc_dti_sw_gpu4",
            cfg=soc_dti_sw_gpu4_config,
            top="dti_switch_4i1o_wrap",
            input_count=4,
        )
        self.sw_right = DtiSwitchNode(
            id="soc_dti_sw_right",
            cfg=soc_dti_sw_right_config,
            top="dti_switch_2i1o_wrap",
            input_count=2,
        )
        self.sw_root = DtiSwitchNode(
            id="soc_dti_sw_root",
            cfg=soc_dti_sw_root_config,
            top="dti_switch_2i1o_wrap",
            input_count=2,
        )

        for node in [self.sw_dsp6, self.sw_io5, self.sw_right, self.sw_root]:
            connect(node.clk, self.clk_noc_dn)
            connect(node.rst_n, self.rst_noc_dn_n)

        connect(self.sw_gpu4.clk, self.clk_noc_up)
        connect(self.sw_gpu4.rst_n, self.rst_noc_up_n)

        # Level-2: sw_io5 + (sw_gpu4 via buf+async chain) -> sw_right
        connect(self.sw_io5.tniu_req, self.sw_right.iniu0_req)
        connect(self.sw_io5.tniu_rsp, self.sw_right.iniu0_rsp)

        # Topology contract from soc_dti_noc_topo:
        # req uses arrow direction and rsp is the reverse edge.
        connect(self.sw_gpu4.tniu_req, self.sw_right.iniu1_req)
        connect(self.sw_right.iniu1_rsp, self.sw_gpu4.tniu_rsp)

        # Root: sw_dsp6 + sw_right -> sw_root -> TCUTNIU
        connect(self.sw_dsp6.tniu_req, self.sw_root.iniu0_req)
        connect(self.sw_dsp6.tniu_rsp, self.sw_root.iniu0_rsp)
        connect(self.sw_right.tniu_req, self.sw_root.iniu1_req)
        connect(self.sw_right.tniu_rsp, self.sw_root.iniu1_rsp)

        self.iniu_nodes = {
            node_name: make_iniu_node(node_name=node_name)
            for node_name in INIU_NODE_NAMES
        }
        self.sys_tcu_tniu = make_tniu_node()

        for attr_name, node in self.iniu_nodes.items():
            setattr(self, f"{attr_name}_iniu", node)
            if attr_name in UP_HARDEN_NODE_NAMES:
                connect(node.clk_top, self.clk_noc_up)
                connect(node.rst_top_n, self.rst_noc_up_n)
            else:
                connect(node.clk_top, self.clk_noc_dn)
                connect(node.rst_top_n, self.rst_noc_dn_n)

        connect(self.sys_tcu_tniu.clk_top, self.clk_noc_dn)
        connect(self.sys_tcu_tniu.rst_top_n, self.rst_noc_dn_n)

        # DSP SS0-5 -> sw_dsp6 (ports 0-5)
        connect(self.iniu_nodes["dsp_ss0"].top_req, self.sw_dsp6.iniu0_req)
        connect(self.iniu_nodes["dsp_ss0"].top_rsp, self.sw_dsp6.iniu0_rsp)
        connect(self.iniu_nodes["dsp_ss1"].top_req, self.sw_dsp6.iniu1_req)
        connect(self.iniu_nodes["dsp_ss1"].top_rsp, self.sw_dsp6.iniu1_rsp)
        connect(self.iniu_nodes["dsp_ss2"].top_req, self.sw_dsp6.iniu2_req)
        connect(self.iniu_nodes["dsp_ss2"].top_rsp, self.sw_dsp6.iniu2_rsp)
        connect(self.iniu_nodes["dsp_ss3"].top_req, self.sw_dsp6.iniu3_req)
        connect(self.iniu_nodes["dsp_ss3"].top_rsp, self.sw_dsp6.iniu3_rsp)
        connect(self.iniu_nodes["dsp_ss4"].top_req, self.sw_dsp6.iniu4_req)
        connect(self.iniu_nodes["dsp_ss4"].top_rsp, self.sw_dsp6.iniu4_rsp)
        connect(self.iniu_nodes["dsp_ss5"].top_req, self.sw_dsp6.iniu5_req)
        connect(self.iniu_nodes["dsp_ss5"].top_rsp, self.sw_dsp6.iniu5_rsp)

        # VPU(0), PCIE_ETH(1), UFS(2), Camera(3), MIPI(4) -> sw_io5
        connect(self.iniu_nodes["vpu_ss"].top_req, self.sw_io5.iniu0_req)
        connect(self.iniu_nodes["vpu_ss"].top_rsp, self.sw_io5.iniu0_rsp)
        connect(self.iniu_nodes["pcie_eth_ss"].top_req, self.sw_io5.iniu1_req)
        connect(self.iniu_nodes["pcie_eth_ss"].top_rsp, self.sw_io5.iniu1_rsp)
        connect(self.iniu_nodes["ufs_ss"].top_req, self.sw_io5.iniu2_req)
        connect(self.iniu_nodes["ufs_ss"].top_rsp, self.sw_io5.iniu2_rsp)
        connect(self.iniu_nodes["camera_ss"].top_req, self.sw_io5.iniu3_req)
        connect(self.iniu_nodes["camera_ss"].top_rsp, self.sw_io5.iniu3_rsp)
        connect(self.iniu_nodes["mipi_ss"].top_req, self.sw_io5.iniu4_req)
        connect(self.iniu_nodes["mipi_ss"].top_rsp, self.sw_io5.iniu4_rsp)

        # GPU SS0(0), GPU SS1(1), DP SS(2), Display SS(3) -> sw_gpu4
        connect(self.iniu_nodes["gpu_ss0"].top_req, self.sw_gpu4.iniu0_req)
        connect(self.iniu_nodes["gpu_ss0"].top_rsp, self.sw_gpu4.iniu0_rsp)
        connect(self.iniu_nodes["gpu_ss1"].top_req, self.sw_gpu4.iniu1_req)
        connect(self.iniu_nodes["gpu_ss1"].top_rsp, self.sw_gpu4.iniu1_rsp)
        connect(self.iniu_nodes["dp_ss"].top_req, self.sw_gpu4.iniu2_req)
        connect(self.iniu_nodes["dp_ss"].top_rsp, self.sw_gpu4.iniu2_rsp)
        connect(self.iniu_nodes["display_ss"].top_req, self.sw_gpu4.iniu3_req)
        connect(self.iniu_nodes["display_ss"].top_rsp, self.sw_gpu4.iniu3_rsp)

        # sw_root -> TCU TNIU
        connect(self.sys_tcu_tniu.top_req, self.sw_root.tniu_req)
        connect(self.sys_tcu_tniu.top_rsp, self.sw_root.tniu_rsp)

        self.expose_unconnected_interfaces()

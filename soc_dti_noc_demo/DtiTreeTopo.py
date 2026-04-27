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
    dsp_iniu_sys_config,
    pcie_eth_iniu_sys_config,
    vpu_iniu_sys_config,
    usb_ufs_iniu_sys_config,
    mipi_iniu_sys_config,
    camera_iniu_sys_config,
    cpu_iniu_sys_config,
    gpu_iniu_sys_config,
    dp_iniu_sys_config,
    display_iniu_sys_config,
    dti_link_buf_config,
    dti_req_rsp_async_config,
    iniu_top_config,
    tcu_tniu_sys_config,
    tniu_top_config,
    dti_sw0_config,
    dti_sw1_config,
    dti_sw2_config,
    dti_sw3_config,
)
from DtiNode import (
    DtiIniuNode,
    DtiTniuNode,
    DtiSwitchNode,
    DtiLinkBufReqNode,
    DtiReqRspAsyncBridgeNode,
)


class DtiLogicTopo(UhdlWrapperNode):
    """4-switch topology matching soc_dti_noc_topo.

    sw0 (6i1o, dsp0~5)        -> sw3 ch0
    sw1 (5i1o, cpu/pcie/ufs/camera/mipi) -> sw3 ch1
    sw2 (4i1o, gpu0/gpu1/dp/display) -> dti_buffer -> async_bridge_slv
    async_bridge_mst -> sw3 ch2
    sw3 (3i1o) -> tcu_tniu
    """

    def __init__(self, id: str = "dti_logic_topo"):
        super().__init__(id=id)

        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("clk_noc_up", is_global=True)
        self.add_interface("rst_noc_up_n", is_global=True)

        # Switches
        self.sw0 = DtiSwitchNode(id="sw0", cfg=dti_sw0_config, top="dti_noc_switch", input_count=6)
        self.sw1 = DtiSwitchNode(id="sw1", cfg=dti_sw1_config, top="dti_noc_switch", input_count=5)
        self.sw2 = DtiSwitchNode(id="sw2", cfg=dti_sw2_config, top="dti_noc_switch", input_count=4)
        self.sw3 = DtiSwitchNode(id="sw3", cfg=dti_sw3_config, top="dti_noc_switch", input_count=3)

        for sw in [self.sw0, self.sw1, self.sw2]:
            connect(sw.clk, self.clk_noc)
            connect(sw.rst_n, self.rst_noc_n)
        connect(self.sw3.clk, self.clk_noc_up)
        connect(self.sw3.rst_n, self.rst_noc_up_n)

        # Buffer + async bridge (sw2 -> buffer -> async slv)
        self.dti_buffer = DtiLinkBufReqNode(id="dti_buffer", cfg=dti_link_buf_config)
        connect(self.dti_buffer.clk, self.clk_noc)
        connect(self.dti_buffer.rst_n, self.rst_noc_n)

        self.async_bridge = DtiReqRspAsyncBridgeNode(id="dti_req_rsp_async_bridge", cfg=dti_req_rsp_async_config)
        connect(self.async_bridge.clk_src, self.clk_noc)
        connect(self.async_bridge.rst_src_n, self.rst_noc_n)
        connect(self.async_bridge.clk_dst, self.clk_noc_up)
        connect(self.async_bridge.rst_dst_n, self.rst_noc_up_n)

        # INIU nodes for sw0 (dsp0~5) — shared config per SS type
        for i in range(6):
            node = DtiIniuNode(id=f"dsp{i}_iniu_node", sys_cfg=dsp_iniu_sys_config, top_cfg=iniu_top_config, node_name=f"dsp{i}")
            setattr(self, f"dsp{i}_iniu", node)
            connect(node.clk_top, self.clk_noc)
            connect(node.rst_top_n, self.rst_noc_n)
            connect(node.top_req, getattr(self.sw0, f"iniu{i}_req"))
            connect(node.top_rsp, getattr(self.sw0, f"iniu{i}_rsp"))

        # INIU nodes for sw1 (cpu, pcie_eth, ufs, camera, mipi)
        self.cpu_iniu    = DtiIniuNode(id="cpu_iniu_node",    sys_cfg=cpu_iniu_sys_config,    top_cfg=iniu_top_config, node_name="cpu")
        self.pcie_iniu   = DtiIniuNode(id="pcie_iniu_node",   sys_cfg=pcie_eth_iniu_sys_config, top_cfg=iniu_top_config, node_name="pcie_eth")
        self.ufs_iniu    = DtiIniuNode(id="ufs_iniu_node",    sys_cfg=usb_ufs_iniu_sys_config, top_cfg=iniu_top_config, node_name="usb_ufs")
        self.camera_iniu = DtiIniuNode(id="camera_iniu_node", sys_cfg=camera_iniu_sys_config,   top_cfg=iniu_top_config, node_name="camera")
        self.mipi_iniu   = DtiIniuNode(id="mipi_iniu_node",   sys_cfg=mipi_iniu_sys_config,     top_cfg=iniu_top_config, node_name="mipi")

        for idx, iniu in enumerate([self.cpu_iniu, self.pcie_iniu, self.ufs_iniu,
                                     self.camera_iniu, self.mipi_iniu]):
            connect(iniu.clk_top, self.clk_noc)
            connect(iniu.rst_top_n, self.rst_noc_n)
            connect(iniu.top_req, getattr(self.sw1, f"iniu{idx}_req"))
            connect(iniu.top_rsp, getattr(self.sw1, f"iniu{idx}_rsp"))

        # INIU nodes for sw2 (gpu0, gpu1, dp, display)
        self.gpu0_iniu    = DtiIniuNode(id="gpu0_iniu_node",    sys_cfg=gpu_iniu_sys_config,     top_cfg=iniu_top_config, node_name="gpu0")
        self.gpu1_iniu    = DtiIniuNode(id="gpu1_iniu_node",    sys_cfg=gpu_iniu_sys_config,     top_cfg=iniu_top_config, node_name="gpu1")
        self.dp_iniu      = DtiIniuNode(id="dp_iniu_node",      sys_cfg=dp_iniu_sys_config,      top_cfg=iniu_top_config, node_name="dp")
        self.display_iniu = DtiIniuNode(id="display_iniu_node", sys_cfg=display_iniu_sys_config, top_cfg=iniu_top_config, node_name="display")

        for idx, iniu in enumerate([self.gpu0_iniu, self.gpu1_iniu,
                                     self.dp_iniu, self.display_iniu]):
            connect(iniu.clk_top, self.clk_noc)
            connect(iniu.rst_top_n, self.rst_noc_n)
            connect(iniu.top_req, getattr(self.sw2, f"iniu{idx}_req"))
            connect(iniu.top_rsp, getattr(self.sw2, f"iniu{idx}_rsp"))

        # Inter-switch wiring
        connect(self.sw0.tniu_req, self.sw3.iniu0_req)
        connect(self.sw0.tniu_rsp, self.sw3.iniu0_rsp)
        connect(self.sw1.tniu_req, self.sw3.iniu1_req)
        connect(self.sw1.tniu_rsp, self.sw3.iniu1_rsp)

        # sw2 → buffer → async bridge slv (unidirectional, request path)
        connect(self.sw2.tniu_req, self.dti_buffer.s_req)
        connect(self.dti_buffer.m_req, self.async_bridge.s_chan)

        # async bridge mst → sw3 ch2
        connect(self.async_bridge.m_chan, self.sw3.iniu2_req)
        # RSP return: sw3 ch2 → sw2 TNIU slave side (response routing)
        connect(self.sw3.iniu2_rsp, self.sw2.tniu_rsp)

        # sw3 -> tcu_tniu
        self.tcu_tniu = DtiTniuNode(id="tcu_tniu_node", sys_cfg=tcu_tniu_sys_config, top_cfg=tniu_top_config, node_name="sys_tcu_tniu")
        connect(self.tcu_tniu.clk_top, self.clk_noc_up)
        connect(self.tcu_tniu.rst_top_n, self.rst_noc_up_n)
        connect(self.sw3.tniu_req, self.tcu_tniu.top_req_data)
        connect(self.tcu_tniu.top_rsp, self.sw3.tniu_rsp)

        self.expose_unconnected_interfaces()

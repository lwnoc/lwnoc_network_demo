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
    SOC_DTI_INIU_SYS_CFG_BY_LEAF,
    SOC_DTI_TTID_BASES,
    iniu_top_config,
    cpu_tniu_sys_config,
    tniu_top_config,
    dti_sw0_config,
    dti_sw1_config,
    dti_sw2_config,
    dti_sw3_config,
    dti_sw4_config,
    dti_sw5_config,
)
from DtiNode import (
    DtiIniuNode,
    DtiTniuNode,
    DtiSwitchNode,
    safe_connect,
)


class DtiLogicTopo(UhdlWrapperNode):
    """Single-domain SoC DTI ingress tree rooted at cpu_ss tniu0/1.

    bottom_merge1 (3i1o): npu_ss3, npu_ss4, npu_ss2
    bottom_merge0 (3i1o): ufs_ss, pcie_eth_ss, gpu_ss0
    dsp_merge0    (6i1o): dspss0..5
    tr_merge0     (6i1o): camera_ss, mipi_ss, gpu_ss1, usb_dp_ss, display_ss, vpu_ss
    tl_merge0     (4i1o): peri_ss, bottom_merge0, dsp_merge0, tr_merge0 -> cpu_ss_tniu0
    top_spine     (3i1o): npu_ss0, bottom_merge1, npu_ss1 -> cpu_ss_tniu1
    """

    def __init__(self, id: str = "dti_logic_topo"):
        super().__init__(id=id)

        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        switch_specs = (
            ("bottom_merge1", dti_sw0_config, 3),
            ("bottom_merge0", dti_sw1_config, 3),
            ("dsp_merge0", dti_sw2_config, 6),
            ("tr_merge0", dti_sw3_config, 6),
            ("tl_merge0", dti_sw4_config, 4),
            ("top_spine", dti_sw5_config, 3),
        )
        for switch_name, switch_cfg, input_count in switch_specs:
            switch_node = DtiSwitchNode(id=switch_name, cfg=switch_cfg, top="dti_noc_switch", input_count=input_count)
            setattr(self, switch_name, switch_node)
            safe_connect(self, switch_node.clk_noc, self.clk_noc)
            safe_connect(self, switch_node.rst_noc_n, self.rst_noc_n)

        def add_iniu_leaf(leaf_name: str, parent_switch: DtiSwitchNode, input_idx: int):
            node = DtiIniuNode(
                id=f"{leaf_name}_iniu_node",
                sys_cfg=SOC_DTI_INIU_SYS_CFG_BY_LEAF[leaf_name],
                top_cfg=iniu_top_config,
                node_name=leaf_name,
                route_base=SOC_DTI_TTID_BASES[leaf_name],
                clk_name="clk_noc",
                rst_name="rst_noc_n",
            )
            setattr(self, f"{leaf_name}_iniu", node)
            safe_connect(self, node.top_req, getattr(parent_switch, f"iniu{input_idx}_req"))
            safe_connect(self, node.top_rsp, getattr(parent_switch, f"iniu{input_idx}_rsp"))
            return node

        for input_idx, leaf_name in enumerate(("npu_ss3", "npu_ss4", "npu_ss2")):
            add_iniu_leaf(leaf_name, self.bottom_merge1, input_idx)

        for input_idx, leaf_name in enumerate(("ufs_ss", "pcie_eth_ss", "gpu_ss0")):
            add_iniu_leaf(leaf_name, self.bottom_merge0, input_idx)

        for input_idx, leaf_name in enumerate(("dspss0", "dspss1", "dspss2", "dspss3", "dspss4", "dspss5")):
            add_iniu_leaf(leaf_name, self.dsp_merge0, input_idx)

        for input_idx, leaf_name in enumerate(("camera_ss", "mipi_ss", "gpu_ss1", "usb_dp_ss", "display_ss", "vpu_ss")):
            add_iniu_leaf(leaf_name, self.tr_merge0, input_idx)

        add_iniu_leaf("peri_ss", self.tl_merge0, 0)
        safe_connect(self, self.bottom_merge0.tniu_req, self.tl_merge0.iniu1_req)
        safe_connect(self, self.bottom_merge0.tniu_rsp, self.tl_merge0.iniu1_rsp)
        safe_connect(self, self.dsp_merge0.tniu_req, self.tl_merge0.iniu2_req)
        safe_connect(self, self.dsp_merge0.tniu_rsp, self.tl_merge0.iniu2_rsp)
        safe_connect(self, self.tr_merge0.tniu_req, self.tl_merge0.iniu3_req)
        safe_connect(self, self.tr_merge0.tniu_rsp, self.tl_merge0.iniu3_rsp)

        add_iniu_leaf("npu_ss0", self.top_spine, 0)
        safe_connect(self, self.bottom_merge1.tniu_req, self.top_spine.iniu1_req)
        safe_connect(self, self.bottom_merge1.tniu_rsp, self.top_spine.iniu1_rsp)
        add_iniu_leaf("npu_ss1", self.top_spine, 2)

        self.cpu_ss_tniu0 = DtiTniuNode(
            id="cpu_ss_tniu0_node",
            sys_cfg=cpu_tniu_sys_config,
            top_cfg=tniu_top_config,
            node_name="cpu_ss_tniu0",
            clk_name="clk_noc",
            rst_name="rst_noc_n",
        )
        self.cpu_ss_tniu1 = DtiTniuNode(
            id="cpu_ss_tniu1_node",
            sys_cfg=cpu_tniu_sys_config,
            top_cfg=tniu_top_config,
            node_name="cpu_ss_tniu1",
            clk_name="clk_noc",
            rst_name="rst_noc_n",
        )
        safe_connect(self, self.tl_merge0.tniu_req, self.cpu_ss_tniu0.top_req_data)
        safe_connect(self, self.cpu_ss_tniu0.top_rsp, self.tl_merge0.tniu_rsp)
        safe_connect(self, self.top_spine.tniu_req, self.cpu_ss_tniu1.top_req_data)
        safe_connect(self, self.cpu_ss_tniu1.top_rsp, self.top_spine.tniu_rsp)

        self.expose_unconnected_interfaces()

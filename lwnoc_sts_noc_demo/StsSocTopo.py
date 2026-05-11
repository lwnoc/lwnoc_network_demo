from _project_env import LWNOC_TOPO_ROOT, THIS_DIR

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from StsNode import StsDecNode, StsIniuNode, StsNodeIdConstNode, StsTniuNode
from StsTemplate import (
    STS_SOC_DECODER_CONFIGS,
    STS_SOC_DECODER_ROUTE_GROUPS,
    STS_SOC_INIU_NODE_IDS,
    STS_SOC_TNIU_CONFIGS,
    SRC_ID_WIDTH,
    aon_ss_iniu_sys_config,
    aon_ss_iniu_top_side_config,
)


BLUE_CHAIN_LEAF_OWNERSHIP = {}
SOC_STS_NOC_TOP_ID = "soc_sts_noc"


STS_SOC_DECODER_CHILDREN = {
    "sts_dec_l0_root": (
        ("leaf", "safetyss_aon_local"),
        ("leaf", "npuss1"),
        ("leaf", "display_ss"),
        ("leaf", "vpuss"),
        ("leaf", "usb_dpss"),
        ("leaf", "mipiss"),
        ("leaf", "gpuss1"),
        ("leaf", "nocss"),
        ("dec", "sts_dec_l1_upper_ctrl"),
        ("dec", "sts_dec_l1_right_upper"),
    ),
    "sts_dec_l1_upper_ctrl": (
        ("leaf", "camera_ss"),
        ("leaf", "mcuss"),
        ("leaf", "periss"),
        ("leaf", "npuss0"),
        ("leaf", "debug_ss"),
        ("leaf", "cpuss"),
        ("dec", "sts_dec_l2_left_ddr"),
    ),
    "sts_dec_l2_left_ddr": (
        ("leaf", "ddrss0"),
        ("leaf", "ddrss1"),
        ("leaf", "ddrss2"),
        ("leaf", "ddrss3"),
        ("leaf", "ddrss4"),
        ("leaf", "ddrss5"),
    ),
    "sts_dec_l1_right_upper": (
        ("leaf", "vdspss0"),
        ("leaf", "vdspss1"),
        ("leaf", "vdspss2"),
        ("leaf", "ddrss6"),
        ("leaf", "ddrss7"),
        ("leaf", "ddrss8"),
        ("dec", "sts_dec_l2_right_lower"),
    ),
    "sts_dec_l2_right_lower": (
        ("leaf", "vdspss3"),
        ("leaf", "vdspss4"),
        ("leaf", "vdspss5"),
        ("leaf", "ddrss9"),
        ("leaf", "ddrss10"),
        ("leaf", "ddrss11"),
        ("dec", "sts_dec_l3_lower_mid"),
    ),
    "sts_dec_l3_lower_mid": (
        ("leaf", "npuss2"),
        ("leaf", "npuss3"),
        ("leaf", "npuss4"),
        ("leaf", "gpuss0"),
        ("leaf", "ufsss"),
        ("leaf", "pcie_ethss"),
    ),
}

for dec_name, children in STS_SOC_DECODER_CHILDREN.items():
    if len(children) != len(STS_SOC_DECODER_ROUTE_GROUPS[dec_name]):
        raise ValueError(f"{dec_name} child count does not match route-group count")
    for child_kind, child_name in children:
        if child_kind == "leaf" and child_name not in STS_SOC_TNIU_CONFIGS:
            raise ValueError(f"unknown TNIU leaf '{child_name}' referenced by {dec_name}")
        if child_kind == "dec" and child_name not in STS_SOC_DECODER_CONFIGS:
            raise ValueError(f"unknown decoder '{child_name}' referenced by {dec_name}")
        if child_kind not in {"leaf", "dec"}:
            raise ValueError(f"unsupported child kind '{child_kind}' in {dec_name}")


class StsSocLogicTopo(UhdlWrapperNode):
    """Reviewed full-topology STS logic tree rooted at the AON INIU."""

    @staticmethod
    def _connect_iniu_to_dec(source: StsIniuNode, target: StsDecNode) -> None:
        connect(source.top_req, target.mst_req)
        connect(target.mst_rsp, source.top_rsp)
        connect(source.noc_cti_channel_out, target.mst_cti_channel_in)
        connect(target.mst_cti_channel_out, source.noc_cti_channel_in)
        connect(source.noc_dbg_timestamp_out, target.mst_dbg_timestamp)
        connect(target.mst_dbg_data, source.noc_dbg_data_in)

    @staticmethod
    def _connect_dec_to_dec(parent: StsDecNode, slot: int, child: StsDecNode) -> None:
        connect(getattr(parent, f"s{slot}_req"), child.mst_req)
        connect(child.mst_rsp, getattr(parent, f"s{slot}_rsp"))
        connect(child.mst_cti_channel_out, getattr(parent, f"s{slot}_cti_channel_in"))
        connect(getattr(parent, f"s{slot}_cti_channel_out"), child.mst_cti_channel_in)
        connect(getattr(parent, f"s{slot}_dbg_timestamp"), child.mst_dbg_timestamp)
        connect(child.mst_dbg_data, getattr(parent, f"s{slot}_dbg_data"))

    @staticmethod
    def _connect_dec_to_leaf(parent: StsDecNode, slot: int, child: StsTniuNode) -> None:
        connect(getattr(parent, f"s{slot}_req"), child.top_req)
        connect(child.top_rsp, getattr(parent, f"s{slot}_rsp"))
        connect(child.noc_ctm_channel_out, getattr(parent, f"s{slot}_cti_channel_in"))
        connect(getattr(parent, f"s{slot}_cti_channel_out"), child.noc_ctm_channel_in)
        connect(getattr(parent, f"s{slot}_dbg_timestamp"), child.noc_dbg_timestamp_in)
        connect(child.noc_dbg_data_out, getattr(parent, f"s{slot}_dbg_data"))

    def __init__(self):
        super().__init__(id=SOC_STS_NOC_TOP_ID)

        self.add_interface("clk_sys", is_global=True)
        self.add_interface("rst_sys_n", is_global=True)
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rst_dbg_timer_n", is_global=True)

        self.aon_ss_iniu = StsIniuNode(
            id="aon_ss_iniu",
            sys_cfg=aon_ss_iniu_sys_config,
            noc_cfg=aon_ss_iniu_top_side_config,
        )
        self.aon_ss_iniu_node_id = StsNodeIdConstNode(
            id="aon_ss_iniu_node_id",
            node_id_value=STS_SOC_INIU_NODE_IDS["aon_ss_iniu"],
            node_id_width=SRC_ID_WIDTH,
        )
        connect(self.aon_ss_iniu.clk_src, self.clk_sys)
        connect(self.aon_ss_iniu.rstn_src, self.rst_sys_n)
        connect(self.aon_ss_iniu.clk_dst, self.clk_noc)
        connect(self.aon_ss_iniu.rstn_dst, self.rst_noc_n)
        connect(self.aon_ss_iniu_node_id.node_id, self.aon_ss_iniu.node_id)

        self.decoder_nodes = {}
        for dec_name, cfg in STS_SOC_DECODER_CONFIGS.items():
            node = StsDecNode(
                id=dec_name,
                slave_num=len(STS_SOC_DECODER_ROUTE_GROUPS[dec_name]),
                cfg=cfg,
            )
            setattr(self, dec_name, node)
            self.decoder_nodes[dec_name] = node
            connect(node.clk, self.clk_noc)
            connect(node.rst_n, self.rst_noc_n)

        self.tniu_nodes = {}
        for leaf_name, (sys_cfg, noc_cfg) in STS_SOC_TNIU_CONFIGS.items():
            node = StsTniuNode(
                id=f"{leaf_name}_tniu",
                sys_cfg=sys_cfg,
                noc_cfg=noc_cfg,
            )
            setattr(self, f"{leaf_name}_tniu", node)
            self.tniu_nodes[leaf_name] = node
            connect(node.clk_src, self.clk_sys)
            connect(node.rstn_src, self.rst_sys_n)
            connect(node.clk_dst, self.clk_noc)
            connect(node.rstn_dst, self.rst_noc_n)
            connect(node.clk_dbg_timer, self.clk_dbg_timer)
            connect(node.rstn_dbg_timer, self.rst_dbg_timer_n)

        self.harden_dn_leaf_names = tuple(sorted(self.tniu_nodes.keys()))
        self.harden_up_leaf_names = tuple()
        self.iniu_node_ids = dict(STS_SOC_INIU_NODE_IDS)

        self._connect_iniu_to_dec(self.aon_ss_iniu, self.decoder_nodes["sts_dec_l0_root"])

        for dec_name, children in STS_SOC_DECODER_CHILDREN.items():
            parent = self.decoder_nodes[dec_name]
            for slot, (child_kind, child_name) in enumerate(children):
                if child_kind == "leaf":
                    self._connect_dec_to_leaf(parent, slot, self.tniu_nodes[child_name])
                else:
                    self._connect_dec_to_dec(parent, slot, self.decoder_nodes[child_name])

        self.expose_unconnected_interfaces()

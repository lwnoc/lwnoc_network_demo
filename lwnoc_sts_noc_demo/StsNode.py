import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from uhdl.uhdl.core import BitXor, Component, Input, Output, UInt
from uhdl.uhdl.core.TemplateIP import TemplateComponent, TemplateIPConfig

from StsTemplate import (
    sts_demo_dec4_config,
    sts_demo_iniu_top_side_config,
    sts_demo_link_buf_config,
    sts_demo_link_pipe_config,
    sts_demo_req_rsp_async_config,
    sts_demo_tniu0_config,
    sts_demo_tniu1_config,
    sts_demo_tniu2_config,
    sts_demo_tniu3_config,
)


sts_demo_req_rsp_async_raw_config = TemplateIPConfig(
    name="sts_demo_req_rsp_async_raw",
    filelist=sts_demo_req_rsp_async_config.filelist,
    prefix="",
)


class StsReqSinkComponent(Component):
    def __init__(self, payload_width: int = 119):
        self._payload_width = payload_width
        super().__init__()

    def circuit(self):
        self.req_vld = Input(UInt(1))
        self.req_rdy = Output(UInt(1))
        self.req_pld = Input(UInt(self._payload_width))
        self.req_rdy += UInt(1, 1)


class StsReqSinkNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_sink", payload_width: int = 119):
        comp = StsReqSinkComponent(payload_width=payload_width)
        super().__init__(id=id, impl=comp)

        self.add_interface("req", r"^req_(vld|rdy|pld)$")


class StsReqZeroSourceComponent(Component):
    def __init__(self, payload_width: int = 119):
        self._payload_width = payload_width
        super().__init__()

    def circuit(self):
        self.req_vld = Output(UInt(1))
        self.req_rdy = Input(UInt(1))
        self.req_pld = Output(UInt(self._payload_width))
        self.req_vld += BitXor(UInt(1, 1), UInt(1, 1))
        self.req_pld += BitXor(UInt(self._payload_width, 1), UInt(self._payload_width, 1))


class StsReqZeroSourceNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_zero_source", payload_width: int = 119):
        comp = StsReqZeroSourceComponent(payload_width=payload_width)
        super().__init__(id=id, impl=comp)

        self.add_interface("req", r"^req_(vld|rdy|pld)$")


class StsReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_slv"):
        comp = TemplateComponent(config=sts_demo_req_rsp_async_raw_config, top="sts_async_bridge_slv")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_mst"):
        comp = TemplateComponent(config=sts_demo_req_rsp_async_raw_config, top="sts_async_bridge_mst")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("m_chan", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsLinkPipeNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_pipe"):
        comp = TemplateComponent(config=sts_demo_link_pipe_config, top="sts_link_pipe")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")


class StsLinkBufNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_buf"):
        comp = TemplateComponent(config=sts_demo_link_buf_config, top="sts_link_buf")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


class StsIniuNode(UhdlComponentNode):
    def __init__(self, id: str = "iniu0"):
        params = getattr(sts_demo_iniu_top_side_config, 'param_overrides', {})
        comp = TemplateComponent(config=sts_demo_iniu_top_side_config, top="sts_demo_iniu_wrap", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        self.add_interface("axi", r"^s_.*")
        self.add_interface("req", r"^out_req_.*")
        self.add_interface("rsp", r"^in_rsp_.*")


class StsDec4Node(UhdlComponentNode):
    def __init__(self, id: str = "noc_dec"):
        params = getattr(sts_demo_dec4_config, 'param_overrides', {})
        comp = TemplateComponent(config=sts_demo_dec4_config, top="sts_demo_dec4_wrap", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("mst_req", r"^mst_req_.*")
        self.add_interface("mst_rsp", r"^mst_rsp_.*")
        self.add_interface("slv0_req", r"^slv0_req_.*")
        self.add_interface("slv0_rsp", r"^slv0_rsp_.*")
        self.add_interface("slv1_req", r"^slv1_req_.*")
        self.add_interface("slv1_rsp", r"^slv1_rsp_.*")
        self.add_interface("slv2_req", r"^slv2_req_.*")
        self.add_interface("slv2_rsp", r"^slv2_rsp_.*")
        self.add_interface("slv3_req", r"^slv3_req_.*")
        self.add_interface("slv3_rsp", r"^slv3_rsp_.*")


class _BaseStsTniuNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, top: str):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top=top, **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("clk_dbg_timer", r"^clk_dbg_timer$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("rstn_dbg_timer", r"^rstn_dbg_timer$")
        self.add_interface("req", r"^in_req_.*")
        self.add_interface("rsp", r"^out_rsp_.*")
        self.add_interface("pmc_apb", r"^pmc_.*")
        self.add_interface("sys_apb", r"^m_.*")
        self.add_interface("dbg_data", r"^dbg_data_.*")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*")
        self.add_interface("sys_cti_event", r"^sys_cti_event_.*")
        self.add_interface("noc_cti_event", r"^noc_cti_event_.*")
        self.add_interface("sys_cti_channel", r"^sys_cti_channel_.*")
        self.add_interface("noc_cti_channel", r"^noc_cti_channel_.*")


class StsTniu0Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu0"):
        super().__init__(id=id, cfg=sts_demo_tniu0_config, top="sts_demo_tniu0_wrap")


class StsTniu1Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu1"):
        super().__init__(id=id, cfg=sts_demo_tniu1_config, top="sts_demo_tniu1_wrap")


class StsTniu2Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu2"):
        super().__init__(id=id, cfg=sts_demo_tniu2_config, top="sts_demo_tniu2_wrap")


class StsTniu3Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu3"):
        super().__init__(id=id, cfg=sts_demo_tniu3_config, top="sts_demo_tniu3_wrap")


STS_TNIU_NODE_TYPES = (
    StsTniu0Node,
    StsTniu1Node,
    StsTniu2Node,
    StsTniu3Node,
)


def make_sts_tniu_node(tniu_idx: int, id: str | None = None) -> _BaseStsTniuNode:
    node_type = STS_TNIU_NODE_TYPES[tniu_idx]
    return node_type(id=id or f"tniu{tniu_idx}")
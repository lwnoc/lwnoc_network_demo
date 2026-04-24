import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from uhdl.uhdl.core import BitXor, Component, Input, Output, UInt
from uhdl.uhdl.core.TemplateIP import TemplateComponent, TemplateIPConfig

from StsTemplate import *


def _pack_int(width: int, values: list[int]) -> int:
    result = 0
    mask = (1 << width) - 1
    for value in values:
        result = (result << width) | (value & mask)
    return result


def _sv_param(total_bits: int, value: int) -> str:
    hex_digits = max(1, (total_bits + 3) // 4)
    return f"{total_bits}'h{value:0{hex_digits}X}"



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
    def __init__(self, id: str = "sts_req_rsp_async_slv", cfg=soc_sts_req_rsp_async_raw_config):
        comp = TemplateComponent(config=cfg, top="sts_async_bridge_slv",
            DATA_WIDTH=119,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_mst", cfg=soc_sts_req_rsp_async_raw_config):
        comp = TemplateComponent(config=cfg, top="sts_async_bridge_mst",
            DATA_WIDTH=119,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("m_chan", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsReqRspAsyncBridgeNode(UhdlWrapperNode):
    def __init__(self, id: str = "sts_async_bridge"):
        super().__init__(id=id)
        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("s_chan")
        self.add_interface("m_chan")

        self.slv_side = StsReqRspAsyncBridgeSlvNode(id=f"{id}_slv")
        self.mst_side = StsReqRspAsyncBridgeMstNode(id=f"{id}_mst")

        connect(self.slv_side.clk, self.clk_src)
        connect(self.slv_side.rst_n, self.rst_src_n)
        connect(self.mst_side.clk, self.clk_dst)
        connect(self.mst_side.rst_n, self.rst_dst_n)
        connect(self.slv_side.s_chan, self.s_chan)
        connect(self.mst_side.m_chan, self.m_chan)
        connect(self.slv_side.sync, self.mst_side.sync)
        self.expose_unconnected_interfaces()


class StsLinkPipeNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_pipe", cfg=soc_sts_link_pipe_config):
        comp = TemplateComponent(config=cfg, top="sts_link_pipe")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")


class StsLinkBufNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_buf", cfg=soc_sts_link_buf_config):
        comp = TemplateComponent(config=cfg, top="sts_link_buf")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


class StsIniuNode(UhdlComponentNode):
    def __init__(self, id: str = "iniu0", cfg=aon_ss_iniu_top_side_config, top: str = "sts_iniu_top"):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top=top, struct_mode="packed", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        self.add_interface("axi", r"^s_.*")
        self.add_interface("req", r"^out_req_.*")
        self.add_interface("rsp", r"^in_rsp_.*")


# CONSTRAINT: Node class names must NOT encode specific config parameters.
# Naming convention: StsDecNode (not StsDec4Node), because the decoder topology
# is generic — slave count, route policy, etc. are driven by TemplateIPConfig
# and constructor arguments, not by a hardcoded numeric suffix in the class name.
# This keeps the node class reusable across different decoder configurations.
# CONSTRAINT: Route table values MUST come from cfg, not hardcoded in the node.
# See soc_sts_dec4_config._route_base_table / _route_mask_val in StsTemplate.py.
class StsDecNode(UhdlComponentNode):
    def __init__(self, id: str = "noc_dec", slave_num: int = 4, cfg=soc_sts_dec4_config):
        if slave_num < 1 or slave_num > 4:
            raise ValueError(f"slave_num must be in [1, 4], got {slave_num}")

        params = dict(getattr(cfg, 'param_overrides', {}))
        # Route table driven by cfg, not hardcoded in node
        route_table = getattr(cfg, '_route_base_table', [0x30, 0x20, 0x10, 0x00])
        route_mask = getattr(cfg, '_route_mask_val', 0xB0)
        route_base_values = route_table[-slave_num:]
        route_mask_values = [route_mask] * slave_num
        route_base_int = _pack_int(TGT_ID_WIDTH, route_base_values)
        route_mask_int = _pack_int(TGT_ID_WIDTH, route_mask_values)
        params.update(
            {
                "STS_DEMO_DEC_SLAVE_NUM": slave_num,
                "STS_DEMO_ROUTE_BASE": _sv_param(slave_num * TGT_ID_WIDTH, route_base_int),
                "STS_DEMO_ROUTE_MASK": _sv_param(slave_num * TGT_ID_WIDTH, route_mask_int),
            }
        )

        comp = TemplateComponent(config=cfg, top="sts_noc_dec_node", struct_mode="packed", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("mst_req", r"^mst_req_.*")
        self.add_interface("mst_rsp", r"^mst_rsp_.*")
        if slave_num >= 1:
            self.add_interface("slv0_req", r"^slv0_req_.*")
            self.add_interface("slv0_rsp", r"^slv0_rsp_.*")
        if slave_num >= 2:
            self.add_interface("slv1_req", r"^slv1_req_.*")
            self.add_interface("slv1_rsp", r"^slv1_rsp_.*")
        if slave_num >= 3:
            self.add_interface("slv2_req", r"^slv2_req_.*")
            self.add_interface("slv2_rsp", r"^slv2_rsp_.*")
        if slave_num >= 4:
            self.add_interface("slv3_req", r"^slv3_req_.*")
            self.add_interface("slv3_rsp", r"^slv3_rsp_.*")


class StsTniuTopNode(UhdlComponentNode):
    """TNIU top-side node — wraps end-point access via top-side config."""
    def __init__(self, id: str, cfg: TemplateIPConfig, top: str):
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


class StsTniuSysNode(UhdlComponentNode):
    """TNIU system-side leaf — hierarchical inside sts_tniu_top."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        comp = TemplateComponent(config=cfg, top="sts_tniu_sys", struct_mode="packed")
        super().__init__(id=id, impl=comp)
        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        # Add remaining sys-side interfaces from RTL contract as needed


class StsTniuWrapNode(UhdlWrapperNode):
    """TNIU composite: sys + top sides, exposed via unwrapped interfaces."""
    def __init__(self, id: str, sys_cfg: TemplateIPConfig, top_cfg: TemplateIPConfig, top_wrap: str = "sts_tniu_top"):
        super().__init__(id=id)
        # Expose integration-facing clock/reset interfaces
        self.add_interface("clk_src")  # sys-side source
        self.add_interface("rstn_src")
        self.add_interface("clk_dst")  # top-side/target
        self.add_interface("rstn_dst")
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rstn_dbg_timer", is_global=True)
        self.add_interface("req")
        self.add_interface("rsp")
        self.add_interface("pmc_apb")
        self.add_interface("sys_apb")
        self.add_interface("dbg_data")
        self.add_interface("dbg_timestamp")
        self.add_interface("sys_cti_event")
        self.add_interface("noc_cti_event")
        self.add_interface("sys_cti_channel")
        self.add_interface("noc_cti_channel")

        self.sys_side = StsTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.top_side = StsTniuTopNode(id=f"{id}_top", cfg=top_cfg, top=top_wrap)

        # Connect sys↔top clock crossing — async bridge handles the crossing
        connect(self.sys_side.clk, self.clk_src)
        connect(self.sys_side.rst_n, self.rstn_src)

        # Top-side clock/reset
        connect(self.top_side.clk_src, self.clk_src)
        connect(self.top_side.rstn_src, self.rstn_src)
        connect(self.top_side.clk_dst, self.clk_dst)
        connect(self.top_side.rstn_dst, self.rstn_dst)
        connect(self.top_side.clk_dbg_timer, self.clk_dbg_timer)
        connect(self.top_side.rstn_dbg_timer, self.rstn_dbg_timer)
        connect(self.top_side.req, self.req)
        connect(self.top_side.rsp, self.rsp)
        connect(self.top_side.pmc_apb, self.pmc_apb)
        connect(self.top_side.sys_apb, self.sys_apb)
        connect(self.top_side.dbg_data, self.dbg_data)
        connect(self.top_side.dbg_timestamp, self.dbg_timestamp)
        connect(self.top_side.sys_cti_event, self.sys_cti_event)
        connect(self.top_side.noc_cti_event, self.noc_cti_event)
        connect(self.top_side.sys_cti_channel, self.sys_cti_channel)
        connect(self.top_side.noc_cti_channel, self.noc_cti_channel)

        self.expose_unconnected_interfaces()
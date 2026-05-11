import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from uhdl.uhdl.core import Input, Output, UInt
from uhdl.uhdl.core.Component import Component
from uhdl.uhdl.core.TemplateIP import TemplateComponent, TemplateIPConfig

from StsTemplate import (
    STS_DEMO_DBG_TIMESTAMP_WIDTH,
    STS_DEMO_DBG_DATA_WIDTH,
    TemplateIPConfig,
    soc_sts_req_rsp_async_raw_config,
    soc_sts_link_pipe_config,
    soc_sts_link_buf_config,
)


INIU_AXI_SIGNAL_NAMES = (
    "awvalid",
    "awready",
    "awid",
    "awaddr",
    "awlen",
    "awsize",
    "awburst",
    "awlock",
    "awcache",
    "awprot",
    "awqos",
    "awuser",
    "wvalid",
    "wready",
    "wdata",
    "wstrb",
    "wlast",
    "bvalid",
    "bready",
    "bid",
    "bresp",
    "arvalid",
    "arready",
    "arid",
    "araddr",
    "arlen",
    "arsize",
    "arburst",
    "arlock",
    "arcache",
    "arprot",
    "arqos",
    "aruser",
    "rvalid",
    "rready",
    "rid",
    "rdata",
    "rresp",
    "rlast",
)


class StsReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_slv", cfg=soc_sts_req_rsp_async_raw_config):
        comp = TemplateComponent(config=cfg, top="sts_async_bridge_slv",
            DATA_WIDTH=120,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("stall", r"^stall$", emit_io=False)
        self.add_interface("clear", r"^clear$", emit_io=False)
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("status", r"^(full_zero|almost_full)$", emit_io=False)
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_mst", cfg=soc_sts_req_rsp_async_raw_config):
        comp = TemplateComponent(config=cfg, top="sts_async_bridge_mst",
            DATA_WIDTH=120,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("stall", r"^stall$", emit_io=False)
        self.add_interface("clear", r"^clear$", emit_io=False)
        self.add_interface("m_chan", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("status", r"^(full_zero|idle|almost_empty)$", emit_io=False)
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("sb_err", r"^sb_err$")
        self.add_interface("db_err", r"^db_err$")


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


class StsNodeIdConstComponent(Component):
    def __init__(self, node_id_value: int = 0, node_id_width: int = 8):
        self._node_id_value = node_id_value
        self._node_id_width = node_id_width
        super().__init__()

    @property
    def module_name(self):
        return (
            f"StsNodeIdConst_node_id_value_{self._node_id_value}"
            f"_node_id_width_{self._node_id_width}"
        )

    def circuit(self):
        self.node_id = Output(UInt(self._node_id_width))
        self.node_id += UInt(self._node_id_width, self._node_id_value)


class StsNodeIdConstNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_node_id_const", node_id_value: int = 0, node_id_width: int = 8):
        comp = StsNodeIdConstComponent(node_id_value=node_id_value, node_id_width=node_id_width)
        super().__init__(id=id, impl=comp)
        self.add_interface("node_id", "node_id")


class StsIniuSysNode(UhdlComponentNode):
    """INIU system-side — AXI slave + async FIFO write + CTI/debug."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        comp = TemplateComponent(config=cfg, top="sts_iniu_sys")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        for signal_name in INIU_AXI_SIGNAL_NAMES:
            self.add_interface(f"axi_{signal_name}", rf"^s_{signal_name}$")
        # async_fifo — cross-connect to noc side (same port naming convention on both sides)
        self.add_interface("async_fifo", r".*(wptr_async|rptr_async|rptr_sync|pld_sync)")
        # CTI/CTM event pass-through (CDC in sys→noc direction)
        self.add_interface("cti_event_in", r"^cti_trig_in$")
        self.add_interface("cti_event_out", r"^cti_trig_in_o$")
        self.add_interface("cti_event_ack_in", r"^cti_trig_in_ack$")
        self.add_interface("cti_event_ack_out", r"^cti_trig_in_ack_o$")
        self.add_interface("cti_event_out_rev", r"^cti_trig_out$")
        self.add_interface("cti_event_out_rev_o", r"^cti_trig_out_o$")
        self.add_interface("cti_event_out_ack", r"^cti_trig_out_ack$")
        self.add_interface("cti_event_out_ack_o", r"^cti_trig_out_ack_o$")
        self.add_interface("ctm_event_in", r"^ctm_trig_in$")
        self.add_interface("ctm_event_out", r"^ctm_trig_in_o$")
        self.add_interface("ctm_event_ack_in", r"^ctm_trig_in_ack$")
        self.add_interface("ctm_event_ack_out", r"^ctm_trig_in_ack_o$")
        self.add_interface("ctm_event_out_rev", r"^ctm_trig_out$")
        self.add_interface("ctm_event_out_rev_o", r"^ctm_trig_out_o$")
        self.add_interface("ctm_event_out_ack", r"^ctm_trig_out_ack$")
        self.add_interface("ctm_event_out_ack_o", r"^ctm_trig_out_ack_o$")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*$")
        self.add_interface("dbg_data", r"^dbg_data_.*$")
        self.add_interface("safety", r"^safety_.*$")  # all safety_* error outputs


class StsIniuNocNode(UhdlComponentNode):
    """INIU noc-side — CDC read side + NoC req/rsp + CTI/debug (no AXI, no node_id)."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        comp = TemplateComponent(config=cfg, top="sts_iniu_noc")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rst_n_dst", r"^rst_n_dst$")
        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("rst_n_src", r"^rst_n_src$")
        self.add_interface("async_fifo", r".*(wptr_async|rptr_async|rptr_sync|pld_sync)")
        self.add_interface("req", r"^req_s_(vld|rdy|pld)$")   # req_s_vld, req_s_rdy, req_s_pld
        self.add_interface("rsp", r"^rsp_m_(vld|rdy|pld)$")   # rsp_m_vld, rsp_m_rdy, rsp_m_pld
        self.add_interface("cti_channel_in", r"^ctm_channel_in$")
        self.add_interface("cti_channel_out", r"^ctm_channel_out$")
        self.add_interface("cti_event", r"^cti_trig_.*$")
        self.add_interface("ctm_event", r"^ctm_trig_.*$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("cti_apb", r"^cti_apb_.*$")
        self.add_interface("req_afifo_sb_err", r"^req_afifo_sb_err$")
        self.add_interface("req_afifo_db_err", r"^req_afifo_db_err$")


# NOTE: No intermediate SysWrapNode/NocWrapNode needed — StsIniuNode directly
# wraps the two component nodes (DTI 2-layer composite pattern).


class StsIniuNode(UhdlWrapperNode):
    """INIU composite: sys side + noc side + async_fifo cross-connection."""
    def __init__(self, id: str, sys_cfg: TemplateIPConfig, noc_cfg: TemplateIPConfig):
        super().__init__(id=id)
        self.sys_side = StsIniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.noc_side = StsIniuNocNode(id=f"{id}_noc", cfg=noc_cfg)

        self.add_interface("clk_src", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
        self.add_interface("top_req")
        self.add_interface("top_rsp")
        self.add_interface("node_id")
        for signal_name in INIU_AXI_SIGNAL_NAMES:
            self.add_interface(f"axi_{signal_name}")
        self.add_interface("noc_cti_channel_in")
        self.add_interface("noc_cti_channel_out")
        self.add_interface("cti_event_in")
        self.add_interface("cti_event_out")
        self.add_interface("cti_event_ack_in")
        self.add_interface("cti_event_ack_out")
        self.add_interface("cti_event_out_rev")
        self.add_interface("cti_event_out_rev_o")
        self.add_interface("cti_event_out_ack")
        self.add_interface("cti_event_out_ack_o")
        self.add_interface("ctm_event_in")
        self.add_interface("ctm_event_out")
        self.add_interface("ctm_event_ack_in")
        self.add_interface("ctm_event_ack_out")
        self.add_interface("ctm_event_out_rev")
        self.add_interface("ctm_event_out_rev_o")
        self.add_interface("ctm_event_out_ack")
        self.add_interface("ctm_event_out_ack_o")
        self.add_interface("dbg_timestamp")
        self.add_interface("dbg_data")
        self.add_interface("noc_dbg_timestamp_in")
        self.add_interface("noc_dbg_timestamp_out")
        self.add_interface("noc_dbg_data_in")
        self.add_interface("noc_dbg_data_out")
        self.add_interface("safety")

        connect(self.sys_side.clk_src, self.clk_src)
        connect(self.sys_side.rstn_src, self.rstn_src)
        connect(self.sys_side.clk_dst, self.clk_dst)
        connect(self.sys_side.rstn_dst, self.rstn_dst)
        connect(self.noc_side.clk_dst, self.clk_dst)
        connect(self.noc_side.rst_n_dst, self.rstn_dst)
        connect(self.noc_side.clk_src, self.clk_src)
        connect(self.noc_side.rst_n_src, self.rstn_src)

        connect(self.sys_side.async_fifo, self.noc_side.async_fifo)
        connect(self.noc_side.req, self.top_req)
        connect(self.noc_side.rsp, self.top_rsp)
        connect(self.noc_side.cti_channel_in, self.noc_cti_channel_in)
        connect(self.noc_side.cti_channel_out, self.noc_cti_channel_out)
        connect(self.sys_side.node_id, self.node_id)
        for signal_name in INIU_AXI_SIGNAL_NAMES:
            connect(getattr(self.sys_side, f"axi_{signal_name}"), getattr(self, f"axi_{signal_name}"))
        connect(self.sys_side.cti_event_in, self.cti_event_in)
        connect(self.sys_side.cti_event_out, self.cti_event_out)
        connect(self.sys_side.cti_event_ack_in, self.cti_event_ack_in)
        connect(self.sys_side.cti_event_ack_out, self.cti_event_ack_out)
        connect(self.sys_side.cti_event_out_rev, self.cti_event_out_rev)
        connect(self.sys_side.cti_event_out_rev_o, self.cti_event_out_rev_o)
        connect(self.sys_side.cti_event_out_ack, self.cti_event_out_ack)
        connect(self.sys_side.cti_event_out_ack_o, self.cti_event_out_ack_o)
        connect(self.sys_side.ctm_event_in, self.ctm_event_in)
        connect(self.sys_side.ctm_event_out, self.ctm_event_out)
        connect(self.sys_side.ctm_event_ack_in, self.ctm_event_ack_in)
        connect(self.sys_side.ctm_event_ack_out, self.ctm_event_ack_out)
        connect(self.sys_side.ctm_event_out_rev, self.ctm_event_out_rev)
        connect(self.sys_side.ctm_event_out_rev_o, self.ctm_event_out_rev_o)
        connect(self.sys_side.ctm_event_out_ack, self.ctm_event_out_ack)
        connect(self.sys_side.ctm_event_out_ack_o, self.ctm_event_out_ack_o)
        connect(self.sys_side.dbg_timestamp, self.dbg_timestamp)
        connect(self.sys_side.dbg_data, self.dbg_data)
        connect(self.noc_side.dbg_timestamp_in, self.noc_dbg_timestamp_in)
        connect(self.noc_side.dbg_timestamp_out, self.noc_dbg_timestamp_out)
        connect(self.noc_side.dbg_data_in, self.noc_dbg_data_in)
        connect(self.noc_side.dbg_data_out, self.noc_dbg_data_out)
        connect(self.sys_side.safety, self.safety)

    @property
    def top_side(self):
        return self.noc_side


# ═══════════════════════════════════════════════════════════════════════════════
# TNIU nodes — sys/noc 基础节点 + sys/noc wrapper + TNIU composite
# ═══════════════════════════════════════════════════════════════════════════════

class StsTniuSysNode(UhdlComponentNode):
    """TNIU system-side — APB + CTI/debug + async FIFO write."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        comp = TemplateComponent(config=cfg, top="sts_tniu_sys")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("clk_dbg_timer", r"^clk_dbg_timer$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("rstn_dbg_timer", r"^rstn_dbg_timer$")
        self.add_interface("async_fifo", r".*(wptr_async|rptr_async|rptr_sync|pld_sync)")
        self.add_interface("sys_apb", r"^m_.*$")  # m_psel, m_paddr, etc.
        # CTI/CTM event pass-through
        self.add_interface("cti_event_in_i", r"^cti_trig_in_i$")
        self.add_interface("cti_event_in_o", r"^cti_trig_in_o$")
        self.add_interface("cti_event_in_ack_i", r"^cti_trig_in_ack_i$")
        self.add_interface("cti_event_in_ack_o", r"^cti_trig_in_ack_o$")
        self.add_interface("cti_event_out_i", r"^cti_trig_out_i$")
        self.add_interface("cti_event_out_o", r"^cti_trig_out_o$")
        self.add_interface("cti_event_out_ack_i", r"^cti_trig_out_ack_i$")
        self.add_interface("cti_event_out_ack_o", r"^cti_trig_out_ack_o$")
        self.add_interface("ctm_event_in_i", r"^ctm_trig_in_i$")
        self.add_interface("ctm_event_in_o", r"^ctm_trig_in_o$")
        self.add_interface("ctm_event_in_ack_i", r"^ctm_trig_in_ack_i$")
        self.add_interface("ctm_event_in_ack_o", r"^ctm_trig_in_ack_o$")
        self.add_interface("ctm_event_out_i", r"^ctm_trig_out_i$")
        self.add_interface("ctm_event_out_o", r"^ctm_trig_out_o$")
        self.add_interface("ctm_event_out_ack_i", r"^ctm_trig_out_ack_i$")
        self.add_interface("ctm_event_out_ack_o", r"^ctm_trig_out_ack_o$")
        self.add_interface("dbg_data", r"^dbg_data_.*$")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*$")
        self.add_interface("safety", r"^sts_tniu_req_afifo_.*$")  # sb_err/db_err


class StsTniuNocNode(UhdlComponentNode):
    """TNIU noc-side — NoC req/rsp crossover + CDC read side + APB/CTI/debug."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        params = {}
        # Override localparam REQ_PLD_WIDTH/RSP_PLD_WIDTH that UHDL/slang can't resolve.
        # STS_REQ_WIDTH = STS_CMN(31) + STS_REQ_EXT(89) = 120
        # STS_RSP_WIDTH = STS_CMN(31) + STS_RSP_EXT(35) = 66
        params["REQ_PLD_WIDTH"] = 120
        params["RSP_PLD_WIDTH"] = 66
        comp = TemplateComponent(config=cfg, top="sts_tniu_noc", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("async_fifo", r".*(wptr_async|rptr_async|rptr_sync|pld_sync)")
        self.add_interface("req", r"^in_req_(vld|rdy|pld)$")   # in_req_vld, in_req_rdy, in_req_pld
        self.add_interface("rsp", r"^out_rsp_(vld|rdy|pld)$")  # out_rsp_vld, out_rsp_rdy, out_rsp_pld
        self.add_interface("apb", r"^(psel|penable|paddr|pwrite|pwdata|prdata|pready|pstrb|pprot|pslverr)$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("cti_event", r"^cti_trig_.*$")
        self.add_interface("ctm_channel_in", r"^ctm_channel_in$")
        self.add_interface("ctm_channel_out", r"^ctm_channel_out$")
        self.add_interface("ctm_event", r"^ctm_trig_.*$")
        self.add_interface("timing_bus1", r"^timing_bus1$")
        self.add_interface("timing_bus2", r"^timing_bus2$")
        self.add_interface("timing_bus3", r"^timing_bus3$")
        self.add_interface("dbg_en", r"^dbg_en$")
        self.add_interface("tniu_regbank_parity_err", r"^tniu_regbank_parity_err$")
        self.add_interface("rsp_afifo_sb_err", r"^rsp_afifo_sb_err$")
        self.add_interface("rsp_afifo_db_err", r"^rsp_afifo_db_err$")


class StsTniuTopSideNode(UhdlComponentNode):
    """Publication-side full TNIU top — wraps upstream sts_tniu_top."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        params = {}
        params["REQ_PLD_WIDTH"] = 120
        params["RSP_PLD_WIDTH"] = 66
        comp = TemplateComponent(config=cfg, top="sts_tniu_top", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("clk_dbg_timer", r"^clk_dbg_timer$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("rstn_dbg_timer", r"^rstn_dbg_timer$")
        self.add_interface("req", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("rsp", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("top_apb", r"^top_p.*$")
        self.add_interface("sys_apb", r"^m_.*$")
        self.add_interface("dbg_data", r"^dbg_data_.*$")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*$")
        self.add_interface("cti_event", r"^cti_trig_.*$")
        self.add_interface("ctm_event", r"^ctm_trig_.*$")
        self.add_interface("ctm_channel", r"^ctm_channel.*$")
        self.add_interface("timing_bus1", r"^timing_bus1$")
        self.add_interface("timing_bus2", r"^timing_bus2$")
        self.add_interface("timing_bus3", r"^timing_bus3$")
        self.add_interface("dbg_en", r"^dbg_en$")
        self.add_interface("tniu_regbank_parity_err", r"^tniu_regbank_parity_err$")
        self.add_interface("safety", r"^tniu_.*afifo_.*err$")


# NOTE: No intermediate SysWrapNode/NocWrapNode needed — StsTniuNode directly
# wraps the two component nodes (DTI 2-layer composite pattern).


class StsTniuNode(UhdlWrapperNode):
    """TNIU composite: sys side + noc side + async_fifo cross-connection."""
    def __init__(self, id: str, sys_cfg: TemplateIPConfig, noc_cfg: TemplateIPConfig):
        super().__init__(id=id)
        self.sys_side = StsTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.noc_side = StsTniuNocNode(id=f"{id}_noc", cfg=noc_cfg)

        self.add_interface("clk_src", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rstn_dbg_timer", is_global=True)
        self.add_interface("top_req")
        self.add_interface("top_rsp")
        self.add_interface("sys_apb")
        self.add_interface("noc_ctm_channel_in")
        self.add_interface("noc_ctm_channel_out")
        self.add_interface("cti_event_in_i")
        self.add_interface("cti_event_in_o")
        self.add_interface("cti_event_in_ack_i")
        self.add_interface("cti_event_in_ack_o")
        self.add_interface("cti_event_out_i")
        self.add_interface("cti_event_out_o")
        self.add_interface("cti_event_out_ack_i")
        self.add_interface("cti_event_out_ack_o")
        self.add_interface("ctm_event_in_i")
        self.add_interface("ctm_event_in_o")
        self.add_interface("ctm_event_in_ack_i")
        self.add_interface("ctm_event_in_ack_o")
        self.add_interface("ctm_event_out_i")
        self.add_interface("ctm_event_out_o")
        self.add_interface("ctm_event_out_ack_i")
        self.add_interface("ctm_event_out_ack_o")
        self.add_interface("dbg_data")
        self.add_interface("dbg_timestamp")
        self.add_interface("noc_dbg_data_in")
        self.add_interface("noc_dbg_data_out")
        self.add_interface("noc_dbg_timestamp_in")
        self.add_interface("noc_dbg_timestamp_out")
        self.add_interface("safety")
        self.add_interface("apb")
        self.add_interface("timing_bus1")
        self.add_interface("timing_bus2")
        self.add_interface("timing_bus3")
        self.add_interface("dbg_en")
        self.add_interface("tniu_regbank_parity_err")
        self.add_interface("rsp_afifo_sb_err")
        self.add_interface("rsp_afifo_db_err")

        connect(self.sys_side.clk_src, self.clk_src)
        connect(self.sys_side.rstn_src, self.rstn_src)
        connect(self.sys_side.clk_dst, self.clk_dst)
        connect(self.sys_side.rstn_dst, self.rstn_dst)
        connect(self.sys_side.clk_dbg_timer, self.clk_dbg_timer)
        connect(self.sys_side.rstn_dbg_timer, self.rstn_dbg_timer)
        connect(self.noc_side.clk_src, self.clk_src)
        connect(self.noc_side.rstn_src, self.rstn_src)
        connect(self.noc_side.clk_dst, self.clk_dst)
        connect(self.noc_side.rstn_dst, self.rstn_dst)

        connect(self.sys_side.async_fifo, self.noc_side.async_fifo)
        connect(self.noc_side.req, self.top_req)
        connect(self.noc_side.rsp, self.top_rsp)
        connect(self.noc_side.ctm_channel_in, self.noc_ctm_channel_in)
        connect(self.noc_side.ctm_channel_out, self.noc_ctm_channel_out)
        connect(self.sys_side.sys_apb, self.sys_apb)
        connect(self.sys_side.cti_event_in_i, self.cti_event_in_i)
        connect(self.sys_side.cti_event_in_o, self.cti_event_in_o)
        connect(self.sys_side.cti_event_in_ack_i, self.cti_event_in_ack_i)
        connect(self.sys_side.cti_event_in_ack_o, self.cti_event_in_ack_o)
        connect(self.sys_side.cti_event_out_i, self.cti_event_out_i)
        connect(self.sys_side.cti_event_out_o, self.cti_event_out_o)
        connect(self.sys_side.cti_event_out_ack_i, self.cti_event_out_ack_i)
        connect(self.sys_side.cti_event_out_ack_o, self.cti_event_out_ack_o)
        connect(self.sys_side.ctm_event_in_i, self.ctm_event_in_i)
        connect(self.sys_side.ctm_event_in_o, self.ctm_event_in_o)
        connect(self.sys_side.ctm_event_in_ack_i, self.ctm_event_in_ack_i)
        connect(self.sys_side.ctm_event_in_ack_o, self.ctm_event_in_ack_o)
        connect(self.sys_side.ctm_event_out_i, self.ctm_event_out_i)
        connect(self.sys_side.ctm_event_out_o, self.ctm_event_out_o)
        connect(self.sys_side.ctm_event_out_ack_i, self.ctm_event_out_ack_i)
        connect(self.sys_side.ctm_event_out_ack_o, self.ctm_event_out_ack_o)
        connect(self.sys_side.dbg_data, self.dbg_data)
        connect(self.sys_side.dbg_timestamp, self.dbg_timestamp)
        connect(self.noc_side.dbg_data_in, self.noc_dbg_data_in)
        connect(self.noc_side.dbg_data_out, self.noc_dbg_data_out)
        connect(self.noc_side.dbg_timestamp_in, self.noc_dbg_timestamp_in)
        connect(self.noc_side.dbg_timestamp_out, self.noc_dbg_timestamp_out)
        connect(self.sys_side.safety, self.safety)
        connect(self.noc_side.apb, self.apb)
        connect(self.noc_side.timing_bus1, self.timing_bus1)
        connect(self.noc_side.timing_bus2, self.timing_bus2)
        connect(self.noc_side.timing_bus3, self.timing_bus3)
        connect(self.noc_side.dbg_en, self.dbg_en)
        connect(self.noc_side.tniu_regbank_parity_err, self.tniu_regbank_parity_err)
        connect(self.noc_side.rsp_afifo_sb_err, self.rsp_afifo_sb_err)
        connect(self.noc_side.rsp_afifo_db_err, self.rsp_afifo_db_err)

    @property
    def top_side(self):
        return self.noc_side


# CONSTRAINT: Node class names must NOT encode specific config parameters.
# Naming convention: StsDecNode (not StsDec4Node), because the decoder topology
# is generic — slave count, route policy, etc. are driven by TemplateIPConfig
# and constructor arguments, not by a hardcoded numeric suffix in the class name.
# This keeps the node class reusable across different decoder configurations.
# CONSTRAINT: Route match values MUST come from cfg, not hardcoded in the node.
# See soc_sts_dec4_config._route_base_values / _route_mask_values in StsTemplate.py.
class StsDecNode(UhdlComponentNode):
    """STS decoder node bound to the per-slave-count 1toX wrapper RTL."""
    def __init__(self, id: str = "noc_dec", slave_num: int = 4, cfg=None):
        if slave_num < 1 or slave_num > 16:
            raise ValueError(f"slave_num must be in [1, 16], got {slave_num}")
        if cfg is None:
            from StsTemplate import soc_sts_dec4_config
            cfg = soc_sts_dec4_config

        top_name = getattr(cfg, "top_wrap", f"sts_noc_dec_node_1to{slave_num}_wrap")
        comp = TemplateComponent(
            config=cfg,
            top=top_name,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("mst_req", r"^mst_req_.*")
        self.add_interface("mst_rsp", r"^mst_rsp_.*")
        self.add_interface("mst_cti_channel_in", r"^mst_cti_channel_in$")
        self.add_interface("mst_cti_channel_out", r"^mst_cti_channel_out$")
        self.add_interface("mst_dbg_timestamp", r"^mst_dbg_timestamp$")
        self.add_interface("mst_dbg_data", r"^mst_dbg_data$")
        for idx in range(slave_num):
            self.add_interface(f"s{idx}_req", rf"^s{idx}_req_(vld|rdy|pld)$")
            self.add_interface(f"s{idx}_rsp", rf"^s{idx}_rsp_(vld|rdy|pld)$")
            self.add_interface(f"s{idx}_cti_channel_in", rf"^s{idx}_cti_channel_in$")
            self.add_interface(f"s{idx}_cti_channel_out", rf"^s{idx}_cti_channel_out$")
            self.add_interface(f"s{idx}_dbg_timestamp", rf"^s{idx}_dbg_timestamp$")
            self.add_interface(f"s{idx}_dbg_data", rf"^s{idx}_dbg_data$")



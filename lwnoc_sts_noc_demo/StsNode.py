import sys
from pathlib import Path

from _project_env import LWNOC_TOPO_ROOT, THIS_DIR

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from uhdl.uhdl.core import Input, Output, UInt, Wire
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


def _sts_prefixed_name(name: str) -> str:
    if name.startswith(("sts_noc_", "soc_sts_", "Sts")):
        return name
    if name.startswith("sts_"):
        return f"sts_noc_{name[len('sts_'):]}"
    return f"sts_noc_{name}"


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
        super().__init__(id=id, module_name=_sts_prefixed_name(id))
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
            f"sts_noc_node_id_const_node_id_value_{self._node_id_value}"
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


class StsApb32ToCtiApb12Component(Component):
    @property
    def module_name(self):
        return "sts_noc_apb32_to_cti_apb12"

    def circuit(self):
        self.tniu_apb_paddr = Input(UInt(32))
        self.tniu_apb_penable = Input(UInt(1))
        self.tniu_apb_pprot = Input(UInt(3))
        self.tniu_apb_prdata = Output(UInt(32))
        self.tniu_apb_pready = Output(UInt(1))
        self.tniu_apb_psel = Input(UInt(1))
        self.tniu_apb_pslverr = Output(UInt(1))
        self.tniu_apb_pstrb = Input(UInt(4))
        self.tniu_apb_pwdata = Input(UInt(32))
        self.tniu_apb_pwrite = Input(UInt(1))

        self.cti_apb_paddr = Output(UInt(12))
        self.cti_apb_penable = Output(UInt(1))
        self.cti_apb_prdata = Input(UInt(32))
        self.cti_apb_pready = Input(UInt(1))
        self.cti_apb_psel = Output(UInt(1))
        self.cti_apb_pslverr = Input(UInt(1))
        self.cti_apb_pwdata = Output(UInt(32))
        self.cti_apb_pwrite = Output(UInt(1))

        self.cti_apb_paddr_w = Wire(UInt(12))
        self.cti_apb_penable_w = Wire(UInt(1))
        self.cti_apb_psel_w = Wire(UInt(1))
        self.cti_apb_pwdata_w = Wire(UInt(32))
        self.cti_apb_pwrite_w = Wire(UInt(1))
        self.tniu_apb_prdata_w = Wire(UInt(32))
        self.tniu_apb_pready_w = Wire(UInt(1))
        self.tniu_apb_pslverr_w = Wire(UInt(1))

        self.cti_apb_paddr_w += self.tniu_apb_paddr[11:0]
        self.cti_apb_penable_w += self.tniu_apb_penable
        self.cti_apb_psel_w += self.tniu_apb_psel
        self.cti_apb_pwdata_w += self.tniu_apb_pwdata
        self.cti_apb_pwrite_w += self.tniu_apb_pwrite
        self.tniu_apb_prdata_w += self.cti_apb_prdata
        self.tniu_apb_pready_w += self.cti_apb_pready
        self.tniu_apb_pslverr_w += self.cti_apb_pslverr

        self.cti_apb_paddr += self.cti_apb_paddr_w
        self.cti_apb_penable += self.cti_apb_penable_w
        self.cti_apb_psel += self.cti_apb_psel_w
        self.cti_apb_pwdata += self.cti_apb_pwdata_w
        self.cti_apb_pwrite += self.cti_apb_pwrite_w
        self.tniu_apb_prdata += self.tniu_apb_prdata_w
        self.tniu_apb_pready += self.tniu_apb_pready_w
        self.tniu_apb_pslverr += self.tniu_apb_pslverr_w

    @property
    def verilog_def(self):
        module_name = self.module_name
        return [
            f"module {module_name} (",
            "\tinput  [31:0] tniu_apb_paddr  ,",
            "\tinput         tniu_apb_penable,",
            "\tinput  [2:0]  tniu_apb_pprot  ,",
            "\toutput [31:0] tniu_apb_prdata ,",
            "\toutput        tniu_apb_pready ,",
            "\tinput         tniu_apb_psel   ,",
            "\toutput        tniu_apb_pslverr,",
            "\tinput  [3:0]  tniu_apb_pstrb  ,",
            "\tinput  [31:0] tniu_apb_pwdata ,",
            "\tinput         tniu_apb_pwrite ,",
            "\toutput [11:0] cti_apb_paddr   ,",
            "\toutput        cti_apb_penable ,",
            "\tinput  [31:0] cti_apb_prdata  ,",
            "\tinput         cti_apb_pready  ,",
            "\toutput        cti_apb_psel    ,",
            "\tinput         cti_apb_pslverr ,",
            "\toutput [31:0] cti_apb_pwdata  ,",
            "\toutput        cti_apb_pwrite  );",
            "",
            "\tassign cti_apb_paddr   = tniu_apb_paddr[11:0];",
            "\tassign cti_apb_penable = tniu_apb_penable;",
            "\tassign cti_apb_psel    = tniu_apb_psel;",
            "\tassign cti_apb_pwdata  = tniu_apb_pwdata;",
            "\tassign cti_apb_pwrite  = tniu_apb_pwrite;",
            "\tassign tniu_apb_prdata = cti_apb_prdata;",
            "\tassign tniu_apb_pready = cti_apb_pready;",
            "\tassign tniu_apb_pslverr = cti_apb_pslverr;",
            "",
            "endmodule",
        ]


class StsApb32ToCtiApb12Node(UhdlComponentNode):
    def __init__(self, id: str = "sts_apb32_to_cti_apb12"):
        super().__init__(id=id, impl=StsApb32ToCtiApb12Component())
        self.add_interface("tniu_apb", r"^tniu_apb_.*$")
        self.add_interface("cti_apb", r"^cti_apb_.*$")


class StsApbIdleTargetComponent(Component):
    @property
    def module_name(self):
        return "sts_noc_apb_idle_target"

    def circuit(self):
        self.apb_paddr = Input(UInt(32))
        self.apb_penable = Input(UInt(1))
        self.apb_pprot = Input(UInt(3))
        self.apb_prdata = Output(UInt(32))
        self.apb_pready = Output(UInt(1))
        self.apb_psel = Input(UInt(1))
        self.apb_pslverr = Output(UInt(1))
        self.apb_pstrb = Input(UInt(4))
        self.apb_pwdata = Input(UInt(32))
        self.apb_pwrite = Input(UInt(1))

        self.apb_prdata += UInt(32, 0)
        self.apb_pready += UInt(1, 1)
        self.apb_pslverr += UInt(1, 0)

    @property
    def verilog_def(self):
        module_name = self.module_name
        return [
            f"module {module_name} (",
            "\tinput  [31:0] apb_paddr  ,",
            "\tinput         apb_penable,",
            "\tinput  [2:0]  apb_pprot  ,",
            "\toutput [31:0] apb_prdata ,",
            "\toutput        apb_pready ,",
            "\tinput         apb_psel   ,",
            "\toutput        apb_pslverr,",
            "\tinput  [3:0]  apb_pstrb  ,",
            "\tinput  [31:0] apb_pwdata ,",
            "\tinput         apb_pwrite );",
            "",
            "\tassign apb_prdata  = 32'h0;",
            "\tassign apb_pready  = 1'b1;",
            "\tassign apb_pslverr = 1'b0;",
            "",
            "endmodule",
        ]


class StsApbIdleTargetNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_apb_idle_target"):
        super().__init__(id=id, impl=StsApbIdleTargetComponent())
        self.add_interface("apb", r"^apb_.*$")


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
        self.add_interface("sys_cti_trigin", r"^sys_cti_trigin$")
        self.add_interface("sys_cti_trigin_ack", r"^sys_cti_trigin_ack$")
        self.add_interface("noc_cti_trigin", r"^noc_cti_trigin$")
        self.add_interface("noc_cti_trigin_ack", r"^noc_cti_trigin_ack$")
        self.add_interface("noc_cti_trigout", r"^noc_cti_trigout$")
        self.add_interface("noc_cti_trigout_ack", r"^noc_cti_trigout_ack$")
        self.add_interface("sys_cti_trigout", r"^sys_cti_trigout$")
        self.add_interface("sys_cti_trigout_ack", r"^sys_cti_trigout_ack$")
        self.add_interface("sys_ctm_trigin", r"^sys_ctm_trigin$")
        self.add_interface("sys_ctm_trigin_ack", r"^sys_ctm_trigin_ack$")
        self.add_interface("noc_ctm_trigin", r"^noc_ctm_trigin$")
        self.add_interface("noc_ctm_trigin_ack", r"^noc_ctm_trigin_ack$")
        self.add_interface("noc_ctm_trigout", r"^noc_ctm_trigout$")
        self.add_interface("noc_ctm_trigout_ack", r"^noc_ctm_trigout_ack$")
        self.add_interface("sys_ctm_trigout", r"^sys_ctm_trigout$")
        self.add_interface("sys_ctm_trigout_ack", r"^sys_ctm_trigout_ack$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("reserved_bits_in", r"^reserved_bits_in$")
        self.add_interface("reserved_bits_out", r"^reserved_bits_out$")
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
        self.add_interface("sys_side_cti_trigin", r"^sys_side_cti_trigin$")
        self.add_interface("sys_side_cti_trigin_ack", r"^sys_side_cti_trigin_ack$")
        self.add_interface("sys_side_cti_trigout", r"^sys_side_cti_trigout$")
        self.add_interface("sys_side_cti_trigout_ack", r"^sys_side_cti_trigout_ack$")
        self.add_interface("sys_side_ctm_trigin", r"^sys_side_ctm_trigin$")
        self.add_interface("sys_side_ctm_trigin_ack", r"^sys_side_ctm_trigin_ack$")
        self.add_interface("sys_side_ctm_trigout", r"^sys_side_ctm_trigout$")
        self.add_interface("sys_side_ctm_trigout_ack", r"^sys_side_ctm_trigout_ack$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("reserved_bits_in", r"^reserved_bits_in$")
        self.add_interface("reserved_bits_out", r"^reserved_bits_out$")
        self.add_interface("cti_apb", r"^cti_apb_.*$")
        self.add_interface("req_afifo_sb_err", r"^req_afifo_sb_err$")
        self.add_interface("req_afifo_db_err", r"^req_afifo_db_err$")


class StsIniuTopSideNode(UhdlComponentNode):
    """Publication-side full INIU top — wraps upstream sts_iniu_top."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        params = {}
        params["REQ_PLD_WIDTH"] = 121
        params["RSP_PLD_WIDTH"] = 67
        comp = TemplateComponent(config=cfg, top="sts_iniu_top", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        for signal_name in INIU_AXI_SIGNAL_NAMES:
            self.add_interface(f"axi_{signal_name}", rf"^sts_iniu_s_{signal_name}$")
        self.add_interface("top_req", r"^out_req_(vld|rdy|pld)$")
        self.add_interface("top_rsp", r"^in_rsp_(vld|rdy|pld)$")
        self.add_interface("cti_event", r"^cti_trig_.*$")
        self.add_interface("ctm_event", r"^ctm_trig_.*$")
        self.add_interface("ctm_channel", r"^ctm_channel_(in|out)$")
        self.add_interface("noc_cti_channel_in", r"^ctm_channel_dec_in$")
        self.add_interface("noc_cti_channel_out", r"^ctm_channel_dec_out$")
        self.add_interface("noc_cti_apb", r"^cti_apb_.*$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("reserved_bits", r"^reserved_bits_.*$")
        self.add_interface("safety", r"^(safety_err|sys_afifo_rsp_.*|noc_afifo_req_.*)$")


class StsIniuTopWrapNode(UhdlWrapperNode):
    """INIU top-side publication wrapper used by sts_soc_top_wrap."""
    def __init__(self, id: str, cfg: TemplateIPConfig, module_name: str | None = None):
        super().__init__(id=id, module_name=module_name or _sts_prefixed_name(id))
        self.top_side = StsIniuTopSideNode(id=f"{id}_top_side", cfg=cfg)

        for iface_name in [
            "clk_src",
            "clk_dst",
            "rstn_src",
            "rstn_dst",
            "node_id",
            "top_req",
            "top_rsp",
            "cti_event",
            "ctm_event",
            "ctm_channel",
            "noc_cti_channel_in",
            "noc_cti_channel_out",
            "noc_cti_apb",
            "dbg_timestamp_in",
            "dbg_timestamp_out",
            "dbg_data_in",
            "dbg_data_out",
            "reserved_bits",
            "safety",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))
        for signal_name in INIU_AXI_SIGNAL_NAMES:
            iface_name = f"axi_{signal_name}"
            self.add_interface(iface_name)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))

        self.expose_unconnected_interfaces()


class StsIniuNocTopWrapNode(UhdlWrapperNode):
    """NoC-only INIU publication wrapper used by sts_soc_top_wrap."""
    def __init__(self, id: str, cfg: TemplateIPConfig, module_name: str | None = None):
        super().__init__(id=id, module_name=module_name or _sts_prefixed_name(id))
        self.noc_side = StsIniuNocNode(id=f"{id}_noc_side", cfg=cfg)

        for iface_name in [
            "clk_src",
            "clk_dst",
            "rst_n_src",
            "rst_n_dst",
            "async_fifo",
            "req",
            "rsp",
            "cti_channel_in",
            "cti_channel_out",
            "sys_side_cti_trigin",
            "sys_side_cti_trigin_ack",
            "sys_side_cti_trigout",
            "sys_side_cti_trigout_ack",
            "sys_side_ctm_trigin",
            "sys_side_ctm_trigin_ack",
            "sys_side_ctm_trigout",
            "sys_side_ctm_trigout_ack",
            "dbg_timestamp_in",
            "dbg_timestamp_out",
            "dbg_data_in",
            "dbg_data_out",
            "reserved_bits_in",
            "reserved_bits_out",
            "cti_apb",
            "req_afifo_sb_err",
            "req_afifo_db_err",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.noc_side, iface_name), getattr(self, iface_name))

        self.expose_unconnected_interfaces()


# NOTE: No intermediate SysWrapNode/NocWrapNode needed — StsIniuNode directly
# wraps the two component nodes (DTI 2-layer composite pattern).


class StsIniuNode(UhdlWrapperNode):
    """INIU composite: sys side + noc side + async_fifo cross-connection."""
    def __init__(self, id: str, sys_cfg: TemplateIPConfig, noc_cfg: TemplateIPConfig):
        super().__init__(id=id, module_name=_sts_prefixed_name(id))
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
        self.add_interface("sys_cti_trigin")
        self.add_interface("sys_cti_trigin_ack")
        self.add_interface("sys_cti_trigout")
        self.add_interface("sys_cti_trigout_ack")
        self.add_interface("sys_ctm_trigin")
        self.add_interface("sys_ctm_trigin_ack")
        self.add_interface("sys_ctm_trigout")
        self.add_interface("sys_ctm_trigout_ack")
        self.add_interface("dbg_timestamp_in")
        self.add_interface("dbg_data_out")
        self.add_interface("noc_dbg_timestamp_out")
        self.add_interface("noc_dbg_data_in")
        self.add_interface("noc_cti_apb")
        self.add_interface("reserved_bits_in")
        self.add_interface("noc_reserved_bits_out")
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
        connect(self.sys_side.sys_cti_trigin, self.sys_cti_trigin)
        connect(self.sys_side.sys_cti_trigin_ack, self.sys_cti_trigin_ack)
        connect(self.sys_side.sys_cti_trigout, self.sys_cti_trigout)
        connect(self.sys_side.sys_cti_trigout_ack, self.sys_cti_trigout_ack)
        connect(self.sys_side.sys_ctm_trigin, self.sys_ctm_trigin)
        connect(self.sys_side.sys_ctm_trigin_ack, self.sys_ctm_trigin_ack)
        connect(self.sys_side.sys_ctm_trigout, self.sys_ctm_trigout)
        connect(self.sys_side.sys_ctm_trigout_ack, self.sys_ctm_trigout_ack)
        connect(self.sys_side.noc_cti_trigin, self.noc_side.sys_side_cti_trigin)
        connect(self.noc_side.sys_side_cti_trigin_ack, self.sys_side.noc_cti_trigin_ack)
        connect(self.noc_side.sys_side_cti_trigout, self.sys_side.noc_cti_trigout)
        connect(self.sys_side.noc_cti_trigout_ack, self.noc_side.sys_side_cti_trigout_ack)
        connect(self.sys_side.noc_ctm_trigin, self.noc_side.sys_side_ctm_trigin)
        connect(self.noc_side.sys_side_ctm_trigin_ack, self.sys_side.noc_ctm_trigin_ack)
        connect(self.noc_side.sys_side_ctm_trigout, self.sys_side.noc_ctm_trigout)
        connect(self.sys_side.noc_ctm_trigout_ack, self.noc_side.sys_side_ctm_trigout_ack)
        connect(self.sys_side.dbg_timestamp_in, self.dbg_timestamp_in)
        connect(self.sys_side.dbg_timestamp_out, self.noc_side.dbg_timestamp_in)
        connect(self.noc_side.dbg_timestamp_out, self.noc_dbg_timestamp_out)
        connect(self.noc_side.dbg_data_out, self.sys_side.dbg_data_in)
        connect(self.sys_side.dbg_data_out, self.dbg_data_out)
        connect(self.noc_side.dbg_data_in, self.noc_dbg_data_in)
        connect(self.sys_side.reserved_bits_in, self.reserved_bits_in)
        connect(self.sys_side.reserved_bits_out, self.noc_side.reserved_bits_in)
        connect(self.noc_side.reserved_bits_out, self.noc_reserved_bits_out)
        connect(self.noc_side.cti_apb, self.noc_cti_apb)
        connect(self.sys_side.safety, self.safety)

        self.expose_unconnected_interfaces(recursive=True)

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
        self.add_interface("v_tniu_sys_reg", r"^v_tniu_sys_reg$")
        self.add_interface("sys_cti_trigin", r"^sys_cti_trigin$")
        self.add_interface("sys_cti_trigin_ack", r"^sys_cti_trigin_ack$")
        self.add_interface("noc_cti_trigin", r"^noc_cti_trigin$")
        self.add_interface("noc_cti_trigin_ack", r"^noc_cti_trigin_ack$")
        self.add_interface("noc_cti_trigout", r"^noc_cti_trigout$")
        self.add_interface("noc_cti_trigout_ack", r"^noc_cti_trigout_ack$")
        self.add_interface("sys_cti_trigout", r"^sys_cti_trigout$")
        self.add_interface("sys_cti_trigout_ack", r"^sys_cti_trigout_ack$")
        self.add_interface("sys_ctm_trigin", r"^sys_ctm_trigin$")
        self.add_interface("sys_ctm_trigin_ack", r"^sys_ctm_trigin_ack$")
        self.add_interface("noc_ctm_trigin", r"^noc_ctm_trigin$")
        self.add_interface("noc_ctm_trigin_ack", r"^noc_ctm_trigin_ack$")
        self.add_interface("noc_ctm_trigout", r"^noc_ctm_trigout$")
        self.add_interface("noc_ctm_trigout_ack", r"^noc_ctm_trigout_ack$")
        self.add_interface("sys_ctm_trigout", r"^sys_ctm_trigout$")
        self.add_interface("sys_ctm_trigout_ack", r"^sys_ctm_trigout_ack$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_data_out", r"^dbg_data_out$")
        self.add_interface("dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("reserved_bits_in", r"^reserved_bits_in$")
        self.add_interface("reserved_bits_out", r"^reserved_bits_out$")
        self.add_interface("hw_dbg_sel_in", r"^hw_dbg_sel_in$")
        self.add_interface("hw_dbg_sel_out", r"^hw_dbg_sel_out$")
        self.add_interface("tniu_sys_regbank_parity_err", r"^tniu_sys_regbank_parity_err$")
        self.add_interface("safety", r"^sts_tniu_req_afifo_.*$")  # sb_err/db_err


class StsTniuNocNode(UhdlComponentNode):
    """TNIU noc-side — NoC req/rsp crossover + CDC read side + APB/CTI/debug."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        params = {}
        # Override localparam REQ_PLD_WIDTH/RSP_PLD_WIDTH that UHDL/slang can't resolve.
        # With SRC_ID_WIDTH/TGT_ID_WIDTH both at 9, STS_CMN_WIDTH becomes 32.
        # STS_REQ_WIDTH = STS_CMN(32) + STS_REQ_EXT(89) = 121
        # STS_RSP_WIDTH = STS_CMN(32) + STS_RSP_EXT(35) = 67
        params["REQ_PLD_WIDTH"] = 121
        params["RSP_PLD_WIDTH"] = 67
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
        self.add_interface("reserved_bits_in", r"^reserved_bits_in$")
        self.add_interface("reserved_bits_out", r"^reserved_bits_out$")
        self.add_interface("ctm_channel_in", r"^ctm_channel_in$")
        self.add_interface("ctm_channel_out", r"^ctm_channel_out$")
        self.add_interface("sys_side_cti_trigin", r"^sys_side_cti_trigin$")
        self.add_interface("sys_side_cti_trigin_ack", r"^sys_side_cti_trigin_ack$")
        self.add_interface("sys_side_cti_trigout", r"^sys_side_cti_trigout$")
        self.add_interface("sys_side_cti_trigout_ack", r"^sys_side_cti_trigout_ack$")
        self.add_interface("sys_side_ctm_trigin", r"^sys_side_ctm_trigin$")
        self.add_interface("sys_side_ctm_trigin_ack", r"^sys_side_ctm_trigin_ack$")
        self.add_interface("sys_side_ctm_trigout", r"^sys_side_ctm_trigout$")
        self.add_interface("sys_side_ctm_trigout_ack", r"^sys_side_ctm_trigout_ack$")
        self.add_interface("timing_bus1", r"^timing_bus1$")
        self.add_interface("timing_bus2", r"^timing_bus2$")
        self.add_interface("timing_bus3", r"^timing_bus3$")
        self.add_interface("dbg_en", r"^dbg_en$")
        self.add_interface("hw_dbg_sel", r"^hw_dbg_sel$")
        self.add_interface("tniu_regbank_parity_err", r"^tniu_regbank_parity_err$")
        self.add_interface("rsp_afifo_sb_err", r"^rsp_afifo_sb_err$")
        self.add_interface("rsp_afifo_db_err", r"^rsp_afifo_db_err$")


class StsTniuTopSideNode(UhdlComponentNode):
    """Publication-side full TNIU top — wraps upstream sts_tniu_top."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        params = {}
        params["REQ_PLD_WIDTH"] = 121
        params["RSP_PLD_WIDTH"] = 67
        comp = TemplateComponent(config=cfg, top="sts_tniu_top", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("clk_dbg_timer", r"^clk_dbg_timer$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("rstn_dbg_timer", r"^rstn_dbg_timer$")
        self.add_interface("top_req", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("top_rsp", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("top_apb", r"^top_p.*$")
        self.add_interface("sys_apb", r"^m_.*$")
        self.add_interface("dbg_data_in", r"^dbg_data_in$")
        self.add_interface("dbg_timestamp_out", r"^dbg_timestamp_out$")
        self.add_interface("noc_dbg_data_out", r"^dbg_data_out$")
        self.add_interface("noc_dbg_timestamp_in", r"^dbg_timestamp_in$")
        self.add_interface("reserved_bits", r"^reserved_bits_.*$")
        self.add_interface("cti_event", r"^cti_trig_.*$")
        self.add_interface("ctm_event", r"^ctm_trig_.*$")
        self.add_interface("ctm_channel", r"^ctm_channel_(in|out)$")
        self.add_interface("noc_ctm_channel_in", r"^ctm_channel_dec_in$")
        self.add_interface("noc_ctm_channel_out", r"^ctm_channel_dec_out$")
        self.add_interface("timing_bus1", r"^timing_bus1$")
        self.add_interface("timing_bus2", r"^timing_bus2$")
        self.add_interface("timing_bus3", r"^timing_bus3$")
        self.add_interface("dbg_en", r"^dbg_en$")
        self.add_interface("tniu_regbank_parity_err", r"^tniu_regbank_parity_err$")
        self.add_interface("safety", r"^tniu_.*afifo_.*err$")


class StsTniuTopWrapNode(UhdlWrapperNode):
    """TNIU top-side publication wrapper used by sts_soc_top_wrap."""
    def __init__(self, id: str, cfg: TemplateIPConfig, module_name: str | None = None):
        super().__init__(id=id, module_name=module_name or _sts_prefixed_name(id))
        self.top_side = StsTniuTopSideNode(id=f"{id}_top_side", cfg=cfg)

        for iface_name in [
            "clk_src",
            "clk_dst",
            "clk_dbg_timer",
            "rstn_src",
            "rstn_dst",
            "rstn_dbg_timer",
            "top_req",
            "top_rsp",
            "top_apb",
            "sys_apb",
            "dbg_data_in",
            "dbg_timestamp_out",
            "noc_dbg_data_out",
            "noc_dbg_timestamp_in",
            "reserved_bits",
            "cti_event",
            "ctm_event",
            "ctm_channel",
            "noc_ctm_channel_in",
            "noc_ctm_channel_out",
            "timing_bus1",
            "timing_bus2",
            "timing_bus3",
            "dbg_en",
            "tniu_regbank_parity_err",
            "safety",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))

        self.expose_unconnected_interfaces()


class StsTniuNocTopWrapNode(UhdlWrapperNode):
    """NoC-only TNIU publication wrapper used by sts_soc_top_wrap."""
    def __init__(self, id: str, cfg: TemplateIPConfig, module_name: str | None = None, expose_apb: bool = True):
        super().__init__(id=id, module_name=module_name or _sts_prefixed_name(id))
        self.noc_side = StsTniuNocNode(id=f"{id}_noc_side", cfg=cfg)

        for iface_name in [
            "clk_src",
            "clk_dst",
            "rstn_src",
            "rstn_dst",
            "async_fifo",
            "req",
            "rsp",
            "dbg_data_in",
            "dbg_data_out",
            "dbg_timestamp_in",
            "dbg_timestamp_out",
            "reserved_bits_in",
            "reserved_bits_out",
            "ctm_channel_in",
            "ctm_channel_out",
            "sys_side_cti_trigin",
            "sys_side_cti_trigin_ack",
            "sys_side_cti_trigout",
            "sys_side_cti_trigout_ack",
            "sys_side_ctm_trigin",
            "sys_side_ctm_trigin_ack",
            "sys_side_ctm_trigout",
            "sys_side_ctm_trigout_ack",
            "timing_bus1",
            "timing_bus2",
            "timing_bus3",
            "dbg_en",
            "hw_dbg_sel",
            "tniu_regbank_parity_err",
            "rsp_afifo_sb_err",
            "rsp_afifo_db_err",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.noc_side, iface_name), getattr(self, iface_name))

        if expose_apb:
            self.add_interface("apb")
            connect(self.noc_side.apb, self.apb)
        else:
            self.apb_idle_target = StsApbIdleTargetNode(id=f"{id}_apb_idle_target")
            connect(self.noc_side.apb, self.apb_idle_target.apb)

        self.expose_unconnected_interfaces()


# NOTE: No intermediate SysWrapNode/NocWrapNode needed — StsTniuNode directly
# wraps the two component nodes (DTI 2-layer composite pattern).


class StsTniuNode(UhdlWrapperNode):
    """TNIU composite: sys side + noc side + async_fifo cross-connection."""
    def __init__(self, id: str, sys_cfg: TemplateIPConfig, noc_cfg: TemplateIPConfig, expose_noc_apb: bool = True):
        super().__init__(id=id, module_name=_sts_prefixed_name(id))
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
        self.add_interface("v_tniu_sys_reg")
        self.add_interface("noc_ctm_channel_in")
        self.add_interface("noc_ctm_channel_out")
        self.add_interface("sys_cti_trigin")
        self.add_interface("sys_cti_trigin_ack")
        self.add_interface("sys_cti_trigout")
        self.add_interface("sys_cti_trigout_ack")
        self.add_interface("sys_ctm_trigin")
        self.add_interface("sys_ctm_trigin_ack")
        self.add_interface("sys_ctm_trigout")
        self.add_interface("sys_ctm_trigout_ack")
        self.add_interface("dbg_data_in")
        self.add_interface("dbg_timestamp_out")
        self.add_interface("noc_dbg_data_out")
        self.add_interface("noc_dbg_timestamp_in")
        self.add_interface("noc_reserved_bits_in")
        self.add_interface("reserved_bits_out")
        self.add_interface("safety")
        if expose_noc_apb:
            self.add_interface("apb")
        self.add_interface("timing_bus1")
        self.add_interface("timing_bus2")
        self.add_interface("timing_bus3")
        self.add_interface("dbg_en")
        self.add_interface("hw_dbg_sel_out")
        self.add_interface("tniu_sys_regbank_parity_err")
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
        connect(self.sys_side.v_tniu_sys_reg, self.v_tniu_sys_reg)
        connect(self.sys_side.sys_cti_trigin, self.sys_cti_trigin)
        connect(self.sys_side.sys_cti_trigin_ack, self.sys_cti_trigin_ack)
        connect(self.sys_side.sys_cti_trigout, self.sys_cti_trigout)
        connect(self.sys_side.sys_cti_trigout_ack, self.sys_cti_trigout_ack)
        connect(self.sys_side.sys_ctm_trigin, self.sys_ctm_trigin)
        connect(self.sys_side.sys_ctm_trigin_ack, self.sys_ctm_trigin_ack)
        connect(self.sys_side.sys_ctm_trigout, self.sys_ctm_trigout)
        connect(self.sys_side.sys_ctm_trigout_ack, self.sys_ctm_trigout_ack)
        connect(self.sys_side.noc_cti_trigin, self.noc_side.sys_side_cti_trigin)
        connect(self.noc_side.sys_side_cti_trigin_ack, self.sys_side.noc_cti_trigin_ack)
        connect(self.noc_side.sys_side_cti_trigout, self.sys_side.noc_cti_trigout)
        connect(self.sys_side.noc_cti_trigout_ack, self.noc_side.sys_side_cti_trigout_ack)
        connect(self.sys_side.noc_ctm_trigin, self.noc_side.sys_side_ctm_trigin)
        connect(self.noc_side.sys_side_ctm_trigin_ack, self.sys_side.noc_ctm_trigin_ack)
        connect(self.noc_side.sys_side_ctm_trigout, self.sys_side.noc_ctm_trigout)
        connect(self.sys_side.noc_ctm_trigout_ack, self.noc_side.sys_side_ctm_trigout_ack)
        connect(self.sys_side.dbg_data_in, self.dbg_data_in)
        connect(self.sys_side.dbg_data_out, self.noc_side.dbg_data_in)
        connect(self.noc_side.dbg_data_out, self.noc_dbg_data_out)
        connect(self.noc_side.dbg_timestamp_in, self.noc_dbg_timestamp_in)
        connect(self.noc_side.dbg_timestamp_out, self.sys_side.dbg_timestamp_in)
        connect(self.sys_side.dbg_timestamp_out, self.dbg_timestamp_out)
        connect(self.noc_side.reserved_bits_in, self.noc_reserved_bits_in)
        connect(self.noc_side.reserved_bits_out, self.sys_side.reserved_bits_in)
        connect(self.sys_side.reserved_bits_out, self.reserved_bits_out)
        connect(self.sys_side.safety, self.safety)
        if expose_noc_apb:
            connect(self.noc_side.apb, self.apb)
        else:
            self.apb_idle_target = StsApbIdleTargetNode(id=f"{id}_apb_idle_target")
            connect(self.noc_side.apb, self.apb_idle_target.apb)
        connect(self.noc_side.timing_bus1, self.timing_bus1)
        connect(self.noc_side.timing_bus2, self.timing_bus2)
        connect(self.noc_side.timing_bus3, self.timing_bus3)
        connect(self.noc_side.dbg_en, self.dbg_en)
        connect(self.noc_side.hw_dbg_sel, self.sys_side.hw_dbg_sel_in)
        connect(self.sys_side.hw_dbg_sel_out, self.hw_dbg_sel_out)
        connect(self.sys_side.tniu_sys_regbank_parity_err, self.tniu_sys_regbank_parity_err)
        connect(self.noc_side.tniu_regbank_parity_err, self.tniu_regbank_parity_err)
        connect(self.noc_side.rsp_afifo_sb_err, self.rsp_afifo_sb_err)
        connect(self.noc_side.rsp_afifo_db_err, self.rsp_afifo_db_err)

        self.expose_unconnected_interfaces(recursive=True)

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
        self.add_interface("mst_reserved_bits", r"^mst_reserved_bits$")
        for idx in range(slave_num):
            self.add_interface(f"s{idx}_req", rf"^s{idx}_req_(vld|rdy|pld)$")
            self.add_interface(f"s{idx}_rsp", rf"^s{idx}_rsp_(vld|rdy|pld)$")
            self.add_interface(f"s{idx}_cti_channel_in", rf"^s{idx}_cti_channel_in$")
            self.add_interface(f"s{idx}_cti_channel_out", rf"^s{idx}_cti_channel_out$")
            self.add_interface(f"s{idx}_dbg_timestamp", rf"^s{idx}_dbg_timestamp$")
            self.add_interface(f"s{idx}_dbg_data", rf"^s{idx}_dbg_data$")
            self.add_interface(f"s{idx}_reserved_bits", rf"^s{idx}_reserved_bits$")



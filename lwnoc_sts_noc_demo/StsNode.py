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
from uhdl.uhdl.core.TemplateIP import TemplateComponent, TemplateIPConfig

from StsTemplate import *
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


class StsIniuSysNode(UhdlComponentNode):
    """INIU system-side — AXI slave + async FIFO + CTI/debug."""
    def __init__(self, id: str, cfg):
        params = dict(getattr(cfg, 'param_overrides', {}))
        comp = TemplateComponent(config=cfg, top="sts_iniu_sys", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        self.add_interface("axi", r"^s_.*")
        self.add_interface("req_async", r"^req_(wptr|rptr|pld)_.*")
        self.add_interface("rsp_async", r"^rsp_(wptr|rptr|pld)_.*")
        self.add_interface("cti_event", r"^cti_event_.*")
        self.add_interface("cti_channel", r"^cti_channel_.*")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*")
        self.add_interface("dbg_data", r"^dbg_data_.*")


class StsIniuTopNode(UhdlComponentNode):
    """INIU top-side — NoC-facing: AXI + req/rsp + CTI/debug (includes sys internally)."""
    def __init__(self, id: str, cfg):
        params = dict(getattr(cfg, 'param_overrides', {}))
        comp = TemplateComponent(config=cfg, top="sts_iniu_top", struct_mode="packed", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        self.add_interface("axi", r"^sts_iniu_s_.*")
        self.add_interface("req", r"^out_req_.*")
        self.add_interface("rsp", r"^in_rsp_.*")
        self.add_interface("cti_event", r"^(sys|noc)_cti_event_.*")
        self.add_interface("cti_channel", r"^(sys|noc)_cti_channel_.*")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*")
        self.add_interface("dbg_data", r"^dbg_data_.*")
        self.add_interface("cti_apb", r"^cti_apb_.*")
        self.add_interface("sys_afifo_rsp_sb_err", r"^sys_afifo_rsp_sb_err$")
        self.add_interface("sys_afifo_rsp_db_err", r"^sys_afifo_rsp_db_err$")
        self.add_interface("noc_afifo_req_sb_err", r"^noc_afifo_req_sb_err$")
        self.add_interface("noc_afifo_req_db_err", r"^noc_afifo_req_db_err$")


class StsIniuTopWrapNode(UhdlWrapperNode):
    """INIU top-side wrapper (ai memnoc pattern): exposes noc-facing ports for harden mounting."""
    def __init__(self, id: str, inner_top: 'StsIniuTopNode'):
        super().__init__(id=id)
        setattr(self, inner_top.id, inner_top)  # register as proper UHDL child
        self.add_interface("clk_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
        self.add_interface("node_id")
        self.add_interface("axi")
        self.add_interface("req")
        self.add_interface("rsp")
        self.add_interface("cti_event")
        self.add_interface("cti_channel")
        self.add_interface("dbg_timestamp")
        self.add_interface("dbg_data")
        self.add_interface("cti_apb")
        self.add_interface("sys_afifo_rsp_sb_err")
        self.add_interface("sys_afifo_rsp_db_err")
        self.add_interface("noc_afifo_req_sb_err")
        self.add_interface("noc_afifo_req_db_err")

        connect(inner_top.clk_src, self.clk_src)
        connect(inner_top.clk_dst, self.clk_dst)
        connect(inner_top.rstn_src, self.rstn_src)
        connect(inner_top.rstn_dst, self.rstn_dst)
        connect(inner_top.axi, self.axi)
        connect(inner_top.node_id, self.node_id)
        connect(inner_top.req, self.req)
        connect(inner_top.rsp, self.rsp)
        connect(inner_top.cti_event, self.cti_event)
        connect(inner_top.cti_channel, self.cti_channel)
        connect(inner_top.dbg_timestamp, self.dbg_timestamp)
        connect(inner_top.dbg_data, self.dbg_data)
        connect(inner_top.cti_apb, self.cti_apb)
        connect(inner_top.sys_afifo_rsp_sb_err, self.sys_afifo_rsp_sb_err)
        connect(inner_top.sys_afifo_rsp_db_err, self.sys_afifo_rsp_db_err)
        connect(inner_top.noc_afifo_req_sb_err, self.noc_afifo_req_sb_err)
        connect(inner_top.noc_afifo_req_db_err, self.noc_afifo_req_db_err)
        self.expose_unconnected_interfaces()


class StsIniuNode(UhdlWrapperNode):
    """INIU wrapper — composes StsIniuTopNode, exposes integration-facing interfaces."""
    def __init__(self, id: str, sys_cfg, top_cfg):
        super().__init__(id=id)

        self.add_interface("clk_src", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
        self.add_interface("node_id")
        self.add_interface("axi")
        self.add_interface("req")
        self.add_interface("rsp")
        self.add_interface("cti_event")
        self.add_interface("cti_channel")
        self.add_interface("dbg_timestamp")
        self.add_interface("dbg_data")
        self.add_interface("cti_apb")
        self.add_interface("sys_afifo_rsp_sb_err")
        self.add_interface("sys_afifo_rsp_db_err")
        self.add_interface("noc_afifo_req_sb_err")
        self.add_interface("noc_afifo_req_db_err")

        self.iniu_sys_side = StsIniuSysNode(id=f"{id}_sys_side", cfg=sys_cfg)
        self.iniu_top_side = StsIniuTopNode(id=f"{id}_top_side", cfg=top_cfg)

        connect(self.iniu_sys_side.clk_src, self.clk_src)
        connect(self.iniu_sys_side.rstn_src, self.rstn_src)
        connect(self.iniu_sys_side.clk_dst, self.clk_dst)
        connect(self.iniu_sys_side.rstn_dst, self.rstn_dst)
        connect(self.iniu_top_side.clk_src, self.clk_src)
        connect(self.iniu_top_side.rstn_src, self.rstn_src)
        connect(self.iniu_top_side.clk_dst, self.clk_dst)
        connect(self.iniu_top_side.rstn_dst, self.rstn_dst)
        connect(self.iniu_top_side.axi, self.axi)
        connect(self.iniu_top_side.node_id, self.node_id)
        connect(self.iniu_top_side.req, self.req)
        connect(self.iniu_top_side.rsp, self.rsp)
        connect(self.iniu_top_side.cti_event, self.cti_event)
        connect(self.iniu_top_side.cti_channel, self.cti_channel)
        connect(self.iniu_top_side.dbg_timestamp, self.dbg_timestamp)
        connect(self.iniu_top_side.dbg_data, self.dbg_data)
        connect(self.iniu_top_side.cti_apb, self.cti_apb)
        connect(self.iniu_top_side.sys_afifo_rsp_sb_err, self.sys_afifo_rsp_sb_err)
        connect(self.iniu_top_side.sys_afifo_rsp_db_err, self.sys_afifo_rsp_db_err)
        connect(self.iniu_top_side.noc_afifo_req_sb_err, self.noc_afifo_req_sb_err)
        connect(self.iniu_top_side.noc_afifo_req_db_err, self.noc_afifo_req_db_err)
        self.expose_unconnected_interfaces()

    @property
    def top_side(self):
        """Return TopWrapNode for harden mounting (INTR/DTI/ai memnoc pattern)."""
        if not hasattr(self, '_top_wrap_node'):
            self._top_wrap_node = StsIniuTopWrapNode(id=f"{self.id}_top_wrap", inner_top=self.iniu_top_side)
        return self._top_wrap_node


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
        route_base_int = pack_int(TGT_ID_WIDTH, route_base_values)
        route_mask_int = pack_int(TGT_ID_WIDTH, route_mask_values)
        params.update(
            {
                "STS_DEMO_DEC_SLAVE_NUM": slave_num,
                "STS_DEMO_ROUTE_BASE": sv_param(slave_num * TGT_ID_WIDTH, route_base_int),
                "STS_DEMO_ROUTE_MASK": sv_param(slave_num * TGT_ID_WIDTH, route_mask_int),
            }
        )

        comp = TemplateComponent(config=cfg, top="sts_noc_dec_node", **params)
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
        self.add_interface("timing_bus1", r"^timing_bus1$")
        self.add_interface("timing_bus2", r"^timing_bus2$")
        self.add_interface("timing_bus3", r"^timing_bus3$")
        self.add_interface("dbg_en", r"^dbg_en$")


class StsTniuTopWrapNode(UhdlWrapperNode):
    """TNIU top-side wrapper (ai memnoc pattern): exposes noc-facing ports for harden mounting."""
    def __init__(self, id: str, inner_top: 'StsTniuTopNode'):
        super().__init__(id=id)
        setattr(self, inner_top.id, inner_top)  # register as proper UHDL child
        self.add_interface("clk_src", is_global=True)
        self.add_interface("clk_dst", is_global=True)
        self.add_interface("clk_dbg_timer", is_global=True)
        self.add_interface("rstn_src", is_global=True)
        self.add_interface("rstn_dst", is_global=True)
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
        self.add_interface("timing_bus1")
        self.add_interface("timing_bus2")
        self.add_interface("timing_bus3")
        self.add_interface("dbg_en")

        connect(inner_top.clk_src, self.clk_src)
        connect(inner_top.clk_dst, self.clk_dst)
        connect(inner_top.clk_dbg_timer, self.clk_dbg_timer)
        connect(inner_top.rstn_src, self.rstn_src)
        connect(inner_top.rstn_dst, self.rstn_dst)
        connect(inner_top.rstn_dbg_timer, self.rstn_dbg_timer)
        connect(inner_top.req, self.req)
        connect(inner_top.rsp, self.rsp)
        connect(inner_top.pmc_apb, self.pmc_apb)
        connect(inner_top.sys_apb, self.sys_apb)
        connect(inner_top.dbg_data, self.dbg_data)
        connect(inner_top.dbg_timestamp, self.dbg_timestamp)
        connect(inner_top.sys_cti_event, self.sys_cti_event)
        connect(inner_top.noc_cti_event, self.noc_cti_event)
        connect(inner_top.sys_cti_channel, self.sys_cti_channel)
        connect(inner_top.noc_cti_channel, self.noc_cti_channel)
        connect(inner_top.timing_bus1, self.timing_bus1)
        connect(inner_top.timing_bus2, self.timing_bus2)
        connect(inner_top.timing_bus3, self.timing_bus3)
        connect(inner_top.dbg_en, self.dbg_en)
        self.expose_unconnected_interfaces()


class StsTniuSysNode(UhdlComponentNode):
    """TNIU system-side leaf — hierarchical inside sts_tniu_top."""
    def __init__(self, id: str, cfg: TemplateIPConfig):
        comp = TemplateComponent(config=cfg, top="sts_tniu_sys")
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
        self.add_interface("timing_bus1")
        self.add_interface("timing_bus2")
        self.add_interface("timing_bus3")
        self.add_interface("dbg_en")

        self.sys_side = StsTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.top_side = StsTniuTopWrapNode(id=f"{id}_top_wrap", inner_top=StsTniuTopNode(id=f"{id}_top", cfg=top_cfg, top=top_wrap))

        # Connect sys-side — top-side exposed directly to harden (ai memnoc pattern)
        connect(self.sys_side.clk, self.clk_src)
        connect(self.sys_side.rst_n, self.rstn_src)

        self.expose_unconnected_interfaces()
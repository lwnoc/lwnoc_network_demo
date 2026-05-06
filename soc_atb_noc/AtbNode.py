import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode  # pyright: ignore[reportMissingImports]
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]
from topo_core.utils.networkHierOpt import connect  # pyright: ignore[reportMissingImports]
from uhdl.uhdl.core.TemplateIP import TemplateComponent  # pyright: ignore[reportMissingImports]

# ── INIU nodes ──────────────────────────────────────────────────────────

class AtbIniuSysNode(UhdlComponentNode):
    """INIU system-side — receives ATB from source SS."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_iniu_sys", struct_mode="packed")
        super().__init__(id=f"{node_id}_sys_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_s$")
        self.add_interface("rst_n", r"^rstn_atb_s$")
        self.add_interface("s_chan", r"^s_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("flush_req", r"^flush_req$")
        self.add_interface("pchnl_ctrl", r"^(preq|pstate|pactive|paccept|pdeny)$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("syncreq_level", r"^syncreq_level$")
        self.add_interface("lp_rx", r"^lwnoc_rx_req$")
        self.add_interface("lp_tx", r"^lwnoc_tx_req$")
        self.add_interface("lp_afifo_rx", r"^afifo_slv_rx_req$")
        self.add_interface("lp_afifo_tx", r"^afifo_slv_tx_req$")
        self.add_interface("timeout_val", r"^timeout_val$")


class AtbIniuTopNode(UhdlComponentNode):
    """INIU top/noc-side — drives ATB fabric."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_iniu_noc", struct_mode="packed")
        super().__init__(id=f"{node_id}_top_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_m$")
        self.add_interface("rst_n", r"^rstn_atb_m$")
        self.add_interface("m_chan", r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("sync_ctrl", r"^(syncreq_level|flush_req_level)$")
        self.add_interface("lp_afifo_rx", r"^afifo_mst_rx_req$")
        self.add_interface("lp_afifo_tx", r"^afifo_mst_tx_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("lp_rx", r"^lw_rx_req$")
        self.add_interface("lp_tx", r"^lw_tx_req$")
        self.add_interface("timeout_val", r"^timeout_val$")


class AtbIniuNode(UhdlWrapperNode):
    """INIU composite: sys + noc (top) sides connected via async_fifo + LP."""
    def __init__(self, node_id: str, cfg, cfg_top):
        super().__init__(id=f"{node_id}_node")
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        self.sys_side = AtbIniuSysNode(node_id=node_id, cfg=cfg)
        self.top_side = AtbIniuTopNode(node_id=node_id, cfg=cfg_top)

        connect(self.sys_side.clk,   self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.top_side.clk,   self.clk_noc)
        connect(self.top_side.rst_n, self.rst_noc_n)
        connect(self.sys_side.async_fifo, self.top_side.async_fifo)
        connect(self.sys_side.lp_tx, self.top_side.lp_rx)
        connect(self.sys_side.lp_rx, self.top_side.lp_tx)
        connect(self.sys_side.lp_afifo_tx, self.top_side.lp_afifo_rx)
        connect(self.sys_side.lp_afifo_rx, self.top_side.lp_afifo_tx)
        self.expose_unconnected_interfaces()


# ── TNIU nodes ──────────────────────────────────────────────────────────

class AtbTniuSysNode(UhdlComponentNode):
    """TNIU system-side — delivers ATB to debug SS."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_tniu_sys", struct_mode="packed")
        super().__init__(id=f"{node_id}_sys_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_m$")
        self.add_interface("rst_n", r"^rstn_atb_m$")
        self.add_interface("m_chan", r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("pchnl_ctrl", r"^(preq|pstate|pactive|paccept|pdeny)$")
        self.add_interface("sync_ctrl", r"^(syncreq_level|flush_req_level)$")
        self.add_interface("lp_lw", r"^lw_(rx|tx)_req$")
        self.add_interface("lp_afifo", r"^afifo_slv_(rx|tx)_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("timeout_val", r"^timeout_val$")


class AtbTniuTopNode(UhdlComponentNode):
    """TNIU top/noc-side — receives aggregated ATB from fabric."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_tniu_noc", struct_mode="packed")
        super().__init__(id=f"{node_id}_top_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_s$")
        self.add_interface("rst_n", r"^rstn_atb_s$")
        self.add_interface("s_chan", r"^s_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("flush_req", r"^flush_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("syncreq_level", r"^syncreq_level$")
        self.add_interface("lp_lw", r"^lw_(rx|tx)_req$")
        self.add_interface("lp_afifo", r"^afifo_slv_(rx|tx)_req$")
        self.add_interface("timeout_val", r"^timeout_val$")
        # FUSA error signal
        self.add_interface("aifo_slv_full_zero", r"^aifo_slv_full_zero$")


class AtbTniuNode(UhdlWrapperNode):
    """TNIU composite: top + sys sides connected via async_fifo + LP."""
    def __init__(self, node_id: str, cfg, cfg_top):
        super().__init__(id=f"{node_id}_node")
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        self.top_side = AtbTniuTopNode(node_id=node_id, cfg=cfg_top)
        self.sys_side = AtbTniuSysNode(node_id=node_id, cfg=cfg)

        connect(self.top_side.clk,   self.clk_noc)
        connect(self.top_side.rst_n, self.rst_noc_n)
        connect(self.sys_side.clk,   self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.top_side.async_fifo, self.sys_side.async_fifo)
        self.expose_unconnected_interfaces()


# ── Network nodes ───────────────────────────────────────────────────────

class AtbFunnelNode(UhdlComponentNode):
    """N-to-1 priority mux aggregating multiple ATB streams."""
    def __init__(self, node_id: str, num_inputs: int, data_width: int, cfg):
        comp = TemplateComponent(config=cfg, top="atb_funnel",
                                 N_ATB=num_inputs, ATB_DATA_WIDTH=data_width)
        super().__init__(id=f"{node_id}_node", impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("resetn", r"^resetn$")
        self.add_interface("atvalids", r"^atvalids$")
        self.add_interface("afreadys", r"^afreadys$")
        self.add_interface("atids", r"^atids$")
        self.add_interface("atdatas", r"^atdatas$")
        self.add_interface("atbytess", r"^atbytess$")
        self.add_interface("atreadym", r"^atreadym$")
        self.add_interface("afvalidm", r"^afvalidm$")
        self.add_interface("syncreqm", r"^syncreqm$")
        self.add_interface("atvalidm", r"^atvalidm$")
        self.add_interface("afreadym", r"^afreadym$")
        self.add_interface("atidm", r"^atidm$")
        self.add_interface("atdatam", r"^atdatam$")
        self.add_interface("atbytesm", r"^atbytesm$")
        self.add_interface("atreadys", r"^atreadys$")
        self.add_interface("afvalids", r"^afvalids$")
        self.add_interface("syncreqs", r"^syncreqs$")
        # APB debug ports
        self.add_interface("pclkendbg", r"^pclkendbg$")
        self.add_interface("pseldbg", r"^pseldbg$")
        self.add_interface("penabledbg", r"^penabledbg$")
        self.add_interface("pwritedbg", r"^pwritedbg$")
        self.add_interface("paddrdbg31", r"^paddrdbg31$")
        self.add_interface("paddrdbg", r"^paddrdbg$")
        self.add_interface("pwdatadbg", r"^pwdatadbg$")
        self.add_interface("preadydbg", r"^preadydbg$")
        self.add_interface("pslverrdbg", r"^pslverrdbg$")
        self.add_interface("prdatadbg", r"^prdatadbg$")


# ── Async Bridge nodes (memnoc-like split) ────────────────────────────

class AtbAsyncBridgeSlvNode(UhdlComponentNode):
    """Async bridge slave-side — source clock domain half of CDC.
    Maps network_atb_slv RTL module."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="network_atb_slv", struct_mode="packed")
        super().__init__(id=f"{node_id}_slv_node", impl=comp)
        self.add_interface("slv_clk",   r"^clk_atb_s$")
        self.add_interface("slv_rst_n", r"^rstn_atb_s$")
        self.add_interface("s_chan", r"^s_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        # Sync interface — matching signals only (wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync|syncreq_level)$")
        # Status and control — side signals (exposed as separate at wrapper level)
        self.add_interface("afifo_slv_full_zero", r"^afifo_slv_full_zero$")
        self.add_interface("flush_req", r"^flush_req$")


class AtbAsyncBridgeMstNode(UhdlComponentNode):
    """Async bridge master-side — destination clock domain half of CDC.
    Maps network_atb_mst RTL module."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="network_atb_mst", struct_mode="packed")
        super().__init__(id=f"{node_id}_mst_node", impl=comp)
        self.add_interface("mst_clk",   r"^clk_atb_m$")
        self.add_interface("mst_rst_n", r"^rstn_atb_m$")
        self.add_interface("m_chan", r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        # Sync interface — matching signals only (wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync|syncreq_level)$")
        # Status and control — side signals (exposed as separate at wrapper level)
        self.add_interface("afifo_mst_full_zero", r"^afifo_mst_full_zero$")
        self.add_interface("afifo_mst_read_idle", r"^afifo_mst_read_idle$")
        self.add_interface("flush_req_level", r"^flush_req_level$")
        # FUSA error signals
        self.add_interface("atb_net_sb_err", r"^atb_net_sb_err$")
        self.add_interface("atb_net_db_err", r"^atb_net_db_err$")


class AtbAsyncBridgeNode(UhdlWrapperNode):
    """Async bridge composite wrapper.

    Internally instantiates slv_side + mst_side and connects cross-domain sync.
    Does NOT instantiate atb_async_bridge_top — the split memnoc-like pattern.

    Exposes:
      - s_chan (to left/downstream funnel)
      - m_chan (to right/upstream funnel)
      - slv_clk/rst (source clock domain)
      - mst_clk/rst (destination clock domain)
      - sync (cross-domain FIFO interface: wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
      - afifo_slv_full_zero, flush_req (slv status/control)
      - afifo_mst_full_zero, afifo_mst_read_idle, flush_req_level (mst status/control)
    """

    def __init__(self, id: str = "async_bridge", cfg=None):
        super().__init__(id=id)

        self.slv_side = AtbAsyncBridgeSlvNode(id, cfg=cfg)
        self.mst_side = AtbAsyncBridgeMstNode(id, cfg=cfg)

        # Cross-domain sync: slv ↔ mst (wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
        connect(self.slv_side.sync, self.mst_side.sync)
        self.expose_unconnected_interfaces()


# ── Funnel ingress aggregator ─────────────────────────────────────────

class AtbFunnelIngressAggNode(UhdlComponentNode):
    """Per-channel aggregator: N scalar ATB m_chan → packed funnel vectors.

    Uses pre-built RTL modules: atb_funnel_ingress_aggregator_{N}to1.
    """
    def __init__(self, node_id: str, num_inputs: int, data_width: int, id_width: int, cfg):
        top = f"atb_funnel_ingress_aggregator_{num_inputs}to1"
        comp = TemplateComponent(config=cfg, top=top,
                                 ATB_DATA_WIDTH=data_width,
                                 ATB_ID_WIDTH=id_width)
        super().__init__(id=f"{node_id}_agg_node", impl=comp)

        for i in range(num_inputs):
            self.add_interface(f"ch{i}_chan",
                rf"^ch{i}_(m_(atvalid|atready|afvalid|afready|syncreq|atwakeup)"
                rf"|m_(atbytes|atdata|atid))$")
        for port_name in ["atvalids", "afreadys", "atids", "atdatas", "atbytess",
                          "atreadys", "afvalids", "syncreqs"]:
            self.add_interface(port_name, rf"^{port_name}$")

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
        comp = TemplateComponent(config=cfg, top="atb_iniu_sys")
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
        comp = TemplateComponent(config=cfg, top="atb_iniu_noc")
        super().__init__(id=f"{node_id}_top_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_m$")
        self.add_interface("rst_n", r"^rstn_atb_m$")
        self.add_interface("m_chan", r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("syncreq_level", r"^syncreq_level$")
        self.add_interface("flush_req_level", r"^flush_req_level$")
        self.add_interface("lp_afifo_rx", r"^afifo_mst_rx_req$")
        self.add_interface("lp_afifo_tx", r"^afifo_mst_tx_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("lp_rx", r"^lw_rx_req$")
        self.add_interface("lp_tx", r"^lw_tx_req$")
        self.add_interface("timeout_val", r"^timeout_val$")
        self.add_interface("afifo_sb_err", r"^atb_iniu_afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^atb_iniu_afifo_db_err$")


class AtbIniuNode(UhdlWrapperNode):
    """INIU composite: sys + noc (top) sides connected via async_fifo + LP."""
    def __init__(self, node_id: str, cfg, cfg_top):
        super().__init__(id=f"{node_id}_node")
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("timeout_val", is_global=True)

        self.sys_side = AtbIniuSysNode(node_id=node_id, cfg=cfg)
        self.top_side = AtbIniuTopWrapNode(node_id=node_id, cfg_top=cfg_top)

        connect(self.sys_side.clk,   self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.top_side.clk,   self.clk_noc)
        connect(self.top_side.rst_n, self.rst_noc_n)
        connect(self.sys_side.async_fifo, self.top_side.async_fifo)
        connect(self.sys_side.lp_tx, self.top_side.lp_rx)
        connect(self.sys_side.lp_rx, self.top_side.lp_tx)
        connect(self.sys_side.lp_afifo_tx, self.top_side.lp_afifo_rx)
        connect(self.sys_side.lp_afifo_rx, self.top_side.lp_afifo_tx)
        connect(self.top_side.flush_req_level, self.sys_side.flush_req)
        connect(self.top_side.syncreq_level, self.sys_side.syncreq_level)
        connect(self.timeout_val, self.sys_side.timeout_val)
        connect(self.timeout_val, self.top_side.timeout_val)
        self.expose_unconnected_interfaces()


class AtbIniuTopWrapNode(UhdlWrapperNode):
    """INIU top-side wrapper: exposes noc-facing ports for harden mounting."""
    def __init__(self, node_id: str, cfg_top):
        super().__init__(id=f"{node_id}_top_wrap")
        self.top_side = AtbIniuTopNode(node_id=node_id, cfg=cfg_top)
        for iface_name in [
            "clk",
            "rst_n",
            "m_chan",
            "syncreq_level",
            "flush_req_level",
            "lp_afifo_rx",
            "lp_afifo_tx",
            "async_fifo",
            "lp_rx",
            "lp_tx",
            "timeout_val",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))

        for iface_name in ["afifo_sb_err", "afifo_db_err"]:
            self.add_interface(iface_name, emit_io=False)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))


# ── TNIU nodes ──────────────────────────────────────────────────────────

class AtbTniuSysNode(UhdlComponentNode):
    """TNIU system-side — delivers ATB to debug SS."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_tniu_sys")
        super().__init__(id=f"{node_id}_sys_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_m$")
        self.add_interface("rst_n", r"^rstn_atb_m$")
        self.add_interface("m_chan", r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$")
        self.add_interface("pchnl_ctrl", r"^(preq|pstate|pactive|paccept|pdeny)$")
        self.add_interface("syncreq_level", r"^syncreq_level$")
        self.add_interface("flush_req_level", r"^flush_req_level$")
        self.add_interface("lp_lw_rx", r"^lw_rx_req$")
        self.add_interface("lp_lw_tx", r"^lw_tx_req$")
        self.add_interface("lp_afifo_rx", r"^afifo_slv_rx_req$")
        self.add_interface("lp_afifo_tx", r"^afifo_slv_tx_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("timeout_val", r"^timeout_val$")
        self.add_interface("afifo_sb_err", r"^atb_tniu_afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^atb_tniu_afifo_db_err$")


class AtbTniuTopNode(UhdlComponentNode):
    """TNIU top/noc-side — receives aggregated ATB from fabric."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="atb_tniu_noc")
        super().__init__(id=f"{node_id}_top_node", impl=comp)

        self.add_interface("clk",   r"^clk_atb_s$")
        self.add_interface("rst_n", r"^rstn_atb_s$")
        self.add_interface("s_chan_in", r"^s_(atvalid|atbytes|atdata|atid|afready|atwakeup)$")
        self.add_interface("s_chan_out", r"^s_(atready|afvalid)$")
        self.add_interface("s_syncreq", r"^s_syncreq$")
        self.add_interface("flush_req", r"^flush_req$")
        self.add_interface("async_fifo", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("syncreq_level", r"^syncreq_level$")
        self.add_interface("lp_lw_rx", r"^lw_rx_req$")
        self.add_interface("lp_lw_tx", r"^lw_tx_req$")
        self.add_interface("lp_afifo_rx", r"^afifo_slv_rx_req$")
        self.add_interface("lp_afifo_tx", r"^afifo_slv_tx_req$")
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
        self.add_interface("timeout_val", is_global=True)
        self.add_interface("afifo_sb_err", emit_io=False)
        self.add_interface("afifo_db_err", emit_io=False)

        self.top_side = AtbTniuTopWrapNode(node_id=node_id, cfg_top=cfg_top)
        self.sys_side = AtbTniuSysNode(node_id=node_id, cfg=cfg)

        connect(self.top_side.clk,   self.clk_noc)
        connect(self.top_side.rst_n, self.rst_noc_n)
        connect(self.sys_side.clk,   self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.top_side.async_fifo, self.sys_side.async_fifo)
        connect(self.sys_side.syncreq_level, self.top_side.syncreq_level)
        connect(self.sys_side.flush_req_level, self.top_side.flush_req)
        connect(self.sys_side.lp_lw_tx, self.top_side.lp_lw_rx)
        connect(self.top_side.lp_lw_tx, self.sys_side.lp_lw_rx)
        connect(self.sys_side.lp_afifo_tx, self.top_side.lp_afifo_rx)
        connect(self.top_side.lp_afifo_tx, self.sys_side.lp_afifo_rx)
        connect(self.timeout_val, self.sys_side.timeout_val)
        connect(self.timeout_val, self.top_side.timeout_val)
        connect(self.afifo_sb_err, self.sys_side.afifo_sb_err)
        connect(self.afifo_db_err, self.sys_side.afifo_db_err)
        self.expose_unconnected_interfaces()


class AtbTniuTopWrapNode(UhdlWrapperNode):
    """TNIU top-side wrapper: exposes noc-facing ports for harden mounting."""
    def __init__(self, node_id: str, cfg_top):
        super().__init__(id=f"{node_id}_top_wrap")
        self.top_side = AtbTniuTopNode(node_id=node_id, cfg=cfg_top)
        for iface_name in [
            "clk",
            "rst_n",
            "s_chan_in",
            "s_chan_out",
            "s_syncreq",
            "flush_req",
            "async_fifo",
            "syncreq_level",
            "lp_lw_rx",
            "lp_lw_tx",
            "lp_afifo_rx",
            "lp_afifo_tx",
            "timeout_val",
        ]:
            self.add_interface(iface_name)
            connect(getattr(self.top_side, iface_name), getattr(self, iface_name))

        self.add_interface("aifo_slv_full_zero", emit_io=False)
        connect(self.top_side.aifo_slv_full_zero, self.aifo_slv_full_zero)


# ── Network nodes ───────────────────────────────────────────────────────

class AtbFunnelBridgeNode(UhdlComponentNode):
    """N-to-1 ATB funnel bridge — per-channel inputs + single master output.
    Maps atb_funnel_bridge_Nto1 wrapper (no APB, no separate aggregator)."""
    def __init__(self, node_id: str, num_inputs: int, data_width: int, id_width: int, cfg):
        top = f"atb_funnel_bridge_{num_inputs}to1"
        comp = TemplateComponent(config=cfg, top=top,
                                 ATB_DATA_WIDTH=data_width,
                                 ATB_ID_WIDTH=id_width)
        super().__init__(id=f"{node_id}_node", impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("resetn", r"^resetn$")
        # Per-channel input interfaces (SS m_chan → funnel chN)
        for i in range(num_inputs):
            self.add_interface(f"ch{i}_chan",
                rf"^ch{i}_(m_atvalid|m_atready|m_afvalid|m_afready|m_syncreq|m_atwakeup)"
                rf"|ch{i}_(m_atbytes|m_atdata|m_atid)$")
        self.add_interface("m_chan",
            r"^m_(atvalid|atready|atbytes|atdata|atid|afvalid|afready|syncreq|atwakeup)$",
            emit_io=False)
        # Master output (funnel → downstream)
        self.add_interface("m_chan_out",
            r"^(m_atvalid|m_atbytes|m_atdata|m_atid|m_atwakeup|m_afready)$",
            emit_io=False)
        # Master input (downstream → funnel) — m_syncreq kept separate to
        # avoid pyslang direction-parsing issues (RTL has 'input m_syncreq')
        self.add_interface("m_chan_in",
            r"^(m_atready|m_afvalid)$",
            emit_io=False)
        self.add_interface("m_syncreq", r"^m_syncreq$", emit_io=False)


# ── Async Bridge nodes (memnoc-like split) ────────────────────────────

class AtbAsyncBridgeSlvNode(UhdlComponentNode):
    """Async bridge slave-side — source clock domain half of CDC.
    Maps network_atb_slv RTL module."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="network_atb_slv")
        super().__init__(id=f"{node_id}_slv_node", impl=comp)
        self.add_interface("slv_clk",   r"^clk_atb_s$")
        self.add_interface("slv_rst_n", r"^rstn_atb_s$")
        self.add_interface("s_chan_in", r"^s_(atvalid|atbytes|atdata|atid|afready|atwakeup)$")
        self.add_interface("s_chan_out", r"^s_(atready|afvalid)$")
        self.add_interface("s_syncreq", r"^s_syncreq$")
        # Sync interface — matching signals only (wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync|syncreq_level)$")
        # Status and control — side signals (exposed as separate at wrapper level)
        self.add_interface("afifo_slv_full_zero", r"^afifo_slv_full_zero$")
        self.add_interface("flush_req", r"^flush_req$")


class AtbAsyncBridgeMstNode(UhdlComponentNode):
    """Async bridge master-side — destination clock domain half of CDC.
    Maps network_atb_mst RTL module."""
    def __init__(self, node_id: str, cfg):
        comp = TemplateComponent(config=cfg, top="network_atb_mst")
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
        # FUSA ECC error outputs
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

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)

        for iface_name in ["s_chan_in", "s_chan_out", "s_syncreq", "m_chan"]:
            self.add_interface(iface_name)

        for iface_name in [
            "afifo_slv_full_zero",
            "afifo_mst_full_zero",
            "afifo_mst_read_idle",
            "atb_net_sb_err",
            "atb_net_db_err",
        ]:
            self.add_interface(iface_name, emit_io=False)

        connect(self.slv_side.slv_clk, self.clk)
        connect(self.slv_side.slv_rst_n, self.rst_n)
        connect(self.mst_side.mst_clk, self.clk)
        connect(self.mst_side.mst_rst_n, self.rst_n)
        connect(self.slv_side.s_chan_in, self.s_chan_in)
        connect(self.slv_side.s_chan_out, self.s_chan_out)
        connect(self.slv_side.s_syncreq, self.s_syncreq)
        connect(self.mst_side.m_chan, self.m_chan)

        # Cross-domain sync: slv ↔ mst (wptr_async, rptr_async, rptr_sync, pld_sync, syncreq_level)
        connect(self.slv_side.sync, self.mst_side.sync)
        connect(self.mst_side.flush_req_level, self.slv_side.flush_req)
        connect(self.slv_side.afifo_slv_full_zero, self.afifo_slv_full_zero)
        connect(self.mst_side.afifo_mst_full_zero, self.afifo_mst_full_zero)
        connect(self.mst_side.afifo_mst_read_idle, self.afifo_mst_read_idle)
        connect(self.mst_side.atb_net_sb_err, self.atb_net_sb_err)
        connect(self.mst_side.atb_net_db_err, self.atb_net_db_err)


class AtbAsyncBridgeSlvWrapNode(UhdlWrapperNode):
    """Harden-facing wrapper for the source half of the async bridge.

    Keep the functional CDC/control interfaces visible between harden blocks,
    but absorb local status-only outputs so they do not become harden/module
    boundary ports.
    """
    def __init__(self, node_id: str, slv_side):
        super().__init__(id=f"{node_id}_slv_wrap")
        self.slv_side = slv_side

        for iface_name in ["slv_clk", "slv_rst_n", "s_chan_in", "s_chan_out", "s_syncreq", "sync", "flush_req"]:
            self.add_interface(iface_name)
            connect(getattr(self.slv_side, iface_name), getattr(self, iface_name))

        self.add_interface("afifo_slv_full_zero", emit_io=False)
        connect(self.slv_side.afifo_slv_full_zero, self.afifo_slv_full_zero)


class AtbAsyncBridgeMstWrapNode(UhdlWrapperNode):
    """Harden-facing wrapper for the sink half of the async bridge.

    Keep the functional CDC/control interfaces visible between harden blocks,
    but absorb local status/error outputs so they do not become harden/module
    boundary ports.
    """
    def __init__(self, node_id: str, mst_side):
        super().__init__(id=f"{node_id}_mst_wrap")
        self.mst_side = mst_side

        for iface_name in ["mst_clk", "mst_rst_n", "m_chan", "sync", "flush_req_level"]:
            self.add_interface(iface_name)
            connect(getattr(self.mst_side, iface_name), getattr(self, iface_name))

        for iface_name in ["afifo_mst_full_zero", "afifo_mst_read_idle", "atb_net_sb_err", "atb_net_db_err"]:
            self.add_interface(iface_name, emit_io=False)
            connect(getattr(self.mst_side, iface_name), getattr(self, iface_name))


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

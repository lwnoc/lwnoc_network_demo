"""
IntrNode.py — UHDL node definitions for the interrupt ring NoC demo.

Node hierarchy:
  IntrIniuSysNode  (UhdlComponentNode) — wraps interrupt_iniu_aync_sys_side
  IntrIniuTopNode  (UhdlComponentNode) — wraps interrupt_iniu_aync_top_side
  IntrTniuSysNode  (UhdlComponentNode) — wraps interrupt_tniu_aync_sys_side
  IntrTniuTopNode  (UhdlComponentNode) — wraps interrupt_tniu_aync_top_side
  IntrRingStationNode (UhdlComponentNode) — wraps interrupt_req_ring_station
    IntrRingIniuStationNode (UhdlComponentNode) — INIU role station wrapper
    IntrRingTniuStationNode (UhdlComponentNode) — TNIU role station wrapper
  IntrRingLinkNode    (UhdlComponentNode) — wraps interrupt_req_ring_link
    IntrRingSpNode      (UhdlComponentNode) — wraps lwnoc_ring_sp
    IntrRingAsyncBridgeSlvNode (UhdlComponentNode) — wraps lwnoc_ring_async_bridge_slv
    IntrRingAsyncBridgeMstNode (UhdlComponentNode) — wraps lwnoc_ring_async_bridge_mst
    IntrRingAsyncBridgeNode    (UhdlComponentNode) — wraps lwnoc_ring_async_bridge

  IntrRingNodeWrap (UhdlWrapperNode)
      ring_sta  : IntrRingStationNode
      link_cw   : IntrRingLinkNode
      link_ccw  : IntrRingLinkNode
      exposes  : pring_in_if / pring_out_if / nring_in_if / nring_out_if
                 local_tx / local_rx

  IntrIniuNode (UhdlWrapperNode)
      iniu_sys  : IntrIniuSysNode
      iniu_top  : IntrIniuTopNode
      ring_wrap : IntrRingNodeWrap
      exposes  : pring/nring ring interfaces; clk_sys/rst_sys_n (sys domain)
                 all unconnected sys-side ports via expose_unconnected_interfaces()

  IntrTniuNode (UhdlWrapperNode)
      tniu_top  : IntrTniuTopNode
      tniu_sys  : IntrTniuSysNode
      ring_wrap : IntrRingNodeWrap
      exposes  : pring/nring ring interfaces; clk_sys/rst_sys_n (sys domain)
                 all unconnected ports via expose_unconnected_interfaces()
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateComponent
from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from IntrTemplate import (
    intr_iniu_top_config,
    intr_tniu_top_config,
    intr_ring_network_config,
    intr_ring_buf_config,
    intr_ring_link_config,
    intr_ring_req_sink_config,
    intr_ring_req_zero_source_config,
    intr_ring_station_config,
)


# ─────────────────────────────────────────────────────────────────────────────
# Leaf component nodes
# ─────────────────────────────────────────────────────────────────────────────

class IntrIniuSysNode(UhdlComponentNode):
    """System-clock-domain INIU component (interrupt_iniu_aync_sys_side)."""

    INIU_ASYNC_FIFO_DEPTH = 16  # align to interrupt_noc_top_wrap.sv INIU_FIFO_DEPTH

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="interrupt_iniu_aync_sys_side",
                                ASYNC_FIFO_DEPTH=IntrIniuSysNode.INIU_ASYNC_FIFO_DEPTH)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk",          "clk")
        self.add_interface("rst_n",        "rst_n")
        self.add_interface("v_interrupt",  "v_interrupt")
        self.add_interface("iniu_src_id",  "iniu_src_id")
        self.add_interface("apb",          r"^p_.*")
        self.add_interface("async_fifo",   r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val",  "timeout_val")
        # s_async_master_hub_rx_req + s_async_master_hub_tx_req (cross-domain LP)
        self.add_interface("lp_async",     r"s_async_master_hub")
        # lp_hub_rx_req + lp_hub_tx_req (hub-level LP, exposed externally)
        self.add_interface("lp_hub",       r"^lp_hub.*")


class IntrIniuTopNode(UhdlComponentNode):
    """NOC-clock-domain INIU component (interrupt_iniu_aync_top_side)."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_iniu_top_config, top="interrupt_iniu_aync_top_side",
                                ASYNC_FIFO_DEPTH=IntrIniuSysNode.INIU_ASYNC_FIFO_DEPTH)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk",        "clk")
        self.add_interface("rst_n",      "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        # m_async_master_hub_rx_req + m_async_master_hub_tx_req (cross-domain LP)
        self.add_interface("lp_async",   r"m_async_master_hub")
        # Ring station payload excludes the unused req_threshold sideband.
        self.add_interface("ring_req",   r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


class IntrTniuSysNode(UhdlComponentNode):
    """System-clock-domain TNIU component (interrupt_tniu_aync_sys_side)."""

    TNIU_ASYNC_FIFO_DEPTH = 10  # align to interrupt_noc_top_wrap.sv TNIU_FIFO_DEPTH

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="interrupt_tniu_aync_sys_side",
                                ASYNC_FIFO_DEPTH=IntrTniuSysNode.TNIU_ASYNC_FIFO_DEPTH)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk",               "clk")
        self.add_interface("rst_n",             "rst_n")
        self.add_interface("tniu_tgt_id",       "tniu_tgt_id")
        self.add_interface("v_interrupt",       "v_interrupt")
        self.add_interface("v_merge_interrupt", "v_merge_interrupt")
        self.add_interface("apb",               r"^p_.*")
        self.add_interface("async_fifo",        r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val",       "timeout_val")
        # m_async_master_hub_rx_req + m_async_master_hub_tx_req (cross-domain LP)
        self.add_interface("lp_async",          r"m_async_master_hub")
        # m_niu_lp_hub_rx_req + m_niu_lp_hub_tx_req (NIU LP hub, paired with top)
        self.add_interface("lp_niu_hub",        r"m_niu_lp_hub.*")


class IntrTniuTopNode(UhdlComponentNode):
    """NOC-clock-domain TNIU component (interrupt_tniu_aync_top_side)."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_tniu_top_config, top="interrupt_tniu_aync_top_side",
                                ASYNC_FIFO_DEPTH=IntrTniuSysNode.TNIU_ASYNC_FIFO_DEPTH)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk",        "clk")
        self.add_interface("rst_n",      "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val","timeout_val")
        # lp_hub_rx_req + lp_hub_tx_req (external hub LP for NOC domain)
        self.add_interface("lp_hub",     r"^lp_hub.*")
        # s_niu_lp_hub_rx_req + s_niu_lp_hub_tx_req (paired with tniu_sys.lp_niu_hub)
        self.add_interface("lp_niu_hub", r"s_niu_lp_hub")
        # s_async_master_hub_rx_req + s_async_master_hub_tx_req (cross-domain LP)
        self.add_interface("lp_async",   r"s_async_master_hub")
        # Ring station payload excludes the unused req_threshold sideband.
        self.add_interface("ring_req",   r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


class IntrRingBufNode(UhdlComponentNode):
    """Buffered ring link wrapper (intr_ring_buf_wrap)."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_buf_config, top="intr_ring_buf_wrap")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_noc", "clk_noc", is_global=True)
        self.add_interface("rst_noc_n", "rst_noc_n", is_global=True)
        self.add_interface(
            "ring_req_src",
            r"^req_(valid|payload|srcid|tgtid|qos|last|ready|vcid|threshold)_src$",
        )
        self.add_interface(
            "ring_req_dst",
            r"^req_(valid|payload|srcid|tgtid|qos|last|ready|vcid|threshold)_dst$",
        )


class IntrRingStationNode(UhdlComponentNode):
    """Combinational ring routing station (interrupt_req_ring_station)."""

    def __init__(self, id: str, node_id: int, has_iniu: bool, has_tniu: bool):
        comp = TemplateComponent(
            config=intr_ring_station_config,
            top="interrupt_req_ring_station",
            NODE_ID=node_id,
            NODE_COUNT=6,
            HAS_INIU=1 if has_iniu else 0,
            HAS_TNIU=1 if has_tniu else 0,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("local_tx", r"^local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("cw_in", r"^cw_in_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("cw_out", r"^cw_out_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("ccw_in", r"^ccw_in_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("ccw_out", r"^ccw_out_(valid|ready|payload|srcid|tgtid|qos|last)$")


class IntrRingIniuStationNode(IntrRingStationNode):
    """INIU-role ring station with fixed role parameters."""

    def __init__(self, id: str, node_id: int):
        super().__init__(id=id, node_id=node_id, has_iniu=True, has_tniu=False)


class IntrRingTniuStationNode(IntrRingStationNode):
    """TNIU-role ring station with fixed role parameters."""

    def __init__(self, id: str, node_id: int):
        super().__init__(id=id, node_id=node_id, has_iniu=False, has_tniu=True)


class IntrRingSpNode(UhdlComponentNode):
    """Ring SP primitive node for memnoc-style component registration."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_network_config, top="lwnoc_ring_sp")
        super().__init__(id=id, impl=comp)


class IntrRingAsyncBridgeSlvNode(UhdlComponentNode):
    """Ring async bridge slave-half primitive registration."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_network_config, top="lwnoc_ring_async_bridge_slv")
        super().__init__(id=id, impl=comp)


class IntrRingAsyncBridgeMstNode(UhdlComponentNode):
    """Ring async bridge master-half primitive registration."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_network_config, top="lwnoc_ring_async_bridge_mst")
        super().__init__(id=id, impl=comp)


class IntrRingAsyncBridgeNode(UhdlComponentNode):
    """Full ring async bridge primitive registration."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_network_config, top="lwnoc_ring_async_bridge")
        super().__init__(id=id, impl=comp)


class IntrRingLinkNode(UhdlComponentNode):
    """One-entry registered ring link (interrupt_req_ring_link)."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_link_config, top="interrupt_req_ring_link")
        super().__init__(id=id, impl=comp)

        self.add_interface("s_req", r"^s_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("m_req", r"^m_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")


class IntrRingReqSinkNode(UhdlComponentNode):
    """Consumes an unused local_rx path inside an INIU wrapper."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_req_sink_config, top="intr_ring_req_sink")
        super().__init__(id=id, impl=comp)

        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class IntrRingReqZeroSourceNode(UhdlComponentNode):
    """Drives an idle local_tx path inside a TNIU wrapper."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=intr_ring_req_zero_source_config, top="intr_ring_req_zero_source")
        super().__init__(id=id, impl=comp)

        self.add_interface("local_tx", r"^local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")


# ─────────────────────────────────────────────────────────────────────────────
# Wrapper nodes
# ─────────────────────────────────────────────────────────────────────────────

class IntrRingNodeWrap(UhdlWrapperNode):
    """Ring node wrapper: station + CW link + CCW link."""

    def __init__(self, id: str, node_id: int, has_iniu: bool, has_tniu: bool):
        super().__init__(id=id)

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("local_tx")
        self.add_interface("local_rx")

        if has_iniu and not has_tniu:
            self.ring_sta = IntrRingIniuStationNode(id=f"{id}_sta", node_id=node_id)
        elif has_tniu and not has_iniu:
            self.ring_sta = IntrRingTniuStationNode(id=f"{id}_sta", node_id=node_id)
        else:
            self.ring_sta = IntrRingStationNode(
                id=f"{id}_sta",
                node_id=node_id,
                has_iniu=has_iniu,
                has_tniu=has_tniu,
            )
        self.link_cw = IntrRingLinkNode(id=f"{id}_link_cw")
        self.link_ccw = IntrRingLinkNode(id=f"{id}_link_ccw")

        connect(self.link_cw.clk, self.clk)
        connect(self.link_cw.rst_n, self.rst_n)
        connect(self.link_ccw.clk, self.clk)
        connect(self.link_ccw.rst_n, self.rst_n)

        connect(self.ring_sta.cw_out, self.link_cw.s_req)
        connect(self.ring_sta.ccw_out, self.link_ccw.s_req)

        connect(self.ring_sta.cw_in, self.pring_in_if)
        connect(self.link_cw.m_req, self.pring_out_if)
        connect(self.ring_sta.ccw_in, self.nring_in_if)
        connect(self.link_ccw.m_req, self.nring_out_if)

        connect(self.ring_sta.local_tx, self.local_tx)
        connect(self.ring_sta.local_rx, self.local_rx)

        self.expose_unconnected_interfaces()


class IntrIniuNode(UhdlWrapperNode):
    """
    INIU composite node: sys_side + top_side + ring wrap.

    Externally exposed:
      clk_sys / rst_sys_n   — system-domain clock/reset
      clk_noc (global) / rst_noc_n (global) — NOC-domain clock/reset
        pring_in_if / pring_out_if / nring_in_if / nring_out_if  — ring links
      v_interrupt / iniu_src_id / apb / timeout_val / lp_hub   — sys-side user ports
    """

    def __init__(self, id: str, sys_cfg):
        super().__init__(id=id)

        # Explicit external interfaces
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc",  is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        # Sub-nodes
        self.iniu_sys = IntrIniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.iniu_top = IntrIniuTopNode(id=f"{id}_top")
        node_id = int(id.replace("iniu", ""))
        self.ring_wrap = IntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            has_iniu=True,
            has_tniu=False,
        )
        self.ring_sink = IntrRingReqSinkNode(id=f"{id}_ring_sink")

        # Clock / reset mapping
        connect(self.iniu_sys.clk,   self.clk_sys)
        connect(self.iniu_sys.rst_n, self.rst_sys_n)
        connect(self.iniu_top.clk,   self.clk_noc)
        connect(self.iniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)

        # Cross-domain connections (async FIFO + LP async bridge)
        connect(self.iniu_sys.async_fifo, self.iniu_top.async_fifo)
        connect(self.iniu_sys.lp_async,   self.iniu_top.lp_async)

        connect(self.iniu_top.ring_req, self.ring_wrap.local_tx)
        connect(self.ring_wrap.local_rx, self.ring_sink.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        # Auto-expose remaining: v_interrupt, iniu_src_id, apb, timeout_val, lp_hub
        self.expose_unconnected_interfaces()


class IntrTniuNode(UhdlWrapperNode):
    """
    TNIU composite node: top_side + sys_side + ring wrap.

    Externally exposed:
      clk_sys / rst_sys_n   — system-domain clock/reset
      clk_noc (global) / rst_noc_n (global) — NOC-domain clock/reset
        pring_in_if / pring_out_if / nring_in_if / nring_out_if  — ring links
      tniu_tgt_id / v_interrupt / v_merge_interrupt / apb / timeout_val — sys side
      lp_hub   — NOC-domain hub LP (from tniu_top)
    """

    def __init__(self, id: str, sys_cfg):
        super().__init__(id=id)

        # Explicit external interfaces
        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc",  is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        # Sub-nodes
        self.tniu_top = IntrTniuTopNode(id=f"{id}_top")
        self.tniu_sys = IntrTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        node_id = 4 + int(id.replace("tniu", ""))
        self.ring_wrap = IntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            has_iniu=False,
            has_tniu=True,
        )
        self.ring_source = IntrRingReqZeroSourceNode(id=f"{id}_ring_source")

        # Clock / reset mapping
        connect(self.tniu_sys.clk,   self.clk_sys)
        connect(self.tniu_sys.rst_n, self.rst_sys_n)
        connect(self.tniu_top.clk,   self.clk_noc)
        connect(self.tniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)

        # Cross-domain connections (async FIFO + LP async bridge + NIU LP hub)
        connect(self.tniu_sys.async_fifo, self.tniu_top.async_fifo)
        connect(self.tniu_sys.lp_async,   self.tniu_top.lp_async)
        connect(self.tniu_sys.lp_niu_hub, self.tniu_top.lp_niu_hub)

        connect(self.ring_wrap.local_rx, self.tniu_top.ring_req)
        connect(self.ring_source.local_tx, self.ring_wrap.local_tx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        # Auto-expose remaining: tniu_tgt_id, v_interrupt, v_merge_interrupt,
        #   apb, timeout_val, lp_hub (from tniu_top)
        self.expose_unconnected_interfaces()

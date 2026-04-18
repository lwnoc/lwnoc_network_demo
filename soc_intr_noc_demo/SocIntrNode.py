"""Node definitions for the SoC-scale interrupt ring NoC demo."""

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

from SocIntrTemplate import (
    INIU_SYS_CONFIGS,
    TNIU_SYS_CONFIGS,
    soc_intr_iniu_top_config,
    soc_intr_tniu_top_config,
    soc_intr_ring_network_config,
    soc_intr_ring_link_config,
    soc_intr_ring_req_sink_config,
    soc_intr_ring_req_zero_source_config,
    soc_intr_ring_station_config,
)


class SocIntrIniuSysNode(UhdlComponentNode):
    INIU_ASYNC_FIFO_DEPTH = 16

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_iniu_aync_sys_side",
            ASYNC_FIFO_DEPTH=SocIntrIniuSysNode.INIU_ASYNC_FIFO_DEPTH,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("v_interrupt", "v_interrupt")
        self.add_interface("iniu_src_id", "iniu_src_id")
        self.add_interface("apb", r"^p_.*")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("lp_async", r"s_async_master_hub")
        self.add_interface("lp_hub", r"^lp_hub.*")


class SocIntrIniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(
            config=soc_intr_iniu_top_config,
            top="interrupt_iniu_aync_top_side",
            ASYNC_FIFO_DEPTH=SocIntrIniuSysNode.INIU_ASYNC_FIFO_DEPTH,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_async", r"m_async_master_hub")
        self.add_interface("ring_req", r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrTniuSysNode(UhdlComponentNode):
    TNIU_ASYNC_FIFO_DEPTH = 10

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_tniu_aync_sys_side",
            ASYNC_FIFO_DEPTH=SocIntrTniuSysNode.TNIU_ASYNC_FIFO_DEPTH,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("tniu_tgt_id", "tniu_tgt_id")
        self.add_interface("v_interrupt", "v_interrupt")
        self.add_interface("v_merge_interrupt", "v_merge_interrupt")
        self.add_interface("apb", r"^p_.*")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("lp_async", r"m_async_master_hub")
        self.add_interface("lp_niu_hub", r"m_niu_lp_hub.*")


class SocIntrTniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(
            config=soc_intr_tniu_top_config,
            top="interrupt_tniu_aync_top_side",
            ASYNC_FIFO_DEPTH=SocIntrTniuSysNode.TNIU_ASYNC_FIFO_DEPTH,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("lp_hub", r"^lp_hub.*")
        self.add_interface("lp_niu_hub", r"s_niu_lp_hub")
        self.add_interface("lp_async", r"s_async_master_hub")
        self.add_interface("ring_req", r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingStationNode(UhdlComponentNode):
    def __init__(self, id: str, node_id: int, node_count: int, has_iniu: bool, has_tniu: bool):
        comp = TemplateComponent(
            config=soc_intr_ring_station_config,
            top="interrupt_req_ring_station",
            NODE_ID=node_id,
            NODE_COUNT=node_count,
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


class SocIntrRingLinkNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_link_config, top="interrupt_req_ring_link")
        super().__init__(id=id, impl=comp)

        self.add_interface("s_req", r"^s_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("m_req", r"^m_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")


class SocIntrRingSpNode(UhdlComponentNode):
    """Primitive registration aligned with lwnoc_intr_noc_demo/IntrNode.py."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_network_config, top="lwnoc_ring_sp")
        super().__init__(id=id, impl=comp)


class SocIntrRingAsyncBridgeSlvNode(UhdlComponentNode):
    """Primitive registration aligned with lwnoc_intr_noc_demo/IntrNode.py."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_network_config, top="lwnoc_ring_async_bridge_slv")
        super().__init__(id=id, impl=comp)


class SocIntrRingAsyncBridgeMstNode(UhdlComponentNode):
    """Primitive registration aligned with lwnoc_intr_noc_demo/IntrNode.py."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_network_config, top="lwnoc_ring_async_bridge_mst")
        super().__init__(id=id, impl=comp)


class SocIntrRingAsyncBridgeNode(UhdlComponentNode):
    """Primitive registration aligned with lwnoc_intr_noc_demo/IntrNode.py."""

    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_network_config, top="lwnoc_ring_async_bridge")
        super().__init__(id=id, impl=comp)


class SocIntrRingReqSinkNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_req_sink_config, top="intr_ring_req_sink")
        super().__init__(id=id, impl=comp)
        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingReqZeroSourceNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=soc_intr_ring_req_zero_source_config, top="intr_ring_req_zero_source")
        super().__init__(id=id, impl=comp)
        self.add_interface("local_tx", r"^local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingNodeWrap(UhdlWrapperNode):
    def __init__(self, id: str, node_id: int, node_count: int, has_iniu: bool, has_tniu: bool):
        super().__init__(id=id)

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("local_tx")
        self.add_interface("local_rx")

        self.ring_sta = SocIntrRingStationNode(
            id=f"{id}_sta",
            node_id=node_id,
            node_count=node_count,
            has_iniu=has_iniu,
            has_tniu=has_tniu,
        )
        self.link_cw = SocIntrRingLinkNode(id=f"{id}_link_cw")
        self.link_ccw = SocIntrRingLinkNode(id=f"{id}_link_ccw")

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


class SocIntrIniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.iniu_sys = SocIntrIniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.iniu_top = SocIntrIniuTopNode(id=f"{id}_top")
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=True,
            has_tniu=False,
        )
        self.ring_sink = SocIntrRingReqSinkNode(id=f"{id}_ring_sink")

        connect(self.iniu_sys.clk, self.clk_sys)
        connect(self.iniu_sys.rst_n, self.rst_sys_n)
        connect(self.iniu_top.clk, self.clk_noc)
        connect(self.iniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)

        connect(self.iniu_sys.async_fifo, self.iniu_top.async_fifo)
        connect(self.iniu_sys.lp_async, self.iniu_top.lp_async)
        connect(self.iniu_top.ring_req, self.ring_wrap.local_tx)
        connect(self.ring_wrap.local_rx, self.ring_sink.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()


class SocIntrTniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.tniu_top = SocIntrTniuTopNode(id=f"{id}_top")
        self.tniu_sys = SocIntrTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=False,
            has_tniu=True,
        )
        self.ring_source = SocIntrRingReqZeroSourceNode(id=f"{id}_ring_source")

        connect(self.tniu_sys.clk, self.clk_sys)
        connect(self.tniu_sys.rst_n, self.rst_sys_n)
        connect(self.tniu_top.clk, self.clk_noc)
        connect(self.tniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)

        connect(self.tniu_sys.async_fifo, self.tniu_top.async_fifo)
        connect(self.tniu_sys.lp_async, self.tniu_top.lp_async)
        connect(self.tniu_sys.lp_niu_hub, self.tniu_top.lp_niu_hub)
        connect(self.ring_wrap.local_rx, self.tniu_top.ring_req)
        connect(self.ring_source.local_tx, self.ring_wrap.local_tx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()


def make_iniu_node(node_name: str, node_id: int, node_count: int) -> SocIntrIniuNode:
    return SocIntrIniuNode(
        id=node_name,
        sys_cfg=INIU_SYS_CONFIGS[node_name],
        node_id=node_id,
        node_count=node_count,
    )


def make_tniu_node(node_name: str, node_id: int, node_count: int) -> SocIntrTniuNode:
    return SocIntrTniuNode(
        id=node_name,
        sys_cfg=TNIU_SYS_CONFIGS[node_name],
        node_id=node_id,
        node_count=node_count,
    )



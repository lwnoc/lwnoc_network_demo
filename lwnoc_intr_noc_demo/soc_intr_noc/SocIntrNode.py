"""Node definitions for the SoC-scale interrupt ring NoC demo."""

import os
from pathlib import Path

from _project_env import LWNOC_TOPO_ROOT

from uhdl.uhdl.core.TemplateIP import TemplateComponent
from uhdl.uhdl.core.VComponent import VComponent
from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from topo_core.utils.data_topology import register_data_topology

TOP_LAYER_SUFFIX = "_noc_side"
TOP_FUNC_CLK = "clk_top_func"
TOP_FUNC_RST_N = "rst_top_func_n"


class ParamInstTemplateComponent(VComponent):
    """Source-filelist VComponent variant that preserves per-instance RTL parameters."""

    def __init__(self, config, top: str, instance=None, **kwargs):
        self._parent_template = config.get_or_create_ip()
        self._parent_template.temp_build()
        source_file = self._parent_template.get_unity_wrapper()

        if instance is None:
            instance = top

        super().__init__(
            file=source_file,
            top=config.prefix + top,
            instance=instance,
            **kwargs,
        )


def _top_layer_id(node_name: str) -> str:
    return f"{node_name}{TOP_LAYER_SUFFIX}"



# Import additional requirements for XbarRoutingLutNode
from uhdl.uhdl.core.Component import Component
from uhdl.uhdl.core.Variable import Output, Input, UInt, Wire
from uhdl.uhdl.core.Operator import Combine, Equal, EmptyWhen
from topo_core.utils.logger import get_topo_logger
from typing import Dict, Tuple, Optional, Any
from collections import deque

_logger = get_topo_logger("SocIntrNode")


class SocIntrXbarRoutingLutComponent(Component):
    """
    UHDL component for generating xbar routing LUT based on (src_id, tgt_id) tuples.
    Generates logic to select pring (0) or nring (1) based on topology shortest paths.
    """
    
    def __init__(self, lut_data: Dict[Tuple[int, int], int], num_nodes: int, node_id_width: int, num_channels: int):
        self.lut_data = lut_data
        self.num_nodes = num_nodes
        self.node_id_width = node_id_width
        self.num_channels = num_channels
        super().__init__()

    @property
    def module_name(self):
        return f"soc_intr_xbar_routing_lut_w{self.node_id_width}_c{self.num_channels}"
    
    def circuit(self):
        """Generate the routing LUT circuit."""
        self.src_id = Input(UInt(self.node_id_width))
        channel_ports = []
        for ch in range(self.num_channels):
            tgt_id_ch = self.create(f"xbar_ch{ch}_tgt_id", Input(UInt(self.node_id_width)))
            sel_bit_ch = self.create(f"xbar_ch{ch}_sel_bit", Output(UInt(1)))
            channel_ports.append((tgt_id_ch, sel_bit_ch))
        
        sorted_lut = sorted(self.lut_data.items())
        
        for ch, (tgt_id_ch, sel_bit_ch) in enumerate(channel_ports):
            sel_lut = EmptyWhen()
            for (src, tgt), sel_val in sorted_lut:
                combined_key = Combine(UInt(self.node_id_width, src), UInt(self.node_id_width, tgt))
                actual_combined = Combine(self.src_id, tgt_id_ch)
                sel_lut = sel_lut.when(Equal(actual_combined, combined_key)).then(UInt(1, sel_val))

            sel_lut = sel_lut.otherwise(UInt(1, 0))
            sel_bit_ch += sel_lut
        
        return [self.src_id] + [ch[0] for ch in channel_ports] + [ch[1] for ch in channel_ports]


class SocIntrXbarRoutingLutNode(UhdlComponentNode):
    """
    Topology node for generating dynamic xbar routing decisions based on shortest paths.
    Wraps SocIntrXbarRoutingLutComponent and supports DataTopology-aware LUT computation.
    """
    
    def __init__(self, id: str, node_id_width: int = 5, num_channels: int = 1):
        self.num_nodes = 2**node_id_width
        default_lut = {(i, j): 0 for i in range(self.num_nodes) for j in range(self.num_nodes)}
        
        comp = SocIntrXbarRoutingLutComponent(
            lut_data=default_lut,
            num_nodes=self.num_nodes,
            node_id_width=node_id_width,
            num_channels=num_channels
        )
        super().__init__(id=id, impl=comp)
        
        self.node_id_width = node_id_width
        self.num_channels = num_channels
        self._component = comp
        
        self.add_interface("src_id", "src_id")
        for ch in range(num_channels):
            self.add_interface(f"xbar_ch{ch}_tgt_id", f"xbar_ch{ch}_tgt_id")
            self.add_interface(f"xbar_ch{ch}_sel_bit", f"xbar_ch{ch}_sel_bit")
    
    def _compute_lut_from_shortest_paths(self, data_topo) -> Dict[Tuple[int, int], int]:
        """Extract routing decisions from DataTopology shortest paths."""
        lut = {}
        all_paths = data_topo.all_pairs_shortest_paths()
        num_nodes = len(data_topo.get_all_node_ids())
        
        for src_id in range(num_nodes):
            for tgt_id in range(num_nodes):
                if src_id == tgt_id:
                    lut[(src_id, tgt_id)] = 0
                elif (src_id, tgt_id) in all_paths:
                    path_info = all_paths[(src_id, tgt_id)]
                    if path_info and hasattr(path_info, 'first_port_info'):
                        first_port = path_info.first_port_info
                        lut[(src_id, tgt_id)] = 1 if 'nring' in str(first_port).lower() else 0
                    else:
                        lut[(src_id, tgt_id)] = 0
                else:
                    lut[(src_id, tgt_id)] = 0
        
        return lut
    
    def build_uhdl(self):
        """Build UHDL circuit using DataTopology shortest paths (memnoc-style).

        Recreates the Component with computed lut_data so circuit() executes
        with fresh data — NOT just setting an attribute on a stale Component.
        """
        _datatopo = None
        parent_queue = deque(getattr(self, "parents", []))

        while parent_queue and not _datatopo:
            node = parent_queue.popleft()
            if node and hasattr(node, '_datatopo'):
                _datatopo = node._datatopo
                break
            if node and hasattr(node, 'parents'):
                for parent in node.parents:
                    parent_queue.append(parent)

        if _datatopo:
            lut_data = self._compute_lut_from_shortest_paths(_datatopo)
            num_nodes = len(_datatopo.get_all_node_ids())
            self.num_nodes = num_nodes
            _logger.info(f"Computed xbar LUT from DataTopology for {self.id}: {len(lut_data)} entries")
        else:
            num_nodes = self.num_nodes
            lut_data = {(i, j): 0 for i in range(num_nodes) for j in range(num_nodes)}
            _logger.warning(f"DataTopology not found for {self.id}, using default all-pring LUT")

        # memnoc pattern: create NEW Component with computed data, replace uhdl_component
        new_comp = SocIntrXbarRoutingLutComponent(
            lut_data=lut_data,
            num_nodes=num_nodes,
            node_id_width=self.node_id_width,
            num_channels=self.num_channels,
        )
        self.uhdl_component = new_comp
        self._component = new_comp
        # Re-map interfaces on the new component
        self.map_interface("src_id", "src_id")
        for ch in range(self.num_channels):
            self.map_interface(f"xbar_ch{ch}_tgt_id", f"xbar_ch{ch}_tgt_id")
            self.map_interface(f"xbar_ch{ch}_sel_bit", f"xbar_ch{ch}_sel_bit")
        return self.uhdl_component


class NodeIdGenComponent(Component):
    def __init__(self, node_id_value: int = 0, node_id_width: int = 8):
        self._node_id_value = node_id_value
        self._node_id_width = node_id_width
        super().__init__()

    @property
    def module_name(self):
        return (
            f"SocIntrNodeIdGen_node_id_value_{self._node_id_value}"
            f"_node_id_width_{self._node_id_width}"
        )

    def circuit(self):
        self.node_id = Output(UInt(self._node_id_width))
        self.node_id += UInt(self._node_id_width, self._node_id_value)


class NodeIdGenNode(UhdlComponentNode):
    def __init__(self, id: str = "node_id_gen", node_id_width: int = 8):
        self._node_id_width = node_id_width
        comp = NodeIdGenComponent(node_id_value=0, node_id_width=node_id_width)
        super().__init__(id=id, impl=comp)
        self.add_interface("node_id", "node_id")

    def build_uhdl(self):
        node_id_value = 0
        visited = set()
        queue = deque(getattr(self, "parents", []))
        while queue:
            parent = queue.popleft()
            if id(parent) in visited:
                continue
            visited.add(id(parent))
            if hasattr(parent, 'data_topo_id') and parent.data_topo_id is not None:
                node_id_value = parent.data_topo_id
                break
            queue.extend(getattr(parent, 'parents', []))

        self.uhdl_component = NodeIdGenComponent(
            node_id_value=node_id_value,
            node_id_width=self._node_id_width,
        )
        return self.uhdl_component


class SocIntrIniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_iniu_async_sys_side",
            struct_mode="packed",
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("v_interrupt", "v_interrupt")
        self.add_interface("iniu_src_id", "iniu_src_id")
        self.add_interface("apb", r"^p_.*")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("lp_async", r"s_async_master_hub.*")
        self.add_interface("lp_hub", r"^lp_hub.*")
        self.add_interface("pchannel", r"^(preq|pstate|pactive|paccept|pdeny)$")
        self.add_interface("regbank_parity_err", r"^regbank_parity_err$")
        self.add_interface("iniu_lut_sb_err", r"^iniu_lut_sb_err$")
        self.add_interface("iniu_lut_db_err", r"^iniu_lut_db_err$")


class SocIntrIniuTopNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_iniu_async_top_side",
            struct_mode="packed",
            **params,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_async", r"m_async_master_hub.*")
        self.add_interface("ring_req", r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("afifo_sb_err", r"^afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^afifo_db_err$")


class SocIntrTniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_tniu_async_sys_side",
            struct_mode="packed",
            **params,
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
        self.add_interface("lp_async", r"m_async_master_hub.*")
        self.add_interface("lp_niu_hub", r"m_niu_lp_hub.*")
        self.add_interface("pchannel", r"^(preq|pstate|pactive|paccept|pdeny)$")
        self.add_interface("afifo_sb_err", r"^afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^afifo_db_err$")
        self.add_interface("regbank_parity_err", r"^regbank_parity_err$")
        self.add_interface("tniu_lut_sb_err", r"^tniu_lut_sb_err$")
        self.add_interface("tniu_lut_db_err", r"^tniu_lut_db_err$")


class SocIntrTniuTopNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_tniu_async_top_side",
            struct_mode="packed",
            **params,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("lp_hub", r"^lp_hub.*")
        self.add_interface("lp_niu_hub", r"s_niu_lp_hub.*")
        self.add_interface("lp_async", r"s_async_master_hub.*")
        self.add_interface("ring_req", r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrRingBufNode(UhdlComponentNode):
    """Dual-direction ring station primitive with explicit per-direction local ports."""

    def __init__(self, id: str, cfg, node_id: int, node_count: int):
        params = getattr(cfg, 'param_overrides', {})
        _p = {
            "RING_ID": node_id,
            "NODE_NUM": node_count,
            "PLD_WIDTH": params.get("PLD_WIDTH", 40),
            "ID_WIDTH": params.get("ID_WIDTH", 8),
            "QOS_WIDTH": params.get("QOS_WIDTH", 4),
            "SINGLE_THR_WIDTH": 1,
        }
        comp = ParamInstTemplateComponent(config=cfg, top="intr_ring_buf_wrap", **_p)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_local_tx", r"^pring_local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_local_rx", r"^pring_local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_local_tx", r"^nring_local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_local_rx", r"^nring_local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrIniuEndpointNode(UhdlComponentNode):
    """REQ-source endpoint wrapper with explicit xbar routing contract."""

    def __init__(self, id: str, cfg, node_id: int, node_count: int):
        params = getattr(cfg, 'param_overrides', {})
        _p = {
            "RING_ID": node_id,
            "NODE_NUM": node_count,
            "PLD_WIDTH": params.get("PLD_WIDTH", 40),
            "ID_WIDTH": params.get("ID_WIDTH", 8),
            "QOS_WIDTH": params.get("QOS_WIDTH", 4),
            "SINGLE_THR_WIDTH": 1,
        }
        comp = ParamInstTemplateComponent(config=cfg, top="lwnoc_intr_iniu_endpoint_wrap", **_p)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_tx", r"^local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("xbar_req_tgt_id", "xbar_req_tgt_id")
        self.add_interface("xbar_req_sel_bit", "xbar_req_sel_bit")


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrTniuEndpointNode(UhdlComponentNode):
    """REQ-sink endpoint wrapper that only receives from the ring."""

    def __init__(self, id: str, cfg, node_id: int, node_count: int):
        params = getattr(cfg, 'param_overrides', {})
        _p = {
            "RING_ID": node_id,
            "NODE_NUM": node_count,
            "PLD_WIDTH": params.get("PLD_WIDTH", 40),
            "ID_WIDTH": params.get("ID_WIDTH", 8),
            "QOS_WIDTH": params.get("QOS_WIDTH", 4),
            "SINGLE_THR_WIDTH": 1,
        }
        comp = ParamInstTemplateComponent(config=cfg, top="lwnoc_intr_tniu_endpoint_wrap", **_p)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 0),
    ('nring_in_if', 'nring_out_if', 0),
])
class SocIntrRingSpNode(UhdlComponentNode):
    """Simplified ring-visible SP node using a local adapter wrapper."""

    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(
            config=cfg,
            top="lwnoc_intr_ring_sp_wrap",
            **params,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingAsyncBridgeSlvNode(UhdlComponentNode):
    """Source-domain half of a bidirectional async cut."""

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="lwnoc_intr_ring_async_bridge_wrap_slv",
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_slv", "clk_slv")
        self.add_interface("rst_slv_n", "rst_slv_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_async_if", r"^pring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")
        self.add_interface("nring_async_if", r"^nring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")


class SocIntrRingAsyncBridgeMstNode(UhdlComponentNode):
    """Destination-domain half of a bidirectional async cut."""

    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="lwnoc_intr_ring_async_bridge_wrap_mst",
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_mst", "clk_mst")
        self.add_interface("rst_mst_n", "rst_mst_n")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_async_if", r"^pring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")
        self.add_interface("nring_async_if", r"^nring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 6),
    ('nring_in_if', 'nring_out_if', 6),
])
class SocIntrRingAsyncBridgeNode(UhdlWrapperNode):
    """Bidirectional async cut composed from explicit source/destination halves."""

    def __init__(self, id: str, cfg):
        super().__init__(id=id)

        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.slv_side = SocIntrRingAsyncBridgeSlvNode(id=f"{id}_slv", cfg=cfg)
        self.mst_side = SocIntrRingAsyncBridgeMstNode(id=f"{id}_mst", cfg=cfg)

        connect(self.slv_side.clk_slv, self.clk_src)
        connect(self.slv_side.rst_slv_n, self.rst_src_n)
        connect(self.mst_side.clk_mst, self.clk_dst)
        connect(self.mst_side.rst_mst_n, self.rst_dst_n)

        connect(self.slv_side.pring_in_if, self.pring_in_if)
        connect(self.mst_side.pring_out_if, self.pring_out_if)
        connect(self.mst_side.nring_in_if, self.nring_in_if)
        connect(self.slv_side.nring_out_if, self.nring_out_if)

        connect(self.slv_side.pring_async_if, self.mst_side.pring_async_if)
        connect(self.slv_side.nring_async_if, self.mst_side.nring_async_if)

        self.expose_unconnected_interfaces()


class SocIntrRingReqSinkNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="lwnoc_intr_default_tgtid_sink",
        )
        super().__init__(id=id, impl=comp)
        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("local_rx", r"^rx_(valid|ready|payload|srcid|tgtid|qos|last)$")

@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrRingSinkStationNode(UhdlWrapperNode):
    """Ring sink station: TNIU endpoint + default_tgtid_sink, placed between last_node and ring_sp."""
    def __init__(self, id: str, endpoint_cfg, sink_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.endpoint_wrap = SocIntrTniuEndpointNode(
            id=f"{id}_endpoint",
            cfg=endpoint_cfg,
            node_id=node_id,
            node_count=node_count,
        )
        self.ring_sink = SocIntrRingReqSinkNode(id=f"{id}_sink", cfg=sink_cfg)

        connect(self.endpoint_wrap.clk, self.clk)
        connect(self.endpoint_wrap.rst_n, self.rst_n)
        connect(self.ring_sink.clk, self.clk)
        connect(self.ring_sink.rst_n, self.rst_n)
        connect(self.endpoint_wrap.local_rx, self.ring_sink.local_rx)

        connect(self.endpoint_wrap.pring_in_if, self.pring_in_if)
        connect(self.endpoint_wrap.pring_out_if, self.pring_out_if)
        connect(self.endpoint_wrap.nring_in_if, self.nring_in_if)
        connect(self.endpoint_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()


class SocIntrIniuTopWrapNode(UhdlWrapperNode):
    """Top-side wrapper for INIU (memnoc-style, prevents _porting_ IO names)."""
    def __init__(self, id: str, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)
        node_id_width = int(getattr(ring_cfg, 'param_overrides', {}).get("ID_WIDTH", 8))
        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("node_id", is_global=True, emit_io=False)
        self.add_interface("async_fifo")
        self.add_interface("lp_async")
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("afifo_sb_err")
        self.add_interface("afifo_db_err")

        self.node_id_gen_top = NodeIdGenNode(id=f"{id}_node_id_gen", node_id_width=node_id_width)
        self.xbar_routing_lut = SocIntrXbarRoutingLutNode(
            id=f"{id}_xbar_lut",
            node_id_width=node_id_width,
            num_channels=1,
        )
        self.iniu_top = SocIntrIniuTopNode(id=f"{id}_top", cfg=top_cfg)
        self.endpoint_wrap = SocIntrIniuEndpointNode(
            id=f"{id}_endpoint", cfg=ring_cfg,
            node_id=node_id, node_count=node_count,
        )

        connect(self.iniu_top.clk, self.clk)
        connect(self.iniu_top.rst_n, self.rst_n)
        connect(self.endpoint_wrap.clk, self.clk)
        connect(self.endpoint_wrap.rst_n, self.rst_n)
        connect(self.node_id_gen_top.node_id, self.node_id)
        connect(self.xbar_routing_lut.src_id, self.node_id)
        connect(self.endpoint_wrap.xbar_req_tgt_id, self.xbar_routing_lut.xbar_ch0_tgt_id)
        connect(self.xbar_routing_lut.xbar_ch0_sel_bit, self.endpoint_wrap.xbar_req_sel_bit)
        connect(self.iniu_top.async_fifo, self.async_fifo)
        connect(self.iniu_top.lp_async, self.lp_async)
        connect(self.iniu_top.afifo_sb_err, self.afifo_sb_err)
        connect(self.iniu_top.afifo_db_err, self.afifo_db_err)
        connect(self.iniu_top.ring_req, self.endpoint_wrap.local_tx)
        # local_rx intentionally left open — INIU does not consume ring responses
        connect(self.endpoint_wrap.pring_in_if, self.pring_in_if)
        connect(self.endpoint_wrap.pring_out_if, self.pring_out_if)
        connect(self.endpoint_wrap.nring_in_if, self.nring_in_if)
        connect(self.endpoint_wrap.nring_out_if, self.nring_out_if)
        self.expose_unconnected_interfaces()


class SocIntrTniuTopWrapNode(UhdlWrapperNode):
    """Top-side wrapper for TNIU (memnoc-style)."""
    def __init__(self, id: str, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)
        node_id_width = int(getattr(ring_cfg, 'param_overrides', {}).get("ID_WIDTH", 8))
        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("node_id", is_global=True, emit_io=False)
        self.add_interface("async_fifo")
        self.add_interface("lp_async")
        self.add_interface("lp_niu_hub")
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.node_id_gen_top = NodeIdGenNode(id=f"{id}_node_id_gen", node_id_width=node_id_width)
        self.tniu_top = SocIntrTniuTopNode(id=f"{id}_top", cfg=top_cfg)
        self.endpoint_wrap = SocIntrTniuEndpointNode(
            id=f"{id}_endpoint", cfg=ring_cfg,
            node_id=node_id, node_count=node_count,
        )

        connect(self.tniu_top.clk, self.clk)
        connect(self.tniu_top.rst_n, self.rst_n)
        connect(self.endpoint_wrap.clk, self.clk)
        connect(self.endpoint_wrap.rst_n, self.rst_n)
        connect(self.node_id_gen_top.node_id, self.node_id)
        connect(self.tniu_top.async_fifo, self.async_fifo)
        connect(self.tniu_top.lp_async, self.lp_async)
        connect(self.tniu_top.lp_niu_hub, self.lp_niu_hub)
        connect(self.tniu_top.ring_req, self.endpoint_wrap.local_rx)
        connect(self.endpoint_wrap.pring_in_if, self.pring_in_if)
        connect(self.endpoint_wrap.pring_out_if, self.pring_out_if)
        connect(self.endpoint_wrap.nring_in_if, self.nring_in_if)
        connect(self.endpoint_wrap.nring_out_if, self.nring_out_if)
        self.expose_unconnected_interfaces()


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrIniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("pchannel")
        self.add_interface("regbank_parity_err")
        self.add_interface("iniu_lut_sb_err")
        self.add_interface("iniu_lut_db_err")
        self.add_interface("afifo_top_sb_err")
        self.add_interface("afifo_top_db_err")

        self.iniu_sys = SocIntrIniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.iniu_top_wrap = SocIntrIniuTopWrapNode(
            id=f"{id}_top_wrap",
            top_cfg=top_cfg, ring_cfg=ring_cfg,
            node_id=node_id, node_count=node_count,
        )

        connect(self.iniu_sys.clk, self.clk_sys)
        connect(self.iniu_sys.rst_n, self.rst_sys_n)
        connect(self.iniu_sys.pchannel, self.pchannel)
        connect(self.iniu_sys.regbank_parity_err, self.regbank_parity_err)
        connect(self.iniu_sys.iniu_lut_sb_err, self.iniu_lut_sb_err)
        connect(self.iniu_sys.iniu_lut_db_err, self.iniu_lut_db_err)
        connect(self.iniu_sys.iniu_src_id, self.iniu_top_wrap.node_id)
        connect(self.iniu_sys.async_fifo, self.iniu_top_wrap.async_fifo)
        connect(self.iniu_sys.lp_async, self.iniu_top_wrap.lp_async)

        connect(self.iniu_top_wrap.pring_in_if, self.pring_in_if)
        connect(self.iniu_top_wrap.pring_out_if, self.pring_out_if)
        connect(self.iniu_top_wrap.nring_in_if, self.nring_in_if)
        connect(self.iniu_top_wrap.nring_out_if, self.nring_out_if)
        connect(self.iniu_top_wrap.afifo_sb_err, self.afifo_top_sb_err)
        connect(self.iniu_top_wrap.afifo_db_err, self.afifo_top_db_err)

        self.expose_unconnected_interfaces()

    @property
    def top_side(self):
        """Return the NoC-top UhdlWrapperNode (for harden partitioning)."""
        return self.iniu_top_wrap


@register_data_topology([
    ('pring_in_if', 'pring_out_if', 1),
    ('nring_in_if', 'nring_out_if', 1),
])
class SocIntrTniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("pchannel")
        self.add_interface("afifo_sb_err")
        self.add_interface("afifo_db_err")
        self.add_interface("regbank_parity_err")
        self.add_interface("tniu_lut_sb_err")
        self.add_interface("tniu_lut_db_err")

        self.tniu_sys = SocIntrTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.tniu_top_wrap = SocIntrTniuTopWrapNode(
            id=f"{id}_top_wrap",
            top_cfg=top_cfg, ring_cfg=ring_cfg,
            node_id=node_id, node_count=node_count,
        )

        connect(self.tniu_sys.clk, self.clk_sys)
        connect(self.tniu_sys.rst_n, self.rst_sys_n)
        connect(self.tniu_sys.pchannel, self.pchannel)
        connect(self.tniu_sys.afifo_sb_err, self.afifo_sb_err)
        connect(self.tniu_sys.afifo_db_err, self.afifo_db_err)
        connect(self.tniu_sys.regbank_parity_err, self.regbank_parity_err)
        connect(self.tniu_sys.tniu_lut_sb_err, self.tniu_lut_sb_err)
        connect(self.tniu_sys.tniu_lut_db_err, self.tniu_lut_db_err)
        connect(self.tniu_sys.tniu_tgt_id, self.tniu_top_wrap.node_id)
        connect(self.tniu_sys.async_fifo, self.tniu_top_wrap.async_fifo)
        connect(self.tniu_sys.lp_async, self.tniu_top_wrap.lp_async)
        connect(self.tniu_sys.lp_niu_hub, self.tniu_top_wrap.lp_niu_hub)

        connect(self.tniu_top_wrap.pring_in_if, self.pring_in_if)
        connect(self.tniu_top_wrap.pring_out_if, self.pring_out_if)
        connect(self.tniu_top_wrap.nring_in_if, self.nring_in_if)
        connect(self.tniu_top_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()

    @property
    def top_side(self):
        """Return the NoC-top UhdlWrapperNode (for harden partitioning)."""
        return self.tniu_top_wrap


class SocIntrIniuTopLayerNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)
        node_id_width = int(getattr(ring_cfg, 'param_overrides', {}).get("ID_WIDTH", 8))

        self.add_interface(TOP_FUNC_CLK, is_global=True)
        self.add_interface(TOP_FUNC_RST_N, is_global=True)
        self.add_interface("node_id", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("async_fifo")
        self.add_interface("lp_async")

        self.xbar_routing_lut = SocIntrXbarRoutingLutNode(
            id=f"{id.replace('_noc_side', '')}_xbar_lut",
            node_id_width=node_id_width,
            num_channels=1,
        )

        self.iniu_top = SocIntrIniuTopNode(id=f"{id}_top", cfg=top_cfg)
        self.endpoint_wrap = SocIntrIniuEndpointNode(
            id=f"{id}_endpoint",
            cfg=ring_cfg,
            node_id=node_id,
            node_count=node_count,
        )

        connect(self.iniu_top.clk, self.clk_top_func)
        connect(self.iniu_top.rst_n, self.rst_top_func_n)
        connect(self.endpoint_wrap.clk, self.clk_top_func)
        connect(self.endpoint_wrap.rst_n, self.rst_top_func_n)

        connect(self.iniu_top.async_fifo, self.async_fifo)
        connect(self.iniu_top.lp_async, self.lp_async)
        connect(self.iniu_top.ring_req, self.endpoint_wrap.local_tx)
        # local_rx intentionally left open — INIU does not consume ring responses

        connect(self.endpoint_wrap.pring_in_if, self.pring_in_if)
        connect(self.endpoint_wrap.pring_out_if, self.pring_out_if)
        connect(self.endpoint_wrap.nring_in_if, self.nring_in_if)
        connect(self.endpoint_wrap.nring_out_if, self.nring_out_if)
        connect(self.xbar_routing_lut.src_id, self.node_id)
        connect(self.endpoint_wrap.xbar_req_tgt_id, self.xbar_routing_lut.xbar_ch0_tgt_id)
        connect(self.xbar_routing_lut.xbar_ch0_sel_bit, self.endpoint_wrap.xbar_req_sel_bit)
        self.expose_unconnected_interfaces()


class SocIntrTniuTopLayerNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, ring_cfg, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface(TOP_FUNC_CLK, is_global=True)
        self.add_interface(TOP_FUNC_RST_N, is_global=True)
        self.add_interface("node_id", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("async_fifo")
        self.add_interface("timeout_val")
        self.add_interface("lp_hub")
        self.add_interface("lp_niu_hub")
        self.add_interface("lp_async")

        self.tniu_top = SocIntrTniuTopNode(id=f"{id}_top", cfg=top_cfg)
        self.endpoint_wrap = SocIntrTniuEndpointNode(
            id=f"{id}_endpoint",
            cfg=ring_cfg,
            node_id=node_id,
            node_count=node_count,
        )

        connect(self.tniu_top.clk, self.clk_top_func)
        connect(self.tniu_top.rst_n, self.rst_top_func_n)
        connect(self.endpoint_wrap.clk, self.clk_top_func)
        connect(self.endpoint_wrap.rst_n, self.rst_top_func_n)

        connect(self.tniu_top.async_fifo, self.async_fifo)
        connect(self.tniu_top.timeout_val, self.timeout_val)
        connect(self.tniu_top.lp_hub, self.lp_hub)
        connect(self.tniu_top.lp_niu_hub, self.lp_niu_hub)
        connect(self.tniu_top.lp_async, self.lp_async)
        connect(self.tniu_top.ring_req, self.endpoint_wrap.local_rx)

        connect(self.endpoint_wrap.pring_in_if, self.pring_in_if)
        connect(self.endpoint_wrap.pring_out_if, self.pring_out_if)
        connect(self.endpoint_wrap.nring_in_if, self.nring_in_if)
        connect(self.endpoint_wrap.nring_out_if, self.nring_out_if)
        self.expose_unconnected_interfaces()

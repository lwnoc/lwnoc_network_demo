"""Node definitions for the SoC-scale interrupt ring NoC demo."""

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parents[1] / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateComponent
from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from SocIntrTemplate import (
    INIU_ASYNC_FIFO_DEPTH,
    TNIU_ASYNC_FIFO_DEPTH,
    SOC_INTR_RING_NODE_NUM,
    SOC_INTR_REQ_PLD_WIDTH,
    SOC_INTR_REQ_ID_WIDTH,
    SOC_INTR_REQ_QOS_WIDTH,
    INIU_SYS_CONFIGS,
    TNIU_SYS_CONFIGS,
    soc_intr_iniu_top_config,
    soc_intr_tniu_top_config,
    soc_intr_ring_network_config,
    soc_intr_ring_buf_config,
    soc_intr_ring_req_sink_config,
    soc_intr_ring_req_zero_source_config,
)


TOP_LAYER_SUFFIX = "_noc_side"
TOP_FUNC_CLK = "clk_top_func"
TOP_FUNC_RST_N = "rst_top_func_n"


class ParamInstTemplateComponent(TemplateComponent):
    """TemplateComponent variant that preserves per-instance RTL parameters."""

    def __init__(self, config, top: str, instance=None, **kwargs):
        super().__init__(config=config, top=top, instance=instance, **kwargs)

    @property
    def verilog_inst(self):
        from functools import reduce

        def concat(lhs, rhs):
            return lhs + rhs

        param_assignment_list = reduce(concat, [param.verilog_assignment for param in self.param_list], [])
        if param_assignment_list:
            str_list = [f"{self.module_name} #("]
            str_list += self._Component__eol_append(param_assignment_list, ",", ")")
            str_list += [f"{self.name} ("]
        else:
            str_list = [f"{self.module_name} {self.name} ("]

        str_list += self._Component__eol_append(
            reduce(concat, [io.verilog_inst for io in self.io_list], []),
            ",",
            ");",
        )
        return str_list


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
        super().__init__()
        self.lut_data = lut_data
        self.num_nodes = num_nodes
        self.node_id_width = node_id_width
        self.num_channels = num_channels
    
    def circuit(self):
        """Generate the routing LUT circuit."""
        src_id = Input(name="src_id", width=UInt(self.node_id_width))
        channel_ports = []
        for ch in range(self.num_channels):
            tgt_id_ch = Input(name=f"xbar_ch{ch}_tgt_id", width=UInt(self.node_id_width))
            sel_bit_ch = Output(name=f"xbar_ch{ch}_sel_bit", width=UInt(1))
            channel_ports.append((tgt_id_ch, sel_bit_ch))
        
        sorted_lut = sorted(self.lut_data.items())
        
        for ch, (tgt_id_ch, sel_bit_ch) in enumerate(channel_ports):
            when_chain = []
            for (src, tgt), sel_val in sorted_lut:
                combined_key = Combine(UInt(src, self.node_id_width), UInt(tgt, self.node_id_width))
                actual_combined = Combine(src_id, tgt_id_ch)
                when_chain.append(Equal(actual_combined, combined_key))
                when_chain.append(UInt(sel_val, 1))
            
            when_chain.append(UInt(0, 1))
            sel_lut = EmptyWhen(*when_chain)
            sel_bit_ch.assign(sel_lut)
        
        return [src_id] + [ch[0] for ch in channel_ports] + [ch[1] for ch in channel_ports]


class SocIntrXbarRoutingLutNode(UhdlComponentNode):
    """
    Topology node for generating dynamic xbar routing decisions based on shortest paths.
    Wraps SocIntrXbarRoutingLutComponent and supports DataTopology-aware LUT computation.
    """
    
    def __init__(self, id: str, node_id_width: int = 5, num_channels: int = 1):
        default_lut = {(i, j): 0 for i in range(2**node_id_width) for j in range(2**node_id_width)}
        
        comp = SocIntrXbarRoutingLutComponent(
            lut_data=default_lut,
            num_nodes=2**node_id_width,
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
        
        for src_id in range(self.num_nodes):
            for tgt_id in range(self.num_nodes):
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
        """Build UHDL circuit, using DataTopology if available to compute routing LUT."""
        _datatopo = None
        parent_queue = deque([self.parent])
        
        while parent_queue and not _datatopo:
            node = parent_queue.popleft()
            if node and hasattr(node, '_datatopo'):
                _datatopo = node._datatopo
                break
            if node and hasattr(node, 'parent') and node.parent:
                parent_queue.append(node.parent)
        
        if _datatopo:
            lut_data = self._compute_lut_from_shortest_paths(_datatopo)
            _logger.info(f"Computed xbar LUT from DataTopology for {self.id}: {len(lut_data)} entries")
        else:
            lut_data = {(i, j): 0 for i in range(2**self.node_id_width) for j in range(2**self.node_id_width)}
            _logger.warning(f"DataTopology not found for {self.id}, using default all-pring LUT")
        
        self._component.lut_data = lut_data
        self.impl = self._component


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


class SocIntrIniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(
            config=soc_intr_iniu_top_config,
            top="interrupt_iniu_async_top_side",
            ASYNC_FIFO_DEPTH=INIU_ASYNC_FIFO_DEPTH,
            struct_mode="packed",
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_async", r"m_async_master_hub.*")
        self.add_interface("ring_req", r"^req_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrTniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(
            config=cfg,
            top="interrupt_tniu_async_sys_side",
            ASYNC_FIFO_DEPTH=TNIU_ASYNC_FIFO_DEPTH,
            struct_mode="packed",
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


class SocIntrTniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(
            config=soc_intr_tniu_top_config,
            top="interrupt_tniu_async_top_side",
            ASYNC_FIFO_DEPTH=TNIU_ASYNC_FIFO_DEPTH,
            struct_mode="packed",
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


class SocIntrRingBufNode(UhdlComponentNode):
    """Ring node primitive based on intr_ring_buf_wrap (buffer and station integrated)."""

    def __init__(self, id: str, node_id: int, node_count: int, has_iniu: bool, has_tniu: bool):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_buf_config,
            top="intr_ring_buf_wrap",
            RING_ID=node_id,
            NODE_NUM=node_count,
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            HAS_INIU=1 if has_iniu else 0,
            HAS_TNIU=1 if has_tniu else 0,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_tx", r"^local_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("local_rx", r"^local_rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingSpNode(UhdlComponentNode):
    """Simplified ring-visible SP node using a local adapter wrapper."""

    def __init__(self, id: str):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_network_config,
            top="lwnoc_intr_ring_sp_wrap",
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            NODE_NUM=SOC_INTR_RING_NODE_NUM,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("pring_in_if", r"^pring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_out_if", r"^nring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingAsyncBridgeSlvNode(UhdlComponentNode):
    """Source-domain half of a bidirectional async cut."""

    def __init__(self, id: str):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_network_config,
            top="lwnoc_intr_ring_async_bridge_wrap_slv",
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            NODE_NUM=SOC_INTR_RING_NODE_NUM,
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

    def __init__(self, id: str):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_network_config,
            top="lwnoc_intr_ring_async_bridge_wrap_mst",
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            NODE_NUM=SOC_INTR_RING_NODE_NUM,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_mst", "clk_mst")
        self.add_interface("rst_mst_n", "rst_mst_n")
        self.add_interface("pring_out_if", r"^pring_out_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("nring_in_if", r"^nring_in_if_(valid|ready|payload|srcid|tgtid|qos|last)$")
        self.add_interface("pring_async_if", r"^pring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")
        self.add_interface("nring_async_if", r"^nring_(wptr_async|rptr_async|rptr_sync|pld_sync|vc_buf_rdy)$")


class SocIntrRingAsyncBridgeNode(UhdlWrapperNode):
    """Bidirectional async cut composed from explicit source/destination halves."""

    def __init__(self, id: str):
        super().__init__(id=id)

        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.slv_side = SocIntrRingAsyncBridgeSlvNode(id=f"{id}_slv")
        self.mst_side = SocIntrRingAsyncBridgeMstNode(id=f"{id}_mst")

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
    def __init__(self, id: str):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_req_sink_config,
            top="lwnoc_intr_default_tgtid_sink",
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            NODE_NUM=SOC_INTR_RING_NODE_NUM,
        )
        super().__init__(id=id, impl=comp)
        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("local_rx", r"^rx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingReqZeroSourceNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = ParamInstTemplateComponent(
            config=soc_intr_ring_req_zero_source_config,
            top="lwnoc_intr_dummy_endpoint",
            PLD_WIDTH=SOC_INTR_REQ_PLD_WIDTH,
            ID_WIDTH=SOC_INTR_REQ_ID_WIDTH,
            QOS_WIDTH=SOC_INTR_REQ_QOS_WIDTH,
            NODE_NUM=SOC_INTR_RING_NODE_NUM,
        )
        super().__init__(id=id, impl=comp)
        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("local_tx", r"^merge_tx_(valid|ready|payload|srcid|tgtid|qos|last)$")


class SocIntrRingSinkStationNode(UhdlWrapperNode):
    def __init__(self, id: str, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface("clk", is_global=True)
        self.add_interface("rst_n", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")

        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=False,
            has_tniu=True,
        )
        self.ring_sink = SocIntrRingReqSinkNode(id=f"{id}_sink")

        connect(self.ring_wrap.clk, self.clk)
        connect(self.ring_wrap.rst_n, self.rst_n)
        connect(self.ring_sink.clk, self.clk)
        connect(self.ring_sink.rst_n, self.rst_n)
        connect(self.ring_wrap.local_rx, self.ring_sink.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()


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

        self.ring_buf = SocIntrRingBufNode(
            id=f"{id}_ring_buf",
            node_id=node_id,
            node_count=node_count,
            has_iniu=has_iniu,
            has_tniu=has_tniu,
        )

        connect(self.ring_buf.clk, self.clk)
        connect(self.ring_buf.rst_n, self.rst_n)
        connect(self.ring_buf.pring_in_if, self.pring_in_if)
        connect(self.ring_buf.pring_out_if, self.pring_out_if)
        connect(self.ring_buf.nring_in_if, self.nring_in_if)
        connect(self.ring_buf.nring_out_if, self.nring_out_if)
        connect(self.ring_buf.local_tx, self.local_tx)
        connect(self.ring_buf.local_rx, self.local_rx)

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
        self.add_interface("pchannel")

        self.iniu_sys = SocIntrIniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.iniu_top = SocIntrIniuTopNode(id=f"{id}_top")
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=True,
            has_tniu=False,
        )
        self.ring_sink = SocIntrRingReqSinkNode(id=f"{id}_sink")

        connect(self.iniu_sys.clk, self.clk_sys)
        connect(self.iniu_sys.rst_n, self.rst_sys_n)
        connect(self.iniu_top.clk, self.clk_noc)
        connect(self.iniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)
        connect(self.ring_sink.clk, self.clk_noc)
        connect(self.ring_sink.rst_n, self.rst_noc_n)

        connect(self.iniu_sys.async_fifo, self.iniu_top.async_fifo)
        connect(self.iniu_sys.lp_async, self.iniu_top.lp_async)
        connect(self.iniu_sys.pchannel, self.pchannel)
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
        self.add_interface("pchannel")

        self.tniu_sys = SocIntrTniuSysNode(id=f"{id}_sys", cfg=sys_cfg)
        self.tniu_top = SocIntrTniuTopNode(id=f"{id}_top")
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=True,
            has_tniu=True,
        )
        self.ring_zero = SocIntrRingReqZeroSourceNode(id=f"{id}_zero")

        connect(self.tniu_sys.clk, self.clk_sys)
        connect(self.tniu_sys.rst_n, self.rst_sys_n)
        connect(self.tniu_top.clk, self.clk_noc)
        connect(self.tniu_top.rst_n, self.rst_noc_n)
        connect(self.ring_wrap.clk, self.clk_noc)
        connect(self.ring_wrap.rst_n, self.rst_noc_n)
        connect(self.ring_zero.clk, self.clk_noc)
        connect(self.ring_zero.rst_n, self.rst_noc_n)

        connect(self.tniu_sys.async_fifo, self.tniu_top.async_fifo)
        connect(self.tniu_sys.lp_async, self.tniu_top.lp_async)
        connect(self.tniu_sys.lp_niu_hub, self.tniu_top.lp_niu_hub)
        connect(self.tniu_sys.pchannel, self.pchannel)
        connect(self.ring_zero.local_tx, self.ring_wrap.local_tx)
        connect(self.tniu_top.ring_req, self.ring_wrap.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)

        self.expose_unconnected_interfaces()


class SocIntrIniuTopLayerNode(UhdlWrapperNode):
    def __init__(self, id: str, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface(TOP_FUNC_CLK, is_global=True)
        self.add_interface(TOP_FUNC_RST_N, is_global=True)
        # NEW: expose node_id globally for xbar_routing_lut
        self.add_interface("node_id", is_global=True)
        self.add_interface("pring_in_if")
        self.add_interface("pring_out_if")
        self.add_interface("nring_in_if")
        self.add_interface("nring_out_if")
        self.add_interface("async_fifo")
        self.add_interface("lp_async")

        # NEW: Create XbarRoutingLutNode
        self.xbar_routing_lut = SocIntrXbarRoutingLutNode(
            id=f"{id.replace('_noc_side', '')}_xbar_lut",
            node_id_width=5,
            num_channels=1  # INIU: 1 channel (interrupt requests)
        )

        self.iniu_top = SocIntrIniuTopNode(id=f"{id}_top")
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=True,
            has_tniu=False,
        )
        self.ring_sink = SocIntrRingReqSinkNode(id=f"{id}_sink")

        connect(self.iniu_top.clk, self.clk_top_func)
        connect(self.iniu_top.rst_n, self.rst_top_func_n)
        connect(self.ring_wrap.clk, self.clk_top_func)
        connect(self.ring_wrap.rst_n, self.rst_top_func_n)
        connect(self.ring_sink.clk, self.clk_top_func)
        connect(self.ring_sink.rst_n, self.rst_top_func_n)

        connect(self.iniu_top.async_fifo, self.async_fifo)
        connect(self.iniu_top.lp_async, self.lp_async)
        connect(self.iniu_top.ring_req, self.ring_wrap.local_tx)
        connect(self.ring_wrap.local_rx, self.ring_sink.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)


        # NEW: Wire xbar_routing_lut.src_id to node_id
        connect(self.xbar_routing_lut.src_id, self.node_id)
        self.expose_unconnected_interfaces()


class SocIntrTniuTopLayerNode(UhdlWrapperNode):
    def __init__(self, id: str, node_id: int, node_count: int):
        super().__init__(id=id)

        self.add_interface(TOP_FUNC_CLK, is_global=True)
        self.add_interface(TOP_FUNC_RST_N, is_global=True)
        # NEW: expose node_id globally for xbar_routing_lut
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

        # NEW: Create XbarRoutingLutNode
        self.xbar_routing_lut = SocIntrXbarRoutingLutNode(
            id=f"{id.replace('_noc_side', '')}_xbar_lut",
            node_id_width=5,
            num_channels=1  # TNIU: 1 channel (interrupt responses)
        )

        self.tniu_top = SocIntrTniuTopNode(id=f"{id}_top")
        self.ring_wrap = SocIntrRingNodeWrap(
            id=f"{id}_ring",
            node_id=node_id,
            node_count=node_count,
            has_iniu=True,
            has_tniu=True,
        )
        self.ring_zero = SocIntrRingReqZeroSourceNode(id=f"{id}_zero")

        connect(self.tniu_top.clk, self.clk_top_func)
        connect(self.tniu_top.rst_n, self.rst_top_func_n)
        connect(self.ring_wrap.clk, self.clk_top_func)
        connect(self.ring_wrap.rst_n, self.rst_top_func_n)
        connect(self.ring_zero.clk, self.clk_top_func)
        connect(self.ring_zero.rst_n, self.rst_top_func_n)

        connect(self.tniu_top.async_fifo, self.async_fifo)
        connect(self.tniu_top.timeout_val, self.timeout_val)
        connect(self.tniu_top.lp_hub, self.lp_hub)
        connect(self.tniu_top.lp_niu_hub, self.lp_niu_hub)
        connect(self.tniu_top.lp_async, self.lp_async)
        connect(self.ring_zero.local_tx, self.ring_wrap.local_tx)
        connect(self.tniu_top.ring_req, self.ring_wrap.local_rx)

        connect(self.ring_wrap.pring_in_if, self.pring_in_if)
        connect(self.ring_wrap.pring_out_if, self.pring_out_if)
        connect(self.ring_wrap.nring_in_if, self.nring_in_if)
        connect(self.ring_wrap.nring_out_if, self.nring_out_if)


        # NEW: Wire xbar_routing_lut.src_id to node_id
        connect(self.xbar_routing_lut.src_id, self.node_id)
        self.expose_unconnected_interfaces()


def make_iniu_node(node_name: str, node_id: int, node_count: int):
    cfg = INIU_SYS_CONFIGS[node_name]
    return SocIntrIniuNode(
        id=node_name,
        sys_cfg=cfg,
        node_id=node_id,
        node_count=node_count,
    )


def make_tniu_node(node_name: str, node_id: int, node_count: int):
    cfg = TNIU_SYS_CONFIGS[node_name]
    return SocIntrTniuNode(
        id=node_name,
        sys_cfg=cfg,
        node_id=node_id,
        node_count=node_count,
    )


def make_iniu_top_layer_node(node_name: str, node_id: int, node_count: int):
    return SocIntrIniuTopLayerNode(
        id=_top_layer_id(node_name),
        node_id=node_id,
        node_count=node_count,
    )


def make_tniu_top_layer_node(node_name: str, node_id: int, node_count: int):
    return SocIntrTniuTopLayerNode(
        id=_top_layer_id(node_name),
        node_id=node_id,
        node_count=node_count,
    )


def make_ring_sp_node(node_name: str):
    return SocIntrRingSpNode(id=node_name)


def make_ring_async_node(node_name: str):
    return SocIntrRingAsyncBridgeNode(id=node_name)


def make_ring_sink_node(node_name: str, node_id: int, node_count: int):
    return SocIntrRingSinkStationNode(
        id=node_name,
        node_id=node_id,
        node_count=node_count,
    )


def make_req_zero_source_node(node_name: str):
    return SocIntrRingReqZeroSourceNode(id=node_name)

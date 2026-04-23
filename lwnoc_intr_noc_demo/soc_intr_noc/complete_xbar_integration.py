#!/usr/bin/env python3
"""
Complete XbarRoutingLutNode integration script.
Adds classes and modifies TopLayer nodes in one operation.
"""

import sys
from pathlib import Path

def main():
    node_file = Path("SocIntrNode.py")
    
    # Read current file
    with open(node_file, 'r') as f:
        lines = f.readlines()
    
    # Find insertion point (after imports and before first class)
    import_end = 0
    for i, line in enumerate(lines):
        if line.startswith("TOP_LAYER_SUFFIX"):
            import_end = i
            break
    
    # Prepare new classes code
    xbar_classes = '''
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
        super().__init__(name="xbar_routing_lut")
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

'''
    
    # Insert the classes after the TOP_LAYER_SUFFIX definition
    insert_pos = import_end + 1
    for i in range(import_end, len(lines)):
        if lines[i].strip().startswith("class ") and "SocIntrIniuSysNode" in lines[i]:
            insert_pos = i
            break
    
    # Add classes
    lines.insert(insert_pos, xbar_classes + "\n")
    
    # Now modify TopLayer nodes to add xbar_routing_lut
    modified = False
    
    # Find and modify SocIntrIniuTopLayerNode
    for i, line in enumerate(lines):
        if "class SocIntrIniuTopLayerNode(UhdlWrapperNode):" in line:
            # Find the line with TOP_FUNC_RST_N
            for j in range(i, min(i+50, len(lines))):
                if 'self.add_interface(TOP_FUNC_RST_N, is_global=True)' in lines[j]:
                    # Insert node_id interface after this line
                    indent = "        "
                    new_lines = [
                        f"{indent}# NEW: expose node_id globally for xbar_routing_lut\n",
                        f"{indent}self.add_interface(\"node_id\", is_global=True)\n",
                    ]
                    lines[j+1:j+1] = new_lines
                    modified = True
                    
                    # Find where to add xbar_routing_lut initialization
                    for k in range(j, min(j+50, len(lines))):
                        if 'self.add_interface("lp_async")' in lines[k]:
                            # Insert xbar initialization after this
                            xbar_init_lines = [
                                f"\n",
                                f"{indent}# NEW: Create XbarRoutingLutNode\n",
                                f"{indent}self.xbar_routing_lut = SocIntrXbarRoutingLutNode(\n",
                                f"{indent}    id=f\"{{id.replace('_noc_side', '')}}_xbar_lut\",\n",
                                f"{indent}    node_id_width=5,\n",
                                f"{indent}    num_channels=1  # INIU: 1 channel (interrupt requests)\n",
                                f"{indent})\n",
                            ]
                            lines[k+1:k+1] = xbar_init_lines
                            
                            # Find where to add xbar connection
                            for m in range(k, min(k+50, len(lines))):
                                if 'self.ring_wrap.nring_out_if, self.nring_out_if' in lines[m]:
                                    # Find the next blank line or expose_unconnected_interfaces
                                    for n in range(m, min(m+10, len(lines))):
                                        if 'self.expose_unconnected_interfaces()' in lines[n]:
                                            xbar_conn_lines = [
                                                f"\n",
                                                f"{indent}# NEW: Wire xbar_routing_lut.src_id to node_id\n",
                                                f"{indent}connect(self.xbar_routing_lut.src_id, self.node_id)\n",
                                            ]
                                            lines[n:n] = xbar_conn_lines
                                            break
                                    break
                            break
                    break
            break
    
    # Find and modify SocIntrTniuTopLayerNode (similar)
    for i, line in enumerate(lines):
        if "class SocIntrTniuTopLayerNode(UhdlWrapperNode):" in line:
            for j in range(i, min(i+50, len(lines))):
                if 'self.add_interface(TOP_FUNC_RST_N, is_global=True)' in lines[j]:
                    indent = "        "
                    new_lines = [
                        f"{indent}# NEW: expose node_id globally for xbar_routing_lut\n",
                        f"{indent}self.add_interface(\"node_id\", is_global=True)\n",
                    ]
                    lines[j+1:j+1] = new_lines
                    modified = True
                    
                    for k in range(j, min(j+50, len(lines))):
                        if 'self.add_interface("lp_async")' in lines[k]:
                            xbar_init_lines = [
                                f"\n",
                                f"{indent}# NEW: Create XbarRoutingLutNode\n",
                                f"{indent}self.xbar_routing_lut = SocIntrXbarRoutingLutNode(\n",
                                f"{indent}    id=f\"{{id.replace('_noc_side', '')}}_xbar_lut\",\n",
                                f"{indent}    node_id_width=5,\n",
                                f"{indent}    num_channels=1  # TNIU: 1 channel (interrupt responses)\n",
                                f"{indent})\n",
                            ]
                            lines[k+1:k+1] = xbar_init_lines
                            
                            for m in range(k, min(k+50, len(lines))):
                                if 'self.ring_wrap.nring_out_if, self.nring_out_if' in lines[m]:
                                    for n in range(m, min(m+10, len(lines))):
                                        if 'self.expose_unconnected_interfaces()' in lines[n]:
                                            xbar_conn_lines = [
                                                f"\n",
                                                f"{indent}# NEW: Wire xbar_routing_lut.src_id to node_id\n",
                                                f"{indent}connect(self.xbar_routing_lut.src_id, self.node_id)\n",
                                            ]
                                            lines[n:n] = xbar_conn_lines
                                            break
                                    break
                            break
                    break
            break
    
    # Write back
    with open(node_file, 'w') as f:
        f.writelines(lines)
    
    if modified:
        print("✓ Successfully added XbarRoutingLutNode classes and integrated into TopLayer nodes")
        return 0
    else:
        print("✗ Failed to modify TopLayer nodes")
        return 1

if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""Standalone PNG generator for topology JSON (no UHDL build required)."""

import json
import sys
from pathlib import Path

try:
    import matplotlib.pyplot as plt
    import networkx as nx
except ImportError as e:
    print(f"ERROR: Required package missing: {e}")
    sys.exit(1)


def load_topology_json(json_path: Path) -> dict:
    """Load topology JSON file."""
    with open(json_path) as f:
        return json.load(f)


def extract_nodes_recursive(node: dict, parent_id: str = None, nodes: dict = None, edges: list = None) -> None:
    """Recursively extract nodes and parent-child relationships from tree structure."""
    if nodes is None:
        nodes = {}
    if edges is None:
        edges = []
    
    node_id = node.get("id")
    if not node_id:
        return
    
    node_type = node.get("type", "unknown")
    nodes[node_id] = {"label": node_id, "type": node_type}
    
    # Add edge from parent to this node if parent exists
    if parent_id and node_type == "atomic":  # Only show atomic components
        edges.append((parent_id, node_id))
    
    # Recursively process children
    children = node.get("children", [])
    for child in children:
        extract_nodes_recursive(child, node_id, nodes, edges)
    
    return nodes, edges


def build_node_graph(topo_dict: dict) -> nx.DiGraph:
    """Build networkx graph from topology JSON."""
    graph = nx.DiGraph()
    
    # Extract topology from root
    root_topo = topo_dict.get("topology", {})
    if not root_topo:
        return graph
    
    nodes, edges = extract_nodes_recursive(root_topo)
    
    # Filter to only atomic nodes for cleaner visualization
    atomic_nodes = {nid: ndata for nid, ndata in nodes.items() if ndata.get("type") == "atomic"}
    
    # Add nodes to graph
    for node_id, node_data in atomic_nodes.items():
        graph.add_node(node_id, label=node_data["label"])
    
    # Add edges between atomic nodes (collapse wrapper hierarchy)
    added_edges = set()
    for parent_id, child_id in edges:
        if child_id in atomic_nodes:
            # Find top-level atomic node that this child belongs to
            for edge_src, edge_dst in edges:
                if edge_dst == parent_id and edge_src in atomic_nodes:
                    edge_key = (edge_src, child_id)
                    if edge_key not in added_edges:
                        graph.add_edge(edge_src, child_id)
                        added_edges.add(edge_key)
    
    return graph


def generate_png(json_path: Path, output_path: Path) -> None:
    """Generate PNG from topology JSON."""
    print(f"Loading topology from {json_path}...")
    topo_dict = load_topology_json(json_path)
    
    print("Building network graph...")
    graph = build_node_graph(topo_dict)
    
    if graph.number_of_nodes() == 0:
        print("WARNING: graph is empty, skip image output")
        return
    
    print(f"Graph: {graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges")
    
    print("Rendering layout...")
    if nx.is_directed_acyclic_graph(graph):
        pos = nx.spring_layout(graph, k=2.5, iterations=120, seed=42)
    else:
        pos = nx.kamada_kawai_layout(graph)
    
    print("Drawing graph...")
    figure = plt.figure(figsize=(24, 16))
    nx.draw_networkx_nodes(graph, pos, node_color="#87CEEB", node_size=1500, alpha=0.9)
    
    # Get labels from node data
    labels = {node: data.get("label", node) for node, data in graph.nodes(data=True)}
    nx.draw_networkx_labels(graph, pos, labels, font_size=7, font_weight="bold")
    
    nx.draw_networkx_edges(graph, pos, arrows=True, arrowsize=10, width=1.0, alpha=0.7)
    
    plt.title(f"SoC Intr Topology ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges)")
    plt.axis("off")
    plt.tight_layout()
    
    print(f"Saving PNG to {output_path}...")
    output_path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output_path, dpi=150, bbox_inches="tight")
    plt.close(figure)
    
    print(f"✓ Topology PNG written to {output_path}")
    print(f"  File size: {output_path.stat().st_size / (1024*1024):.1f} MB")


if __name__ == "__main__":
    this_dir = Path(__file__).parent
    json_file = this_dir / "soc_intr_logic_topology.json"
    png_file = this_dir / "soc_intr_ring_topology.png"
    
    if not json_file.exists():
        print(f"ERROR: Topology JSON not found: {json_file}")
        sys.exit(1)
    
    generate_png(json_file, png_file)

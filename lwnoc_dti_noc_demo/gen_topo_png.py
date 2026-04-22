#!/usr/bin/env python3
"""Generate topology PNG from topology JSON for DTI demo."""

import json
import sys
from pathlib import Path

try:
    import matplotlib.pyplot as plt
    import networkx as nx
except ImportError as exc:
    print(f"ERROR: Required package missing: {exc}")
    sys.exit(1)


def _load_topology_json(json_path: Path) -> dict:
    return json.loads(json_path.read_text())


def _extract_nodes_recursive(node: dict, parent_id: str | None = None, nodes: dict | None = None, edges: list | None = None):
    if nodes is None:
        nodes = {}
    if edges is None:
        edges = []

    node_id = node.get("id")
    if not node_id:
        return nodes, edges

    node_type = node.get("type", "unknown")
    nodes[node_id] = {"label": node_id, "type": node_type}

    if parent_id and node_type == "atomic":
        edges.append((parent_id, node_id))

    for child in node.get("children", []):
        _extract_nodes_recursive(child, node_id, nodes, edges)

    return nodes, edges


def _build_graph(topo_dict: dict) -> nx.DiGraph:
    graph = nx.DiGraph()
    root_topo = topo_dict.get("topology", {})
    if not root_topo:
        return graph

    nodes, edges = _extract_nodes_recursive(root_topo)
    atomic_nodes = {node_id: data for node_id, data in nodes.items() if data.get("type") == "atomic"}

    for node_id, data in atomic_nodes.items():
        graph.add_node(node_id, label=data.get("label", node_id))

    added = set()
    for parent_id, child_id in edges:
        if child_id not in atomic_nodes:
            continue
        for edge_src, edge_dst in edges:
            if edge_dst == parent_id and edge_src in atomic_nodes:
                key = (edge_src, child_id)
                if key in added:
                    continue
                graph.add_edge(edge_src, child_id)
                added.add(key)

    return graph


def generate_png(json_path: Path, png_path: Path, title: str = "DTI Topology") -> None:
    topo_dict = _load_topology_json(json_path)
    graph = _build_graph(topo_dict)

    if graph.number_of_nodes() == 0:
        print(f"WARNING: Empty graph for {json_path}, skip png output")
        return

    if nx.is_directed_acyclic_graph(graph):
        pos = nx.spring_layout(graph, k=2.5, iterations=120, seed=42)
    else:
        pos = nx.kamada_kawai_layout(graph)

    figure = plt.figure(figsize=(22, 14))
    nx.draw_networkx_nodes(graph, pos, node_color="#9ad1f5", node_size=1450, alpha=0.9)
    labels = {node: data.get("label", node) for node, data in graph.nodes(data=True)}
    nx.draw_networkx_labels(graph, pos, labels, font_size=7, font_weight="bold")
    nx.draw_networkx_edges(graph, pos, arrows=True, arrowsize=10, width=1.0, alpha=0.7)

    plt.title(f"{title} ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges)")
    plt.axis("off")
    plt.tight_layout()

    png_path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(png_path, dpi=150, bbox_inches="tight")
    plt.close(figure)


def main() -> None:
    this_dir = Path(__file__).resolve().parent
    json_path = this_dir / "dti_logic_topology.json"
    png_path = this_dir / "dti_logic_topology.png"

    if not json_path.exists():
        print(f"ERROR: Topology JSON not found: {json_path}")
        sys.exit(1)

    generate_png(json_path, png_path, title="DTI Logic Topology")
    print(f"Topology PNG written to {png_path}")


if __name__ == "__main__":
    main()

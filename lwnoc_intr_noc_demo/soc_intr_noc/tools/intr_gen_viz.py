"""Topology visualization utilities for SoC interrupt NoC generation."""

import os
from pathlib import Path


def extract_nodes_recursive(
    node: dict, parent_id: str = None, nodes: dict = None, edges: list = None
) -> tuple:
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
        extract_nodes_recursive(child, node_id, nodes, edges)
    return nodes, edges


def build_graph_from_topology_json(json_path: Path):
    try:
        import networkx as nx
        import json
    except ImportError:
        return None
    try:
        with open(json_path) as f:
            topo_dict = json.load(f)
    except Exception:
        return None
    graph = nx.DiGraph()
    root_topo = topo_dict.get("topology", {})
    if not root_topo:
        return graph
    nodes, edges = extract_nodes_recursive(root_topo)
    for node_id, node_data in nodes.items():
        graph.add_node(node_id, label=node_data["label"], node_type=node_data.get("type", "unknown"))
    for parent_id, child_id in edges:
        if parent_id in nodes and child_id in nodes:
            graph.add_edge(parent_id, child_id)
    return graph


def build_soc_intr_ring_graph(ring_plan: list):
    import networkx as nx
    graph = nx.MultiDiGraph()
    ordered_names = []
    for ring_slot, entry in enumerate(ring_plan):
        node_name = entry[1]
        graph.add_node(
            node_name,
            label=node_name,
            kind=entry[2],
            ring_slot=ring_slot,
            node_id=entry[0],
        )
        ordered_names.append(node_name)
    for idx, node_name in enumerate(ordered_names):
        next_name = ordered_names[(idx + 1) % len(ordered_names)]
        graph.add_edge(node_name, next_name, key=f"pring_{idx}", ring="pring")
        graph.add_edge(next_name, node_name, key=f"nring_{idx}", ring="nring")
    return graph


def build_soc_intr_ring_layout(graph):
    import math
    ordered_nodes = sorted(graph.nodes, key=lambda n: graph.nodes[n].get("ring_slot", 0))
    if not ordered_nodes:
        return {}
    radius = max(6.0, len(ordered_nodes) / 6.0)
    pos = {}
    for idx, node_name in enumerate(ordered_nodes):
        angle = 2 * math.pi * idx / len(ordered_nodes) - math.pi / 2
        pos[node_name] = (radius * math.cos(angle), radius * math.sin(angle))
    return pos


def render_soc_intr_ring_graph(graph, output_path: Path):
    import matplotlib.patches as mpatches
    import matplotlib.pyplot as plt
    import networkx as nx

    pos = build_soc_intr_ring_layout(graph)
    figure = plt.figure(figsize=(22, 22))

    node_colors = []
    for node_name in graph.nodes:
        kind = graph.nodes[node_name].get("kind")
        if kind == "tniu":
            node_colors.append("#b7e4c7")
        else:
            node_colors.append("#8ecae6")

    labels = {n: graph.nodes[n].get("label", n) for n in graph.nodes}
    nx.draw_networkx_nodes(graph, pos, node_color=node_colors, node_size=1800, alpha=0.95,
                           linewidths=1.0, edgecolors="#404040")
    nx.draw_networkx_labels(graph, pos, labels=labels, font_size=6, font_weight="bold")

    pring_edges = [(u, v) for u, v, _, d in graph.edges(keys=True, data=True) if d.get("ring") == "pring"]
    nring_edges = [(u, v) for u, v, _, d in graph.edges(keys=True, data=True) if d.get("ring") == "nring"]

    nx.draw_networkx_edges(graph, pos, edgelist=pring_edges, arrows=True, arrowsize=16,
                           width=1.6, alpha=0.8, edge_color="#4169E1",
                           connectionstyle="arc3,rad=0.14", min_source_margin=20, min_target_margin=20)
    nx.draw_networkx_edges(graph, pos, edgelist=nring_edges, arrows=True, arrowsize=16,
                           width=1.6, alpha=0.8, edge_color="#FF8C00",
                           connectionstyle="arc3,rad=-0.14", min_source_margin=20, min_target_margin=20)

    plt.legend(handles=[
        mpatches.Patch(color="#4169E1", label="pring"),
        mpatches.Patch(color="#FF8C00", label="nring"),
        mpatches.Patch(color="#8ecae6", label="iniu"),
        mpatches.Patch(color="#b7e4c7", label="tniu"),
    ], loc="upper right", fontsize=10)
    plt.title(f"SoC Intr Ring Graph ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges)")
    plt.axis("off")
    plt.tight_layout()
    output_path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output_path, dpi=150, bbox_inches="tight")
    plt.close(figure)
    print(f"  [topo_viz] ring graph written to {output_path}")


def emit_topology_visualization(topo, output_path: Path, topology_json: Path = None, ring_plan: list = None) -> None:
    if os.environ.get("SKIP_TOPO_VIZ") == "1":
        print("  [topo_viz] skipped by SKIP_TOPO_VIZ=1")
        return
    try:
        import matplotlib.pyplot as plt  # noqa: F401
        import networkx as nx  # noqa: F401
    except Exception as exc:
        print(f"  [topo_viz] WARNING: skip visualization (missing deps): {exc}")
        return

    try:
        graph = None
        if ring_plan and type(topo).__name__ == "SocIntrLogicTopo":
            graph = build_soc_intr_ring_graph(ring_plan)
        else:
            try:
                graph = topo.datatopo.to_networkx(node_level=True)
            except Exception:
                if topology_json and topology_json.exists():
                    graph = build_graph_from_topology_json(topology_json)

        if graph is None or graph.number_of_nodes() == 0:
            print("  [topo_viz] WARNING: graph is empty, skip image output")
            return

        if ring_plan and type(topo).__name__ == "SocIntrLogicTopo":
            render_soc_intr_ring_graph(graph, output_path)
            return

        figure = plt.figure(figsize=(24, 16))
        if nx.is_directed_acyclic_graph(graph):
            pos = nx.spring_layout(graph, k=2.5, iterations=120, seed=42)
        else:
            pos = nx.kamada_kawai_layout(graph)
        nx.draw_networkx_nodes(graph, pos, node_color="#87CEEB", node_size=1500, alpha=0.9)
        nx.draw_networkx_labels(graph, pos, font_size=7, font_weight="bold")
        nx.draw_networkx_edges(graph, pos, arrows=True, arrowsize=10, width=1.0, alpha=0.7)
        plt.title(f"SoC Intr Topology ({graph.number_of_nodes()} nodes, {graph.number_of_edges()} edges)")
        plt.axis("off")
        plt.tight_layout()
        output_path.parent.mkdir(parents=True, exist_ok=True)
        figure.savefig(output_path, dpi=150, bbox_inches="tight")
        plt.close(figure)
        print(f"  [topo_viz] graph written to {output_path}")
    except Exception as exc:
        print(f"  [topo_viz] WARNING: failed to render: {exc}")

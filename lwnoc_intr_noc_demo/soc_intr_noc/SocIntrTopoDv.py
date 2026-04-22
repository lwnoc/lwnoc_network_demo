"""DV topology for the SoC-scale interrupt ring NoC demo."""

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parents[1]
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from SocIntrNode import make_iniu_node, make_ring_async_node, make_ring_sink_node, make_ring_sp_node, make_tniu_node
from SocIntrTopoConfig import INIU_COUNT, RING_PLAN, TNIU_COUNT, TOPO_ID


class SocIntrLogicTopo(UhdlWrapperNode):
    """Perimeter-ordered SoC interrupt ring demo for DV generation."""

    def __init__(self):
        super().__init__(id=TOPO_ID)

        self.add_interface("clk_noc_up", is_global=True)
        self.add_interface("rst_noc_up_n", is_global=True)
        self.add_interface("clk_noc_dn", is_global=True)
        self.add_interface("rst_noc_dn_n", is_global=True)

        total = INIU_COUNT + TNIU_COUNT
        count = len(RING_PLAN)
        self.ring_nodes = []
        self.node_map = {}

        for entry in RING_PLAN:
            node_type = entry["kind"]
            node_name = entry["name"]

            if node_type == "iniu":
                node = make_iniu_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "tniu":
                node = make_tniu_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sink":
                node = make_ring_sink_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sp":
                node = make_ring_sp_node(node_name=node_name)
            elif node_type == "async":
                node = make_ring_async_node(node_name=node_name)
            else:
                raise ValueError(f"Unsupported ring node kind: {node_type}")

            setattr(self, node_name, node)
            self.node_map[node_name] = node
            self.ring_nodes.append(node)

            if node_type == "async":
                if entry["src_domain"] == "a":
                    connect(node.clk_src, self.clk_noc_up)
                    connect(node.rst_src_n, self.rst_noc_up_n)
                else:
                    connect(node.clk_src, self.clk_noc_dn)
                    connect(node.rst_src_n, self.rst_noc_dn_n)

                if entry["dst_domain"] == "a":
                    connect(node.clk_dst, self.clk_noc_up)
                    connect(node.rst_dst_n, self.rst_noc_up_n)
                else:
                    connect(node.clk_dst, self.clk_noc_dn)
                    connect(node.rst_dst_n, self.rst_noc_dn_n)
                continue

            domain_tag = entry["domain"]
            if domain_tag == "a":
                clk = self.clk_noc_up
                rst_n = self.rst_noc_up_n
            else:
                clk = self.clk_noc_dn
                rst_n = self.rst_noc_dn_n

            if node_type in ("iniu", "tniu"):
                connect(node.clk_noc, clk)
                connect(node.rst_noc_n, rst_n)
            elif node_type == "sink":
                connect(node.clk, clk)
                connect(node.rst_n, rst_n)
            elif node_type == "sp":
                connect(node.clk, clk)

        for index in range(count):
            nxt = (index + 1) % count
            connect(self.ring_nodes[index].pring_out_if, self.ring_nodes[nxt].pring_in_if)
            connect(self.ring_nodes[nxt].nring_out_if, self.ring_nodes[index].nring_in_if)

        self.expose_unconnected_interfaces()
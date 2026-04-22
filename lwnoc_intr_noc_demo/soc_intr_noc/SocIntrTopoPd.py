"""PD topology for the SoC-scale interrupt ring NoC demo."""

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parents[1]
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from SocIntrNode import make_iniu_top_layer_node, make_ring_async_node, make_ring_sink_node, make_ring_sp_node, make_tniu_top_layer_node
from SocIntrTopoConfig import (
    ASYNC_CUT_PLAN,
    DN_HARDEN_ID,
    DN_RING_PLAN,
    HARDEN_TOP_ID,
    INIU_COUNT,
    TNIU_COUNT,
    UP_HARDEN_ID,
    UP_RING_PLAN,
)


_UP_COUNT = len(UP_RING_PLAN)
_DN_COUNT = len(DN_RING_PLAN)

PD_TOPO_ID = HARDEN_TOP_ID


class SocIntrUpHardenWrap(UhdlWrapperNode):
    def __init__(self):
        super().__init__(id=UP_HARDEN_ID)

        self.add_interface("clk_up_func", is_global=True)
        self.add_interface("rst_up_func_n", is_global=True)
        self.add_interface("pring_out_to_dn")
        self.add_interface("pring_in_from_dn")
        self.add_interface("nring_out_to_dn")
        self.add_interface("nring_in_from_dn")

        total = INIU_COUNT + TNIU_COUNT
        self.ring_nodes = []
        self.node_map = {}
        for entry in UP_RING_PLAN:
            node_type = entry["kind"]
            node_name = entry["name"]

            if node_type == "iniu":
                node = make_iniu_top_layer_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "tniu":
                node = make_tniu_top_layer_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sink":
                node = make_ring_sink_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sp":
                node = make_ring_sp_node(node_name=node_name)
            else:
                raise ValueError(f"Unsupported up-harden ring node kind: {node_type}")

            setattr(self, node_name, node)
            self.node_map[node_name] = node
            self.ring_nodes.append(node)

            if node_type in ("iniu", "tniu"):
                connect(node.clk_top_func, self.clk_up_func)
                connect(node.rst_top_func_n, self.rst_up_func_n)
            elif node_type == "sink":
                connect(node.clk, self.clk_up_func)
                connect(node.rst_n, self.rst_up_func_n)
            elif node_type == "sp":
                connect(node.clk, self.clk_up_func)

        for index in range(_UP_COUNT - 1):
            connect(self.ring_nodes[index].pring_out_if, self.ring_nodes[index + 1].pring_in_if)
            connect(self.ring_nodes[index + 1].nring_out_if, self.ring_nodes[index].nring_in_if)

        connect(self.ring_nodes[-1].pring_out_if, self.pring_out_to_dn)
        connect(self.pring_in_from_dn, self.ring_nodes[0].pring_in_if)
        connect(self.ring_nodes[0].nring_out_if, self.nring_out_to_dn)
        connect(self.nring_in_from_dn, self.ring_nodes[-1].nring_in_if)

        self.expose_unconnected_interfaces()


class SocIntrDnHardenWrap(UhdlWrapperNode):
    def __init__(self):
        super().__init__(id=DN_HARDEN_ID)

        self.add_interface("clk_dn_func", is_global=True)
        self.add_interface("rst_dn_func_n", is_global=True)
        self.add_interface("pring_out_to_up")
        self.add_interface("pring_in_from_up")
        self.add_interface("nring_out_to_up")
        self.add_interface("nring_in_from_up")

        total = INIU_COUNT + TNIU_COUNT
        self.ring_nodes = []
        self.node_map = {}
        for entry in DN_RING_PLAN:
            node_type = entry["kind"]
            node_name = entry["name"]

            if node_type == "iniu":
                node = make_iniu_top_layer_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "tniu":
                node = make_tniu_top_layer_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sink":
                node = make_ring_sink_node(node_name=node_name, node_id=entry["node_id"], node_count=total)
            elif node_type == "sp":
                node = make_ring_sp_node(node_name=node_name)
            else:
                raise ValueError(f"Unsupported dn-harden ring node kind: {node_type}")

            setattr(self, node_name, node)
            self.node_map[node_name] = node
            self.ring_nodes.append(node)

            if node_type in ("iniu", "tniu"):
                connect(node.clk_top_func, self.clk_dn_func)
                connect(node.rst_top_func_n, self.rst_dn_func_n)
            elif node_type == "sink":
                connect(node.clk, self.clk_dn_func)
                connect(node.rst_n, self.rst_dn_func_n)
            elif node_type == "sp":
                connect(node.clk, self.clk_dn_func)

        for index in range(_DN_COUNT - 1):
            connect(self.ring_nodes[index].pring_out_if, self.ring_nodes[index + 1].pring_in_if)
            connect(self.ring_nodes[index + 1].nring_out_if, self.ring_nodes[index].nring_in_if)

        connect(self.pring_in_from_up, self.ring_nodes[0].pring_in_if)
        connect(self.ring_nodes[-1].pring_out_if, self.pring_out_to_up)
        connect(self.ring_nodes[0].nring_out_if, self.nring_out_to_up)
        connect(self.nring_in_from_up, self.ring_nodes[-1].nring_in_if)

        self.expose_unconnected_interfaces()


class SocIntrPdTopo(UhdlWrapperNode):
    """PD-mode harden-cut topology used as the primary PD generation target."""

    def __init__(self):
        super().__init__(id=PD_TOPO_ID)

        self.add_interface("clk_up_func", is_global=True)
        self.add_interface("rst_up_func_n", is_global=True)
        self.add_interface("clk_dn_func", is_global=True)
        self.add_interface("rst_dn_func_n", is_global=True)

        self.up_harden = SocIntrUpHardenWrap()
        self.dn_harden = SocIntrDnHardenWrap()
        self.async_nodes = {}

        for entry in ASYNC_CUT_PLAN:
            async_node = make_ring_async_node(entry["name"])
            setattr(self, entry["name"], async_node)
            self.async_nodes[entry["name"]] = async_node

            if entry["src_domain"] == "a":
                connect(async_node.clk_src, self.clk_up_func)
                connect(async_node.rst_src_n, self.rst_up_func_n)
            else:
                connect(async_node.clk_src, self.clk_dn_func)
                connect(async_node.rst_src_n, self.rst_dn_func_n)

            if entry["dst_domain"] == "a":
                connect(async_node.clk_dst, self.clk_up_func)
                connect(async_node.rst_dst_n, self.rst_up_func_n)
            else:
                connect(async_node.clk_dst, self.clk_dn_func)
                connect(async_node.rst_dst_n, self.rst_dn_func_n)

        connect(self.up_harden.clk_up_func, self.clk_up_func)
        connect(self.up_harden.rst_up_func_n, self.rst_up_func_n)
        connect(self.dn_harden.clk_dn_func, self.clk_dn_func)
        connect(self.dn_harden.rst_dn_func_n, self.rst_dn_func_n)

        async_up_to_dn = self.async_nodes["ring_async_cut_up_to_dn"]
        connect(self.up_harden.pring_out_to_dn, async_up_to_dn.pring_in_if)
        connect(async_up_to_dn.pring_out_if, self.dn_harden.pring_in_from_up)
        connect(self.dn_harden.nring_out_to_up, async_up_to_dn.nring_in_if)
        connect(async_up_to_dn.nring_out_if, self.up_harden.nring_in_from_dn)

        async_dn_to_up = self.async_nodes["ring_async_cut_dn_to_up"]
        connect(self.dn_harden.pring_out_to_up, async_dn_to_up.pring_in_if)
        connect(async_dn_to_up.pring_out_if, self.up_harden.pring_in_from_dn)
        connect(self.up_harden.nring_out_to_dn, async_dn_to_up.nring_in_if)
        connect(async_dn_to_up.nring_out_if, self.dn_harden.nring_in_from_up)

        self.expose_unconnected_interfaces()


SocIntrHardenTopTopo = SocIntrPdTopo
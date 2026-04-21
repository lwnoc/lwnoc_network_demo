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

from SocIntrNode import make_iniu_top_layer_node, make_tniu_top_layer_node
from SocIntrTopoConfig import DN_HARDEN_ID, HARDEN_TOP_ID, INIU_COUNT, RING_PLAN, TNIU_COUNT, UP_HARDEN_ID


_UP_PLAN = [(t, n, d) for t, n, d in RING_PLAN if d == "a"]
_DN_PLAN = [(t, n, d) for t, n, d in RING_PLAN if d == "b"]
_UP_COUNT = len(_UP_PLAN)
_DN_COUNT = len(_DN_PLAN)

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
        for global_idx, (node_type, node_name, _) in enumerate(RING_PLAN):
            if global_idx >= _UP_COUNT:
                break
            if node_type == "iniu":
                node = make_iniu_top_layer_node(node_name=node_name, node_id=global_idx, node_count=total)
            else:
                node = make_tniu_top_layer_node(node_name=node_name, node_id=global_idx, node_count=total)
            setattr(self, node_name, node)
            self.ring_nodes.append(node)
            connect(node.clk_top_func, self.clk_up_func)
            connect(node.rst_top_func_n, self.rst_up_func_n)

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
        for global_idx, (node_type, node_name, _) in enumerate(RING_PLAN):
            if global_idx < _UP_COUNT:
                continue
            if node_type == "iniu":
                node = make_iniu_top_layer_node(node_name=node_name, node_id=global_idx, node_count=total)
            else:
                node = make_tniu_top_layer_node(node_name=node_name, node_id=global_idx, node_count=total)
            setattr(self, node_name, node)
            self.ring_nodes.append(node)
            connect(node.clk_top_func, self.clk_dn_func)
            connect(node.rst_top_func_n, self.rst_dn_func_n)

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

        connect(self.up_harden.clk_up_func, self.clk_up_func)
        connect(self.up_harden.rst_up_func_n, self.rst_up_func_n)
        connect(self.dn_harden.clk_dn_func, self.clk_dn_func)
        connect(self.dn_harden.rst_dn_func_n, self.rst_dn_func_n)

        connect(self.up_harden.pring_out_to_dn, self.dn_harden.pring_in_from_up)
        connect(self.dn_harden.pring_out_to_up, self.up_harden.pring_in_from_dn)
        connect(self.up_harden.nring_out_to_dn, self.dn_harden.nring_in_from_up)
        connect(self.dn_harden.nring_out_to_up, self.up_harden.nring_in_from_dn)

        self.expose_unconnected_interfaces()


SocIntrHardenTopTopo = SocIntrPdTopo
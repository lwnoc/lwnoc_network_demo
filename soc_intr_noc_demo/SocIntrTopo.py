"""SoC-scale interrupt ring NoC topology derived from the attached sketch."""

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from SocIntrNode import make_iniu_node, make_tniu_node


RING_PLAN: list[tuple[str, str, str]] = [
    ("iniu", "cpu_ss_iniu", "a"),
    ("tniu", "cpu_ss_tniu", "a"),
    ("iniu", "audio_ss_iniu", "a"),
    ("tniu", "peri_ss_tniu", "a"),
    ("iniu", "gpu_ss1_iniu", "a"),
    ("tniu", "gpu_ss0_tniu", "a"),
    ("tniu", "display_ss_tniu", "a"),
    ("iniu", "dp_ss_iniu", "a"),
    ("iniu", "ddr6_iniu", "a"),
    ("iniu", "ddr7_iniu", "a"),
    ("iniu", "ddr8_iniu", "a"),
    ("iniu", "ddr9_iniu", "a"),
    ("iniu", "ddr10_iniu", "a"),
    ("tniu", "ddr11_tniu", "a"),
    ("iniu", "mipi_ss_iniu", "b"),
    ("iniu", "ufs_ss_iniu", "b"),
    ("tniu", "camera_ss_tniu", "b"),
    ("iniu", "camera_ss_iniu", "b"),
    ("iniu", "vpu_ss_iniu", "b"),
    ("iniu", "pcie_eth_ss_iniu", "b"),
    ("iniu", "debug_ss_iniu", "b"),
    ("iniu", "aon_ss_iniu", "b"),
    ("tniu", "aon_ss_tniu", "b"),
    ("iniu", "ucie_ss1_iniu", "b"),
    ("tniu", "ucie_ss1_tniu", "b"),
    ("iniu", "dspss5_iniu", "b"),
    ("tniu", "dspss4_tniu", "b"),
    ("iniu", "dspss3_iniu", "b"),
    ("tniu", "dspss2_tniu", "b"),
    ("iniu", "dspss1_iniu", "b"),
    ("tniu", "dspss0_tniu", "b"),
    ("iniu", "ddr0_iniu", "b"),
    ("iniu", "ddr1_iniu", "b"),
    ("iniu", "ddr2_iniu", "b"),
    ("iniu", "ddr3_iniu", "b"),
    ("iniu", "ddr4_iniu", "b"),
    ("iniu", "ddr5_iniu", "b"),
    ("iniu", "ucie_ss0_iniu", "b"),
    ("tniu", "ucie_ss0_tniu", "b"),
]


INIU_COUNT = sum(1 for node_type, _, _ in RING_PLAN if node_type == "iniu")
TNIU_COUNT = sum(1 for node_type, _, _ in RING_PLAN if node_type == "tniu")
TOPO_ID = f"soc_intr_ring_noc_{INIU_COUNT}i{TNIU_COUNT}t"


class SocIntrLogicTopo(UhdlWrapperNode):
    """Perimeter-ordered SoC interrupt ring demo.

    The ring order follows the attached figure's outer traversal and models
    mixed-role subsystems as adjacent INIU/TNIU ring nodes.
    """

    def __init__(self):
        super().__init__(id=TOPO_ID)

        self.add_interface("clk_noc_a", is_global=True)
        self.add_interface("rst_noc_a_n", is_global=True)
        self.add_interface("clk_noc_b", is_global=True)
        self.add_interface("rst_noc_b_n", is_global=True)

        count = len(RING_PLAN)
        self.ring_nodes = []
        self.node_map = {}
        endpoint_id = 0

        for node_type, node_name, domain_tag in RING_PLAN:
            if node_type == "iniu":
                node = make_iniu_node(node_name=node_name, node_id=endpoint_id, node_count=INIU_COUNT + TNIU_COUNT)
            else:  # tniu
                node = make_tniu_node(node_name=node_name, node_id=endpoint_id, node_count=INIU_COUNT + TNIU_COUNT)
            endpoint_id += 1

            setattr(self, node_name, node)
            self.node_map[node_name] = node
            self.ring_nodes.append(node)

            if domain_tag == "a":
                connect(node.clk_noc, self.clk_noc_a)
                connect(node.rst_noc_n, self.rst_noc_a_n)
            else:
                connect(node.clk_noc, self.clk_noc_b)
                connect(node.rst_noc_n, self.rst_noc_b_n)

        for index in range(count):
            nxt = (index + 1) % count
            connect(self.ring_nodes[index].pring_out_if, self.ring_nodes[nxt].pring_in_if)
            connect(self.ring_nodes[nxt].nring_out_if, self.ring_nodes[index].nring_in_if)

        self.expose_unconnected_interfaces()
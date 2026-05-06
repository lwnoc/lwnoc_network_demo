"""SoC interrupt ring NoC topology — merged UhdlWrapperNode topology definitions.

Four-file rule compliance: this file replaces SocIntrTopoConfig, SocIntrTopoDv,
SocIntrTopoPd. All topology classes, constants, ring plan, and node wiring.
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parents[1] / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]
from topo_core.utils.networkHierOpt import connect  # pyright: ignore[reportMissingImports]
from topo_core.utils.data_topology import DataTopology  # pyright: ignore[reportMissingImports]

from SocIntrNode import (
    SocIntrIniuNode, SocIntrTniuNode,
    SocIntrRingSpNode, SocIntrRingAsyncBridgeNode,
    SocIntrRingReqSinkNode, SocIntrRingReqZeroSourceNode,
    SocIntrRingSinkStationNode,
    SocIntrIniuTopLayerNode, SocIntrTniuTopLayerNode,
    TOP_LAYER_SUFFIX, TOP_FUNC_CLK, TOP_FUNC_RST_N,
)
from SocIntrTemplate import (
    INIU_SYS_CONFIGS, TNIU_SYS_CONFIGS,
    soc_intr_iniu_top_config, soc_intr_tniu_top_config,
    soc_intr_iniu_endpoint_config, soc_intr_tniu_endpoint_config,
    soc_intr_ring_network_config, soc_intr_ring_buf_config,
    soc_intr_ring_station_config, soc_intr_ring_link_config,
    soc_intr_ring_req_sink_config, soc_intr_ring_req_zero_source_config,
    SOC_INTR_RING_NODE_NUM, SOC_INTR_REQ_PLD_WIDTH,
    SOC_INTR_REQ_ID_WIDTH, SOC_INTR_REQ_QOS_WIDTH,
)

# ── Constants ──────────────────────────────────────────────────────────

TOPO_ID = "soc_intr_ring_noc"
PD_TOPO_ID = "soc_intr_ring_noc_pd"
HARDEN_TOP_ID = "soc_intr_ring_noc_harden_top"
UP_HARDEN_ID = "soc_intr_ring_noc_up_harden_wrap"
DN_HARDEN_ID = "soc_intr_ring_noc_dn_harden_wrap"

INIU_NODE_NAMES = list(INIU_SYS_CONFIGS.keys())
TNIU_NODE_NAMES = list(TNIU_SYS_CONFIGS.keys())
INIU_COUNT = len(INIU_NODE_NAMES)
TNIU_COUNT = len(TNIU_NODE_NAMES)

# Ring plan: (node_id, ss_name, role, harden_side)
RING_PLAN = [
    (0, "cpu_ss", "iniu", "a"), (1, "ucie_ss0", "iniu", "a"),
    (2, "audio_ss", "iniu", "a"), (3, "peri_ss", "tniu", ""),
    (4, "gpu_ss0", "tniu", "a"), (5, "gpu_ss1", "iniu", "a"),
    (6, "dp_ss", "iniu", "a"), (7, "display_ss", "tniu", ""),
    (8, "ddr6", "iniu", "b"), (9, "ddr7", "iniu", "b"),
    (10, "ddr8", "iniu", "b"), (11, "ddr9", "iniu", "b"),
    (12, "ddr10", "iniu", "b"), (13, "ddr11", "tniu", "b"),
    (14, "mipi_ss", "iniu", "b"), (15, "ufs_ss", "iniu", "b"),
    (16, "camera_ss", "iniu", "b"), (17, "camera_ss", "tniu", "b"),
    (18, "vpu_ss", "iniu", "b"), (19, "aon_ss", "iniu", "b"),
    (20, "aon_ss", "tniu", "b"), (21, "debug_ss", "iniu", "b"),
    (22, "ucie_ss1", "iniu", "b"), (23, "ucie_ss1", "tniu", "b"),
    (24, "dspss0", "tniu", ""), (25, "dspss1", "iniu", ""),
    (26, "dspss2", "tniu", ""), (27, "dspss3", "iniu", ""),
    (28, "dspss4", "tniu", ""), (29, "dspss5", "iniu", ""),
    (30, "ddr0", "iniu", ""), (31, "ddr1", "iniu", ""),
    (32, "ddr2", "iniu", ""), (33, "ddr3", "iniu", ""),
    (34, "ddr4", "iniu", ""), (35, "ddr5", "iniu", ""),
    (36, "pcie_eth_ss", "iniu", ""),
]

# ── Helpers ────────────────────────────────────────────────────────────

def _ring_node_id(ss_name: str, role: str) -> int:
    for (nid, name, r, _) in RING_PLAN:
        if name == ss_name and r == role:
            return nid
    return 0

def _node_attr_name(ss_name: str, role: str) -> str:
    return f"{ss_name}_{role}_node"

def _ring_node_attr_names() -> list[str]:
    return [_node_attr_name(ss_name, role) for _, ss_name, role, _ in RING_PLAN]

def _harden_iface(side: str) -> str:
    return f"clk_{side}_func"
def _harden_rst(side: str) -> str:
    return f"rst_{side}_func_n"

# ── DV Topologies ──────────────────────────────────────────────────────

# Single topology class for the DV generation pass.
# SocIntrFullLogicTopo (suffix-split pass) moved to gen_soc_intr_topo.py as
# _SocIntrFullLogicTopo (local-to-gen, ATB-style wrapper pattern).

class SocIntrLogicTopo(UhdlWrapperNode):
    """INIU + TNIU ring topology — ring nodes + ring network."""
    def __init__(self, id: str = TOPO_ID):
        super().__init__(id=id)
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        for (sid, side) in [("a", "up"), ("b", "dn")]:
            self.add_interface(f"clk_{side}_func", is_global=True)
            self.add_interface(f"rst_{side}_func_n", is_global=True)

        # Create ring nodes
        for (node_id, ss_name, role, harden) in RING_PLAN:
            sys_name = f"{ss_name}_{role}"
            if role == "iniu":
                node_cfg = INIU_SYS_CONFIGS.get(sys_name)
                n = SocIntrIniuNode(
                    id=f"{sys_name}_node",
                    sys_cfg=node_cfg,
                    top_cfg=soc_intr_iniu_top_config,
                    ring_cfg=soc_intr_iniu_endpoint_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            else:
                node_cfg = TNIU_SYS_CONFIGS.get(sys_name)
                n = SocIntrTniuNode(
                    id=f"{sys_name}_node",
                    sys_cfg=node_cfg,
                    top_cfg=soc_intr_tniu_top_config,
                    ring_cfg=soc_intr_tniu_endpoint_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            setattr(self, _node_attr_name(ss_name, role), n)
            connect(n.clk_noc, self.clk_noc)
            connect(n.rst_noc_n, self.rst_noc_n)
            n.set_data_topo_id(node_id)

        # Ring network (SP + async bridges, req_sink, zero_source)
        self.ring_sp = SocIntrRingSpNode(id="ring_sp", cfg=soc_intr_ring_buf_config)
        self.ring_req_sink = SocIntrRingReqSinkNode(id="ring_req_sink", cfg=soc_intr_ring_req_sink_config)
        self.ring_zero_source = SocIntrRingReqZeroSourceNode(id="ring_zero_source", cfg=soc_intr_ring_req_zero_source_config)
        connect(self.ring_sp.clk, self.clk_noc)
        connect(self.ring_sp.rst_n, self.rst_noc_n)
        connect(self.ring_req_sink.clk, self.clk_noc)
        connect(self.ring_req_sink.rst_n, self.rst_noc_n)
        connect(self.ring_zero_source.clk, self.clk_noc)
        connect(self.ring_zero_source.rst_n, self.rst_noc_n)

        ring_nodes = [getattr(self, attr_name) for attr_name in _ring_node_attr_names()]
        for prev_node, next_node in zip(ring_nodes, ring_nodes[1:]):
            connect(prev_node.pring_out_if, next_node.pring_in_if)
            connect(next_node.nring_out_if, prev_node.nring_in_if)

        first_node = ring_nodes[0]
        last_node = ring_nodes[-1]
        connect(last_node.pring_out_if, self.ring_sp.pring_in_if)
        connect(self.ring_sp.pring_out_if, first_node.pring_in_if)
        connect(first_node.nring_out_if, self.ring_sp.nring_in_if)
        connect(self.ring_sp.nring_out_if, last_node.nring_in_if)

        self.datatopo = DataTopology(TOPO_ID)
        for ring_node in ring_nodes:
            self.datatopo.add(ring_node)
        self.datatopo.add(self.ring_sp)
        self.datatopo.validate_ids()

        self.expose_unconnected_interfaces()


# ── PD topology (ai memnoc pattern: harden wrappers + top aggregation in Topo.py) ──

class SocIntrPdTopo(UhdlWrapperNode):
    """PD-mode harden topology: self-contained, instantiated directly by gen script."""

    def __init__(self, id: str = PD_TOPO_ID):
        super().__init__(id=id)

        # Top-level clocks
        self.add_interface("clk_up_func", is_global=True)
        self.add_interface("rst_up_func_n", is_global=True)
        self.add_interface("clk_dn_func", is_global=True)
        self.add_interface("rst_dn_func_n", is_global=True)

        # Compute harden assignment (same algorithm as before)
        n = len(RING_PLAN)
        assigned = [None] * n
        for i, (node_id, ss_name, role, harden) in enumerate(RING_PLAN):
            if harden == "a":
                assigned[i] = "a"
            elif harden == "b":
                assigned[i] = "b"

        changed = True
        while changed:
            changed = False
            for i in range(n):
                if assigned[i] is not None:
                    continue
                prev = (i - 1) % n
                nxt = (i + 1) % n
                if assigned[prev] == "a" or assigned[nxt] == "a":
                    assigned[i] = "a"
                    changed = True
                elif assigned[prev] == "b" or assigned[nxt] == "b":
                    assigned[i] = "b"
                    changed = True
        for i in range(n):
            if assigned[i] is None:
                assigned[i] = "a"

        # Create harden wrappers and nodes directly (ai memnoc pattern)
        self.u_up_harden = UhdlWrapperNode(UP_HARDEN_ID)
        self.u_up_harden.add_interface("clk_up_func", is_global=True)
        self.u_up_harden.add_interface("rst_up_func_n", is_global=True)
        self.u_dn_harden = UhdlWrapperNode(DN_HARDEN_ID)
        self.u_dn_harden.add_interface("clk_dn_func", is_global=True)
        self.u_dn_harden.add_interface("rst_dn_func_n", is_global=True)

        up_nodes = []
        dn_nodes = []

        for i, (node_id, ss_name, role, harden) in enumerate(RING_PLAN):
            sys_name = f"{ss_name}_{role}"
            if role == "iniu":
                top_layer = SocIntrIniuTopLayerNode(
                    id=f"{ss_name}_iniu{TOP_LAYER_SUFFIX}",
                    top_cfg=soc_intr_iniu_top_config,
                    ring_cfg=soc_intr_iniu_endpoint_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            else:
                top_layer = SocIntrTniuTopLayerNode(
                    id=f"{ss_name}_tniu{TOP_LAYER_SUFFIX}",
                    top_cfg=soc_intr_tniu_top_config,
                    ring_cfg=soc_intr_tniu_endpoint_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            if assigned[i] == "a":
                setattr(self.u_up_harden, f"u_{sys_name}", top_layer)
                up_nodes.append(top_layer)
            else:
                setattr(self.u_dn_harden, f"u_{sys_name}", top_layer)
                dn_nodes.append(top_layer)

        # Ring core in up_harden
        for ring_cls, ring_cfg, ring_name in [
            (SocIntrRingSpNode, soc_intr_ring_buf_config, "ring_sp"),
            (SocIntrRingReqSinkNode, soc_intr_ring_req_sink_config, "ring_req_sink"),
            (SocIntrRingReqZeroSourceNode, soc_intr_ring_req_zero_source_config, "ring_zero_source"),
        ]:
            sub = ring_cls(id=ring_name, cfg=ring_cfg)
            setattr(self.u_up_harden, f"u_{ring_name}", sub)

        self.u_up_harden.expose_unconnected_interfaces()
        self.u_dn_harden.expose_unconnected_interfaces()

        connect(self.u_up_harden.clk_up_func, self.clk_up_func)
        connect(self.u_up_harden.rst_up_func_n, self.rst_up_func_n)
        connect(self.u_dn_harden.clk_dn_func, self.clk_dn_func)
        connect(self.u_dn_harden.rst_dn_func_n, self.rst_dn_func_n)

        self.expose_unconnected_interfaces()


__all__ = [
    "TOPO_ID", "PD_TOPO_ID",
    "HARDEN_TOP_ID", "UP_HARDEN_ID", "DN_HARDEN_ID",
    "INIU_COUNT", "TNIU_COUNT", "RING_PLAN",
    "SocIntrLogicTopo", "SocIntrPdTopo",
]
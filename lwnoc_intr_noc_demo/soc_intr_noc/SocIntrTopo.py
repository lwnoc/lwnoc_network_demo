"""SoC interrupt ring NoC topology — merged UhdlWrapperNode topology definitions.

Four-file rule compliance: this file replaces SocIntrTopoConfig, SocIntrTopoDv,
SocIntrTopoPd. All topology classes, constants, ring plan, and node wiring.
"""
from _project_env import LWNOC_TOPO_ROOT

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]
from topo_core.utils.networkHierOpt import connect  # pyright: ignore[reportMissingImports]
from topo_core.utils.data_topology import DataTopology  # pyright: ignore[reportMissingImports]

from SocIntrNode import (
    SocIntrIniuNode, SocIntrTniuNode,
    SocIntrRingSpNode, SocIntrRingAsyncBridgeNode,
    SocIntrRingReqSinkNode,
    SocIntrRingSinkStationNode,
    SocIntrIniuTopLayerNode, SocIntrTniuTopLayerNode,
    TOP_LAYER_SUFFIX, TOP_FUNC_CLK, TOP_FUNC_RST_N,
)
from SocIntrTemplate import (
    INIU_SYS_CONFIGS, TNIU_SYS_CONFIGS,
    soc_intr_iniu_top_config, soc_intr_tniu_top_config,
    soc_intr_iniu_endpoint_config, soc_intr_tniu_endpoint_config,
    soc_intr_req_rs_config,
    soc_intr_ring_network_config, soc_intr_ring_buf_config,
    soc_intr_ring_station_config, soc_intr_ring_link_config,
    soc_intr_ring_req_sink_config,
    SOC_INTR_RING_NODE_NUM, SOC_INTR_REQ_PLD_WIDTH,
    SOC_INTR_REQ_ID_WIDTH, SOC_INTR_REQ_QOS_WIDTH,
)

# ── Constants ──────────────────────────────────────────────────────────

TOPO_ID = "soc_intr_ring_noc"
HARDEN_TOP_ID = "soc_intr_ring_noc_harden_top"
UP_HARDEN_ID = "soc_intr_ring_noc_up_harden_wrap"
DN_HARDEN_ID = "soc_intr_ring_noc_dn_harden_wrap"

INIU_NODE_NAMES = list(INIU_SYS_CONFIGS.keys())
TNIU_NODE_NAMES = list(TNIU_SYS_CONFIGS.keys())
INIU_COUNT = len(INIU_NODE_NAMES)
TNIU_COUNT = len(TNIU_NODE_NAMES)

DEFAULT_REQ_REGSLICE_STAGE = 0
INIU_REGSLICE_STAGES = {name: DEFAULT_REQ_REGSLICE_STAGE for name in INIU_NODE_NAMES}
TNIU_REGSLICE_STAGES = {name: DEFAULT_REQ_REGSLICE_STAGE for name in TNIU_NODE_NAMES}

# Ring plan: (node_id, ss_name, role, harden_side)
# harden: "a"=up (clk_up_func), "b"=dn (clk_dn_func)
# Order: Domain A (up) then Domain B (dn), per soc_intr_noc_topo
RING_PLAN = [
    # ── Domain A (up) ──
    (0, "npu_ss0", "iniu", "a"),   (1, "npu_ss0", "tniu", "a"),
    (2, "cpu_ss", "tniu", "a"),    (3, "cpu_ss", "iniu", "a"),
    (4, "camera_ss", "iniu", "a"),
    (5, "gpu_ss1", "iniu", "a"),
    (6, "mipi_ss", "iniu", "a"),
    (7, "dp_ss", "iniu", "a"),
    (8, "display_ss", "iniu", "a"),
    (9, "vpu_ss", "iniu", "a"),
    (10, "noc_ss", "iniu", "a"),
    (11, "npu_ss1", "iniu", "a"),
    (12, "aon_ss", "iniu", "a"),   (13, "aon_ss", "tniu", "a"),
    (14, "dsp_ss0", "iniu", "a"),  (15, "dsp_ss0", "tniu", "a"),
    (16, "dsp_ss1", "iniu", "a"),  (17, "dsp_ss1", "tniu", "a"),
    (18, "dsp_ss2", "iniu", "a"),  (19, "dsp_ss2", "tniu", "a"),
    (20, "dsp_ss3", "iniu", "a"),  (21, "dsp_ss3", "tniu", "a"),
    (22, "dsp_ss4", "iniu", "a"),  (23, "dsp_ss4", "tniu", "a"),
    (24, "dsp_ss5", "iniu", "a"),  (25, "dsp_ss5", "tniu", "a"),
    (26, "ddr6", "iniu", "a"),     (27, "ddr7", "iniu", "a"),
    (28, "ddr8", "iniu", "a"),     (29, "ddr9", "iniu", "a"),
    (30, "ddr10", "iniu", "a"),    (31, "ddr11", "iniu", "a"),
    # ── Domain B (dn) ──
    (32, "npu_ss4", "iniu", "b"),  (33, "npu_ss4", "tniu", "b"),
    (34, "npu_ss2", "tniu", "b"),  (35, "npu_ss2", "iniu", "b"),
    (36, "gpu_ss0", "iniu", "b"),
    (37, "pcie_eth_ss", "iniu", "b"),
    (38, "ufs_ss", "iniu", "b"),
    (39, "npu_ss3", "iniu", "b"),  (40, "npu_ss3", "tniu", "b"),
    (41, "ddr0", "iniu", "b"),     (42, "ddr1", "iniu", "b"),
    (43, "ddr2", "iniu", "b"),     (44, "ddr3", "iniu", "b"),
    (45, "ddr4", "iniu", "b"),     (46, "ddr5", "iniu", "b"),
    (47, "peri_ss", "iniu", "b"),
    (48, "mcu_ss", "iniu", "b"),   (49, "mcu_ss", "tniu", "b"),
    (50, "audio_ss", "tniu", "b"),
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
                    req_rs_cfg=soc_intr_req_rs_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                    top_regslice_stage=INIU_REGSLICE_STAGES.get(sys_name, DEFAULT_REQ_REGSLICE_STAGE),
                )
            else:
                node_cfg = TNIU_SYS_CONFIGS.get(sys_name)
                n = SocIntrTniuNode(
                    id=f"{sys_name}_node",
                    sys_cfg=node_cfg,
                    top_cfg=soc_intr_tniu_top_config,
                    ring_cfg=soc_intr_tniu_endpoint_config,
                    req_rs_cfg=soc_intr_req_rs_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                    top_regslice_stage=TNIU_REGSLICE_STAGES.get(sys_name, DEFAULT_REQ_REGSLICE_STAGE),
                )
            setattr(self, _node_attr_name(ss_name, role), n)
            connect(n.clk_noc, self.clk_noc)
            connect(n.rst_noc_n, self.rst_noc_n)
            n.set_data_topo_id(node_id)

        # Ring network: SP, sink station between last_node and ring_sp
        self.ring_sp = SocIntrRingSpNode(id="ring_sp", cfg=soc_intr_ring_buf_config)
        self.ring_sink_station = SocIntrRingSinkStationNode(
            id="ring_sink_station",
            endpoint_cfg=soc_intr_tniu_endpoint_config,
            sink_cfg=soc_intr_ring_req_sink_config,
            node_id=SOC_INTR_RING_NODE_NUM,  # last valid node_id + 1
            node_count=SOC_INTR_RING_NODE_NUM + 1,
        )
        connect(self.ring_sp.clk, self.clk_noc)
        connect(self.ring_sp.rst_n, self.rst_noc_n)
        connect(self.ring_sink_station.clk, self.clk_noc)
        connect(self.ring_sink_station.rst_n, self.rst_noc_n)

        ring_nodes = [getattr(self, attr_name) for attr_name in _ring_node_attr_names()]
        for prev_node, next_node in zip(ring_nodes, ring_nodes[1:]):
            connect(prev_node.pring_out_if, next_node.pring_in_if)
            connect(next_node.nring_out_if, prev_node.nring_in_if)

        first_node = ring_nodes[0]
        last_node = ring_nodes[-1]
        # pring: last → sink_station → ring_sp → first
        connect(last_node.pring_out_if, self.ring_sink_station.pring_in_if)
        connect(self.ring_sink_station.pring_out_if, self.ring_sp.pring_in_if)
        connect(self.ring_sp.pring_out_if, first_node.pring_in_if)
        # nring (reverse): first → ring_sp → sink_station → last
        connect(first_node.nring_out_if, self.ring_sp.nring_in_if)
        connect(self.ring_sp.nring_out_if, self.ring_sink_station.nring_in_if)
        connect(self.ring_sink_station.nring_out_if, last_node.nring_in_if)

        self.datatopo = DataTopology(TOPO_ID)
        for ring_node in ring_nodes:
            self.datatopo.add(ring_node)
        self.datatopo.add(self.ring_sp)
        self.datatopo.add(self.ring_sink_station)
        self.datatopo.validate_ids()

        self.expose_unconnected_interfaces()


__all__ = [
    "TOPO_ID",
    "HARDEN_TOP_ID", "UP_HARDEN_ID", "DN_HARDEN_ID",
    "INIU_COUNT", "TNIU_COUNT", "RING_PLAN",
    "SocIntrLogicTopo",
]
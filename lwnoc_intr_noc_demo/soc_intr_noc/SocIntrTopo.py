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

from SocIntrNode import (
    SocIntrIniuNode, SocIntrTniuNode,
    SocIntrRingSpNode, SocIntrRingAsyncBridgeNode,
    SocIntrRingReqSinkNode, SocIntrRingReqZeroSourceNode,
    SocIntrRingSinkStationNode, SocIntrRingNodeWrap,
    SocIntrIniuTopLayerNode, SocIntrTniuTopLayerNode,
    SocIntrXbarRoutingLutNode,
    TOP_LAYER_SUFFIX, TOP_FUNC_CLK, TOP_FUNC_RST_N,
)
from SocIntrTemplate import (
    INIU_SYS_CONFIGS, TNIU_SYS_CONFIGS,
    soc_intr_iniu_top_config, soc_intr_tniu_top_config,
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
                    ring_cfg=soc_intr_ring_buf_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            else:
                node_cfg = TNIU_SYS_CONFIGS.get(sys_name)
                n = SocIntrTniuNode(
                    id=f"{sys_name}_node",
                    sys_cfg=node_cfg,
                    top_cfg=soc_intr_tniu_top_config,
                    ring_cfg=soc_intr_ring_buf_config,
                    node_id=node_id,
                    node_count=SOC_INTR_RING_NODE_NUM,
                )
            setattr(self, _node_attr_name(ss_name, role), n)
            connect(n.clk_noc, self.clk_noc)
            connect(n.rst_noc_n, self.rst_noc_n)

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

        self.expose_unconnected_interfaces()


# ── PD topology is in gen_soc_intr_topo.py (ATB pattern — PD wrappers local to gen) ──


__all__ = [
    "TOPO_ID", "PD_TOPO_ID",
    "HARDEN_TOP_ID", "UP_HARDEN_ID", "DN_HARDEN_ID",
    "INIU_COUNT", "TNIU_COUNT", "RING_PLAN",
    "SocIntrLogicTopo",
]
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from DtiTemplate import (
    INIU_NODE_NAMES,
    dti_sw_left3_config,
    dti_sw_left_dsp0_config,
    dti_sw_left_dsp1_config,
    dti_sw_left_noc1_config,
    dti_sw_right4_config,
    dti_sw_right_noc0_config,
    dti_sw_root_config,
)
from DtiTreeNode import DtiSwitchNode
from DtiNode import (
    make_iniu_node,
    make_tcu_tniu_node,
)


INIU_TO_SWITCH_BINDINGS = (
    ("pcie_eth", "sw_left3", 0),
    ("vpu", "sw_left3", 1),
    ("dsp2", "sw_left3", 2),
    ("dsp1", "sw_left_dsp1", 1),
    ("dsp0", "sw_left_dsp0", 1),
    ("noc_tbu1", "sw_left_noc1", 1),
    ("usb_ufs", "sw_right4", 0),
    ("mipi0", "sw_right4", 1),
    ("mipi1", "sw_right4", 2),
    ("camera", "sw_right4", 3),
    ("noc_tbu0", "sw_right_noc0", 1),
)


class DtiLogicTopo(UhdlWrapperNode):
    def __init__(self, id: str = "dti_logic_topo"):
        super().__init__(id=id)

        self._validate_iniu_bindings()

        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        # ── Switches (7 nodes) ─────────────────────────────────────────────
        self.sw_left3 = DtiSwitchNode(id="sw_left3", cfg=dti_sw_left3_config, top="dti_switch_3i1o_wrap", input_count=3)
        self.sw_left_dsp1 = DtiSwitchNode(id="sw_left_dsp1", cfg=dti_sw_left_dsp1_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_left_dsp0 = DtiSwitchNode(id="sw_left_dsp0", cfg=dti_sw_left_dsp0_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_left_noc1 = DtiSwitchNode(id="sw_left_noc1", cfg=dti_sw_left_noc1_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_right4 = DtiSwitchNode(id="sw_right4", cfg=dti_sw_right4_config, top="dti_switch_4i1o_wrap", input_count=4)
        self.sw_right_noc0 = DtiSwitchNode(id="sw_right_noc0", cfg=dti_sw_right_noc0_config, top="dti_switch_2i1o_wrap", input_count=2)
        self.sw_root = DtiSwitchNode(id="sw_root", cfg=dti_sw_root_config, top="dti_switch_2i1o_wrap", input_count=2)

        for node in [
            self.sw_left3,
            self.sw_left_dsp1,
            self.sw_left_dsp0,
            self.sw_left_noc1,
            self.sw_right4,
            self.sw_right_noc0,
            self.sw_root,
        ]:
            connect(node.clk, self.clk_noc)
            connect(node.rst_n, self.rst_noc_n)

        # ── Switch internal tree wiring ────────────────────────────────────
        connect(self.sw_left3.tniu_req, self.sw_left_dsp1.iniu0_req)
        connect(self.sw_left3.tniu_rsp, self.sw_left_dsp1.iniu0_rsp)

        connect(self.sw_left_dsp1.tniu_req, self.sw_left_dsp0.iniu0_req)
        connect(self.sw_left_dsp1.tniu_rsp, self.sw_left_dsp0.iniu0_rsp)

        connect(self.sw_left_dsp0.tniu_req, self.sw_left_noc1.iniu0_req)
        connect(self.sw_left_dsp0.tniu_rsp, self.sw_left_noc1.iniu0_rsp)

        connect(self.sw_right4.tniu_req, self.sw_right_noc0.iniu0_req)
        connect(self.sw_right4.tniu_rsp, self.sw_right_noc0.iniu0_rsp)

        connect(self.sw_left_noc1.tniu_req, self.sw_root.iniu0_req)
        connect(self.sw_left_noc1.tniu_rsp, self.sw_root.iniu0_rsp)
        connect(self.sw_right_noc0.tniu_req, self.sw_root.iniu1_req)
        connect(self.sw_right_noc0.tniu_rsp, self.sw_root.iniu1_rsp)

        # ── INIU / TNIU wrapper nodes (11 per-endpoint INIUs + 1 TNIU) ─────
        self.iniu_nodes = {node_name: make_iniu_node(node_name=node_name) for node_name in INIU_NODE_NAMES}
        for node_name, node in self.iniu_nodes.items():
            setattr(self, f"{node_name}_iniu", node)
        self.tcu_tniu       = make_tcu_tniu_node()

        for niu in [*self.iniu_nodes.values(), self.tcu_tniu]:
            connect(niu.clk_top, self.clk_noc)
            connect(niu.rst_top_n, self.rst_noc_n)

        # ── INIU top → switch leaf (5-signal, positional zip matched by suffix sort) ──
        for node_name, sw_name, iniu_index in INIU_TO_SWITCH_BINDINGS:
            iniu_node = self.iniu_nodes[node_name]
            sw_node = getattr(self, sw_name)
            connect(iniu_node.top_req, getattr(sw_node, f"iniu{iniu_index}_req"))
            connect(iniu_node.top_rsp, getattr(sw_node, f"iniu{iniu_index}_rsp"))

        # ── Switch root → TNIU (5-signal) ────────────────────────────────
        connect(self.tcu_tniu.top_req, self.sw_root.tniu_req)
        connect(self.tcu_tniu.top_rsp, self.sw_root.tniu_rsp)

        self.expose_unconnected_interfaces()

    @staticmethod
    def _validate_iniu_bindings() -> None:
        declared = set(INIU_NODE_NAMES)
        wired = {node_name for node_name, _, _ in INIU_TO_SWITCH_BINDINGS}
        if wired != declared:
            missing = sorted(declared - wired)
            extra = sorted(wired - declared)
            raise ValueError(
                f"DTI INIU switch bindings mismatch: missing={missing}, extra={extra}"
            )
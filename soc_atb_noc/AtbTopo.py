"""
AtbTopo.py — ATB topology definition as UhdlWrapperNode subclass.

Topology (memnoc-like split):
  dsp_ss0~5 → left_agg(N=6) → left_funnel(6→1) → async_bridge.slv
    sync ───────────────────────────────────────────────── sync
  async_bridge.mst → right_agg(N=3) → right_funnel(3→1) → debug_tniu_ss
  camera_ss → right_agg
  mipi_ss   → right_agg
"""
import json
from pathlib import Path

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]
from topo_core.utils.networkHierOpt import connect  # pyright: ignore[reportMissingImports]

from AtbNode import (
    AtbIniuNode,
    AtbTniuNode,
    AtbFunnelNode,
    AtbAsyncBridgeNode,
    AtbFunnelIngressAggNode,
)
from AtbTemplate import (
    atb_async_bridge_config,
    atb_funnel_config,
    atb_iniu_noc_config,
    atb_tniu_noc_config,
    camera_iniu_cfg,
    debug_tniu_cfg,
    dsp_iniu_cfg,
    mipi_iniu_cfg,
)


# ATB data/ID parameters (must match ATB submodule RTL).
# ATB_DATA_WIDTH: actual ATB data bus width, NOT payload (data+id+bytes).
# ATB_ID_WIDTH:   ATB stream identifier width.
ATB_DATA_WIDTH = 128
ATB_ID_WIDTH   = 7
ATB_BYTES_WIDTH = 4  # clog2(128/8) = 4
NUM_DSP_SS = 6


class AtbLogicTopo(UhdlWrapperNode):
    """SoC-level ATB packet network topology — owns all node instances and connections."""

    def __init__(self, id: str = "atb_soc_topo"):
        super().__init__(id=id)

        # ── Node instances ──────────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            setattr(self, f"dsp_ss{i}_node",
                    AtbIniuNode(node_id=f"dsp_ss{i}", cfg=dsp_iniu_cfg, cfg_top=atb_iniu_noc_config))

        self.camera_node = AtbIniuNode(node_id="camera_ss", cfg=camera_iniu_cfg, cfg_top=atb_iniu_noc_config)
        self.mipi_node   = AtbIniuNode(node_id="mipi_ss",   cfg=mipi_iniu_cfg,   cfg_top=atb_iniu_noc_config)
        self.debug_node  = AtbTniuNode(node_id="debug_tniu_ss", cfg=debug_tniu_cfg, cfg_top=atb_tniu_noc_config)

        # ── Funnels with aggregators (memnoc-like port packing) ─────────
        self.left_funnel  = AtbFunnelNode(node_id="left_funnel",   num_inputs=NUM_DSP_SS,
                                          data_width=ATB_DATA_WIDTH, cfg=atb_funnel_config)
        self.right_funnel = AtbFunnelNode(node_id="right_funnel",  num_inputs=3,
                                          data_width=ATB_DATA_WIDTH, cfg=atb_funnel_config)

        self.left_agg  = AtbFunnelIngressAggNode(node_id="left_agg",  num_inputs=NUM_DSP_SS,
                                                  data_width=ATB_DATA_WIDTH, id_width=ATB_ID_WIDTH,
                                                  cfg=atb_funnel_config)
        self.right_agg = AtbFunnelIngressAggNode(node_id="right_agg", num_inputs=3,
                                                  data_width=ATB_DATA_WIDTH, id_width=ATB_ID_WIDTH,
                                                  cfg=atb_funnel_config)

        self.async_bridge = AtbAsyncBridgeNode(id="async_bridge", cfg=atb_async_bridge_config)

        # ── Interfaces ──────────────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            self.add_interface(f"clk_dsp_ss{i}_sys", is_global=True)
            self.add_interface(f"rst_dsp_ss{i}_sys_n", is_global=True)
        self.add_interface("clk_camera_sys", is_global=True)
        self.add_interface("rst_camera_sys_n", is_global=True)
        self.add_interface("clk_mipi_sys", is_global=True)
        self.add_interface("rst_mipi_sys_n", is_global=True)
        self.add_interface("clk_debug_sys", is_global=True)
        self.add_interface("rst_debug_sys_n", is_global=True)
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)
        # Funnel APB debug ports
        for funnel_name in ["left_funnel", "right_funnel"]:
            self.add_interface(f"{funnel_name}_pclkendbg", is_global=True)
            self.add_interface(f"{funnel_name}_pseldbg", is_global=True)
            self.add_interface(f"{funnel_name}_penabledbg", is_global=True)
            self.add_interface(f"{funnel_name}_pwritedbg", is_global=True)
            self.add_interface(f"{funnel_name}_paddrdbg31", is_global=True)

        # ── Clock/reset mapping (per-SS) ────────────────────────────────
        for i in range(NUM_DSP_SS):
            node = getattr(self, f"dsp_ss{i}_node")
            connect(getattr(self, f"clk_dsp_ss{i}_sys"), node.clk_sys)
            connect(getattr(self, f"rst_dsp_ss{i}_sys_n"), node.rst_sys_n)
            connect(self.clk_noc, node.clk_noc)
            connect(self.rst_noc_n, node.rst_noc_n)

        connect(self.clk_camera_sys, self.camera_node.clk_sys)
        connect(self.rst_camera_sys_n, self.camera_node.rst_sys_n)
        connect(self.clk_noc, self.camera_node.clk_noc)
        connect(self.rst_noc_n, self.camera_node.rst_noc_n)

        connect(self.clk_mipi_sys, self.mipi_node.clk_sys)
        connect(self.rst_mipi_sys_n, self.mipi_node.rst_sys_n)
        connect(self.clk_noc, self.mipi_node.clk_noc)
        connect(self.rst_noc_n, self.mipi_node.rst_noc_n)

        connect(self.clk_debug_sys, self.debug_node.clk_sys)
        connect(self.rst_debug_sys_n, self.debug_node.rst_sys_n)
        connect(self.clk_noc, self.debug_node.clk_noc)
        connect(self.rst_noc_n, self.debug_node.rst_noc_n)

        # ── Async bridge clock/reset ────────────────────────────────────
        # Bridge wrapper has no clk_src/clk_dst interfaces; sub-node ports
        # (slv_clk, mst_clk) are exposed via expose_unconnected_interfaces()
        # and connected at the top level.

        # ── Funnel clock/reset (all on noc domain) ──────────────────────
        for funnel in [self.left_funnel, self.right_funnel]:
            connect(self.clk_noc, funnel.clk)
            connect(self.rst_noc_n, funnel.resetn)

        # ── Aggregator funnel_side → Funnel (same hierarchy, matching port names) ──
        for port_name in ["atvalids", "afreadys", "atids", "atdatas", "atbytess",
                          "atreadys", "afvalids", "syncreqs"]:
            connect(getattr(self.left_agg, port_name), getattr(self.left_funnel, port_name))
            connect(getattr(self.right_agg, port_name), getattr(self.right_funnel, port_name))

        # ── Data path topology (SS → agg → funnel → bridge → agg → funnel → TNIU) ──
        # SS→agg / bridge→agg connections cross wrapper hierarchy boundaries.
        # Topology structure:
        #   left_agg.in0..5_chan  ← dsp_ss0..5 top_side.m_chan
        #   left_agg.funnel_bus   → left_funnel (above)
        #   left_funnel           → async_bridge.slv_side.s_chan
        #   async_bridge.mst_side.m_chan → right_agg.in2_chan
        #   camera_ss → right_agg.in0_chan
        #   mipi_ss   → right_agg.in1_chan
        #   right_agg.funnel_bus  → right_funnel (above)
        #   right_funnel          → debug_tniu_ss top_side.s_chan
        # Signal names differ at funnel↔bridge/funnel↔TNIU boundaries:
        #   atvalidm(→) ↔ s_atvalid, atreadym(←) ↔ s_atready, etc.
        # These are exposed as integration-level wiring contract.

        self.expose_unconnected_interfaces()

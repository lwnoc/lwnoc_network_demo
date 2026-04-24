"""
AtbTopo.py — ATB topology definition as UhdlWrapperNode subclass.

Topology:
  dsp_ss0~5 → left_funnel → async_bridge → right_funnel → debug_tniu_ss
  camera_ss → right_funnel
  mipi_ss   → right_funnel
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
)
from AtbTemplate import dsp_iniu_cfg, camera_iniu_cfg, mipi_iniu_cfg, debug_tniu_cfg


ATB_NETWORK_PAYLOAD_W = 128 + 4 + 7
NUM_DSP_SS = 6


class AtbLogicTopo(UhdlWrapperNode):
    """SoC-level ATB packet network topology — owns all node instances and connections."""

    def __init__(self, id: str = "atb_soc_topo"):
        super().__init__(id=id)

        # ── Node instances ──────────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            setattr(self, f"dsp_ss{i}_node", AtbIniuNode(node_id=f"dsp_ss{i}", cfg=dsp_iniu_cfg))

        self.camera_node = AtbIniuNode(node_id="camera_ss", cfg=camera_iniu_cfg)
        self.mipi_node   = AtbIniuNode(node_id="mipi_ss",   cfg=mipi_iniu_cfg)
        self.debug_node  = AtbTniuNode(node_id="debug_tniu_ss", cfg=debug_tniu_cfg)

        self.left_funnel  = AtbFunnelNode(node_id="left_funnel")
        self.cam_funnel   = AtbFunnelNode(node_id="camera_funnel")
        self.right_funnel = AtbFunnelNode(node_id="right_funnel")

        self.async_bridge = AtbAsyncBridgeNode(id="async_bridge")

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
        # Funnel APB debug ports exposed to top
        for funnel_name in ["left_funnel", "camera_funnel", "right_funnel"]:
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

        # ── Async bridge clock/reset (shared noc domain) ────────────────
        connect(self.async_bridge.clk_src, self.clk_noc)
        connect(self.async_bridge.rst_src_n, self.rst_noc_n)
        connect(self.async_bridge.clk_dst, self.clk_noc)
        connect(self.async_bridge.rst_dst_n, self.rst_noc_n)

        # ── Funnel clock/reset (all on noc domain) ──────────────────────
        for funnel in [self.left_funnel, self.cam_funnel, self.right_funnel]:
            connect(self.clk_noc, funnel.clk)
            connect(self.rst_noc_n, funnel.resetn)

        self.expose_unconnected_interfaces()

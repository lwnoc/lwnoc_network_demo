"""AtbTopo.py — ATB topology definition as UhdlWrapperNode subclass."""

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode  # pyright: ignore[reportMissingImports]
from topo_core.utils.networkHierOpt import connect  # pyright: ignore[reportMissingImports]

from AtbNode import (
    AtbIniuNode,
    AtbTniuNode,
    AtbFunnelBridgeNode,
)
from AtbTemplate import (
    atb_funnel_config,
    aon_iniu_cfg,
    aon_iniu_noc_cfg,
    camera_iniu_cfg,
    camera_iniu_noc_cfg,
    cpu_iniu_cfg,
    cpu_iniu_noc_cfg,
    display_iniu_cfg,
    display_iniu_noc_cfg,
    dsp_iniu_cfg,
    dsp_iniu_noc_cfg,
    gpu0_iniu_cfg,
    gpu0_iniu_noc_cfg,
    gpu1_iniu_cfg,
    gpu1_iniu_noc_cfg,
    mcu_iniu_cfg,
    mcu_iniu_noc_cfg,
    mipi_iniu_cfg,
    mipi_iniu_noc_cfg,
    peri_tniu_cfg,
    peri_tniu_noc_cfg,
    usb_dp_iniu_cfg,
    usb_dp_iniu_noc_cfg,
)


# ATB data/ID parameters (must match ATB submodule RTL).
# ATB_DATA_WIDTH: actual ATB data bus width, NOT payload (data+id+bytes).
# ATB_ID_WIDTH:   ATB stream identifier width.
ATB_DATA_WIDTH = 128
ATB_ID_WIDTH   = 7
ATB_BYTES_WIDTH = 4  # clog2(128/8) = 4
NUM_DSP_SS = 6

MEDIA_SS_SPECS = [
    ("camera_node", "camera_ss", camera_iniu_cfg, camera_iniu_noc_cfg),
    ("mipi_node", "mipi_ss", mipi_iniu_cfg, mipi_iniu_noc_cfg),
    ("gpu1_node", "gpu1_ss", gpu1_iniu_cfg, gpu1_iniu_noc_cfg),
    ("usb_dp_node", "usb_dp_ss", usb_dp_iniu_cfg, usb_dp_iniu_noc_cfg),
    ("display_node", "display_ss", display_iniu_cfg, display_iniu_noc_cfg),
    ("aon_node", "aon_ss", aon_iniu_cfg, aon_iniu_noc_cfg),
]

FINAL_FANIN_SPECS = [
    ("gpu0_node", "gpu_ss0", gpu0_iniu_cfg, gpu0_iniu_noc_cfg),
    ("cpu_node", "cpu_ss", cpu_iniu_cfg, cpu_iniu_noc_cfg),
    ("mcu_node", "mcu_ss", mcu_iniu_cfg, mcu_iniu_noc_cfg),
]


class AtbLogicTopo(UhdlWrapperNode):
    """SoC-level ATB packet network topology — owns all node instances and connections."""

    def __init__(self, id: str = "atb_soc_topo"):
        super().__init__(id=id)

        def _exposed_iface(node, suffix: str):
            for iface_id, interface in node.interfaces.items():
                if iface_id.endswith(suffix):
                    return interface
            raise AttributeError(f"{node.id} has no interface ending with {suffix}")

        def _connect_funnel_output_to_channel(upstream_funnel, downstream_funnel, channel_index: int):
            connect(upstream_funnel.m_chan, getattr(downstream_funnel, f"ch{channel_index}_chan"))

        # ── Node instances ──────────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            setattr(self, f"dsp_ss{i}_node",
                    AtbIniuNode(node_id=f"dsp_ss{i}", cfg=dsp_iniu_cfg, cfg_top=dsp_iniu_noc_cfg))

        for attr_name, node_id, cfg, cfg_top in MEDIA_SS_SPECS + FINAL_FANIN_SPECS:
            setattr(self, attr_name, AtbIniuNode(node_id=node_id, cfg=cfg, cfg_top=cfg_top))

        self.peri_node = AtbTniuNode(node_id="peri_ss", cfg=peri_tniu_cfg, cfg_top=peri_tniu_noc_cfg)

        # ── Funnel bridges (N-to-1, combines per-channel input + single master output) ──
        self.right_dsp_funnel = AtbFunnelBridgeNode(
            node_id="right_dsp_funnel0",
            num_inputs=NUM_DSP_SS,
            data_width=ATB_DATA_WIDTH,
            id_width=ATB_ID_WIDTH,
            cfg=atb_funnel_config,
        )
        self.top_media_funnel = AtbFunnelBridgeNode(
            node_id="top_media_funnel0",
            num_inputs=len(MEDIA_SS_SPECS),
            data_width=ATB_DATA_WIDTH,
            id_width=ATB_ID_WIDTH,
            cfg=atb_funnel_config,
        )
        self.left_top_funnel = AtbFunnelBridgeNode(
            node_id="left_top_funnel0",
            num_inputs=5,
            data_width=ATB_DATA_WIDTH,
            id_width=ATB_ID_WIDTH,
            cfg=atb_funnel_config,
        )

        # ── Interfaces ──────────────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            self.add_interface(f"clk_dsp_ss{i}_sys", is_global=True)
            self.add_interface(f"rst_dsp_ss{i}_sys_n", is_global=True)
        for _, node_id, _, _ in MEDIA_SS_SPECS + FINAL_FANIN_SPECS:
            self.add_interface(f"clk_{node_id}_sys", is_global=True)
            self.add_interface(f"rst_{node_id}_sys_n", is_global=True)
        self.add_interface("clk_peri_ss_sys", is_global=True)
        self.add_interface("rst_peri_ss_sys_n", is_global=True)
        self.add_interface("clk_noc", is_global=True)
        self.add_interface("rst_noc_n", is_global=True)

        # ── Clock/reset mapping (per-SS) ────────────────────────────────
        for i in range(NUM_DSP_SS):
            node = getattr(self, f"dsp_ss{i}_node")
            connect(getattr(self, f"clk_dsp_ss{i}_sys"), node.clk_sys)
            connect(getattr(self, f"rst_dsp_ss{i}_sys_n"), node.rst_sys_n)
            connect(self.clk_noc, node.clk_noc)
            connect(self.rst_noc_n, node.rst_noc_n)

        for attr_name, node_id, _, _ in MEDIA_SS_SPECS + FINAL_FANIN_SPECS:
            node = getattr(self, attr_name)
            connect(getattr(self, f"clk_{node_id}_sys"), node.clk_sys)
            connect(getattr(self, f"rst_{node_id}_sys_n"), node.rst_sys_n)
            connect(self.clk_noc, node.clk_noc)
            connect(self.rst_noc_n, node.rst_noc_n)

        connect(self.clk_peri_ss_sys, self.peri_node.clk_sys)
        connect(self.rst_peri_ss_sys_n, self.peri_node.rst_sys_n)
        connect(self.clk_noc, self.peri_node.clk_noc)
        connect(self.rst_noc_n, self.peri_node.rst_noc_n)

        # ── Funnel clock/reset (all on noc domain) ──────────────────────
        for funnel in [self.right_dsp_funnel, self.top_media_funnel, self.left_top_funnel]:
            connect(self.clk_noc, funnel.clk)
            connect(self.rst_noc_n, funnel.resetn)

        # ── Data path topology ──────────────────────────────────────────
        for i in range(NUM_DSP_SS):
            ss_node = getattr(self, f"dsp_ss{i}_node")
            connect(_exposed_iface(ss_node, "_top_wrap.m_chan_porting"),
                    getattr(self.right_dsp_funnel, f"ch{i}_chan"))

        for channel_index, (attr_name, _, _, _) in enumerate(MEDIA_SS_SPECS):
            connect(
                _exposed_iface(getattr(self, attr_name), "_top_wrap.m_chan_porting"),
                getattr(self.top_media_funnel, f"ch{channel_index}_chan"),
            )

        connect(_exposed_iface(self.gpu0_node, "_top_wrap.m_chan_porting"), self.left_top_funnel.ch0_chan)
        connect(_exposed_iface(self.cpu_node, "_top_wrap.m_chan_porting"), self.left_top_funnel.ch1_chan)
        _connect_funnel_output_to_channel(self.right_dsp_funnel, self.left_top_funnel, 2)
        _connect_funnel_output_to_channel(self.top_media_funnel, self.left_top_funnel, 3)
        connect(_exposed_iface(self.mcu_node, "_top_wrap.m_chan_porting"), self.left_top_funnel.ch4_chan)

        connect(self.left_top_funnel.m_chan_out, _exposed_iface(self.peri_node, "_top_wrap.s_chan_in_porting"))
        connect(self.left_top_funnel.m_chan_in,  _exposed_iface(self.peri_node, "_top_wrap.s_chan_out_porting"))
        connect(self.left_top_funnel.m_syncreq,  _exposed_iface(self.peri_node, "_top_wrap.s_syncreq_porting"))

        self.expose_unconnected_interfaces()

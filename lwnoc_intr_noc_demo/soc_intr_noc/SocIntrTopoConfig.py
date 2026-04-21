"""Shared topology constants for the SoC interrupt NoC demo."""

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

TOPO_ID = "soc_intr_ring_top"
UP_HARDEN_ID = "soc_intr_ring_noc_up_harden_wrap"
DN_HARDEN_ID = "soc_intr_ring_noc_dn_harden_wrap"
HARDEN_TOP_ID = "soc_intr_ring_top_pd"
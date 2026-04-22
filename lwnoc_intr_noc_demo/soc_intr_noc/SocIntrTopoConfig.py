"""Shared topology constants for the SoC interrupt NoC demo."""

from SocIntrTemplate import SOC_INTR_RING_NODE_NUM


def _endpoint(kind: str, name: str, domain: str, node_id: int) -> dict[str, object]:
    return {
        "kind": kind,
        "name": name,
        "domain": domain,
        "node_id": node_id,
    }


def _inline(kind: str, name: str, domain: str) -> dict[str, object]:
    return {
        "kind": kind,
        "name": name,
        "domain": domain,
    }


def _async_cut(name: str, src_domain: str, dst_domain: str) -> dict[str, object]:
    return {
        "kind": "async",
        "name": name,
        "src_domain": src_domain,
        "dst_domain": dst_domain,
    }


INVALID_TGTID_SINK_NODE_ID = SOC_INTR_RING_NODE_NUM

RING_PLAN: list[dict[str, object]] = [
    _endpoint("iniu", "cpu_ss_iniu", "a", 0),
    _endpoint("tniu", "cpu_ss_tniu", "a", 1),
    _endpoint("iniu", "audio_ss_iniu", "a", 2),
    _endpoint("tniu", "peri_ss_tniu", "a", 3),
    _endpoint("iniu", "gpu_ss1_iniu", "a", 4),
    _endpoint("tniu", "gpu_ss0_tniu", "a", 5),
    _endpoint("tniu", "display_ss_tniu", "a", 6),
    _endpoint("iniu", "dp_ss_iniu", "a", 7),
    _endpoint("iniu", "ddr6_iniu", "a", 8),
    _endpoint("iniu", "ddr7_iniu", "a", 9),
    _endpoint("iniu", "ddr8_iniu", "a", 10),
    _endpoint("iniu", "ddr9_iniu", "a", 11),
    _endpoint("iniu", "ddr10_iniu", "a", 12),
    _endpoint("tniu", "ddr11_tniu", "a", 13),
    _async_cut("ring_async_cut_up_to_dn", "a", "b"),
    _endpoint("iniu", "mipi_ss_iniu", "b", 14),
    _endpoint("iniu", "ufs_ss_iniu", "b", 15),
    _endpoint("tniu", "camera_ss_tniu", "b", 16),
    _endpoint("iniu", "camera_ss_iniu", "b", 17),
    _endpoint("iniu", "pcie_eth_ss_iniu", "b", 19),
    _endpoint("iniu", "debug_ss_iniu", "b", 20),
    _endpoint("iniu", "aon_ss_iniu", "b", 21),
    _endpoint("tniu", "aon_ss_tniu", "b", 22),
    _endpoint("iniu", "ucie_ss1_iniu", "b", 23),
    _endpoint("tniu", "ucie_ss1_tniu", "b", 24),
    _endpoint("iniu", "dspss5_iniu", "b", 25),
    _endpoint("sink", "default_tgtid_sink", "b", INVALID_TGTID_SINK_NODE_ID),
    _inline("sp", "dspss5_sp", "b"),
    _endpoint("iniu", "vpu_ss_iniu", "b", 18),
    _endpoint("tniu", "dspss4_tniu", "b", 26),
    _endpoint("iniu", "dspss3_iniu", "b", 27),
    _endpoint("tniu", "dspss2_tniu", "b", 28),
    _endpoint("iniu", "dspss1_iniu", "b", 29),
    _endpoint("tniu", "dspss0_tniu", "b", 30),
    _endpoint("iniu", "ddr0_iniu", "b", 31),
    _endpoint("iniu", "ddr1_iniu", "b", 32),
    _endpoint("iniu", "ddr2_iniu", "b", 33),
    _endpoint("iniu", "ddr3_iniu", "b", 34),
    _endpoint("iniu", "ddr4_iniu", "b", 35),
    _endpoint("iniu", "ddr5_iniu", "b", 36),
    _endpoint("iniu", "ucie_ss0_iniu", "b", 37),
    _endpoint("tniu", "ucie_ss0_tniu", "b", 38),
    _async_cut("ring_async_cut_dn_to_up", "b", "a"),
]

UP_RING_PLAN = [entry for entry in RING_PLAN if entry.get("domain") == "a"]
DN_RING_PLAN = [entry for entry in RING_PLAN if entry.get("domain") == "b"]
ASYNC_CUT_PLAN = [entry for entry in RING_PLAN if entry["kind"] == "async"]

INIU_COUNT = sum(1 for entry in RING_PLAN if entry["kind"] == "iniu")
TNIU_COUNT = sum(1 for entry in RING_PLAN if entry["kind"] == "tniu")

TOPO_ID = "soc_intr_ring_top"
UP_HARDEN_ID = "soc_intr_ring_noc_up_harden_wrap"
DN_HARDEN_ID = "soc_intr_ring_noc_dn_harden_wrap"
HARDEN_TOP_ID = "soc_intr_ring_top_pd"
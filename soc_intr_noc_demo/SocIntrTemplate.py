"""TemplateIPConfig definitions for the SoC-scale interrupt ring NoC demo."""

import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
INTR_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"
RING_NETWORK_ROOT = REPO_ROOT / "subs" / "lwnoc_ring_network" / "de" / "rtl"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


os.environ["INTR_NOC_DIR"] = str(INTR_NOC_ROOT)
os.environ["INTR_NOC_STANDALONE_DIR"] = "/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc"
os.environ["INTR_NOC_DEMO_DIR"] = str(THIS_DIR)
os.environ["INTR_NOC_NETWORK_DIR"] = str(RING_NETWORK_ROOT)
os.environ["LWNOC_LOWPOWER_COMPONENT"] = str(INTR_NOC_ROOT / "lwnoc_lowpower_component")


FILELIST_DIR = THIS_DIR / "filelist"


INIU_NODE_NAMES = [
    "cpu_ss_iniu",
    "ucie_ss0_iniu",
    "audio_ss_iniu",
    "gpu_ss1_iniu",
    "dp_ss_iniu",
    "ddr6_iniu",
    "ddr7_iniu",
    "ddr8_iniu",
    "ddr9_iniu",
    "ddr10_iniu",
    "mipi_ss_iniu",
    "ufs_ss_iniu",
    "camera_ss_iniu",
    "vpu_ss_iniu",
    "debug_ss_iniu",
    "aon_ss_iniu",
    "ucie_ss1_iniu",
    "dspss5_iniu",
    "dspss3_iniu",
    "dspss1_iniu",
    "ddr0_iniu",
    "ddr1_iniu",
    "ddr2_iniu",
    "ddr3_iniu",
    "ddr4_iniu",
    "ddr5_iniu",
    "pcie_eth_ss_iniu",
]

TNIU_NODE_NAMES = [
    "cpu_ss_tniu",
    "ucie_ss0_tniu",
    "peri_ss_tniu",
    "gpu_ss0_tniu",
    "display_ss_tniu",
    "ddr11_tniu",
    "camera_ss_tniu",
    "aon_ss_tniu",
    "ucie_ss1_tniu",
    "dspss0_tniu",
    "dspss2_tniu",
    "dspss4_tniu",
]


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


def _to_env_token(node_name: str) -> str:
    return node_name.upper().replace("-", "_")


INIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {}
for node_name in INIU_NODE_NAMES:
    cfg = _new_cfg(
        name=f"{node_name}_sys",
        prefix=f"{node_name}_",
        filelist_name="intr_iniu_sys.f",
        env_var=f"SOC_INTR_{_to_env_token(node_name)}_SYS_OUT_DIR",
    )
    INIU_SYS_CONFIGS[node_name] = cfg


TNIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {}
for node_name in TNIU_NODE_NAMES:
    cfg = _new_cfg(
        name=f"{node_name}_sys",
        prefix=f"{node_name}_",
        filelist_name="intr_tniu_sys.f",
        env_var=f"SOC_INTR_{_to_env_token(node_name)}_SYS_OUT_DIR",
    )
    TNIU_SYS_CONFIGS[node_name] = cfg


soc_intr_iniu_top_config = _new_cfg(
    name="intr_iniu_top_side",
    prefix="intr_iniu_top_",
    filelist_name="intr_iniu_top.f",
    env_var="INTR_INIU_TOP_OUT_DIR",
)

soc_intr_tniu_top_config = _new_cfg(
    name="intr_tniu_top_side",
    prefix="intr_tniu_top_",
    filelist_name="intr_tniu_top.f",
    env_var="INTR_TNIU_TOP_OUT_DIR",
)

soc_intr_ring_network_config = _new_cfg(
    name="intr_ring_network",
    prefix="intr_ring_network_",
    filelist_name="intr_ring_network_wrap.f",
    env_var="INTR_RING_NETWORK_OUT_DIR",
)

soc_intr_ring_buf_config = _new_cfg(
    name="intr_ring_buf",
    prefix="intr_ring_buf_",
    filelist_name="intr_ring_buf_wrap.f",
    env_var="INTR_RING_BUF_OUT_DIR",
)

soc_intr_ring_station_config = _new_cfg(
    name="intr_ring_station",
    prefix="intr_ring_station_",
    filelist_name="intr_ring_station.f",
    env_var="INTR_RING_STATION_OUT_DIR",
)

soc_intr_ring_link_config = _new_cfg(
    name="intr_ring_link",
    prefix="intr_ring_link_",
    filelist_name="intr_ring_link.f",
    env_var="INTR_RING_LINK_OUT_DIR",
)

soc_intr_ring_req_sink_config = _new_cfg(
    name="intr_ring_req_sink",
    prefix="intr_ring_req_sink_",
    filelist_name="intr_ring_req_sink.f",
    env_var="INTR_RING_REQ_SINK_OUT_DIR",
)

soc_intr_ring_req_zero_source_config = _new_cfg(
    name="intr_ring_req_zero_source",
    prefix="intr_ring_req_zero_source_",
    filelist_name="intr_ring_req_zero_source.f",
    env_var="INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
)
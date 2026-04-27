"""TemplateIPConfig definitions for the SoC-scale interrupt ring NoC demo."""

import os
import shutil
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parents[1]
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
os.environ["INTERRUPT_INIU"] = str(INTR_NOC_ROOT)
os.environ["INTERRUPT_TNIU"] = str(INTR_NOC_ROOT)
os.environ["FCIP_DIR"] = str(INTR_NOC_ROOT / "fcip")
os.environ["LWNOC_LOWPOWER_COMPONENT"] = str(INTR_NOC_ROOT / "lwnoc_lowpower_component")
os.environ["lwnoc_lowpower_component"] = str(INTR_NOC_ROOT / "lwnoc_lowpower_component")


FILELIST_DIR = THIS_DIR / "filelist"
USE_SUBS_VC_FILELIST_MODE = os.environ.get("SOC_INTR_USE_SUBS_VC_FILELIST", "1") == "1"

# Map publish filelist names to submodule vc/ counterparts.
# Publishes use submodule source filelists directly (not synthesized).
_VC_FILELIST_MAP: dict[str, str] = {
    "intr_iniu_sys.f":         "iniu_filelist.f",
    "intr_tniu_sys.f":         "tniu_filelist.f",
    "intr_iniu_top.f":         "iniu_top.f",
    "intr_tniu_top.f":         "tniu_top.f",
    "intr_ring_network_wrap.f":"network_filelist.f",
    "intr_ring_buf_wrap.f":    "network_filelist.f",
    "intr_ring_station.f":     "network_filelist.f",
    "intr_ring_link.f":        "network_filelist.f",
    "intr_ring_req_sink.f":    "network_filelist.f",
    "intr_ring_req_zero_source.f":"network_filelist.f",
}


def _resolve_fl(name: str) -> str:
    # Sys-side filelists need LP package wrappers for VComponent type resolution
    # (memnoc pattern: filelist is self-contained). Use local filelist when it
    # exists in the demo's filelist/ directory.
    local_path = FILELIST_DIR / name
    if local_path.exists():
        return str(local_path)
    if USE_SUBS_VC_FILELIST_MODE:
        vc_name = _VC_FILELIST_MAP.get(name, name)
        return str(INTR_NOC_ROOT / "vc" / vc_name)
    return str(FILELIST_DIR / name)


def _effective_prefix(prefix: str, filelist_name: str) -> str:
    if not USE_SUBS_VC_FILELIST_MODE:
        return prefix
    plain_lists = {
        "intr_iniu_top.f",
        "intr_tniu_top.f",
        "intr_ring_network_wrap.f",
        "intr_ring_buf_wrap.f",
        "intr_ring_station.f",
        "intr_ring_link.f",
        "intr_ring_req_sink.f",
        "intr_ring_req_zero_source.f",
    }
    if filelist_name in plain_lists:
        return ""

    # Keep sys-side naming source-owned: per-ss TemplateIP prefixes should be
    # applied by ip_builder at generation time (memnoc-style flow).
    return prefix


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=_resolve_fl(filelist_name),
        env_var=env_var,
    )


INIU_ASYNC_FIFO_DEPTH = 16
TNIU_ASYNC_FIFO_DEPTH = 10
SOC_INTR_REQ_PLD_WIDTH = 40
SOC_INTR_REQ_ID_WIDTH = 8
SOC_INTR_REQ_QOS_WIDTH = 4


# ── Explicit per-SS-type config declarations (memnoc-style) ────────────

# INIU sys-side configs (14 types)
cpu_ss_iniu_cfg = _new_cfg(name="cpu_ss_iniu_sys",     prefix="cpu_ss_iniu_",   filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_CPU_SS_INIU_SYS_OUT_DIR")
cpu_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
cpu_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

ucie_ss_iniu_cfg = _new_cfg(name="ucie_ss_iniu_sys",    prefix="ucie_ss_iniu_",  filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_UCIE_SS_INIU_SYS_OUT_DIR")
ucie_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
ucie_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

audio_ss_iniu_cfg = _new_cfg(name="audio_ss_iniu_sys",   prefix="audio_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_AUDIO_SS_INIU_SYS_OUT_DIR")
audio_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
audio_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

gpu_ss_iniu_cfg = _new_cfg(name="gpu_ss_iniu_sys",     prefix="gpu_ss_iniu_",   filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_GPU_SS_INIU_SYS_OUT_DIR")
gpu_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
gpu_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

dp_ss_iniu_cfg = _new_cfg(name="dp_ss_iniu_sys",       prefix="dp_ss_iniu_",    filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DP_SS_INIU_SYS_OUT_DIR")
dp_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
dp_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

ddr_iniu_cfg = _new_cfg(name="ddr_iniu_sys",           prefix="ddr_iniu_",      filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DDR_INIU_SYS_OUT_DIR")
ddr_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
ddr_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

mipi_ss_iniu_cfg = _new_cfg(name="mipi_ss_iniu_sys",    prefix="mipi_ss_iniu_",  filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_MIPI_SS_INIU_SYS_OUT_DIR")
mipi_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
mipi_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

ufs_ss_iniu_cfg = _new_cfg(name="ufs_ss_iniu_sys",      prefix="ufs_ss_iniu_",   filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_UFS_SS_INIU_SYS_OUT_DIR")
ufs_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
ufs_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

camera_ss_iniu_cfg = _new_cfg(name="camera_ss_iniu_sys", prefix="camera_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_CAMERA_SS_INIU_SYS_OUT_DIR")
camera_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
camera_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

vpu_ss_iniu_cfg = _new_cfg(name="vpu_ss_iniu_sys",     prefix="vpu_ss_iniu_",   filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_VPU_SS_INIU_SYS_OUT_DIR")
vpu_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
vpu_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

debug_ss_iniu_cfg = _new_cfg(name="debug_ss_iniu_sys",   prefix="debug_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DEBUG_SS_INIU_SYS_OUT_DIR")
debug_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
debug_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

aon_ss_iniu_cfg = _new_cfg(name="aon_ss_iniu_sys",     prefix="aon_ss_iniu_",   filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_AON_SS_INIU_SYS_OUT_DIR")
aon_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
aon_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

dspss_iniu_cfg = _new_cfg(name="dspss_iniu_sys",        prefix="dspss_iniu_",    filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DSPSS_INIU_SYS_OUT_DIR")
dspss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
dspss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

pcie_eth_ss_iniu_cfg = _new_cfg(name="pcie_eth_ss_iniu_sys", prefix="pcie_eth_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_PCIE_ETH_SS_INIU_SYS_OUT_DIR")
pcie_eth_ss_iniu_cfg.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
pcie_eth_ss_iniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

# TNIU sys-side configs (9 types)
cpu_ss_tniu_cfg = _new_cfg(name="cpu_ss_tniu_sys",     prefix="cpu_ss_tniu_",   filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_CPU_SS_TNIU_SYS_OUT_DIR")
cpu_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
cpu_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

ucie_ss_tniu_cfg = _new_cfg(name="ucie_ss_tniu_sys",    prefix="ucie_ss_tniu_",  filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_UCIE_SS_TNIU_SYS_OUT_DIR")
ucie_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
ucie_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

peri_ss_tniu_cfg = _new_cfg(name="peri_ss_tniu_sys",    prefix="peri_ss_tniu_",  filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_PERI_SS_TNIU_SYS_OUT_DIR")
peri_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
peri_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

gpu_ss_tniu_cfg = _new_cfg(name="gpu_ss_tniu_sys",     prefix="gpu_ss_tniu_",   filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_GPU_SS_TNIU_SYS_OUT_DIR")
gpu_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
gpu_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

display_ss_tniu_cfg = _new_cfg(name="display_ss_tniu_sys", prefix="display_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_DISPLAY_SS_TNIU_SYS_OUT_DIR")
display_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
display_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

ddr_tniu_cfg = _new_cfg(name="ddr_tniu_sys",           prefix="ddr_tniu_",      filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_DDR_TNIU_SYS_OUT_DIR")
ddr_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
ddr_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

camera_ss_tniu_cfg = _new_cfg(name="camera_ss_tniu_sys", prefix="camera_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_CAMERA_SS_TNIU_SYS_OUT_DIR")
camera_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
camera_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

aon_ss_tniu_cfg = _new_cfg(name="aon_ss_tniu_sys",     prefix="aon_ss_tniu_",   filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_AON_SS_TNIU_SYS_OUT_DIR")
aon_ss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
aon_ss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

dspss_tniu_cfg = _new_cfg(name="dspss_tniu_sys",       prefix="dspss_tniu_",    filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_DSPSS_TNIU_SYS_OUT_DIR")
dspss_tniu_cfg.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
dspss_tniu_cfg.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

# ── Explicit node_name→config mapping (memnoc-style, no dict-of-dicts) ──
INIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {
    "cpu_ss_iniu":     cpu_ss_iniu_cfg,
    "ucie_ss0_iniu":   ucie_ss_iniu_cfg,
    "audio_ss_iniu":   audio_ss_iniu_cfg,
    "gpu_ss1_iniu":    gpu_ss_iniu_cfg,
    "dp_ss_iniu":      dp_ss_iniu_cfg,
    "ddr6_iniu":       ddr_iniu_cfg,
    "ddr7_iniu":       ddr_iniu_cfg,
    "ddr8_iniu":       ddr_iniu_cfg,
    "ddr9_iniu":       ddr_iniu_cfg,
    "ddr10_iniu":      ddr_iniu_cfg,
    "mipi_ss_iniu":    mipi_ss_iniu_cfg,
    "ufs_ss_iniu":     ufs_ss_iniu_cfg,
    "camera_ss_iniu":  camera_ss_iniu_cfg,
    "vpu_ss_iniu":     vpu_ss_iniu_cfg,
    "debug_ss_iniu":   debug_ss_iniu_cfg,
    "aon_ss_iniu":     aon_ss_iniu_cfg,
    "ucie_ss1_iniu":   ucie_ss_iniu_cfg,
    "dspss5_iniu":     dspss_iniu_cfg,
    "dspss3_iniu":     dspss_iniu_cfg,
    "dspss1_iniu":     dspss_iniu_cfg,
    "ddr0_iniu":       ddr_iniu_cfg,
    "ddr1_iniu":       ddr_iniu_cfg,
    "ddr2_iniu":       ddr_iniu_cfg,
    "ddr3_iniu":       ddr_iniu_cfg,
    "ddr4_iniu":       ddr_iniu_cfg,
    "ddr5_iniu":       ddr_iniu_cfg,
    "pcie_eth_ss_iniu": pcie_eth_ss_iniu_cfg,
}

TNIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {
    "cpu_ss_tniu":     cpu_ss_tniu_cfg,
    "ucie_ss0_tniu":   ucie_ss_tniu_cfg,
    "peri_ss_tniu":    peri_ss_tniu_cfg,
    "gpu_ss0_tniu":    gpu_ss_tniu_cfg,
    "display_ss_tniu": display_ss_tniu_cfg,
    "ddr11_tniu":      ddr_tniu_cfg,
    "camera_ss_tniu":  camera_ss_tniu_cfg,
    "aon_ss_tniu":     aon_ss_tniu_cfg,
    "ucie_ss1_tniu":   ucie_ss_tniu_cfg,
    "dspss0_tniu":     dspss_tniu_cfg,
    "dspss2_tniu":     dspss_tniu_cfg,
    "dspss4_tniu":     dspss_tniu_cfg,
}

SOC_INTR_RING_NODE_NUM = len(INIU_SYS_CONFIGS) + len(TNIU_SYS_CONFIGS)


soc_intr_iniu_top_config = _new_cfg(
    name="intr_iniu_top_side",
    prefix="intr_iniu_top_",
    filelist_name="intr_iniu_top.f",
    env_var="INTR_INIU_TOP_OUT_DIR",
)
soc_intr_iniu_top_config.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
soc_intr_iniu_top_config.param_overrides = {"ASYNC_FIFO_DEPTH": INIU_ASYNC_FIFO_DEPTH}

soc_intr_tniu_top_config = _new_cfg(
    name="intr_tniu_top_side",
    prefix="intr_tniu_top_",
    filelist_name="intr_tniu_top.f",
    env_var="INTR_TNIU_TOP_OUT_DIR",
)
soc_intr_tniu_top_config.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
soc_intr_tniu_top_config.param_overrides = {"ASYNC_FIFO_DEPTH": TNIU_ASYNC_FIFO_DEPTH}

soc_intr_ring_network_config = _new_cfg(
    name="intr_ring_network",
    prefix="intr_ring_network_",
    filelist_name="intr_ring_network_wrap.f",
    env_var="INTR_RING_NETWORK_OUT_DIR",
)
soc_intr_ring_network_config.set_macro("PLD_WIDTH", SOC_INTR_REQ_PLD_WIDTH)
soc_intr_ring_network_config.set_macro("ID_WIDTH", SOC_INTR_REQ_ID_WIDTH)
soc_intr_ring_network_config.set_macro("QOS_WIDTH", SOC_INTR_REQ_QOS_WIDTH)
soc_intr_ring_network_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_network_config.param_overrides = {
    "PLD_WIDTH": SOC_INTR_REQ_PLD_WIDTH,
    "ID_WIDTH": SOC_INTR_REQ_ID_WIDTH,
    "QOS_WIDTH": SOC_INTR_REQ_QOS_WIDTH,
    "NODE_NUM": SOC_INTR_RING_NODE_NUM,
}

soc_intr_ring_buf_config = _new_cfg(
    name="intr_ring_buf",
    prefix="",
    filelist_name="intr_ring_buf_wrap.f",
    env_var="INTR_RING_BUF_OUT_DIR",
)
soc_intr_ring_buf_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
_INTR_RING_BUF_PARAMS = {
    "PLD_WIDTH": SOC_INTR_REQ_PLD_WIDTH,
    "ID_WIDTH": SOC_INTR_REQ_ID_WIDTH,
    "QOS_WIDTH": SOC_INTR_REQ_QOS_WIDTH,
    "NODE_NUM": SOC_INTR_RING_NODE_NUM,
}
soc_intr_ring_buf_config.param_overrides = dict(_INTR_RING_BUF_PARAMS)

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
    prefix="",
    filelist_name="intr_ring_req_sink.f",
    env_var="INTR_RING_REQ_SINK_OUT_DIR",
)
soc_intr_ring_req_sink_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_req_sink_config.param_overrides = dict(_INTR_RING_BUF_PARAMS)

soc_intr_ring_req_zero_source_config = _new_cfg(
    name="intr_ring_req_zero_source",
    prefix="",
    filelist_name="intr_ring_req_zero_source.f",
    env_var="INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
)
soc_intr_ring_req_zero_source_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_req_zero_source_config.param_overrides = dict(_INTR_RING_BUF_PARAMS)
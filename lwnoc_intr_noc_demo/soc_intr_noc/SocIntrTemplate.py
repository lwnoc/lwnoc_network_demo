"""TemplateIPConfig definitions for the SoC-scale interrupt ring NoC demo."""

import os
import shutil
import sys
from pathlib import Path

from _project_env import LWNOC_TOPO_ROOT, REPO_ROOT, THIS_DIR

# ═══════════════════════════════════════════════════════════════════════════════
# PATHS — edit these to match your environment, or leave ""
#         and set the corresponding env var instead.
# ═══════════════════════════════════════════════════════════════════════════════
_HARDCODED_PATHS = {
    "INTR_NOC_DIR":            "",   # e.g. "/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc"
    "INTR_NOC_NETWORK_DIR":    "",
    "FCIP_DIR":                "",
    "LWNOC_LOWPOWER_COMPONENT": "",
}


def _resolve_path(name: str) -> Path:
    """Use hardcoded path if set, else env var, else error."""
    hard = _HARDCODED_PATHS.get(name, "").strip()
    if hard:
        return Path(hard)
    val = os.environ.get(name)
    if val:
        return Path(val)
    print(f"[ERROR] ${name} is not set in your shell or in _HARDCODED_PATHS.")
    print(f"  bash:  export {name}=<absolute/path>")
    print(f"  csh:   setenv {name} <absolute/path>")
    raise SystemExit(f"Missing path for: {name}")


INTR_NOC_ROOT = _resolve_path("INTR_NOC_DIR")
RING_NETWORK_ROOT = _resolve_path("INTR_NOC_NETWORK_DIR")
FCIP_DIR = _resolve_path("FCIP_DIR")
LWNOC_LOWPOWER_COMPONENT = _resolve_path("LWNOC_LOWPOWER_COMPONENT")

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


BUILD_LOGIC_DIR = THIS_DIR / "build_logic"

# export derived paths for downstream consumers
for _k, _v in (("INTR_NOC_DIR", INTR_NOC_ROOT),
               ("INTR_NOC_NETWORK_DIR", RING_NETWORK_ROOT),
               ("FCIP_DIR", FCIP_DIR),
               ("LWNOC_LOWPOWER_COMPONENT", LWNOC_LOWPOWER_COMPONENT),
               ("lwnoc_lowpower_component", LWNOC_LOWPOWER_COMPONENT),
               ("INTERRUPT_INIU", INTR_NOC_ROOT),
               ("INTERRUPT_TNIU", INTR_NOC_ROOT)):
    os.environ.setdefault(_k, str(_v))


FILELIST_DIR = THIS_DIR / "filelist"  # demo-local overrides (optional, may not exist)
USE_SUBS_VC_FILELIST_MODE = os.environ.get("SOC_INTR_USE_SUBS_VC_FILELIST", "1") == "1"

# Map publish filelist names to submodule vc/ counterparts.
# Publishes use submodule source filelists directly (not synthesized).
# *_comp.f variants include foundation IP (FCIP + LP) — prefer them over bare *_filelist.f.
_VC_FILELIST_MAP: dict[str, str] = {
    "intr_iniu_sys.f":         "iniu_comp.f",
    "intr_tniu_sys.f":         "tniu_comp.f",
    "intr_iniu_top.f":         "iniu_comp.f",
    "intr_tniu_top.f":         "tniu_comp.f",
    # Network per-wrapper pub files — each contains ONLY its own leaf RTL.
    # Common primitives come from network_common_pub.f (compile-once).
    "intr_iniu_endpoint_wrap.f":"network_wrappers_pub.f",
    "intr_tniu_endpoint_wrap.f":"network_wrappers_pub.f",
    "intr_ring_network_wrap.f":"network_wrappers_pub.f",
    "intr_ring_buf_wrap.f":    "network_wrappers_pub.f",
    "intr_req_rs_wrap.f":      "network_wrappers_pub.f",
    "intr_ring_station.f":     "network_wrappers_pub.f",
    "intr_ring_link.f":        "network_wrappers_pub.f",
    "intr_ring_req_sink.f":    "network_req_sink_pub.f",
    "intr_ring_req_zero_source.f":"network_wrappers_pub.f",
    # network_common is a shared ingress — all wrappers share one copy.
    "network_common_pub.f":    "network_common_pub.f",
}





def _resolve_fl(name: str) -> str:
    # Prefer submodule *_comp.f filelists which already include foundation IP
    # (FCIP + LP).  Only fall back to a local override when the file actually
    # exists in the demo filelist/ directory.
    local_path = FILELIST_DIR / name
    if local_path.exists():
        return str(local_path)
    if USE_SUBS_VC_FILELIST_MODE:
        vc_name = _VC_FILELIST_MAP.get(name, name)
        if name.startswith("intr_iniu") or name.startswith("intr_tniu"):
            return str(INTR_NOC_ROOT / "vc" / vc_name)
        return str(INTR_NOC_ROOT / "vc" / vc_name)
    return str(FILELIST_DIR / name)


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=_resolve_fl(filelist_name),
        env_var=env_var,
    )


SOC_INTR_REQ_PLD_WIDTH = 40
SOC_INTR_REQ_ID_WIDTH = 8
SOC_INTR_REQ_QOS_WIDTH = 4
SOC_INTR_ASYNC_FIFO_DEPTH = 16


def _apply_cfg_params(cfg: TemplateIPConfig, *, param_overrides: dict | None = None, macros: dict | None = None) -> TemplateIPConfig:
    if param_overrides is not None:
        cfg.param_overrides = dict(param_overrides)
    for macro_name, macro_value in (macros or {}).items():
        cfg.set_macro(macro_name, macro_value)
    return cfg


def _unique_cfgs(cfgs):
    seen = set()
    unique = []
    for cfg in cfgs:
        key = id(cfg)
        if key not in seen:
            seen.add(key)
            unique.append(cfg)
    return unique


# ── Explicit per-SS-type config declarations (memnoc-style) ────────────

# INIU sys-side configs
cpu_ss_iniu_cfg = _new_cfg(name="cpu_ss_iniu_sys", prefix="cpu_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_CPU_SS_INIU_SYS_OUT_DIR")

npu_ss_iniu_cfg = _new_cfg(name="npu_ss_iniu_sys", prefix="npu_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_NPU_SS_INIU_SYS_OUT_DIR")

gpu_ss_iniu_cfg = _new_cfg(name="gpu_ss_iniu_sys", prefix="gpu_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_GPU_SS_INIU_SYS_OUT_DIR")

mipi_ss_iniu_cfg = _new_cfg(name="mipi_ss_iniu_sys", prefix="mipi_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_MIPI_SS_INIU_SYS_OUT_DIR")

dp_ss_iniu_cfg = _new_cfg(name="dp_ss_iniu_sys", prefix="dp_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DP_SS_INIU_SYS_OUT_DIR")

display_ss_iniu_cfg = _new_cfg(name="display_ss_iniu_sys", prefix="display_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DISPLAY_SS_INIU_SYS_OUT_DIR")

vpu_ss_iniu_cfg = _new_cfg(name="vpu_ss_iniu_sys", prefix="vpu_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_VPU_SS_INIU_SYS_OUT_DIR")

aon_ss_iniu_cfg = _new_cfg(name="aon_ss_iniu_sys", prefix="aon_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_AON_SS_INIU_SYS_OUT_DIR")

dsp_ss_iniu_cfg = _new_cfg(name="dsp_ss_iniu_sys", prefix="dsp_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DSP_SS_INIU_SYS_OUT_DIR")

ddr_iniu_cfg = _new_cfg(name="ddr_iniu_sys", prefix="ddr_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_DDR_INIU_SYS_OUT_DIR")

ufs_ss_iniu_cfg = _new_cfg(name="ufs_ss_iniu_sys", prefix="ufs_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_UFS_SS_INIU_SYS_OUT_DIR")

camera_ss_iniu_cfg = _new_cfg(name="camera_ss_iniu_sys", prefix="camera_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_CAMERA_SS_INIU_SYS_OUT_DIR")

pcie_eth_ss_iniu_cfg = _new_cfg(name="pcie_eth_ss_iniu_sys", prefix="pcie_eth_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_PCIE_ETH_SS_INIU_SYS_OUT_DIR")

peri_ss_iniu_cfg = _new_cfg(name="peri_ss_iniu_sys", prefix="peri_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_PERI_SS_INIU_SYS_OUT_DIR")

mcu_ss_iniu_cfg = _new_cfg(name="mcu_ss_iniu_sys", prefix="mcu_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_MCU_SS_INIU_SYS_OUT_DIR")

noc_ss_iniu_cfg = _new_cfg(name="noc_ss_iniu_sys", prefix="noc_ss_iniu_", filelist_name="intr_iniu_sys.f", env_var="SOC_INTR_NOC_SS_INIU_SYS_OUT_DIR")

# TNIU sys-side configs
cpu_ss_tniu_cfg = _new_cfg(name="cpu_ss_tniu_sys", prefix="cpu_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_CPU_SS_TNIU_SYS_OUT_DIR")

npu_ss_tniu_cfg = _new_cfg(name="npu_ss_tniu_sys", prefix="npu_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_NPU_SS_TNIU_SYS_OUT_DIR")

aon_ss_tniu_cfg = _new_cfg(name="aon_ss_tniu_sys", prefix="aon_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_AON_SS_TNIU_SYS_OUT_DIR")

dsp_ss_tniu_cfg = _new_cfg(name="dsp_ss_tniu_sys", prefix="dsp_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_DSP_SS_TNIU_SYS_OUT_DIR")

mcu_ss_tniu_cfg = _new_cfg(name="mcu_ss_tniu_sys", prefix="mcu_ss_tniu_", filelist_name="intr_tniu_sys.f", env_var="SOC_INTR_MCU_SS_TNIU_SYS_OUT_DIR")

# Explicit node_name -> config mapping
INIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {
    "cpu_ss_iniu": cpu_ss_iniu_cfg,
    "npu_ss0_iniu": npu_ss_iniu_cfg,
    "npu_ss1_iniu": npu_ss_iniu_cfg,
    "npu_ss2_iniu": npu_ss_iniu_cfg,
    "npu_ss3_iniu": npu_ss_iniu_cfg,
    "npu_ss4_iniu": npu_ss_iniu_cfg,
    "gpu_ss0_iniu": gpu_ss_iniu_cfg,
    "gpu_ss1_iniu": gpu_ss_iniu_cfg,
    "mipi_ss_iniu": mipi_ss_iniu_cfg,
    "dp_ss_iniu": dp_ss_iniu_cfg,
    "display_ss_iniu": display_ss_iniu_cfg,
    "vpu_ss_iniu": vpu_ss_iniu_cfg,
    "aon_ss_iniu": aon_ss_iniu_cfg,
    "dsp_ss0_iniu": dsp_ss_iniu_cfg,
    "dsp_ss1_iniu": dsp_ss_iniu_cfg,
    "dsp_ss2_iniu": dsp_ss_iniu_cfg,
    "dsp_ss3_iniu": dsp_ss_iniu_cfg,
    "dsp_ss4_iniu": dsp_ss_iniu_cfg,
    "dsp_ss5_iniu": dsp_ss_iniu_cfg,
    "ddr0_iniu": ddr_iniu_cfg,
    "ddr1_iniu": ddr_iniu_cfg,
    "ddr2_iniu": ddr_iniu_cfg,
    "ddr3_iniu": ddr_iniu_cfg,
    "ddr4_iniu": ddr_iniu_cfg,
    "ddr5_iniu": ddr_iniu_cfg,
    "ddr6_iniu": ddr_iniu_cfg,
    "ddr7_iniu": ddr_iniu_cfg,
    "ddr8_iniu": ddr_iniu_cfg,
    "ddr9_iniu": ddr_iniu_cfg,
    "ddr10_iniu": ddr_iniu_cfg,
    "ddr11_iniu": ddr_iniu_cfg,
    "noc_ss_iniu": noc_ss_iniu_cfg,
    "peri_ss_iniu": peri_ss_iniu_cfg,
    "camera_ss_iniu": camera_ss_iniu_cfg,
    "ufs_ss_iniu": ufs_ss_iniu_cfg,
    "pcie_eth_ss_iniu": pcie_eth_ss_iniu_cfg,
    "mcu_ss_iniu": mcu_ss_iniu_cfg,
}

TNIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {
    "cpu_ss_tniu": cpu_ss_tniu_cfg,
    "npu_ss0_tniu": npu_ss_tniu_cfg,
    "npu_ss1_tniu": npu_ss_tniu_cfg,
    "npu_ss2_tniu": npu_ss_tniu_cfg,
    "npu_ss3_tniu": npu_ss_tniu_cfg,
    "npu_ss4_tniu": npu_ss_tniu_cfg,
    "aon_ss_tniu": aon_ss_tniu_cfg,
    "dsp_ss0_tniu": dsp_ss_tniu_cfg,
    "dsp_ss1_tniu": dsp_ss_tniu_cfg,
    "dsp_ss2_tniu": dsp_ss_tniu_cfg,
    "dsp_ss3_tniu": dsp_ss_tniu_cfg,
    "dsp_ss4_tniu": dsp_ss_tniu_cfg,
    "dsp_ss5_tniu": dsp_ss_tniu_cfg,
    "mcu_ss_tniu": mcu_ss_tniu_cfg,
}

SOC_INTR_RING_NODE_NUM = len(INIU_SYS_CONFIGS) + len(TNIU_SYS_CONFIGS)
SOC_INTR_RING_TOTAL_NODE_NUM = SOC_INTR_RING_NODE_NUM + 1

_SOC_INTR_RING_PARAM_OVERRIDES = {
    "PLD_WIDTH": SOC_INTR_REQ_PLD_WIDTH,
    "ID_WIDTH": SOC_INTR_REQ_ID_WIDTH,
    "QOS_WIDTH": SOC_INTR_REQ_QOS_WIDTH,
    "NODE_NUM": SOC_INTR_RING_TOTAL_NODE_NUM,
}

_SOC_INTR_NETWORK_MACROS = {
    "INTR_NETWORK_RING_PLD_WIDTH": SOC_INTR_REQ_PLD_WIDTH,
    "INTR_NETWORK_RING_ID_WIDTH": SOC_INTR_REQ_ID_WIDTH,
    "INTR_NETWORK_RING_QOS_WIDTH": SOC_INTR_REQ_QOS_WIDTH,
    "INTR_NETWORK_RING_NODE_NUM": SOC_INTR_RING_TOTAL_NODE_NUM,
    "INTR_NETWORK_ENDPOINT_PLD_WIDTH": SOC_INTR_REQ_PLD_WIDTH,
    "INTR_NETWORK_ENDPOINT_ID_WIDTH": SOC_INTR_REQ_ID_WIDTH,
    "INTR_NETWORK_ENDPOINT_QOS_WIDTH": SOC_INTR_REQ_QOS_WIDTH,
    "INTR_NETWORK_ENDPOINT_NODE_NUM": SOC_INTR_RING_TOTAL_NODE_NUM,
    "INTR_NETWORK_FLOW_CTRL_NODE_NUM": SOC_INTR_RING_TOTAL_NODE_NUM,
    "INTR_NETWORK_SINK_EN": '1\'b1',
    "INTR_NETWORK_DUMMY_EN": '1\'b1',
    "INTR_NETWORK_RING_THRESHOLD_EN": '1\'b1',
    "INTR_NETWORK_RING_SINGLE_THR_WIDTH": 1,
    "INTR_NETWORK_RING_SYNC_LEVEL": 3,
    "INTR_NETWORK_RING_AFIFO_DEP": 8,
    "INTR_NETWORK_RING_ERR_INT_CNT_WIDTH": 16,
    "INTR_NETWORK_ENDPOINT_RING_ID": 0,
    "INTR_NETWORK_ENDPOINT_HAS_INIU": '1\'b1',
    "INTR_NETWORK_ENDPOINT_HAS_TNIU": '1\'b1',
    "INTR_NETWORK_STATION_VC_BUF_DEPTH": 32,
    "INTR_NETWORK_STATION_VC_AFULL_LEVEL": 4,
}

_SOC_INTR_INIU_ASYNC_MACROS = {
    "INTR_INIU_SYS_ASYNC_FIFO_DEPTH": SOC_INTR_ASYNC_FIFO_DEPTH,
    "INTR_INIU_TOP_ASYNC_FIFO_DEPTH": SOC_INTR_ASYNC_FIFO_DEPTH,
}

_SOC_INTR_TNIU_ASYNC_MACROS = {
    "INTR_TNIU_SYS_ASYNC_FIFO_DEPTH": SOC_INTR_ASYNC_FIFO_DEPTH,
    "INTR_TNIU_TOP_ASYNC_FIFO_DEPTH": SOC_INTR_ASYNC_FIFO_DEPTH,
}


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
    prefix="",
    filelist_name="intr_ring_buf_wrap.f",
    env_var="INTR_RING_BUF_OUT_DIR",
)

soc_intr_iniu_endpoint_config = _new_cfg(
    name="intr_iniu_endpoint_wrap",
    prefix="",
    filelist_name="intr_iniu_endpoint_wrap.f",
    env_var="INTR_INIU_ENDPOINT_OUT_DIR",
)

soc_intr_tniu_endpoint_config = _new_cfg(
    name="intr_tniu_endpoint_wrap",
    prefix="",
    filelist_name="intr_tniu_endpoint_wrap.f",
    env_var="INTR_TNIU_ENDPOINT_OUT_DIR",
)

soc_intr_req_rs_config = _new_cfg(
    name="intr_req_rs_wrap",
    prefix="",
    filelist_name="intr_req_rs_wrap.f",
    env_var="INTR_REQ_RS_OUT_DIR",
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
    prefix="",
    filelist_name="intr_ring_req_sink.f",
    env_var="INTR_RING_REQ_SINK_OUT_DIR",
)

soc_intr_ring_req_zero_source_config = _new_cfg(
    name="intr_ring_req_zero_source",
    prefix="",
    filelist_name="intr_ring_req_zero_source.f",
    env_var="INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
)


for _cfg in _unique_cfgs(INIU_SYS_CONFIGS.values()):
    _apply_cfg_params(_cfg, macros=_SOC_INTR_INIU_ASYNC_MACROS)

for _cfg in _unique_cfgs(TNIU_SYS_CONFIGS.values()):
    _apply_cfg_params(_cfg, macros=_SOC_INTR_TNIU_ASYNC_MACROS)

_apply_cfg_params(soc_intr_iniu_top_config, macros=_SOC_INTR_INIU_ASYNC_MACROS)
_apply_cfg_params(soc_intr_tniu_top_config, macros=_SOC_INTR_TNIU_ASYNC_MACROS)

for _cfg in (
    soc_intr_ring_network_config,
    soc_intr_ring_buf_config,
    soc_intr_req_rs_config,
    soc_intr_iniu_endpoint_config,
    soc_intr_tniu_endpoint_config,
    soc_intr_ring_station_config,
    soc_intr_ring_link_config,
    soc_intr_ring_req_sink_config,
    soc_intr_ring_req_zero_source_config,
):
    _apply_cfg_params(
        _cfg,
        param_overrides=_SOC_INTR_RING_PARAM_OVERRIDES,
        macros=_SOC_INTR_NETWORK_MACROS,
    )
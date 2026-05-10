import os
from pathlib import Path
from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

THIS_DIR = Path(__file__).resolve().parent


def _env_path(name: str, default: Path) -> Path:
    return Path(os.environ.get(name, str(default))).expanduser()


SUBS_DIR = THIS_DIR.parent / "subs"
DEFAULT_ATB_ROOT = SUBS_DIR / "lwnoc_atb_noc"
ATB_ROOT = _env_path("ATB_SUBIP_ROOT", DEFAULT_ATB_ROOT)
RTL_PATH_ROOT = _env_path("RTL_PATH", ATB_ROOT)
ATB_INIU_ROOT = _env_path("ATB_INIU", ATB_ROOT)

# Filelist reference: use component-specific .f (not _comp.f) to keep
# publish directories clean. _comp.f includes common deps which causes
# ip_builder to spill shared RTL into every publish dir. Common deps
# are provided at the umbrella compile level.
VC_DIR = ATB_ROOT / "vc"

# ── Error-checked helper ─────────────────────────────────────────────────
def _vcf(name: str) -> str:
    """Resolve a vc/ filelist path. Raises FileNotFoundError if missing."""
    p = VC_DIR / name
    if not p.exists():
        raise FileNotFoundError(
            f"ATB submodule filelist not found: {p}\n"
            f"Expected at: {p}\n"
            f"Is ATB_SUBIP_ROOT={ATB_ROOT} correct?"
        )
    return str(p)


# Set env var for submodule vc/ filelists that use $RTL_PATH, $ATB_INIU etc.
os.environ.setdefault("RTL_PATH", str(RTL_PATH_ROOT))
os.environ.setdefault("ATB_INIU", str(ATB_INIU_ROOT))
os.environ.setdefault("ATB_SUBIP_ROOT", str(ATB_ROOT))
# LOWPOWER_PATH: needed for pchnl_ctrl enum types (lwnoc_pchannel_active_t/state_t).
# Set to subs/ path so _comp.f filelists can resolve the LP package.
DEFAULT_LP_SUB = SUBS_DIR / "lwnoc_lowpower_component"
LP_SUB = _env_path("LWNOC_LOWPOWER_COMPONENT", _env_path("LOWPOWER_PATH", DEFAULT_LP_SUB))
if LP_SUB.exists():
    os.environ.setdefault("LOWPOWER_PATH", str(LP_SUB))
    os.environ.setdefault("LWNOC_LOWPOWER_COMPONENT", str(LP_SUB))


# ── Shared parameter sets (DTI-style: param_overrides → set_macro()) ─────
_INIU_PARAMS = {
    "ATB_INIU_FIFO_DEPTH": 16,
    "ATB_INIU_AUTO_CLEAR_EN": 0,
    "ATB_INIU_SYNC_STAGE": 2,
    "ATB_INIU_SYNC_BUF_DEPTH": 2,
    "ATB_INIU_ERR_INT_CNT_WIDTH": 16,
}
_TNIU_PARAMS = {
    "ATB_TNIU_FIFO_DEPTH": 16,
    "ATB_TNIU_AUTO_CLEAR_EN": 0,
    "ATB_TNIU_SYNC_STAGE": 2,
    "ATB_TNIU_ERR_INT_CNT_WIDTH": 16,
}
_NETWORK_PARAMS = {
    "ATB_NETWORK_FIFO_DEPTH": 16,
    "ATB_NETWORK_SYNC_STAGE": 2,
    "ATB_NETWORK_ERR_INT_CNT_WIDTH": 16,
    "ATB_FUNNEL_N_ATB": 2,
    "ATB_FUNNEL_HOLD_WIDTH": 4,
    "ATB_FUNNEL_DATA0_WIDTH": 9,
    "ATB_FUNNEL_FIXED_CONFIGURATION": "1'b0",
    "ATB_FUNNEL_FIXED_HOLD_TIME": "4'b0011",
    "ATB_AFIFO_WID": 128,
    "ATB_ID_WIDTH": 7,
}
_PACK_PARAMS = {
    "ATB_DATA_WIDTH": 128,
    "ATB_ID_WIDTH": 7,
}


def _apply_params(cfg: TemplateIPConfig, params: dict) -> TemplateIPConfig:
    cfg.param_overrides = params
    for macro_name, macro_value in params.items():
        cfg.set_macro(macro_name, macro_value)
    return cfg


def _new_iniu_cfg(name: str, prefix: str, env_var: str, filelist_name: str) -> TemplateIPConfig:
    return _apply_params(
        TemplateIPConfig(
            name=name,
            prefix=prefix,
            filelist=_vcf(filelist_name),
            env_var=env_var,
        ),
        dict(_INIU_PARAMS, **_PACK_PARAMS),
    )


def _new_tniu_cfg(name: str, prefix: str, env_var: str, filelist_name: str) -> TemplateIPConfig:
    return _apply_params(
        TemplateIPConfig(
            name=name,
            prefix=prefix,
            filelist=_vcf(filelist_name),
            env_var=env_var,
        ),
        dict(_TNIU_PARAMS, **_PACK_PARAMS),
    )


# ── Per-SS-type noc configs (each SS type gets its own publish directory) ──
# Follows DTI pattern: per-SS prefix → independent top_side publish dir.
# Identical SS (dsp_ss0~5) share one cfg → one publish dir.

# ── Per-SS-type noc configs (each SS type gets its own publish directory) ──
# Follows DTI pattern: per-SS prefix → independent top_side publish dir.
# Identical SS (dsp_ss0~5) share one cfg → one publish dir.

dsp_iniu_noc_cfg = TemplateIPConfig(
    name="dsp_iniu_noc",
    prefix="dsp_noc_",
    filelist=_vcf("atb_iniu_noc_pub.f"),
    env_var="DSP_INIU_NOC_DIR",
)
dsp_iniu_noc_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in dsp_iniu_noc_cfg.param_overrides.items():
    dsp_iniu_noc_cfg.set_macro(macro_name, macro_value)

camera_iniu_noc_cfg = TemplateIPConfig(
    name="camera_iniu_noc",
    prefix="cam_noc_",
    filelist=_vcf("atb_iniu_noc_pub.f"),
    env_var="CAMERA_INIU_NOC_DIR",
)
camera_iniu_noc_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in camera_iniu_noc_cfg.param_overrides.items():
    camera_iniu_noc_cfg.set_macro(macro_name, macro_value)

mipi_iniu_noc_cfg = TemplateIPConfig(
    name="mipi_iniu_noc",
    prefix="mipi_noc_",
    filelist=_vcf("atb_iniu_noc_pub.f"),
    env_var="MIPI_INIU_NOC_DIR",
)
mipi_iniu_noc_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in mipi_iniu_noc_cfg.param_overrides.items():
    mipi_iniu_noc_cfg.set_macro(macro_name, macro_value)

debug_tniu_noc_cfg = TemplateIPConfig(
    name="debug_tniu_noc",
    prefix="dbg_noc_",
    filelist=_vcf("atb_tniu_noc_pub.f"),
    env_var="DEBUG_TNIU_NOC_DIR",
)
debug_tniu_noc_cfg.param_overrides = dict(_TNIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in debug_tniu_noc_cfg.param_overrides.items():
    debug_tniu_noc_cfg.set_macro(macro_name, macro_value)

gpu0_iniu_noc_cfg = _new_iniu_cfg(
    name="gpu0_iniu_noc",
    prefix="gpu0_noc_",
    env_var="GPU0_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
cpu_iniu_noc_cfg = _new_iniu_cfg(
    name="cpu_iniu_noc",
    prefix="cpu_noc_",
    env_var="CPU_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
gpu1_iniu_noc_cfg = _new_iniu_cfg(
    name="gpu1_iniu_noc",
    prefix="gpu1_noc_",
    env_var="GPU1_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
usb_dp_iniu_noc_cfg = _new_iniu_cfg(
    name="usb_dp_iniu_noc",
    prefix="usb_dp_noc_",
    env_var="USB_DP_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
display_iniu_noc_cfg = _new_iniu_cfg(
    name="display_iniu_noc",
    prefix="display_noc_",
    env_var="DISPLAY_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
aon_iniu_noc_cfg = _new_iniu_cfg(
    name="aon_iniu_noc",
    prefix="aon_noc_",
    env_var="AON_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
mcu_iniu_noc_cfg = _new_iniu_cfg(
    name="mcu_iniu_noc",
    prefix="mcu_noc_",
    env_var="MCU_INIU_NOC_DIR",
    filelist_name="atb_iniu_noc_pub.f",
)
peri_tniu_noc_cfg = _new_tniu_cfg(
    name="peri_tniu_noc",
    prefix="peri_noc_",
    env_var="PERI_TNIU_NOC_DIR",
    filelist_name="atb_tniu_noc_pub.f",
)

# ── Network component configs ────────────────────────────────────────────
# Component-specific .f (only top module + own IPs) for memnoc-like publish.
# Bridge and funnel share no RTL files — each publish dir is self-contained.

atb_async_bridge_config = TemplateIPConfig(
    name="atb_async_bridge",
    prefix="",
    filelist=_vcf("atb_async_bridge.f"),
    env_var="ATB_ASYNC_BRIDGE_DIR",
)
atb_async_bridge_config.param_overrides = dict(_NETWORK_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in atb_async_bridge_config.param_overrides.items():
    atb_async_bridge_config.set_macro(macro_name, macro_value)

atb_funnel_config = TemplateIPConfig(
    name="atb_funnel",
    prefix="",
    filelist=_vcf("atb_funnel.f"),
    env_var="ATB_FUNNEL_DIR",
)
atb_funnel_config.param_overrides = dict(_NETWORK_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in atb_funnel_config.param_overrides.items():
    atb_funnel_config.set_macro(macro_name, macro_value)

atb_top_wrap_config = TemplateIPConfig(
    name="atb_top_wrap",
    prefix="",
    filelist=_vcf("atb_noc_top_wrap_comp.f"),
    env_var="ATB_TOP_WRAP_DIR",
)
atb_top_wrap_config.param_overrides = dict(_NETWORK_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in atb_top_wrap_config.param_overrides.items():
    atb_top_wrap_config.set_macro(macro_name, macro_value)


# ── Per-SS-type TemplateIPConfigs (name → publish folder) ────────────────
# Memnoc pattern: each SS type gets its own cfg with semantic name/env_var.
# Identical SS IDs (dsp_ss0~5) share one cfg → one publish folder.
# Sys configs use _pub.f (not _comp.f/sys_filelist) to avoid pulling LP
# Sys configs use _pub.f (not _comp.f/sys_filelist) to avoid pulling LP

dsp_iniu_cfg = TemplateIPConfig(
    name="dsp_iniu_sys",
    prefix="dsp_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="DSP_INIU_SYS_DIR",
)
dsp_iniu_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in dsp_iniu_cfg.param_overrides.items():
    dsp_iniu_cfg.set_macro(macro_name, macro_value)

camera_iniu_cfg = TemplateIPConfig(
    name="camera_iniu_sys",
    prefix="cam_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="CAMERA_INIU_SYS_DIR",
)
camera_iniu_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in camera_iniu_cfg.param_overrides.items():
    camera_iniu_cfg.set_macro(macro_name, macro_value)

mipi_iniu_cfg = TemplateIPConfig(
    name="mipi_iniu_sys",
    prefix="mipi_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="MIPI_INIU_SYS_DIR",
)
mipi_iniu_cfg.param_overrides = dict(_INIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in mipi_iniu_cfg.param_overrides.items():
    mipi_iniu_cfg.set_macro(macro_name, macro_value)

debug_tniu_cfg = TemplateIPConfig(
    name="debug_tniu_sys",
    prefix="dbg_",
    filelist=_vcf("atb_tniu_sys_pub.f"),
    env_var="DEBUG_TNIU_SYS_DIR",
)
debug_tniu_cfg.param_overrides = dict(_TNIU_PARAMS, **_PACK_PARAMS)
for macro_name, macro_value in debug_tniu_cfg.param_overrides.items():
    debug_tniu_cfg.set_macro(macro_name, macro_value)

gpu0_iniu_cfg = _new_iniu_cfg(
    name="gpu0_iniu_sys",
    prefix="gpu0_",
    env_var="GPU0_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
cpu_iniu_cfg = _new_iniu_cfg(
    name="cpu_iniu_sys",
    prefix="cpu_",
    env_var="CPU_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
gpu1_iniu_cfg = _new_iniu_cfg(
    name="gpu1_iniu_sys",
    prefix="gpu1_",
    env_var="GPU1_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
usb_dp_iniu_cfg = _new_iniu_cfg(
    name="usb_dp_iniu_sys",
    prefix="usb_dp_",
    env_var="USB_DP_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
display_iniu_cfg = _new_iniu_cfg(
    name="display_iniu_sys",
    prefix="display_",
    env_var="DISPLAY_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
aon_iniu_cfg = _new_iniu_cfg(
    name="aon_iniu_sys",
    prefix="aon_",
    env_var="AON_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
mcu_iniu_cfg = _new_iniu_cfg(
    name="mcu_iniu_sys",
    prefix="mcu_",
    env_var="MCU_INIU_SYS_DIR",
    filelist_name="atb_iniu_sys_pub.f",
)
peri_tniu_cfg = _new_tniu_cfg(
    name="peri_tniu_sys",
    prefix="peri_",
    env_var="PERI_TNIU_SYS_DIR",
    filelist_name="atb_tniu_sys_pub.f",
)


# ── Public aliases for node-level consumers ────────────────────────────────
atb_iniu_sys_config = dsp_iniu_cfg          # default sys config
atb_iniu_noc_config = dsp_iniu_noc_cfg      # default noc config
atb_tniu_sys_config = peri_tniu_cfg         # default sys config
atb_tniu_noc_config = peri_tniu_noc_cfg     # default noc config

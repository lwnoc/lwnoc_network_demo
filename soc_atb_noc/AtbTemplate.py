import os
from pathlib import Path
from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

THIS_DIR = Path(__file__).resolve().parent
ATB_ROOT = Path(os.environ.get("ATB_SUBIP_ROOT", "/home/lgzhu/dev/noc_work/lwnoc_atb_noc"))

_work_dir = ATB_ROOT / "work"


def _resolve_f(path: str) -> str:
    p = ATB_ROOT / path
    if p.exists():
        return str(p)
    wpath = _work_dir / path
    if wpath.exists():
        return str(wpath)
    return str(p)


# ── Base component configs (shared across all SS of same type) ───────────
# These define the RTL building blocks. Multiple SS types may share the same
# component-level config if they use identical RTL. Each SS type still gets
# its own TemplateIPConfig for publish folder naming.

_atb_iniu_sys_cfg = TemplateIPConfig(
    name="atb_iniu_sys",
    prefix="",
    filelist=_resolve_f("work/iniu_sys_comp/filelist.f"),
    env_var="ATB_INIU_SYS_DIR",
)

_atb_iniu_noc_cfg = TemplateIPConfig(
    name="atb_iniu_noc",
    prefix="",
    filelist=_resolve_f("work/iniu_noc_comp/filelist.f"),
    env_var="ATB_INIU_NOC_DIR",
)

_atb_tniu_sys_cfg = TemplateIPConfig(
    name="atb_tniu_sys",
    prefix="",
    filelist=_resolve_f("work/tniu_sys_comp/filelist.f"),
    env_var="ATB_TNIU_SYS_DIR",
)

_atb_tniu_noc_cfg = TemplateIPConfig(
    name="atb_tniu_noc",
    prefix="",
    filelist=_resolve_f("work/tniu_noc_comp/filelist.f"),
    env_var="ATB_TNIU_NOC_DIR",
)

# ── Network component configs ────────────────────────────────────────────
atb_funnel_config = TemplateIPConfig(
    name="atb_funnel",
    prefix="",
    filelist=str(THIS_DIR / "filelist" / "atb_funnel.f"),
    env_var="ATB_FUNNEL_DIR",
)

atb_async_bridge_config = TemplateIPConfig(
    name="atb_async_bridge",
    prefix="",
    filelist=str(THIS_DIR / "filelist" / "atb_async_bridge.f"),
    env_var="ATB_ASYNC_BRIDGE_DIR",
)

atb_cmn_config = TemplateIPConfig(
    name="atb_cmn",
    prefix="",
    filelist=_resolve_f("work/cmn_comp/filelist.f"),
    env_var="ATB_CMN_DIR",
)

atb_top_wrap_config = TemplateIPConfig(
    name="atb_top_wrap",
    prefix="",
    filelist=_resolve_f("work/top_wrap_comp/filelist.f"),
    env_var="ATB_TOP_WRAP_DIR",
)


# ── Per-SS-type TemplateIPConfigs (name → publish folder) ────────────────
# Memnoc pattern: each SS type gets its own cfg with semantic name/env_var.
# Identical SS IDs (dsp_ss0~5) share one cfg → one publish folder.

dsp_iniu_cfg = TemplateIPConfig(
    name="dsp_iniu_sys",
    prefix="",
    filelist=_resolve_f("work/iniu_sys_comp/filelist.f"),
    env_var="DSP_INIU_SYS_DIR",
)

camera_iniu_cfg = TemplateIPConfig(
    name="camera_iniu_sys",
    prefix="",
    filelist=_resolve_f("work/iniu_sys_comp/filelist.f"),
    env_var="CAMERA_INIU_SYS_DIR",
)

mipi_iniu_cfg = TemplateIPConfig(
    name="mipi_iniu_sys",
    prefix="",
    filelist=_resolve_f("work/iniu_sys_comp/filelist.f"),
    env_var="MIPI_INIU_SYS_DIR",
)

debug_tniu_cfg = TemplateIPConfig(
    name="debug_tniu_sys",
    prefix="",
    filelist=_resolve_f("work/tniu_sys_comp/filelist.f"),
    env_var="DEBUG_TNIU_SYS_DIR",
)


# ── Public aliases for node-level consumers (point to same component cfgs) ──
atb_iniu_sys_config = _atb_iniu_sys_cfg
atb_iniu_noc_config = _atb_iniu_noc_cfg
atb_tniu_sys_config = _atb_tniu_sys_cfg
atb_tniu_noc_config = _atb_tniu_noc_cfg

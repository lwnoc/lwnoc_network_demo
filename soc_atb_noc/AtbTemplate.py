import os, subprocess
from pathlib import Path
from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
SUBS_DIR = REPO_ROOT / "subs"


def _resolve_env_path(name: str, csh_path: Path, bash_path: Path, default: Path) -> Path:
    """Resolve an env-dependent path with three-tier fallback:
    1. Shell env (csh or bash) — already in os.environ
    2. Source setup_env.csh → echo $name
    3. Source setup_env.sh → echo $name
    4. Python-side default
    """
    val = os.environ.get(name)
    if val:
        return Path(val).expanduser()

    # Try csh setup file
    if csh_path.exists():
        try:
            r = subprocess.run(
                ["csh", "-c", f'source "{csh_path}" >& /dev/null; if ( $?{name} ) printf "%s" "${name}"'],
                capture_output=True, text=True, timeout=10,
            )
            val = r.stdout.strip()
            if val:
                return Path(val).expanduser()
        except Exception:
            pass

    # Try bash setup file
    if bash_path.exists():
        try:
            r = subprocess.run(
                ["bash", "-c", f'source "{bash_path}" 2>/dev/null; printf "%s" "${{{name}}}"'],
                capture_output=True, text=True, timeout=10,
            )
            val = r.stdout.strip()
            if val:
                return Path(val).expanduser()
        except Exception:
            pass

    return Path(str(default)).expanduser()


DEFAULT_ATB_ROOT = SUBS_DIR / "lwnoc_atb_noc"
ATB_ROOT = _resolve_env_path("ATB_SUBIP_ROOT",
    DEFAULT_ATB_ROOT / "setup_env.csh", DEFAULT_ATB_ROOT / "setup_env.sh",
    DEFAULT_ATB_ROOT)
RTL_PATH_ROOT = _resolve_env_path("RTL_PATH",
    DEFAULT_ATB_ROOT / "setup_env.csh", DEFAULT_ATB_ROOT / "setup_env.sh",
    ATB_ROOT)
ATB_INIU_ROOT = _resolve_env_path("ATB_INIU",
    DEFAULT_ATB_ROOT / "setup_env.csh", DEFAULT_ATB_ROOT / "setup_env.sh",
    ATB_ROOT)

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


# ── Source dependency env vars (one per submodule, following ai memnoc pattern) ──
os.environ["RTL_PATH"] = str(RTL_PATH_ROOT)
os.environ["ATB_INIU"] = str(ATB_INIU_ROOT)
os.environ["ATB_SUBIP_ROOT"] = str(ATB_ROOT)
# LOWPOWER_PATH: needed for pchnl_ctrl enum types (lwnoc_pchannel_active_t/state_t).
# Set to subs/ path so _comp.f filelists can resolve the LP package.
DEFAULT_LP_SUB = SUBS_DIR / "lwnoc_lowpower_component"
LP_SUB = _resolve_env_path("LWNOC_LOWPOWER_COMPONENT",
    DEFAULT_LP_SUB / "setup_env.csh", DEFAULT_LP_SUB / "setup_env.sh",
    DEFAULT_LP_SUB)
LP_SUB_alt = _resolve_env_path("LOWPOWER_PATH",
    DEFAULT_LP_SUB / "setup_env.csh", DEFAULT_LP_SUB / "setup_env.sh",
    LP_SUB if LP_SUB.exists() else DEFAULT_LP_SUB)
if not LP_SUB.exists() and LP_SUB_alt.exists():
    LP_SUB = LP_SUB_alt
os.environ["LOWPOWER_PATH"] = str(LP_SUB)
os.environ["LWNOC_LOWPOWER_COMPONENT"] = str(LP_SUB)


# ── Combined filelists for sys configs (need LP package for pchnl_ctrl) ──
# ── Base component configs (shared across all SS of same type) ───────────

_atb_iniu_sys_cfg = TemplateIPConfig(
    name="atb_iniu_sys",
    prefix="",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="ATB_INIU_SYS_DIR",
)

_atb_iniu_noc_cfg = TemplateIPConfig(
    name="atb_iniu_noc",
    prefix="",
    filelist=_vcf("atb_iniu_noc_pub.f"),
    env_var="ATB_INIU_NOC_DIR",
)

_atb_tniu_sys_cfg = TemplateIPConfig(
    name="atb_tniu_sys",
    prefix="",
    filelist=_vcf("atb_tniu_sys_pub.f"),
    env_var="ATB_TNIU_SYS_DIR",
)

_atb_tniu_noc_cfg = TemplateIPConfig(
    name="atb_tniu_noc",
    prefix="",
    filelist=_vcf("atb_tniu_noc_pub.f"),
    env_var="ATB_TNIU_NOC_DIR",
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

atb_funnel_config = TemplateIPConfig(
    name="atb_funnel",
    prefix="",
    filelist=_vcf("atb_funnel.f"),
    env_var="ATB_FUNNEL_DIR",
)

atb_top_wrap_config = TemplateIPConfig(
    name="atb_top_wrap",
    prefix="",
    filelist=_vcf("atb_noc_top_wrap_comp.f"),
    env_var="ATB_TOP_WRAP_DIR",
)


# ── Per-SS-type TemplateIPConfigs (name → publish folder) ────────────────
# Memnoc pattern: each SS type gets its own cfg with semantic name/env_var.
# Identical SS IDs (dsp_ss0~5) share one cfg → one publish folder.
# Sys configs use _pub.f (not _comp.f/sys_filelist) to avoid pulling LP
# and common dep files. struct_mode="packed" is applied on TemplateComponent
# for enum flattening (requires LP package at integration compile level).
# Known: [-1:0] for pstate/pactive in demo without LP package.

dsp_iniu_cfg = TemplateIPConfig(
    name="dsp_iniu_sys",
    prefix="dsp_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="DSP_INIU_SYS_DIR",
)

camera_iniu_cfg = TemplateIPConfig(
    name="camera_iniu_sys",
    prefix="cam_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="CAMERA_INIU_SYS_DIR",
)

mipi_iniu_cfg = TemplateIPConfig(
    name="mipi_iniu_sys",
    prefix="mipi_",
    filelist=_vcf("atb_iniu_sys_pub.f"),
    env_var="MIPI_INIU_SYS_DIR",
)

debug_tniu_cfg = TemplateIPConfig(
    name="debug_tniu_sys",
    prefix="dbg_",
    filelist=_vcf("atb_tniu_sys_pub.f"),
    env_var="DEBUG_TNIU_SYS_DIR",
)


# ── Public aliases for node-level consumers (point to same component cfgs) ──
atb_iniu_sys_config = _atb_iniu_sys_cfg
atb_iniu_noc_config = _atb_iniu_noc_cfg
atb_tniu_sys_config = _atb_tniu_sys_cfg
atb_tniu_noc_config = _atb_tniu_noc_cfg

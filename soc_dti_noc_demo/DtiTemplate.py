import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DEFAULT_DTI_REPO_ROOT = REPO_ROOT / "subs" / "lwnoc_dti_noc"
EXTERNAL_DTI_REPO_ROOT = Path("/home/lgzhu/dev/noc_work/lwnoc_dti_noc")
DTI_REPO_ROOT = EXTERNAL_DTI_REPO_ROOT if EXTERNAL_DTI_REPO_ROOT.exists() else DEFAULT_DTI_REPO_ROOT

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


os.environ["DTI_PR"] = str(DTI_REPO_ROOT)
os.environ["DTI_TEST_DIR"] = str(THIS_DIR)
os.environ["RTL_PATH"] = str(DTI_REPO_ROOT)
os.environ["FCIP_DIR"] = str(DTI_REPO_ROOT / "fcip")
os.environ["LWNOC_LOWPOWER_COMPONENT"] = str(DTI_REPO_ROOT / "lwnoc_lowpower_component")


FILELIST_DIR = THIS_DIR / "filelists"

# Mapping from local filelist names to publish-optimized filelists.
# _pub.f files are self-contained (no FCIP/LP, only owner IP).
_VC_FILELIST_MAP = {
    "dti_iniu_sys.f":     "dti_iniu_sys_pub.f",
    "dti_tniu_sys.f":     "dti_tniu_sys_pub.f",
    "dti_iniu_top.f":     "dti_iniu_top_pub.f",
    "dti_tniu_top.f":     "dti_tniu_top_pub.f",
    "dti_switch_3i1o.f":  "dti_switch_pub.f",
    "dti_switch_2i1o.f":  "dti_switch_pub.f",
    "dti_switch_4i1o.f":  "dti_switch_pub.f",
    "dti_req_rsp_async.f": "dti_req_rsp_async_pub.f",
    "dti_link_pipe.f":    "network_filelist.f",
    "dti_link_buf.f":     "network_filelist.f",
    "dti_tieoff.f":       "network_filelist.f",
}


def _resolve_fl(name: str) -> str:
    vc_name = _VC_FILELIST_MAP.get(name, name)
    # Prefer local file (workspace) over external repo vc/
    local_f = THIS_DIR / vc_name
    if local_f.exists():
        return str(local_f)
    return str(DTI_REPO_ROOT / "vc" / vc_name)


def _pack_u32_ranges(ranges):
    packed_min = 0
    packed_max = 0
    for idx, (range_min, range_max) in enumerate(ranges):
        packed_min |= int(range_min) << (idx * 32)
        packed_max |= int(range_max) << (idx * 32)
    return packed_min, packed_max


# ── Shared base for single-TBU INIU sys configs ─────────────────────────
# All single-TBU INIUs use the same RTL with identical param_overrides.
# Per-instance naming (prefix, env_var) is set on each derived config.
_SINGLE_TBU_PARAMS = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}
_INIU_SYS_FILELIST = _resolve_fl("dti_iniu_sys.f")


def _iniu_sys_cfg(name: str, prefix: str, env_var: str) -> TemplateIPConfig:
    """Single-TBU INIU sys config — all use same filelist + param_overrides."""
    cfg = TemplateIPConfig(name=name, prefix=prefix, filelist=_INIU_SYS_FILELIST, env_var=env_var)
    cfg.param_overrides = dict(_SINGLE_TBU_PARAMS)
    return cfg


# ── Per-endpoint INIU sys-side configs ──────────────────────────────────
pcie_eth_iniu_sys_config = _iniu_sys_cfg("pcie_eth_iniu_sys", "pcie_eth_", "PCIE_ETH_INIU_SYS_DIR")
vpu_iniu_sys_config       = _iniu_sys_cfg("vpu_iniu_sys",       "vpu_",      "VPU_INIU_SYS_DIR")
cpu_iniu_sys_config       = _iniu_sys_cfg("cpu_iniu_sys",       "cpu_",      "CPU_INIU_SYS_DIR")
gpu_iniu_sys_config        = _iniu_sys_cfg("gpu_iniu_sys",       "gpu_",      "GPU_INIU_SYS_DIR")
dp_iniu_sys_config        = _iniu_sys_cfg("dp_iniu_sys",        "dp_",       "DP_INIU_SYS_DIR")
display_iniu_sys_config   = _iniu_sys_cfg("display_iniu_sys",   "display_",  "DISPLAY_INIU_SYS_DIR")
usb_ufs_iniu_sys_config   = _iniu_sys_cfg("usb_ufs_iniu_sys",   "usb_ufs_",  "USB_UFS_INIU_SYS_DIR")
mipi_iniu_sys_config      = _iniu_sys_cfg("mipi_iniu_sys",      "mipi_",    "MIPI_INIU_SYS_DIR")
camera_iniu_sys_config     = _iniu_sys_cfg("camera_iniu_sys",    "camera_",   "CAMERA_INIU_SYS_DIR")
noc_tbu0_iniu_sys_config   = _iniu_sys_cfg("noc_tbu0_iniu_sys",  "noc_tbu0_", "NOC_TBU0_INIU_SYS_DIR")
noc_tbu1_iniu_sys_config   = _iniu_sys_cfg("noc_tbu1_iniu_sys",  "noc_tbu1_", "NOC_TBU1_INIU_SYS_DIR")

# DSP INIUs (6 instances) — all use same config, per-instance naming via template macro
dsp_iniu_sys_config = _iniu_sys_cfg("dsp_iniu_sys", "dsp_", "DSP_INIU_SYS_DIR")


iniu_top_config = TemplateIPConfig(
    name="dti_iniu_top_side",
    prefix="dti_iniu_top_",
    filelist=_resolve_fl("dti_iniu_top.f"),
    env_var="DTI_INIU_TOP_DIR",
)

tcu_tniu_sys_config = TemplateIPConfig(
    name="sys_tcu_tniu_sys",
    prefix="sys_tcu_",
    filelist=_resolve_fl("dti_tniu_sys.f"),
    env_var="SYS_TCU_TNIU_SYS_DIR",
)

tniu_top_config = TemplateIPConfig(
    name="dti_tniu_top_side",
    prefix="dti_tniu_top_",
    filelist=_resolve_fl("dti_tniu_top.f"),
    env_var="DTI_TNIU_TOP_DIR",
)


# ── Switch configs (direct declarations — no wrapper function) ──────────
# SRCID layout per soc_dti_noc_topo:
_SW_FILELIST = _resolve_fl("dti_switch_3i1o.f")
_SWITCH_COMMON = {"NUM_TNIU": 1}

dti_sw0_config = TemplateIPConfig(
    name="dti_sw0", prefix="dti_sw0_", filelist=_SW_FILELIST, env_var="DTI_SW0_OUT_DIR",
)
dti_sw0_config.param_overrides = dict(_SWITCH_COMMON,
    NUM_INIU=6, TNIU_DECMIN=0, TNIU_DECMAX=5,
    INIU_DECMIN=0, INIU_DECMAX=0,
)

dti_sw1_config = TemplateIPConfig(
    name="dti_sw1", prefix="dti_sw1_", filelist=_SW_FILELIST, env_var="DTI_SW1_OUT_DIR",
)
dti_sw1_config.param_overrides = dict(_SWITCH_COMMON,
    NUM_INIU=5, TNIU_DECMIN=0, TNIU_DECMAX=4,
    INIU_DECMIN=0, INIU_DECMAX=0,
)

dti_sw2_config = TemplateIPConfig(
    name="dti_sw2", prefix="dti_sw2_", filelist=_SW_FILELIST, env_var="DTI_SW2_OUT_DIR",
)
dti_sw2_config.param_overrides = dict(_SWITCH_COMMON,
    NUM_INIU=4, TNIU_DECMIN=0, TNIU_DECMAX=3,
    INIU_DECMIN=0, INIU_DECMAX=0,
)

dti_sw3_config = TemplateIPConfig(
    name="dti_sw3", prefix="dti_sw3_", filelist=_SW_FILELIST, env_var="DTI_SW3_OUT_DIR",
)
dti_sw3_config.param_overrides = dict(_SWITCH_COMMON,
    NUM_INIU=3, TNIU_DECMIN=0, TNIU_DECMAX=14,
    INIU_DECMIN=0, INIU_DECMAX=5,
)


dti_req_rsp_async_config = TemplateIPConfig(
    name="dti_req_rsp_async",
    prefix="",
    filelist=_resolve_fl("dti_req_rsp_async.f"),
    env_var="DTI_REQ_RSP_ASYNC_OUT_DIR",
)
dti_req_rsp_async_config.param_overrides = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}

dti_link_pipe_config = TemplateIPConfig(
    name="dti_link_pipe",
    prefix="",
    filelist=_resolve_fl("dti_link_pipe.f"),
    env_var="DTI_LINK_PIPE_OUT_DIR",
)
dti_link_pipe_config.param_overrides = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}

dti_link_buf_config = TemplateIPConfig(
    name="dti_link_buf",
    prefix="",
    filelist=_resolve_fl("dti_link_buf.f"),
    env_var="DTI_LINK_BUF_OUT_DIR",
)
dti_link_buf_config.param_overrides = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}
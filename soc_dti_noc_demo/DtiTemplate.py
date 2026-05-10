import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DEFAULT_DTI_REPO_ROOT = REPO_ROOT / "subs" / "lwnoc_dti_noc"


def _env_path(name: str, default: Path) -> Path:
    return Path(os.environ.get(name, str(default))).expanduser()


DTI_REPO_ROOT = _env_path("DTI_PR", DEFAULT_DTI_REPO_ROOT)
RTL_PATH_ROOT = _env_path("RTL_PATH", DTI_REPO_ROOT)
FCIP_DIR = _env_path("FCIP_DIR", DTI_REPO_ROOT / "fcip")
LWNOC_LOWPOWER_COMPONENT = _env_path("LWNOC_LOWPOWER_COMPONENT", DTI_REPO_ROOT / "lwnoc_lowpower_component")

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


os.environ.setdefault("DTI_PR", str(DTI_REPO_ROOT))
os.environ.setdefault("DTI_TEST_DIR", str(THIS_DIR))
os.environ.setdefault("RTL_PATH", str(RTL_PATH_ROOT))
os.environ.setdefault("FCIP_DIR", str(FCIP_DIR))
os.environ.setdefault("LWNOC_LOWPOWER_COMPONENT", str(LWNOC_LOWPOWER_COMPONENT))


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


def _sv_param(total_bits: int, value: int) -> str:
    # Packed route tables must stay as sized SV literals when copied into macros.
    hex_digits = max(1, (total_bits + 3) // 4)
    return f"{total_bits}'h{value:0{hex_digits}X}"


# Shared base for INIU sys configs. Most leaves stay single-TBU; vpu_ss widens to 2.
_DEFAULT_INIU_PARAMS = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}
_VPU_INIU_PARAMS = {"TBU_NUM": 2, "TRANSACTION_MAX_NUM": 8}
_DEFAULT_TNIU_PARAMS = {"TBU_NUM": 4, "TRANSACTION_MAX_NUM": 8}
_INIU_SYS_FILELIST = _resolve_fl("dti_iniu_sys.f")


# Keep sys-side params and emitted macros next to each config so hand edits only
# need to touch the local dict below.
pcie_eth_iniu_sys_config = TemplateIPConfig(
    name="pcie_eth_iniu_sys",
    prefix="pcie_eth_",
    filelist=_INIU_SYS_FILELIST,
    env_var="PCIE_ETH_INIU_SYS_DIR",
)
pcie_eth_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in pcie_eth_iniu_sys_config.param_overrides.items():
    pcie_eth_iniu_sys_config.set_macro(macro_name, macro_value)

vpu_iniu_sys_config = TemplateIPConfig(
    name="vpu_iniu_sys",
    prefix="vpu_",
    filelist=_INIU_SYS_FILELIST,
    env_var="VPU_INIU_SYS_DIR",
)
vpu_iniu_sys_config.param_overrides = dict(_VPU_INIU_PARAMS)
for macro_name, macro_value in vpu_iniu_sys_config.param_overrides.items():
    vpu_iniu_sys_config.set_macro(macro_name, macro_value)

cpu_iniu_sys_config = TemplateIPConfig(
    name="cpu_iniu_sys",
    prefix="cpu_",
    filelist=_INIU_SYS_FILELIST,
    env_var="CPU_INIU_SYS_DIR",
)
cpu_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in cpu_iniu_sys_config.param_overrides.items():
    cpu_iniu_sys_config.set_macro(macro_name, macro_value)

gpu_iniu_sys_config = TemplateIPConfig(
    name="gpu_iniu_sys",
    prefix="gpu_",
    filelist=_INIU_SYS_FILELIST,
    env_var="GPU_INIU_SYS_DIR",
)
gpu_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in gpu_iniu_sys_config.param_overrides.items():
    gpu_iniu_sys_config.set_macro(macro_name, macro_value)

usb_dp_iniu_sys_config = TemplateIPConfig(
    name="usb_dp_iniu_sys",
    prefix="usb_dp_",
    filelist=_INIU_SYS_FILELIST,
    env_var="USB_DP_INIU_SYS_DIR",
)
usb_dp_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in usb_dp_iniu_sys_config.param_overrides.items():
    usb_dp_iniu_sys_config.set_macro(macro_name, macro_value)

dp_iniu_sys_config = usb_dp_iniu_sys_config

display_iniu_sys_config = TemplateIPConfig(
    name="display_iniu_sys",
    prefix="display_",
    filelist=_INIU_SYS_FILELIST,
    env_var="DISPLAY_INIU_SYS_DIR",
)
display_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in display_iniu_sys_config.param_overrides.items():
    display_iniu_sys_config.set_macro(macro_name, macro_value)

usb_ufs_iniu_sys_config = TemplateIPConfig(
    name="usb_ufs_iniu_sys",
    prefix="usb_ufs_",
    filelist=_INIU_SYS_FILELIST,
    env_var="USB_UFS_INIU_SYS_DIR",
)
usb_ufs_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in usb_ufs_iniu_sys_config.param_overrides.items():
    usb_ufs_iniu_sys_config.set_macro(macro_name, macro_value)

mipi_iniu_sys_config = TemplateIPConfig(
    name="mipi_iniu_sys",
    prefix="mipi_",
    filelist=_INIU_SYS_FILELIST,
    env_var="MIPI_INIU_SYS_DIR",
)
mipi_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in mipi_iniu_sys_config.param_overrides.items():
    mipi_iniu_sys_config.set_macro(macro_name, macro_value)

camera_iniu_sys_config = TemplateIPConfig(
    name="camera_iniu_sys",
    prefix="camera_",
    filelist=_INIU_SYS_FILELIST,
    env_var="CAMERA_INIU_SYS_DIR",
)
camera_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in camera_iniu_sys_config.param_overrides.items():
    camera_iniu_sys_config.set_macro(macro_name, macro_value)

npu_iniu_sys_config = TemplateIPConfig(
    name="npu_iniu_sys",
    prefix="npu_",
    filelist=_INIU_SYS_FILELIST,
    env_var="NPU_INIU_SYS_DIR",
)
npu_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in npu_iniu_sys_config.param_overrides.items():
    npu_iniu_sys_config.set_macro(macro_name, macro_value)

peri_iniu_sys_config = TemplateIPConfig(
    name="peri_iniu_sys",
    prefix="peri_",
    filelist=_INIU_SYS_FILELIST,
    env_var="PERI_INIU_SYS_DIR",
)
peri_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in peri_iniu_sys_config.param_overrides.items():
    peri_iniu_sys_config.set_macro(macro_name, macro_value)

noc_tbu0_iniu_sys_config = TemplateIPConfig(
    name="noc_tbu0_iniu_sys",
    prefix="noc_tbu0_",
    filelist=_INIU_SYS_FILELIST,
    env_var="NOC_TBU0_INIU_SYS_DIR",
)
noc_tbu0_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in noc_tbu0_iniu_sys_config.param_overrides.items():
    noc_tbu0_iniu_sys_config.set_macro(macro_name, macro_value)

noc_tbu1_iniu_sys_config = TemplateIPConfig(
    name="noc_tbu1_iniu_sys",
    prefix="noc_tbu1_",
    filelist=_INIU_SYS_FILELIST,
    env_var="NOC_TBU1_INIU_SYS_DIR",
)
noc_tbu1_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in noc_tbu1_iniu_sys_config.param_overrides.items():
    noc_tbu1_iniu_sys_config.set_macro(macro_name, macro_value)

dsp_iniu_sys_config = TemplateIPConfig(
    name="dsp_iniu_sys",
    prefix="dsp_",
    filelist=_INIU_SYS_FILELIST,
    env_var="DSP_INIU_SYS_DIR",
)
dsp_iniu_sys_config.param_overrides = dict(_DEFAULT_INIU_PARAMS)
for macro_name, macro_value in dsp_iniu_sys_config.param_overrides.items():
    dsp_iniu_sys_config.set_macro(macro_name, macro_value)


iniu_top_config = TemplateIPConfig(
    name="dti_iniu_top_side",
    prefix="dti_iniu_top_",
    filelist=_resolve_fl("dti_iniu_top.f"),
    env_var="DTI_INIU_TOP_DIR",
)
iniu_top_config.param_overrides = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6, **_DEFAULT_INIU_PARAMS}
for macro_name, macro_value in iniu_top_config.param_overrides.items():
    iniu_top_config.set_macro(macro_name, macro_value)

cpu_tniu_sys_config = TemplateIPConfig(
    name="cpu_tniu_sys",
    prefix="cpu_tniu_",
    filelist=_resolve_fl("dti_tniu_sys.f"),
    env_var="CPU_TNIU_SYS_DIR",
)
cpu_tniu_sys_config.param_overrides = dict(_DEFAULT_TNIU_PARAMS)
for macro_name, macro_value in cpu_tniu_sys_config.param_overrides.items():
    cpu_tniu_sys_config.set_macro(macro_name, macro_value)
tcu_tniu_sys_config = cpu_tniu_sys_config

tniu_top_config = TemplateIPConfig(
    name="dti_tniu_top_side",
    prefix="dti_tniu_top_",
    filelist=_resolve_fl("dti_tniu_top.f"),
    env_var="DTI_TNIU_TOP_DIR",
)
tniu_top_config.param_overrides = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6, **_DEFAULT_TNIU_PARAMS}
for macro_name, macro_value in tniu_top_config.param_overrides.items():
    tniu_top_config.set_macro(macro_name, macro_value)


SOC_DTI_TTID_LEAF_ORDER = (
    "npu_ss0",
    "npu_ss3",
    "npu_ss4",
    "npu_ss2",
    "npu_ss1",
    "peri_ss",
    "ufs_ss",
    "pcie_eth_ss",
    "gpu_ss0",
    "dspss0",
    "dspss1",
    "dspss2",
    "dspss3",
    "dspss4",
    "dspss5",
    "camera_ss",
    "mipi_ss",
    "gpu_ss1",
    "usb_dp_ss",
    "display_ss",
    "vpu_ss",
)

SOC_DTI_TBU_NUM_BY_LEAF = {leaf_name: 1 for leaf_name in SOC_DTI_TTID_LEAF_ORDER}
SOC_DTI_TBU_NUM_BY_LEAF["vpu_ss"] = int(vpu_iniu_sys_config.param_overrides["TBU_NUM"])

SOC_DTI_TTID_BASES: dict[str, int] = {}
_next_route_base = 0
for _leaf_name in SOC_DTI_TTID_LEAF_ORDER:
    SOC_DTI_TTID_BASES[_leaf_name] = _next_route_base
    _next_route_base += int(SOC_DTI_TBU_NUM_BY_LEAF[_leaf_name])

SOC_DTI_LEAF_TTID_WINDOWS = {
    leaf_name: (
        SOC_DTI_TTID_BASES[leaf_name],
        SOC_DTI_TTID_BASES[leaf_name] + int(SOC_DTI_TBU_NUM_BY_LEAF[leaf_name]) - 1,
    )
    for leaf_name in SOC_DTI_TTID_LEAF_ORDER
}
SOC_DTI_TOTAL_TTID_SLOTS = sum(int(slot_count) for slot_count in SOC_DTI_TBU_NUM_BY_LEAF.values())

SOC_DTI_SWITCH_CHILDREN = {
    "bottom_merge1": ("npu_ss3", "npu_ss4", "npu_ss2"),
    "bottom_merge0": ("ufs_ss", "pcie_eth_ss", "gpu_ss0"),
    "dsp_merge0": ("dspss0", "dspss1", "dspss2", "dspss3", "dspss4", "dspss5"),
    "tr_merge0": ("camera_ss", "mipi_ss", "gpu_ss1", "usb_dp_ss", "display_ss", "vpu_ss"),
    "tl_merge0": ("peri_ss", "bottom_merge0", "dsp_merge0", "tr_merge0"),
    "top_spine": ("npu_ss0", "bottom_merge1", "npu_ss1"),
}


def get_soc_dti_ttid_window(node_name: str) -> tuple[int, int]:
    if node_name in SOC_DTI_LEAF_TTID_WINDOWS:
        return SOC_DTI_LEAF_TTID_WINDOWS[node_name]
    child_windows = tuple(get_soc_dti_ttid_window(child_name) for child_name in SOC_DTI_SWITCH_CHILDREN[node_name])
    return child_windows[0][0], child_windows[-1][1]


SOC_DTI_SWITCH_TTID_LAYOUTS = {
    switch_name: tuple(get_soc_dti_ttid_window(child_name) for child_name in child_names)
    for switch_name, child_names in SOC_DTI_SWITCH_CHILDREN.items()
}


def _leaf_top_env_var(node_name: str) -> str:
    return f"DTI_INIU_TOP_{node_name.upper()}_DIR"


def make_iniu_top_leaf_config(cfg: TemplateIPConfig, node_name: str, route_base: int) -> TemplateIPConfig:
    leaf_cfg = TemplateIPConfig(
        name=f"{cfg.name}_{node_name}",
        prefix=f"dti_iniu_top_{node_name}_",
        filelist=cfg.filelist,
        env_var=_leaf_top_env_var(node_name),
    )
    leaf_params = dict(getattr(cfg, "param_overrides", {}) or {})
    leaf_params.update(getattr(SOC_DTI_INIU_SYS_CFG_BY_LEAF[node_name], "param_overrides", {}) or {})
    leaf_params["INIU_ROUTE_BASE"] = int(route_base)
    leaf_cfg.param_overrides = leaf_params
    for macro_name, macro_value in leaf_params.items():
        leaf_cfg.set_macro(macro_name, macro_value)
    return leaf_cfg


SOC_DTI_INIU_SYS_CFG_BY_LEAF = {
    "npu_ss0": npu_iniu_sys_config,
    "npu_ss1": npu_iniu_sys_config,
    "npu_ss2": npu_iniu_sys_config,
    "npu_ss3": npu_iniu_sys_config,
    "npu_ss4": npu_iniu_sys_config,
    "peri_ss": peri_iniu_sys_config,
    "ufs_ss": usb_ufs_iniu_sys_config,
    "pcie_eth_ss": pcie_eth_iniu_sys_config,
    "gpu_ss0": gpu_iniu_sys_config,
    "gpu_ss1": gpu_iniu_sys_config,
    "dspss0": dsp_iniu_sys_config,
    "dspss1": dsp_iniu_sys_config,
    "dspss2": dsp_iniu_sys_config,
    "dspss3": dsp_iniu_sys_config,
    "dspss4": dsp_iniu_sys_config,
    "dspss5": dsp_iniu_sys_config,
    "camera_ss": camera_iniu_sys_config,
    "mipi_ss": mipi_iniu_sys_config,
    "usb_dp_ss": usb_dp_iniu_sys_config,
    "display_ss": display_iniu_sys_config,
    "vpu_ss": vpu_iniu_sys_config,
}


_SW_FILELIST = _resolve_fl("dti_switch_3i1o.f")
_SWITCH_COMMON = {"NUM_TNIU": 1, "PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}

_BOTTOM_MERGE1_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["bottom_merge1"]
_BOTTOM_MERGE1_TNIU_DECMIN, _BOTTOM_MERGE1_TNIU_DECMAX = _BOTTOM_MERGE1_CHILD_WINDOWS[0][0], _BOTTOM_MERGE1_CHILD_WINDOWS[-1][1]
_BOTTOM_MERGE1_INIU_DECMIN, _BOTTOM_MERGE1_INIU_DECMAX = _pack_u32_ranges(_BOTTOM_MERGE1_CHILD_WINDOWS)

_BOTTOM_MERGE0_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["bottom_merge0"]
_BOTTOM_MERGE0_TNIU_DECMIN, _BOTTOM_MERGE0_TNIU_DECMAX = _BOTTOM_MERGE0_CHILD_WINDOWS[0][0], _BOTTOM_MERGE0_CHILD_WINDOWS[-1][1]
_BOTTOM_MERGE0_INIU_DECMIN, _BOTTOM_MERGE0_INIU_DECMAX = _pack_u32_ranges(_BOTTOM_MERGE0_CHILD_WINDOWS)

_DSP_MERGE0_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["dsp_merge0"]
_DSP_MERGE0_TNIU_DECMIN, _DSP_MERGE0_TNIU_DECMAX = _DSP_MERGE0_CHILD_WINDOWS[0][0], _DSP_MERGE0_CHILD_WINDOWS[-1][1]
_DSP_MERGE0_INIU_DECMIN, _DSP_MERGE0_INIU_DECMAX = _pack_u32_ranges(_DSP_MERGE0_CHILD_WINDOWS)

_TR_MERGE0_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["tr_merge0"]
_TR_MERGE0_TNIU_DECMIN, _TR_MERGE0_TNIU_DECMAX = _TR_MERGE0_CHILD_WINDOWS[0][0], _TR_MERGE0_CHILD_WINDOWS[-1][1]
_TR_MERGE0_INIU_DECMIN, _TR_MERGE0_INIU_DECMAX = _pack_u32_ranges(_TR_MERGE0_CHILD_WINDOWS)

_TL_MERGE0_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["tl_merge0"]
_TL_MERGE0_TNIU_DECMIN, _TL_MERGE0_TNIU_DECMAX = _TL_MERGE0_CHILD_WINDOWS[0][0], _TL_MERGE0_CHILD_WINDOWS[-1][1]
_TL_MERGE0_INIU_DECMIN, _TL_MERGE0_INIU_DECMAX = _pack_u32_ranges(_TL_MERGE0_CHILD_WINDOWS)

_TOP_SPINE_CHILD_WINDOWS = SOC_DTI_SWITCH_TTID_LAYOUTS["top_spine"]
_TOP_SPINE_TNIU_DECMIN, _TOP_SPINE_TNIU_DECMAX = _TOP_SPINE_CHILD_WINDOWS[0][0], _TOP_SPINE_CHILD_WINDOWS[-1][1]
_TOP_SPINE_INIU_DECMIN, _TOP_SPINE_INIU_DECMAX = _pack_u32_ranges(_TOP_SPINE_CHILD_WINDOWS)

dti_sw0_config = TemplateIPConfig(
    name="dti_sw0", prefix="dti_sw0_", filelist=_SW_FILELIST, env_var="DTI_SW0_OUT_DIR",
)
_DTI_SW0_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=3,
    TNIU_DECMIN=_BOTTOM_MERGE1_TNIU_DECMIN,
    TNIU_DECMAX=_BOTTOM_MERGE1_TNIU_DECMAX,
    INIU_DECMIN=_BOTTOM_MERGE1_INIU_DECMIN,
    INIU_DECMAX=_BOTTOM_MERGE1_INIU_DECMAX,
)
dti_sw0_config.param_overrides = dict(_DTI_SW0_PARAMS)
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TID_WIDTH", int(_DTI_SW0_PARAMS["TID_WIDTH"]))
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW0_PARAMS["PAYLOAD_WIDTH"]))
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW0_PARAMS["NUM_TNIU"]), int(_DTI_SW0_PARAMS["TNIU_DECMIN"])))
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW0_PARAMS["NUM_TNIU"]), int(_DTI_SW0_PARAMS["TNIU_DECMAX"])))
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW0_PARAMS["NUM_INIU"]), int(_DTI_SW0_PARAMS["INIU_DECMIN"])))
dti_sw0_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW0_PARAMS["NUM_INIU"]), int(_DTI_SW0_PARAMS["INIU_DECMAX"])))

dti_sw1_config = TemplateIPConfig(
    name="dti_sw1", prefix="dti_sw1_", filelist=_SW_FILELIST, env_var="DTI_SW1_OUT_DIR",
)
_DTI_SW1_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=3,
    TNIU_DECMIN=_BOTTOM_MERGE0_TNIU_DECMIN,
    TNIU_DECMAX=_BOTTOM_MERGE0_TNIU_DECMAX,
    INIU_DECMIN=_BOTTOM_MERGE0_INIU_DECMIN,
    INIU_DECMAX=_BOTTOM_MERGE0_INIU_DECMAX,
)
dti_sw1_config.param_overrides = dict(_DTI_SW1_PARAMS)
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TID_WIDTH", int(_DTI_SW1_PARAMS["TID_WIDTH"]))
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW1_PARAMS["PAYLOAD_WIDTH"]))
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW1_PARAMS["NUM_TNIU"]), int(_DTI_SW1_PARAMS["TNIU_DECMIN"])))
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW1_PARAMS["NUM_TNIU"]), int(_DTI_SW1_PARAMS["TNIU_DECMAX"])))
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW1_PARAMS["NUM_INIU"]), int(_DTI_SW1_PARAMS["INIU_DECMIN"])))
dti_sw1_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW1_PARAMS["NUM_INIU"]), int(_DTI_SW1_PARAMS["INIU_DECMAX"])))

dti_sw2_config = TemplateIPConfig(
    name="dti_sw2", prefix="dti_sw2_", filelist=_SW_FILELIST, env_var="DTI_SW2_OUT_DIR",
)
_DTI_SW2_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=6,
    TNIU_DECMIN=_DSP_MERGE0_TNIU_DECMIN,
    TNIU_DECMAX=_DSP_MERGE0_TNIU_DECMAX,
    INIU_DECMIN=_DSP_MERGE0_INIU_DECMIN,
    INIU_DECMAX=_DSP_MERGE0_INIU_DECMAX,
)
dti_sw2_config.param_overrides = dict(_DTI_SW2_PARAMS)
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TID_WIDTH", int(_DTI_SW2_PARAMS["TID_WIDTH"]))
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW2_PARAMS["PAYLOAD_WIDTH"]))
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW2_PARAMS["NUM_TNIU"]), int(_DTI_SW2_PARAMS["TNIU_DECMIN"])))
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW2_PARAMS["NUM_TNIU"]), int(_DTI_SW2_PARAMS["TNIU_DECMAX"])))
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW2_PARAMS["NUM_INIU"]), int(_DTI_SW2_PARAMS["INIU_DECMIN"])))
dti_sw2_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW2_PARAMS["NUM_INIU"]), int(_DTI_SW2_PARAMS["INIU_DECMAX"])))

dti_sw3_config = TemplateIPConfig(
    name="dti_sw3", prefix="dti_sw3_", filelist=_SW_FILELIST, env_var="DTI_SW3_OUT_DIR",
)
_DTI_SW3_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=6,
    TNIU_DECMIN=_TR_MERGE0_TNIU_DECMIN,
    TNIU_DECMAX=_TR_MERGE0_TNIU_DECMAX,
    INIU_DECMIN=_TR_MERGE0_INIU_DECMIN,
    INIU_DECMAX=_TR_MERGE0_INIU_DECMAX,
)
dti_sw3_config.param_overrides = dict(_DTI_SW3_PARAMS)
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TID_WIDTH", int(_DTI_SW3_PARAMS["TID_WIDTH"]))
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW3_PARAMS["PAYLOAD_WIDTH"]))
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW3_PARAMS["NUM_TNIU"]), int(_DTI_SW3_PARAMS["TNIU_DECMIN"])))
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW3_PARAMS["NUM_TNIU"]), int(_DTI_SW3_PARAMS["TNIU_DECMAX"])))
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW3_PARAMS["NUM_INIU"]), int(_DTI_SW3_PARAMS["INIU_DECMIN"])))
dti_sw3_config.set_macro("DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW3_PARAMS["NUM_INIU"]), int(_DTI_SW3_PARAMS["INIU_DECMAX"])))

dti_sw4_config = TemplateIPConfig(
    name="dti_sw4", prefix="dti_sw4_", filelist=_SW_FILELIST, env_var="DTI_SW4_OUT_DIR",
)
_DTI_SW4_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=4,
    TNIU_DECMIN=_TL_MERGE0_TNIU_DECMIN,
    TNIU_DECMAX=_TL_MERGE0_TNIU_DECMAX,
    INIU_DECMIN=_TL_MERGE0_INIU_DECMIN,
    INIU_DECMAX=_TL_MERGE0_INIU_DECMAX,
)
dti_sw4_config.param_overrides = dict(_DTI_SW4_PARAMS)
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_TID_WIDTH", int(_DTI_SW4_PARAMS["TID_WIDTH"]))
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW4_PARAMS["PAYLOAD_WIDTH"]))
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW4_PARAMS["NUM_TNIU"]), int(_DTI_SW4_PARAMS["TNIU_DECMIN"])))
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW4_PARAMS["NUM_TNIU"]), int(_DTI_SW4_PARAMS["TNIU_DECMAX"])))
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW4_PARAMS["NUM_INIU"]), int(_DTI_SW4_PARAMS["INIU_DECMIN"])))
dti_sw4_config.set_macro("DTI_NOC_SWITCH_4TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW4_PARAMS["NUM_INIU"]), int(_DTI_SW4_PARAMS["INIU_DECMAX"])))

dti_sw5_config = TemplateIPConfig(
    name="dti_sw5", prefix="dti_sw5_", filelist=_SW_FILELIST, env_var="DTI_SW5_OUT_DIR",
)
_DTI_SW5_PARAMS = dict(
    _SWITCH_COMMON,
    NUM_INIU=3,
    TNIU_DECMIN=_TOP_SPINE_TNIU_DECMIN,
    TNIU_DECMAX=_TOP_SPINE_TNIU_DECMAX,
    INIU_DECMIN=_TOP_SPINE_INIU_DECMIN,
    INIU_DECMAX=_TOP_SPINE_INIU_DECMAX,
)
dti_sw5_config.param_overrides = dict(_DTI_SW5_PARAMS)
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TID_WIDTH", int(_DTI_SW5_PARAMS["TID_WIDTH"]))
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_PAYLOAD_WIDTH", int(_DTI_SW5_PARAMS["PAYLOAD_WIDTH"]))
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMIN", _sv_param(32 * int(_DTI_SW5_PARAMS["NUM_TNIU"]), int(_DTI_SW5_PARAMS["TNIU_DECMIN"])))
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_TNIU_DECMAX", _sv_param(32 * int(_DTI_SW5_PARAMS["NUM_TNIU"]), int(_DTI_SW5_PARAMS["TNIU_DECMAX"])))
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMIN", _sv_param(32 * int(_DTI_SW5_PARAMS["NUM_INIU"]), int(_DTI_SW5_PARAMS["INIU_DECMIN"])))
dti_sw5_config.set_macro("DTI_NOC_SWITCH_3TO1_WRAP_INIU_DECMAX", _sv_param(32 * int(_DTI_SW5_PARAMS["NUM_INIU"]), int(_DTI_SW5_PARAMS["INIU_DECMAX"])))


dti_req_rsp_async_config = TemplateIPConfig(
    name="dti_req_rsp_async",
    prefix="",
    filelist=_resolve_fl("dti_req_rsp_async.f"),
    env_var="DTI_REQ_RSP_ASYNC_OUT_DIR",
)
_DTI_ASYNC_PARAMS = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}
dti_req_rsp_async_config.param_overrides = dict(_DTI_ASYNC_PARAMS)
dti_req_rsp_async_config.set_macro("DTI_ASYNC_BRIDGE_SLV_PAYLOAD_WIDTH", int(_DTI_ASYNC_PARAMS["PAYLOAD_WIDTH"]))
dti_req_rsp_async_config.set_macro("DTI_ASYNC_BRIDGE_SLV_TID_WIDTH", int(_DTI_ASYNC_PARAMS["TID_WIDTH"]))
dti_req_rsp_async_config.set_macro("DTI_ASYNC_BRIDGE_MST_PAYLOAD_WIDTH", int(_DTI_ASYNC_PARAMS["PAYLOAD_WIDTH"]))
dti_req_rsp_async_config.set_macro("DTI_ASYNC_BRIDGE_MST_TID_WIDTH", int(_DTI_ASYNC_PARAMS["TID_WIDTH"]))

dti_link_pipe_config = TemplateIPConfig(
    name="dti_link_pipe",
    prefix="",
    filelist=_resolve_fl("dti_link_pipe.f"),
    env_var="DTI_LINK_PIPE_OUT_DIR",
)
_DTI_LINK_PIPE_PARAMS = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}
dti_link_pipe_config.param_overrides = dict(_DTI_LINK_PIPE_PARAMS)
dti_link_pipe_config.set_macro("DTI_LINK_PIPE_PAYLOAD_WIDTH", int(_DTI_LINK_PIPE_PARAMS["PAYLOAD_WIDTH"]))
dti_link_pipe_config.set_macro("DTI_LINK_PIPE_TID_WIDTH", int(_DTI_LINK_PIPE_PARAMS["TID_WIDTH"]))

dti_link_buf_config = TemplateIPConfig(
    name="dti_link_buf",
    prefix="",
    filelist=_resolve_fl("dti_link_buf.f"),
    env_var="DTI_LINK_BUF_OUT_DIR",
)
_DTI_LINK_BUF_PARAMS = {"PAYLOAD_WIDTH": 90, "TID_WIDTH": 6}
dti_link_buf_config.param_overrides = dict(_DTI_LINK_BUF_PARAMS)
dti_link_buf_config.set_macro("DTI_LINK_BUF_PAYLOAD_WIDTH", int(_DTI_LINK_BUF_PARAMS["PAYLOAD_WIDTH"]))
dti_link_buf_config.set_macro("DTI_LINK_BUF_TID_WIDTH", int(_DTI_LINK_BUF_PARAMS["TID_WIDTH"]))
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


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


# ── Per-endpoint INIU sys-side configs (TBU_NUM=1 per single-TBU node) ────
# Left-branch initiators: SRCIDs 0-5
pcie_eth_iniu_sys_config = _new_cfg(
    name="pcie_eth_iniu_sys",
    prefix="pcie_eth_",
    filelist_name="dti_iniu_sys.f",
    env_var="PCIE_ETH_INIU_SYS_DIR",
)
pcie_eth_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

vpu_iniu_sys_config = _new_cfg(
    name="vpu_iniu_sys",
    prefix="vpu_",
    filelist_name="dti_iniu_sys.f",
    env_var="VPU_INIU_SYS_DIR",
)
vpu_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

dsp2_iniu_sys_config = _new_cfg(
    name="dsp2_iniu_sys",
    prefix="dsp2_",
    filelist_name="dti_iniu_sys.f",
    env_var="DSP2_INIU_SYS_DIR",
)
dsp2_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

dsp1_iniu_sys_config = _new_cfg(
    name="dsp1_iniu_sys",
    prefix="dsp1_",
    filelist_name="dti_iniu_sys.f",
    env_var="DSP1_INIU_SYS_DIR",
)
dsp1_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

dsp0_iniu_sys_config = _new_cfg(
    name="dsp0_iniu_sys",
    prefix="dsp0_",
    filelist_name="dti_iniu_sys.f",
    env_var="DSP0_INIU_SYS_DIR",
)
dsp0_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

noc_tbu1_iniu_sys_config = _new_cfg(
    name="noc_tbu1_iniu_sys",
    prefix="noc_tbu1_",
    filelist_name="dti_iniu_sys.f",
    env_var="NOC_TBU1_INIU_SYS_DIR",
)
noc_tbu1_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

# Right-branch initiators: SRCIDs 6-10
usb_ufs_iniu_sys_config = _new_cfg(
    name="usb_ufs_iniu_sys",
    prefix="usb_ufs_",
    filelist_name="dti_iniu_sys.f",
    env_var="USB_UFS_INIU_SYS_DIR",
)
usb_ufs_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

mipi0_iniu_sys_config = _new_cfg(
    name="mipi0_iniu_sys",
    prefix="mipi0_",
    filelist_name="dti_iniu_sys.f",
    env_var="MIPI0_INIU_SYS_DIR",
)
mipi0_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

mipi1_iniu_sys_config = _new_cfg(
    name="mipi1_iniu_sys",
    prefix="mipi1_",
    filelist_name="dti_iniu_sys.f",
    env_var="MIPI1_INIU_SYS_DIR",
)
mipi1_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

camera_iniu_sys_config = _new_cfg(
    name="camera_iniu_sys",
    prefix="camera_",
    filelist_name="dti_iniu_sys.f",
    env_var="CAMERA_INIU_SYS_DIR",
)
camera_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}

noc_tbu0_iniu_sys_config = _new_cfg(
    name="noc_tbu0_iniu_sys",
    prefix="noc_tbu0_",
    filelist_name="dti_iniu_sys.f",
    env_var="NOC_TBU0_INIU_SYS_DIR",
)
noc_tbu0_iniu_sys_config.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}


iniu_top_config = _new_cfg(
    name="dti_iniu_top_side",
    prefix="dti_iniu_top_",
    filelist_name="dti_iniu_top.f",
    env_var="DTI_INIU_TOP_DIR",
)


tcu_tniu_sys_config = _new_cfg(
    name="sys_tcu_tniu_sys",
    prefix="sys_tcu_",
    filelist_name="dti_tniu_sys.f",
    env_var="SYS_TCU_TNIU_SYS_DIR",
)


tniu_top_config = _new_cfg(
    name="dti_tniu_top_side",
    prefix="dti_tniu_top_",
    filelist_name="dti_tniu_top.f",
    env_var="DTI_TNIU_TOP_DIR",
)


def _switch_cfg(name: str, prefix: str, filelist_name: str, env_var: str, iniu_ranges, tniu_range) -> TemplateIPConfig:
    cfg = _new_cfg(name=name, prefix=prefix, filelist_name=filelist_name, env_var=env_var)
    params = {
        "DTI_TNIU_MIN": tniu_range[0],
        "DTI_TNIU_MAX": tniu_range[1],
    }
    for idx, (rng_min, rng_max) in enumerate(iniu_ranges):
        params[f"DTI_INIU{idx}_MIN"] = rng_min
        params[f"DTI_INIU{idx}_MAX"] = rng_max
    cfg.param_overrides = params
    return cfg


# ── Switch configs: DECMIN/DECMAX reflect single-TBU-per-endpoint SRCIDs ─
# Left branch: pcie_eth=0, vpu=1, dsp2=2, dsp1=3, dsp0=4, noc_tbu1=5
# Right branch: usb_ufs=6, mipi0=7, mipi1=8, camera=9, noc_tbu0=10
dti_sw_left3_config = _switch_cfg(
    name="dti_sw_left3",
    prefix="dti_sw_left3_",
    filelist_name="dti_switch_3i1o.f",
    env_var="DTI_SW_LEFT3_OUT_DIR",
    iniu_ranges=[(0, 0), (1, 1), (2, 2)],
    tniu_range=(0, 2),
)

dti_sw_left_dsp1_config = _switch_cfg(
    name="dti_sw_left_dsp1",
    prefix="dti_sw_left_dsp1_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_DSP1_OUT_DIR",
    iniu_ranges=[(0, 2), (3, 3)],
    tniu_range=(0, 3),
)

dti_sw_left_dsp0_config = _switch_cfg(
    name="dti_sw_left_dsp0",
    prefix="dti_sw_left_dsp0_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_DSP0_OUT_DIR",
    iniu_ranges=[(0, 3), (4, 4)],
    tniu_range=(0, 4),
)

dti_sw_left_noc1_config = _switch_cfg(
    name="dti_sw_left_noc1",
    prefix="dti_sw_left_noc1_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_NOC1_OUT_DIR",
    iniu_ranges=[(0, 4), (5, 5)],
    tniu_range=(0, 5),
)

dti_sw_right4_config = _switch_cfg(
    name="dti_sw_right4",
    prefix="dti_sw_right4_",
    filelist_name="dti_switch_4i1o.f",
    env_var="DTI_SW_RIGHT4_OUT_DIR",
    iniu_ranges=[(6, 6), (7, 7), (8, 8), (9, 9)],
    tniu_range=(6, 9),
)

dti_sw_right_noc0_config = _switch_cfg(
    name="dti_sw_right_noc0",
    prefix="dti_sw_right_noc0_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_RIGHT_NOC0_OUT_DIR",
    iniu_ranges=[(6, 9), (10, 10)],
    tniu_range=(6, 10),
)

dti_sw_root_config = _switch_cfg(
    name="dti_sw_root",
    prefix="dti_sw_root_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_ROOT_OUT_DIR",
    iniu_ranges=[(0, 5), (6, 10)],
    tniu_range=(0, 43),
)


dti_req_rsp_async_config = _new_cfg(
    name="dti_req_rsp_async",
    prefix="dti_req_rsp_async_",
    filelist_name="dti_req_rsp_async.f",
    env_var="DTI_REQ_RSP_ASYNC_OUT_DIR",
)

dti_link_pipe_config = _new_cfg(
    name="dti_link_pipe",
    prefix="dti_link_pipe_",
    filelist_name="dti_link_pipe.f",
    env_var="DTI_LINK_PIPE_OUT_DIR",
)

dti_link_buf_config = _new_cfg(
    name="dti_link_buf",
    prefix="dti_link_buf_",
    filelist_name="dti_link_buf.f",
    env_var="DTI_LINK_BUF_OUT_DIR",
)
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


INIU_NODE_NAMES = [
    "dsp_ss0",
    "dsp_ss1",
    "dsp_ss2",
    "dsp_ss3",
    "dsp_ss4",
    "dsp_ss5",
    "vpu_ss",
    "pcie_rtg_ss",
    "ufs_ss",
    "camera_ss",
    "mipi_ss",
    "gpu_ss0",
    "gpu_ss1",
    "dp_ss",
    "display_ss",
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
        name=f"{node_name}_iniu_sys",
        prefix=f"{node_name}_",
        filelist_name="dti_iniu_sys.f",
        env_var=f"SOC_DTI_{_to_env_token(node_name)}_INIU_SYS_DIR",
    )
    cfg.param_overrides = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}
    INIU_SYS_CONFIGS[node_name] = cfg


# Level-1 switches (leaf switches, directly connected to INIUs)
# sw_dsp6: DSP SS0-5 [TID 0-5] -> 6-input switch
soc_dti_sw_dsp6_config = _new_cfg(
    name="soc_dti_sw_dsp6",
    prefix="soc_dti_sw_dsp6_",
    filelist_name="dti_switch_6i1o.f",
    env_var="SOC_DTI_SW_DSP6_OUT_DIR",
)
soc_dti_sw_dsp6_config.param_overrides = {
    "DTI_INIU0_MIN": 0,
    "DTI_INIU0_MAX": 0,
    "DTI_INIU1_MIN": 1,
    "DTI_INIU1_MAX": 1,
    "DTI_INIU2_MIN": 2,
    "DTI_INIU2_MAX": 2,
    "DTI_INIU3_MIN": 3,
    "DTI_INIU3_MAX": 3,
    "DTI_INIU4_MIN": 4,
    "DTI_INIU4_MAX": 4,
    "DTI_INIU5_MIN": 5,
    "DTI_INIU5_MAX": 5,
    "DTI_TNIU_MIN": 0,
    "DTI_TNIU_MAX": 5,
}

# sw_io5: VPU(6), PCIE_RTG(7), UFS(8), Camera(9), MIPI(10) -> 5-input switch
soc_dti_sw_io5_config = _new_cfg(
    name="soc_dti_sw_io5",
    prefix="soc_dti_sw_io5_",
    filelist_name="dti_switch_5i1o.f",
    env_var="SOC_DTI_SW_IO5_OUT_DIR",
)
soc_dti_sw_io5_config.param_overrides = {
    "DTI_INIU0_MIN": 6,
    "DTI_INIU0_MAX": 6,
    "DTI_INIU1_MIN": 7,
    "DTI_INIU1_MAX": 7,
    "DTI_INIU2_MIN": 8,
    "DTI_INIU2_MAX": 8,
    "DTI_INIU3_MIN": 9,
    "DTI_INIU3_MAX": 9,
    "DTI_INIU4_MIN": 10,
    "DTI_INIU4_MAX": 10,
    "DTI_TNIU_MIN": 6,
    "DTI_TNIU_MAX": 10,
}

# sw_gpu4: GPU SS0(11), GPU SS1(12), DP SS(13), Display SS(14) -> 4-input switch
soc_dti_sw_gpu4_config = _new_cfg(
    name="soc_dti_sw_gpu4",
    prefix="soc_dti_sw_gpu4_",
    filelist_name="dti_switch_4i1o.f",
    env_var="SOC_DTI_SW_GPU4_OUT_DIR",
)
soc_dti_sw_gpu4_config.param_overrides = {
    "DTI_INIU0_MIN": 11,
    "DTI_INIU0_MAX": 11,
    "DTI_INIU1_MIN": 12,
    "DTI_INIU1_MAX": 12,
    "DTI_INIU2_MIN": 13,
    "DTI_INIU2_MAX": 13,
    "DTI_INIU3_MIN": 14,
    "DTI_INIU3_MAX": 14,
    "DTI_TNIU_MIN": 11,
    "DTI_TNIU_MAX": 14,
}

# Level-2 switch: merges sw_io5 + sw_gpu4 [TID 6-14]
soc_dti_sw_right_config = _new_cfg(
    name="soc_dti_sw_right",
    prefix="soc_dti_sw_right_",
    filelist_name="dti_switch_2i1o.f",
    env_var="SOC_DTI_SW_RIGHT_OUT_DIR",
)
soc_dti_sw_right_config.param_overrides = {
    "DTI_INIU0_MIN": 6,
    "DTI_INIU0_MAX": 10,
    "DTI_INIU1_MIN": 11,
    "DTI_INIU1_MAX": 14,
    "DTI_TNIU_MIN": 6,
    "DTI_TNIU_MAX": 14,
}

# Root switch: merges sw_dsp6 + sw_right [TID 0-14] -> TCUTNIU
soc_dti_sw_root_config = _new_cfg(
    name="soc_dti_sw_root",
    prefix="soc_dti_sw_root_",
    filelist_name="dti_switch_2i1o.f",
    env_var="SOC_DTI_SW_ROOT_OUT_DIR",
)
soc_dti_sw_root_config.param_overrides = {
    "DTI_INIU0_MIN": 0,
    "DTI_INIU0_MAX": 5,
    "DTI_INIU1_MIN": 6,
    "DTI_INIU1_MAX": 14,
    "DTI_TNIU_MIN": 0,
    "DTI_TNIU_MAX": 63,
}

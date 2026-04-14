import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DTI_REPO_ROOT = REPO_ROOT / "subs" / "lwnoc_dti_noc"

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


npu_iniu_sys_config = _new_cfg(
    name="sys_npu_iniu_sys",
    prefix="sys_npu_",
    filelist_name="dti_iniu_sys.f",
    env_var="SYS_NPU_INIU_SYS_DIR",
)
npu_iniu_sys_config.set_macro("TBU_NUM", 4)
npu_iniu_sys_config.set_macro("TRANSACTION_MAX_NUM", 8)


vpu_iniu_sys_config = _new_cfg(
    name="sys_vpu_iniu_sys",
    prefix="sys_vpu_",
    filelist_name="dti_iniu_sys.f",
    env_var="SYS_VPU_INIU_SYS_DIR",
)
vpu_iniu_sys_config.set_macro("TBU_NUM", 1)
vpu_iniu_sys_config.set_macro("TRANSACTION_MAX_NUM", 8)


iniu_top_config = _new_cfg(
    name="dti_iniu_top",
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
    name="dti_tniu_top",
    prefix="dti_tniu_top_",
    filelist_name="dti_tniu_top.f",
    env_var="DTI_TNIU_TOP_DIR",
)


def _switch_cfg(name: str, prefix: str, filelist_name: str, env_var: str, iniu_ranges, tniu_range) -> TemplateIPConfig:
    cfg = _new_cfg(name=name, prefix=prefix, filelist_name=filelist_name, env_var=env_var)
    cfg.set_macro("DTI_TNIU_MIN", tniu_range[0])
    cfg.set_macro("DTI_TNIU_MAX", tniu_range[1])
    for idx, (rng_min, rng_max) in enumerate(iniu_ranges):
        cfg.set_macro(f"DTI_INIU{idx}_MIN", rng_min)
        cfg.set_macro(f"DTI_INIU{idx}_MAX", rng_max)
    return cfg


dti_sw_left3_config = _switch_cfg(
    name="dti_sw_left3",
    prefix="dti_sw_left3_",
    filelist_name="dti_switch_3i1o.f",
    env_var="DTI_SW_LEFT3_OUT_DIR",
    iniu_ranges=[(0, 3), (4, 7), (8, 11)],
    tniu_range=(0, 11),
)

dti_sw_left_dsp1_config = _switch_cfg(
    name="dti_sw_left_dsp1",
    prefix="dti_sw_left_dsp1_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_DSP1_OUT_DIR",
    iniu_ranges=[(0, 11), (12, 15)],
    tniu_range=(0, 15),
)

dti_sw_left_dsp0_config = _switch_cfg(
    name="dti_sw_left_dsp0",
    prefix="dti_sw_left_dsp0_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_DSP0_OUT_DIR",
    iniu_ranges=[(0, 15), (16, 19)],
    tniu_range=(0, 19),
)

dti_sw_left_noc1_config = _switch_cfg(
    name="dti_sw_left_noc1",
    prefix="dti_sw_left_noc1_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_LEFT_NOC1_OUT_DIR",
    iniu_ranges=[(0, 19), (20, 23)],
    tniu_range=(0, 23),
)

dti_sw_right4_config = _switch_cfg(
    name="dti_sw_right4",
    prefix="dti_sw_right4_",
    filelist_name="dti_switch_4i1o.f",
    env_var="DTI_SW_RIGHT4_OUT_DIR",
    iniu_ranges=[(24, 27), (28, 31), (32, 35), (36, 39)],
    tniu_range=(24, 39),
)

dti_sw_right_noc0_config = _switch_cfg(
    name="dti_sw_right_noc0",
    prefix="dti_sw_right_noc0_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_RIGHT_NOC0_OUT_DIR",
    iniu_ranges=[(24, 39), (40, 43)],
    tniu_range=(24, 43),
)

dti_sw_root_config = _switch_cfg(
    name="dti_sw_root",
    prefix="dti_sw_root_",
    filelist_name="dti_switch_2i1o.f",
    env_var="DTI_SW_ROOT_OUT_DIR",
    iniu_ranges=[(0, 23), (24, 43)],
    tniu_range=(0, 43),
)
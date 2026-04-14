import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
STS_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_sts_noc"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


os.environ["RTL_PATH"] = str(STS_NOC_ROOT)
os.environ["STS_INIU"] = str(STS_NOC_ROOT)
os.environ["STS_TNIU"] = str(STS_NOC_ROOT)
os.environ["FCIP_DIR"] = str(STS_NOC_ROOT / "fcip")
os.environ["STS_NOC_DIR"] = str(STS_NOC_ROOT)
os.environ["STS_NOC_DEMO_DIR"] = str(THIS_DIR)


FILELIST_DIR = THIS_DIR / "filelists"

AXI_ADDR_WIDTH = 32
TGT_ID_WIDTH = 8
STS_DEMO_NODE_NUM = 2
STS_DEMO_DEC_SLAVE_NUM = 4
STS_DEMO_DBG_TIMESTAMP_WIDTH = 1
STS_DEMO_DBG_DATA_WIDTH = 1
STS_DEMO_APB_ADDR_WIDTH = 32
STS_DEMO_SYS_APB_MASTER_NUM = 10
STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID = 0xFF


def _sv_hex(width: int, value: int) -> str:
    digits = max(1, (width + 3) // 4)
    return f"{width}'h{value:0{digits}X}"


def _sv_concat(width: int, values: list[int]) -> str:
    return "{" + ",".join(_sv_hex(width, value) for value in values) + "}"


def _tniu_window_bases(tniu_idx: int) -> list[int]:
    return [((tniu_idx * 12) + slot) << 12 for slot in range(11, -1, -1)]


def _tniu_target_ids(tniu_idx: int) -> list[int]:
    local_base = tniu_idx << 4
    sys_base = 0x40 + local_base
    return [sys_base + sys_idx for sys_idx in range(9, -1, -1)] + [local_base + 0x1, local_base + 0x0]


def _apply_macros(cfg: TemplateIPConfig, macros: dict[str, object]) -> TemplateIPConfig:
    for key, value in macros.items():
        cfg.set_macro(key, value)
    return cfg


STS_DEMO_ROUTE_BASE = _sv_concat(TGT_ID_WIDTH, [0x30, 0x20, 0x10, 0x00])
STS_DEMO_ROUTE_MASK = _sv_concat(TGT_ID_WIDTH, [0xB0, 0xB0, 0xB0, 0xB0])

STS_DEMO_ADDR_MAP_BASE_TABLE = _sv_concat(
    AXI_ADDR_WIDTH,
    [base for tniu_idx in range(3, -1, -1) for base in _tniu_window_bases(tniu_idx)],
)
STS_DEMO_ADDR_MAP_MASK_TABLE = _sv_concat(AXI_ADDR_WIDTH, [0xFFFF_F000] * 48)
STS_DEMO_ADDR_MAP_TGT_ID_TABLE = _sv_concat(
    TGT_ID_WIDTH,
    [tgt_id for tniu_idx in range(3, -1, -1) for tgt_id in _tniu_target_ids(tniu_idx)],
)


def _tniu_macros(tniu_idx: int) -> dict[str, object]:
    local_base = tniu_idx << 4
    return {
        "STS_DEMO_APB_ADDR_WIDTH": STS_DEMO_APB_ADDR_WIDTH,
        "STS_DEMO_LOCAL_RSC_TGT_ID": _sv_hex(TGT_ID_WIDTH, local_base + 0x1),
        "STS_DEMO_LOCAL_REGBANK_TGT_ID": _sv_hex(TGT_ID_WIDTH, local_base + 0x0),
        "STS_DEMO_SYS_APB_MASTER_NUM": STS_DEMO_SYS_APB_MASTER_NUM,
        "STS_DEMO_SYS_APB_ROUTE_BASE": _sv_concat(TGT_ID_WIDTH, [0x40 + local_base + idx for idx in range(9, -1, -1)]),
        "STS_DEMO_SYS_APB_ROUTE_MASK": _sv_concat(TGT_ID_WIDTH, [0xFF] * STS_DEMO_SYS_APB_MASTER_NUM),
    }


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


sts_demo_iniu_config = _new_cfg(
    name="sts_demo_iniu",
    prefix="sts_demo_iniu_",
    filelist_name="sts_demo_iniu.f",
    env_var="STS_DEMO_INIU_OUT_DIR",
)
_apply_macros(
    sts_demo_iniu_config,
    {
        "STS_DEMO_NODE_NUM": STS_DEMO_NODE_NUM,
        "STS_DEMO_ADDR_MAP_ENTRY_NUM": 48,
        "STS_DEMO_ADDR_MAP_BASE_TABLE": STS_DEMO_ADDR_MAP_BASE_TABLE,
        "STS_DEMO_ADDR_MAP_MASK_TABLE": STS_DEMO_ADDR_MAP_MASK_TABLE,
        "STS_DEMO_ADDR_MAP_TGT_ID_TABLE": STS_DEMO_ADDR_MAP_TGT_ID_TABLE,
        "STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID": _sv_hex(TGT_ID_WIDTH, STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID),
    },
)

sts_demo_dec4_config = _new_cfg(
    name="sts_demo_dec4",
    prefix="sts_demo_dec4_",
    filelist_name="sts_demo_dec4.f",
    env_var="STS_DEMO_DEC4_OUT_DIR",
)
_apply_macros(
    sts_demo_dec4_config,
    {
        "STS_DEMO_DEC_SLAVE_NUM": STS_DEMO_DEC_SLAVE_NUM,
        "STS_DEMO_ROUTE_BASE": STS_DEMO_ROUTE_BASE,
        "STS_DEMO_ROUTE_MASK": STS_DEMO_ROUTE_MASK,
        "STS_DEMO_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
        "STS_DEMO_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
    },
)

sts_demo_tniu0_config = _new_cfg(
    name="sts_demo_tniu0",
    prefix="sts_demo_tniu0_",
    filelist_name="sts_demo_tniu0.f",
    env_var="STS_DEMO_TNIU0_OUT_DIR",
)
_apply_macros(sts_demo_tniu0_config, _tniu_macros(0))

sts_demo_tniu1_config = _new_cfg(
    name="sts_demo_tniu1",
    prefix="sts_demo_tniu1_",
    filelist_name="sts_demo_tniu1.f",
    env_var="STS_DEMO_TNIU1_OUT_DIR",
)
_apply_macros(sts_demo_tniu1_config, _tniu_macros(1))

sts_demo_tniu2_config = _new_cfg(
    name="sts_demo_tniu2",
    prefix="sts_demo_tniu2_",
    filelist_name="sts_demo_tniu2.f",
    env_var="STS_DEMO_TNIU2_OUT_DIR",
)
_apply_macros(sts_demo_tniu2_config, _tniu_macros(2))

sts_demo_tniu3_config = _new_cfg(
    name="sts_demo_tniu3",
    prefix="sts_demo_tniu3_",
    filelist_name="sts_demo_tniu3.f",
    env_var="STS_DEMO_TNIU3_OUT_DIR",
)
_apply_macros(sts_demo_tniu3_config, _tniu_macros(3))
import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DEFAULT_STS_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_sts_noc"
EXTERNAL_STS_NOC_ROOT = Path("/home/lgzhu/dev/noc_work/lwnoc_sts_noc")
STS_NOC_ROOT = EXTERNAL_STS_NOC_ROOT if EXTERNAL_STS_NOC_ROOT.exists() else DEFAULT_STS_NOC_ROOT

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


def _pack_int(width: int, values: list[int]) -> int:
    """Pack MSB-first values into a single integer for kwargs."""
    result = 0
    mask = (1 << width) - 1
    for v in values:
        result = (result << width) | (v & mask)
    return result


def _sv_param(total_bits: int, value: int) -> str:
    """Format integer as a sized hex literal for slang -G parameter override."""
    hex_digits = max(1, (total_bits + 3) // 4)
    return f"{total_bits}'h{value:0{hex_digits}X}"


def _tniu_window_bases(tniu_idx: int) -> list[int]:
    return [((tniu_idx * 12) + slot) << 12 for slot in range(11, -1, -1)]


def _tniu_target_ids(tniu_idx: int) -> list[int]:
    local_base = tniu_idx << 4
    sys_base = 0x40 + local_base
    return [sys_base + sys_idx for sys_idx in range(9, -1, -1)] + [local_base + 0x1, local_base + 0x0]


STS_DEMO_ROUTE_BASE_INT = _pack_int(TGT_ID_WIDTH, [0x30, 0x20, 0x10, 0x00])
STS_DEMO_ROUTE_MASK_INT = _pack_int(TGT_ID_WIDTH, [0xB0, 0xB0, 0xB0, 0xB0])

STS_DEMO_ADDR_MAP_BASE_TABLE_INT = _pack_int(
    AXI_ADDR_WIDTH,
    [base for tniu_idx in range(3, -1, -1) for base in _tniu_window_bases(tniu_idx)],
)
STS_DEMO_ADDR_MAP_MASK_TABLE_INT = _pack_int(AXI_ADDR_WIDTH, [0xFFFF_F000] * 48)
STS_DEMO_ADDR_MAP_TGT_ID_TABLE_INT = _pack_int(
    TGT_ID_WIDTH,
    [tgt_id for tniu_idx in range(3, -1, -1) for tgt_id in _tniu_target_ids(tniu_idx)],
)


def _tniu_params(tniu_idx: int) -> dict[str, object]:
    local_base = tniu_idx << 4
    route_base_int = _pack_int(TGT_ID_WIDTH, [0x40 + local_base + idx for idx in range(9, -1, -1)])
    route_mask_int = _pack_int(TGT_ID_WIDTH, [0xFF] * STS_DEMO_SYS_APB_MASTER_NUM)
    return {
        "STS_DEMO_APB_ADDR_WIDTH": STS_DEMO_APB_ADDR_WIDTH,
        "STS_DEMO_LOCAL_RSC_TGT_ID": local_base + 0x1,
        "STS_DEMO_LOCAL_REGBANK_TGT_ID": local_base + 0x0,
        "STS_DEMO_SYS_APB_MASTER_NUM": STS_DEMO_SYS_APB_MASTER_NUM,
        "STS_DEMO_SYS_APB_ROUTE_BASE": _sv_param(STS_DEMO_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, route_base_int),
        "STS_DEMO_SYS_APB_ROUTE_MASK": _sv_param(STS_DEMO_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, route_mask_int),
    }


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


sts_demo_iniu_sys_config = _new_cfg(
    name="sts_demo_iniu_sys",
    prefix="sts_demo_iniu_",
    filelist_name="sts_demo_iniu_sys.f",   # sys-side RTL (all except sts_iniu_top.sv + wrap)
    env_var="STS_DEMO_INIU_SYS_OUT_DIR",
)

_iniu_params = {
    "STS_DEMO_NODE_NUM": STS_DEMO_NODE_NUM,
    "STS_DEMO_ADDR_MAP_ENTRY_NUM": 48,
    "STS_DEMO_ADDR_MAP_BASE_TABLE": _sv_param(48 * AXI_ADDR_WIDTH, STS_DEMO_ADDR_MAP_BASE_TABLE_INT),
    "STS_DEMO_ADDR_MAP_MASK_TABLE": _sv_param(48 * AXI_ADDR_WIDTH, STS_DEMO_ADDR_MAP_MASK_TABLE_INT),
    "STS_DEMO_ADDR_MAP_TGT_ID_TABLE": _sv_param(48 * TGT_ID_WIDTH, STS_DEMO_ADDR_MAP_TGT_ID_TABLE_INT),
    "STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID": STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID,
}

sts_demo_iniu_top_side_config = _new_cfg(
    name="sts_demo_iniu_top_side",
    prefix="sts_demo_iniu_",
    filelist_name="sts_demo_iniu.f",
    env_var="STS_DEMO_INIU_TOP_SIDE_OUT_DIR",
)
sts_demo_iniu_top_side_config.param_overrides = _iniu_params

sts_demo_dec4_config = _new_cfg(
    name="sts_demo_dec4",
    prefix="sts_demo_dec4_",
    filelist_name="sts_demo_dec4.f",
    env_var="STS_DEMO_DEC4_OUT_DIR",
)
sts_demo_dec4_config.param_overrides = {
    "STS_DEMO_DEC_SLAVE_NUM": STS_DEMO_DEC_SLAVE_NUM,
    "STS_DEMO_ROUTE_BASE": _sv_param(STS_DEMO_DEC_SLAVE_NUM * TGT_ID_WIDTH, STS_DEMO_ROUTE_BASE_INT),
    "STS_DEMO_ROUTE_MASK": _sv_param(STS_DEMO_DEC_SLAVE_NUM * TGT_ID_WIDTH, STS_DEMO_ROUTE_MASK_INT),
    "STS_DEMO_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
    "STS_DEMO_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
}

# TNIU sys-side: one directory per consumer instance (hierarchical — sts_tniu_top instantiates sts_tniu_sys)
sts_demo_tniu0_sys_config = _new_cfg(
    name="sts_demo_tniu0_sys",
    prefix="sts_demo_tniu0_",      # same prefix as top_side (hierarchical RTL)
    filelist_name="sts_demo_tniu_sys.f",
    env_var="STS_DEMO_TNIU0_SYS_OUT_DIR",
)

sts_demo_tniu1_sys_config = _new_cfg(
    name="sts_demo_tniu1_sys",
    prefix="sts_demo_tniu1_",
    filelist_name="sts_demo_tniu_sys.f",
    env_var="STS_DEMO_TNIU1_SYS_OUT_DIR",
)

sts_demo_tniu2_sys_config = _new_cfg(
    name="sts_demo_tniu2_sys",
    prefix="sts_demo_tniu2_",
    filelist_name="sts_demo_tniu_sys.f",
    env_var="STS_DEMO_TNIU2_SYS_OUT_DIR",
)

sts_demo_tniu3_sys_config = _new_cfg(
    name="sts_demo_tniu3_sys",
    prefix="sts_demo_tniu3_",
    filelist_name="sts_demo_tniu_sys.f",
    env_var="STS_DEMO_TNIU3_SYS_OUT_DIR",
)

# TNIU top-side: one directory per consumer instance (build_logic dir = sts_demo_tniu<N>_top_side)
sts_demo_tniu0_config = _new_cfg(
    name="sts_demo_tniu0_top_side",
    prefix="sts_demo_tniu0_",
    filelist_name="sts_demo_tniu0.f",
    env_var="STS_DEMO_TNIU0_OUT_DIR",
)
sts_demo_tniu0_config.param_overrides = _tniu_params(0)

sts_demo_tniu1_config = _new_cfg(
    name="sts_demo_tniu1_top_side",
    prefix="sts_demo_tniu1_",
    filelist_name="sts_demo_tniu1.f",
    env_var="STS_DEMO_TNIU1_OUT_DIR",
)
sts_demo_tniu1_config.param_overrides = _tniu_params(1)

sts_demo_tniu2_config = _new_cfg(
    name="sts_demo_tniu2_top_side",
    prefix="sts_demo_tniu2_",
    filelist_name="sts_demo_tniu2.f",
    env_var="STS_DEMO_TNIU2_OUT_DIR",
)
sts_demo_tniu2_config.param_overrides = _tniu_params(2)

sts_demo_tniu3_config = _new_cfg(
    name="sts_demo_tniu3_top_side",
    prefix="sts_demo_tniu3_",
    filelist_name="sts_demo_tniu3.f",
    env_var="STS_DEMO_TNIU3_OUT_DIR",
)
sts_demo_tniu3_config.param_overrides = _tniu_params(3)

sts_demo_req_rsp_async_config = _new_cfg(
    name="sts_demo_req_rsp_async",
    prefix="sts_demo_req_rsp_async_",
    filelist_name="sts_demo_req_rsp_async.f",
    env_var="STS_DEMO_REQ_RSP_ASYNC_OUT_DIR",
)

sts_demo_link_pipe_config = _new_cfg(
    name="sts_demo_link_pipe",
    prefix="sts_demo_link_pipe_",
    filelist_name="sts_demo_link_pipe.f",
    env_var="STS_DEMO_LINK_PIPE_OUT_DIR",
)

sts_demo_link_buf_config = _new_cfg(
    name="sts_demo_link_buf",
    prefix="sts_demo_link_buf_",
    filelist_name="sts_demo_link_buf.f",
    env_var="STS_DEMO_LINK_BUF_OUT_DIR",
)
import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DEFAULT_STS_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_sts_noc"
STS_NOC_ROOT = DEFAULT_STS_NOC_ROOT

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


# ── INIU configs ────────────────────────────────────────────────────────────

_iniu_params = {
    "STS_DEMO_NODE_NUM": STS_DEMO_NODE_NUM,
    "STS_DEMO_ADDR_MAP_ENTRY_NUM": 48,
    "STS_DEMO_ADDR_MAP_BASE_TABLE": _sv_param(48 * AXI_ADDR_WIDTH, STS_DEMO_ADDR_MAP_BASE_TABLE_INT),
    "STS_DEMO_ADDR_MAP_MASK_TABLE": _sv_param(48 * AXI_ADDR_WIDTH, STS_DEMO_ADDR_MAP_MASK_TABLE_INT),
    "STS_DEMO_ADDR_MAP_TGT_ID_TABLE": _sv_param(48 * TGT_ID_WIDTH, STS_DEMO_ADDR_MAP_TGT_ID_TABLE_INT),
    "STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID": STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID,
}

aon_ss_iniu_sys_config = TemplateIPConfig(
    name="aon_ss_iniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "iniu_filelist.f"),
    env_var="AON_SS_INIU_SYS_OUT_DIR",
)
aon_ss_iniu_sys_config.param_overrides = _iniu_params

aon_ss_iniu_top_side_config = TemplateIPConfig(
    name="aon_ss_iniu_top_side",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "iniu_filelist.f"),
    env_var="AON_SS_INIU_TOP_SIDE_OUT_DIR",
)
aon_ss_iniu_top_side_config.param_overrides = _iniu_params
aon_ss_iniu_top_side_config.top_wrap = "sts_iniu_top"

# ── Decoder config ──────────────────────────────────────────────────────────

soc_sts_dec4_config = TemplateIPConfig(
    name="soc_sts_dec4",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="SOC_STS_DEC4_OUT_DIR",
)
# Route table: MSB-first slot IDs for each slave port.
# For a 4-input decoder these are [0x30, 0x20, 0x10, 0x00] (SoC address offsets).
# The node slices from the right based on slave_num.
soc_sts_dec4_config._route_base_table = [0x30, 0x20, 0x10, 0x00]
soc_sts_dec4_config._route_mask_val = 0xB0
soc_sts_dec4_config.param_overrides = {
    "STS_DEMO_DEC_SLAVE_NUM": STS_DEMO_DEC_SLAVE_NUM,
    "STS_DEMO_ROUTE_BASE": _sv_param(STS_DEMO_DEC_SLAVE_NUM * TGT_ID_WIDTH, STS_DEMO_ROUTE_BASE_INT),
    "STS_DEMO_ROUTE_MASK": _sv_param(STS_DEMO_DEC_SLAVE_NUM * TGT_ID_WIDTH, STS_DEMO_ROUTE_MASK_INT),
    "STS_DEMO_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
    "STS_DEMO_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
}

# ── TNIU sys-side configs (one per TNIU type, per soc_sts_noc_topo) ─────────
# sts_tniu_top instantiates sts_tniu_sys hierarchically.

vpu_ss_tniu_sys_config = TemplateIPConfig(
    name="vpu_ss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="VPU_SS_TNIU_SYS_OUT_DIR",
)

camera_ss_tniu_sys_config = TemplateIPConfig(
    name="camera_ss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="CAMERA_SS_TNIU_SYS_OUT_DIR",
)

dspss_tniu_sys_config = TemplateIPConfig(
    name="dspss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="DSPSS_TNIU_SYS_OUT_DIR",
)

# ── TNIU top-side configs ───────────────────────────────────────────────────

vpu_ss_tniu_top_side_config = TemplateIPConfig(
    name="vpu_ss_tniu_top_side",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="VPU_SS_TNIU_TOP_SIDE_OUT_DIR",
)
vpu_ss_tniu_top_side_config.param_overrides = _tniu_params(0)
vpu_ss_tniu_top_side_config.top_wrap = "sts_tniu_top"

camera_ss_tniu_top_side_config = TemplateIPConfig(
    name="camera_ss_tniu_top_side",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="CAMERA_SS_TNIU_TOP_SIDE_OUT_DIR",
)
camera_ss_tniu_top_side_config.param_overrides = _tniu_params(1)
camera_ss_tniu_top_side_config.top_wrap = "sts_tniu_top"

dspss_tniu_top_side_config = TemplateIPConfig(
    name="dspss_tniu_top_side",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="DSPSS_TNIU_TOP_SIDE_OUT_DIR",
)
dspss_tniu_top_side_config.param_overrides = _tniu_params(2)
dspss_tniu_top_side_config.top_wrap = "sts_tniu_top"

# ── Utility configs ─────────────────────────────────────────────────────────

soc_sts_req_rsp_async_config = TemplateIPConfig(
    name="soc_sts_req_rsp_async",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="STS_REQ_RSP_ASYNC_OUT_DIR",
)

soc_sts_link_pipe_config = TemplateIPConfig(
    name="soc_sts_link_pipe",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="SOC_STS_LINK_PIPE_OUT_DIR",
)

soc_sts_link_buf_config = TemplateIPConfig(
    name="soc_sts_link_buf",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="SOC_STS_LINK_BUF_OUT_DIR",
)

# Raw async config used by StsReqRspAsyncBridgeSlvNode / StsReqRspAsyncBridgeMstNode
soc_sts_req_rsp_async_raw_config = TemplateIPConfig(
    name="soc_sts_req_rsp_async_raw",
    filelist=soc_sts_req_rsp_async_config.filelist,
    prefix="",
)
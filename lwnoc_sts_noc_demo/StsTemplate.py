import os
import sys
from pathlib import Path
from typing import Mapping, TypedDict


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
DEFAULT_STS_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_sts_noc"


def _export_env_path(name: str, value: Path) -> Path:
    resolved = value.resolve()
    os.environ[name] = str(resolved)
    return resolved


STS_NOC_ROOT = _export_env_path("STS_NOC_DIR", DEFAULT_STS_NOC_ROOT)
STS_INIU_ROOT = _export_env_path("STS_INIU", STS_NOC_ROOT)
STS_TNIU_ROOT = _export_env_path("STS_TNIU", STS_NOC_ROOT)
FCIP_DIR = _export_env_path("FCIP_DIR", STS_NOC_ROOT / "fcip")
STS_INIU_SYS_PUB_F = STS_INIU_ROOT / "vc" / "iniu_sys_pub.f"
STS_INIU_NOC_PUB_F = STS_INIU_ROOT / "vc" / "iniu_noc_pub.f"
STS_TNIU_SYS_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_sys_pub.f"
STS_TNIU_NOC_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_noc_pub.f"
STS_TNIU_TOP_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_top_pub.f"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


_export_env_path("RTL_PATH", STS_NOC_ROOT)
_export_env_path("STS_INIU", STS_INIU_ROOT)
_export_env_path("STS_TNIU", STS_TNIU_ROOT)
_export_env_path("FCIP_DIR", FCIP_DIR)
_export_env_path("STS_NOC_DIR", STS_NOC_ROOT)
_export_env_path("STS_NOC_DEMO_DIR", THIS_DIR)


AXI_ADDR_WIDTH = 32
SRC_ID_WIDTH = 8
TGT_ID_WIDTH = 9
STS_DEMO_DBG_TIMESTAMP_WIDTH = 64
STS_DEMO_DBG_DATA_WIDTH = 32
STS_APB_ADDR_WIDTH = 32
STS_TNIU_SYS_APB_MASTER_NUM = 1
STS_SOC_NIU_CFG_BASE = 0x5700_0000
STS_SOC_NIU_CFG_END = 0x573F_FFFF
STS_SOC_FUNC_STRIDE = 0x0001_0000
STS_SOC_FUNC_WINDOW_MASK = 0xFFFF_0000
STS_SOC_DEBUG_BASE = 0x4800_0000
STS_SOC_DEBUG_END = 0x4FFF_FFFF
STS_SOC_DEBUG_STRIDE = 0x0020_0000
STS_SOC_DEBUG_WINDOW_MASK = 0xFFE0_0000
STS_SOC_FUNC_4KB_MASK = 0xFFFF_F000
STS_SOC_FULL_MASK = 0x1FF
STS_SOC_ADDR_MAP_DEFAULT_TGT_ID = 0x1FF
STS_INIU_NUM = 16
STS_INIU_OT_TOTAL = 264
STS_INIU_SINGLE_OT = 0
STS_SOC_PUBLISH_ENV_DIRS: dict[str, str] = {"STS_SOC_NOC": "."}

MacroValue = int | str


def _sv_hex(width: int, value: int) -> str:
    return f"{width}'h{value:X}"


def _pack_int(width: int, values: list[int]) -> int:
    result = 0
    mask = (1 << width) - 1
    for value in values:
        result = (result << width) | (value & mask)
    return result


def _sv_param(total_bits: int, value: int) -> str:
    return f"{total_bits}'h{value:X}"


def _apply_macro_sets(cfg: TemplateIPConfig, *macro_sets: Mapping[str, MacroValue]) -> TemplateIPConfig:
    for macro_set in macro_sets:
        for macro_name, macro_value in macro_set.items():
            cfg.set_macro(macro_name, macro_value)
    return cfg


def _new_template_cfg(name: str, filelist: str, env_var: str, prefix: str = "") -> TemplateIPConfig:
    cfg = TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=filelist,
        env_var=env_var,
    )
    STS_SOC_PUBLISH_ENV_DIRS[env_var] = name
    return cfg


def _alias_template_env(env_var: str, cfg: TemplateIPConfig) -> None:
    STS_SOC_PUBLISH_ENV_DIRS[env_var] = cfg.name


class StsSocTniuResource(TypedDict):
    key: str
    env_token: str
    canonical: str
    addr_idx: int
    tniu_id: int
    func_base: int
    debug_base: int
    sys_apb_route_base: int
    sys_reg_route_base: int
    local_regbank_tgt_id: int
    local_cti_tgt_id: int
    local_iniu_cti_tgt_id: int
    has_iniu_cti_apb: bool


_STS_SOC_TNIU_ROWS = [
    ("safetyss_aon_local", "AON_LOCAL", "SafetySS(Aon)", 0, 34, True),
    ("cpuss", "CPUSS", "CPUSS", 1, 1, False),
    ("gpuss0", "GPUSS0", "GPUSS0", 2, 2, False),
    ("gpuss1", "GPUSS1", "GPUSS1", 3, 3, False),
    ("npuss0", "NPUSS0", "NPUSS0", 4, 4, False),
    ("npuss1", "NPUSS1", "NPUSS1", 5, 5, False),
    ("npuss2", "NPUSS2", "NPUSS2", 6, 6, False),
    ("npuss3", "NPUSS3", "NPUSS3", 7, 7, False),
    ("npuss4", "NPUSS4", "NPUSS4", 8, 8, False),
    ("mipiss", "MIPISS", "MIPISS", 9, 9, False),
    ("camera_ss", "CAMERASS", "CameraSS", 10, 10, False),
    ("ddrss0", "DDRSS0", "DDRSS0", 11, 11, False),
    ("ddrss1", "DDRSS1", "DDRSS1", 12, 12, False),
    ("ddrss2", "DDRSS2", "DDRSS2", 13, 13, False),
    ("ddrss3", "DDRSS3", "DDRSS3", 14, 14, False),
    ("ddrss4", "DDRSS4", "DDRSS4", 15, 15, False),
    ("ddrss5", "DDRSS5", "DDRSS5", 16, 16, False),
    ("ddrss6", "DDRSS6", "DDRSS6", 17, 17, False),
    ("ddrss7", "DDRSS7", "DDRSS7", 18, 18, False),
    ("ddrss8", "DDRSS8", "DDRSS8", 19, 19, False),
    ("ddrss9", "DDRSS9", "DDRSS9", 20, 20, False),
    ("ddrss10", "DDRSS10", "DDRSS10", 21, 21, False),
    ("ddrss11", "DDRSS11", "DDRSS11", 22, 22, False),
    ("vpuss", "VPUSS", "VPUSS", 23, 23, False),
    ("display_ss", "DISPLAYSS", "DisplaySS", 24, 24, False),
    ("pcie_ethss", "PCIE_ETHSS", "PCIE_ETHSS", 25, 25, False),
    ("vdspss0", "VDSPSS0", "VDSPSS0", 26, 26, False),
    ("vdspss1", "VDSPSS1", "VDSPSS1", 27, 27, False),
    ("vdspss2", "VDSPSS2", "VDSPSS2", 28, 28, False),
    ("vdspss3", "VDSPSS3", "VDSPSS3", 29, 29, False),
    ("vdspss4", "VDSPSS4", "VDSPSS4", 30, 30, False),
    ("vdspss5", "VDSPSS5", "VDSPSS5", 31, 31, False),
    ("usb_dpss", "USB_DPSS", "USB_DPSS", 32, 32, False),
    ("ufsss", "UFSSS", "UFSSS", 33, 33, False),
    ("periss", "PERISS", "PERISS", 34, 35, False),
    ("debug_ss", "DEBUGSS", "DebugSS", 35, 36, False),
    ("mcuss", "MCUSS", "MCUSS", 36, 37, False),
    ("nocss", "NOCSS", "NOCSS", 37, 38, False),
]


STS_SOC_TNIU_RESOURCES: list[StsSocTniuResource] = []
for key, env_token, canonical, addr_idx, tniu_id, has_iniu_cti_apb in _STS_SOC_TNIU_ROWS:
    STS_SOC_TNIU_RESOURCES.append(
        {
            "key": key,
            "env_token": env_token,
            "canonical": canonical,
            "addr_idx": addr_idx,
            "tniu_id": tniu_id,
            "func_base": STS_SOC_NIU_CFG_BASE + (addr_idx * STS_SOC_FUNC_STRIDE),
            "debug_base": STS_SOC_DEBUG_BASE + (addr_idx * STS_SOC_DEBUG_STRIDE),
            "sys_apb_route_base": tniu_id,
            "sys_reg_route_base": 0x040 | tniu_id,
            "local_regbank_tgt_id": 0x080 | tniu_id,
            "local_cti_tgt_id": 0x0C0 | tniu_id,
            "local_iniu_cti_tgt_id": 0x100 | tniu_id,
            "has_iniu_cti_apb": has_iniu_cti_apb,
        }
    )

STS_SOC_TNIU_RESOURCE_BY_NAME = {entry["key"]: entry for entry in STS_SOC_TNIU_RESOURCES}
for entry in STS_SOC_TNIU_RESOURCES:
    func_end = entry["func_base"] | (~STS_SOC_FUNC_WINDOW_MASK & 0xFFFF_FFFF)
    debug_end = entry["debug_base"] | (~STS_SOC_DEBUG_WINDOW_MASK & 0xFFFF_FFFF)
    if not (STS_SOC_NIU_CFG_BASE <= entry["func_base"] <= func_end <= STS_SOC_NIU_CFG_END):
        raise ValueError(f"{entry['key']} func window 0x{entry['func_base']:08X}..0x{func_end:08X} exceeds NIU cfg space")
    if not (STS_SOC_DEBUG_BASE <= entry["debug_base"] <= debug_end <= STS_SOC_DEBUG_END):
        raise ValueError(f"{entry['key']} debug window 0x{entry['debug_base']:08X}..0x{debug_end:08X} exceeds debug space")

_STS_SOC_TNIU_SHARED_CFG_GROUPS = (
    ("gpuss0", ("gpuss0", "gpuss1")),
    ("npuss0", ("npuss0", "npuss1", "npuss2", "npuss3", "npuss4")),
    (
        "ddrss0",
        (
            "ddrss0",
            "ddrss1",
            "ddrss2",
            "ddrss3",
            "ddrss4",
            "ddrss5",
            "ddrss6",
            "ddrss7",
            "ddrss8",
            "ddrss9",
            "ddrss10",
            "ddrss11",
        ),
    ),
    ("vdspss0", ("vdspss0", "vdspss1", "vdspss2", "vdspss3", "vdspss4", "vdspss5")),
)
STS_SOC_TNIU_CFG_REPRESENTATIVE = {
    key: representative
    for representative, keys in _STS_SOC_TNIU_SHARED_CFG_GROUPS
    for key in keys
}
for representative, keys in _STS_SOC_TNIU_SHARED_CFG_GROUPS:
    if representative not in keys:
        raise ValueError(f"TNIU cfg representative {representative} must be listed in its group")
    for key in keys:
        if key not in STS_SOC_TNIU_RESOURCE_BY_NAME:
            raise ValueError(f"unknown TNIU cfg sharing key {key}")


def _tniu_cfg_representative(key: str) -> str:
    return STS_SOC_TNIU_CFG_REPRESENTATIVE.get(key, key)


_STS_SOC_TNIU_FAMILY_NAMES = {
    "gpuss0": "gpuss",
    "npuss0": "npuss",
    "ddrss0": "ddrss",
    "vdspss0": "vdspss",
}


def _tniu_cfg_display_name(key: str) -> str:
    """Return the family display name for a shared-group representative, or the key itself."""
    return _STS_SOC_TNIU_FAMILY_NAMES.get(key, key)


def _build_full_addr_map_entries() -> list[tuple[int, int, int]]:
    entries: list[tuple[int, int, int]] = []
    for entry in reversed(STS_SOC_TNIU_RESOURCES):
        debug_base = entry["debug_base"]
        func_base = entry["func_base"]
        debug_end = debug_base | (~STS_SOC_DEBUG_WINDOW_MASK & 0xFFFF_FFFF)
        func_end = func_base | (~STS_SOC_FUNC_WINDOW_MASK & 0xFFFF_FFFF)
        sys_apb_tgt_id = entry["sys_apb_route_base"]
        local_iniu_cti_tgt_id = entry["local_iniu_cti_tgt_id"]
        local_cti_tgt_id = entry["local_cti_tgt_id"]
        sys_reg_tgt_id = entry["sys_reg_route_base"]
        local_regbank_tgt_id = entry["local_regbank_tgt_id"]

        entries.append((debug_base, debug_end, sys_apb_tgt_id))
        if entry["has_iniu_cti_apb"]:
            entries.append((debug_base + 0x1000, debug_base + 0x1FFF, local_iniu_cti_tgt_id))
        entries.append((debug_base, debug_base + 0x0FFF, local_cti_tgt_id))
        entries.append((func_base, func_end, sys_apb_tgt_id))
        entries.append((func_base + 0x1000, func_base + 0x1FFF, sys_reg_tgt_id))
        entries.append((func_base, func_base + 0x0FFF, local_regbank_tgt_id))
    return entries


STS_SOC_ADDR_MAP_ENTRIES = _build_full_addr_map_entries()
if len(STS_SOC_ADDR_MAP_ENTRIES) != 191:
    raise ValueError(f"expected 191 full-topo address-map entries, got {len(STS_SOC_ADDR_MAP_ENTRIES)}")

STS_SOC_ADDR_MAP_START_TABLE_INT = _pack_int(AXI_ADDR_WIDTH, [entry[0] for entry in STS_SOC_ADDR_MAP_ENTRIES])
STS_SOC_ADDR_MAP_END_TABLE_INT = _pack_int(AXI_ADDR_WIDTH, [entry[1] for entry in STS_SOC_ADDR_MAP_ENTRIES])
STS_SOC_ADDR_MAP_TGT_ID_TABLE_INT = _pack_int(TGT_ID_WIDTH, [entry[2] for entry in STS_SOC_ADDR_MAP_ENTRIES])


STS_SOC_INIU_NODE_IDS = {
    "aon_ss_iniu": 0,
}

STS_COMMON_ID_MACROS = {
    "STS_SRC_ID_WIDTH": SRC_ID_WIDTH,
    "STS_TGT_ID_WIDTH": TGT_ID_WIDTH,
    "STS_TXN_ID_WIDTH": 8,
    "STS_RESERVE_WIDTH": 8,
}

STS_COMMON_CTI_MACROS = {
    "STS_CTI_EVENT_WIDTH": 8,
    "STS_CTI_CHANNEL_WIDTH": 40,
    "STS_CTM_TRIG_WIDTH": 32,
}

STS_COMMON_AXI_BASE_MACROS = {
    "STS_AXI_ADDR_WIDTH": AXI_ADDR_WIDTH,
    "STS_AXI_DATA_WIDTH": 32,
    "STS_AXI_USER_WIDTH": 8,
}

STS_COMMON_AXI_BURST_MACROS = {
    "STS_AXI_AWLEN_WIDTH": 8,
    "STS_AXI_ARLEN_WIDTH": 8,
}

STS_INIU_AXI_ID_MACROS = {
    "STS_AXI_AWID_WIDTH": 8,
    "STS_AXI_ARID_WIDTH": 8,
}

STS_TNIU_AXI_ID_MACROS = {
    "STS_AXI_AWID_WIDTH": 8,
    "STS_AXI_BID_WIDTH": 8,
    "STS_AXI_ARID_WIDTH": 8,
    "STS_AXI_RID_WIDTH": 8,
    "STS_AXI_STRB_WIDTH": 4,
    "STS_AXI_SIZE_WIDTH": 3,
}

STS_INIU_DEBUG_MACROS = {
    "STS_INIU_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
    "STS_INIU_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
}

STS_TNIU_DEBUG_MACROS = {
    "STS_TNIU_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
    "STS_TNIU_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
}

STS_DEC_DEBUG_MACROS = {
    "STS_NETWORK_DEC_DBG_TIMESTAMP_WIDTH": STS_DEMO_DBG_TIMESTAMP_WIDTH,
    "STS_NETWORK_DEC_DBG_DATA_WIDTH": STS_DEMO_DBG_DATA_WIDTH,
}

STS_INIU_STATIC_MACROS = {
    "STS_INIU_FIFO_DEPTH": 16,
    "STS_INIU_SYNC_STAGE": 2,
    "STS_INIU_REQ_FIFO_DEPTH": 16,
    "STS_INIU_RSP_FIFO_DEPTH": 16,
    "STS_INIU_SINGLE_OT": STS_INIU_SINGLE_OT,
    "STS_INIU_ERR_INT_CNT_WIDTH": 8,
    "STS_INIU_SAFETY_TIMEOUT_CYCLES": 16,
    "STS_INIU_NODE_NUM": 2,
    "STS_INIU_NUM": STS_INIU_NUM,
    "STS_INIU_OT_TOTAL": STS_INIU_OT_TOTAL,
}

STS_TNIU_STATIC_MACROS = {
    "STS_TNIU_APB_ADDR_WIDTH": STS_APB_ADDR_WIDTH,
    "STS_TNIU_SYNC_STAGE": 2,
    "STS_TNIU_ASYNC_FIFO_DEPTH": 4,
    "STS_TNIU_FIFO_DEPTH": 16,
    "STS_TNIU_TGT_TYPE_WIDTH": 2,
    "STS_TNIU_LOCAL_APB_TGT_TYPE": "2'b01",
    "STS_TNIU_SYS_APB_MASTER_NUM": STS_TNIU_SYS_APB_MASTER_NUM,
    "STS_TNIU_ERR_INT_CNT_WIDTH": 16,
    "STS_TNIU_REQ_FIFO_DEPTH": 16,
    "STS_TNIU_RSP_FIFO_DEPTH": 16,
    "STS_INIU_SINGLE_OT": STS_INIU_SINGLE_OT,
    "STS_INIU_NUM": STS_INIU_NUM,
    "STS_INIU_OT_TOTAL": STS_INIU_OT_TOTAL,
}

STS_ASYNC_RAW_MACROS = {
    "STS_NETWORK_ASYNC_SYNC_STAGE": 2,
    "STS_NETWORK_ASYNC_FIFO_DEPTH": 16,
    "STS_NETWORK_ASYNC_THRESHOLD_EN": 0,
    "STS_NETWORK_ASYNC_ALMOST_FULL_THRESHOLD": 14,
    "STS_NETWORK_ASYNC_ALMOST_EMPTY_THRESHOLD": 4,
    "STS_NETWORK_ASYNC_DATA_WIDTH": 120,
    "STS_NETWORK_ASYNC_ERR_INT_CNT_WIDTH": 16,
    "STS_NETWORK_ASYNC_VT_TYPE": 1,
}


STS_SOC_DECODER_ROUTE_GROUPS = {
    "sts_dec_l0_root": (
        ("safetyss_aon_local",),
        ("npuss1",),
        ("display_ss",),
        ("vpuss",),
        ("usb_dpss",),
        ("mipiss",),
        ("gpuss1",),
        ("nocss",),
        ("camera_ss", "mcuss", "periss", "npuss0", "debug_ss", "cpuss", "ddrss0", "ddrss1", "ddrss2", "ddrss3", "ddrss4", "ddrss5"),
        ("vdspss0", "vdspss1", "vdspss2", "ddrss6", "ddrss7", "ddrss8", "vdspss3", "vdspss4", "vdspss5", "ddrss9", "ddrss10", "ddrss11", "npuss2", "npuss3", "npuss4", "gpuss0", "ufsss", "pcie_ethss"),
    ),
    "sts_dec_l1_upper_ctrl": (
        ("camera_ss",),
        ("mcuss",),
        ("periss",),
        ("npuss0",),
        ("debug_ss",),
        ("cpuss",),
        ("ddrss0", "ddrss1", "ddrss2", "ddrss3", "ddrss4", "ddrss5"),
    ),
    "sts_dec_l2_left_ddr": (
        ("ddrss0",),
        ("ddrss1",),
        ("ddrss2",),
        ("ddrss3",),
        ("ddrss4",),
        ("ddrss5",),
    ),
    "sts_dec_l1_right_upper": (
        ("vdspss0",),
        ("vdspss1",),
        ("vdspss2",),
        ("ddrss6",),
        ("ddrss7",),
        ("ddrss8",),
        ("vdspss3", "vdspss4", "vdspss5", "ddrss9", "ddrss10", "ddrss11", "npuss2", "npuss3", "npuss4", "gpuss0", "ufsss", "pcie_ethss"),
    ),
    "sts_dec_l2_right_lower": (
        ("vdspss3",),
        ("vdspss4",),
        ("vdspss5",),
        ("ddrss9",),
        ("ddrss10",),
        ("ddrss11",),
        ("npuss2", "npuss3", "npuss4", "gpuss0", "ufsss", "pcie_ethss"),
    ),
    "sts_dec_l3_lower_mid": (
        ("npuss2",),
        ("npuss3",),
        ("npuss4",),
        ("gpuss0",),
        ("ufsss",),
        ("pcie_ethss",),
    ),
}


def _zero_route_literal(slave_num: int) -> str:
    return _sv_param(slave_num * TGT_ID_WIDTH, 0)


def _route_dst_width(slave_num: int) -> int:
    return max(1, (slave_num - 1).bit_length())


def _build_dec_route_lut(route_groups: tuple[tuple[str, ...], ...]) -> tuple[int, int, tuple[int, ...], tuple[int, ...]]:
    entry_num = 1 << TGT_ID_WIDTH
    route_vld_bits = [0] * entry_num
    route_dst_by_tgt_id = [0] * entry_num
    route_dst_width = _route_dst_width(len(route_groups))
    route_vld_int = 0
    route_dst_int = 0

    for slot_idx, route_group in enumerate(route_groups):
        for leaf_name in route_group:
            tgt_id = STS_SOC_TNIU_RESOURCE_BY_NAME[leaf_name]["tniu_id"]
            if route_vld_bits[tgt_id]:
                raise ValueError(f"duplicate tgt_id {tgt_id} in decoder route groups")
            route_vld_bits[tgt_id] = 1
            route_dst_by_tgt_id[tgt_id] = slot_idx
            route_vld_int |= 1 << tgt_id
            route_dst_int |= slot_idx << (tgt_id * route_dst_width)

    return route_vld_int, route_dst_int, tuple(route_vld_bits), tuple(route_dst_by_tgt_id)


def _apply_iniu_macros(cfg: TemplateIPConfig) -> TemplateIPConfig:
    return _apply_macro_sets(
        cfg,
        STS_COMMON_ID_MACROS,
        STS_COMMON_AXI_BASE_MACROS,
        STS_COMMON_AXI_BURST_MACROS,
        STS_INIU_AXI_ID_MACROS,
        STS_COMMON_CTI_MACROS,
        STS_INIU_DEBUG_MACROS,
        STS_INIU_STATIC_MACROS,
        {
            "STS_INIU_ADDR_MAP_ENTRY_NUM": len(STS_SOC_ADDR_MAP_ENTRIES),
            "STS_INIU_ADDR_MAP_START_TABLE": _sv_param(len(STS_SOC_ADDR_MAP_ENTRIES) * AXI_ADDR_WIDTH, STS_SOC_ADDR_MAP_START_TABLE_INT),
            "STS_INIU_ADDR_MAP_END_TABLE": _sv_param(len(STS_SOC_ADDR_MAP_ENTRIES) * AXI_ADDR_WIDTH, STS_SOC_ADDR_MAP_END_TABLE_INT),
            "STS_INIU_ADDR_MAP_TGT_ID_TABLE": _sv_param(len(STS_SOC_ADDR_MAP_ENTRIES) * TGT_ID_WIDTH, STS_SOC_ADDR_MAP_TGT_ID_TABLE_INT),
            "STS_INIU_ADDR_MAP_DEFAULT_TGT_ID": STS_SOC_ADDR_MAP_DEFAULT_TGT_ID,
        },
    )


def _apply_tniu_macros(cfg: TemplateIPConfig, tniu_name: str) -> TemplateIPConfig:
    entry = STS_SOC_TNIU_RESOURCE_BY_NAME[tniu_name]
    _apply_macro_sets(
        cfg,
        STS_COMMON_ID_MACROS,
        STS_COMMON_AXI_BASE_MACROS,
        STS_COMMON_AXI_BURST_MACROS,
        STS_TNIU_AXI_ID_MACROS,
        STS_COMMON_CTI_MACROS,
        STS_TNIU_DEBUG_MACROS,
        STS_TNIU_STATIC_MACROS,
        {
            "STS_TNIU_LOCAL_RSC_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_regbank_tgt_id"]),
            "STS_TNIU_LOCAL_REGBANK_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_regbank_tgt_id"]),
            "STS_TNIU_LOCAL_CTI_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_cti_tgt_id"]),
            "STS_TNIU_SYS_APB_ROUTE_BASE": _sv_param(STS_TNIU_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, entry["sys_apb_route_base"]),
            "STS_TNIU_SYS_APB_ROUTE_MASK": _sv_param(STS_TNIU_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, STS_SOC_FULL_MASK),
        },
    )
    cfg._canonical_name = entry["canonical"]
    cfg._tniu_id = entry["tniu_id"]
    cfg._func_base = entry["func_base"]
    cfg._debug_base = entry["debug_base"]
    cfg._local_iniu_cti_tgt_id = entry["local_iniu_cti_tgt_id"]
    cfg._has_iniu_cti_apb = entry["has_iniu_cti_apb"]
    cfg._sys_reg_route_base = entry["sys_reg_route_base"]
    cfg._sys_apb_route_base = entry["sys_apb_route_base"]
    return cfg


def _apply_dec_config(cfg: TemplateIPConfig, dec_name: str) -> TemplateIPConfig:
    route_groups = STS_SOC_DECODER_ROUTE_GROUPS[dec_name]
    slave_num = len(route_groups)
    route_dst_width = _route_dst_width(slave_num)
    route_vld_int, route_dst_int, route_vld_bits, route_dst_by_tgt_id = _build_dec_route_lut(route_groups)
    cfg.top_wrap = f"sts_noc_dec_node_1to{slave_num}_wrap"
    _apply_macro_sets(
        cfg,
        STS_COMMON_ID_MACROS,
        STS_COMMON_AXI_BASE_MACROS,
        STS_COMMON_CTI_MACROS,
        STS_DEC_DEBUG_MACROS,
        {
            "STS_NETWORK_DEC_SLAVE_NUM": slave_num,
            "STS_NETWORK_DEC_ROUTE_VLD_TABLE": _sv_param(1 << TGT_ID_WIDTH, route_vld_int),
            "STS_NETWORK_DEC_ROUTE_DST_TABLE": _sv_param((1 << TGT_ID_WIDTH) * route_dst_width, route_dst_int),
            "STS_NETWORK_DEC_ROUTE_BASE": _zero_route_literal(slave_num),
            "STS_NETWORK_DEC_ROUTE_MASK": _zero_route_literal(slave_num),
        },
    )
    wrap_macro_prefix = f"STS_NOC_DEC_NODE_1TO{slave_num}_WRAP"
    _apply_macro_sets(
        cfg,
        {
            f"{wrap_macro_prefix}_ROUTE_VLD_TABLE": _sv_param(1 << TGT_ID_WIDTH, route_vld_int),
            f"{wrap_macro_prefix}_ROUTE_DST_TABLE": _sv_param((1 << TGT_ID_WIDTH) * route_dst_width, route_dst_int),
            f"{wrap_macro_prefix}_ROUTE_BASE": _zero_route_literal(slave_num),
            f"{wrap_macro_prefix}_ROUTE_MASK": _zero_route_literal(slave_num),
        },
    )
    cfg._slave_num = slave_num
    cfg._route_vld_table = route_vld_bits
    cfg._route_dst_table = route_dst_by_tgt_id
    cfg._route_group_names = route_groups
    cfg._route_group_tgt_ids = tuple(
        tuple(STS_SOC_TNIU_RESOURCE_BY_NAME[leaf_name]["tniu_id"] for leaf_name in route_group)
        for route_group in route_groups
    )
    cfg._route_base_table = tuple(0 for _ in route_groups)
    cfg._route_mask_table = tuple(0 for _ in route_groups)
    return cfg


aon_ss_iniu_sys_config = _apply_iniu_macros(
    _new_template_cfg(
        name="aon_ss_iniu_sys",
        filelist=str(STS_INIU_SYS_PUB_F),
        env_var="AON_SS_INIU_SYS_OUT_DIR",
    )
)

aon_ss_iniu_noc_side_config = _apply_iniu_macros(
    _new_template_cfg(
        name="aon_ss_iniu_noc_side",
        filelist=str(STS_INIU_NOC_PUB_F),
        env_var="AON_SS_INIU_NOC_SIDE_OUT_DIR",
    )
)
aon_ss_iniu_noc_side_config.top_wrap = "sts_iniu_noc"


sts_dec_l0_root_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l0_root",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L0_ROOT_OUT_DIR",
    ),
    "sts_dec_l0_root",
)

sts_dec_l1_upper_ctrl_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l1_upper_ctrl",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L1_UPPER_CTRL_OUT_DIR",
    ),
    "sts_dec_l1_upper_ctrl",
)

sts_dec_l2_left_ddr_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l2_left_ddr",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L2_LEFT_DDR_OUT_DIR",
    ),
    "sts_dec_l2_left_ddr",
)

sts_dec_l1_right_upper_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l1_right_upper",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L1_RIGHT_UPPER_OUT_DIR",
    ),
    "sts_dec_l1_right_upper",
)

sts_dec_l2_right_lower_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l2_right_lower",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L2_RIGHT_LOWER_OUT_DIR",
    ),
    "sts_dec_l2_right_lower",
)

sts_dec_l3_lower_mid_config = _apply_dec_config(
    _new_template_cfg(
        name="sts_dec_l3_lower_mid",
        filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
        env_var="STS_DEC_L3_LOWER_MID_OUT_DIR",
    ),
    "sts_dec_l3_lower_mid",
)

STS_SOC_DECODER_CONFIGS = {
    "sts_dec_l0_root": sts_dec_l0_root_config,
    "sts_dec_l1_upper_ctrl": sts_dec_l1_upper_ctrl_config,
    "sts_dec_l2_left_ddr": sts_dec_l2_left_ddr_config,
    "sts_dec_l1_right_upper": sts_dec_l1_right_upper_config,
    "sts_dec_l2_right_lower": sts_dec_l2_right_lower_config,
    "sts_dec_l3_lower_mid": sts_dec_l3_lower_mid_config,
}


STS_SOC_TNIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {}
STS_SOC_TNIU_NOC_CONFIGS: dict[str, TemplateIPConfig] = {}
STS_SOC_TNIU_TOP_CONFIGS: dict[str, TemplateIPConfig] = {}
STS_SOC_TNIU_TOP_NOC_SIDE_CONFIG = _apply_tniu_macros(
    _new_template_cfg(
        name="sts_soc_tniu_noc_side",
        filelist=str(STS_TNIU_TOP_PUB_F),
        env_var="STS_SOC_TNIU_NOC_SIDE_OUT_DIR",
    ),
    "ddrss0",
)
for entry in STS_SOC_TNIU_RESOURCES:
    key = str(entry["key"])
    env_token = str(entry["env_token"])
    cfg_key = _tniu_cfg_representative(key)
    if cfg_key not in STS_SOC_TNIU_SYS_CONFIGS:
        display = _tniu_cfg_display_name(cfg_key)
        display_env = display.upper()
        sys_cfg = _apply_tniu_macros(
            _new_template_cfg(
                name=f"{display}_tniu_sys",
                filelist=str(STS_TNIU_SYS_PUB_F),
                env_var=f"{display_env}_TNIU_SYS_OUT_DIR",
            ),
            cfg_key,
        )
        noc_cfg = _apply_tniu_macros(
            _new_template_cfg(
                name=f"{display}_tniu_noc_side",
                filelist=str(STS_TNIU_NOC_PUB_F),
                env_var=f"{display_env}_TNIU_NOC_SIDE_OUT_DIR",
            ),
            cfg_key,
        )
        STS_SOC_TNIU_SYS_CONFIGS[cfg_key] = sys_cfg
        STS_SOC_TNIU_NOC_CONFIGS[cfg_key] = noc_cfg
    else:
        sys_cfg = STS_SOC_TNIU_SYS_CONFIGS[cfg_key]
        noc_cfg = STS_SOC_TNIU_NOC_CONFIGS[cfg_key]
    top_cfg = STS_SOC_TNIU_TOP_NOC_SIDE_CONFIG

    _alias_template_env(f"{env_token}_TNIU_SYS_OUT_DIR", sys_cfg)
    _alias_template_env(f"{env_token}_TNIU_NOC_SIDE_OUT_DIR", noc_cfg)
    STS_SOC_TNIU_SYS_CONFIGS[key] = sys_cfg
    STS_SOC_TNIU_NOC_CONFIGS[key] = noc_cfg
    STS_SOC_TNIU_TOP_CONFIGS[key] = top_cfg

STS_SOC_TNIU_CONFIGS = {
    key: (STS_SOC_TNIU_SYS_CONFIGS[key], STS_SOC_TNIU_NOC_CONFIGS[key])
    for key in STS_SOC_TNIU_SYS_CONFIGS
}


soc_sts_req_rsp_async_config = _new_template_cfg(
    name="soc_sts_req_rsp_async",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="STS_REQ_RSP_ASYNC_OUT_DIR",
)

soc_sts_link_pipe_config = _new_template_cfg(
    name="soc_sts_link_pipe",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="SOC_STS_LINK_PIPE_OUT_DIR",
)

soc_sts_link_buf_config = _new_template_cfg(
    name="soc_sts_link_buf",
    filelist=str(STS_NOC_ROOT / "vc" / "network_filelist.f"),
    env_var="SOC_STS_LINK_BUF_OUT_DIR",
)

soc_sts_req_rsp_async_raw_config = _new_template_cfg(
    name="soc_sts_req_rsp_async_raw",
    filelist=soc_sts_req_rsp_async_config.filelist,
    env_var="SOC_STS_REQ_RSP_ASYNC_RAW_OUT_DIR",
)
_apply_macro_sets(soc_sts_req_rsp_async_raw_config, STS_ASYNC_RAW_MACROS)

import os
import sys
from pathlib import Path
from typing import Mapping, TypedDict

from _project_env import LWNOC_TOPO_ROOT, REPO_ROOT, THIS_DIR

# ═══════════════════════════════════════════════════════════════════════════════
# PATHS — edit these to match your environment, or leave ""
#         and set the corresponding env var instead.
# ═══════════════════════════════════════════════════════════════════════════════
_HARDCODED_PATHS = {
    "STS_NOC_DIR":             "",   # e.g. "/home/lgzhu/dev/noc_work/lwnoc_sts_noc"
    "STS_INIU":                "",
    "STS_TNIU":                "",
    "FCIP_DIR":                "",
    "RTL_PATH":                "",
    "STS_NOC_DEMO_DIR":        "",
}


def _resolve_path(name: str) -> Path:
    """Use hardcoded path if set, else env var, else error."""
    hard = _HARDCODED_PATHS.get(name, "").strip()
    if hard:
        return Path(hard)
    val = os.environ.get(name)
    if val:
        return Path(val)
    print(f"[ERROR] ${name} is not set in your shell or in _HARDCODED_PATHS.")
    print(f"  bash:  export {name}=<absolute/path>")
    print(f"  csh:   setenv {name} <absolute/path>")
    raise SystemExit(f"Missing path for: {name}")


STS_NOC_ROOT = _resolve_path("STS_NOC_DIR")
STS_INIU_ROOT = _resolve_path("STS_INIU") if _HARDCODED_PATHS.get("STS_INIU", "").strip() or os.environ.get("STS_INIU") else STS_NOC_ROOT
STS_TNIU_ROOT = _resolve_path("STS_TNIU") if _HARDCODED_PATHS.get("STS_TNIU", "").strip() or os.environ.get("STS_TNIU") else STS_NOC_ROOT
FCIP_DIR = _resolve_path("FCIP_DIR")
STS_INIU_SYS_PUB_F = STS_INIU_ROOT / "vc" / "iniu_sys_pub.f"
STS_INIU_NOC_PUB_F = STS_INIU_ROOT / "vc" / "iniu_noc_pub.f"
STS_TNIU_SYS_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_sys_pub.f"
STS_TNIU_NOC_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_noc_pub.f"
STS_TNIU_TOP_PUB_F = STS_TNIU_ROOT / "vc" / "tniu_top_pub.f"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

# export derived paths to os.environ for downstream consumers
for _k, _v in (("RTL_PATH", STS_NOC_ROOT), ("STS_INIU", STS_INIU_ROOT),
               ("STS_TNIU", STS_TNIU_ROOT), ("FCIP_DIR", FCIP_DIR),
               ("STS_NOC_DIR", STS_NOC_ROOT), ("STS_NOC_DEMO_DIR", THIS_DIR)):
    os.environ.setdefault(_k, str(_v))


AXI_ADDR_WIDTH = 32
SRC_ID_WIDTH = 8
TGT_ID_WIDTH = 9
STS_DEMO_DBG_TIMESTAMP_WIDTH = 64
STS_DEMO_DBG_DATA_WIDTH = 32
STS_APB_ADDR_WIDTH = 32
STS_TNIU_SYS_APB_MASTER_NUM = 1
STS_SOC_FUNC_4KB_MASK = 0xFFFF_F000
STS_SOC_FUNC_128KB_MASK = 0xFFFE_0000
STS_SOC_DEBUG_32MB_MASK = 0xFE00_0000
STS_SOC_FULL_MASK = 0x1FF
STS_SOC_FUNC_ADDR_OFFSET = 0x0800_0000
STS_SOC_ADDR_MAP_DEFAULT_TGT_ID = 0x1FF
STS_INIU_NUM = 16
STS_INIU_OT_TOTAL = 264
STS_INIU_SINGLE_OT = 0
STS_SOC_PUBLISH_ENV_DIRS: dict[str, str] = {"STS_SOC_NOC": "."}

MacroValue = int | str


def _sv_hex(width: int, value: int) -> str:
    digits = max(1, (width + 3) // 4)
    return f"{width}'h{value:0{digits}X}"


def _pack_int(width: int, values: list[int]) -> int:
    result = 0
    mask = (1 << width) - 1
    for value in values:
        result = (result << width) | (value & mask)
    return result


def _sv_param(total_bits: int, value: int) -> str:
    digits = max(1, (total_bits + 3) // 4)
    return f"{total_bits}'h{value:0{digits}X}"


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
            "func_base": addr_idx * 0x0002_0000,
            "debug_base": 0x0200_0000 + (addr_idx * 0x0200_0000),
            "sys_apb_route_base": tniu_id,
            "sys_reg_route_base": 0x040 | tniu_id,
            "local_regbank_tgt_id": 0x080 | tniu_id,
            "local_cti_tgt_id": 0x0C0 | tniu_id,
            "local_iniu_cti_tgt_id": 0x100 | tniu_id,
            "has_iniu_cti_apb": has_iniu_cti_apb,
        }
    )

STS_SOC_TNIU_RESOURCE_BY_NAME = {entry["key"]: entry for entry in STS_SOC_TNIU_RESOURCES}

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


STS_SOC_ADDR_MAP_SOURCE_ROWS: tuple[tuple[str, str, int, int, str, int, int], ...] = (
    ("func", "CPU niu", 0x08000000, 0x0800FFFF, "cpuss", 1, 0x001),
    ("func", "GPU0 niu", 0x08010000, 0x0801FFFF, "gpuss0", 2, 0x002),
    ("func", "GPU1 niu", 0x08020000, 0x0802FFFF, "gpuss1", 3, 0x003),
    ("func", "NPU0 niu", 0x08030000, 0x0803FFFF, "npuss0", 4, 0x004),
    ("func", "NPU1 niu", 0x08040000, 0x0804FFFF, "npuss1", 5, 0x005),
    ("func", "NPU2 niu", 0x08050000, 0x0805FFFF, "npuss2", 6, 0x006),
    ("func", "NPU3 niu", 0x08060000, 0x0806FFFF, "npuss3", 7, 0x007),
    ("func", "NPU4 niu", 0x08070000, 0x0807FFFF, "npuss4", 8, 0x008),
    ("func", "MIPI niu", 0x08080000, 0x0808FFFF, "mipiss", 9, 0x009),
    ("func", "Camera niu", 0x08090000, 0x0809FFFF, "camera_ss", 10, 0x00A),
    ("func", "DDR0 niu", 0x080A0000, 0x080AFFFF, "ddrss0", 11, 0x00B),
    ("func", "DDR1 niu", 0x080B0000, 0x080BFFFF, "ddrss1", 12, 0x00C),
    ("func", "DDR2 niu", 0x080C0000, 0x080CFFFF, "ddrss2", 13, 0x00D),
    ("func", "DDR3 niu", 0x080D0000, 0x080DFFFF, "ddrss3", 14, 0x00E),
    ("func", "DDR4 niu", 0x080E0000, 0x080EFFFF, "ddrss4", 15, 0x00F),
    ("func", "DDR5 niu", 0x080F0000, 0x080FFFFF, "ddrss5", 16, 0x010),
    ("func", "DDR6 niu", 0x08100000, 0x0810FFFF, "ddrss6", 17, 0x011),
    ("func", "DDR7 niu", 0x08110000, 0x0811FFFF, "ddrss7", 18, 0x012),
    ("func", "DDR8 niu", 0x08120000, 0x0812FFFF, "ddrss8", 19, 0x013),
    ("func", "DDR9 niu", 0x08130000, 0x0813FFFF, "ddrss9", 20, 0x014),
    ("func", "DDR10 niu", 0x08140000, 0x0814FFFF, "ddrss10", 21, 0x015),
    ("func", "DDR11 niu", 0x08150000, 0x0815FFFF, "ddrss11", 22, 0x016),
    ("func", "VPU niu", 0x08160000, 0x0816FFFF, "vpuss", 23, 0x017),
    ("func", "Display niu", 0x08170000, 0x0817FFFF, "display_ss", 24, 0x018),
    ("func", "PCIE_ETH niu", 0x08180000, 0x0818FFFF, "pcie_ethss", 25, 0x019),
    ("func", "VDSP0 niu", 0x08190000, 0x0819FFFF, "vdspss0", 26, 0x01A),
    ("func", "VDSP1 niu", 0x081A0000, 0x081AFFFF, "vdspss1", 27, 0x01B),
    ("func", "VDSP2 niu", 0x081B0000, 0x081BFFFF, "vdspss2", 28, 0x01C),
    ("func", "VDSP3 niu", 0x081C0000, 0x081CFFFF, "vdspss3", 29, 0x01D),
    ("func", "VDSP4 niu", 0x081D0000, 0x081DFFFF, "vdspss4", 30, 0x01E),
    ("func", "VDSP5 niu", 0x081E0000, 0x081EFFFF, "vdspss5", 31, 0x01F),
    ("func", "USB_DP niu", 0x081F0000, 0x081FFFFF, "usb_dpss", 32, 0x020),
    ("func", "UFS niu", 0x08200000, 0x0820FFFF, "ufsss", 33, 0x021),
    ("func", "Safety niu", 0x08210000, 0x0821FFFF, "safetyss_aon_local", 34, 0x022),
    ("func", "PERI niu", 0x08220000, 0x0822FFFF, "periss", 35, 0x023),
    ("func", "Debug niu", 0x08230000, 0x0823FFFF, "debug_ss", 36, 0x024),
    ("func", "Audio niu", 0x08240000, 0x0824FFFF, "periss", 35, 0x023),
    ("func", "MCU niu", 0x08250000, 0x0825FFFF, "mcuss", 37, 0x025),
    ("func", "Noc niu", 0x08260000, 0x0826FFFF, "nocss", 38, 0x026),
    ("debug", "ROMTABLE", 0x00000000, 0x003FFFFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "SAFETY CL0 R52 ROM TABLE", 0x00400000, 0x007FFFFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "SAFETY CL1 R52 ROM TABLE", 0x00800000, 0x00BFFFFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "SAFETY CL0 Funnel8", 0x00C00000, 0x00C00FFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "SAFETY CL1 Funnel8", 0x00C01000, 0x00C01FFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "SAFETY Funnel2", 0x00C02000, 0x00C02FFF, "safetyss_aon_local", 34, 0x022),
    ("debug", "CPU CL0 ROM TABLE", 0x02000000, 0x027FFFFF, "cpuss", 1, 0x001),
    ("debug", "CPU CL1 ROM TABLE", 0x02800000, 0x02FFFFFF, "cpuss", 1, 0x001),
    ("debug", "CPU CL2 ROM TABLE", 0x03000000, 0x037FFFFF, "cpuss", 1, 0x001),
    ("debug", "CPU CL3 ROM TABLE", 0x03800000, 0x03DFFFFF, "cpuss", 1, 0x001),
    ("debug", "CPU Funnel2", 0x03E00000, 0x03E00FFF, "cpuss", 1, 0x001),
    ("debug", "CPU CTI", 0x03E01000, 0x03E01FFF, "cpuss", 1, 0x001),
    ("debug", "MCU Core0", 0x04000000, 0x043FFFFF, "mcuss", 37, 0x025),
    ("debug", "MCU Core1", 0x04400000, 0x047FFFFF, "mcuss", 37, 0x025),
    ("debug", "MCU Core2", 0x04800000, 0x04BFFFFF, "mcuss", 37, 0x025),
    ("debug", "MCU Core3", 0x04C00000, 0x04FFFFFF, "mcuss", 37, 0x025),
    ("debug", "MCU Funnel", 0x05000000, 0x05000FFF, "mcuss", 37, 0x025),
    ("debug", "GPU0", 0x06000000, 0x065FFFFF, "gpuss0", 2, 0x002),
    ("debug", "GPU0 CTI", 0x06600000, 0x06600FFF, "gpuss0", 2, 0x002),
    ("debug", "GPU1", 0x06800000, 0x06DFFFFF, "gpuss1", 3, 0x003),
    ("debug", "GPU1 CTI", 0x06E00000, 0x06E00FFF, "gpuss1", 3, 0x003),
    ("debug", "VDSP0", 0x07000000, 0x07003FFF, "vdspss0", 26, 0x01A),
    ("debug", "VDSP0 CTI", 0x07004000, 0x07004FFF, "vdspss0", 26, 0x01A),
    ("debug", "VDSP1", 0x07008000, 0x0700BFFF, "vdspss1", 27, 0x01B),
    ("debug", "VDSP1 CTI", 0x0700C000, 0x0700CFFF, "vdspss1", 27, 0x01B),
    ("debug", "VDSP2", 0x07010000, 0x07013FFF, "vdspss2", 28, 0x01C),
    ("debug", "VDSP2 CTI", 0x07014000, 0x07014FFF, "vdspss2", 28, 0x01C),
    ("debug", "VDSP3", 0x07018000, 0x0701BFFF, "vdspss3", 29, 0x01D),
    ("debug", "VDSP3 CTI", 0x0701C000, 0x0701CFFF, "vdspss3", 29, 0x01D),
    ("debug", "VDSP4", 0x07020000, 0x07023FFF, "vdspss4", 30, 0x01E),
    ("debug", "VDSP4 CTI", 0x07024000, 0x07024FFF, "vdspss4", 30, 0x01E),
    ("debug", "VDSP5", 0x07028000, 0x0702BFFF, "vdspss5", 31, 0x01F),
    ("debug", "VDSP5 CTI", 0x0702C000, 0x0702CFFF, "vdspss5", 31, 0x01F),
    ("debug", "Camera Funnel", 0x07400000, 0x07400FFF, "camera_ss", 10, 0x00A),
    ("debug", "Camera CTI", 0x07401000, 0x07401FFF, "camera_ss", 10, 0x00A),
    ("debug", "Audio Core0", 0x07800000, 0x07803FFF, "periss", 35, 0x023),
    ("debug", "Audio Core1", 0x07804000, 0x07807FFF, "periss", 35, 0x023),
    ("debug", "Peri dbg tsgen", 0x07808000, 0x07808FFF, "periss", 35, 0x023),
    ("debug", "Peri dbg etf", 0x07809000, 0x07809FFF, "periss", 35, 0x023),
    ("debug", "Peri dbg cti0", 0x0780A000, 0x0780AFFF, "periss", 35, 0x023),
    ("debug", "Peri dbg stm", 0x0780B000, 0x0780BFFF, "periss", 35, 0x023),
    ("debug", "Peri dbg cti1", 0x0780C000, 0x0780CFFF, "periss", 35, 0x023),
)

STS_SOC_ADDR_MAP_ENTRIES = tuple((start_addr, end_addr, tgt_id) for _, _, start_addr, end_addr, _, _, tgt_id in STS_SOC_ADDR_MAP_SOURCE_ROWS)
if len(STS_SOC_ADDR_MAP_ENTRIES) != 81:
    raise ValueError(f"expected 81 latest address-map entries, got {len(STS_SOC_ADDR_MAP_ENTRIES)}")

for row_idx, (domain, row_name, start_addr, end_addr, owner_key, tniu_id, tgt_id) in enumerate(STS_SOC_ADDR_MAP_SOURCE_ROWS):
    if start_addr > end_addr:
        raise ValueError(f"invalid address range at row {row_idx}: {row_name}")
    if owner_key not in STS_SOC_TNIU_RESOURCE_BY_NAME:
        raise ValueError(f"unknown owner_key at row {row_idx}: {owner_key}")
    expected_tgt_id = STS_SOC_TNIU_RESOURCE_BY_NAME[owner_key]["sys_apb_route_base"]
    if tniu_id != STS_SOC_TNIU_RESOURCE_BY_NAME[owner_key]["tniu_id"] or tgt_id != expected_tgt_id:
        raise ValueError(f"owner/tgt_id mismatch at row {row_idx}: {row_name}")

for lhs_idx, lhs_entry in enumerate(STS_SOC_ADDR_MAP_SOURCE_ROWS):
    for rhs_idx in range(lhs_idx + 1, len(STS_SOC_ADDR_MAP_SOURCE_ROWS)):
        rhs_entry = STS_SOC_ADDR_MAP_SOURCE_ROWS[rhs_idx]
        if max(lhs_entry[2], rhs_entry[2]) <= min(lhs_entry[3], rhs_entry[3]):
            raise ValueError(f"overlapped STS addr map rows: {lhs_idx} {lhs_entry[1]} / {rhs_idx} {rhs_entry[1]}")

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
            "STS_TNIU_LOCAL_INIU_CTI_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_iniu_cti_tgt_id"]),
            "STS_TNIU_LOCAL_INIU_CTI_TGT_MASK": _sv_hex(TGT_ID_WIDTH, STS_SOC_FULL_MASK),
            "STS_TNIU_LOCAL_REGBANK_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_regbank_tgt_id"]),
            "STS_TNIU_LOCAL_REGBANK_TGT_MASK": _sv_hex(TGT_ID_WIDTH, STS_SOC_FULL_MASK),
            "STS_TNIU_LOCAL_CTI_TGT_ID": _sv_hex(TGT_ID_WIDTH, entry["local_cti_tgt_id"]),
            "STS_TNIU_LOCAL_CTI_TGT_MASK": _sv_hex(TGT_ID_WIDTH, STS_SOC_FULL_MASK),
            "STS_TNIU_HAS_INIU_CTI_APB": int(entry["has_iniu_cti_apb"]),
            "STS_TNIU_SYS_REG_ROUTE_BASE": _sv_hex(TGT_ID_WIDTH, entry["sys_reg_route_base"]),
            "STS_TNIU_SYS_REG_ROUTE_MASK": _sv_hex(TGT_ID_WIDTH, 0x1C0),
            "STS_TNIU_SYS_APB_ROUTE_BASE": _sv_param(STS_TNIU_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, entry["sys_apb_route_base"]),
            "STS_TNIU_SYS_APB_ROUTE_MASK": _sv_param(STS_TNIU_SYS_APB_MASTER_NUM * TGT_ID_WIDTH, 0x1C0),
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
    cfg.top_wrap = f"sts_noc_dec_node_1to{slave_num}_wrap"
    _apply_macro_sets(
        cfg,
        STS_COMMON_ID_MACROS,
        STS_COMMON_AXI_BASE_MACROS,
        STS_COMMON_CTI_MACROS,
        STS_DEC_DEBUG_MACROS,
        {
            "STS_NETWORK_DEC_SLAVE_NUM": slave_num,
            "STS_NETWORK_DEC_ROUTE_BASE": _zero_route_literal(slave_num),
            "STS_NETWORK_DEC_ROUTE_MASK": _zero_route_literal(slave_num),
        },
    )
    wrap_macro_prefix = f"STS_NOC_DEC_NODE_1TO{slave_num}_WRAP"
    _apply_macro_sets(
        cfg,
        {
            f"{wrap_macro_prefix}_ROUTE_BASE": _zero_route_literal(slave_num),
            f"{wrap_macro_prefix}_ROUTE_MASK": _zero_route_literal(slave_num),
        },
    )
    cfg._slave_num = slave_num
    cfg._route_vld_table = tuple(1 for _ in route_groups)
    cfg._route_dst_table = tuple(
        tuple(STS_SOC_TNIU_RESOURCE_BY_NAME[leaf_name]["tniu_id"] for leaf_name in route_group)
        for route_group in route_groups
    )
    cfg._route_group_names = route_groups
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

aon_ss_iniu_top_side_config = _apply_iniu_macros(
    _new_template_cfg(
        name="aon_ss_iniu_top_side",
        filelist=str(STS_INIU_NOC_PUB_F),
        env_var="AON_SS_INIU_TOP_SIDE_OUT_DIR",
    )
)
aon_ss_iniu_top_side_config.top_wrap = "sts_iniu_noc"


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
STS_SOC_TNIU_TOP_SIDE_CONFIG = _apply_tniu_macros(
    _new_template_cfg(
        name="ddrss_tniu_top_side",
        filelist=str(STS_TNIU_TOP_PUB_F),
        env_var="DDRSS_TNIU_TOP_SIDE_OUT_DIR",
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
    top_cfg = STS_SOC_TNIU_TOP_SIDE_CONFIG

    _alias_template_env(f"{env_token}_TNIU_SYS_OUT_DIR", sys_cfg)
    _alias_template_env(f"{env_token}_TNIU_NOC_SIDE_OUT_DIR", noc_cfg)
    _alias_template_env(f"{env_token}_TNIU_TOP_SIDE_OUT_DIR", top_cfg)
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

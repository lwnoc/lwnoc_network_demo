"""
IntrTemplate.py — TemplateIPConfig definitions for the interrupt ring NoC demo.

Mirrors the pattern of DtiTemplate.py / MemTemplate.py.
Sets up env vars (INTR_NOC_DIR, INTR_NOC_DEMO_DIR) used by the .f filelists,
then creates one TemplateIPConfig per IP component.
"""
import os
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent                                     # lwnoc_network_demo/
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
INTR_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"
RING_NETWORK_ROOT = REPO_ROOT / "subs" / "lwnoc_ring_network" / "de" / "rtl"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

# ── env vars referenced in .f filelists ──────────────────────────────────────
os.environ["INTR_NOC_DIR"]               = str(INTR_NOC_ROOT)
os.environ["INTR_NOC_STANDALONE_DIR"]    = "/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc"
os.environ["INTR_NOC_DEMO_DIR"]          = str(THIS_DIR)
os.environ["INTR_NOC_NETWORK_DIR"]       = str(RING_NETWORK_ROOT)
os.environ["LWNOC_LOWPOWER_COMPONENT"]   = str(INTR_NOC_ROOT / "lwnoc_lowpower_component")

FILELIST_DIR = THIS_DIR / "filelist"


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


# ── per-IP configs ────────────────────────────────────────────────────────────
# INIU sys-side: one directory per consumer instance (P1 — consumer-oriented
# partitioning). Top-side changes never force sys-side regeneration.
iniu0_sys_config = _new_cfg(
    name="iniu0_sys",
    prefix="iniu0_sys_",
    filelist_name="intr_iniu_sys.f",
    env_var="INTR_INIU0_SYS_OUT_DIR",
)

iniu1_sys_config = _new_cfg(
    name="iniu1_sys",
    prefix="iniu1_sys_",
    filelist_name="intr_iniu_sys.f",
    env_var="INTR_INIU1_SYS_OUT_DIR",
)

iniu2_sys_config = _new_cfg(
    name="iniu2_sys",
    prefix="iniu2_sys_",
    filelist_name="intr_iniu_sys.f",
    env_var="INTR_INIU2_SYS_OUT_DIR",
)

iniu3_sys_config = _new_cfg(
    name="iniu3_sys",
    prefix="iniu3_sys_",
    filelist_name="intr_iniu_sys.f",
    env_var="INTR_INIU3_SYS_OUT_DIR",
)

# INIU top-side: shared across all INIU instances (P1 — top-side only changes here)
intr_iniu_top_config = _new_cfg(
    name="intr_iniu_top_side",
    prefix="intr_iniu_top_",
    filelist_name="intr_iniu_top.f",
    env_var="INTR_INIU_TOP_OUT_DIR",
)

# TNIU sys-side: one directory per consumer instance
tniu0_sys_config = _new_cfg(
    name="tniu0_sys",
    prefix="tniu0_sys_",
    filelist_name="intr_tniu_sys.f",
    env_var="INTR_TNIU0_SYS_OUT_DIR",
)

tniu1_sys_config = _new_cfg(
    name="tniu1_sys",
    prefix="tniu1_sys_",
    filelist_name="intr_tniu_sys.f",
    env_var="INTR_TNIU1_SYS_OUT_DIR",
)

# TNIU top-side: shared across all TNIU instances
intr_tniu_top_config = _new_cfg(
    name="intr_tniu_top_side",
    prefix="intr_tniu_top_",
    filelist_name="intr_tniu_top.f",
    env_var="INTR_TNIU_TOP_OUT_DIR",
)

intr_ring_network_config = _new_cfg(
    name="intr_ring_network",
    prefix="intr_ring_network_",
    filelist_name="intr_ring_network_wrap.f",
    env_var="INTR_RING_NETWORK_OUT_DIR",
)

intr_ring_buf_config = _new_cfg(
    name="intr_ring_buf",
    prefix="intr_ring_buf_",
    filelist_name="intr_ring_buf_wrap.f",
    env_var="INTR_RING_BUF_OUT_DIR",
)

intr_ring_station_config = _new_cfg(
    name="intr_ring_station",
    prefix="intr_ring_station_",
    filelist_name="intr_ring_station.f",
    env_var="INTR_RING_STATION_OUT_DIR",
)

intr_ring_sp_config = _new_cfg(
    name="intr_ring_sp",
    prefix="intr_ring_sp_",
    filelist_name="intr_ring_sp.f",
    env_var="INTR_RING_SP_OUT_DIR",
)

intr_ring_link_config = _new_cfg(
    name="intr_ring_link",
    prefix="intr_ring_link_",
    filelist_name="intr_ring_link.f",
    env_var="INTR_RING_LINK_OUT_DIR",
)

intr_ring_req_sink_config = _new_cfg(
    name="intr_ring_req_sink",
    prefix="intr_ring_req_sink_",
    filelist_name="intr_ring_req_sink.f",
    env_var="INTR_RING_REQ_SINK_OUT_DIR",
)

intr_ring_req_zero_source_config = _new_cfg(
    name="intr_ring_req_zero_source",
    prefix="intr_ring_req_zero_source_",
    filelist_name="intr_ring_req_zero_source.f",
    env_var="INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
)

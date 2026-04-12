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

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

# ── env vars referenced in .f filelists ──────────────────────────────────────
os.environ["INTR_NOC_DIR"]      = str(INTR_NOC_ROOT)
os.environ["INTR_NOC_DEMO_DIR"] = str(THIS_DIR)

FILELIST_DIR = THIS_DIR / "filelists"


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=prefix,
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


# ── per-IP configs ────────────────────────────────────────────────────────────
intr_iniu_sys_config = _new_cfg(
    name="intr_iniu_sys",
    prefix="intr_iniu_sys_",
    filelist_name="intr_iniu_sys.f",
    env_var="INTR_INIU_SYS_OUT_DIR",
)

intr_iniu_top_config = _new_cfg(
    name="intr_iniu_top",
    prefix="intr_iniu_top_",
    filelist_name="intr_iniu_top.f",
    env_var="INTR_INIU_TOP_OUT_DIR",
)

intr_tniu_sys_config = _new_cfg(
    name="intr_tniu_sys",
    prefix="intr_tniu_sys_",
    filelist_name="intr_tniu_sys.f",
    env_var="INTR_TNIU_SYS_OUT_DIR",
)

intr_tniu_top_config = _new_cfg(
    name="intr_tniu_top",
    prefix="intr_tniu_top_",
    filelist_name="intr_tniu_top.f",
    env_var="INTR_TNIU_TOP_OUT_DIR",
)

intr_ring_sta_config = _new_cfg(
    name="intr_ring_sta",
    prefix="intr_ring_sta_",
    filelist_name="intr_ring_station.f",
    env_var="INTR_RING_STA_OUT_DIR",
)

intr_ring_lnk_config = _new_cfg(
    name="intr_ring_lnk",
    prefix="intr_ring_lnk_",
    filelist_name="intr_ring_link.f",
    env_var="INTR_RING_LNK_OUT_DIR",
)

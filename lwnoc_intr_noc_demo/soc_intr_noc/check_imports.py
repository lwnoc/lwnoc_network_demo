"""Quick check: SocIntrTemplate and SocIntrTopo import OK"""
import sys, os
sys.path.insert(0, "/home/lgzhu/dev/noc_work/lwnoc_network_demo/lwnoc_intr_noc_demo/soc_intr_noc")
from SocIntrTemplate import _resolve_fl, INIU_SYS_CONFIGS, TNIU_SYS_CONFIGS
from pathlib import Path
print("=== Filelist check ===")
for name in ["intr_iniu_sys.f", "intr_tniu_sys.f", "intr_iniu_top.f", "intr_tniu_top.f"]:
    p = Path(_resolve_fl(name))
    print(f"  {name} -> {p.name}  exists={p.exists()}")
print(f"\nINIU_SYS_CONFIGS: {len(INIU_SYS_CONFIGS)} nodes")
print(f"TNIU_SYS_CONFIGS: {len(TNIU_SYS_CONFIGS)} nodes")
from SocIntrTopo import SocIntrLogicTopo, SocIntrFullLogicTopo
print("SocIntrLogicTopo: OK")
print("ALL IMPORTS PASSED")

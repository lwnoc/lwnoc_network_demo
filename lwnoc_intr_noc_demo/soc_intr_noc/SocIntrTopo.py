"""Compatibility re-exports for the SoC interrupt NoC topology modules."""

from SocIntrTopoConfig import DN_HARDEN_ID, HARDEN_TOP_ID, INIU_COUNT, RING_PLAN, TNIU_COUNT, TOPO_ID, UP_HARDEN_ID
from SocIntrTopoDv import SocIntrLogicTopo
from SocIntrTopoPd import SocIntrDnHardenWrap, SocIntrHardenTopTopo, SocIntrPdTopo, SocIntrUpHardenWrap


__all__ = [
    "RING_PLAN",
    "INIU_COUNT",
    "TNIU_COUNT",
    "TOPO_ID",
    "UP_HARDEN_ID",
    "DN_HARDEN_ID",
    "HARDEN_TOP_ID",
    "SocIntrLogicTopo",
    "SocIntrUpHardenWrap",
    "SocIntrDnHardenWrap",
    "SocIntrPdTopo",
    "SocIntrHardenTopTopo",
]
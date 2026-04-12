"""
IntrRingTopo.py — Interrupt ring NoC topology: 4 INIU + 2 TNIU.

Ring order (CW direction): iniu0 → iniu1 → iniu2 → iniu3 → tniu0 → tniu1 → iniu0

Connections:
  CW  (pring): node[i].pring_out_if  → node[(i+1)%N].pring_in_if
  CCW (nring): node[(i+1)%N].nring_out_if → node[i].nring_in_if
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from IntrNode import IntrIniuNode, IntrTniuNode
from IntrTemplate import intr_iniu_sys_config, intr_tniu_sys_config


class IntrRingLogicTopo(UhdlWrapperNode):
    """
    4-INIU + 2-TNIU interrupt ring NoC topology.

    All INIU and TNIU nodes share the same sys-side config (identical RTL).
    Ring order: iniu0, iniu1, iniu2, iniu3, tniu0, tniu1.
    """

    def __init__(self):
        super().__init__(id="intr_ring_noc_4i2t")

        # ── Create 4 INIU nodes ──────────────────────────────────────────────
        self.iniu0 = IntrIniuNode(id="iniu0", sys_cfg=intr_iniu_sys_config)
        self.iniu1 = IntrIniuNode(id="iniu1", sys_cfg=intr_iniu_sys_config)
        self.iniu2 = IntrIniuNode(id="iniu2", sys_cfg=intr_iniu_sys_config)
        self.iniu3 = IntrIniuNode(id="iniu3", sys_cfg=intr_iniu_sys_config)

        # ── Create 2 TNIU nodes ──────────────────────────────────────────────
        self.tniu0 = IntrTniuNode(id="tniu0", sys_cfg=intr_tniu_sys_config)
        self.tniu1 = IntrTniuNode(id="tniu1", sys_cfg=intr_tniu_sys_config)

        # Ring order list (CW sequence)
        nodes = [self.iniu0, self.iniu1, self.iniu2, self.iniu3,
                 self.tniu0, self.tniu1]
        N = len(nodes)

        # ── Bi-directional ring connectivity ────────────────────────────────
        for i in range(N):
            nxt = (i + 1) % N
            # CW: node[i] → node[i+1]
            connect(nodes[i].pring_out_if, nodes[nxt].pring_in_if)
            # CCW: node[i+1] → node[i]
            connect(nodes[nxt].nring_out_if, nodes[i].nring_in_if)

        # Expose all remaining external interfaces (clk/rst, sys-side user ports)
        self.expose_unconnected_interfaces()

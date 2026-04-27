"""Generate the SoC-scale interrupt ring NoC demo topology.

Three-layer release (memnoc/ATB standard):
  Layer 1: Full topology → build_logic/<topo_id>/
  Layer 3: Harden wrappers → build_logic/<up/dn_harden>/  [follows topo file]
  Layer 2: Aggregation wrapper → build_logic/ring_top_wrap/

Topo description file: soc_intr_noc_topo (clk domain split around async bridges).
"""

import argparse
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parents[1] / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))
if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))

from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

from SocIntrTopo import (
    RING_PLAN, TOPO_ID, SocIntrLogicTopo, _node_attr_name,
    UP_HARDEN_ID, DN_HARDEN_ID,
)
from SocIntrNode import TOP_LAYER_SUFFIX
from SocIntrTemplate import SOC_INTR_RING_NODE_NUM

BUILD_DIR = THIS_DIR / "build_logic"


def generate():
    # ── Layer 1: Full topology ─────────────────────────────────────────
    logic_wrapper = SocIntrLogicTopo()
    TopologySerializer().save_to_file(
        logic_wrapper, str(THIS_DIR / f"{TOPO_ID}_logic_topology.json")
    )
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$SOC_INTR_RING_NOC")

    # ── Layer 3: Harden wrappers (per soc_intr_noc_topo) ───────────────
    # Domain split: nodes with harden="a" → up_harden, harden="b" → dn_harden.
    # Nodes with harden="" are assigned by adjacency to nearest assigned neighbor
    # in the ring plan (circular topology).

    # Step 1: compute assignment for each node
    n = len(RING_PLAN)
    assigned = [None] * n  # None=unassigned, "a", or "b"
    for i, (node_id, ss_name, role, harden) in enumerate(RING_PLAN):
        if harden == "a":
            assigned[i] = "a"
        elif harden == "b":
            assigned[i] = "b"

    # Step 2: propagate assignments to neighbors for unassigned nodes
    # Walk both directions from known anchors
    changed = True
    while changed:
        changed = False
        for i in range(n):
            if assigned[i] is not None:
                continue
            # Check immediate neighbors (circular)
            prev = (i - 1) % n
            nxt = (i + 1) % n
            if assigned[prev] == "a" or assigned[nxt] == "a":
                assigned[i] = "a"
                changed = True
            elif assigned[prev] == "b" or assigned[nxt] == "b":
                assigned[i] = "b"
                changed = True
    # Any remaining None → default to up_harden
    for i in range(n):
        if assigned[i] is None:
            assigned[i] = "a"

    up_harden = UhdlWrapperNode(UP_HARDEN_ID)
    up_harden.add_interface("clk_up_func", is_global=True)
    up_harden.add_interface("rst_up_func_n", is_global=True)
    dn_harden = UhdlWrapperNode(DN_HARDEN_ID)
    dn_harden.add_interface("clk_dn_func", is_global=True)
    dn_harden.add_interface("rst_dn_func_n", is_global=True)

    for i, (node_id, ss_name, role, harden) in enumerate(RING_PLAN):
        sys_name = f"{ss_name}_{role}"
        node = getattr(logic_wrapper, _node_attr_name(ss_name, role))
        if assigned[i] == "a":
            setattr(up_harden, f"u_{sys_name}", node.top_side)
        else:
            setattr(dn_harden, f"u_{sys_name}", node.top_side)
    # Ring core lives in up_harden
    for ring_node_name in ("ring_sp", "ring_req_sink", "ring_zero_source"):
        sub_node = getattr(logic_wrapper, ring_node_name)
        setattr(up_harden, f"u_{ring_node_name}", sub_node)
    up_harden.expose_unconnected_interfaces()
    dn_harden.expose_unconnected_interfaces()

    for harden in (up_harden, dn_harden):
        hc = harden.build_uhdl()
        hc.output_dir = str(BUILD_DIR)
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="$SOC_INTR_RING_NOC")

    # ── Layer 2: Aggregation wrapper (ring_top_wrap) ──────────────────
    # Only nests harden sub-nodes — NO sys-side files, NO full Iniu/Tniu nodes.
    ring_top_wrap = UhdlWrapperNode("ring_top_wrap")
    ring_top_wrap.u_up_harden = up_harden
    ring_top_wrap.u_dn_harden = dn_harden
    ring_top_wrap.u_dn_harden = dn_harden
    ring_top_wrap.expose_unconnected_interfaces()
    rtw_comp = ring_top_wrap.build_uhdl()
    rtw_comp.output_dir = str(BUILD_DIR)
    rtw_comp.generate_verilog(iteration=True)
    rtw_comp.generate_filelist(abs_path=False, prefix="$SOC_INTR_RING_NOC")

    # ── Viz (optional) ─────────────────────────────────────────────────
    try:
        import networkx  # noqa: F401
        from tools.intr_gen_viz import emit_topology_visualization
        emit_topology_visualization(
            logic_wrapper, THIS_DIR / f"{TOPO_ID}_topology.png",
            topology_json=THIS_DIR / f"{TOPO_ID}_logic_topology.json",
        )
    except ImportError:
        print("  [viz] skipped (missing networkx)")

    print(f"Done. Layers: {BUILD_DIR}")


def main():
    parser = argparse.ArgumentParser(description="Generate SoC intr NoC topology")
    parser.parse_args()
    generate()


if __name__ == "__main__":
    main()
"""
gen_intr_ring_topo.py — Generate the 4-INIU + 2-TNIU interrupt ring NoC.

Usage:
    cd lwnoc_intr_noc_demo
    python gen_intr_ring_topo.py

Outputs:
    intr_ring_logic_topology.json   — serialised topology
    build_logic/                    — generated Verilog + filelist
"""
import os
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent                                     # lwnoc_network_demo/
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

# Optional: use the local slang binary bundled in the repo
LOCAL_SLANG_BIN = LWNOC_TOPO_ROOT / "uhdl" / "slang" / "build" / "bin"
if os.environ.get("USE_LOCAL_SLANG") == "1" and LOCAL_SLANG_BIN.exists():
    os.environ["PATH"] = f"{LOCAL_SLANG_BIN}:{os.environ.get('PATH', '')}"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.node import reset_global_state
from topo_core.utils.serialization import TopologySerializer

from IntrRingTopo import IntrRingLogicTopo


def main():
    reset_global_state()

    topo = IntrRingLogicTopo()

    topology_json = THIS_DIR / "intr_ring_logic_topology.json"
    build_dir = THIS_DIR / "build_logic"

    TopologySerializer().save_to_file(topo, str(topology_json))

    comp = topo.build_uhdl()
    comp.output_dir = str(build_dir)
    comp.generate_verilog(iteration=True)
    comp.generate_filelist()

    _patch_ring_station_params(build_dir / "intr_ring_noc_4i2t")

    print(f"Topology JSON written to {topology_json}")
    print(f"Generated RTL written to  {build_dir}")


# -----------------------------------------------------------------------------
# Post-generation patch: inject per-node ring station parameters.
#
# The UHDL framework instantiates all ring stations without #(.PARAM(value))
# overrides because TemplateComponent kwargs only affect the Python port-width
# model (slang AST parse), not the generated Verilog instantiation text.
# We therefore apply a deterministic string substitution after generation.
#
# Node positions (ring order CW):
#   iniu0=0, iniu1=1, iniu2=2, iniu3=3, tniu0=4, tniu1=5
# -----------------------------------------------------------------------------

def _build_param_override(node_id: int, has_iniu: int, has_tniu: int) -> str:
    return (
        f"\tintr_ring_sta_interrupt_req_ring_station #(\n"
        f"\t\t.NODE_ID    ({node_id}),\n"
        f"\t\t.NODE_COUNT (6),\n"
        f"\t\t.HAS_INIU   (1'b{has_iniu}),\n"
        f"\t\t.HAS_TNIU   (1'b{has_tniu})) ring_sta ("
    )


_RING_NODE_PARAMS = {
    "iniu0_ring.v": _build_param_override(0, 1, 0),
    "iniu1_ring.v": _build_param_override(1, 1, 0),
    "iniu2_ring.v": _build_param_override(2, 1, 0),
    "iniu3_ring.v": _build_param_override(3, 1, 0),
    "tniu0_ring.v": _build_param_override(4, 0, 1),
    "tniu1_ring.v": _build_param_override(5, 0, 1),
}

_UNPARAM_INST = "\tintr_ring_sta_interrupt_req_ring_station ring_sta ("


def _patch_ring_station_params(ring_dir: Path) -> None:
    """Replace bare ring-station instantiation with parameterized version."""
    for fname, replacement in _RING_NODE_PARAMS.items():
        fpath = ring_dir / fname
        if not fpath.exists():
            print(f"  [patch] WARNING: {fpath} not found, skipping")
            continue
        text = fpath.read_text()
        if _UNPARAM_INST in text:
            fpath.write_text(text.replace(_UNPARAM_INST, replacement))
            print(f"  [patch] {fname}: ring station parameterized (NODE_ID={list(_RING_NODE_PARAMS.keys()).index(fname)})")
        else:
            print(f"  [patch] {fname}: already patched or pattern not found, skip")


if __name__ == "__main__":
    main()

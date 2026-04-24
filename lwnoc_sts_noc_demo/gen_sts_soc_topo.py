"""gen_sts_soc_topo.py — STS SoC topology generation driver.

Flow:
  1. Build UHDL topology → generate verilog + filelist
  2. Publish single-instance components into soc_sts_noc/ (no need for own dir)
  3. Create harden wrappers (up/dn) and generate third-party filelists
  4. Create ring_top_wrap-style aggregation wrapper

Single-instance vs multi-instance:
  - Single-instance: aon_ss_iniu, vpu_ss_tniu, camera_ss_tniu
    → RTL published into soc_sts_noc/ directly
  - Multi-instance: dspss0~5_tniu (same config, 6 copies)
    → Each gets its own publish directory
"""
import subprocess, sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from StsSocTopo import StsSocLogicTopo
from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode

BUILD_DIR = THIS_DIR / "build_logic"
# CONSTRAINT: Single-instance components (instantiated once in the topology)
# must be merged into the soc_sts_noc/ directory. This is the PERMANENT approach,
# NOT a transitional workaround. Rationale:
#   - Avoids redundant per-component directories for one-of-a-kind instances
#   - Keeps the build output clean for integration handoff (PD team sees fewer dirs)
#   - Does NOT apply to multi-instance components (e.g. dspss0~5_tniu_top_side)
#     which keep their own directories for independent leaf filelists
_SINGLE_INSTANCE = {"vpu_ss_tniu_top_side", "camera_ss_tniu_top_side", "aon_ss_iniu_top_side"}


def main():
    BUILD_DIR.mkdir(parents=True, exist_ok=True)

    # 1. Define topology
    logic_wrapper = StsSocLogicTopo()
    TopologySerializer().save_to_file(
        logic_wrapper, str(THIS_DIR / "soc_sts_logic_topology.json")
    )

    # 2. Build (auto-configures logging, captures prints, shows progress)
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))

    # 3. Generate outputs
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")

    # 4. Publish single-instance components into soc_sts_noc/
    import shutil
    top_dir = BUILD_DIR / logic_wrapper.id  # soc_sts_noc
    for leaf in sorted(BUILD_DIR.iterdir()):
        if not leaf.is_dir() or leaf.name not in _SINGLE_INSTANCE:
            continue
        for f in list(leaf.iterdir()):
            if f.suffix in (".sv", ".v"):
                dest = top_dir / f.name
                if not dest.exists():
                    f.rename(dest)
                    print(f"  [merge] {leaf.name}/{f.name} -> soc_sts_noc/")
                else:
                    f.unlink()  # duplicate, already merged from another instance
        # Clean empty directory
        sv_files = [f for f in leaf.iterdir() if f.suffix in (".sv", ".v")]
        if not sv_files:
            shutil.rmtree(leaf)
            print(f"  [clean] {leaf.name}/ (merged into soc_sts_noc/)")

    # 5. Create harden wrappers
    dn_harden = UhdlWrapperNode("soc_sts_dn_harden")
    for name in sorted(logic_wrapper.harden_dn_leaf_names):
        setattr(dn_harden, f"{name}_top", logic_wrapper.tniu_nodes[name].top_side)
    setattr(dn_harden, "aon_ss_iniu", logic_wrapper.aon_ss_iniu)
    setattr(dn_harden, "async_bridge_slv", logic_wrapper.harden_dn_async_bridge_slv)

    up_harden = UhdlWrapperNode("soc_sts_up_harden")
    for name in sorted(logic_wrapper.harden_up_leaf_names):
        setattr(up_harden, f"{name}_top", logic_wrapper.tniu_nodes[name].top_side)
    setattr(up_harden, "async_bridge_mst", logic_wrapper.harden_up_async_bridge_mst)

    # 6. Generate harden outputs
    for harden in [dn_harden, up_harden]:
        harden.expose_unconnected_interfaces()
        hc = harden.build_uhdl()
        hc.output_dir = str(BUILD_DIR)
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")

    print(f"Done. RTL: {BUILD_DIR}")


if __name__ == "__main__":
    main()

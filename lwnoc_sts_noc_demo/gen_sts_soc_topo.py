"""gen_sts_soc_topo.py — STS SoC topology generation driver.

Flow (ring_top_wrap aggregation pattern):
  1. Build UHDL topology → generate verilog + filelist
  2. Create harden wrappers (up/dn) and generate filelists
  3. Nest harden wrappers in ring_top_wrap aggregator (no physical merge)
"""
import sys
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

# Apply [-1:0] width fix before any TemplateComponent creation
# Apply [-1:0] width fix before any TemplateComponent creation
sys.path.insert(0, str(THIS_DIR))


from StsSocTopo import StsSocLogicTopo
from topo_core.utils.serialization import TopologySerializer
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect

BUILD_DIR = THIS_DIR / "build_logic"


def main():
    BUILD_DIR.mkdir(parents=True, exist_ok=True)

    # 1. Define topology
    logic_wrapper = StsSocLogicTopo()
    TopologySerializer().save_to_file(
        logic_wrapper, str(THIS_DIR / "soc_sts_logic_topology.json")
    )

    # 2. Build (auto-configures logging, captures prints, shows progress)
    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))

    # 3. Generate outputs for main topology
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")

    # 4. Create harden wrappers with partition clocks (G9)
    dn_harden = UhdlWrapperNode("soc_sts_dn_harden")
    dn_harden.add_interface("clk_harden_dn_func", is_global=True)
    dn_harden.add_interface("rst_harden_dn_func_n", is_global=True)
    for name in sorted(logic_wrapper.harden_dn_leaf_names):
        sub = logic_wrapper.tniu_nodes[name].top_side
        setattr(dn_harden, f"{name}_top", sub)
        connect(sub.clk_dst, dn_harden.clk_harden_dn_func)
        connect(sub.rstn_dst, dn_harden.rst_harden_dn_func_n)
    setattr(dn_harden, "aon_ss_iniu_top", logic_wrapper.aon_ss_iniu.top_side)
    connect(logic_wrapper.aon_ss_iniu.top_side.clk_dst, dn_harden.clk_harden_dn_func)
    connect(logic_wrapper.aon_ss_iniu.top_side.rstn_dst, dn_harden.rst_harden_dn_func_n)
    setattr(dn_harden, "async_bridge_slv", logic_wrapper.harden_dn_async_bridge_slv)
    connect(logic_wrapper.harden_dn_async_bridge_slv.clk, dn_harden.clk_harden_dn_func)
    connect(logic_wrapper.harden_dn_async_bridge_slv.rst_n, dn_harden.rst_harden_dn_func_n)

    up_harden = UhdlWrapperNode("soc_sts_up_harden")
    up_harden.add_interface("clk_harden_up_func", is_global=True)
    up_harden.add_interface("rst_harden_up_func_n", is_global=True)
    for name in sorted(logic_wrapper.harden_up_leaf_names):
        sub = logic_wrapper.tniu_nodes[name].top_side
        setattr(up_harden, f"{name}_top", sub)
        connect(sub.clk_dst, up_harden.clk_harden_up_func)
        connect(sub.rstn_dst, up_harden.rst_harden_up_func_n)
    setattr(up_harden, "async_bridge_mst", logic_wrapper.harden_up_async_bridge_mst)
    connect(logic_wrapper.harden_up_async_bridge_mst.clk, up_harden.clk_harden_up_func)
    connect(logic_wrapper.harden_up_async_bridge_mst.rst_n, up_harden.rst_harden_up_func_n)

    # Output all harden .v files to top_wrap_dir (memnoc pattern: flat aggregation)
    top_wrap_dir = str(BUILD_DIR / "sts_soc_top_wrap")
    for harden in [dn_harden, up_harden]:
        harden.expose_unconnected_interfaces()
        hc = harden.build_uhdl()
        hc.output_dir = top_wrap_dir
        hc.generate_verilog(iteration=True)
        hc.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")

    # 5. Aggregation wrapper (memnoc ring_top_wrap pattern):
    #    Flat directory containing all top-side IP .v files + harden partitions.
    ring_top_wrap = UhdlWrapperNode("sts_soc_top_wrap")
    ring_top_wrap.u_dn_harden = dn_harden
    ring_top_wrap.u_up_harden = up_harden
    ring_top_wrap.expose_unconnected_interfaces()
    rtw_comp = ring_top_wrap.build_uhdl()
    rtw_comp.output_dir = top_wrap_dir
    rtw_comp.generate_verilog(iteration=True)

    # Collect all template .v/.sv files from sibling build dirs into top_wrap
    import os, shutil
    for ip_dir in BUILD_DIR.iterdir():
        if not ip_dir.is_dir() or ip_dir.name == "sts_soc_top_wrap":
            continue
        for fn in os.listdir(str(ip_dir)):
            if fn.endswith((".v", ".sv")):
                src = str(ip_dir / fn)
                dst = os.path.join(top_wrap_dir, fn)
                if not os.path.exists(dst):
                    shutil.copy2(src, dst)
    rtw_comp.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Aggregation wrapper: {BUILD_DIR / 'sts_soc_top_wrap'}")
    print(f"Sub-component dirs: {sorted(d.name for d in BUILD_DIR.iterdir() if d.is_dir())}")


if __name__ == "__main__":
    main()

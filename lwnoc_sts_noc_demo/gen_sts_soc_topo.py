"""gen_sts_soc_topo.py — STS SoC topology generation driver.

Layered publication uses one full logic topology plus a derived wrapper view:
    1. Full logic publication     -> build_logic/soc_sts_noc/
    2. Aggregation top release    -> build_logic/sts_soc_top_wrap/
"""
import shutil
from pathlib import Path

from _project_env import LWNOC_TOPO_ROOT, THIS_DIR

from StsSocTopo import StsSocLogicTopo
from StsNode import StsTniuTopSideNode
from StsTemplate import STS_SOC_PUBLISH_ENV_DIRS, STS_SOC_TNIU_TOP_CONFIGS
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.serialization import TopologySerializer

BUILD_DIR = THIS_DIR / "build_logic"
FILELIST_DIR = THIS_DIR / "filelists"
PUBLISH_FILELIST = FILELIST_DIR / "filelist_soc.f"
PUBLISH_ENV_MK = FILELIST_DIR / "sts_soc_publish_env.mk"
PUBLISH_ENV_SH = FILELIST_DIR / "sts_soc_publish_env.sh"
FILELIST_PREFIX = "$STS_SOC_NOC"
TOP_WRAP_ID = "sts_soc_top_wrap"


def main():
    if BUILD_DIR.exists():
        shutil.rmtree(BUILD_DIR)
    BUILD_DIR.mkdir(parents=True, exist_ok=True)
    FILELIST_DIR.mkdir(parents=True, exist_ok=True)

    logic_wrapper = StsSocLogicTopo()
    TopologySerializer().save_to_file(
        logic_wrapper,
        str(THIS_DIR / "soc_sts_logic_topology.json"),
    )

    comp = logic_wrapper.build(output_dir=str(BUILD_DIR))
    comp.generate_verilog(iteration=True)
    comp.generate_filelist(abs_path=False, prefix=FILELIST_PREFIX)

    top_wrap = UhdlWrapperNode(TOP_WRAP_ID)
    setattr(top_wrap, "u_aon_ss_iniu_noc_side", logic_wrapper.aon_ss_iniu.top_side)
    for leaf_name in sorted(logic_wrapper.tniu_nodes.keys()):
        setattr(
            top_wrap,
            f"u_{leaf_name}_noc_side",
            StsTniuTopSideNode(
                id=f"{leaf_name}_tniu_noc_side",
                cfg=STS_SOC_TNIU_TOP_CONFIGS[leaf_name],
            ),
        )
    top_wrap.expose_unconnected_interfaces()
    rtw_comp = top_wrap.build_uhdl()
    rtw_comp.output_dir = str(BUILD_DIR)
    rtw_comp.generate_verilog(iteration=True)
    rtw_comp.generate_filelist(abs_path=False, prefix=FILELIST_PREFIX)

    PUBLISH_FILELIST.write_text(
        "// Auto-generated STS SoC wrapper compile ingress.\n"
        f"-f {FILELIST_PREFIX}/{TOP_WRAP_ID}/filelist.f\n"
    )

    mk_lines = [
        "# Auto-generated STS SoC publish env exports.",
        "STS_SOC_BUILD_LOGIC_DIR := $(DEMO_DIR)/build_logic",
    ]
    sh_lines = [
        "#!/usr/bin/env bash",
        "DEMO_DIR=\"$(builtin cd \"$(dirname \"${BASH_SOURCE[0]}\")/..\" && pwd)\"",
        "STS_SOC_BUILD_LOGIC_DIR=\"$DEMO_DIR/build_logic\"",
    ]
    for env_var, rel_dir in sorted(STS_SOC_PUBLISH_ENV_DIRS.items()):
        target_dir = BUILD_DIR if rel_dir == "." else BUILD_DIR / rel_dir
        if not target_dir.exists():
            continue
        if rel_dir == ".":
            mk_lines.append(f"export {env_var} := $(STS_SOC_BUILD_LOGIC_DIR)")
            sh_lines.append(f"export {env_var}=\"$STS_SOC_BUILD_LOGIC_DIR\"")
        else:
            mk_lines.append(f"export {env_var} := $(STS_SOC_BUILD_LOGIC_DIR)/{rel_dir}")
            sh_lines.append(f"export {env_var}=\"$STS_SOC_BUILD_LOGIC_DIR/{rel_dir}\"")
    PUBLISH_ENV_MK.write_text("\n".join(mk_lines) + "\n")
    PUBLISH_ENV_SH.write_text("\n".join(sh_lines) + "\n")
    PUBLISH_ENV_SH.chmod(0o755)

    print(f"Done. RTL: {BUILD_DIR}")
    print(f"Logic publication: {BUILD_DIR / 'soc_sts_noc'}")
    print(f"Aggregation wrapper: {BUILD_DIR / TOP_WRAP_ID}")
    print(f"Compile ingress: {PUBLISH_FILELIST}")
    print(f"Make env include: {PUBLISH_ENV_MK}")
    print(f"Shell env include: {PUBLISH_ENV_SH}")


if __name__ == "__main__":
    main()

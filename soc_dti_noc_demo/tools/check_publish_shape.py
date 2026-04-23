#!/usr/bin/env python3

from __future__ import annotations

import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
if str(DEMO_DIR) not in sys.path:
    sys.path.insert(0, str(DEMO_DIR))

from SocDtiTemplate import INIU_NODE_NAMES  # noqa: E402


BUILD_DIR = DEMO_DIR / "build_logic"
TOP_FILELIST = DEMO_DIR / "filelists" / "soc_dti_logic_topo.f"
TOP_WRAP_DIR = BUILD_DIR / "soc_dti_top_wrap"
NETWORK_DIR = BUILD_DIR / "soc_dti_network_component"
STALE_SHARED_DIR = BUILD_DIR / "soc_dti_logic_topo"
STALE_GENERIC_INIU_DIR = BUILD_DIR / "soc_dti_iniu_sys"
SWITCH_IDS = (
    "soc_dti_sw_root",
    "soc_dti_sw_right",
    "soc_dti_sw_io5",
    "soc_dti_sw_gpu4",
    "soc_dti_sw_dsp6",
)


def _require(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def _node_env_token(node_name: str) -> str:
    return node_name.upper().replace("-", "_")


def main() -> int:
    errors: list[str] = []

    _require(TOP_FILELIST.exists(), f"missing top filelist: {TOP_FILELIST}", errors)
    _require(TOP_WRAP_DIR.is_dir(), f"missing top-wrap dir: {TOP_WRAP_DIR}", errors)
    _require(NETWORK_DIR.is_dir(), f"missing network-component dir: {NETWORK_DIR}", errors)
    _require(not STALE_SHARED_DIR.exists(), f"stale scratch dir still present: {STALE_SHARED_DIR}", errors)
    _require(not STALE_GENERIC_INIU_DIR.exists(), f"stale generic INIU sys dir still present: {STALE_GENERIC_INIU_DIR}", errors)

    for node_name in INIU_NODE_NAMES:
        expected_dir = BUILD_DIR / f"{node_name}_iniu_sys"
        _require(expected_dir.is_dir(), f"missing per-owner INIU sys dir: {expected_dir}", errors)

    _require((BUILD_DIR / "sys_tcu_tniu_sys").is_dir(), "missing sys_tcu_tniu_sys dir", errors)
    _require((BUILD_DIR / "dti_iniu_top_side").is_dir(), "missing dti_iniu_top_side dir", errors)
    _require((BUILD_DIR / "dti_tniu_top_side").is_dir(), "missing dti_tniu_top_side dir", errors)
    _require((BUILD_DIR / "soc_dti_harden_up").is_dir(), "missing soc_dti_harden_up dir", errors)
    _require((BUILD_DIR / "soc_dti_harden_dn").is_dir(), "missing soc_dti_harden_dn dir", errors)

    network_filelist = NETWORK_DIR / "filelist.f"
    _require(network_filelist.exists(), f"missing network-component filelist: {network_filelist}", errors)
    for switch_id in SWITCH_IDS:
        _require((NETWORK_DIR / f"{switch_id}_filelist.f").exists(), f"missing network filelist for {switch_id}", errors)

    top_wrap_switch_files = list(TOP_WRAP_DIR.glob("soc_dti_sw_*"))
    _require(not top_wrap_switch_files, f"top-wrap dir still contains switch payload: {[p.name for p in top_wrap_switch_files]}", errors)

    top_wrap_top_side_files = list(TOP_WRAP_DIR.glob("dti_iniu_top_*")) + list(TOP_WRAP_DIR.glob("dti_tniu_top_*"))
    _require(not top_wrap_top_side_files, f"top-wrap dir still contains top-side payload copies: {[p.name for p in top_wrap_top_side_files]}", errors)

    top_text = TOP_FILELIST.read_text() if TOP_FILELIST.exists() else ""
    _require(
        f"-f $DTI_TEST_DIR/build_logic/{NETWORK_DIR.name}/filelist.f" in top_text,
        "top filelist missing network-component ingress",
        errors,
    )
    _require("-f $DTI_INIU_TOP_DIR/dti_iniu_top_filelist.f" in top_text, "top filelist missing DTI_INIU_TOP_DIR ingress", errors)
    _require("-f $DTI_TNIU_TOP_DIR/dti_tniu_top_filelist.f" in top_text, "top filelist missing DTI_TNIU_TOP_DIR ingress", errors)
    _require("-f $SYS_TCU_TNIU_SYS_DIR/sys_tcu_filelist.f" in top_text, "top filelist missing SYS_TCU_TNIU_SYS_DIR ingress", errors)
    _require("SOC_DTI_INIU_SYS_DIR" not in top_text, "top filelist still references generic SOC_DTI_INIU_SYS_DIR", errors)

    for node_name in INIU_NODE_NAMES:
        env_name = f"SOC_DTI_{_node_env_token(node_name)}_INIU_SYS_DIR"
        expected_line = f"-f ${env_name}/{node_name}_filelist.f"
        _require(expected_line in top_text, f"top filelist missing owner-local ingress: {expected_line}", errors)

    if errors:
        print("CHECK_PUBLISH_SHAPE: FAIL")
        for message in errors:
            print(f"- {message}")
        return 1

    print("CHECK_PUBLISH_SHAPE: PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
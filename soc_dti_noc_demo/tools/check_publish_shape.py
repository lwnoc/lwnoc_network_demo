#!/usr/bin/env python3

from __future__ import annotations

import sys
import re
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
if str(DEMO_DIR) not in sys.path:
    sys.path.insert(0, str(DEMO_DIR))

from SocDtiTemplate import INIU_SYS_CONFIGS  # noqa: E402


BUILD_DIR = DEMO_DIR / "build_logic"
TOP_FILELIST = DEMO_DIR / "filelists" / "soc_dti_logic_topo.f"
TOP_WRAP_DIR = BUILD_DIR / "soc_dti_top_wrap"
NETWORK_DIR = BUILD_DIR / "soc_dti_network_component"
STALE_SHARED_DIR = BUILD_DIR / "soc_dti_logic_topo"
STALE_GENERIC_INIU_DIR = BUILD_DIR / "soc_dti_iniu_sys"
def _require(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def _extract_filelist_refs(text: str) -> list[tuple[str, str]]:
    refs: list[tuple[str, str]] = []
    pattern = re.compile(r"^-f\s+\$([A-Z0-9_]+)/(\S+)$")
    for raw_line in text.splitlines():
        line = raw_line.strip()
        match = pattern.match(line)
        if match:
            refs.append((match.group(1), match.group(2)))
    return refs


def _extract_switch_ids(network_filelist_text: str) -> set[str]:
    switch_ids: set[str] = set()
    for _env, rel_path in _extract_filelist_refs(network_filelist_text):
        if not rel_path.endswith("_filelist.f"):
            continue
        stem = Path(rel_path).name[: -len("_filelist.f")]
        if stem.startswith("soc_dti_sw_"):
            switch_ids.add(stem)
    return switch_ids


def main() -> int:
    errors: list[str] = []

    _require(TOP_FILELIST.exists(), f"missing top filelist: {TOP_FILELIST}", errors)
    _require(TOP_WRAP_DIR.is_dir(), f"missing top-wrap dir: {TOP_WRAP_DIR}", errors)
    _require(NETWORK_DIR.is_dir(), f"missing network-component dir: {NETWORK_DIR}", errors)
    _require(not STALE_SHARED_DIR.exists(), f"stale scratch dir still present: {STALE_SHARED_DIR}", errors)
    _require(not STALE_GENERIC_INIU_DIR.exists(), f"stale generic INIU sys dir still present: {STALE_GENERIC_INIU_DIR}", errors)

    expected_dirs = {BUILD_DIR / cfg.name for cfg in INIU_SYS_CONFIGS.values()}
    for expected_dir in sorted(expected_dirs):
        _require(expected_dir.is_dir(), f"missing INIU sys dir: {expected_dir}", errors)

    _require((BUILD_DIR / "sys_tcu_tniu_sys").is_dir(), "missing sys_tcu_tniu_sys dir", errors)
    _require((BUILD_DIR / "dti_iniu_top_side").is_dir(), "missing dti_iniu_top_side dir", errors)
    _require((BUILD_DIR / "dti_tniu_top_side").is_dir(), "missing dti_tniu_top_side dir", errors)
    _require((BUILD_DIR / "soc_dti_harden_up").is_dir(), "missing soc_dti_harden_up dir", errors)
    _require((BUILD_DIR / "soc_dti_harden_dn").is_dir(), "missing soc_dti_harden_dn dir", errors)

    network_filelist = NETWORK_DIR / "filelist.f"
    _require(network_filelist.exists(), f"missing network-component filelist: {network_filelist}", errors)

    network_text = network_filelist.read_text() if network_filelist.exists() else ""
    switch_ids = _extract_switch_ids(network_text)
    _require(bool(switch_ids), "network-component filelist has no switch ingress entries", errors)
    for switch_id in sorted(switch_ids):
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

    top_refs = _extract_filelist_refs(top_text)
    for node_name, cfg in sorted(INIU_SYS_CONFIGS.items()):
        expected_dir = BUILD_DIR / cfg.name
        filelists = sorted(expected_dir.glob("*_filelist.f")) if expected_dir.is_dir() else []
        _require(bool(filelists), f"missing INIU sys filelist under: {expected_dir}", errors)

        # Keep this generic: require one ingress per node filelist, but do not
        # hard-bind to a specific env-var token naming convention.
        node_filelist_name = f"{node_name}_filelist.f"
        _require(
            any(rel_path == node_filelist_name for _env, rel_path in top_refs),
            f"top filelist missing node ingress for {node_name}: */{node_filelist_name}",
            errors,
        )

    if errors:
        print("CHECK_PUBLISH_SHAPE: FAIL")
        for message in errors:
            print(f"- {message}")
        return 1

    print("CHECK_PUBLISH_SHAPE: PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
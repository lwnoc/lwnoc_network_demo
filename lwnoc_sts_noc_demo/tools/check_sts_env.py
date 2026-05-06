#!/usr/bin/env python3

from __future__ import annotations

import os
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
REPO_ROOT = DEMO_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))
if str(DEMO_DIR) not in sys.path:
    sys.path.insert(0, str(DEMO_DIR))

import StsTemplate  # noqa: E402
from pyslang import CommandLineOptions, Driver  # noqa: E402


def section(title: str) -> None:
    print(f"\n=== {title} ===")


def print_path(label: str, path: str | Path | None) -> bool:
    text = str(path) if path is not None else "<unset>"
    exists = os.path.exists(text) if path is not None else False
    print(f"{label}: {text}")
    print(f"  exists: {exists}")
    return exists


def check_file(label: str, path: Path) -> bool:
    exists = path.exists()
    print(f"{label}: {path}")
    print(f"  exists: {exists}")
    return exists


def inspect_temp_build() -> int:
    section("Template Temp Build")
    cfg = StsTemplate.aon_ss_iniu_sys_config
    expected_top = "sts_iniu_sys"
    print(f"config name: {cfg.name}")
    print(f"config prefix: {cfg.prefix}")
    print(f"expected top: {expected_top}")
    print(f"config filelist: {cfg.filelist}")

    template_ip = cfg.get_or_create_ip()
    template_ip.temp_build()
    unity_wrapper = Path(template_ip.get_unity_wrapper())
    filelist_path = Path(template_ip.temp_output_dir) / f"{cfg.prefix}filelist.f"

    check_file("unity wrapper", unity_wrapper)
    check_file("generated filelist", filelist_path)

    if filelist_path.exists():
        print("generated filelist preview:")
        for line in filelist_path.read_text(encoding="utf-8", errors="replace").splitlines()[:12]:
            print(f"  {line}")

    if not unity_wrapper.exists():
        print("FAIL: unity wrapper missing, cannot run slang check")
        return 1

    cmd = f"slang --ignore-unknown-modules {unity_wrapper}"
    driver = Driver()
    driver.addStandardArgs()
    ok = driver.parseCommandLine(cmd, CommandLineOptions())
    print(f"slang parseCommandLine ok: {ok}")
    if not ok:
        print("FAIL: slang failed to parse command line")
        return 1

    driver.processOptions()
    driver.parseAllSources()
    compilation = driver.createCompilation()
    tops = [inst.name for inst in compilation.getRoot().topInstances]
    print(f"top instances ({len(tops)}):")
    for top_name in tops:
        print(f"  {top_name}")

    if expected_top in tops:
        print("PASS: expected top instance is visible to slang")
        return 0

    if len(tops) == 1:
        print(f"PASS: expected top is not listed, but exactly one top instance is visible ({tops[0]})")
        print("note: STS currently relies on VComponent single-top fallback for this filelist shape")
        return 0

    print("FAIL: expected top instance not visible to slang")
    if not tops:
        print("hint: zero top instances usually means filelist expansion or package visibility failed before module discovery")
    else:
        print("hint: multiple unexpected tops usually means filelist ingress or module name selection drift")
    return 1


def main() -> int:
    failures = 0

    section("Template Paths")
    print_path("REPO_ROOT", StsTemplate.REPO_ROOT)
    print_path("STS_NOC_ROOT", StsTemplate.STS_NOC_ROOT)
    print_path("FILELIST_DIR", StsTemplate.FILELIST_DIR)
    print_path("env:RTL_PATH", os.environ.get("RTL_PATH"))
    print_path("env:STS_INIU", os.environ.get("STS_INIU"))
    print_path("env:STS_TNIU", os.environ.get("STS_TNIU"))
    print_path("env:FCIP_DIR", os.environ.get("FCIP_DIR"))
    print_path("env:STS_NOC_DIR", os.environ.get("STS_NOC_DIR"))
    print_path("env:STS_NOC_DEMO_DIR", os.environ.get("STS_NOC_DEMO_DIR"))

    section("Representative Filelists")
    check_file("aon_ss_iniu_sys_config.filelist", Path(StsTemplate.aon_ss_iniu_sys_config.filelist))
    check_file("camera_ss_tniu_sys_config.filelist", Path(StsTemplate.camera_ss_tniu_sys_config.filelist))
    check_file("soc_sts_dec4_config.filelist", Path(StsTemplate.soc_sts_dec4_config.filelist))
    check_file("soc_sts_req_rsp_async_config.filelist", Path(StsTemplate.soc_sts_req_rsp_async_config.filelist))

    failures += inspect_temp_build()

    section("Summary")
    if failures:
        print(f"CHECK_STS_ENV: FAIL ({failures} failing section(s))")
        return 1

    print("CHECK_STS_ENV: PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
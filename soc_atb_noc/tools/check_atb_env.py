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

import AtbTemplate  # noqa: E402
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


def print_makefile_override() -> None:
    makefile = AtbTemplate.ATB_ROOT / "makefile"
    print(f"makefile: {makefile}")
    if not makefile.exists():
        print("  makefile missing")
        return
    for line in makefile.read_text(encoding="utf-8", errors="replace").splitlines():
        if "LWNOC_LOWPOWER_COMPONENT" in line or "LOWPOWER_PATH" in line:
            print(f"  override line: {line.strip()}")
            return
    print("  no lowpower override line found")


def inspect_temp_build() -> int:
    section("Template Temp Build")
    cfg = AtbTemplate.dsp_iniu_cfg
    expected_top = f"{cfg.prefix}atb_iniu_sys"
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

    print("FAIL: expected top instance not visible to slang")
    if not tops:
        print("hint: zero top instances usually means filelist expansion or package visibility failed before module discovery")
    else:
        print("hint: top exists mismatch usually means prefix or module name mismatch")
    return 1


def main() -> int:
    failures = 0

    section("Template Paths")
    print_path("REPO_ROOT", REPO_ROOT)
    print_path("ATB_ROOT", AtbTemplate.ATB_ROOT)
    print_path("VC_DIR", AtbTemplate.VC_DIR)
    lp_root = os.environ.get("LWNOC_LOWPOWER_COMPONENT")
    print_path("env:LWNOC_LOWPOWER_COMPONENT", lp_root)
    print_path("env:LOWPOWER_PATH", os.environ.get("LOWPOWER_PATH"))
    print_path("env:RTL_PATH", os.environ.get("RTL_PATH"))
    print_path("env:ATB_INIU", os.environ.get("ATB_INIU"))
    print_path("env:ATB_SUBIP_ROOT", os.environ.get("ATB_SUBIP_ROOT"))

    section("LP Package Checks")
    if not lp_root:
        print("FAIL: LWNOC_LOWPOWER_COMPONENT is unset after importing AtbTemplate")
        failures += 1
    else:
        lp_path = Path(lp_root)
        pkg_ok = True
        pkg_ok &= check_file("lp define package", lp_path / "src/rtl/lwnoc_lp_define_package.sv")
        pkg_ok &= check_file("lp struct package", lp_path / "src/rtl/lwnoc_lp_struct_package.sv")
        pkg_ok &= check_file("lp core filelist", lp_path / "src/vc/lwnoc_lp_core.f")
        if not pkg_ok:
            print("FAIL: lowpower path is set, but required files are missing under it")
            failures += 1

    section("Representative Filelists")
    check_file("dsp_iniu_cfg.filelist", Path(AtbTemplate.dsp_iniu_cfg.filelist))
    check_file("atb_iniu_noc_config.filelist", Path(AtbTemplate.atb_iniu_noc_config.filelist))
    check_file("debug_tniu_cfg.filelist", Path(AtbTemplate.debug_tniu_cfg.filelist))

    section("Standalone Makefile")
    print_makefile_override()

    failures += inspect_temp_build()

    section("Summary")
    if failures:
        print(f"CHECK_ATB_ENV: FAIL ({failures} failing section(s))")
        return 1

    print("CHECK_ATB_ENV: PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
#!/usr/bin/env python3

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DV_WRAPPER = ROOT / "filelist" / "filelist.f"
DV_COMMON_DEP = ROOT / "filelist" / "intr_common_dep.f"
DV_NIU_CORE = ROOT / "filelist" / "intr_niu_core.f"
DV_NETWORK_CORE = ROOT / "filelist" / "intr_network_core.f"
DV_WRAP_CORE = ROOT / "build_logic" / "soc_intr_noc_wrap" / "filelist.f"
PD_WRAPPER = ROOT / "filelist_pd" / "filelist.f"
PD_CORE = ROOT / "filelist_pd" / "filelist_harden.f"
FLAT_TOKENS = (
    "intr_niu_flat.svh",
    "intr_network_flat.svh",
    "intr_niu_flat.f",
    "intr_network_flat.f",
)
SOURCE_SCAN_DIRS = (
    ROOT / "filelist",
    ROOT / "filelist_pd",
    ROOT / "qc",
    ROOT / "sim",
)
GENERATED_SCAN_DIRS = (
    ROOT / "build_logic",
    ROOT / "build" / "temp",
)


def _safe_lines(path: Path) -> list[str]:
    if not path.exists() or not path.is_file():
        return []
    return path.read_text(errors="ignore").splitlines()


def _has_token(path: Path, token: str) -> bool:
    return any(token in line for line in _safe_lines(path))


def _scan_consumers(scan_roots: tuple[Path, ...]) -> list[tuple[Path, int, str]]:
    hits: list[tuple[Path, int, str]] = []
    for scan_root in scan_roots:
        if not scan_root.exists():
            continue
        for path in sorted(scan_root.rglob("*")):
            if not path.is_file():
                continue
            if path.suffix == ".sh":
                continue
            lines = _safe_lines(path)
            for line_no, line in enumerate(lines, start=1):
                if any(token in line for token in FLAT_TOKENS):
                    hits.append((path, line_no, line.strip()))
    return hits


def _emit_consumer_block(label: str, hits: list[tuple[Path, int, str]]) -> None:
    print(f"{label}_count: {len(hits)}")
    print(f"{label}:")
    if not hits:
        print("  (none)")
        return
    for path, line_no, line in hits:
        rel = path.relative_to(ROOT)
        print(f"  - {rel}:{line_no}: {line}")


def main() -> int:
    dv_wrapper_has_common = _has_token(DV_WRAPPER, "intr_common_dep.f")
    dv_wrapper_has_niu_core = _has_token(DV_WRAPPER, "intr_niu_core.f")
    dv_wrapper_has_network_core = _has_token(DV_WRAPPER, "intr_network_core.f")
    dv_wrapper_has_wrap_core = _has_token(DV_WRAPPER, "soc_intr_noc_wrap/filelist.f")
    pd_wrapper_has_core = _has_token(PD_WRAPPER, "filelist_harden.f")
    dv_niu_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(DV_NIU_CORE))
    dv_network_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(DV_NETWORK_CORE))
    dv_wrap_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(DV_WRAP_CORE))
    pd_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(PD_CORE))

    source_hits = _scan_consumers(SOURCE_SCAN_DIRS)
    generated_hits = _scan_consumers(GENERATED_SCAN_DIRS)

    status_ok = all(
        [
            DV_WRAPPER.exists(),
            DV_COMMON_DEP.exists(),
            DV_NIU_CORE.exists(),
            DV_NETWORK_CORE.exists(),
            DV_WRAP_CORE.exists(),
            dv_wrapper_has_common,
            dv_wrapper_has_niu_core,
            dv_wrapper_has_network_core,
            dv_wrapper_has_wrap_core,
            PD_WRAPPER.exists(),
            PD_CORE.exists(),
            pd_wrapper_has_core,
            not dv_niu_core_refs_flat,
            not dv_network_core_refs_flat,
            not dv_wrap_core_refs_flat,
            not pd_core_refs_flat,
            not source_hits,
            not generated_hits,
        ]
    )

    print(f"status: {'pass' if status_ok else 'fail'}")
    print("scenario: soc_intr_wrapper_ingress_audit")
    print(f"dv_live_wrapper: {DV_WRAPPER}")
    print(f"dv_common_dep: {DV_COMMON_DEP}")
    print(f"dv_niu_core: {DV_NIU_CORE}")
    print(f"dv_network_core: {DV_NETWORK_CORE}")
    print(f"dv_wrap_core: {DV_WRAP_CORE}")
    print(f"pd_live_wrapper: {PD_WRAPPER}")
    print(f"pd_generated_core: {PD_CORE}")
    print(f"dv_wrapper_refs_common_dep: {'yes' if dv_wrapper_has_common else 'no'}")
    print(f"dv_wrapper_refs_niu_core: {'yes' if dv_wrapper_has_niu_core else 'no'}")
    print(f"dv_wrapper_refs_network_core: {'yes' if dv_wrapper_has_network_core else 'no'}")
    print(f"dv_wrapper_refs_wrap_core: {'yes' if dv_wrapper_has_wrap_core else 'no'}")
    print(f"pd_wrapper_refs_generated_core: {'yes' if pd_wrapper_has_core else 'no'}")
    print(f"dv_niu_core_refs_flat_headers: {'yes' if dv_niu_core_refs_flat else 'no'}")
    print(f"dv_network_core_refs_flat_headers: {'yes' if dv_network_core_refs_flat else 'no'}")
    print(f"dv_wrap_core_refs_flat_headers: {'yes' if dv_wrap_core_refs_flat else 'no'}")
    print(f"pd_core_refs_flat_headers: {'yes' if pd_core_refs_flat else 'no'}")
    _emit_consumer_block("source_flat_consumers", source_hits)
    _emit_consumer_block("generated_flat_consumers", generated_hits)

    return 0 if status_ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
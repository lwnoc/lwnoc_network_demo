#!/usr/bin/env python3

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from SocIntrTopoConfig import RING_PLAN


DV_WRAPPER = ROOT / "filelist" / "filelist.f"
DV_COMMON_DEP = ROOT / "filelist" / "intr_common_dep.f"
DV_LOGIC_TOP = ROOT / "build_logic" / "soc_intr_ring_top" / "filelist.f"
DV_WRAP_CORE = ROOT / "build_logic" / "soc_intr_noc_wrap" / "filelist.f"
PD_WRAPPER = ROOT / "filelist_pd" / "filelist.f"
PD_CORE = ROOT / "filelist_pd" / "filelist_harden.f"
PD_WRAP_CORE = ROOT / "build_logic" / "soc_intr_ring_top_pd" / "filelist.f"
DIRECT_ROLE_OUTPUT_DIRS = (
    ("INTR_INIU_TOP_OUT_DIR", "intr_iniu_top_side"),
    ("INTR_TNIU_TOP_OUT_DIR", "intr_tniu_top_side"),
    ("INTR_RING_NETWORK_OUT_DIR", "intr_ring_network"),
)
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


def _sys_dir_env_var(dir_name: str) -> str:
    return f"SOC_INTR_{dir_name.upper()}_OUT_DIR"


def _primary_generated_filelist(path: Path) -> str | None:
    candidates = [entry.name for entry in sorted(path.glob("*_filelist.f")) if entry.name != "expanded_filelist.f"]
    if candidates:
        return candidates[0]
    fallback = path / "filelist.f"
    if fallback.exists():
        return fallback.name
    return None


def _expected_sys_filelist_tokens() -> list[str]:
    tokens: list[str] = []
    for path in sorted((ROOT / "build_logic").glob("*_sys")):
        filelist_name = _primary_generated_filelist(path)
        if filelist_name is None:
            continue
        tokens.append(f"${_sys_dir_env_var(path.name)}/{filelist_name}")
    return tokens


def _expected_role_filelist_tokens() -> list[str]:
    tokens: list[str] = []
    for env_var, dir_name in DIRECT_ROLE_OUTPUT_DIRS:
        if not (ROOT / "build_logic" / dir_name / "filelist.f").exists():
            continue
        tokens.append(f"${env_var}/filelist.f")
    return tokens


def _expected_dv_logic_top_tokens() -> list[str]:
    tokens: list[str] = []
    for entry in RING_PLAN:
        if not isinstance(entry, dict):
            continue

        node_name = entry.get("name")
        node_kind = entry.get("kind")
        if not isinstance(node_name, str):
            continue

        if node_kind in {"iniu", "tniu"}:
            tokens.append(f"build_logic/soc_intr_ring_top/{node_name}_top_wrap.v")
            tokens.append(f"build_logic/soc_intr_ring_top/{node_name}_top_wrap_ring.v")
        elif node_kind == "sink":
            tokens.append(f"build_logic/soc_intr_ring_top/{node_name}.v")
            tokens.append(f"build_logic/soc_intr_ring_top/{node_name}_ring.v")
        elif node_kind == "async":
            tokens.append(f"build_logic/soc_intr_ring_top/{node_name}.v")

    tokens.append("build_logic/soc_intr_ring_top/soc_intr_ring_top.v")
    return tokens


def _missing_tokens(path: Path, tokens: list[str]) -> list[str]:
    return [token for token in tokens if not _has_token(path, token)]


def _scan_consumers(scan_roots: tuple[Path, ...]) -> list[tuple[Path, int, str]]:
    hits: list[tuple[Path, int, str]] = []
    allowed_suffixes = {".f", ".sv", ".svh", ".vh", ".py"}
    for scan_root in scan_roots:
        if not scan_root.exists():
            continue
        for path in sorted(scan_root.rglob("*")):
            if not path.is_file():
                continue
            if path.suffix not in allowed_suffixes:
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
    dv_wrapper_has_wrap_core = _has_token(DV_WRAPPER, "build_logic/soc_intr_noc_wrap/filelist.f")
    dv_wrapper_has_niu_core = _has_token(DV_WRAPPER, "intr_niu_core.f")
    dv_wrapper_has_network_core = _has_token(DV_WRAPPER, "intr_network_core.f")
    dv_logic_top_has_common = _has_token(DV_LOGIC_TOP, "intr_common_dep.f")
    dv_wrap_core_has_wrapper_module = _has_token(DV_WRAP_CORE, "build_logic/soc_intr_noc_wrap/soc_intr_noc_wrap.v")
    pd_wrapper_has_core = _has_token(PD_WRAPPER, "filelist_harden.f")
    pd_core_has_wrap_core = _has_token(PD_CORE, "build_logic/soc_intr_ring_top_pd/filelist.f")
    dv_logic_top_has_sys_payload = any(line.startswith("-f $SOC_INTR_") and "_SYS_OUT_DIR/" in line for line in _safe_lines(DV_LOGIC_TOP))
    dv_wrap_core_has_sys_payload = any(line.startswith("-f $SOC_INTR_") and "_SYS_OUT_DIR/" in line for line in _safe_lines(DV_WRAP_CORE))
    dv_logic_top_has_generated_leaf = _has_token(DV_LOGIC_TOP, "build_logic/soc_intr_ring_top/aon_ss_iniu_top_wrap.v")
    dv_logic_top_has_top_module = _has_token(DV_LOGIC_TOP, "build_logic/soc_intr_ring_top/soc_intr_ring_top.v")
    dv_missing_leaf_tokens = _missing_tokens(DV_LOGIC_TOP, _expected_dv_logic_top_tokens())
    dv_missing_sys_dirs = _missing_tokens(DV_WRAP_CORE, _expected_sys_filelist_tokens())
    dv_logic_top_missing_role_refs = _missing_tokens(DV_LOGIC_TOP, _expected_role_filelist_tokens())
    dv_wrap_core_missing_role_refs = _missing_tokens(DV_WRAP_CORE, _expected_role_filelist_tokens())
    dv_logic_top_has_full_leaf_closure = not dv_missing_leaf_tokens
    dv_wrap_core_has_full_sys_closure = not dv_missing_sys_dirs
    dv_logic_top_has_full_role_closure = not dv_logic_top_missing_role_refs
    dv_wrap_core_has_full_role_closure = not dv_wrap_core_missing_role_refs
    dv_logic_top_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(DV_LOGIC_TOP))
    dv_wrap_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(DV_WRAP_CORE))
    pd_core_refs_flat = any(any(token in line for token in FLAT_TOKENS) for line in _safe_lines(PD_CORE))

    source_hits = _scan_consumers(SOURCE_SCAN_DIRS)
    generated_hits = _scan_consumers(GENERATED_SCAN_DIRS)

    status_ok = all(
        [
            DV_WRAPPER.exists(),
            DV_COMMON_DEP.exists(),
            DV_LOGIC_TOP.exists(),
            DV_WRAP_CORE.exists(),
            dv_wrapper_has_wrap_core,
            dv_logic_top_has_common,
            dv_wrap_core_has_wrapper_module,
            not dv_logic_top_has_sys_payload,
            dv_wrap_core_has_sys_payload,
            dv_logic_top_has_generated_leaf,
            dv_logic_top_has_top_module,
            dv_logic_top_has_full_leaf_closure,
            dv_wrap_core_has_full_sys_closure,
            dv_logic_top_has_full_role_closure,
            dv_wrap_core_has_full_role_closure,
            not dv_wrapper_has_niu_core,
            not dv_wrapper_has_network_core,
            PD_WRAPPER.exists(),
            PD_CORE.exists(),
            PD_WRAP_CORE.exists(),
            pd_wrapper_has_core,
            pd_core_has_wrap_core,
            not dv_logic_top_refs_flat,
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
    print(f"dv_logic_top: {DV_LOGIC_TOP}")
    print(f"dv_wrap_core: {DV_WRAP_CORE}")
    print(f"pd_live_wrapper: {PD_WRAPPER}")
    print(f"pd_generated_core: {PD_CORE}")
    print(f"pd_wrap_core: {PD_WRAP_CORE}")
    print(f"dv_wrapper_refs_wrap_core: {'yes' if dv_wrapper_has_wrap_core else 'no'}")
    print(f"dv_wrapper_refs_niu_core: {'yes' if dv_wrapper_has_niu_core else 'no'}")
    print(f"dv_wrapper_refs_network_core: {'yes' if dv_wrapper_has_network_core else 'no'}")
    print(f"dv_logic_top_refs_common_dep: {'yes' if dv_logic_top_has_common else 'no'}")
    print(f"dv_wrap_core_has_wrapper_module: {'yes' if dv_wrap_core_has_wrapper_module else 'no'}")
    print(f"dv_logic_top_has_sys_payload: {'yes' if dv_logic_top_has_sys_payload else 'no'}")
    print(f"dv_wrap_core_has_sys_payload: {'yes' if dv_wrap_core_has_sys_payload else 'no'}")
    print(f"dv_logic_top_has_generated_leaf: {'yes' if dv_logic_top_has_generated_leaf else 'no'}")
    print(f"dv_logic_top_has_top_module: {'yes' if dv_logic_top_has_top_module else 'no'}")
    print(f"dv_logic_top_has_full_leaf_closure: {'yes' if dv_logic_top_has_full_leaf_closure else 'no'}")
    print(f"dv_wrap_core_has_full_sys_closure: {'yes' if dv_wrap_core_has_full_sys_closure else 'no'}")
    print(f"dv_logic_top_has_full_role_closure: {'yes' if dv_logic_top_has_full_role_closure else 'no'}")
    print(f"dv_wrap_core_has_full_role_closure: {'yes' if dv_wrap_core_has_full_role_closure else 'no'}")
    print(f"pd_wrapper_refs_generated_core: {'yes' if pd_wrapper_has_core else 'no'}")
    print(f"pd_generated_core_refs_wrap_core: {'yes' if pd_core_has_wrap_core else 'no'}")
    print(f"dv_logic_top_refs_flat_headers: {'yes' if dv_logic_top_refs_flat else 'no'}")
    print(f"dv_wrap_core_refs_flat_headers: {'yes' if dv_wrap_core_refs_flat else 'no'}")
    print(f"pd_core_refs_flat_headers: {'yes' if pd_core_refs_flat else 'no'}")
    print(f"dv_missing_leaf_tokens_count: {len(dv_missing_leaf_tokens)}")
    print(f"dv_missing_sys_dirs_count: {len(dv_missing_sys_dirs)}")
    print(f"dv_logic_top_missing_role_refs_count: {len(dv_logic_top_missing_role_refs)}")
    print(f"dv_wrap_core_missing_role_refs_count: {len(dv_wrap_core_missing_role_refs)}")
    if dv_missing_leaf_tokens:
        print("dv_missing_leaf_tokens:")
        for token in dv_missing_leaf_tokens:
            print(f"  - {token}")
    else:
        print("dv_missing_leaf_tokens:\n  (none)")
    if dv_missing_sys_dirs:
        print("dv_missing_sys_dirs:")
        for token in dv_missing_sys_dirs:
            print(f"  - {token}")
    else:
        print("dv_missing_sys_dirs:\n  (none)")
    if dv_logic_top_missing_role_refs:
        print("dv_logic_top_missing_role_refs:")
        for token in dv_logic_top_missing_role_refs:
            print(f"  - {token}")
    else:
        print("dv_logic_top_missing_role_refs:\n  (none)")
    if dv_wrap_core_missing_role_refs:
        print("dv_wrap_core_missing_role_refs:")
        for token in dv_wrap_core_missing_role_refs:
            print(f"  - {token}")
    else:
        print("dv_wrap_core_missing_role_refs:\n  (none)")
    _emit_consumer_block("source_flat_consumers", source_hits)
    _emit_consumer_block("generated_flat_consumers", generated_hits)

    return 0 if status_ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
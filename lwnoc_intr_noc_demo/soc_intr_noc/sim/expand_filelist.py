#!/usr/bin/env python3

from __future__ import annotations

import argparse
import os
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
REPO_ROOT = DEMO_DIR.parent.parent


def _normalize_env_token(name: str) -> str:
    return name.replace("-", "_").upper()


def _seed_default_env() -> None:
    build_logic_dir = DEMO_DIR / "build_logic"
    intr_root = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"

    defaults = {
        "INTR_NOC_DEMO_DIR": str(DEMO_DIR),
        "INTR_INIU_TOP_OUT_DIR": str(build_logic_dir / "intr_iniu_top_side"),
        "INTR_TNIU_TOP_OUT_DIR": str(build_logic_dir / "intr_tniu_top_side"),
        "INTR_RING_NETWORK_OUT_DIR": str(build_logic_dir / "intr_ring_network"),
        "INTR_RING_BUF_OUT_DIR": str(build_logic_dir / "intr_ring_buf"),
        "INTR_RING_STATION_OUT_DIR": str(build_logic_dir / "intr_ring_station"),
        "INTR_RING_LINK_OUT_DIR": str(build_logic_dir / "intr_ring_link"),
        "INTR_RING_REQ_SINK_OUT_DIR": str(build_logic_dir / "intr_ring_req_sink"),
        "INTR_RING_REQ_ZERO_SOURCE_OUT_DIR": str(build_logic_dir / "intr_ring_req_zero_source"),
        "INTERRUPT_INIU": str(intr_root),
        "INTERRUPT_TNIU": str(intr_root),
        "FCIP_DIR": str(intr_root / "fcip"),
        "LWNOC_LOWPOWER_COMPONENT": str(intr_root / "lwnoc_lowpower_component"),
        "lwnoc_lowpower_component": str(intr_root / "lwnoc_lowpower_component"),
    }

    for path in sorted(build_logic_dir.glob("*_sys")):
        if not path.is_dir():
            continue
        defaults[f"SOC_INTR_{_normalize_env_token(path.name)}_OUT_DIR"] = str(path)

    for key, value in defaults.items():
        os.environ.setdefault(key, value)


def _expand_vars(raw: str, src: Path) -> str:
    expanded = os.path.expandvars(raw)
    if "$" in expanded:
        raise RuntimeError(f"Unresolved env var in {src}: {raw}")
    return expanded


def _resolve_path(token: str, src: Path) -> Path:
    path = Path(token)
    if not path.is_absolute():
        local_candidate = (src.parent / path).resolve()
        if local_candidate.exists():
            return local_candidate

        build_root_candidate = (src.parent.parent / path).resolve()
        if build_root_candidate.exists():
            return build_root_candidate

        path = local_candidate
    return path


def _flatten_filelist(src: Path, visited: set[Path]) -> list[str]:
    src = src.resolve()
    if src in visited:
        return []
    if not src.exists():
        raise FileNotFoundError(f"Missing filelist: {src}")
    visited.add(src)

    flattened: list[str] = []
    for raw_line in src.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("//") or line.startswith("#"):
            continue
        if line.startswith("`"):
            continue

        expanded = _expand_vars(line, src)
        if expanded.startswith("-f "):
            nested = _resolve_path(expanded[3:].strip(), src)
            flattened.extend(_flatten_filelist(nested, visited))
            continue

        if expanded.startswith("+incdir+"):
            incdir = _resolve_path(expanded[len("+incdir+") :], src)
            if not incdir.is_dir():
                raise FileNotFoundError(f"Missing incdir in {src}: {incdir}")
            flattened.append(f"+incdir+{incdir}")
            continue

        resolved = _resolve_path(expanded, src)
        if not resolved.exists():
            raise FileNotFoundError(f"Missing RTL file in {src}: {resolved}")
        flattened.append(str(resolved))

    return flattened


def _dedupe_keep_order(entries: list[str]) -> list[str]:
    seen: set[str] = set()
    out: list[str] = []
    for entry in entries:
        if entry in seen:
            continue
        seen.add(entry)
        out.append(entry)
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description="Flatten a hierarchical soc_intr_noc filelist")
    parser.add_argument("input", type=Path, help="Root filelist to expand")
    parser.add_argument("output", type=Path, help="Flat filelist output path")
    args = parser.parse_args()

    _seed_default_env()
    flattened = _dedupe_keep_order(_flatten_filelist(args.input, set()))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text("\n".join(flattened) + "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path


WORKSPACE_ROOT = Path(__file__).resolve().parents[1]
ENTRYPOINT_EXCLUDES = {
    "gen_topo_png.py",
}
LIVE_ROOT_PREFIXES = (
    "build_logic",
    "build_harden",
)
COMPILE_DIR_NAMES = (
    "filelist",
    "filelist_pd",
    "filelists",
)
TOPOLOGY_PATTERNS = (
    "*topology*.json",
    "*topology*.png",
)


def _workspace_relative(path: Path) -> str:
    try:
        return str(path.relative_to(WORKSPACE_ROOT))
    except ValueError:
        return str(path)


def _resolve_demo_root(raw_path: str) -> Path:
    candidate = Path(raw_path)
    if not candidate.is_absolute():
        candidate = (WORKSPACE_ROOT / candidate).resolve()
    return candidate


def _flow_for_entrypoint(path: Path) -> str:
    stem = path.stem
    if stem.endswith("_dv"):
        return "dv"
    if stem.endswith("_pd"):
        return "pd"
    return "default"


def _classify_entrypoint_mode(flows: list[str]) -> str:
    unique_flows = set(flows)
    if unique_flows == {"default"}:
        return "single-flow"
    if unique_flows == {"dv", "pd"}:
        return "dv/pd split"
    if unique_flows == {"default", "dv", "pd"}:
        return "shared-core dv/pd split"
    return "custom"


def _collect_entrypoints(demo_root: Path) -> list[dict[str, str]]:
    entrypoints: list[dict[str, str]] = []
    for path in sorted(demo_root.glob("gen_*.py")):
        if path.name in ENTRYPOINT_EXCLUDES:
            continue
        entrypoints.append(
            {
                "path": _workspace_relative(path),
                "flow": _flow_for_entrypoint(path),
            }
        )
    return entrypoints


def _collect_output_roots(demo_root: Path) -> list[str]:
    roots: list[str] = []
    for path in sorted(demo_root.iterdir()):
        if not path.is_dir():
            continue
        if path.name.startswith(LIVE_ROOT_PREFIXES):
            roots.append(_workspace_relative(path))
    return roots


def _collect_compile_ingresses(demo_root: Path) -> list[str]:
    ingresses: list[str] = []
    for dir_name in COMPILE_DIR_NAMES:
        root = demo_root / dir_name
        if not root.is_dir():
            continue
        for path in sorted(root.glob("*.f")):
            if dir_name in {"filelist", "filelist_pd"}:
                if path.name.startswith("filelist"):
                    ingresses.append(_workspace_relative(path))
                continue

            if path.name.startswith("filelist") or "logic_topo" in path.stem:
                ingresses.append(_workspace_relative(path))
    return ingresses


def _collect_topology_artifacts(demo_root: Path) -> list[str]:
    artifacts: set[Path] = set()
    for pattern in TOPOLOGY_PATTERNS:
        artifacts.update(demo_root.glob(pattern))
    return [_workspace_relative(path) for path in sorted(artifacts)]


def _collect_harden_partition_dirs(demo_root: Path) -> list[str]:
    partitions: list[str] = []
    for root_rel in _collect_output_roots(demo_root):
        root_path = WORKSPACE_ROOT / root_rel
        for path in sorted(root_path.iterdir()):
            if path.is_dir() and "harden" in path.name.lower():
                partitions.append(_workspace_relative(path))
    return partitions


def _collect_harden_refs(demo_root: Path) -> list[dict[str, str | int]]:
    refs: list[dict[str, str | int]] = []
    for rel_path in _collect_compile_ingresses(demo_root):
        path = WORKSPACE_ROOT / rel_path
        for line_no, raw_line in enumerate(path.read_text(errors="ignore").splitlines(), start=1):
            line = raw_line.strip()
            if "harden" not in line.lower():
                continue
            refs.append(
                {
                    "path": rel_path,
                    "line": line_no,
                    "text": line,
                }
            )
    return refs


def _build_report(demo_root: Path) -> dict[str, object]:
    entrypoints = _collect_entrypoints(demo_root)
    output_roots = _collect_output_roots(demo_root)
    compile_ingresses = _collect_compile_ingresses(demo_root)
    topology_artifacts = _collect_topology_artifacts(demo_root)
    harden_partition_dirs = _collect_harden_partition_dirs(demo_root)
    harden_refs = _collect_harden_refs(demo_root)
    flows = [entry["flow"] for entry in entrypoints]

    return {
        "demo_root": _workspace_relative(demo_root),
        "entrypoint_mode": _classify_entrypoint_mode(flows) if flows else "none",
        "entrypoints": entrypoints,
        "output_roots": output_roots,
        "compile_ingresses": compile_ingresses,
        "topology_artifacts": topology_artifacts,
        "harden_partition_dirs": harden_partition_dirs,
        "harden_ingress_refs": harden_refs,
        "summary": {
            "has_split_entrypoints": {"dv", "pd"}.issubset(set(flows)),
            "has_pd_output_root": any(Path(path).name.endswith("_pd") for path in output_roots),
            "has_pd_compile_ingress": any("filelist_pd/" in path for path in compile_ingresses),
            "has_harden_partition_delivery": bool(harden_partition_dirs or harden_refs),
            "has_topology_artifacts": bool(topology_artifacts),
        },
    }


def _print_text_report(report: dict[str, object]) -> None:
    print(f"demo_root: {report['demo_root']}")
    print(f"entrypoint_mode: {report['entrypoint_mode']}")

    print("entrypoints:")
    entrypoints = report["entrypoints"]
    if entrypoints:
        for entry in entrypoints:
            print(f"  - {entry['path']} [{entry['flow']}]")
    else:
        print("  (none)")

    for key in ("output_roots", "compile_ingresses", "topology_artifacts", "harden_partition_dirs"):
        print(f"{key}:")
        values = report[key]
        if values:
            for value in values:
                print(f"  - {value}")
        else:
            print("  (none)")

    print("harden_ingress_refs:")
    harden_refs = report["harden_ingress_refs"]
    if harden_refs:
        for ref in harden_refs:
            print(f"  - {ref['path']}:{ref['line']}: {ref['text']}")
    else:
        print("  (none)")

    print("summary:")
    for key, value in report["summary"].items():
        print(f"  - {key}: {'yes' if value else 'no'}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Report topology generation capabilities for a demo root.")
    parser.add_argument("demo_root", help="Demo root path, relative to the workspace or absolute.")
    parser.add_argument("--json", action="store_true", help="Print the report as JSON.")
    args = parser.parse_args()

    demo_root = _resolve_demo_root(args.demo_root)
    if not demo_root.is_dir():
        print(f"error: demo root not found: {demo_root}", file=sys.stderr)
        return 2

    report = _build_report(demo_root)
    if args.json:
        print(json.dumps(report, indent=2, sort_keys=True))
        return 0

    _print_text_report(report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
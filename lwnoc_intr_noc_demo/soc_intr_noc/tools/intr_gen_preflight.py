"""Pre-flight checks for SoC interrupt NoC generation."""

import os
import re
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent.parent


def declares_module(content: str, module_name: str) -> bool:
    plain = re.search(rf"\bmodule\s+{re.escape(module_name)}\b", content)
    macro_wrapped = re.search(
        rf"\bmodule\s+`[A-Za-z0-9_]+\(\s*{re.escape(module_name)}\s*\)",
        content,
    )
    return bool(plain or macro_wrapped)


def check_shared_intr_assets(intr_root: Path) -> None:
    os.environ.setdefault("INTERRUPT_INIU", str(intr_root))
    os.environ.setdefault("INTERRUPT_TNIU", str(intr_root))
    os.environ.setdefault("FCIP_DIR", str(intr_root / "fcip"))
    os.environ.setdefault("LWNOC_LOWPOWER_COMPONENT", str(intr_root / "lwnoc_lowpower_component"))
    os.environ.setdefault("lwnoc_lowpower_component", str(intr_root / "lwnoc_lowpower_component"))

    required_vc_files = [
        "iniu_filelist.f", "tniu_filelist.f",
        "iniu_top.f", "tniu_top.f",
        "network_filelist.f",
    ]
    missing = [f for f in required_vc_files if not (intr_root / "vc" / f).exists()]
    if missing:
        miss_str = "\n".join(f"  - {m}" for m in missing)
        raise RuntimeError(
            "Missing submodule vc/ filelists required by SocIntrTemplate.\n"
            f"Expected under: {intr_root / 'vc'}\n"
            f"Missing:\n{miss_str}"
        )


def report_missing_intr_nodes(
    rtl_root: Path,
    required_modules: tuple[str, ...],
    required_aliases: dict[str, tuple[str, ...]],
    required_migration_candidates: dict[str, tuple[str, ...]],
    required_station_port_groups: tuple[str, ...],
) -> None:
    report_path = THIS_DIR / "qc" / "missing_intr_nodes_report.txt"
    report_path.parent.mkdir(parents=True, exist_ok=True)

    if not rtl_root.exists():
        report_path.write_text(f"status: blocked\nreason: rtl_root_missing\nrtl_root: {rtl_root}\n")
        raise RuntimeError(f"Required RTL root does not exist: {rtl_root}")

    sv_sources = list(rtl_root.rglob("*.sv")) + list(rtl_root.rglob("*.v"))
    found, missing = [], []
    alias_hits = {}
    for mod in required_modules:
        present = False
        matched_name = None
        candidates = (mod,) + required_aliases.get(mod, ())
        for candidate in candidates:
            for src in sv_sources:
                content = src.read_text(errors="ignore")
                if declares_module(content, candidate):
                    present, matched_name = True, candidate
                    break
            if present:
                break
        if present:
            found.append(mod)
            if matched_name and matched_name != mod:
                alias_hits[mod] = matched_name
        else:
            missing.append(mod)

    lines = [
        "status: blocked" if missing else "status: pass",
        f"rtl_root: {rtl_root}",
        f"required_count: {len(required_modules)}",
        f"found_count: {len(found)}",
        f"missing_count: {len(missing)}",
        "",
        "found_modules:",
    ]
    lines.extend(f"  - {m}" for m in found)
    lines.append("")
    lines.append("missing_modules:")
    lines.extend(f"  - {m}" for m in missing)
    lines.append("")
    lines.append("alias_resolutions:")
    if alias_hits:
        lines.extend(f"  - {k} => {v}" for k, v in sorted(alias_hits.items()))
    else:
        lines.append("  - (none)")
    lines.append("")
    lines.append("migration_candidates:")
    migration_lines = []
    for mod in missing:
        candidates = required_migration_candidates.get(mod, ())
        if not candidates:
            continue
        status_list = []
        for cand in candidates:
            cand_present = any(declares_module(src.read_text(errors="ignore"), cand) for src in sv_sources)
            status_list.append(f"{cand}({'found' if cand_present else 'missing'})")
        migration_lines.append(f"  - {mod} => {', '.join(status_list)}")
    if migration_lines:
        lines.extend(migration_lines)
    else:
        lines.append("  - (none)")
    lines.append("")
    lines.append("required_interrupt_req_ring_station_ports:")
    lines.extend(f"  - {port_group}" for port_group in required_station_port_groups)
    lines.append("")
    lines.append("note: generation is blocked if any required module is missing under external RTL root.")
    report_path.write_text("\n".join(lines) + "\n")

    if missing:
        missing_preview = "\n".join(f"  - {m}" for m in missing)
        raise RuntimeError(
            "External RTL-only constraint check failed. Missing required IntrNode modules:\n"
            f"{missing_preview}\n"
            f"Report: {report_path}"
        )


def check_no_demo_local_rtl_refs(forbidden_prefix: str) -> None:
    filelist_dir = THIS_DIR / "filelist"
    offenders = []
    for filelist in sorted(filelist_dir.glob("*.f")):
        for lineno, line in enumerate(filelist.read_text(errors="ignore").splitlines(), start=1):
            if forbidden_prefix in line:
                offenders.append((filelist.name, lineno, line.strip()))

    report_path = THIS_DIR / "qc" / "forbidden_local_rtl_refs.txt"
    if offenders:
        lines = ["status: blocked", f"forbidden_prefix: {forbidden_prefix}", "", "offenders:"]
        lines.extend(f"  - {fname}:{lineno}: {entry}" for fname, lineno, entry in offenders)
        report_path.write_text("\n".join(lines) + "\n")
        preview = "\n".join(f"  - {fname}:{lineno}: {entry}" for fname, lineno, entry in offenders[:12])
        raise RuntimeError(
            "Submodule-only RTL constraint violated by demo-local RTL filelist entries:\n"
            f"{preview}\n"
            f"Report: {report_path}"
        )
    report_path.write_text("status: pass\n" f"forbidden_prefix: {forbidden_prefix}\n" "offenders: 0\n")


def check_visualization_dependencies() -> None:
    if os.environ.get("SKIP_TOPO_VIZ") == "1":
        print("  [topo_check] PNG visualization skipped (SKIP_TOPO_VIZ=1)")
        return
    try:
        import matplotlib.pyplot  # noqa: F401
        import networkx  # noqa: F401
    except ImportError as exc:
        cmd_hint = "pip install matplotlib networkx"
        raise RuntimeError(
            f"Topology visualization requires matplotlib and networkx.\n"
            f"  Missing: {exc}\n"
            f"  Install: {cmd_hint}"
        ) from exc

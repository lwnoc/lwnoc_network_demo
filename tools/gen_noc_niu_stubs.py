#!/usr/bin/env python3

from __future__ import annotations

import argparse
import importlib
import json
import math
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parent.parent
BUILD_DIR = REPO_ROOT / "build" / "niu_stub_views"
TEMP_RESOLVED_FILELIST_DIR = REPO_ROOT / "build" / "temp" / "niu_stub_views_filelists"


@dataclass(frozen=True)
class StubSpec:
    noc: str
    category: str
    template_module: str
    config_attr: str
    top_module: str
    extra_sys_paths: tuple[Path, ...] = ()
    fallback_build_dir: Path | None = None
    fallback_top_module: str | None = None

    @property
    def stub_module_name(self) -> str:
        return f"{self.noc}_{self.category}_stub"

    @property
    def file_name(self) -> str:
        return f"{self.stub_module_name}.sv"


@dataclass(frozen=True)
class ParsedPort:
    name: str
    direction: str
    width: int


@dataclass(frozen=True)
class ParsedType:
    name: str
    kind: str
    expr: str | None = None
    msb: str | None = None
    lsb: str | None = None
    fields: tuple[tuple[str, str | None, str | None], ...] = ()


SPECS: tuple[StubSpec, ...] = (
    StubSpec(
        noc="sts",
        category="iniu_sys_side",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_sys_config",
        top_module="sts_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "aon_ss_iniu_sys",
        fallback_top_module="sts_iniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="iniu_top_side",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_noc_side_config",
        top_module="sts_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "aon_ss_iniu_noc_side",
        fallback_top_module="sts_iniu_noc",
    ),
    StubSpec(
        noc="sts",
        category="tniu_sys_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_SYS_CONFIGS.ddrss0",
        top_module="sts_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss0_tniu_sys",
        fallback_top_module="sts_tniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="tniu_top_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_TOP_CONFIGS.ddrss0",
        top_module="sts_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss0_tniu_top_side",
        fallback_top_module="sts_tniu_noc",
    ),
    StubSpec(
        noc="intr",
        category="iniu_sys_side",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_iniu_cfg",
        top_module="interrupt_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "audio_ss_iniu_sys",
        fallback_top_module="audio_ss_iniu_interrupt_iniu_async_sys_side",
    ),
    StubSpec(
        noc="intr",
        category="iniu_top_side",
        template_module="SocIntrTemplate",
        config_attr="soc_intr_iniu_top_config",
        top_module="interrupt_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "audio_ss_iniu_sys",
        fallback_top_module="audio_ss_iniu_interrupt_iniu_async_top_side",
    ),
    StubSpec(
        noc="intr",
        category="tniu_sys_side",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_tniu_cfg",
        top_module="interrupt_tniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "display_ss_tniu_sys",
        fallback_top_module="display_ss_tniu_interrupt_tniu_async_sys_side",
    ),
    StubSpec(
        noc="intr",
        category="tniu_top_side",
        template_module="SocIntrTemplate",
        config_attr="soc_intr_tniu_top_config",
        top_module="interrupt_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "display_ss_tniu_sys",
        fallback_top_module="display_ss_tniu_interrupt_tniu_async_top_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_sys_side",
        template_module="DtiTemplate",
        config_attr="gpu_iniu_sys_config",
        top_module="dti_pr_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "pcie_eth_iniu_sys",
        fallback_top_module="pcie_eth_dti_pr_iniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_top_side",
        template_module="DtiTemplate",
        config_attr="gpu_iniu_sys_config",
        top_module="dti_pr_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="dti",
        category="tniu_sys_side",
        template_module="DtiTemplate",
        config_attr="tcu_tniu_sys_config",
        top_module="dti_tniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "sys_tcu_tniu_sys",
        fallback_top_module="sys_tcu_dti_tniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="tniu_top_side",
        template_module="DtiTemplate",
        config_attr="tcu_tniu_sys_config",
        top_module="dti_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="atb",
        category="iniu_sys_side",
        template_module="AtbTemplate",
        config_attr="aon_iniu_cfg",
        top_module="aon_atb_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "aon_iniu_sys",
        fallback_top_module="aon_atb_iniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="iniu_top_side",
        template_module="AtbTemplate",
        config_attr="aon_iniu_noc_cfg",
        top_module="aon_noc_atb_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "aon_iniu_noc",
        fallback_top_module="aon_noc_atb_iniu_noc",
    ),
    StubSpec(
        noc="atb",
        category="tniu_sys_side",
        template_module="AtbTemplate",
        config_attr="peri_tniu_cfg",
        top_module="peri_atb_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "peri_tniu_sys",
        fallback_top_module="peri_atb_tniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="tniu_top_side",
        template_module="AtbTemplate",
        config_attr="peri_tniu_noc_cfg",
        top_module="peri_noc_atb_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "peri_tniu_noc",
        fallback_top_module="peri_noc_atb_tniu_noc",
    ),
    # ── Top-level aggregation wrapper stubs ────────────────────────────
    StubSpec(
        noc="atb",
        category="soc_top_wrap",
        template_module="AtbTemplate",
        config_attr="atb_top_wrap_config",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_soc_top_wrap",
        fallback_top_module="atb_soc_top_wrap",
    ),
    StubSpec(
        noc="sts",
        category="soc_top_wrap",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_sys_config",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "sts_soc_top_wrap",
        fallback_top_module="sts_soc_top_wrap",
    ),
    StubSpec(
        noc="intr",
        category="ring_top_wrap",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_iniu_cfg",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "ring_top_wrap",
        fallback_top_module="ring_top_wrap",
    ),
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate review-only NIU boundary stubs with fully expanded vector widths."
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=BUILD_DIR,
        help=f"Output directory for generated stub views (default: {BUILD_DIR}).",
    )
    parser.add_argument(
        "--spec",
        action="append",
        default=[],
        help="Generate only the selected stub spec(s), formatted as noc/category. Repeatable.",
    )
    parser.add_argument(
        "--skip-manifest",
        action="store_true",
        help="Do not rewrite manifest.json. Use for safe targeted regeneration.",
    )
    return parser.parse_args()


def bootstrap_paths() -> None:
    base_paths = [
        REPO_ROOT,
        REPO_ROOT / "lwnoc_topo",
        REPO_ROOT / "lwnoc_sts_noc_demo",
        REPO_ROOT / "lwnoc_intr_noc_demo",
        REPO_ROOT / "soc_dti_noc_demo",
        REPO_ROOT / "soc_atb_noc",
    ]
    for path in base_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)


def patch_port_widths() -> None:
    try:
        from lwnoc_sts_noc_demo.tools.vport_width_patch import patch_vport_width
        patch_vport_width()
    except ModuleNotFoundError:
        pass  # optional post-generation width fixup; run after adding module

def _resolve_attr(obj, part: str):
    """Resolve part from obj: dict key or attribute."""
    if isinstance(obj, dict):
        return obj[part]
    return getattr(obj, part)


def normalize_env_token(name: str) -> str:
    return re.sub(r"(_out)?_dir$", "", name.lower())


def parse_selected_specs(raw_specs: list[str]) -> set[tuple[str, str]]:
    selected: set[tuple[str, str]] = set()
    for raw_spec in raw_specs:
        parts = raw_spec.split("/", 1)
        if len(parts) != 2 or not parts[0] or not parts[1]:
            raise ValueError(f"Invalid --spec '{raw_spec}'. Expected noc/category.")
        selected.add((parts[0], parts[1]))
    return selected


def filter_specs(specs: tuple[StubSpec, ...], raw_specs: list[str]) -> list[StubSpec]:
    if not raw_specs:
        return list(specs)

    selected = parse_selected_specs(raw_specs)
    filtered = [spec for spec in specs if (spec.noc, spec.category) in selected]
    missing = selected.difference((spec.noc, spec.category) for spec in filtered)
    if missing:
        missing_text = ", ".join(f"{noc}/{category}" for noc, category in sorted(missing))
        raise ValueError(f"Unknown --spec value(s): {missing_text}")
    return filtered


def resolve_source_top_file(spec: StubSpec) -> Path | None:
    if spec.fallback_build_dir is None:
        return None

    candidate_names = [name for name in (spec.fallback_top_module, spec.top_module) if name]
    for module_name in candidate_names:
        for suffix in (".sv", ".v"):
            source_file = spec.fallback_build_dir / f"{module_name}{suffix}"
            if source_file.exists():
                return source_file
    return None


def _parse_width_term(raw: str) -> int | None:
    raw = raw.strip()
    if not re.fullmatch(r"0|[1-9][0-9]*", raw):
        return None
    return int(raw, 10)


def clog2(value: int) -> int:
    if value <= 1:
        return 0
    return math.ceil(math.log2(value))


def _split_ternary(expr: str) -> tuple[str, str, str] | None:
    depth = 0
    question_index = -1
    for index, char in enumerate(expr):
        if char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        elif char == "?" and depth == 0:
            question_index = index
            break
    if question_index < 0:
        return None

    depth = 0
    colon_index = -1
    for index in range(question_index + 1, len(expr)):
        char = expr[index]
        if char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        elif char == ":" and depth == 0:
            colon_index = index
            break
    if colon_index < 0:
        return None

    return (
        expr[:question_index].strip(),
        expr[question_index + 1:colon_index].strip(),
        expr[colon_index + 1:].strip(),
    )


def transform_sv_expr(expr: str) -> str | None:
    expr = expr.strip().rstrip(",;")
    if not expr:
        return None

    ternary = _split_ternary(expr)
    if ternary is not None:
        cond, true_expr, false_expr = ternary
        cond_py = transform_sv_expr(cond)
        true_py = transform_sv_expr(true_expr)
        false_py = transform_sv_expr(false_expr)
        if cond_py is None or true_py is None or false_py is None:
            return None
        return f"({true_py} if {cond_py} else {false_py})"

    expr = expr.replace("`", "")
    expr = expr.replace("$clog2", "clog2")
    expr = expr.replace("/", "//")
    return expr


def replace_bits_calls(expr: str, type_widths: dict[str, int]) -> str | None:
    pattern = re.compile(r"\$bits\(\s*([A-Za-z_][A-Za-z0-9_$]*)\s*\)")

    def _replace(match: re.Match[str]) -> str:
        type_name = match.group(1)
        width = type_widths.get(type_name)
        if width is None:
            raise KeyError(type_name)
        return str(width)

    try:
        return pattern.sub(_replace, expr)
    except KeyError:
        return None


def eval_sv_expr(expr: str, symbols: dict[str, int], type_widths: dict[str, int]) -> int | None:
    expr = replace_bits_calls(expr, type_widths)
    if expr is None:
        return None

    expr_py = transform_sv_expr(expr)
    if expr_py is None:
        return None

    try:
        value = eval(expr_py, {"__builtins__": {}}, {"clog2": clog2, **symbols})
    except Exception:  # noqa: BLE001
        return None

    if isinstance(value, bool):
        return int(value)
    if isinstance(value, int):
        return value
    return None


def parse_imported_package_names(source_file: Path) -> list[str]:
    import_re = re.compile(r"^\s*import\s+([A-Za-z_][A-Za-z0-9_$]*)::\*\s*;")
    packages: list[str] = []
    for line in source_file.read_text(encoding="utf-8").splitlines():
        match = import_re.match(line)
        if match is not None:
            packages.append(match.group(1))
    return packages


def find_package_file(package_name: str, anchor_dir: Path) -> Path | None:
    search_roots = [
        anchor_dir,
        anchor_dir.parent,
        REPO_ROOT / "subs",
        REPO_ROOT,
    ]

    seen_roots: set[Path] = set()
    for root in search_roots:
        if root in seen_roots or not root.exists():
            continue
        seen_roots.add(root)
        for suffix in (".sv", ".v"):
            direct = root / f"{package_name}{suffix}"
            if direct.exists():
                return direct

    for root in search_roots:
        if not root.exists():
            continue
        for suffix in (".sv", ".v"):
            matches = list(root.rglob(f"{package_name}{suffix}"))
            if matches:
                return matches[0]
    return None


def collect_related_source_files(source_file: Path) -> list[Path]:
    ordered: list[Path] = []
    queue = [source_file]
    seen: set[Path] = set()

    while queue:
        current = queue.pop(0)
        current = current.resolve()
        if current in seen or not current.exists():
            continue
        seen.add(current)
        ordered.append(current)
        for package_name in parse_imported_package_names(current):
            package_file = find_package_file(package_name, current.parent)
            if package_file is not None:
                queue.append(package_file)

    return ordered


def extract_type_specs(source_file: Path) -> list[ParsedType]:
    lines = source_file.read_text(encoding="utf-8").splitlines()
    enum_start_re = re.compile(r"^\s*typedef\s+enum\s+logic\s+\[(?P<msb>[^:\]]+)\s*:\s*(?P<lsb>[^\]]+)\]\s*\{")
    struct_start_re = re.compile(r"^\s*typedef\s+struct\s+packed\s*\{")
    type_end_re = re.compile(r"^\s*}\s*(?P<name>[A-Za-z_][A-Za-z0-9_$]*)\s*;\s*$")
    logic_typedef_re = re.compile(
        r"^\s*typedef\s+(?:logic|bit|reg)\s+(?:\[(?P<msb>[^:\]]+)\s*:\s*(?P<lsb>[^\]]+)\]\s+)?(?P<name>[A-Za-z_][A-Za-z0-9_$]*)\s*;\s*$"
    )
    field_re = re.compile(
        r"^\s*(?P<type>[A-Za-z_][A-Za-z0-9_$]*|logic|bit|reg)\s*(?:\[(?P<msb>[^:\]]+)\s*:\s*(?P<lsb>[^\]]+)\])?\s+(?P<name>[A-Za-z_][A-Za-z0-9_$]*)\s*;\s*$"
    )

    specs: list[ParsedType] = []
    index = 0
    while index < len(lines):
        line = lines[index]
        enum_match = enum_start_re.match(line)
        if enum_match is not None:
            while index < len(lines) and type_end_re.match(lines[index]) is None:
                index += 1
            if index < len(lines):
                end_match = type_end_re.match(lines[index])
                assert end_match is not None
                specs.append(
                    ParsedType(
                        name=end_match.group("name"),
                        kind="enum",
                        msb=enum_match.group("msb"),
                        lsb=enum_match.group("lsb"),
                    )
                )
            index += 1
            continue

        if struct_start_re.match(line) is not None:
            fields: list[tuple[str, str | None, str | None]] = []
            index += 1
            while index < len(lines):
                end_match = type_end_re.match(lines[index])
                if end_match is not None:
                    specs.append(
                        ParsedType(
                            name=end_match.group("name"),
                            kind="struct",
                            fields=tuple(fields),
                        )
                    )
                    break
                field_match = field_re.match(lines[index])
                if field_match is not None:
                    fields.append(
                        (
                            field_match.group("type"),
                            field_match.group("msb"),
                            field_match.group("lsb"),
                        )
                    )
                index += 1
            index += 1
            continue

        logic_match = logic_typedef_re.match(line)
        if logic_match is not None:
            specs.append(
                ParsedType(
                    name=logic_match.group("name"),
                    kind="logic",
                    msb=logic_match.group("msb"),
                    lsb=logic_match.group("lsb"),
                )
            )
        index += 1

    return specs


def eval_type_width(spec: ParsedType, symbols: dict[str, int], type_widths: dict[str, int]) -> int | None:
    if spec.kind in {"enum", "logic"}:
        if spec.msb is None or spec.lsb is None:
            return 1
        msb_value = _parse_width_term(spec.msb)
        lsb_value = _parse_width_term(spec.lsb)
        if msb_value is None:
            msb_value = eval_sv_expr(spec.msb, symbols, type_widths)
        if lsb_value is None:
            lsb_value = eval_sv_expr(spec.lsb, symbols, type_widths)
        if msb_value is None or lsb_value is None:
            return None
        return abs(msb_value - lsb_value) + 1

    if spec.kind == "struct":
        total_width = 0
        for field_type, msb, lsb in spec.fields:
            if field_type in {"logic", "bit", "reg"}:
                if msb is None or lsb is None:
                    field_width = 1
                else:
                    msb_value = _parse_width_term(msb)
                    lsb_value = _parse_width_term(lsb)
                    if msb_value is None:
                        msb_value = eval_sv_expr(msb, symbols, type_widths)
                    if lsb_value is None:
                        lsb_value = eval_sv_expr(lsb, symbols, type_widths)
                    if msb_value is None or lsb_value is None:
                        return None
                    field_width = abs(msb_value - lsb_value) + 1
            else:
                field_width = type_widths.get(field_type)
                if field_width is None:
                    return None
            total_width += field_width
        return total_width

    return None


def collect_source_symbols(source_file: Path) -> dict[str, int]:
    symbol_files = collect_related_source_files(source_file)
    local_files = sorted(source_file.parent.glob("*_macros_*.sv"))
    local_files += sorted(source_file.parent.glob("*_pack_define.sv"))
    local_files += sorted(source_file.parent.glob("*_pack.sv"))
    local_files += sorted(source_file.parent.glob("*_define.sv"))
    for path in local_files:
        resolved = path.resolve()
        if resolved not in symbol_files:
            symbol_files.append(resolved)

    define_re = re.compile(r"^\s*`define\s+(?P<name>\w+)\s+(?P<expr>.+?)\s*$")
    param_re = re.compile(
        r"^\s*(?:localparam|parameter)(?:\s+\w+)*\s+(?P<name>\w+)\s*=\s*(?P<expr>.+?)\s*(?:[,;])?\s*$"
    )

    type_specs: list[ParsedType] = []
    pending: list[tuple[str, str]] = []
    for path in symbol_files:
        type_specs.extend(extract_type_specs(path))
        for line in path.read_text(encoding="utf-8").splitlines():
            match = define_re.match(line)
            if match is None:
                match = param_re.match(line)
            if match is not None:
                pending.append((match.group("name"), match.group("expr")))

    symbols: dict[str, int] = {}
    type_widths: dict[str, int] = {}
    unresolved = pending
    unresolved_types = type_specs
    for _ in range(12):
        next_unresolved_types: list[ParsedType] = []
        progress = False
        for spec in unresolved_types:
            value = eval_type_width(spec, symbols, type_widths)
            if value is None:
                next_unresolved_types.append(spec)
                continue
            type_widths[spec.name] = value
            progress = True

        next_unresolved: list[tuple[str, str]] = []
        for name, expr in unresolved:
            value = eval_sv_expr(expr, symbols, type_widths)
            if value is None:
                next_unresolved.append((name, expr))
                continue
            symbols[name] = value
            progress = True
        unresolved_types = next_unresolved_types
        unresolved = next_unresolved
        if (not unresolved and not unresolved_types) or not progress:
            break
    return {**type_widths, **symbols}


def parse_source_ports(source_file: Path, top_module: str) -> list[ParsedPort]:
    lines = source_file.read_text(encoding="utf-8").splitlines()
    symbols = collect_source_symbols(source_file)
    module_re = re.compile(rf"^\s*module\s+{re.escape(top_module)}\b")
    port_re = re.compile(
        r"^\s*(input|output|inout)\s+"
        r"(?:(?:logic|wire|reg)\s+)?"
        r"(?:\[(?P<msb>[^:\]]+)\s*:\s*(?P<lsb>[^\]]+)\]\s+)?"
        r"(?P<name>[A-Za-z_][A-Za-z0-9_$]*)"
    )

    saw_module = False
    inside_ports = False
    ports: list[ParsedPort] = []

    for line in lines:
        stripped = line.strip()
        if not saw_module:
            if module_re.search(line):
                saw_module = True
                if stripped.endswith("(") and "#(" not in stripped:
                    inside_ports = True
            continue

        if not inside_ports:
            if stripped.startswith(")") and stripped.endswith("("):
                inside_ports = True
            continue

        if stripped.startswith(");"):
            break

        match = port_re.match(line.rstrip(","))
        if not match:
            continue

        width = 1
        msb = match.group("msb")
        lsb = match.group("lsb")
        if msb is not None and lsb is not None:
            msb_value = _parse_width_term(msb)
            lsb_value = _parse_width_term(lsb)
            if msb_value is None:
                msb_value = eval_sv_expr(msb, symbols, symbols)
            if lsb_value is None:
                lsb_value = eval_sv_expr(lsb, symbols, symbols)
            if msb_value is not None and lsb_value is not None:
                width = abs(msb_value - lsb_value) + 1

        ports.append(
            ParsedPort(
                name=match.group("name"),
                direction=match.group(1),
                width=width,
            )
        )

    if not saw_module:
        raise ValueError(f"Module '{top_module}' not found in {source_file}")
    if not ports:
        raise ValueError(f"No ANSI ports parsed for module '{top_module}' in {source_file}")
    return ports


def load_config(spec: StubSpec) -> Any:
    for path in spec.extra_sys_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)

    module = importlib.import_module(spec.template_module)
    attr = spec.config_attr
    if "." in attr:
        obj: Any = module
        for part in attr.split("."):
            obj = _resolve_attr(obj, part)
        return obj
    return getattr(module, attr)


def resolve_build_filelist(spec: StubSpec) -> Path:
    assert spec.fallback_build_dir is not None

    build_dir = spec.fallback_build_dir
    raw_filelist = build_dir / "expanded_filelist.f"
    if not raw_filelist.exists():
        raw_filelist = build_dir / "filelist.f"
    if not raw_filelist.exists():
        candidates = sorted(build_dir.glob("*.f"))
        candidates = [f for f in candidates if f.name != "expanded_filelist.f"]
        if candidates:
            raw_filelist = candidates[0]
    if not raw_filelist.exists():
        raise FileNotFoundError(f"No filelist.f found under {build_dir}")

    TEMP_RESOLVED_FILELIST_DIR.mkdir(parents=True, exist_ok=True)
    resolved_filelist = TEMP_RESOLVED_FILELIST_DIR / f"{spec.stub_module_name}.f"

    # build_logic root = parent of per-IP directories
    build_root = build_dir.parent
    # Build a name→path index for all build_logic subdirs
    dir_index: dict[str, Path] = {}
    for d in build_root.iterdir():
        if d.is_dir():
            dir_index[d.name.lower()] = d

    def _resolve_env_path(raw: str) -> str:
        """Resolve $SOME_VAR/rel/path to an absolute path under build_root."""
        raw = raw.strip()
        m = re.match(r"\$(\w+)/(.+)", raw)
        if not m:
            return raw
        var, rest = m.groups()
        token_candidates = [var.lower(), normalize_env_token(var)]
        # Direct name match
        for token in token_candidates:
            if token in dir_index:
                candidate = dir_index[token] / rest
                if candidate.exists():
                    return str(candidate)
        # Wrapper aggregates often point at the build root itself.
        candidate = build_root / rest
        if candidate.exists():
            return str(candidate)
        # Partial name match
        for token in token_candidates:
            for name, path in dir_index.items():
                if token and token in name:
                    candidate = path / rest
                    if candidate.exists():
                        return str(candidate)
        return raw

    resolved_lines: list[str] = []
    for raw_line in raw_filelist.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("//"):
            continue
        if line.startswith("-f "):
            ref = line[3:]
            resolved = _resolve_env_path(ref)
            resolved_lines.append(f"-f {resolved}")
        elif line.startswith("$"):
            resolved = _resolve_env_path(line)
            resolved_lines.append(resolved)
        else:
            # Relative path — make absolute under build_dir
            if not os.path.isabs(line):
                line = str((build_dir / line).resolve())
            resolved_lines.append(line)

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist


def instantiate_component(spec: StubSpec):
    from uhdl.uhdl.core.TemplateIP import TemplateComponent
    from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

    config = load_config(spec)
    params = dict(getattr(config, "param_overrides", {}) or {})
    top_candidates = [spec.top_module]

    last_error: Exception | None = None
    source_file = resolve_source_top_file(spec)
    if source_file is not None:
        resolved_top_name = spec.fallback_top_module or spec.top_module
        try:
            ports = parse_source_ports(source_file, resolved_top_name)
            return config, ports, resolved_top_name
        except Exception as exc:  # noqa: BLE001
            last_error = exc

    for top_name in top_candidates:
        try:
            component = TemplateComponent(
                config=config,
                top=top_name,
                struct_mode="packed",
                **params,
            )
            return config, component, top_name
        except Exception as exc:  # noqa: BLE001
            last_error = exc

    if spec.fallback_build_dir is not None and spec.fallback_top_module is not None:
        # Resolve filelist env vars to absolute paths, then TemplateComponent.
        from uhdl.uhdl.core.TemplateIP import TemplateComponent
        from uhdl.uhdl.core.TemplateIP import TemplateIPConfig
        filelist = resolve_build_filelist(spec)
        fallback_cfg = TemplateIPConfig(
            name=f"{spec.stub_module_name}_fallback",
            prefix="",
            filelist=str(filelist),
            env_var=f"{spec.stub_module_name.upper()}_FALLBACK",
        )
        component = TemplateComponent(
            config=fallback_cfg,
            top=spec.fallback_top_module,
            struct_mode="packed",
        )
        return config, component, spec.fallback_top_module

    assert last_error is not None
    raise last_error


def io_direction(io: Any) -> str:
    type_name = type(io).__name__
    if type_name == "Input":
        return "input"
    if type_name == "Output":
        return "output"
    if type_name == "Inout":
        return "inout"
    raise ValueError(f"Unsupported IO type {type_name!r} for port {getattr(io, 'name', '<unknown>')}")


def port_width(io: Any) -> int:
    width = int(getattr(io, "width", 0) or 0)
    if width < 1:
        width = 1  # unresolved width fallback, stub output still reviewable
    return width


def port_decl(direction: str, width: int, name: str, dir_width: int, vec_width: int, name_width: int, with_comma: bool) -> str:
    vector = f"logic [{width - 1}:0]"
    comma = "," if with_comma else ""
    return f"    {direction:<{dir_width}} {vector:<{vec_width}} {name:<{name_width}}{comma}"


# ── Port category comments (pattern → description) ─────────────────────
_PORT_COMMENT_RULES: tuple[tuple[str, str], ...] = (
    # Clock & Reset
    ("clk", "clock input"),
    ("rst_n|rstn|reset_n", "active-low reset"),
    # AXI4 channels
    ("_awvalid$|_awready$", "AXI write address valid/ready"),
    ("_awaddr$", "AXI write address"),
    ("_awid$", "AXI write address ID"),
    ("_awlen$", "AXI write burst length"),
    ("_awsize$", "AXI write burst size"),
    ("_awburst$", "AXI write burst type"),
    ("_awlock$", "AXI write lock"),
    ("_awcache$", "AXI write cache"),
    ("_awprot$", "AXI write protection"),
    ("_awqos$", "AXI write QoS"),
    ("_awuser$", "AXI write user"),
    ("_wvalid$|_wready$", "AXI write data valid/ready"),
    ("_wdata$", "AXI write data"),
    ("_wstrb$", "AXI write strobe"),
    ("_wlast$", "AXI write last"),
    ("_bvalid$|_bready$", "AXI write response valid/ready"),
    ("_bid$", "AXI write response ID"),
    ("_bresp$", "AXI write response"),
    ("_arvalid$|_arready$", "AXI read address valid/ready"),
    ("_araddr$", "AXI read address"),
    ("_arid$", "AXI read address ID"),
    ("_arlen$", "AXI read burst length"),
    ("_arsize$", "AXI read burst size"),
    ("_arburst$", "AXI read burst type"),
    ("_arlock$", "AXI read lock"),
    ("_arcache$", "AXI read cache"),
    ("_arprot$", "AXI read protection"),
    ("_arqos$", "AXI read QoS"),
    ("_aruser$", "AXI read user"),
    ("_rvalid$|_rready$", "AXI read data valid/ready"),
    ("_rid$", "AXI read data ID"),
    ("_rdata$", "AXI read data"),
    ("_rresp$", "AXI read response"),
    ("_rlast$", "AXI read last"),
    # APB
    ("p_addr$|_paddr$", "APB address"),
    ("p_wdata$|_pwdata$", "APB write data"),
    ("p_rdata$|_prdata$", "APB read data"),
    ("p_write$|_pwrite$", "APB write enable"),
    ("p_sel$|_psel$", "APB select"),
    ("p_enable$|_penable$", "APB enable"),
    ("p_ready$|_pready$", "APB ready"),
    ("p_slverr$|_pslverr$", "APB slave error"),
    # ATB
    ("_atvalid$", "ATB trace valid"),
    ("_atready$", "ATB trace ready"),
    ("_atbytes$", "ATB trace byte count"),
    ("_atdata$", "ATB trace data"),
    ("_atid$", "ATB trace ID"),
    ("_afvalid$", "ATB flush valid"),
    ("_afready$", "ATB flush ready"),
    ("_syncreq$", "ATB sync request"),
    ("_atwakeup$", "ATB wakeup"),
    # Interrupt
    ("_v_interrupt", "interrupt vector"),
    ("_v_merge_interrupt", "merged interrupt output"),
    # NoC flow control
    ("_req_valid|_req_ready", "request valid/ready"),
    ("_req_payload", "request payload"),
    ("_req_srcid", "request source ID"),
    ("_req_tgtid", "request target ID"),
    ("_req_qos", "request QoS"),
    ("_req_last", "request last beat"),
    ("_rsp_valid|_rsp_ready", "response valid/ready"),
    ("_rsp_payload", "response payload"),
    # CDC / async FIFO
    ("wptr_async", "async FIFO write pointer"),
    ("rptr_async", "async FIFO read pointer (async)"),
    ("rptr_sync", "async FIFO read pointer (sync)"),
    ("pld_sync", "async FIFO payload sync"),
    # Low power
    ("pchannel_paccept|pchannel_pdeny", "power channel accept/deny"),
    ("pchannel_pactive", "power channel active state"),
    ("pchannel_preq", "power channel request"),
    ("pchannel_pstate", "power channel state"),
    ("lp_", "low-power interface"),
    # ID / node
    ("node_id$", "node identifier"),
    ("src_id$", "source ID"),
    ("tgt_id$", "target ID"),
    # Error / safety
    ("_sb_err|_db_err", "ECC error flag (single/double bit)"),
    ("regbank_parity_err", "register bank parity error"),
    ("safety", "safety/fault output"),
    # Timeout
    ("timeout", "timeout value"),
    # Debug
    ("dbg_", "debug interface"),
    # Generic ring
    ("pring_in_if|pring_out_if|nring_in_if|nring_out_if", "ring link interface"),
    ("local_tx|local_rx", "local endpoint interface"),
)


def port_comment(name: str) -> str:
    """Return a //-style comment for a port based on its name pattern."""
    import re
    for pattern, desc in _PORT_COMMENT_RULES:
        if re.search(pattern, name):
            return f"// {desc}"
    return ""


def collect_ports(component_or_ports: Any) -> list[dict[str, Any]]:
    if isinstance(component_or_ports, list):
        return [
            {"name": port.name, "direction": port.direction, "width": port.width}
            for port in component_or_ports
        ]

    ports: list[dict[str, Any]] = []
    for io in component_or_ports.io_list:
        ports.append(
            {
                "name": io.name,
                "direction": io_direction(io),
                "width": port_width(io),
            }
        )
    return ports


def render_stub(spec: StubSpec, config: Any, component: Any, resolved_top_name: str) -> str:
    ports = collect_ports(component)

    dir_width = max(len(port["direction"]) for port in ports)
    vec_width = max(len(f"logic [{port['width'] - 1}:0]") for port in ports)
    name_width = max(len(port["name"]) for port in ports)

    lines = [
        "// Auto-generated by tools/gen_noc_niu_stubs.py.",
        "// Review-only boundary stub with fully expanded vector widths.",
        "// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.",
        "// Future extension: FUSA error related ports will be added on this boundary in a later revision.",
        f"// Requested source top module: {spec.top_module}",
        f"// Resolved source top module: {resolved_top_name}",
        f"// Representative config: {spec.config_attr} (TemplateIPConfig name={getattr(config, 'name', '<unknown>')})",
        f"module {spec.stub_module_name} (",
    ]

    for index, port in enumerate(ports):
        decl = port_decl(
            direction=port["direction"],
            width=port["width"],
            name=port["name"],
            dir_width=dir_width,
            vec_width=vec_width,
            name_width=name_width,
            with_comma=index != len(ports) - 1,
        )
        comment = port_comment(port["name"])
        if comment:
            decl += f"  {comment}"
        lines.append(decl)

    lines.extend(
        [
            ");",
            "",
            "    // Future boundary note:",
            "    // FUSA error reporting ports are intentionally omitted in this review stub today,",
            "    // but this boundary is expected to grow dedicated FUSA error signaling later.",
            "",
            "    // Review-only stub behavior: tie every output low.",
        ]
    )

    output_ports = [port for port in ports if port["direction"] == "output"]
    if output_ports:
        for port in output_ports:
            lines.append(f"    assign {port['name']} = '0;")
    else:
        lines.append("    // This boundary has no output ports to tie off.")

    lines.extend(["", "endmodule"])
    return "\n".join(lines) + "\n"


def write_stub(output_dir: Path, spec: StubSpec, content: str) -> Path:
    noc_dir = output_dir / spec.noc
    noc_dir.mkdir(parents=True, exist_ok=True)
    stub_path = noc_dir / spec.file_name
    stub_path.write_text(content, encoding="utf-8")
    return stub_path


def write_manifest(output_dir: Path, entries: list[dict[str, Any]]) -> Path:
    manifest_path = output_dir / "manifest.json"
    manifest_path.write_text(json.dumps({"generated_stubs": entries}, indent=2) + "\n", encoding="utf-8")
    return manifest_path


def main() -> int:
    args = parse_args()
    bootstrap_paths()
    patch_port_widths()

    specs = filter_specs(SPECS, args.spec)
    manifest_entries: list[dict[str, Any]] = []
    for spec in specs:
        try:
            config, component, resolved_top_name = instantiate_component(spec)
        except Exception as exc:
            print(f"[SKIP] {spec.noc}/{spec.category}: {exc}", file=sys.stderr)
            continue
        content = render_stub(spec, config, component, resolved_top_name)
        stub_path = write_stub(args.output_dir, spec, content)
        ports = collect_ports(component)
        manifest_entries.append(
            {
                "noc": spec.noc,
                "category": spec.category,
                "top_module": spec.top_module,
                "resolved_top_module": resolved_top_name,
                "config_attr": spec.config_attr,
                "config_name": getattr(config, "name", None),
                "stub_module": spec.stub_module_name,
                "path": str(stub_path),
                "port_count": len(ports),
            }
        )

    print(f"output_dir: {args.output_dir}")
    if not args.skip_manifest:
        manifest_path = write_manifest(args.output_dir, manifest_entries)
        print(f"manifest: {manifest_path}")
    for entry in manifest_entries:
        print(f"stub: {entry['path']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
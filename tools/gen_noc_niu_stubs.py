#!/usr/bin/env python3

from __future__ import annotations

import argparse
import importlib
import json
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parent.parent
BUILD_DIR = REPO_ROOT / "build" / "niu_stub_views"
TEMP_RESOLVED_FILELIST_DIR = REPO_ROOT / "build" / "temp" / "niu_stub_views_filelists"

# Optional absolute path override for the lwnoc_topo checkout.
# Fill this in when you want the script to use a fixed local path instead of
# relying on LWNOC_TOPO_ROOT/UHDL_ROOT from the shell environment.
LWNOC_TOPO_ROOT_OVERRIDE = ""

KNOWN_PORT_WIDTH_SUFFIXES: tuple[tuple[str, int], ...] = (
    ("pstate", 3),
    ("pactive", 2),
    ("lp_req", 7),
    ("lp_hub_rx_req", 7),
    ("lp_hub_tx_req", 7),
)

# Struct bit-widths resolved from lwnoc_lp_*_package.sv definitions at repo root.
# These are the $bits() of key struct types used in NIU port declarations.
KNOWN_STRUCT_WIDTHS: dict[str, int] = {
    "lwnoc_lp_req_signal_t": 13,
    "lwnoc_pchannel_state_t": 2,
    "lwnoc_pchannel_active_t": 2,
    "lwnoc_lp_state_t": 3,
}

HDL_SUFFIXES: tuple[str, ...] = (".sv", ".v")
ENV_VAR_PATTERN = re.compile(r"\$\{?([A-Z0-9_]+)\}?")


def parse_macros_file(build_dir: Path) -> dict[str, str]:
    """Extract all `define KEY VALUE pairs and package localparams from *build_dir*.

    Reads *_define.sv (defaults), *_macros_*.sv (instance overrides), and
    *_pkg.sv (`define + localparam declarations).  Macros file wins.
    """
    macros: dict[str, str] = {}
    # Phase 1: *_define.sv and *_pkg.sv (`define defaults)
    for pattern in ("*_define.sv", "*_pkg.sv"):
        for candidate in build_dir.glob(pattern):
            for m in re.finditer(r"`define\s+(\w+)\s+(.+)", candidate.read_text(encoding="utf-8")):
                key = m.group(1)
                val = m.group(2).strip()
                val = re.sub(r"\s*//.*$", "", val)
                macros[key] = val
    # Phase 2: *_macros_*.sv (overrides — wins)
    for candidate in build_dir.glob("*_macros_*.sv"):
        for m in re.finditer(r"`define\s+(\w+)\s+(.+)", candidate.read_text(encoding="utf-8")):
            key = m.group(1)
            val = m.group(2).strip()
            val = re.sub(r"\s*//.*$", "", val)
            macros[key] = val
    # Phase 3: package localparams used by port declarations.
    package_candidates: list[Path] = []
    for pattern in ("*_pkg.sv", "*_pack.sv", "*_package.sv"):
        package_candidates.extend(sorted(build_dir.glob(pattern)))
    for candidate in package_candidates:
        text = candidate.read_text(encoding="utf-8")
        raw_lp: list[tuple[str, str]] = []
        for m in re.finditer(
            r"localparam\s+(?:integer\s+)?(?:unsigned\s+)?(?:int\s+)?(\w+)\s*=\s*(.+?)\s*;",
            text,
            re.DOTALL,
        ):
            name = m.group(1)
            val = m.group(2).strip()
            val = re.sub(r"\s*//.*$", "", val)
            raw_lp.append((name, val))
        # Iterate resolution until stable (handles chains like
        # TIMER_COUNT_WIDTH = $clog2(TIMER_COUNT) where TIMER_COUNT is another localparam)
        for _ in range(10):
            changed = False
            for name, raw_val in raw_lp:
                resolved = _eval_width_expr(raw_val, macros, {})
                if resolved is not None:
                    if name not in macros or str(resolved) != macros[name]:
                        macros[name] = str(resolved)
                        changed = True
            if not changed:
                break
    _backfill_atb_width_macros(macros)
    return macros


def _backfill_atb_width_macros(macros: dict[str, str]) -> None:
    if "ATB_PLD_WIDTH" not in macros:
        for key, raw_val in sorted(macros.items()):
            if not key.endswith("_ATB_PLD_WIDTH"):
                continue
            resolved = _eval_width_expr(raw_val, macros, {})
            if resolved is not None:
                macros["ATB_PLD_WIDTH"] = str(resolved)
                break

    if "ATB_ECC_OH" not in macros and "ATB_PLD_WIDTH" in macros:
        pld_width = int(macros["ATB_PLD_WIDTH"])
        ecc_oh = max(1, (pld_width - 1).bit_length())
        if ecc_oh + pld_width + 1 > 2 ** ecc_oh:
            ecc_oh += 1
        macros["ATB_ECC_OH"] = str(ecc_oh)

    if "ATB_AFIFO_W" not in macros and "ATB_PLD_WIDTH" in macros and "ATB_ECC_OH" in macros:
        macros["ATB_AFIFO_W"] = str(int(macros["ATB_PLD_WIDTH"]) + int(macros["ATB_ECC_OH"]) + 1)


def _eval_width_expr(expr: str, macros: dict[str, str], localparams: dict[str, str]) -> int | None:
    """Best-effort evaluation of a width expression (e.g. 'NIU_ID_WIDTH-1')."""
    resolved = " ".join(expr.strip().split())
    # Substitute known macros (longest first to avoid partial matches)
    for key, val in sorted(macros.items(), key=lambda kv: -len(kv[0])):
        resolved = resolved.replace(f"`{key}", val)
        resolved = re.sub(rf"\b{re.escape(key)}\b", val, resolved)
    # Substitute localparams
    for key, val in sorted(localparams.items(), key=lambda kv: -len(kv[0])):
        resolved = re.sub(rf"\b{re.escape(key)}\b", val, resolved)
    # Replace $bits(struct_type) with known widths
    def _bits_repl(m: re.Match) -> str:
        struct_name = m.group(1)
        w = KNOWN_STRUCT_WIDTHS.get(struct_name)
        return str(w) if w is not None else m.group(0)
    resolved = re.sub(r"\$bits\(\s*(\w+)\s*\)", _bits_repl, resolved)
    # Replace $clog2(X) with Python equivalent
    def _clog2_repl(m: re.Match) -> str:
        inner_val = _eval_width_expr(m.group(1), macros, localparams)
        if inner_val is not None and inner_val > 0:
            return str((inner_val - 1).bit_length())
        return m.group(0)
    # Match $clog2(...) with balanced parens
    def _replace_clog2(s: str) -> str:
        # Find $clog2( ... ) and replace
        pattern = r"\$clog2\(((?:[^()]|\([^()]*\))*)\)"
        prev = None
        while prev != s:
            prev = s
            s = re.sub(pattern, _clog2_repl, s)
        return s
    resolved = _replace_clog2(resolved)
    # Evaluate SV ternary ?: (find outermost ? at depth 0)
    resolved = _eval_ternary(resolved)
    resolved = " ".join(resolved.split())
    try:
        return int(eval(resolved, {"__builtins__": {}}, {}))
    except Exception:
        return None


def _eval_ternary(expr: str) -> str:
    """Evaluate the outermost SV-style ?: ternary in *expr*, returning a value string."""
    expr = _strip_wrapping_parens(expr.strip())
    # Find ? at paren-depth 0
    depth = 0
    qpos = -1
    for i, ch in enumerate(expr):
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        elif ch == "?" and depth == 0:
            qpos = i
            break
    if qpos < 0:
        return expr  # no ternary
    cond = expr[:qpos].strip()
    rest = expr[qpos + 1:]
    # Find matching : at depth 0
    depth = 0
    cpos = -1
    for i, ch in enumerate(rest):
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        elif ch == ":" and depth == 0:
            cpos = i
            break
    if cpos < 0:
        return expr
    true_val = rest[:cpos].strip()
    false_val = rest[cpos + 1:].strip()
    try:
        if eval(cond, {"__builtins__": {}}, {}):
            return true_val
        return false_val
    except Exception:
        return expr


def _strip_wrapping_parens(expr: str) -> str:
    current = expr
    while current.startswith("(") and current.endswith(")"):
        depth = 0
        balanced = True
        wraps_all = True
        for idx, ch in enumerate(current):
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
                if depth < 0:
                    balanced = False
                    break
                if depth == 0 and idx != len(current) - 1:
                    wraps_all = False
                    break
        if not balanced or depth != 0 or not wraps_all:
            break
        current = current[1:-1].strip()
    return current


def _resolve_localparams(text: str, macros: dict[str, str]) -> dict[str, str]:
    """Extract localparam/parameter definitions from a module body.

    Parses the #( ... ) parameter block and evaluates each declaration.
    Handles chains via iterative re-evaluation.
    """
    localparams: dict[str, str] = {}
    raw_defs: list[tuple[str, str]] = []

    # Find the #(...) parameter block
    hash_paren = re.search(r"#\s*\(", text)
    if not hash_paren:
        return localparams

    # Extract the parameter block content by matching parens
    start = hash_paren.end()
    depth = 1
    end = start
    for i in range(start, len(text)):
        if text[i] == "(":
            depth += 1
        elif text[i] == ")":
            depth -= 1
            if depth == 0:
                end = i
                break
    param_block = text[start:end]

    # Split param_block on top-level commas (not inside nested parens)
    decls: list[str] = []
    depth = 0
    current = ""
    for ch in param_block:
        if ch == "(":
            depth += 1
            current += ch
        elif ch == ")":
            depth -= 1
            current += ch
        elif ch == "," and depth == 0:
            decls.append(current.strip())
            current = ""
        else:
            current += ch
    if current.strip():
        decls.append(current.strip())

    # Parse each declaration
    for decl in decls:
        m = re.match(
            r"(?:localparam|parameter)\s+(?:integer\s+)?(?:unsigned\s+)?(?:int\s+)?(\w+)\s*=\s*(.+)",
            decl, re.DOTALL,
        )
        if m:
            raw_defs.append((m.group(1), m.group(2).strip()))

    # Evaluate each definition
    for key, raw_val in raw_defs:
        val = _eval_width_expr(raw_val, macros, localparams)
        if val is not None:
            localparams[key] = str(val)

    # Iterate re-evaluation until stable (handles definition chains)
    for _ in range(10):  # safety limit
        changed = False
        for key, raw_val in raw_defs:
            new_val = _eval_width_expr(raw_val, macros, localparams)
            if new_val is not None and str(new_val) != localparams.get(key):
                localparams[key] = str(new_val)
                changed = True
        if not changed:
            break

    return localparams


def _extract_top_module_ports(top_sv_path: Path, macros: dict[str, str]) -> list[dict[str, Any]]:
    """Parse port declarations from a top-level .sv file and resolve actual widths."""
    text = top_sv_path.read_text(encoding="utf-8")
    localparams = _resolve_localparams(text, macros)

    # Extract module port list. Handles:
    #   module foo ( ports );         module foo #( params ) ( ports );
    mod_match = re.search(r"module\s+(\w+)", text)
    if not mod_match:
        return []
    after_mod = text[mod_match.end():]

    # Skip parameter block #(...) if present
    skip_to = 0
    param_match = re.search(r"#\s*\(", after_mod)
    if param_match:
        depth = 1
        j = param_match.end()
        while j < len(after_mod) and depth > 0:
            if after_mod[j] == "(":
                depth += 1
            elif after_mod[j] == ")":
                depth -= 1
            j += 1
        skip_to = j

    # Find port-list opening (
    port_open_match = re.search(r"\(", after_mod[skip_to:])
    if not port_open_match:
        return []
    open_pos = mod_match.end() + skip_to + port_open_match.start()
    depth = 1
    close_pos = open_pos
    for j in range(open_pos + 1, len(text)):
        ch = text[j]
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                close_pos = j
                break
    port_section = text[open_pos + 1:close_pos]

    # Strip // comments (they bleed into port text after whitespace flattening)
    port_section = re.sub(r"//[^\n]*", "", port_section)

    # Flatten whitespace and normalize
    port_flat = " ".join(port_section.split())

    ports: list[dict[str, Any]] = []
    # Split on top-level commas (not inside parens)
    depth = 0
    current = ""
    for ch in port_flat:
        if ch == "(":
            depth += 1
            current += ch
        elif ch == ")":
            depth -= 1
            current += ch
        elif ch == "," and depth == 0:
            current = current.strip()
            if current:
                p = _parse_one_port(current, macros, localparams)
                if p:
                    ports.append(p)
            current = ""
        else:
            current += ch
    current = current.strip()
    if current:
        p = _parse_one_port(current, macros, localparams)
        if p:
            ports.append(p)

    return ports


def _parse_one_port(port_str: str, macros: dict[str, str], localparams: dict[str, str]) -> dict[str, Any] | None:
    """Parse a single port string like 'input logic [WIDTH-1:0] port_name'."""
    # Remove trailing comment
    port_str = re.sub(r"\s*//.*$", "", port_str).strip()
    m = re.match(
        r"(input|output|inout)\s+(?:logic\s+)?(?:\[([^\]]+)\]\s*)?(\w+)\s*$",
        port_str,
    )
    if not m:
        return None
    direction = m.group(1)
    width_expr = m.group(2)
    name = m.group(3)
    width = 1
    if width_expr:
        # [N:0] or [N:M]
        parts = width_expr.split(":")
        hi = _eval_width_expr(parts[0].strip(), macros, localparams)
        if hi is not None:
            width = hi + 1  # [N:0] → N+1 bits
        else:
            width = 0
    return {"name": name, "direction": direction, "width": width}


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
        config_attr="STS_SOC_TNIU_SYS_CONFIGS[ddrss0]",
        top_module="sts_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss_tniu_sys",
        fallback_top_module="sts_tniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="tniu_top_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_TOP_CONFIGS[ddrss0]",
        top_module="sts_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss_tniu_noc_side",
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
        config_attr="display_ss_tniu_cfg",
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
        config_attr="pcie_eth_iniu_sys_config",
        top_module="dti_pr_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "pcie_eth_iniu_sys",
        fallback_top_module="pcie_eth_dti_pr_iniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_top_side",
        template_module="DtiTemplate",
        config_attr="iniu_top_config",
        top_module="dti_pr_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "dti_iniu_top_side",
        fallback_top_module="dti_iniu_top_dti_pr_iniu_async_top_side",
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
        config_attr="tniu_top_config",
        top_module="dti_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "dti_tniu_top_side",
        fallback_top_module="dti_tniu_top_dti_tniu_async_top_side",
    ),
    StubSpec(
        noc="atb",
        category="iniu_sys_side",
        template_module="AtbTemplate",
        config_attr="_atb_iniu_sys_cfg",
        top_module="atb_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "camera_iniu_sys",
        fallback_top_module="cam_atb_iniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="iniu_top_side",
        template_module="AtbTemplate",
        config_attr="_atb_iniu_noc_cfg",
        top_module="atb_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_iniu_noc",
        fallback_top_module="atb_iniu_noc",
    ),
    StubSpec(
        noc="atb",
        category="tniu_sys_side",
        template_module="AtbTemplate",
        config_attr="_atb_tniu_sys_cfg",
        top_module="atb_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "debug_tniu_sys",
        fallback_top_module="dbg_atb_tniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="tniu_top_side",
        template_module="AtbTemplate",
        config_attr="_atb_tniu_noc_cfg",
        top_module="atb_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_tniu_noc",
        fallback_top_module="atb_tniu_noc",
    ),
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate review-only NIU boundary stubs with fully expanded vector widths."
    )
    parser.add_argument(
        "target_dir",
        nargs="?",
        type=Path,
        help="Optional input directory. Pass a build_logic root for batch mode, or a single publish directory for one top stub.",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=BUILD_DIR,
        help=f"Output directory for generated stub views (default: {BUILD_DIR}).",
    )
    parser.add_argument(
        "--build-dir",
        type=Path,
        default=None,
        help="Ad-hoc mode: point to a build_logic/<name> directory. Uses the first .f filelist found and resolves all port widths.",
    )
    parser.add_argument(
        "--top-module",
        default=None,
        help="Top module name for ad-hoc mode (as it appears in the .sv file, without prefix).",
    )
    parser.add_argument(
        "--stub-name",
        default=None,
        help="Output stub module name (default: <top_module>_stub).",
    )
    parser.add_argument(
        "--build-logic-dir",
        type=Path,
        default=None,
        help="Batch mode: point to a build_logic/ parent directory. Auto-discovers all subdirectories and generates stubs for each.",
    )
    return parser.parse_args()


def resolve_requested_dirs(args: argparse.Namespace) -> tuple[Path | None, Path | None]:
    if args.target_dir is None:
        return args.build_logic_dir, args.build_dir

    if args.build_logic_dir is not None or args.build_dir is not None:
        raise ValueError("Use either positional target_dir or --build-dir/--build-logic-dir, not both.")

    target_dir = args.target_dir.resolve()
    if not target_dir.is_dir():
        raise NotADirectoryError(f"{target_dir} is not a directory")

    child_dirs = [child for child in target_dir.iterdir() if child.is_dir()]
    local_hdl = [child for child in target_dir.iterdir() if child.is_file() and child.suffix.lower() in HDL_SUFFIXES]
    if child_dirs and not local_hdl:
        return target_dir, None
    return None, target_dir


def _resolve_env_topo_root() -> Path | None:
    if LWNOC_TOPO_ROOT_OVERRIDE.strip():
        root = Path(LWNOC_TOPO_ROOT_OVERRIDE).expanduser().resolve()
        if root.name == "uhdl" and (root / "uhdl").is_dir() and (root.parent / "setup_env.sh").exists():
            return root.parent
        return root

    raw_root = os.environ.get("LWNOC_TOPO_ROOT") or os.environ.get("UHDL_ROOT")
    if not raw_root:
        return None

    root = Path(raw_root).expanduser().resolve()
    if root.name == "uhdl" and (root / "uhdl").is_dir() and (root.parent / "setup_env.sh").exists():
        return root.parent
    return root


def bootstrap_paths() -> None:
    base_paths: list[Path] = []
    env_topo_root = _resolve_env_topo_root()
    if env_topo_root is not None:
        base_paths.append(env_topo_root)

    base_paths.extend([
        REPO_ROOT,
        REPO_ROOT / "lwnoc_topo",
        REPO_ROOT / "lwnoc_sts_noc_demo",
        REPO_ROOT / "lwnoc_intr_noc_demo",
        REPO_ROOT / "soc_dti_noc_demo",
        REPO_ROOT / "soc_atb_noc",
    ])
    for path in base_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)


def patch_port_widths() -> None:
    from lwnoc_sts_noc_demo.tools.vport_width_patch import patch_vport_width

    patch_vport_width()


def load_config(spec: StubSpec) -> Any:
    for path in spec.extra_sys_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)

    module = importlib.import_module(spec.template_module)
    parts = spec.config_attr.split(".")
    obj: Any = module
    for part in parts:
        if part.endswith("]") and "[" in part:
            name, key = part.split("[", 1)
            key = key.rstrip("]").strip("\"'")
            obj = getattr(obj, name)[key]
        else:
            obj = getattr(obj, part)
    return obj


def _resolve_existing_build_dir(build_dir: Path, fallback_top_module: str | None) -> Path:
    if build_dir.exists():
        return build_dir

    build_root = build_dir.parent
    if fallback_top_module is None or not build_root.is_dir():
        return build_dir

    suffix_matches: list[Path] = []
    for child in sorted(build_root.iterdir()):
        if not child.is_dir():
            continue
        for suffix in HDL_SUFFIXES:
            if (child / f"{fallback_top_module}{suffix}").exists():
                return child
            if any(child.glob(f"*_{fallback_top_module}{suffix}")):
                suffix_matches.append(child)
                break

    if len(suffix_matches) == 1:
        return suffix_matches[0]

    suffix_dir_matches = [child for child in sorted(build_root.iterdir()) if child.is_dir() and child.name.endswith(build_dir.name)]
    if len(suffix_dir_matches) == 1:
        return suffix_dir_matches[0]

    return build_dir


def resolve_build_filelist(spec: StubSpec) -> Path:
    assert spec.fallback_build_dir is not None

    build_dir = _resolve_existing_build_dir(spec.fallback_build_dir, spec.fallback_top_module)
    return _resolve_filelist_for_build_dir(build_dir, spec.stub_module_name)


def _source_filelist_for_build_dir(build_dir: Path) -> Path:
    preferred = sorted(path for path in build_dir.glob("*.f") if path.name != "expanded_filelist.f")
    if preferred:
        return preferred[0]

    expanded = build_dir / "expanded_filelist.f"
    if expanded.exists():
        return expanded

    raise FileNotFoundError(f"No build filelist found under {build_dir}")


def _normalize_filelist_token(line: str) -> str:
    token = line.strip()
    if token.startswith("-f"):
        return token[2:].strip()
    if token.startswith("+incdir+"):
        return token[len("+incdir+"):].strip()
    return token


def _infer_filelist_search_root(build_dir: Path) -> Path:
    for candidate in (build_dir, *build_dir.parents):
        if candidate.name == "build_logic":
            return candidate
    return build_dir.parent


def _env_var_dir_stem(env_var: str) -> str:
    stem = env_var
    for prefix in ("SOC_ATB_", "SOC_INTR_"):
        if stem.startswith(prefix):
            stem = stem[len(prefix):]
            break
    for suffix in ("_OUT_DIR", "_DIR"):
        if stem.endswith(suffix):
            stem = stem[: -len(suffix)]
            break
    return stem.lower()


def _named_dir_candidates(env_var: str, child_dirs: list[Path]) -> list[Path]:
    if not (env_var.endswith("_DIR") or env_var.endswith("_OUT_DIR")):
        return []

    stem = _env_var_dir_stem(env_var)
    exact = [child for child in child_dirs if child.name.lower() == stem]
    if exact:
        return exact

    suffix_matches = [child for child in child_dirs if child.name.lower().endswith(stem)]
    if suffix_matches:
        return suffix_matches

    stem_tokens = tuple(token for token in stem.split("_") if token)
    token_matches = [
        child
        for child in child_dirs
        if all(token in child.name.lower().split("_") for token in stem_tokens)
    ]
    return token_matches


def _infer_env_var_paths(build_dir: Path, source_filelist: Path) -> dict[str, Path]:
    search_root = _infer_filelist_search_root(build_dir)
    child_dirs = [child for child in sorted(search_root.iterdir()) if child.is_dir()]
    resolved: dict[str, Path] = {}

    for raw_line in source_filelist.read_text(encoding="utf-8").splitlines():
        token = _normalize_filelist_token(raw_line)
        if not token or token.startswith("/"):
            continue

        for match in ENV_VAR_PATTERN.finditer(token):
            env_var = match.group(1)
            if env_var in resolved:
                continue

            suffix = token[match.end():].lstrip("/")
            if not suffix:
                continue

            candidates: list[Path] = []
            named_candidates = _named_dir_candidates(env_var, child_dirs)
            if len(named_candidates) == 1 and (named_candidates[0] / suffix).exists():
                resolved[env_var] = named_candidates[0]
                continue

            root_candidate = search_root / suffix
            if root_candidate.exists():
                candidates.append(search_root)

            for child in child_dirs:
                if (child / suffix).exists():
                    candidates.append(child)

            unique_candidates: list[Path] = []
            seen: set[Path] = set()
            for candidate in candidates:
                if candidate not in seen:
                    unique_candidates.append(candidate)
                    seen.add(candidate)

            if len(unique_candidates) == 1:
                resolved[env_var] = unique_candidates[0]

    return resolved


def _resolve_filelist_line(line: str, build_dir: Path, env_var_paths: dict[str, Path]) -> str:
    resolved_line = line

    def _replace_env_var(match: re.Match[str]) -> str:
        env_var = match.group(1)
        return str(env_var_paths.get(env_var, build_dir))

    resolved_line = ENV_VAR_PATTERN.sub(_replace_env_var, resolved_line)
    if not resolved_line.startswith("/") and not resolved_line.startswith("+") and not resolved_line.startswith("-"):
        resolved_line = str((build_dir / resolved_line).resolve())
    return resolved_line


def _apply_env_var_paths(env_var_paths: dict[str, Path]) -> None:
    for env_var, resolved_path in env_var_paths.items():
        os.environ[env_var] = str(resolved_path)


def _resolve_filelist_for_build_dir(build_dir: Path, tag: str) -> Path:
    source_filelist = _source_filelist_for_build_dir(build_dir)

    TEMP_RESOLVED_FILELIST_DIR.mkdir(parents=True, exist_ok=True)
    safe_tag = re.sub(r"[^A-Za-z0-9_.-]", "_", tag)
    resolved_filelist = TEMP_RESOLVED_FILELIST_DIR / f"{safe_tag}.f"
    env_var_paths = _infer_env_var_paths(build_dir, source_filelist)

    resolved_lines: list[str] = []
    for raw_line in source_filelist.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line:
            continue

        resolved_lines.append(_resolve_filelist_line(line, build_dir, env_var_paths))

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist


def _instantiate_component_from_build_dir(build_dir: Path, top_module: str, stub_name: str):
    from uhdl.uhdl.core.TemplateIP import TemplateComponent
    from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

    source_filelist = _source_filelist_for_build_dir(build_dir)
    _apply_env_var_paths(_infer_env_var_paths(build_dir, source_filelist))
    filelist = _resolve_filelist_for_build_dir(build_dir, stub_name)
    build_cfg = TemplateIPConfig(
        name=f"{stub_name}_build_fallback",
        prefix="",
        filelist=str(filelist),
        env_var=f"{stub_name.upper()}_BUILD_FALLBACK",
    )
    component = TemplateComponent(
        config=build_cfg,
        top=top_module,
        struct_mode="packed",
    )
    return build_cfg, component


def _candidate_filelists(build_dir: Path) -> list[Path]:
    preferred = sorted(
        path for path in build_dir.glob("*_filelist.f") if path.name != "expanded_filelist.f"
    )
    if preferred:
        return preferred

    common = [build_dir / name for name in ("filelist.f", "expanded_filelist.f") if (build_dir / name).exists()]
    if common:
        return common

    return sorted(path for path in build_dir.glob("*.f") if path.name != "expanded_filelist.f")


def _should_skip_top_candidate(path: Path) -> bool:
    name = path.name
    if path.suffix.lower() not in HDL_SUFFIXES:
        return True
    if name.endswith("_define.sv") or name.endswith("_undef.sv") or name.endswith("_undefine.sv"):
        return True
    if name.endswith("_pkg.sv"):
        return True
    if name.endswith("_macros.sv") or "_macros_" in name:
        return True
    return False


def _resolve_top_from_filelists(build_dir: Path) -> Path | None:
    candidates: list[Path] = []
    for filelist in _candidate_filelists(build_dir):
        for raw_line in filelist.read_text(encoding="utf-8").splitlines():
            line = raw_line.strip()
            if not line or line.startswith("//"):
                continue
            if line.startswith("-f") or line.startswith("+incdir+") or line.startswith("-y"):
                continue

            local_path = build_dir / Path(line).name
            if _should_skip_top_candidate(local_path):
                continue
            if local_path.exists():
                candidates.append(local_path)

    return candidates[-1] if candidates else None


def _find_existing_top_file(build_dir: Path, top_module: str) -> Path | None:
    for suffix in HDL_SUFFIXES:
        candidate = build_dir / f"{top_module}{suffix}"
        if candidate.exists():
            return candidate
    return None


def _find_top_sv(build_dir: Path) -> list[Path]:
    """Find likely top-level HDL files in a build directory.

    Top files are wrappers whose names end with _async_sys_side, _async_top_side,
    _noc_side, or similar boundary markers. Falls back to any HDL file that looks like a module.
    """
    filelist_top = _resolve_top_from_filelists(build_dir)
    if filelist_top is not None:
        return [filelist_top]

    markers = (
        "_async_sys_side.sv",
        "_async_top_side.sv",
        "_sys_side.sv",
        "_top_side.sv",
        "_noc_side.sv",
        "_wrap.sv",
        "_async_sys_side.v",
        "_async_top_side.v",
        "_sys_side.v",
        "_top_side.v",
        "_noc_side.v",
        "_wrap.v",
    )
    candidates: list[Path] = []
    for suffix in HDL_SUFFIXES:
        for hdl in sorted(build_dir.glob(f"*{suffix}")):
            if _should_skip_top_candidate(hdl):
                continue
            if any(hdl.name.endswith(marker) for marker in markers):
                candidates.append(hdl)
    if candidates:
        return candidates
    # Fallback: any HDL file that starts a module
    for suffix in HDL_SUFFIXES:
        for hdl in sorted(build_dir.glob(f"*{suffix}")):
            if _should_skip_top_candidate(hdl):
                continue
            text = hdl.read_text(encoding="utf-8")
            if re.search(r"^\s*module\s+\w+\s*(?:#\(|[^#]\()", text, re.MULTILINE):
                candidates.append(hdl)
    return candidates


def ad_hoc_stub(build_dir: Path, top_module: str | None = None, stub_name: str | None = None) -> list[tuple[str, str, list[dict[str, Any]]]]:
    """Generate stubs from a build directory, preferring UHDL elaboration.

    Returns list of (top_module_name, stub_name, ports_list).
    """
    macros = parse_macros_file(build_dir)

    results: list[tuple[str, str, list[dict[str, Any]]]] = []
    top_svs = [_find_existing_top_file(build_dir, top_module)] if top_module else _find_top_sv(build_dir)

    for sv_path in top_svs:
        if sv_path is None or not sv_path.exists():
            continue
        resolved_top = sv_path.stem
        resolved_stub = stub_name or f"{resolved_top}_stub"
        try:
            _, component = _instantiate_component_from_build_dir(build_dir, resolved_top, resolved_stub)
            ports = [
                {
                    "name": io.name,
                    "direction": io_direction(io),
                    "width": port_width(io),
                }
                for io in component.io_list
            ]
        except Exception:
            ports = _extract_top_module_ports(sv_path, macros)
            if not ports:
                continue

        unresolved = [port["name"] for port in ports if int(port.get("width", 0) or 0) < 1]
        if unresolved:
            raise ValueError(
                f"{sv_path.name}: unresolved port widths for {', '.join(unresolved[:8])}"
            )
        results.append((resolved_top, resolved_stub, ports))

    return results


def instantiate_component(spec: StubSpec):
    from uhdl.uhdl.core.TemplateIP import TemplateComponent
    from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

    config = load_config(spec)
    params = dict(getattr(config, "param_overrides", {}) or {})
    top_candidates = [spec.top_module]
    prefix = str(getattr(config, "prefix", "") or "")
    if prefix:
        top_candidates.append(f"{prefix}{spec.top_module}")

    last_error: Exception | None = None
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
        filelist = resolve_build_filelist(spec)
        build_cfg = TemplateIPConfig(
            name=f"{spec.stub_module_name}_build_fallback",
            prefix="",
            filelist=str(filelist),
            env_var=f"{spec.stub_module_name.upper()}_BUILD_FALLBACK",
        )
        component = TemplateComponent(
            config=build_cfg,
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
        name = str(getattr(io, "name", "") or "")
        for suffix, fallback_width in KNOWN_PORT_WIDTH_SUFFIXES:
            if name == suffix or name.endswith(f"_{suffix}"):
                width = fallback_width
                break
    if width < 1:
        raise ValueError(f"Port {io.name} has unresolved width {width}")
    return width


def port_decl(direction: str, width: int, name: str, dir_width: int, vec_width: int, name_width: int, with_comma: bool) -> str:
    vector = f"logic [{width - 1}:0]"
    comma = "," if with_comma else ""
    return f"    {direction:<{dir_width}} {vector:<{vec_width}} {name:<{name_width}}{comma}"


def _render_stub_text(*, build_dir: Path, top_module: str, stub_name: str, ports: list[dict[str, Any]]) -> str:
    """Render a stub .sv from resolved port metadata (no TemplateComponent needed)."""
    dir_width = max((len(p["direction"]) for p in ports), default=6)
    vec_width = max((len(f"logic [{p['width'] - 1}:0]") for p in ports if p["width"] > 0), default=12)
    name_width = max((len(p["name"]) for p in ports), default=8)

    lines = [
        "// Auto-generated by tools/gen_noc_niu_stubs.py (ad-hoc mode).",
        f"// Build dir : {build_dir}",
        f"// Top module: {top_module}",
        f"// Port count: {len(ports)}",
        f"module {stub_name} (",
    ]
    for idx, port in enumerate(ports):
        lines.append(
            port_decl(
                direction=port["direction"],
                width=max(port["width"], 1),
                name=port["name"],
                dir_width=dir_width,
                vec_width=vec_width,
                name_width=name_width,
                with_comma=idx != len(ports) - 1,
            )
        )
    lines.append(");")
    lines.append("")
    output_ports = [p for p in ports if p["direction"] == "output"]
    if output_ports:
        for p in output_ports:
            lines.append(f"    assign {p['name']} = '0;")
    else:
        lines.append("    // No output ports to tie off.")
    lines.append("")
    lines.append("endmodule")
    return "\n".join(lines) + "\n"


def render_stub(spec: StubSpec, config: Any, component: Any, resolved_top_name: str) -> str:
    ports: list[dict[str, Any]] = []
    for io in component.io_list:
        direction = io_direction(io)
        width = port_width(io)
        ports.append({"name": io.name, "direction": direction, "width": width})

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
        lines.append(
            port_decl(
                direction=port["direction"],
                width=port["width"],
                name=port["name"],
                dir_width=dir_width,
                vec_width=vec_width,
                name_width=name_width,
                with_comma=index != len(ports) - 1,
            )
        )

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

    try:
        requested_build_logic_dir, requested_build_dir = resolve_requested_dirs(args)
    except Exception as exc:  # noqa: BLE001
        print(f"error: {exc}", file=sys.stderr)
        return 2

    # ── Ad-hoc batch mode: --build-logic-dir ──
    if requested_build_logic_dir:
        root = requested_build_logic_dir.resolve()
        if not root.is_dir():
            print(f"error: --build-logic-dir {root} is not a directory", file=sys.stderr)
            return 2
        output_dir = args.output_dir
        output_dir.mkdir(parents=True, exist_ok=True)
        total = 0
        for sub in sorted(root.iterdir()):
            if not sub.is_dir():
                continue
            try:
                results = ad_hoc_stub(sub)
            except Exception as exc:
                print(f"skip  : {sub.name}  ({exc})", file=sys.stderr)
                continue
            for top_name, stub_name, ports in results:
                content = _render_stub_text(
                    build_dir=sub,
                    top_module=top_name,
                    stub_name=stub_name,
                    ports=ports,
                )
                stub_path = output_dir / f"{stub_name}.sv"
                stub_path.write_text(content, encoding="utf-8")
                print(f"stub  : {stub_path}  ({len(ports)} ports)")
                total += 1
        print(f"done: {total} stubs from {root}")
        return 0

    # ── Ad-hoc single dir mode: --build-dir ──
    if requested_build_dir:
        build_dir = requested_build_dir.resolve()
        if not build_dir.is_dir():
            print(f"error: --build-dir {build_dir} is not a directory", file=sys.stderr)
            return 2
        try:
            results = ad_hoc_stub(build_dir, top_module=args.top_module, stub_name=args.stub_name)
        except Exception as exc:
            print(f"error: {exc}", file=sys.stderr)
            return 1
        output_dir = args.output_dir
        output_dir.mkdir(parents=True, exist_ok=True)
        for top_name, stub_name, ports in results:
            content = _render_stub_text(
                build_dir=build_dir,
                top_module=top_name,
                stub_name=stub_name,
                ports=ports,
            )
            stub_path = output_dir / f"{stub_name}.sv"
            stub_path.write_text(content, encoding="utf-8")
            print(f"stub: {stub_path}  ({len(ports)} ports)")
        return 0

    manifest_entries: list[dict[str, Any]] = []
    for spec in SPECS:
        config, component, resolved_top_name = instantiate_component(spec)
        content = render_stub(spec, config, component, resolved_top_name)
        stub_path = write_stub(args.output_dir, spec, content)
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
                "port_count": len(component.io_list),
            }
        )

    manifest_path = write_manifest(args.output_dir, manifest_entries)
    print(f"output_dir: {args.output_dir}")
    print(f"manifest: {manifest_path}")
    for entry in manifest_entries:
        print(f"stub: {entry['path']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple


MODULE_RE = re.compile(r"\bmodule\s+([A-Za-z_][A-Za-z0-9_$]*)\b(.*?)\bendmodule\b", re.S)
INSTANCE_RE = re.compile(
    r"\b([A-Za-z_][A-Za-z0-9_$]*)\s*(?:#\s*\((.*?)\)\s*)?([A-Za-z_][A-Za-z0-9_$]*)\s*\((.*?)\)\s*;",
    re.S,
)
EMPTY_CONN_RE = re.compile(r"\.([A-Za-z_][A-Za-z0-9_$]*)\s*\(\s*\)", re.S)


KEYWORDS = {
    "module",
    "endmodule",
    "if",
    "else",
    "for",
    "while",
    "always",
    "always_ff",
    "always_comb",
    "assign",
    "case",
    "function",
    "task",
    "generate",
    "endgenerate",
    "typedef",
}

DECL_NOISE = {
    "wire",
    "logic",
    "reg",
    "var",
    "signed",
    "unsigned",
    "const",
    "automatic",
    "static",
}


def split_top_level_commas(text: str) -> List[str]:
    parts: List[str] = []
    depth_paren = 0
    depth_brack = 0
    depth_brace = 0
    start = 0

    for idx, ch in enumerate(text):
        if ch == "(":
            depth_paren += 1
        elif ch == ")":
            depth_paren = max(0, depth_paren - 1)
        elif ch == "[":
            depth_brack += 1
        elif ch == "]":
            depth_brack = max(0, depth_brack - 1)
        elif ch == "{":
            depth_brace += 1
        elif ch == "}":
            depth_brace = max(0, depth_brace - 1)
        elif ch == "," and depth_paren == 0 and depth_brack == 0 and depth_brace == 0:
            parts.append(text[start:idx])
            start = idx + 1

    parts.append(text[start:])
    return parts


def register_decl_names(ports: Dict[str, str], direction: str, decl_text: str) -> None:
    # Remove attributes and packed ranges that are not part of identifier names.
    decl_text = re.sub(r"\(\*.*?\*\)", " ", decl_text, flags=re.S)
    decl_text = re.sub(r"\[[^\]]*\]", " ", decl_text)

    for item in split_top_level_commas(decl_text):
        item = item.split("=", 1)[0].strip()
        if not item:
            continue

        ids = re.findall(r"[A-Za-z_][A-Za-z0-9_$]*", item)
        ids = [tok for tok in ids if tok not in DECL_NOISE and tok not in {"input", "output", "inout"}]
        if ids:
            ports[ids[-1]] = direction


def strip_comments(text: str) -> str:
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    text = re.sub(r"//.*", "", text)
    return text


def extract_module_ports(module_text: str) -> Dict[str, str]:
    ports: Dict[str, str] = {}
    cleaned = strip_comments(module_text)
    body_text = cleaned

    # 1) ANSI-style module header declarations.
    header_match = re.search(
        r"\bmodule\b\s+[A-Za-z_][A-Za-z0-9_$]*\s*(?:#\s*\(.*?\))?\s*\((.*?)\)\s*;",
        cleaned,
        flags=re.S,
    )
    if header_match:
        for entry in split_top_level_commas(header_match.group(1)):
            m = re.match(r"\s*(input|output|inout)\b(.*)", entry, flags=re.S)
            if m:
                register_decl_names(ports, m.group(1), m.group(2))
        body_text = cleaned[header_match.end() :]

    # 2) Body declarations (covers non-ANSI style and keeps parser generic).
    for match in re.finditer(r"\b(input|output|inout)\b(.*?);", body_text, flags=re.S):
        register_decl_names(ports, match.group(1), match.group(2))

    return ports


def line_for_offset(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def collect_modules(files: List[Path]) -> Dict[str, Dict[str, str]]:
    module_ports: Dict[str, Dict[str, str]] = {}
    for file_path in files:
        text = file_path.read_text(encoding="utf-8", errors="replace")
        for module_match in MODULE_RE.finditer(text):
            module_name = module_match.group(1)
            module_text = module_match.group(0)
            module_ports[module_name] = extract_module_ports(module_text)
    return module_ports


def find_violations(
    files: List[Path], module_ports: Dict[str, Dict[str, str]]
) -> Tuple[List[str], List[str]]:
    violations: List[str] = []
    unknowns: List[str] = []

    for file_path in files:
        text = file_path.read_text(encoding="utf-8", errors="replace")
        for module_match in MODULE_RE.finditer(text):
            parent_name = module_match.group(1)
            body = module_match.group(2)
            module_base = module_match.start(2)
            for inst_match in INSTANCE_RE.finditer(body):
                child_module = inst_match.group(1)
                inst_name = inst_match.group(3)
                conns = inst_match.group(4)

                if child_module in KEYWORDS:
                    continue

                known_ports = module_ports.get(child_module)
                for empty_match in EMPTY_CONN_RE.finditer(conns):
                    port_name = empty_match.group(1)
                    line = line_for_offset(text, module_base + inst_match.start(4) + empty_match.start())
                    location = f"{file_path}:{line}"

                    if not known_ports or port_name not in known_ports:
                        unknowns.append(
                            f"{location}: {parent_name}.{inst_name} .{port_name}() direction unknown (child={child_module})"
                        )
                        continue

                    if known_ports[port_name] == "input":
                        violations.append(
                            f"{location}: {parent_name}.{inst_name} .{port_name}() is empty but {child_module}.{port_name} is input"
                        )

    return violations, unknowns


def gather_sv_files(root: Path) -> List[Path]:
    files: List[Path] = []
    for pattern in ("**/*.sv", "**/*.v"):
        files.extend(root.glob(pattern))
    return sorted({path.resolve() for path in files if path.is_file()})


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Fail if named empty connections .port() bind to input formals."
    )
    parser.add_argument("scan_root", type=Path, help="Directory containing generated RTL to scan")
    parser.add_argument(
        "--allow-unknown",
        action="store_true",
        help="Do not fail on empty connections when child formal direction cannot be resolved",
    )
    args = parser.parse_args()

    root = args.scan_root
    if not root.is_dir():
        print(f"[TB] ERROR: scan root not found: {root}", file=sys.stderr)
        return 2

    files = gather_sv_files(root)
    if not files:
        print(f"[TB] ERROR: no .sv/.v files found under {root}", file=sys.stderr)
        return 2

    module_ports = collect_modules(files)
    violations, unknowns = find_violations(files, module_ports)

    if violations:
        print("[TB] ERROR: empty named-port connections on input formals detected:", file=sys.stderr)
        for item in violations:
            print(f"  - {item}", file=sys.stderr)
        if unknowns:
            print("[TB] INFO: additional empty connections with unknown direction:", file=sys.stderr)
            for item in unknowns:
                print(f"  - {item}", file=sys.stderr)
        return 4

    if unknowns and not args.allow_unknown:
        print(
            "[TB] ERROR: empty named-port connections found, but formal direction could not be resolved:",
            file=sys.stderr,
        )
        for item in unknowns:
            print(f"  - {item}", file=sys.stderr)
        print("[TB] Use --allow-unknown only when this is explicitly accepted.", file=sys.stderr)
        return 5

    if unknowns:
        print("[TB] WARN: empty named-port connections with unknown direction:", file=sys.stderr)
        for item in unknowns:
            print(f"  - {item}", file=sys.stderr)

    print("[TB] Empty input-connection gate passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

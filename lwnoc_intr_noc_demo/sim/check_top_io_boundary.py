#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from typing import List, Set


HEADER_RE = re.compile(
    r"\bmodule\b\s+[A-Za-z_][A-Za-z0-9_$]*\s*(?:#\s*\(.*?\))?\s*\((.*?)\)\s*;",
    re.S,
)
INSTANCE_RE = re.compile(
    r"^\s*([A-Za-z_][A-Za-z0-9_$]*)\s+(?:#\s*\(.*?\)\s*)?([A-Za-z_][A-Za-z0-9_$]*)\s*\(",
    re.M | re.S,
)


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


def extract_port_names(verilog_text: str) -> List[str]:
    m = HEADER_RE.search(verilog_text)
    if not m:
        return []

    names: List[str] = []
    for entry in split_top_level_commas(m.group(1)):
        tokens = re.findall(r"[A-Za-z_][A-Za-z0-9_$]*", entry)
        if not tokens:
            continue
        # Last token of ANSI declaration is the formal port identifier.
        names.append(tokens[-1])
    return names


def extract_instance_names(verilog_text: str) -> Set[str]:
    m = HEADER_RE.search(verilog_text)
    if not m:
        return set()

    body = verilog_text[m.end() :]
    names: Set[str] = set()
    for inst in INSTANCE_RE.finditer(body):
        module_name = inst.group(1)
        inst_name = inst.group(2)
        if module_name in {"if", "for", "while", "case", "assign"}:
            continue
        names.add(inst_name)
    return names


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Check generated top IO for leaked internal ring-station interfaces.")
    parser.add_argument("--top-file", required=True, type=Path, help="Generated top RTL path")
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Fail when forbidden internal interfaces are exposed at top IO",
    )
    parser.add_argument(
        "--endpoint-prefix-regex",
        default=r"^(?:iniu\d+|tniu\d+)$",
        help="Regex for instance prefixes that are allowed to own top-level ports",
    )
    args = parser.parse_args()

    if not args.top_file.is_file():
        print(f"[TB] ERROR: top file not found: {args.top_file}", file=sys.stderr)
        return 2

    text = args.top_file.read_text(encoding="utf-8", errors="replace")
    port_names = extract_port_names(text)
    instance_names = extract_instance_names(text)
    if not port_names:
        print(f"[TB] ERROR: failed to parse top module header in {args.top_file}", file=sys.stderr)
        return 2
    if not instance_names:
        print(f"[TB] ERROR: failed to parse instance names in {args.top_file}", file=sys.stderr)
        return 2

    endpoint_re = re.compile(args.endpoint_prefix_regex)
    leaked: List[str] = []
    instance_order = sorted(instance_names, key=len, reverse=True)
    for name in port_names:
        owner = None
        for inst_name in instance_order:
            if name.startswith(inst_name + "_"):
                owner = inst_name
                break
        if owner is None:
            continue
        # Ownership rule: if a top IO is named under an instantiated internal node
        # prefix, that prefix must belong to an endpoint class.
        if not endpoint_re.match(owner):
            leaked.append(name)

    leaked = sorted(leaked)
    if not leaked:
        print("[TB] Top-IO boundary check passed.")
        return 0

    level = "ERROR" if args.strict else "WARN"
    stream = sys.stderr if args.strict else sys.stdout
    print(
        f"[TB] {level}: detected non-endpoint-owned interfaces exposed at top IO "
        f"({len(leaked)} signals)",
        file=stream,
    )
    for name in leaked:
        print(f"  - {name}", file=stream)

    print(
        "[TB] Hint: connect/consume these interfaces inside topology wrappers before "
        "expose_unconnected_interfaces().",
        file=stream,
    )
    return 6 if args.strict else 0


if __name__ == "__main__":
    raise SystemExit(main())

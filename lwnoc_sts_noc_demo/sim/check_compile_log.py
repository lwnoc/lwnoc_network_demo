#!/usr/bin/env python3

import sys
from pathlib import Path


FAIL_HEADERS = {
    "Warning-[OPD] Override previous declaration": "duplicate design-unit declarations",
    "Warning-[PCWM-W] Port connection width mismatch": "port connection width mismatches",
    "Warning-[TFIPC] Too few instance port connections": "too few instance port connections",
}


def collect_findings(lines):
    findings = []
    index = 0
    while index < len(lines):
        matched_header = None
        for header in FAIL_HEADERS:
            if header in lines[index]:
                matched_header = header
                break

        if matched_header is None:
            index += 1
            continue

        block = [lines[index].rstrip("\n")]
        probe = index + 1
        while probe < len(lines):
            line = lines[probe]
            if any(header in line for header in FAIL_HEADERS):
                break
            block.append(line.rstrip("\n"))
            probe += 1
            if not line.strip():
                break

        findings.append((matched_header, block))
        index = probe

    return findings


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: check_compile_log.py <compile.log>", file=sys.stderr)
        return 2

    log_path = Path(sys.argv[1])
    if not log_path.is_file():
        print(f"compile log not found: {log_path}", file=sys.stderr)
        return 2

    findings = collect_findings(log_path.read_text(encoding="utf-8", errors="replace").splitlines())
    if not findings:
        return 0

    counts = {header: 0 for header in FAIL_HEADERS}
    for header, _ in findings:
        counts[header] += 1

    print("[TB] ERROR: compile log contains disallowed warnings:", file=sys.stderr)
    for header, label in FAIL_HEADERS.items():
        count = counts[header]
        if count:
            print(f"  - {label}: {count}", file=sys.stderr)

    for header, block in findings[:8]:
        print(f"[TB] {header}", file=sys.stderr)
        for line in block[1:8]:
            if line:
                print(f"      {line}", file=sys.stderr)

    return 3


if __name__ == "__main__":
    raise SystemExit(main())
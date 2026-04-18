#!/usr/bin/env python3

import re
import sys
from pathlib import Path


OPD_HEADER = "Warning-[OPD] Override previous declaration"
SOURCE_RE = re.compile(r"Source info:\s*(module|interface|program|primitive)\s+([A-Za-z_][A-Za-z0-9_$]*)")
PREV_RE = re.compile(r'at:"([^"]+)"')


def find_duplicate_design_units(lines):
    duplicates = []
    index = 0
    while index < len(lines):
        if OPD_HEADER not in lines[index]:
            index += 1
            continue

        block = []
        probe = index + 1
        while probe < len(lines):
            line = lines[probe]
            if not line.strip() and block:
                break
            if OPD_HEADER in line and block:
                break
            block.append(line.rstrip("\n"))
            probe += 1

        source_kind = None
        source_name = None
        previous_path = None
        current_path = None
        for line in block:
            match = SOURCE_RE.search(line)
            if match:
                source_kind = match.group(1)
                source_name = match.group(2)
            prev_match = PREV_RE.search(line)
            if prev_match and previous_path is None:
                previous_path = prev_match.group(1)
            stripped = line.strip()
            if stripped.startswith('"') and stripped.endswith(','):
                current_path = stripped.strip('",')

        if source_kind and source_name:
            duplicates.append((source_kind, source_name, current_path, previous_path))

        index = probe

    return duplicates


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: check_compile_log.py <compile.log>", file=sys.stderr)
        return 2

    log_path = Path(sys.argv[1])
    if not log_path.is_file():
        print(f"compile log not found: {log_path}", file=sys.stderr)
        return 2

    duplicates = find_duplicate_design_units(log_path.read_text(encoding="utf-8", errors="replace").splitlines())
    if not duplicates:
        return 0

    print("[TB] ERROR: duplicate design-unit declarations detected in compile log:", file=sys.stderr)
    for kind, name, current_path, previous_path in duplicates:
        current_text = current_path or "<unknown current file>"
        previous_text = previous_path or "<unknown previous file>"
        print(
            f"  - {kind} {name}: current={current_text} previous={previous_text}",
            file=sys.stderr,
        )
    print("[TB] Treating duplicate design-unit declarations as a compile failure.", file=sys.stderr)
    return 3


if __name__ == "__main__":
    raise SystemExit(main())
#!/usr/bin/env python3
"""Audit feature testcase coverage/pass status for intr NoC demo.

This script cross-checks:
1) Planned testcases from interrupt_noc_testplan.md
2) Implemented test tasks in tb_intr_ring_noc_4i2t.sv
3) Runtime evidence from tc_sanity.log

Exit code:
- 0: every planned testcase is implemented and has pass evidence
- 2: gaps exist (missing implementation or missing pass evidence)
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

TC_PATTERN = re.compile(r"`(tc\d+[a-z]?)`", re.IGNORECASE)
TASK_PATTERN = re.compile(r"task\s+automatic\s+([a-zA-Z0-9_]+)\s*\(", re.IGNORECASE)
TASK_TC_ID_PATTERN = re.compile(r"^(tc\d+[a-z]?)(?:_|$)", re.IGNORECASE)
LOG_BANNER_PATTERN = re.compile(r"\[TB\]\s+(tc\d+[a-z]?)", re.IGNORECASE)
PASS_LINE_PATTERN = re.compile(r"all interrupt ring NoC testcases PASSED", re.IGNORECASE)
FAIL_COUNT_PATTERN = re.compile(r"\[TB\]\s+pass_count=\d+\s+fail_count=(\d+)")


def normalize(tc_name: str) -> str:
    return tc_name.lower()


def read_text(path: Path) -> str:
    if not path.exists():
        raise FileNotFoundError(f"missing file: {path}")
    return path.read_text(encoding="utf-8", errors="ignore")


def parse_planned_testcases(testplan_text: str) -> list[str]:
    tcs = [normalize(m.group(1)) for m in TC_PATTERN.finditer(testplan_text)]
    # Preserve source order while deduplicating
    return list(dict.fromkeys(tcs))


def parse_implemented_testcases(tb_text: str) -> set[str]:
    implemented: set[str] = set()
    for m in TASK_PATTERN.finditer(tb_text):
        task_name = m.group(1)
        tc_match = TASK_TC_ID_PATTERN.match(task_name)
        if tc_match:
            implemented.add(normalize(tc_match.group(1)))
    return implemented


def parse_passed_testcases(log_text: str) -> tuple[set[str], bool, int | None]:
    seen = {normalize(m.group(1)) for m in LOG_BANNER_PATTERN.finditer(log_text)}
    pass_banner = bool(PASS_LINE_PATTERN.search(log_text))
    fail_count = None
    m = FAIL_COUNT_PATTERN.search(log_text)
    if m:
        fail_count = int(m.group(1))
    return seen, pass_banner, fail_count


def main() -> int:
    parser = argparse.ArgumentParser(description="Audit intr NoC feature testcase closure")
    parser.add_argument("--testplan", required=True, help="Path to interrupt_noc_testplan.md")
    parser.add_argument("--tb", required=True, help="Path to tb_intr_ring_noc_4i2t.sv")
    parser.add_argument("--log", required=True, help="Path to tc_sanity.log")
    args = parser.parse_args()

    testplan_path = Path(args.testplan)
    tb_path = Path(args.tb)
    log_path = Path(args.log)

    try:
        planned = parse_planned_testcases(read_text(testplan_path))
        implemented = parse_implemented_testcases(read_text(tb_path))
        seen_in_log, pass_banner, fail_count = parse_passed_testcases(read_text(log_path))
    except FileNotFoundError as exc:
        print(f"[AUDIT][ERROR] {exc}")
        return 2

    planned_set = set(planned)
    missing_impl = [tc for tc in planned if tc not in implemented]
    no_pass_evidence = [tc for tc in planned if tc not in seen_in_log]

    print("[AUDIT] Interrupt NoC feature testcase closure")
    print(f"[AUDIT] Planned testcases: {len(planned)}")
    print(f"[AUDIT] Implemented testcase tasks: {len(implemented)}")
    print(f"[AUDIT] Seen testcase banners in log: {len(seen_in_log)}")
    print(f"[AUDIT] Log pass banner present: {pass_banner}")
    if fail_count is None:
        print("[AUDIT] Log fail_count: <not found>")
    else:
        print(f"[AUDIT] Log fail_count: {fail_count}")

    print("[AUDIT] Planned testcase IDs:")
    print("  " + ", ".join(planned))

    if missing_impl:
        print("[AUDIT][GAP] Planned but not implemented in tb_intr_ring_noc_4i2t:")
        for tc in missing_impl:
            print(f"  - {tc}")
    else:
        print("[AUDIT] All planned cases are implemented in TB task list.")

    if no_pass_evidence:
        print("[AUDIT][GAP] Planned but no pass/run evidence in tc_sanity.log:")
        for tc in no_pass_evidence:
            print(f"  - {tc}")
    else:
        print("[AUDIT] All planned cases have run evidence in log.")

    ok = not missing_impl and not no_pass_evidence and pass_banner and (fail_count == 0)
    print(f"[AUDIT] Final verdict: {'PASS' if ok else 'FAIL'}")
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main())

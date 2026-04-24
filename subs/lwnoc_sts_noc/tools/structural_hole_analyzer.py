#!/usr/bin/env python3
"""Analyze URG HTML coverage report to identify structural unreachable holes.

Parses the hierarchy and per-module HTML pages to find instances with
low coverage that are structurally unreachable in a non-UVM single-clock
testbench (CDC cells, async bridges, tied-off config, etc.).
"""

import re
import os
import sys
import json
from collections import defaultdict
from pathlib import Path

REPORT_DIR = "log/urg_nouvm"
ROOT_LABELS = ("u_iniu", "u_tniu0", "u_tniu1", "u_tniu2")

# Patterns that indicate structurally unreachable instances in non-UVM bench
CDC_PATTERNS = [
    r"ts_bin2gray",
    r"ts_gray2bin",
    r"pulse_async_bridge",
    r"async_bridge",
    r"async_fifo",
    r"afifo",
    r"sync_ff",
    r"cdc_",
    r"_sync$",
    r"_synchronizer",
    r"double_sync",
    r"dsync",
]

# Lowpower / DFT patterns
LOWPOWER_PATTERNS = [
    r"lowpower",
    r"qactive",
    r"isolation",
    r"retention",
    r"power_ctrl",
]


def read_hierarchy(report_dir):
    """Read all hierarchy HTML files and build instance tree."""
    hier_files = sorted(
        f for f in os.listdir(report_dir)
        if f.startswith("hierarchy") and f.endswith(".html")
    )
    all_content = ""
    for hf in hier_files:
        with open(os.path.join(report_dir, hf)) as f:
            all_content += f.read()
    return all_content


def resolve_roots(all_hier):
    """Find root instance page/tag from hierarchy."""
    pat = re.compile(
        r'<a\s+href="(mod\d+\.html)#inst_tag_(\d+)"[^>]*>\s*(%s)\s*</a>'
        % "|".join(re.escape(r) for r in ROOT_LABELS)
    )
    roots = {}
    for m in pat.finditer(all_hier):
        page, tag, label = m.group(1), m.group(2), m.group(3).strip()
        roots[label] = (page, tag)
    return roots


def parse_mod_page_instances(report_dir, page):
    """Parse a mod page to get all instance sections with their coverage."""
    filepath = os.path.join(report_dir, page)
    if not os.path.exists(filepath):
        return []

    with open(filepath) as f:
        content = f.read()

    # Find all instance sections: <a name="inst_tag_NNN">
    # Each section has instance name, module name, and coverage table
    inst_sections = re.split(r'<a\s+name="inst_tag_(\d+)"', content)

    results = []
    for i in range(1, len(inst_sections), 2):
        if i + 1 >= len(inst_sections):
            break
        tag = inst_sections[i]
        section = inst_sections[i + 1]

        # Extract instance path - typically in a heading or first text
        # Pattern: "Instance: top_nouvm.u_dut.u_xxx.yyy"
        inst_match = re.search(r'Instance\s*:\s*([^\s<]+)', section)
        inst_path = inst_match.group(1) if inst_match else f"unknown_{tag}"

        # Extract module name
        mod_match = re.search(r'Module\s*:\s*([^\s<]+)', section)
        module_name = mod_match.group(1) if mod_match else "unknown"

        # Extract source file
        src_match = re.search(r'Source\s*:\s*([^\s<]+)', section)
        source_file = src_match.group(1) if src_match else ""

        # Extract coverage metrics from the table
        # Look for coverage type rows with covered/total/percentage
        metrics = {}
        for metric_type in ["line", "branch", "toggle", "condition", "fsm"]:
            # Pattern varies but typically: "Line" ... "NNN/MMM" ... "XX.XX%"
            # or separate covered/total columns
            type_pat = re.compile(
                rf'{metric_type}\b.*?(\d+)/(\d+).*?(\d+\.?\d*)%',
                re.IGNORECASE | re.DOTALL
            )
            m = type_pat.search(section[:5000])  # limit search range
            if m:
                covered, total, pct = int(m.group(1)), int(m.group(2)), float(m.group(3))
                metrics[metric_type] = {"covered": covered, "total": total, "pct": pct}

        results.append({
            "tag": tag,
            "instance": inst_path,
            "module": module_name,
            "source": source_file,
            "metrics": metrics,
            "page": page,
        })

    return results


def parse_all_instances_from_hierarchy(all_hier):
    """Extract all instance links and their hierarchy depth."""
    # Parse the nested <ul>/<li> structure to get parent-child relationships
    pat = re.compile(
        r'<a\s+href="(mod\d+\.html)#inst_tag_(\d+)"[^>]*>\s*([^<]+)\s*</a>'
    )
    instances = []
    for m in pat.finditer(all_hier):
        page, tag, name = m.group(1), m.group(2), m.group(3).strip()
        instances.append({"page": page, "tag": tag, "name": name})
    return instances


def extract_coverage_text_report(report_dir):
    """Parse URG text report for per-instance coverage data (alternative approach)."""
    text_dir = os.path.join(report_dir, "cov_text")
    if not os.path.isdir(text_dir):
        return {}

    results = {}
    for f in os.listdir(text_dir):
        if f.endswith(".txt"):
            filepath = os.path.join(text_dir, f)
            with open(filepath) as fh:
                content = fh.read()
            # Parse based on format
            results[f] = content
    return results


def classify_instance(inst_name, module_name, source_file):
    """Classify an instance as structural/CDC/lowpower/functional."""
    full_text = f"{inst_name} {module_name} {source_file}".lower()

    for pat in CDC_PATTERNS:
        if re.search(pat, full_text, re.IGNORECASE):
            return "cdc"

    for pat in LOWPOWER_PATTERNS:
        if re.search(pat, full_text, re.IGNORECASE):
            return "lowpower"

    if "/fcip/" in source_file.lower():
        return "third_party"

    return "functional"


def main():
    report_dir = REPORT_DIR
    if len(sys.argv) > 1:
        report_dir = sys.argv[1]

    print(f"Analyzing: {report_dir}")
    print("=" * 80)

    # Step 1: Read hierarchy
    all_hier = read_hierarchy(report_dir)
    roots = resolve_roots(all_hier)
    print(f"Roots found: {roots}")

    # Step 2: Get all instances from hierarchy
    all_instances = parse_all_instances_from_hierarchy(all_hier)
    print(f"Total instances in hierarchy: {len(all_instances)}")

    # Step 3: Parse each unique mod page for coverage data
    unique_pages = set(inst["page"] for inst in all_instances)
    print(f"Unique module pages: {len(unique_pages)}")

    page_instances = {}
    for page in sorted(unique_pages):
        instances = parse_mod_page_instances(report_dir, page)
        page_instances[page] = instances

    # Step 4: Collect all instances under our roots
    # We need the full hierarchy path to determine parentage
    # For now collect all instances from our root pages and their children
    all_coverage_data = []
    for page, instances in page_instances.items():
        for inst in instances:
            # Check if this instance is under one of our roots
            path = inst["instance"]
            root_match = None
            for label in ROOT_LABELS:
                if f".{label}." in path or path.endswith(f".{label}"):
                    root_match = label
                    break

            if root_match:
                classification = classify_instance(
                    inst["instance"], inst["module"], inst["source"]
                )
                inst["root"] = root_match
                inst["classification"] = classification
                all_coverage_data.append(inst)

    print(f"\nInstances under scope roots: {len(all_coverage_data)}")

    # Step 5: Summarize by classification
    by_class = defaultdict(list)
    for inst in all_coverage_data:
        by_class[inst["classification"]].append(inst)

    print("\n--- Classification Summary ---")
    for cls, insts in sorted(by_class.items()):
        print(f"  {cls}: {len(insts)} instances")

    # Step 6: Show CDC instances with low toggle coverage
    print("\n--- CDC/Async Instances (waiver candidates) ---")
    cdc_waiver_candidates = []
    for inst in by_class.get("cdc", []) + by_class.get("lowpower", []):
        toggle = inst["metrics"].get("toggle", {})
        line = inst["metrics"].get("line", {})
        toggle_pct = toggle.get("pct", -1)
        line_pct = line.get("pct", -1)
        toggle_total = toggle.get("total", 0)

        print(f"  {inst['instance']}")
        print(f"    Module: {inst['module']}")
        print(f"    Classification: {inst['classification']}")
        if toggle:
            print(f"    Toggle: {toggle['covered']}/{toggle['total']} = {toggle_pct:.1f}%")
        if line:
            print(f"    Line: {line['covered']}/{line['total']} = {line_pct:.1f}%")
        for mt, mv in inst["metrics"].items():
            if mt not in ("toggle", "line"):
                print(f"    {mt}: {mv['covered']}/{mv['total']} = {mv['pct']:.1f}%")
        print()

        cdc_waiver_candidates.append({
            "instance": inst["instance"],
            "module": inst["module"],
            "root": inst["root"],
            "classification": inst["classification"],
            "metrics": inst["metrics"],
            "page": inst["page"],
            "tag": inst["tag"],
        })

    # Step 7: Show functional instances with low coverage
    print("\n--- Low Coverage Functional Instances (need testcases) ---")
    functional_low = []
    for inst in by_class.get("functional", []):
        line = inst["metrics"].get("line", {})
        toggle = inst["metrics"].get("toggle", {})
        cond = inst["metrics"].get("condition", {})
        branch = inst["metrics"].get("branch", {})

        # Flag if any metric is significantly below target
        low = False
        for metric in [line, toggle, cond, branch]:
            if metric and metric.get("pct", 100) < 80 and metric.get("total", 0) > 5:
                low = True
                break

        if low:
            functional_low.append(inst)
            print(f"  {inst['instance']}")
            print(f"    Module: {inst['module']}")
            for mt, mv in inst["metrics"].items():
                pct_str = f"{mv['pct']:.1f}%" if mv["total"] > 0 else "N/A"
                marker = " <<<" if mv.get("pct", 100) < 80 and mv.get("total", 0) > 5 else ""
                print(f"    {mt}: {mv['covered']}/{mv['total']} = {pct_str}{marker}")
            print()

    # Step 8: Estimate waiver impact
    print("\n--- Waiver Impact Estimate ---")
    total_toggle_waivable = sum(
        inst["metrics"].get("toggle", {}).get("total", 0)
        for inst in cdc_waiver_candidates
    )
    total_toggle_covered_waivable = sum(
        inst["metrics"].get("toggle", {}).get("covered", 0)
        for inst in cdc_waiver_candidates
    )
    print(f"CDC/LP toggle points waivable: {total_toggle_waivable}")
    print(f"CDC/LP toggle covered: {total_toggle_covered_waivable}")
    print(f"CDC/LP toggle uncovered: {total_toggle_waivable - total_toggle_covered_waivable}")

    # Save results
    output = {
        "cdc_waiver_candidates": cdc_waiver_candidates,
        "functional_low_coverage": [
            {
                "instance": i["instance"],
                "module": i["module"],
                "root": i["root"],
                "metrics": i["metrics"],
            }
            for i in functional_low
        ],
        "summary": {
            "total_instances_in_scope": len(all_coverage_data),
            "cdc_instances": len(by_class.get("cdc", [])),
            "lowpower_instances": len(by_class.get("lowpower", [])),
            "third_party_instances": len(by_class.get("third_party", [])),
            "functional_instances": len(by_class.get("functional", [])),
            "functional_low_coverage": len(functional_low),
        },
    }

    output_path = os.path.join("log", "structural_hole_analysis.json")
    with open(output_path, "w") as f:
        json.dump(output, f, indent=2)
    print(f"\nResults saved to: {output_path}")


if __name__ == "__main__":
    main()

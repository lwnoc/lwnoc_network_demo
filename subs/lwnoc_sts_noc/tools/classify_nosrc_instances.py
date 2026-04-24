#!/usr/bin/env python3
"""Analyze toggle gaps by classifying instances: our-RTL vs FCIP-child."""
import sys
from pathlib import Path
from collections import defaultdict
import re

sys.path.insert(0, str(Path(__file__).parent))
import coverage_scope_extract as cse


def walk(parser, page, inst_id, parent_src="", parent_3p=False):
    node = parser.load_node(page, inst_id)
    self_3p = parser.is_third_party(node)
    toggle = node.instance_metrics["toggle"]
    yield {
        "path": node.full_path,
        "src": node.module_source,
        "self_3p": self_3p,
        "parent_src": parent_src,
        "parent_3p": parent_3p,
        "toggle_cov": toggle.covered,
        "toggle_tot": toggle.total,
    }
    for child in node.children:
        yield from walk(parser, child.page, child.inst_id, node.module_source, self_3p)


def main():
    report_dir = Path("log/urg_nouvm")
    parser = cse.ReportParser(report_dir, list(cse.THIRD_PARTY_PATH_MARKERS))
    start = cse._resolve_start_instances(report_dir)

    # Classify no-source instances by their ancestor chain
    by_category = defaultdict(lambda: {"count": 0, "toggle_tot": 0, "toggle_cov": 0, "examples": []})

    for page, inst_id, label in start:
        for info in walk(parser, page, inst_id):
            if info["src"] or info["self_3p"]:
                continue  # has source or already tagged
            if info["toggle_tot"] == 0:
                continue

            inst_name = info["path"].split(".")[-1]
            gen_name = re.sub(r"\[\d+\]", "[*]", inst_name)

            # Classify by parent
            if info["parent_3p"]:
                cat = f"FCIP-child:{gen_name}"
            elif "/fcip/" in info["parent_src"].lower():
                cat = f"FCIP-child:{gen_name}"
            else:
                cat = f"OUR-RTL-child:{gen_name}"

            d = by_category[cat]
            d["count"] += 1
            d["toggle_tot"] += info["toggle_tot"]
            d["toggle_cov"] += info["toggle_cov"]
            if len(d["examples"]) < 2:
                d["examples"].append(info["path"].replace("top_nouvm.u_dut.", ""))

    # Print sorted by uncov
    sorted_cats = sorted(by_category.items(), key=lambda x: -(x[1]["toggle_tot"] - x[1]["toggle_cov"]))
    fcip_total_uncov = 0
    our_total_uncov = 0
    fcip_total_total = 0
    our_total_total = 0

    print(f"{'Category':<45s} {'Cnt':>5s} {'Covered':>8s} {'Total':>8s} {'Uncov':>8s}")
    print("-" * 80)
    for cat, d in sorted_cats:
        uncov = d["toggle_tot"] - d["toggle_cov"]
        print(f"{cat:<45s} {d['count']:>5d} {d['toggle_cov']:>8d} {d['toggle_tot']:>8d} {uncov:>8d}")
        for ex in d["examples"]:
            print(f"    ex: {ex}")
        if cat.startswith("FCIP"):
            fcip_total_uncov += uncov
            fcip_total_total += d["toggle_tot"]
        else:
            our_total_uncov += uncov
            our_total_total += d["toggle_tot"]

    print()
    print(f"FCIP-child total: {fcip_total_total} toggle, {fcip_total_uncov} uncov")
    print(f"OUR-RTL-child total: {our_total_total} toggle, {our_total_uncov} uncov")


if __name__ == "__main__":
    main()

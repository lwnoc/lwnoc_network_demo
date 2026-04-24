#!/usr/bin/env python3
"""Walk URG HTML tree matching extractor logic, report per-instance toggle gaps after waivers."""
import sys
from pathlib import Path
from collections import defaultdict
import re

sys.path.insert(0, str(Path(__file__).parent))
import coverage_scope_extract as cse


def walk_toggle(parser, page, inst_id, waiver_rules, parent_3p=False):
    """Yield (full_path, covered, total, waiver_info, is_leaf) matching extractor logic."""
    node = parser.load_node(page, inst_id)
    self_3p = parser.is_third_party(node)
    top_3p = self_3p and not parent_3p

    excl = cse._check_subtree_exclusion(node.full_path, waiver_rules)
    if excl is not None:
        yield (node.full_path, 0, 0, f"excluded:{excl}", True)
        return

    adj, applied = cse._with_waivers(node.full_path, node.instance_metrics, waiver_rules)

    if top_3p:
        t = adj["toggle_port"]
        waiver_names = ",".join(w["name"] for w in applied) if applied else ""
        yield (node.full_path, t.covered, t.total, "3P-PORT " + waiver_names, True)
        # DON'T recurse children — matches extractor behavior
    else:
        t = adj["toggle"]
        waiver_names = ",".join(w["name"] for w in applied) if applied else ""
        is_leaf = len(node.children) == 0
        yield (node.full_path, t.covered, t.total, waiver_names, is_leaf)
        for child in node.children:
            yield from walk_toggle(parser, child.page, child.inst_id, waiver_rules, self_3p)


def main():
    report_dir = Path("log/urg_nouvm")
    waiver_file = Path("tools/coverage_waivers_structural.json")
    parser = cse.ReportParser(report_dir, list(cse.THIRD_PARTY_PATH_MARKERS))
    waiver_rules = cse._load_waiver_rules(waiver_file)
    start_instances = cse._resolve_start_instances(report_dir)

    for page, inst_id, label in start_instances:
        results = list(walk_toggle(parser, page, inst_id, waiver_rules))
        # Only show LEAF instances with uncov > 0
        leaf_uncov = [(p, c, t, w) for p, c, t, w, leaf in results if (t - c > 0) and leaf]
        leaf_uncov.sort(key=lambda x: -(x[2] - x[1]))
        
        # Also aggregate by generalized instance name
        by_type = defaultdict(lambda: {"count": 0, "cov": 0, "tot": 0})
        for p, c, t, w, leaf in results:
            if leaf and (t - c > 0):
                inst_name = p.split(".")[-1]
                gen_name = re.sub(r"\[\d+\]", "[*]", inst_name)
                d = by_type[gen_name]
                d["count"] += 1
                d["cov"] += c
                d["tot"] += t

        total_cov = sum(c for _, c, t, _, _ in results)
        total_tot = sum(t for _, c, t, _, _ in results)
        print(f"=== {label} (leaf instances with uncov toggle) ===")
        print(f"  Aggregate: {total_cov}/{total_tot}")
        print()
        print(f"  By type (leaf uncov):")
        sorted_types = sorted(by_type.items(), key=lambda x: -(x[1]["tot"] - x[1]["cov"]))
        for name, d in sorted_types:
            uncov = d["tot"] - d["cov"]
            print(f"    {name:40s} cnt={d['count']:4d}  {d['cov']:5d}/{d['tot']:5d}  uncov={uncov:5d}")
        print()
        print(f"  Top leaf instances:")
        for path, c, t, w in leaf_uncov[:15]:
            short = path.replace("top_nouvm.u_dut.", "")
            u = t - c
            pct = c / t * 100 if t > 0 else 0
            print(f"    {short:75s} {c:5d}/{t:5d} ({pct:5.1f}%) uncov={u:4d}  {w}")
        print()


if __name__ == "__main__":
    main()

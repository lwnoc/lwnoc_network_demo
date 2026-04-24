#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple


ROOT_LABELS = (
    "u_iniu",
    "u_tniu0",
    "u_tniu1",
    "u_tniu2",
)

THIRD_PARTY_PATH_MARKERS = (
    "/fcip/",
    "/lowpower/",
)

TARGET_METRICS = ("line", "condition", "toggle", "fsm", "branch")
WAIVABLE_METRICS = TARGET_METRICS + ("toggle_port",)


@dataclass
class MetricCount:
    covered: int = 0
    total: int = 0

    def add(self, other: "MetricCount") -> None:
        self.covered += other.covered
        self.total += other.total

    @property
    def percentage(self) -> Optional[float]:
        if self.total == 0:
            return None
        return 100.0 * self.covered / self.total


@dataclass
class Aggregate:
    line: MetricCount = field(default_factory=MetricCount)
    condition: MetricCount = field(default_factory=MetricCount)
    toggle: MetricCount = field(default_factory=MetricCount)
    fsm: MetricCount = field(default_factory=MetricCount)
    branch: MetricCount = field(default_factory=MetricCount)

    def add_metric(self, metric: str, count: MetricCount) -> None:
        getattr(self, metric).add(count)

    def merge(self, other: "Aggregate") -> None:
        for metric in TARGET_METRICS:
            self.add_metric(metric, getattr(other, metric))

    def to_dict(self) -> Dict[str, Dict[str, Optional[float]]]:
        out: Dict[str, Dict[str, Optional[float]]] = {}
        for metric in TARGET_METRICS:
            count = getattr(self, metric)
            out[metric] = {
                "covered": count.covered,
                "total": count.total,
                "percentage": count.percentage,
            }
        return out


@dataclass
class WaiverAdjustment:
    covered: int = 0
    total: int = 0


@dataclass
class WaiverRule:
    name: str
    instance_regex: str
    adjustments: Dict[str, WaiverAdjustment]
    reason: str = ""
    exclude_subtree: bool = False

    def matches(self, instance_path: str) -> bool:
        return re.search(self.instance_regex, instance_path) is not None


@dataclass
class ChildRef:
    page: str
    inst_id: str
    name: str


@dataclass
class InstanceNode:
    page: str
    inst_id: str
    full_path: str
    module_source: str
    instance_metrics: Dict[str, MetricCount]
    children: List[ChildRef]


def _load_waiver_rules(path: Optional[Path]) -> List[WaiverRule]:
    if path is None:
        return []

    raw = json.loads(path.read_text(encoding="utf-8"))
    rules: List[WaiverRule] = []
    for index, entry in enumerate(raw.get("rules", []), start=1):
        adjustments: Dict[str, WaiverAdjustment] = {}
        for metric, values in entry.get("adjustments", {}).items():
            if metric not in WAIVABLE_METRICS:
                raise ValueError(f"Unsupported waiver metric '{metric}' in rule #{index}")
            adjustments[metric] = WaiverAdjustment(
                covered=int(values.get("covered", 0)),
                total=int(values.get("total", 0)),
            )
        rules.append(
            WaiverRule(
                name=entry.get("name", f"rule_{index}"),
                instance_regex=entry["instance_regex"],
                adjustments=adjustments,
                reason=entry.get("reason", ""),
                exclude_subtree=bool(entry.get("exclude_subtree", False)),
            )
        )
    return rules


def _apply_adjustment(count: MetricCount, adjustment: WaiverAdjustment, metric: str, rule_name: str, instance_path: str) -> MetricCount:
    # Pure wrappers may have no data for a metric (total==0); skip adjustment silently.
    if count.total == 0 and adjustment.total > 0:
        return count
    covered = count.covered - adjustment.covered
    total = count.total - adjustment.total
    if covered < 0 or total < 0 or covered > total:
        import sys
        print(
            f"WARNING: stale waiver '{rule_name}' on '{instance_path}' metric '{metric}': "
            f"base=({count.covered},{count.total}) adj=({adjustment.covered},{adjustment.total}); clamping",
            file=sys.stderr,
        )
        # Clamp: keep covered ≤ total, both ≥ 0
        total = max(total, 0)
        covered = max(min(covered, total), 0)
    return MetricCount(covered=covered, total=total)


def _with_waivers(
    instance_path: str,
    instance_metrics: Dict[str, MetricCount],
    waiver_rules: List[WaiverRule],
) -> Tuple[Dict[str, MetricCount], List[Dict[str, object]]]:
    adjusted = {
        key: MetricCount(value.covered, value.total)
        for key, value in instance_metrics.items()
    }
    applied: List[Dict[str, object]] = []

    for rule in waiver_rules:
        if not rule.matches(instance_path):
            continue
        rule_metrics: Dict[str, Dict[str, int]] = {}
        for metric, adjustment in rule.adjustments.items():
            adjusted[metric] = _apply_adjustment(adjusted[metric], adjustment, metric, rule.name, instance_path)
            rule_metrics[metric] = {
                "covered": adjustment.covered,
                "total": adjustment.total,
            }
        applied.append(
            {
                "name": rule.name,
                "reason": rule.reason,
                "adjustments": rule_metrics,
            }
        )

    return adjusted, applied


def _read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="ignore")


def _extract_source_file(text: str) -> str:
    match = re.search(r'file:///([^"<]+)', text)
    if not match:
        return ""
    return "/" + match.group(1).lstrip("/")


def _resolve_start_instances(report_dir: Path) -> List[Tuple[str, str, str]]:
    hierarchy_pages = sorted(report_dir.glob("hierarchy*.html"))
    if not hierarchy_pages:
        raise ValueError(f"Could not find hierarchy HTML pages under {report_dir}")

    resolved: List[Tuple[str, str, str]] = []
    for label in ROOT_LABELS:
        pattern = re.compile(
            rf'<a href="([^"]+)#inst_tag_(\d+)"[^>]*>\s*{re.escape(label)}\s*</a>'
        )
        matched = False
        for page in hierarchy_pages:
            text = _read_text(page)
            match = pattern.search(text)
            if match:
                resolved.append((match.group(1), match.group(2), label))
                matched = True
                break
        if not matched:
            raise ValueError(f"Could not resolve root instance '{label}' from hierarchy HTML in {report_dir}")
    return resolved


def _extract_instance_section(text: str, inst_id: str) -> str:
    patterns = [
        re.compile(
            rf"<div name=['\"]inst_tag_{re.escape(inst_id)}['\"]>(.*?)</div>\s*</div>",
            re.S,
        ),
        re.compile(
            rf'<a name="inst_tag_{re.escape(inst_id)}"></a>(.*?)</div>\s*</div>',
            re.S,
        ),
    ]
    for pattern in patterns:
        match = pattern.search(text)
        if match:
            return match.group(1)
    raise ValueError(f"Could not find instance section for {inst_id}")


def _extract_metric_section(text: str, inst_id: str, suffix: str) -> Optional[str]:
    pattern = re.compile(
        rf'<a name="inst_tag_{re.escape(inst_id)}_{suffix}"></a>(.*?)(?:<hr>|</div>\s*</div>)',
        re.S,
    )
    match = pattern.search(text)
    if not match:
        return None
    return match.group(1)


def _extract_full_path(instance_section: str) -> str:
    match = re.search(r'Module Instance : <a [^>]+>([^<]+)</a>', instance_section)
    if not match:
        raise ValueError("Could not find full instance path")
    return match.group(1).strip()


def _extract_subtree_children(instance_section: str) -> List[ChildRef]:
    marker = '<span class=repname>Subtrees :</span>'
    start = instance_section.find(marker)
    if start == -1:
        return []
    table_start = instance_section.find('<table', start)
    table_end = instance_section.find('</table>', table_start)
    if table_start == -1 or table_end == -1:
        return []
    table = instance_section[table_start:table_end]
    children = []
    for page, inst_id, name in re.findall(
        r'<a href="([^"]+)#inst_tag_(\d+)" id="tag_urg_inst_\d+">([^<]+)</a>',
        table,
    ):
        children.append(ChildRef(page=page, inst_id=inst_id, name=name.strip()))
    return children


def _extract_line_count(section: Optional[str]) -> MetricCount:
    if not section:
        return MetricCount()
    match = re.search(r'<tr class="s\d+"><td class="lf">TOTAL</td><td></td><td>(\d+)</td><td>(\d+)</td>', section)
    if not match:
        return MetricCount()
    return MetricCount(covered=int(match.group(2)), total=int(match.group(1)))


def _extract_condition_count(section: Optional[str]) -> MetricCount:
    if not section:
        return MetricCount()
    match = re.search(r'<tr class="s\d+"><td class="lf">Conditions</td><td>(\d+)</td><td>(\d+)</td>', section)
    if not match:
        return MetricCount()
    return MetricCount(covered=int(match.group(2)), total=int(match.group(1)))


def _extract_toggle_count(section: Optional[str], port_only: bool) -> MetricCount:
    if not section:
        return MetricCount()
    label = "Port Bits" if port_only else "Total Bits"
    match = re.search(rf'<td>{re.escape(label)}</td>\s*<td class="rt">(\d+)</td>\s*<td class="rt">(\d+)</td>', section)
    if not match:
        return MetricCount()
    return MetricCount(covered=int(match.group(2)), total=int(match.group(1)))


def _extract_fsm_count(section: Optional[str]) -> MetricCount:
    if not section:
        return MetricCount()
    match = re.search(r'<td>Transitions</td>\s*<td class="rt">(\d+)</td>\s*<td class="rt">(\d+)</td>', section)
    if not match:
        return MetricCount()
    return MetricCount(covered=int(match.group(2)), total=int(match.group(1)))


def _extract_branch_count(section: Optional[str]) -> MetricCount:
    if not section:
        return MetricCount()
    match = re.search(r'<td>Branches</td>\s*<td></td>\s*<td class="rt">(\d+)</td>\s*<td class="rt">(\d+)</td>', section)
    if not match:
        return MetricCount()
    return MetricCount(covered=int(match.group(2)), total=int(match.group(1)))


class ReportParser:
    def __init__(
        self,
        report_dir: Path,
        third_party_markers: Iterable[str],
        third_party_instance_leaves: Iterable[str] = (),
    ) -> None:
        self.report_dir = report_dir
        self.third_party_markers = tuple(third_party_markers)
        self.third_party_instance_leaves = tuple(third_party_instance_leaves)
        self.cache: Dict[Tuple[str, str], InstanceNode] = {}

    def load_node(self, page: str, inst_id: str) -> InstanceNode:
        key = (page, inst_id)
        if key in self.cache:
            return self.cache[key]

        text = _read_text(self.report_dir / page)
        source_file = _extract_source_file(text)
        instance_section = _extract_instance_section(text, inst_id)
        full_path = _extract_full_path(instance_section)

        metrics = {
            "line": _extract_line_count(_extract_metric_section(text, inst_id, "Line")),
            "condition": _extract_condition_count(_extract_metric_section(text, inst_id, "Cond")),
            "toggle": _extract_toggle_count(_extract_metric_section(text, inst_id, "Toggle"), port_only=False),
            "toggle_port": _extract_toggle_count(_extract_metric_section(text, inst_id, "Toggle"), port_only=True),
            "fsm": _extract_fsm_count(_extract_metric_section(text, inst_id, "FSM")),
            "branch": _extract_branch_count(_extract_metric_section(text, inst_id, "Branch")),
        }
        children = _extract_subtree_children(instance_section)

        node = InstanceNode(
            page=page,
            inst_id=inst_id,
            full_path=full_path,
            module_source=source_file,
            instance_metrics=metrics,
            children=children,
        )
        self.cache[key] = node
        return node

    def is_third_party(self, node: InstanceNode) -> bool:
        if any(marker in node.module_source for marker in self.third_party_markers):
            return True
        if not node.module_source and self.third_party_instance_leaves:
            leaf = node.full_path.rsplit(".", 1)[-1]
            return leaf in self.third_party_instance_leaves
        return False


def _check_subtree_exclusion(
    instance_path: str,
    waiver_rules: List[WaiverRule],
) -> Optional[str]:
    """Return the waiver rule name if instance should be fully excluded, else None."""
    for rule in waiver_rules:
        if rule.exclude_subtree and rule.matches(instance_path):
            return rule.name
    return None


def aggregate_node(
    parser: ReportParser,
    page: str,
    inst_id: str,
    waiver_rules: List[WaiverRule],
    parent_is_third_party: bool = False,
) -> Tuple[Aggregate, Dict[str, object]]:
    node = parser.load_node(page, inst_id)
    aggregate = Aggregate()
    self_is_third_party = parser.is_third_party(node)
    top_of_third_party = self_is_third_party and not parent_is_third_party

    # Check if this entire subtree should be excluded by a waiver
    exclusion_rule = _check_subtree_exclusion(node.full_path, waiver_rules)
    if exclusion_rule is not None:
        detail = {
            "instance": node.full_path,
            "page": page,
            "inst_id": inst_id,
            "module_source": node.module_source,
            "third_party_top": top_of_third_party,
            "applied_waivers": [{"name": exclusion_rule, "type": "exclude_subtree"}],
            "aggregate": aggregate.to_dict(),
        }
        return aggregate, detail

    adjusted_metrics, applied_waivers = _with_waivers(node.full_path, node.instance_metrics, waiver_rules)

    if top_of_third_party:
        aggregate.add_metric("toggle", adjusted_metrics["toggle_port"])
    else:
        aggregate.add_metric("line", adjusted_metrics["line"])
        aggregate.add_metric("condition", adjusted_metrics["condition"])
        aggregate.add_metric("toggle", adjusted_metrics["toggle"])
        aggregate.add_metric("fsm", adjusted_metrics["fsm"])
        aggregate.add_metric("branch", adjusted_metrics["branch"])
        for child in node.children:
            child_agg, _ = aggregate_node(
                parser,
                child.page,
                child.inst_id,
                waiver_rules,
                parent_is_third_party=self_is_third_party,
            )
            aggregate.merge(child_agg)

    detail = {
        "instance": node.full_path,
        "page": page,
        "inst_id": inst_id,
        "module_source": node.module_source,
        "third_party_top": top_of_third_party,
        "applied_waivers": applied_waivers,
        "aggregate": aggregate.to_dict(),
    }
    return aggregate, detail


def format_percent(value: Optional[float]) -> str:
    if value is None:
        return "N/A"
    return f"{value:.2f}"


def main() -> int:
    argp = argparse.ArgumentParser(description="Extract scope-filtered coverage from urg HTML output.")
    argp.add_argument("report_dir", type=Path)
    argp.add_argument("--json", action="store_true", dest="as_json")
    argp.add_argument(
        "--waiver-file",
        type=Path,
        help="JSON file containing metric-count waiver rules keyed by instance path regex.",
    )
    argp.add_argument(
        "--third-party-marker",
        action="append",
        default=list(THIRD_PARTY_PATH_MARKERS),
        help="Path substring marking a third-party IP source file. Can be repeated.",
    )
    argp.add_argument(
        "--third-party-instance-leaf",
        action="append",
        default=[],
        help="Instance leaf name treated as third-party when source path is empty (VCS parameterised modules). Can be repeated.",
    )
    args = argp.parse_args()

    parser = ReportParser(args.report_dir, args.third_party_marker, args.third_party_instance_leaf)
    start_instances = _resolve_start_instances(args.report_dir)
    waiver_rules = _load_waiver_rules(args.waiver_file)
    total = Aggregate()
    details = []
    for page, inst_id, label in start_instances:
        agg, detail = aggregate_node(parser, page, inst_id, waiver_rules)
        detail["label"] = label
        details.append(detail)
        total.merge(agg)

    result = {
        "report_dir": str(args.report_dir),
        "policy": {
            "roots": [label for _, _, label in start_instances],
            "metrics": list(TARGET_METRICS),
            "third_party_markers": list(args.third_party_marker),
            "third_party_instance_leaves": args.third_party_instance_leaf,
            "third_party_rule": "Exclude all third-party internal coverage; include only top-instance port toggle.",
            "waiver_file": str(args.waiver_file) if args.waiver_file else None,
        },
        "per_root": details,
        "total": total.to_dict(),
    }

    if args.as_json:
        print(json.dumps(result, indent=2, sort_keys=True))
        return 0

    print("Policy-filtered coverage summary")
    print(f"Report dir: {args.report_dir}")
    if args.waiver_file:
        print(f"Waiver file: {args.waiver_file}")
    print("Roots: " + ", ".join(label for _, _, label in start_instances))
    print("")
    for detail in details:
        print(f"[{detail['label']}] {detail['instance']}")
        if detail["applied_waivers"]:
            for waiver in detail["applied_waivers"]:
                print(f"  waiver    {waiver['name']} ({waiver['reason']})")
        for metric in TARGET_METRICS:
            metric_data = detail["aggregate"][metric]
            print(
                f"  {metric:9s} {metric_data['covered']:6d}/{metric_data['total']:<6d} {format_percent(metric_data['percentage'])}%"
            )
        print("")

    print("[total]")
    for metric in TARGET_METRICS:
        metric_data = result["total"][metric]
        print(
            f"  {metric:9s} {metric_data['covered']:6d}/{metric_data['total']:<6d} {format_percent(metric_data['percentage'])}%"
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Any, cast


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
REPO_ROOT = DEMO_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))
if str(DEMO_DIR) not in sys.path:
    sys.path.insert(0, str(DEMO_DIR))

import StsTemplate  # noqa: E402
from StsSocTopo import StsSocLogicTopo  # noqa: E402


WINDOW_SIZE = 0x1000
SEL_REGISTER_ALIAS = "sel(debug_data_gate)"
REG_BANK_GEN = StsTemplate.STS_NOC_ROOT / "rtl" / "reg" / "build" / "reg_bank_table_rf_gen.py"
STS_TNIU_APB = StsTemplate.STS_TNIU_ROOT / "rtl" / "tniu" / "sts_tniu_apb.sv"
TOPOLOGY_JSON = DEMO_DIR / "soc_sts_logic_topology.json"
BUILD_LOGIC_DIR = DEMO_DIR / "build_logic"
DEFAULT_REPORT_DIR = DEMO_DIR / "build" / "postgen_reports"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Report STS post-generation metadata without changing the gen flow."
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Emit machine-readable JSON instead of the default text report.",
    )
    parser.add_argument(
        "--markdown",
        action="store_true",
        help="Emit review-friendly Markdown to stdout instead of the default text report.",
    )
    parser.add_argument(
        "--emit-both",
        action="store_true",
        help="Write both JSON and Markdown report files under --output-dir and print the paths.",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=DEFAULT_REPORT_DIR,
        help=f"Directory used by --emit-both (default: {DEFAULT_REPORT_DIR}).",
    )
    return parser.parse_args()


def ensure_paths() -> None:
    required_paths = [TOPOLOGY_JSON, BUILD_LOGIC_DIR, REG_BANK_GEN, STS_TNIU_APB]
    missing = [str(path) for path in required_paths if not path.exists()]
    if missing:
        raise SystemExit(
            "Missing required generated/source inputs for STS post-processing:\n"
            + "\n".join(f"- {path}" for path in missing)
        )


def parse_regbank_registers() -> list[dict[str, Any]]:
    text = REG_BANK_GEN.read_text(encoding="utf-8", errors="replace")
    registers: list[dict[str, Any]] = []
    current_name: str | None = None
    for line in text.splitlines():
        match_name = re.search(r"Register\(name='([^']+)'", line)
        if match_name:
            current_name = match_name.group(1)
            continue

        match_offset = re.search(r"regBank\.add\(reg_\d+,offset=(0x[0-9A-Fa-f]+)\)", line)
        if match_offset and current_name is not None:
            registers.append(
                {
                    "register_name": current_name,
                    "offset": int(match_offset.group(1), 16),
                    "offset_hex": match_offset.group(1).lower(),
                    "semantic_alias": SEL_REGISTER_ALIAS if current_name == "debug_data_gate" else None,
                }
            )
            current_name = None
    return registers


def classify_window(tniu_idx: int, tgtid: int) -> tuple[str, int | None]:
    local_base = tniu_idx << 4
    if tgtid == local_base + 0x0:
        return "local_regbank", None
    if tgtid == local_base + 0x1:
        return "local_rsc", None
    sys_base = 0x40 + local_base
    if sys_base <= tgtid <= sys_base + 9:
        return "sys_apb_slot", tgtid - sys_base
    return "unknown", None


def internal_address_rules(base: int) -> dict[str, str]:
    return {
        "external_axi_window": f"0x{base:05X}-0x{base + WINDOW_SIZE - 1:05X}",
        "internal_axi_rule": f"internal_addr = axi_addr - 0x{base:05X}",
        "local_apb_rule": "paddr = internal_addr[11:0]",
    }


def build_family_windows(
    family_name: str,
    tniu_idx: int,
    register_catalog: list[dict[str, Any]],
) -> list[dict[str, Any]]:
    windows: list[dict[str, Any]] = []
    bases = StsTemplate._tniu_window_bases(tniu_idx)
    tgtids = StsTemplate._tniu_target_ids(tniu_idx)
    reg_select = next(
        (entry for entry in register_catalog if entry["register_name"] == "debug_data_gate"),
        None,
    )

    for base, tgtid in zip(bases, tgtids):
        window_type, sys_apb_slot = classify_window(tniu_idx, tgtid)
        entry: dict[str, Any] = {
            "family_name": family_name,
            "tniu_index": tniu_idx,
            "window_base": base,
            "window_base_hex": f"0x{base:05X}",
            "window_end_hex": f"0x{base + WINDOW_SIZE - 1:05X}",
            "window_mask": 0xFFFF_F000,
            "window_mask_hex": "0xfffff000",
            "tgtid": tgtid,
            "tgtid_hex": f"0x{tgtid:02X}",
            "window_type": window_type,
            "sys_apb_slot": sys_apb_slot,
            **internal_address_rules(base),
        }
        if window_type == "local_regbank" and reg_select is not None:
            offset = int(reg_select["offset"])
            entry.update(
                {
                    "register_name": reg_select["register_name"],
                    "register_semantic_alias": reg_select["semantic_alias"],
                    "register_offset": offset,
                    "register_offset_hex": f"0x{offset:04X}",
                    "selector_axi_address": base + offset,
                    "selector_axi_address_hex": f"0x{base + offset:05X}",
                    "final_apb_paddr_hex": f"0x{offset:03X}",
                }
            )
        elif window_type == "local_rsc":
            entry.update({"final_apb_paddr_hex": "0x000"})
        else:
            entry.update({"final_apb_paddr_hex": "window_local_offset"})
        windows.append(entry)

    return windows


def build_partition_map(logic: StsSocLogicTopo) -> dict[str, str]:
    partition_map: dict[str, str] = {"aon_ss_iniu": "dn"}
    for name in logic.harden_dn_leaf_names:
        partition_map[name] = "dn"
    for name in logic.harden_up_leaf_names:
        partition_map[name] = "up"
    return partition_map


def build_signal_hierarchies(logic: StsSocLogicTopo) -> dict[str, list[dict[str, str]]]:
    partition_map = build_partition_map(logic)
    debug_outputs = [
        {
            "node": "aon_ss_iniu",
            "role": "iniu",
            "signal": "dbg_data_out",
            "hier": "sts_soc_top_wrap.u_dn_harden.aon_ss_iniu_top.dbg_data_out",
        }
    ]
    debug_inputs: list[dict[str, str]] = []
    timestamps = [
        {
            "node": "aon_ss_iniu",
            "role": "iniu",
            "signal": "dbg_timestamp_out",
            "hier": "sts_soc_top_wrap.u_dn_harden.aon_ss_iniu_top.dbg_timestamp_out",
        }
    ]

    for leaf_name in sorted(logic.tniu_nodes.keys()):
        partition = partition_map[leaf_name]
        wrapper = "u_dn_harden" if partition == "dn" else "u_up_harden"
        top_name = f"{leaf_name}_top"
        debug_inputs.append(
            {
                "node": f"{leaf_name}_tniu",
                "role": "tniu",
                "signal": "dbg_data_in",
                "hier": f"sts_soc_top_wrap.{wrapper}.{top_name}.dbg_data_in",
            }
        )
        timestamps.append(
            {
                "node": f"{leaf_name}_tniu",
                "role": "tniu",
                "signal": "dbg_timestamp_in",
                "hier": f"sts_soc_top_wrap.{wrapper}.{top_name}.dbg_timestamp_in",
            }
        )

    return {
        "debug_data_outputs": debug_outputs,
        "debug_data_inputs": debug_inputs,
        "timestamp_ports": timestamps,
    }


def analyze_shared_family_source() -> dict[str, Any]:
    return {
        "shared_family_name": "dspss_family",
        "shared_leaf_nodes": [
            "dspss0",
            "dspss1",
            "dspss2",
            "dspss3",
            "dspss4",
            "dspss5",
        ],
        "status": "current_template_level_sharing",
        "conclusion": (
            "The shared tgtid family is current source behavior, not a report-side merge artifact. "
            "All dspss leaves are instantiated from the same sys/top TemplateIPConfig pair, and the top-side config "
            "uses a single _tniu_params(2) override set."
        ),
        "evidence": [
            {
                "file": "lwnoc_sts_noc_demo/StsTemplate.py",
                "detail": "Only one dspss_tniu_sys_config is declared and reused for all dspss leaf nodes.",
            },
            {
                "file": "lwnoc_sts_noc_demo/StsTemplate.py",
                "detail": "Only one dspss_tniu_top_side_config is declared, with param_overrides = _tniu_params(2).",
            },
            {
                "file": "lwnoc_sts_noc_demo/StsSocTopo.py",
                "detail": "Every non-vpu/non-camera leaf falls into the same else branch and binds to dspss_tniu_sys_config + dspss_tniu_top_side_config.",
            },
            {
                "file": "lwnoc_sts_noc_demo/StsNode.py",
                "detail": "StsTniuWrapNode passes cfg.param_overrides through to TemplateComponent without per-leaf dspss specialization.",
            },
        ],
        "classification": {
            "design_intent_vs_template_granularity": "template_granularity_currently_shared",
            "reporter_confidence": "high",
            "why": (
                "There is no leaf-specific parameter path for dspss0~5 in Template.py, Topo.py, or Node.py. "
                "If unique tgtid families were intended, the source would need distinct TemplateIPConfig instances or per-leaf param overrides."
            ),
        },
        "follow_up_if_unique_families_are_needed": [
            "Define per-leaf dspss TemplateIPConfig instances or a data-driven config table in StsTemplate.py.",
            "Bind each dspss leaf to its own sys/top config in StsSocTopo.py instead of the shared else branch.",
            "Keep report_sts_postgen.py source-owned: it should only observe the per-leaf metadata after template/topology refinement.",
        ],
    }


def family_metadata(logic: StsSocLogicTopo, register_catalog: list[dict[str, Any]]) -> list[dict[str, Any]]:
    partition_map = build_partition_map(logic)
    families = [
        {
            "family_name": "vpu_ss",
            "leaf_nodes": ["vpu_ss"],
            "tniu_index": 0,
            "partition": partition_map["vpu_ss"],
            "shared_tgtid_family": False,
            "path_segments": ["aon_ss_iniu", "dec0", "vpu_ss_tniu"],
            "artifact_bindings": {
                "sys": {
                    "config_name": "vpu_ss_tniu_sys",
                    "build_dir": str(BUILD_LOGIC_DIR / "vpu_ss_tniu_sys"),
                    "env_var": "VPU_SS_TNIU_SYS_OUT_DIR",
                },
                "top_side": {
                    "config_name": "vpu_ss_tniu_top_side",
                    "build_dir": str(BUILD_LOGIC_DIR / "vpu_ss_tniu_top_side"),
                    "env_var": "VPU_SS_TNIU_TOP_SIDE_OUT_DIR",
                },
            },
        },
        {
            "family_name": "camera_ss",
            "leaf_nodes": ["camera_ss"],
            "tniu_index": 1,
            "partition": partition_map["camera_ss"],
            "shared_tgtid_family": False,
            "path_segments": ["aon_ss_iniu", "dec0", "dec1", "camera_ss_tniu"],
            "artifact_bindings": {
                "sys": {
                    "config_name": "camera_ss_tniu_sys",
                    "build_dir": str(BUILD_LOGIC_DIR / "camera_ss_tniu_sys"),
                    "env_var": "CAMERA_SS_TNIU_SYS_OUT_DIR",
                },
                "top_side": {
                    "config_name": "camera_ss_tniu_top_side",
                    "build_dir": str(BUILD_LOGIC_DIR / "camera_ss_tniu_top_side"),
                    "env_var": "CAMERA_SS_TNIU_TOP_SIDE_OUT_DIR",
                },
            },
        },
        {
            "family_name": "dspss_family",
            "leaf_nodes": [
                "dspss0",
                "dspss1",
                "dspss2",
                "dspss3",
                "dspss4",
                "dspss5",
            ],
            "tniu_index": 2,
            "partition": "up",
            "shared_tgtid_family": True,
            "path_segments": [
                "aon_ss_iniu",
                "dec0",
                "dec1",
                "harden_dn_async_bridge_slv",
                "harden_up_async_bridge_mst",
                "dec2",
            ],
            "note": "All dspss leaf instances currently share the same TNIU config/target-id family metadata.",
            "artifact_bindings": {
                "sys": {
                    "config_name": "dspss_tniu_sys",
                    "build_dir": str(BUILD_LOGIC_DIR / "dspss_tniu_sys"),
                    "env_var": "DSPSS_TNIU_SYS_OUT_DIR",
                },
                "top_side": {
                    "config_name": "dspss_tniu_top_side",
                    "build_dir": str(BUILD_LOGIC_DIR / "dspss_tniu_top_side"),
                    "env_var": "DSPSS_TNIU_TOP_SIDE_OUT_DIR",
                },
            },
        },
    ]

    for family in families:
        family["windows"] = build_family_windows(
            family["family_name"],
            int(family["tniu_index"]),
            register_catalog,
        )
    return families


def build_address_map(families: list[dict[str, Any]]) -> list[dict[str, Any]]:
    entries: list[dict[str, Any]] = []
    for family in families:
        entries.extend(cast(list[dict[str, Any]], family["windows"]))
    return sorted(entries, key=lambda item: int(cast(int, item["window_base"])))


def build_tree(families: list[dict[str, Any]], register_catalog: list[dict[str, Any]]) -> dict[str, Any]:
    all_windows = build_address_map(families)
    root: dict[str, Any] = {
        "node": "aon_ss_iniu",
        "role": "iniu",
        "tgtid_scope": sorted(str(entry["tgtid_hex"]) for entry in all_windows),
        "external_axi_windows": [
            {
                "window_base_hex": entry["window_base_hex"],
                "window_end_hex": entry["window_end_hex"],
                "tgtid_hex": entry["tgtid_hex"],
            }
            for entry in all_windows
        ],
        "internal_axi_rule": "internal_addr = axi_addr - matched_window_base",
        "final_apb_rule": "For local targets, paddr = internal_addr[11:0]",
        "children": [],
    }

    reg_select = next(
        (entry for entry in register_catalog if entry["register_name"] == "debug_data_gate"),
        None,
    )

    family_by_leaf: dict[str, dict[str, Any]] = {}
    for family in families:
        for leaf_name in cast(list[str], family["leaf_nodes"]):
            family_by_leaf[leaf_name] = family

    def leaf_node(leaf_name: str) -> dict[str, Any]:
        family = family_by_leaf[leaf_name]
        partition = family["partition"]
        wrapper = "u_dn_harden" if partition == "dn" else "u_up_harden"
        windows = cast(list[dict[str, Any]], family["windows"])
        selector_axi = [
            str(entry["selector_axi_address_hex"])
            for entry in windows
            if entry["window_type"] == "local_regbank" and "selector_axi_address_hex" in entry
        ]
        node: dict[str, Any] = {
            "node": f"{leaf_name}_tniu",
            "role": "tniu",
            "partition": partition,
            "wrapper_hier": f"sts_soc_top_wrap.{wrapper}.{leaf_name}_top",
            "tgtids": [entry["tgtid_hex"] for entry in windows],
            "external_axi_windows": [
                {
                    "window_base_hex": entry["window_base_hex"],
                    "window_end_hex": entry["window_end_hex"],
                    "window_type": entry["window_type"],
                    "tgtid_hex": entry["tgtid_hex"],
                }
                for entry in windows
            ],
            "internal_axi_rule": "internal_addr = axi_addr - matched_window_base",
            "final_apb_rule": "paddr = internal_addr[11:0]",
            "selector_register": reg_select["register_name"] if reg_select is not None else None,
            "selector_register_alias": reg_select["semantic_alias"] if reg_select is not None else None,
            "selector_axi_addresses": selector_axi,
            "path_segments": [],
            "shared_tgtid_family": family["shared_tgtid_family"],
            "children": [],
        }
        if family.get("note"):
            node["note"] = family["note"]
        return node

    def aggregate_children(node: dict[str, Any]) -> None:
        children = cast(list[dict[str, Any]], node.get("children", []))
        if not children:
            return
        for child in children:
            aggregate_children(child)

        tgtids: list[str] = []
        windows: list[dict[str, Any]] = []
        for child in children:
            tgtids.extend(str(value) for value in cast(list[Any], child.get("tgtids", [])))
            windows.extend(cast(list[dict[str, Any]], child.get("external_axi_windows", [])))

        if tgtids:
            node["tgtids"] = sorted(set(tgtids))
        if windows:
            dedup = []
            seen = set()
            for item in windows:
                key = (item["window_base_hex"], item["tgtid_hex"], item["window_type"])
                if key in seen:
                    continue
                seen.add(key)
                dedup.append(item)
            node["external_axi_windows"] = sorted(dedup, key=lambda item: int(item["window_base_hex"], 16))
        node.setdefault("internal_axi_rule", "internal_addr = axi_addr - matched_window_base")
        node.setdefault("final_apb_rule", "For local targets, paddr = internal_addr[11:0]")

    dec2_ext = {
        "node": "dec2_ext",
        "role": "decoder",
        "children": [leaf_node("dspss3"), leaf_node("dspss4"), leaf_node("dspss5")],
    }
    dec2 = {
        "node": "dec2",
        "role": "decoder",
        "children": [leaf_node("dspss0"), leaf_node("dspss1"), leaf_node("dspss2"), dec2_ext],
    }
    bridge_mst = {
        "node": "harden_up_async_bridge_mst",
        "role": "bridge",
        "children": [dec2],
    }
    bridge_slv = {
        "node": "harden_dn_async_bridge_slv",
        "role": "bridge",
        "children": [bridge_mst],
    }
    dec1 = {
        "node": "dec1",
        "role": "decoder",
        "children": [leaf_node("camera_ss"), bridge_slv],
    }
    dec0 = {
        "node": "dec0",
        "role": "decoder",
        "children": [leaf_node("vpu_ss"), dec1],
    }
    root["children"] = [dec0]

    def annotate_paths(node: dict[str, Any], prefix: list[str]) -> None:
        current = prefix + [node["node"]]
        if node.get("role") == "tniu":
            node["path_segments"] = current
        for child in cast(list[dict[str, Any]], node.get("children", [])):
            annotate_paths(child, current)

    annotate_paths(root, [])
    aggregate_children(root)
    return root


def leaf_attach_metadata(leaf_name: str) -> dict[str, Any]:
    slot_map = {
        "vpu_ss": {"parent_decoder": "dec0", "slot": 0},
        "camera_ss": {"parent_decoder": "dec1", "slot": 0},
        "dspss0": {"parent_decoder": "dec2", "slot": 0},
        "dspss1": {"parent_decoder": "dec2", "slot": 1},
        "dspss2": {"parent_decoder": "dec2", "slot": 2},
        "dspss3": {"parent_decoder": "dec2_ext", "slot": 0},
        "dspss4": {"parent_decoder": "dec2_ext", "slot": 1},
        "dspss5": {"parent_decoder": "dec2_ext", "slot": 2},
    }
    return slot_map[leaf_name]


def iter_leaf_nodes(node: dict[str, Any]) -> list[dict[str, Any]]:
    leaves: list[dict[str, Any]] = []
    if node.get("role") == "tniu":
        leaves.append(node)
    for child in cast(list[dict[str, Any]], node.get("children", [])):
        leaves.extend(iter_leaf_nodes(child))
    return leaves


def build_leaf_aliases(tree: dict[str, Any], families: list[dict[str, Any]]) -> dict[str, Any]:
    family_by_leaf: dict[str, dict[str, Any]] = {}
    for family in families:
        for leaf_name in cast(list[str], family["leaf_nodes"]):
            family_by_leaf[leaf_name] = family

    entries: list[dict[str, Any]] = []
    for node in iter_leaf_nodes(tree):
        logical_node = str(node["node"])
        leaf_name = logical_node.removesuffix("_tniu")
        family = family_by_leaf[leaf_name]
        attach = leaf_attach_metadata(leaf_name)
        sibling_leafs = [name for name in cast(list[str], family["leaf_nodes"]) if name != leaf_name]
        entries.append(
            {
                "leaf_name": leaf_name,
                "logical_node": logical_node,
                "family_name": family["family_name"],
                "shared_tgtid_family": bool(family["shared_tgtid_family"]),
                "shared_with_leafs": sibling_leafs,
                "route_path": cast(list[str], node.get("path_segments", [])),
                "attach_point": attach,
                "wrapper_hier": node.get("wrapper_hier"),
                "selector_axi_addresses": cast(list[Any], node.get("selector_axi_addresses", [])),
                "tgtids": cast(list[Any], node.get("tgtids", [])),
                "shared_artifacts": cast(dict[str, Any], family["artifact_bindings"]),
                "note": node.get("note"),
            }
        )

    shared_groups = []
    for family in families:
        if not family["shared_tgtid_family"]:
            continue
        shared_groups.append(
            {
                "family_name": family["family_name"],
                "leaf_nodes": cast(list[str], family["leaf_nodes"]),
                "shared_artifacts": cast(dict[str, Any], family["artifact_bindings"]),
                "note": family.get("note"),
            }
        )

    return {
        "purpose": "Map logical leaf names onto shared physical artifacts without changing STS template granularity.",
        "entries": entries,
        "shared_artifact_groups": shared_groups,
    }


def format_signal_section(title: str, rows: list[dict[str, str]]) -> str:
    lines = [title]
    for row in rows:
        lines.append(f"- {row['node']}: {row['hier']}")
    return "\n".join(lines)


def format_address_map(entries: list[dict[str, Any]]) -> str:
    lines = ["address -> tgtid map"]
    for entry in entries:
        suffix = ""
        if entry["window_type"] == "sys_apb_slot":
            suffix = f", sys_apb_slot={entry['sys_apb_slot']}"
        if entry["window_type"] == "local_regbank":
            suffix += f", sel_axi={entry['selector_axi_address_hex']}"
        lines.append(
            "- "
            f"{entry['window_base_hex']}-{entry['window_end_hex']} -> {entry['tgtid_hex']} "
            f"({entry['family_name']}, {entry['window_type']}{suffix})"
        )
    return "\n".join(lines)


def format_leaf_aliases_text(leaf_aliases: dict[str, Any]) -> str:
    lines = ["leaf -> shared artifact mapping"]
    for entry in cast(list[dict[str, Any]], leaf_aliases["entries"]):
        sys_art = cast(dict[str, str], cast(dict[str, Any], entry["shared_artifacts"])["sys"])
        top_art = cast(dict[str, str], cast(dict[str, Any], entry["shared_artifacts"])["top_side"])
        attach = cast(dict[str, Any], entry["attach_point"])
        lines.append(
            "- "
            f"{entry['leaf_name']} -> sys={sys_art['config_name']} ({sys_art['build_dir']}), "
            f"top={top_art['config_name']} ({top_art['build_dir']}), "
            f"attach={attach['parent_decoder']}.slv{attach['slot']}"
        )
    return "\n".join(lines)


def append_tree_lines(lines: list[str], node: dict[str, Any], depth: int = 0) -> None:
    indent = "  " * depth
    role = node.get("role", "node")
    line = f"{indent}- {node['node'] if 'node' in node else node['family_name']} [{role}]"
    lines.append(line)

    tgtids = cast(list[Any], node.get("tgtids") or node.get("tgtid_scope") or [])
    if tgtids:
        lines.append(f"{indent}  tgtids: {', '.join(str(value) for value in tgtids)}")

    windows = cast(list[dict[str, Any]], node.get("external_axi_windows", []))
    if windows:
        preview = ", ".join(
            f"{item['window_base_hex']}->{item['tgtid_hex']}" for item in windows[:4]
        )
        if len(windows) > 4:
            preview += ", ..."
        lines.append(f"{indent}  ext_axi: {preview}")

    if node.get("internal_axi_rule"):
        lines.append(f"{indent}  internal_axi: {node['internal_axi_rule']}")
    if node.get("final_apb_rule"):
        lines.append(f"{indent}  final_apb: {node['final_apb_rule']}")
    selector_axi = cast(list[Any], node.get("selector_axi_addresses", []))
    if selector_axi:
        lines.append(f"{indent}  sel_axi: {', '.join(str(value) for value in selector_axi)}")
    note = node.get("note")
    if note:
        lines.append(f"{indent}  note: {note}")

    for child in cast(list[dict[str, Any]], node.get("children", [])):
        append_tree_lines(lines, child, depth + 1)


def format_tree(tree: dict[str, Any]) -> str:
    lines = ["tgtid attributed tree"]
    append_tree_lines(lines, tree)
    return "\n".join(lines)


def build_report() -> dict[str, Any]:
    ensure_paths()
    logic = StsSocLogicTopo()
    register_catalog = parse_regbank_registers()
    signal_hier = build_signal_hierarchies(logic)
    families = family_metadata(logic, register_catalog)
    address_map = build_address_map(families)
    tree = build_tree(families, register_catalog)
    leaf_aliases = build_leaf_aliases(tree, families)
    return {
        "inputs": {
            "build_logic_dir": str(BUILD_LOGIC_DIR),
            "topology_json": str(TOPOLOGY_JSON),
            "regbank_generator": str(REG_BANK_GEN),
            "tniu_apb_rtl": str(STS_TNIU_APB),
        },
        "shared_family_root_cause": analyze_shared_family_source(),
        "family_metadata": families,
        "leaf_aliases": leaf_aliases,
        "debug_timestamp_hier": signal_hier,
        "register_catalog": register_catalog,
        "address_to_tgtid_map": address_map,
        "tgtid_attributed_tree": tree,
    }


def emit_text(report: dict[str, Any]) -> str:
    parts = [
        format_signal_section(
            "debug data outputs",
            cast(dict[str, list[dict[str, str]]], report["debug_timestamp_hier"])["debug_data_outputs"],
        ),
        "",
        format_signal_section(
            "debug data inputs",
            cast(dict[str, list[dict[str, str]]], report["debug_timestamp_hier"])["debug_data_inputs"],
        ),
        "",
        format_signal_section(
            "timestamp ports",
            cast(dict[str, list[dict[str, str]]], report["debug_timestamp_hier"])["timestamp_ports"],
        ),
        "",
        format_address_map(cast(list[dict[str, Any]], report["address_to_tgtid_map"])),
        "",
        format_leaf_aliases_text(cast(dict[str, Any], report["leaf_aliases"])),
        "",
        format_tree(cast(dict[str, Any], report["tgtid_attributed_tree"])),
    ]
    return "\n".join(parts)


def format_markdown_signal_section(title: str, rows: list[dict[str, str]]) -> str:
    lines = [f"## {title}", "", "| Node | Role | Signal | Hier |", "| --- | --- | --- | --- |"]
    for row in rows:
        lines.append(f"| {row['node']} | {row['role']} | {row['signal']} | `{row['hier']}` |")
    return "\n".join(lines)


def format_markdown_root_cause(root_cause: dict[str, Any]) -> str:
    evidence = cast(list[dict[str, str]], root_cause["evidence"])
    follow_up = cast(list[str], root_cause["follow_up_if_unique_families_are_needed"])
    classification = cast(dict[str, str], root_cause["classification"])
    lines = [
        "## Shared DSPSS Family Root Cause",
        "",
        f"- Status: `{root_cause['status']}`",
        f"- Conclusion: {root_cause['conclusion']}",
        f"- Classification: `{classification['design_intent_vs_template_granularity']}`",
        f"- Confidence: `{classification['reporter_confidence']}`",
        f"- Why: {classification['why']}",
        "",
        "### Source Evidence",
    ]
    for item in evidence:
        lines.append(f"- `{item['file']}`: {item['detail']}")
    lines.extend(["", "### If Unique Families Are Needed"])
    for item in follow_up:
        lines.append(f"- {item}")
    return "\n".join(lines)


def format_markdown_address_map(entries: list[dict[str, Any]]) -> str:
    lines = [
        "## Address To Tgtid Map",
        "",
        "| Window | Tgtid | Family | Type | Extra |",
        "| --- | --- | --- | --- | --- |",
    ]
    for entry in entries:
        extras: list[str] = []
        if entry["window_type"] == "sys_apb_slot":
            extras.append(f"sys_apb_slot={entry['sys_apb_slot']}")
        if entry["window_type"] == "local_regbank":
            extras.append(f"sel_axi={entry['selector_axi_address_hex']}")
        lines.append(
            "| "
            f"{entry['window_base_hex']}-{entry['window_end_hex']} | {entry['tgtid_hex']} | {entry['family_name']} | {entry['window_type']} | {'; '.join(extras) if extras else '-'} |"
        )
    return "\n".join(lines)


def format_markdown_leaf_aliases(leaf_aliases: dict[str, Any]) -> str:
    entries = cast(list[dict[str, Any]], leaf_aliases["entries"])
    groups = cast(list[dict[str, Any]], leaf_aliases["shared_artifact_groups"])
    lines = [
        "## Leaf To Shared Artifact Mapping",
        "",
        leaf_aliases["purpose"],
        "",
        "| Leaf | Family | Route Path | Attach Point | Shared Sys Artifact | Shared Top Artifact | Sel AXI | Shared With |",
        "| --- | --- | --- | --- | --- | --- | --- | --- |",
    ]
    for entry in entries:
        shared_artifacts = cast(dict[str, Any], entry["shared_artifacts"])
        sys_art = cast(dict[str, str], shared_artifacts["sys"])
        top_art = cast(dict[str, str], shared_artifacts["top_side"])
        attach = cast(dict[str, Any], entry["attach_point"])
        route_path = " -> ".join(cast(list[str], entry["route_path"]))
        selector_axi = ", ".join(str(value) for value in cast(list[Any], entry["selector_axi_addresses"])) or "-"
        shared_with = ", ".join(cast(list[str], entry["shared_with_leafs"])) or "-"
        lines.append(
            "| "
            f"{entry['leaf_name']} | {entry['family_name']} | {route_path} | {attach['parent_decoder']}.slv{attach['slot']} | "
            f"{sys_art['config_name']} (`{sys_art['build_dir']}`) | {top_art['config_name']} (`{top_art['build_dir']}`) | {selector_axi} | {shared_with} |"
        )

    if groups:
        lines.extend(["", "### Shared Artifact Groups"])
        for group in groups:
            shared_artifacts = cast(dict[str, Any], group["shared_artifacts"])
            sys_art = cast(dict[str, str], shared_artifacts["sys"])
            top_art = cast(dict[str, str], shared_artifacts["top_side"])
            lines.append(
                "- "
                f"{group['family_name']}: leafs={', '.join(cast(list[str], group['leaf_nodes']))}; "
                f"sys={sys_art['config_name']} ({sys_art['build_dir']}); "
                f"top={top_art['config_name']} ({top_art['build_dir']})"
            )
            if group.get("note"):
                lines.append(f"  note: {group['note']}")

    return "\n".join(lines)


def append_markdown_tree(lines: list[str], node: dict[str, Any], depth: int = 0) -> None:
    indent = "  " * depth
    role = node.get("role", "node")
    label = str(node.get("node", node.get("family_name", "unknown")))
    lines.append(f"{indent}- **{label}** [{role}]")

    tgtids = cast(list[Any], node.get("tgtids") or node.get("tgtid_scope") or [])
    if tgtids:
        lines.append(f"{indent}  - tgtids: {', '.join(str(value) for value in tgtids)}")

    windows = cast(list[dict[str, Any]], node.get("external_axi_windows", []))
    if windows:
        preview = ", ".join(f"{item['window_base_hex']}->{item['tgtid_hex']}" for item in windows[:4])
        if len(windows) > 4:
            preview += ", ..."
        lines.append(f"{indent}  - ext_axi: {preview}")

    if node.get("internal_axi_rule"):
        lines.append(f"{indent}  - internal_axi: {node['internal_axi_rule']}")
    if node.get("final_apb_rule"):
        lines.append(f"{indent}  - final_apb: {node['final_apb_rule']}")

    selector_axi = cast(list[Any], node.get("selector_axi_addresses", []))
    if selector_axi:
        lines.append(f"{indent}  - sel_axi: {', '.join(str(value) for value in selector_axi)}")

    note = node.get("note")
    if note:
        lines.append(f"{indent}  - note: {note}")

    for child in cast(list[dict[str, Any]], node.get("children", [])):
        append_markdown_tree(lines, child, depth + 1)


def format_markdown_tree(tree: dict[str, Any]) -> str:
    lines = ["## Tgtid Attributed Tree", ""]
    append_markdown_tree(lines, tree)
    return "\n".join(lines)


def emit_markdown(report: dict[str, Any]) -> str:
    signal_hier = cast(dict[str, list[dict[str, str]]], report["debug_timestamp_hier"])
    root_cause = cast(dict[str, Any], report["shared_family_root_cause"])
    parts = [
        "# STS Post-Generation Review Report",
        "",
        "This report is generated by `tools/report_sts_postgen.py` without modifying the normal STS gen flow.",
        "",
        format_markdown_root_cause(root_cause),
        "",
        format_markdown_signal_section("Debug Data Outputs", signal_hier["debug_data_outputs"]),
        "",
        format_markdown_signal_section("Debug Data Inputs", signal_hier["debug_data_inputs"]),
        "",
        format_markdown_signal_section("Timestamp Ports", signal_hier["timestamp_ports"]),
        "",
        format_markdown_address_map(cast(list[dict[str, Any]], report["address_to_tgtid_map"])),
        "",
        format_markdown_leaf_aliases(cast(dict[str, Any], report["leaf_aliases"])),
        "",
        format_markdown_tree(cast(dict[str, Any], report["tgtid_attributed_tree"])),
    ]
    return "\n".join(parts)


def write_dual_reports(report: dict[str, Any], output_dir: Path) -> tuple[Path, Path]:
    output_dir.mkdir(parents=True, exist_ok=True)
    json_path = output_dir / "sts_postgen_report.json"
    markdown_path = output_dir / "sts_postgen_review.md"
    json_path.write_text(json.dumps(report, indent=2, sort_keys=False) + "\n", encoding="utf-8")
    markdown_path.write_text(emit_markdown(report) + "\n", encoding="utf-8")
    return json_path, markdown_path


def main() -> int:
    args = parse_args()
    report = build_report()
    if args.emit_both:
        json_path, markdown_path = write_dual_reports(report, args.output_dir)
        print(f"json: {json_path}")
        print(f"markdown: {markdown_path}")
    elif args.json:
        print(json.dumps(report, indent=2, sort_keys=False))
    elif args.markdown:
        print(emit_markdown(report))
    else:
        print(emit_text(report))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
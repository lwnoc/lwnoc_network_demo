import json
from pathlib import Path

from AtbTopo import build_topology_dict


def build_uhdl_component_plan_dict():
    topo = build_topology_dict()
    plan_nodes = []
    for node in topo["nodes"]:
        hint = node.get("uhdl_migration", {})
        plan_nodes.append(
            {
                "node_id": node["node_id"],
                "kind": node["kind"],
                "role": node["role"],
                "migration_stage": hint.get("migration_stage", "seed"),
                "target_node_base": hint.get("target_node_base", "UhdlComponentNode"),
                "target_component": hint.get("target_component", "TemplateComponent"),
                "publish_contract": hint.get("publish_contract", "internal_helper"),
                "publish_mode": hint.get("publish_mode", "inline_only"),
                "module": node.get("param", {}).get("module", ""),
            }
        )

    return {
        "plan": "soc_atb_uhdl_component_plan",
        "description": (
            "Stage-0 migration inventory from graph/dataclass nodes toward "
            "UhdlComponentNode + TemplateComponent without changing the shared-root publish contract."
        ),
        "nodes": plan_nodes,
    }


def write_uhdl_migration_plan(path: Path):
    data = build_uhdl_component_plan_dict()
    path.write_text(json.dumps(data, indent=2) + "\n")
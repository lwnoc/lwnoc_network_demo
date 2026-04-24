import json
from pathlib import Path

from AtbTopo import build_topology_dict
from AtbNode import build_registered_uhdl_plan_entries


def build_uhdl_component_plan_dict():
    topo = build_topology_dict()
    plan_nodes = build_registered_uhdl_plan_entries()

    return {
        "plan": "soc_atb_uhdl_component_plan",
        "description": (
            "Stage-0 migration inventory from graph/dataclass nodes toward "
            "registered UhdlComponentNode/UhdlWrapperNode seed classes without changing the shared-root publish contract."
        ),
        "nodes": plan_nodes,
    }


def write_uhdl_migration_plan(path: Path):
    data = build_uhdl_component_plan_dict()
    path.write_text(json.dumps(data, indent=2) + "\n")
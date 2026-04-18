from DtiNode import DtiIniuNode, DtiTniuNode
from SocDtiTemplate import INIU_SYS_CONFIGS


def make_iniu_node(node_name: str, id: str | None = None) -> DtiIniuNode:
    if node_name not in INIU_SYS_CONFIGS:
        raise KeyError(f"Unknown SoC DTI INIU node: {node_name}")
    node_id = id or f"{node_name}_iniu_node"
    return DtiIniuNode(id=node_id, sys_cfg=INIU_SYS_CONFIGS[node_name], node_name=node_name)


def make_tniu_node(id: str = "sys_tcu_tniu_node") -> DtiTniuNode:
    return DtiTniuNode(id=id, node_name="sys_tcu")

import json
from dataclasses import dataclass

from AtbNode import (
    DSP_SOURCES,
    CAMERA_SOURCE,
    MIPI_SOURCE,
    ASYNC_BRIDGE_SLV,
    ASYNC_BRIDGE_MST,
    LEFT_FUNNEL,
    CAMERA_FUNNEL,
    RIGHT_FUNNEL,
    DEBUG_TNIU,
)


@dataclass(frozen=True)
class AtbEdge:
    src: str
    dst: str
    width: int
    note: str = ""

    def to_dict(self):
        return {
            "src": self.src,
            "dst": self.dst,
            "width": self.width,
            "note": self.note,
        }


def build_topology_dict():
    nodes = []
    # DSP INIUs
    nodes.extend(node.to_dict() for node in DSP_SOURCES)
    # camera branch
    nodes.append(CAMERA_SOURCE.to_dict())
    # mipi branch (128b; CDC/buffer internal to iniu sys)
    nodes.append(MIPI_SOURCE.to_dict())
    # async bridge (clock-domain crossing pair)
    nodes.append(ASYNC_BRIDGE_SLV.to_dict())
    nodes.append(ASYNC_BRIDGE_MST.to_dict())
    # funnels and TNIU
    nodes.append(LEFT_FUNNEL.to_dict())
    nodes.append(CAMERA_FUNNEL.to_dict())
    nodes.append(RIGHT_FUNNEL.to_dict())
    nodes.append(DEBUG_TNIU.to_dict())

    edges = []

    # DSP branch: each INIU top-side -> left_funnel directly
    for i, src in enumerate(DSP_SOURCES):
        edges.append(AtbEdge(src=src.node_id, dst=LEFT_FUNNEL.node_id, width=128, note=f"DSP INIU{i} top-side -> left funnel").to_dict())

    # Camera branch: INIU top-side -> camera_funnel directly
    edges.append(AtbEdge(src=CAMERA_SOURCE.node_id, dst=CAMERA_FUNNEL.node_id, width=128, note="camera INIU top-side -> camera funnel").to_dict())

    # MIPI branch: INIU top-side (128b; CDC/buffer internal) -> camera_funnel directly
    edges.append(AtbEdge(src=MIPI_SOURCE.node_id, dst=CAMERA_FUNNEL.node_id, width=128, note="mipi INIU top-side (128b) -> camera funnel").to_dict())

    # Async bridge path: left_funnel -> async_bridge_slv -> async_bridge_mst -> right_funnel
    # slv is on the source clock domain; mst is on the destination/debug clock domain.
    # TODO: async bridge stubs currently tie-off outputs; replace with real CDC FIFO IP.
    edges.append(AtbEdge(src=LEFT_FUNNEL.node_id, dst=ASYNC_BRIDGE_SLV.node_id, width=128, note="left funnel -> async bridge slv (source domain)").to_dict())
    edges.append(AtbEdge(src=ASYNC_BRIDGE_SLV.node_id, dst=ASYNC_BRIDGE_MST.node_id, width=128, note="async bridge CDC cut").to_dict())
    edges.append(AtbEdge(src=ASYNC_BRIDGE_MST.node_id, dst=RIGHT_FUNNEL.node_id, width=128, note="async bridge mst (dest domain) -> right funnel").to_dict())

    # camera_funnel -> right_funnel
    edges.append(AtbEdge(src=CAMERA_FUNNEL.node_id, dst=RIGHT_FUNNEL.node_id, width=128, note="camera aggregate path -> right funnel").to_dict())

    # right_funnel -> TNIU top-side -> debug SS
    edges.append(AtbEdge(src=RIGHT_FUNNEL.node_id, dst=DEBUG_TNIU.node_id, width=128, note="right funnel -> TNIU top-side -> debug SS").to_dict())

    return {
        "topology": "soc_atb_logic_topology",
        "description": (
            "SoC-level ATB packet network. "
            "Sources (INIU): dsp_ss0~5 (128b), mipi_ss (128b), camera_ss (128b). "
            "Sink (TNIU): debug_tniu_ss. "
            "Buffer/CDC is internal to each INIU sys side; topology contains only "
            "INIU, funnel, async_bridge_slv/mst, and TNIU nodes."
        ),
        "nodes": nodes,
        "edges": edges,
    }


def write_topology_json(path):
    data = build_topology_dict()
    path.write_text(json.dumps(data, indent=2) + "\n")


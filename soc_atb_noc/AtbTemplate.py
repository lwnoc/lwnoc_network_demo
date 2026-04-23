from dataclasses import dataclass, asdict
from typing import List


@dataclass(frozen=True)
class AtbNodeParam:
    module: str
    data_width: int
    comment: str = ""
    tie_off: bool = False

    def to_dict(self):
        return asdict(self)


@dataclass(frozen=True)
class AtbEndpointTemplate:
    node_id: str
    kind: str
    role: str
    sys_data_w: int = 128
    fabric_data_w: int = 128


# Template-driven endpoint registration. Keep endpoint ownership and widths here,
# and let AtbNode.py consume this table to build concrete node objects.
ATB_ENDPOINT_TEMPLATES: List[AtbEndpointTemplate] = [
    *(AtbEndpointTemplate(node_id=f"dsp_ss{i}", kind="atb_iniu", role="initiator") for i in range(6)),
    AtbEndpointTemplate(node_id="camera_ss", kind="atb_iniu", role="initiator"),
    AtbEndpointTemplate(node_id="mipi_ss", kind="atb_iniu", role="initiator"),
    AtbEndpointTemplate(node_id="debug_tniu_ss", kind="atb_tniu", role="target"),
]


ATB_PARAMS = {
    # INIU: system-side receives ATB from source SS; top-side drives ATB fabric.
    # sys_data_width = data width on the SS side; top_data_width = fabric width.
    "atb_iniu": AtbNodeParam(
        module="atb_iniu_sys_side",
        data_width=128,
        comment="ATB INIU sys-side payload wrapper (delivery-facing role-local module)",
    ),
    # Buffer: transparent pass-through or FIFO stub between INIU top-side and funnel.
    "atb_buffer": AtbNodeParam(
        module="atb_buffer_stub",
        data_width=128,
        comment="Legacy-only ATB buffer leaf; no longer instantiated in the active ATB topology",
    ),
    # Upsizer: retained only for backward-compatible metadata; active topology is already 128-bit.
    "atb_upsizer": AtbNodeParam(
        module="atb_upsizer_stub",
        data_width=128,
        comment="Legacy-only ATB upsizer leaf; no longer instantiated in the active ATB topology",
        tie_off=True,
    ),
    # Funnel: N-to-1 priority mux aggregating multiple ATB streams.
    "atb_funnel": AtbNodeParam(
        module="atb_funnel3",  # funnel3 / funnel6 chosen per instance fanin
        data_width=128,
        comment="ATB funnel node — priority mux of multiple ATB streams",
    ),
    # Async bridge slave: receives from ATB fabric on source clock domain.
    # Replacement: insert real clock-domain-crossing FIFO slave here.
    "atb_async_bridge_slv": AtbNodeParam(
        module="atb_async_bridge_slv",
        data_width=128,
        comment="ATB async bridge slave stage — CDC from core/fabric domain into async bridge domain",
    ),
    # Async bridge master: drives to ATB fabric on destination clock domain.
    # Replacement: insert real clock-domain-crossing FIFO master here.
    "atb_async_bridge_mst": AtbNodeParam(
        module="atb_async_bridge_mst",
        data_width=128,
        comment="ATB async bridge master stage — CDC from async bridge domain back to core/debug domain",
    ),
    # TNIU: top-side receives aggregated ATB from fabric; sys-side delivers to debug SS.
    "atb_tniu": AtbNodeParam(
        module="atb_tniu_sys_side",
        data_width=128,
        comment="ATB TNIU sys-side payload wrapper (delivery-facing role-local module)",
    ),
}

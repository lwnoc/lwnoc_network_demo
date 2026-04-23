from dataclasses import dataclass, asdict
from typing import Dict, List

from AtbTemplate import ATB_PARAMS, ATB_ENDPOINT_TEMPLATES


def _sv_port(direction: str, name: str, width: int = 1, width_expr: str | None = None) -> Dict[str, str | int | None]:
    expr = width_expr if width_expr is not None else (None if width == 1 else f"{width - 1}:0")
    return {
        "direction": direction,
        "name": name,
        "width": width,
        "width_expr": expr,
    }


def _sv_name_value(name: str, value: str) -> Dict[str, str]:
    return {
        "name": name,
        "value": value,
    }


def _sv_binding(port: str, signal: str) -> Dict[str, str]:
    return {
        "port": port,
        "signal": signal,
    }


@dataclass(frozen=True)
class InterfacePort:
    name: str
    direction: str
    width: int

    def to_dict(self):
        return asdict(self)


@dataclass(frozen=True)
class AtbNode:
    node_id: str
    kind: str
    role: str
    sys_data_w: int = 128
    fabric_data_w: int = 128
    num_inputs: int = 1  # For funnels: number of input channels (1=passthrough, 3=funnel3, 6=funnel6)

    def uhdl_migration_hint(self) -> Dict[str, str]:
        if self.kind in {"atb_iniu", "atb_tniu"}:
            return {
                "migration_stage": "seed",
                "target_node_base": "UhdlComponentNode",
                "target_component": "TemplateComponent",
                "publish_contract": "delivery_boundary",
                "publish_mode": "shared_root_top_wrapper",
            }
        if self.kind in {"atb_async_bridge_slv", "atb_async_bridge_mst"}:
            return {
                "migration_stage": "seed",
                "target_node_base": "UhdlComponentNode",
                "target_component": "TemplateComponent",
                "publish_contract": "internal_helper",
                "publish_mode": "inline_only",
            }
        return {
            "migration_stage": "seed",
            "target_node_base": "UhdlComponentNode",
            "target_component": "TemplateComponent",
            "publish_contract": "internal_helper",
            "publish_mode": "inline_only",
        }

    def sys_interface_ports(self) -> List[InterfacePort]:
        if self.kind == "atb_iniu":
            return [
                InterfacePort(name=f"{self.node_id}_atvalid", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_atready", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_atbytes", direction="input", width=4),
                InterfacePort(name=f"{self.node_id}_atdata", direction="input", width=self.sys_data_w),
                InterfacePort(name=f"{self.node_id}_atid", direction="input", width=7),
                InterfacePort(name=f"{self.node_id}_afvalid", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_afready", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_syncreq", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_atwakeup", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_preq", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_pstate", direction="input", width=2),
                InterfacePort(name=f"{self.node_id}_pactive", direction="output", width=2),
                InterfacePort(name=f"{self.node_id}_paccept", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_pdeny", direction="output", width=1),
            ]
        if self.kind == "atb_tniu":
            return [
                InterfacePort(name=f"{self.node_id}_atvalid", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_atready", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_atbytes", direction="output", width=4),
                InterfacePort(name=f"{self.node_id}_atdata", direction="output", width=self.sys_data_w),
                InterfacePort(name=f"{self.node_id}_atid", direction="output", width=7),
                InterfacePort(name=f"{self.node_id}_afvalid", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_afready", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_syncreq", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_atwakeup", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_preq", direction="input", width=1),
                InterfacePort(name=f"{self.node_id}_pstate", direction="input", width=2),
                InterfacePort(name=f"{self.node_id}_pactive", direction="output", width=2),
                InterfacePort(name=f"{self.node_id}_paccept", direction="output", width=1),
                InterfacePort(name=f"{self.node_id}_pdeny", direction="output", width=1),
            ]
        return []

    def wrapper_contract(self) -> Dict[str, object]:
        if self.kind == "atb_iniu":
            return {
                "module_ports": [
                    _sv_port("input", "clk"),
                    _sv_port("input", "rst_n"),
                    _sv_port("input", "sys_atvalid"),
                    _sv_port("output", "sys_atready"),
                    _sv_port("input", "sys_atbytes", 4),
                    _sv_port("input", "sys_atdata", self.sys_data_w, "DATA_W-1:0"),
                    _sv_port("input", "sys_atid", 7),
                    _sv_port("output", "sys_afvalid"),
                    _sv_port("input", "sys_afready"),
                    _sv_port("output", "sys_syncreq"),
                    _sv_port("input", "sys_atwakeup"),
                    _sv_port("input", "sys_preq"),
                    _sv_port("input", "sys_pstate", 2),
                    _sv_port("output", "sys_pactive", 2),
                    _sv_port("output", "sys_paccept"),
                    _sv_port("output", "sys_pdeny"),
                    _sv_port("output", "noc_atvalid"),
                    _sv_port("input", "noc_atready"),
                    _sv_port("output", "noc_atbytes", 4),
                    _sv_port("output", "noc_atdata", self.fabric_data_w, "DATA_W-1:0"),
                    _sv_port("output", "noc_atid", 7),
                    _sv_port("input", "noc_afvalid"),
                    _sv_port("output", "noc_afready"),
                    _sv_port("input", "noc_syncreq"),
                    _sv_port("output", "noc_atwakeup"),
                ],
                "localparams": [
                    _sv_name_value("ATB_BYTES_W", "4"),
                    _sv_name_value("ATB_ID_W", "7"),
                    _sv_name_value("ATB_PLD_W", "142"),
                    _sv_name_value("FIFO_DEPTH", "16"),
                    _sv_name_value("LP_REQ_W", "9"),
                ],
                "internals": [
                    _sv_name_value("wptr_async", "FIFO_DEPTH-1:0"),
                    _sv_name_value("rptr_async", "FIFO_DEPTH-1:0"),
                    _sv_name_value("rptr_sync", "FIFO_DEPTH-1:0"),
                    _sv_name_value("pld_sync", "ATB_PLD_W:0"),
                    _sv_name_value("syncreq_level", ""),
                    _sv_name_value("flush_req_level", ""),
                    _sv_name_value("lp_sys_to_noc", "LP_REQ_W-1:0"),
                    _sv_name_value("lp_noc_to_sys", "LP_REQ_W-1:0"),
                    _sv_name_value("lp_afifo_sys_to_noc", "LP_REQ_W-1:0"),
                    _sv_name_value("lp_afifo_noc_to_sys", "LP_REQ_W-1:0"),
                    _sv_name_value("lwnoc_m_atbytes", "ATB_BYTES_W-1:0"),
                    _sv_name_value("lwnoc_m_atid", "ATB_ID_W-1:0"),
                ],
                "instances": {
                    "sys": {
                        "params": [_sv_name_value("FIFO_DEPTH", "FIFO_DEPTH")],
                        "ports": [
                            _sv_binding("clk_atb_s", "clk"),
                            _sv_binding("rstn_atb_s", "rst_n"),
                            _sv_binding("s_atvalid", "sys_atvalid"),
                            _sv_binding("s_atready", "sys_atready"),
                            _sv_binding("s_atbytes", "sys_atbytes"),
                            _sv_binding("s_atdata", "sys_atdata"),
                            _sv_binding("s_atid", "sys_atid"),
                            _sv_binding("s_afvalid", "sys_afvalid"),
                            _sv_binding("s_afready", "sys_afready"),
                            _sv_binding("s_syncreq", "sys_syncreq"),
                            _sv_binding("s_atwakeup", "sys_atwakeup"),
                            _sv_binding("flush_req", "flush_req_level"),
                            _sv_binding("wptr_async", "wptr_async"),
                            _sv_binding("rptr_async", "rptr_async"),
                            _sv_binding("rptr_sync", "rptr_sync"),
                            _sv_binding("pld_sync", "pld_sync"),
                            _sv_binding("syncreq_level", "syncreq_level"),
                            _sv_binding("preq", "sys_preq"),
                            _sv_binding("pstate", "sys_pstate"),
                            _sv_binding("pactive", "sys_pactive"),
                            _sv_binding("paccept", "sys_paccept"),
                            _sv_binding("pdeny", "sys_pdeny"),
                            _sv_binding("lwnoc_rx_req", "lp_noc_to_sys"),
                            _sv_binding("lwnoc_tx_req", "lp_sys_to_noc"),
                            _sv_binding("afifo_slv_rx_req", "lp_afifo_noc_to_sys"),
                            _sv_binding("afifo_slv_tx_req", "lp_afifo_sys_to_noc"),
                            _sv_binding("timeout_val", "10'd0"),
                        ],
                    },
                    "noc": {
                        "params": [_sv_name_value("FIFO_DEPTH", "FIFO_DEPTH")],
                        "ports": [
                            _sv_binding("clk_atb_m", "clk"),
                            _sv_binding("rstn_atb_m", "rst_n"),
                            _sv_binding("m_atvalid", "noc_atvalid"),
                            _sv_binding("m_atready", "noc_atready"),
                            _sv_binding("m_atbytes", "noc_atbytes"),
                            _sv_binding("m_atdata", "noc_atdata"),
                            _sv_binding("m_atid", "noc_atid"),
                            _sv_binding("m_afvalid", "noc_afvalid"),
                            _sv_binding("m_afready", "noc_afready"),
                            _sv_binding("m_syncreq", "noc_syncreq"),
                            _sv_binding("m_atwakeup", "noc_atwakeup"),
                            _sv_binding("syncreq_level", "syncreq_level"),
                            _sv_binding("flush_req_level", "flush_req_level"),
                            _sv_binding("afifo_mst_rx_req", "lp_afifo_sys_to_noc"),
                            _sv_binding("afifo_mst_tx_req", "lp_afifo_noc_to_sys"),
                            _sv_binding("wptr_async", "wptr_async"),
                            _sv_binding("rptr_async", "rptr_async"),
                            _sv_binding("rptr_sync", "rptr_sync"),
                            _sv_binding("pld_sync", "pld_sync"),
                            _sv_binding("lw_rx_req", "lp_sys_to_noc"),
                            _sv_binding("lw_tx_req", "lp_noc_to_sys"),
                            _sv_binding("timeout_val", "10'd0"),
                        ],
                    },
                },
                "payload_bridge": {
                    "fabric_valid_wire": "noc_atvalid",
                    "fabric_data_wire": "noc_atdata",
                    "tieoffs": [],
                },
            }

        if self.kind == "atb_tniu":
            return {
                "module_ports": [
                    _sv_port("input", "clk"),
                    _sv_port("input", "rst_n"),
                    _sv_port("input", "noc_atvalid"),
                    _sv_port("output", "noc_atready"),
                    _sv_port("input", "noc_atbytes", 4),
                    _sv_port("input", "noc_atdata", self.fabric_data_w, "DATA_W-1:0"),
                    _sv_port("input", "noc_atid", 7),
                    _sv_port("output", "noc_afvalid"),
                    _sv_port("input", "noc_afready"),
                    _sv_port("output", "noc_syncreq"),
                    _sv_port("input", "noc_atwakeup"),
                    _sv_port("input", "syncreq_level"),
                    _sv_port("input", "flush_req_level"),
                    _sv_port("input", "lp_sys_to_noc", 9),
                    _sv_port("output", "lp_noc_to_sys", 9),
                    _sv_port("input", "lp_afifo_sys_to_noc", 9),
                    _sv_port("output", "lp_afifo_noc_to_sys", 9),
                    _sv_port("output", "wptr_async", 16),
                    _sv_port("input", "rptr_async", 16),
                    _sv_port("input", "rptr_sync", 16),
                    _sv_port("output", "pld_sync", 143),
                ],
                "localparams": [
                    _sv_name_value("ATB_BYTES_W", "4"),
                    _sv_name_value("ATB_ID_W", "7"),
                    _sv_name_value("ATB_PLD_W", "142"),
                    _sv_name_value("FIFO_DEPTH", "16"),
                    _sv_name_value("LP_REQ_W", "9"),
                ],
                "internals": [
                    _sv_name_value("lwnoc_s_atready_unused", ""),
                    _sv_name_value("lwnoc_s_afvalid_unused", ""),
                    _sv_name_value("lwnoc_s_syncreq_unused", ""),
                ],
                "instances": {
                    "noc": {
                        "params": [_sv_name_value("FIFO_DEPTH", "FIFO_DEPTH")],
                        "ports": [
                            _sv_binding("clk_atb_s", "clk"),
                            _sv_binding("rstn_atb_s", "rst_n"),
                            _sv_binding("s_atvalid", "noc_atvalid"),
                            _sv_binding("s_atready", "lwnoc_s_atready_unused"),
                            _sv_binding("s_atbytes", "noc_atbytes"),
                            _sv_binding("s_atdata", "noc_atdata"),
                            _sv_binding("s_atid", "noc_atid"),
                            _sv_binding("s_afvalid", "lwnoc_s_afvalid_unused"),
                            _sv_binding("s_afready", "noc_afready"),
                            _sv_binding("s_syncreq", "lwnoc_s_syncreq_unused"),
                            _sv_binding("s_atwakeup", "noc_atwakeup"),
                            _sv_binding("flush_req", "flush_req_level"),
                            _sv_binding("aifo_slv_full_zero", ""),
                            _sv_binding("wptr_async", "wptr_async"),
                            _sv_binding("rptr_async", "rptr_async"),
                            _sv_binding("rptr_sync", "rptr_sync"),
                            _sv_binding("pld_sync", "pld_sync"),
                            _sv_binding("syncreq_level", "syncreq_level"),
                            _sv_binding("lw_rx_req", "lp_sys_to_noc"),
                            _sv_binding("lw_tx_req", "lp_noc_to_sys"),
                            _sv_binding("afifo_slv_rx_req", "lp_afifo_sys_to_noc"),
                            _sv_binding("afifo_slv_tx_req", "lp_afifo_noc_to_sys"),
                            _sv_binding("timeout_val", "10'd0"),
                        ],
                    },
                },
                "payload_bridge": {
                    "fabric_valid_wire": "noc_atvalid",
                    "fabric_data_wire": "noc_atdata",
                    "defaults": [
                        _sv_binding("noc_afready", "1'b1"),
                        _sv_binding("noc_atwakeup", "1'b0"),
                    ],
                },
            }

        return {}

    def node_interfaces(self) -> Dict[str, List[InterfacePort]]:
        if self.kind == "atb_iniu":
            return {
                "sys_in": self.sys_interface_ports(),
                "top_out": [
                    InterfacePort(name="out_valid", direction="output", width=1),
                    InterfacePort(name="out_data", direction="output", width=self.fabric_data_w),
                ],
            }
        if self.kind == "atb_tniu":
            return {
                "top_in": [
                    InterfacePort(name="in_valid", direction="input", width=1),
                    InterfacePort(name="in_data", direction="input", width=self.fabric_data_w),
                ],
                "sys_out": self.sys_interface_ports(),
            }
        if self.kind == "atb_buffer":
            return {
                "control": [
                    InterfacePort(name="clk", direction="input", width=1),
                    InterfacePort(name="rst_n", direction="input", width=1),
                ],
                "top_in": [
                    InterfacePort(name="in_valid", direction="input", width=1),
                    InterfacePort(name="in_data", direction="input", width=self.fabric_data_w),
                ],
                "top_out": [
                    InterfacePort(name="out_valid", direction="output", width=1),
                    InterfacePort(name="out_data", direction="output", width=self.fabric_data_w),
                ],
            }
        if self.kind == "atb_upsizer":
            return {
                "control": [
                    InterfacePort(name="clk", direction="input", width=1),
                    InterfacePort(name="rst_n", direction="input", width=1),
                ],
                "narrow_in": [
                    InterfacePort(name="in_valid", direction="input", width=1),
                    InterfacePort(name="in_data", direction="input", width=self.sys_data_w),
                ],
                "wide_out": [
                    InterfacePort(name="out_valid", direction="output", width=1),
                    InterfacePort(name="out_data", direction="output", width=self.fabric_data_w),
                ],
            }
        if self.kind == "atb_funnel":
            # Funnels with full ATB protocol support
            # Inputs are indexed arrays of ATB protocol signals
            # Outputs are single consolidated ATB protocol signals
            ports_dict = {}
            top_in = []
            for i in range(self.num_inputs):
                top_in.append(InterfacePort(name=f"atvalids[{i}]", direction="input", width=1))
                top_in.append(InterfacePort(name=f"atbytess[{i}]", direction="input", width=4))
                top_in.append(InterfacePort(name=f"atdatas[{i}]", direction="input", width=self.fabric_data_w))
                top_in.append(InterfacePort(name=f"atids[{i}]", direction="input", width=7))
                top_in.append(InterfacePort(name=f"afreadys[{i}]", direction="output", width=1))
            ports_dict["top_in"] = top_in
            ports_dict["top_out"] = [
                InterfacePort(name="atreadym", direction="output", width=1),
                InterfacePort(name="afvalidm", direction="output", width=1),
                InterfacePort(name="syncreqm", direction="output", width=1),
            ]
            return ports_dict
        if self.kind == "atb_async_bridge_slv":
            return {
                "control": [
                    InterfacePort(name="clk", direction="input", width=1),
                    InterfacePort(name="clk_async", direction="input", width=1),
                    InterfacePort(name="rst_n", direction="input", width=1),
                ],
                "top_in": [
                    InterfacePort(name="s_atvalid", direction="input", width=1),
                    InterfacePort(name="s_atready", direction="output", width=1),
                    InterfacePort(name="s_atbytes", direction="input", width=4),
                    InterfacePort(name="s_atdata", direction="input", width=self.fabric_data_w),
                    InterfacePort(name="s_atid", direction="input", width=7),
                    InterfacePort(name="s_afvalid", direction="output", width=1),
                    InterfacePort(name="s_afready", direction="input", width=1),
                    InterfacePort(name="s_syncreq", direction="output", width=1),
                    InterfacePort(name="s_atwakeup", direction="input", width=1),
                ],
                "async_out": [
                    InterfacePort(name="m_atvalid", direction="output", width=1),
                    InterfacePort(name="m_atready", direction="input", width=1),
                    InterfacePort(name="m_atbytes", direction="output", width=4),
                    InterfacePort(name="m_atdata", direction="output", width=self.fabric_data_w),
                    InterfacePort(name="m_atid", direction="output", width=7),
                    InterfacePort(name="m_afvalid", direction="input", width=1),
                    InterfacePort(name="m_afready", direction="output", width=1),
                    InterfacePort(name="m_syncreq", direction="input", width=1),
                    InterfacePort(name="m_atwakeup", direction="output", width=1),
                ],
            }
        if self.kind == "atb_async_bridge_mst":
            return {
                "control": [
                    InterfacePort(name="clk", direction="input", width=1),
                    InterfacePort(name="clk_async", direction="input", width=1),
                    InterfacePort(name="rst_n", direction="input", width=1),
                ],
                "async_in": [
                    InterfacePort(name="s_atvalid", direction="input", width=1),
                    InterfacePort(name="s_atready", direction="output", width=1),
                    InterfacePort(name="s_atbytes", direction="input", width=4),
                    InterfacePort(name="s_atdata", direction="input", width=self.fabric_data_w),
                    InterfacePort(name="s_atid", direction="input", width=7),
                    InterfacePort(name="s_afvalid", direction="output", width=1),
                    InterfacePort(name="s_afready", direction="input", width=1),
                    InterfacePort(name="s_syncreq", direction="output", width=1),
                    InterfacePort(name="s_atwakeup", direction="input", width=1),
                ],
                "top_out": [
                    InterfacePort(name="m_atvalid", direction="output", width=1),
                    InterfacePort(name="m_atready", direction="input", width=1),
                    InterfacePort(name="m_atbytes", direction="output", width=4),
                    InterfacePort(name="m_atdata", direction="output", width=self.fabric_data_w),
                    InterfacePort(name="m_atid", direction="output", width=7),
                    InterfacePort(name="m_afvalid", direction="input", width=1),
                    InterfacePort(name="m_afready", direction="output", width=1),
                    InterfacePort(name="m_syncreq", direction="input", width=1),
                    InterfacePort(name="m_atwakeup", direction="output", width=1),
                ],
            }
        return {}

    def to_dict(self):
        d = asdict(self)
        if self.kind in ATB_PARAMS:
            d["param"] = ATB_PARAMS[self.kind].to_dict()
        d["uhdl_migration"] = self.uhdl_migration_hint()
        d["interfaces"] = {
            name: [port.to_dict() for port in ports]
            for name, ports in self.node_interfaces().items()
        }
        contract = self.wrapper_contract()
        if contract:
            d["wrapper_contract"] = contract
        return d


def _build_registered_endpoints() -> Dict[str, AtbNode]:
    registry: Dict[str, AtbNode] = {}
    for spec in ATB_ENDPOINT_TEMPLATES:
        registry[spec.node_id] = AtbNode(
            node_id=spec.node_id,
            kind=spec.kind,
            role=spec.role,
            sys_data_w=spec.sys_data_w,
            fabric_data_w=spec.fabric_data_w,
        )
    return registry


ATB_NODE_REGISTRY = _build_registered_endpoints()


def _registry_nodes_by(kind: str | None = None, node_prefix: str | None = None) -> List[AtbNode]:
    nodes = list(ATB_NODE_REGISTRY.values())
    if kind is not None:
        nodes = [n for n in nodes if n.kind == kind]
    if node_prefix is not None:
        nodes = [n for n in nodes if n.node_id.startswith(node_prefix)]
    return sorted(nodes, key=lambda n: n.node_id)

# ATB source INIUs: dsp_ss0~5, mipi_ss, camera_ss
DSP_SOURCES = _registry_nodes_by(kind="atb_iniu", node_prefix="dsp_ss")
CAMERA_SOURCE = ATB_NODE_REGISTRY["camera_ss"]
MIPI_SOURCE = ATB_NODE_REGISTRY["mipi_ss"]

# Async bridge (clock domain crossing) on the aggregation path.
# slv = receives from ATB fabric (source domain side)
# mst = drives to ATB fabric (destination domain side)
# Async bridge path now uses real CDC primitives from rtl/atb_primitives.sv.
ASYNC_BRIDGE_SLV = AtbNode(node_id="async_bridge_slv", kind="atb_async_bridge_slv", role="async_bridge")
ASYNC_BRIDGE_MST = AtbNode(node_id="async_bridge_mst", kind="atb_async_bridge_mst", role="async_bridge")

LEFT_FUNNEL = AtbNode(node_id="left_funnel", kind="atb_funnel", role="aggregation", num_inputs=6)
CAMERA_FUNNEL = AtbNode(node_id="camera_funnel", kind="atb_funnel", role="aggregation", num_inputs=3)
RIGHT_FUNNEL = AtbNode(node_id="right_funnel", kind="atb_funnel", role="aggregation", num_inputs=3)

# ATB destination TNIU: debug SS
DEBUG_TNIU = ATB_NODE_REGISTRY["debug_tniu_ss"]

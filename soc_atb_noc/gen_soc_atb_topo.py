import os
import re
import shutil
from pathlib import Path

from AtbNode import CAMERA_SOURCE, DEBUG_TNIU, DSP_SOURCES, MIPI_SOURCE
from AtbTopo import build_topology_dict, write_topology_json
from AtbUhdlPlan import write_uhdl_migration_plan


THIS_DIR = Path(__file__).resolve().parent
TOPO_ID = "atb_soc_topo"
NETWORK_LAYER_ID = "atb_network_layer"
ATB_SUBIP_ROOT = Path(os.environ.get("ATB_SUBIP_ROOT", "/home/lgzhu/dev/noc_work/lwnoc_atb_noc")).resolve()


def _default_common_ip_root() -> Path:
    candidates = [
        THIS_DIR.parent / "subs" / "lwnoc_dti_noc" / "fcip",
        THIS_DIR.parent / "subs" / "lwnoc_interrupt_noc" / "fcip",
    ]
    for c in candidates:
        if (c / "vc" / "basic.f").exists():
            return c.resolve()
    raise FileNotFoundError("Cannot find COMMON_IP_PATH candidate under subs/*/fcip")


def _default_lowpower_root() -> Path:
    candidates = [
        THIS_DIR.parent / "subs" / "lwnoc_dti_noc" / "lwnoc_lowpower_component",
        THIS_DIR.parent / "subs" / "lwnoc_interrupt_noc" / "lwnoc_lowpower_component",
    ]
    for c in candidates:
        if (c / "src" / "vc" / "lwnoc_lp_all.f").exists():
            return c.resolve()
    raise FileNotFoundError("Cannot find LOWPOWER_PATH candidate under subs/*/lwnoc_lowpower_component")


def _ensure_dirs():
    for rel in ["build", "build_logic", "build_logic_pd", "filelist", "filelist_pd", "sim", "constraint"]:
        (THIS_DIR / rel).mkdir(parents=True, exist_ok=True)


def _fmt_logic_width(width: int) -> str:
    return "" if width == 1 else f" [{width-1}:0]"


def _funnel_debug_ports(nodes) -> list[tuple[str, str, int]]:
    ports: list[tuple[str, str, int]] = []
    for node in nodes:
        if node["kind"] != "atb_funnel":
            continue
        nid = node["node_id"]
        ports.extend([
            ("input", f"{nid}_pclkendbg", 1),
            ("input", f"{nid}_pseldbg", 1),
            ("input", f"{nid}_penabledbg", 1),
            ("input", f"{nid}_pwritedbg", 1),
            ("input", f"{nid}_paddrdbg31", 1),
            ("input", f"{nid}_paddrdbg", 10),
            ("input", f"{nid}_pwdatadbg", 32),
            ("output", f"{nid}_preadydbg", 1),
            ("output", f"{nid}_pslverrdbg", 1),
            ("output", f"{nid}_prdatadbg", 32),
        ])
    return ports


def _collect_boundary_ports(topo_nodes=None):
    ports = [
        ("input", "clk_core", 1),
        ("input", "clk_async", 1),
        ("input", "rst_core_n", 1),
        ("input", "rst_async_n", 1),
    ]
    boundary_nodes = [*DSP_SOURCES, CAMERA_SOURCE, MIPI_SOURCE, DEBUG_TNIU]
    for node in boundary_nodes:
        ports.append(("input", f"{node.node_id}_clk_sys", 1))
        ports.append(("input", f"{node.node_id}_rst_sys_n", 1))
        for port in node.sys_interface_ports():
            ports.append((port.direction, port.name, port.width))
    if topo_nodes is not None:
        ports.extend(_funnel_debug_ports(topo_nodes))
    return ports


def _collect_boundary_ports_for_node_dicts(nodes) -> list[tuple[str, str, int]]:
    ports = [
        ("input", "clk_core", 1),
        ("input", "clk_async", 1),
        ("input", "rst_core_n", 1),
        ("input", "rst_async_n", 1),
    ]
    for node in nodes:
        ports.append(("input", f"{node['node_id']}_clk_sys", 1))
        ports.append(("input", f"{node['node_id']}_rst_sys_n", 1))
        iface_name = "sys_in" if node["kind"] == "atb_iniu" else "sys_out"
        for port in node["interfaces"][iface_name]:
            ports.append((port["direction"], port["name"], int(port["width"])))
    return ports


def _boundary_nodes(nodes, kind: str):
    return [node for node in nodes if node["kind"] == kind]


def _sys_publish_dir(node) -> str:
    suffix = "iniu_sys" if node["kind"] == "atb_iniu" else "tniu_sys"
    return f"{node['node_id']}_{suffix}"


def _sys_publish_group_dir(node) -> str:
    if node["kind"] == "atb_iniu" and node["node_id"].startswith("dsp_ss"):
        return "dsp_iniu_sys"
    return _sys_publish_dir(node)


def _sys_module_name(node) -> str:
    suffix = "iniu_sys_side" if node["kind"] == "atb_iniu" else "tniu_sys_side"
    return f"{node['node_id']}_{suffix}"


def _tniu_noc_module_name(node) -> str:
    return f"{node['node_id']}_tniu_noc_side"


def _network_port_valid(node, direction: str) -> str:
    return f"{node['node_id']}_{direction}_valid"


def _network_port_data(node, direction: str) -> str:
    return f"{node['node_id']}_{direction}_data"


def _sys_sig(node, suffix: str) -> str:
    return f"{node['node_id']}_{suffix}"


def _sys_payload_prefix(node) -> str:
    return node["node_id"]


def _wrapper_contract(node) -> dict:
    contract = node.get("wrapper_contract")
    if not contract:
        raise ValueError(f"missing wrapper contract for node {node['node_id']}")
    return contract


def _contract_name_values(entries: list[dict]) -> list[tuple[str, str]]:
    return [(entry["name"], entry["value"]) for entry in entries]


def _contract_port_decls(node) -> list[tuple[str, str, str | None]]:
    return [
        (port["direction"], port["name"], port.get("width_expr"))
        for port in _wrapper_contract(node)["module_ports"]
    ]


def _contract_bindings(entries: list[dict]) -> list[tuple[str, str]]:
    return [(entry["port"], entry["signal"]) for entry in entries]


_PSTATE_ENUM_TYPE = "lwnoc_lp_define_package::lwnoc_pchannel_state_t"


def _cast_pstate_bindings(bindings: list[tuple[str, str]]) -> list[tuple[str, str]]:
    """Wrap pstate signal in enum cast to suppress ENUMASSIGN lint warning."""
    result = []
    for port_name, sig_name in bindings:
        if port_name == "pstate":
            sig_name = f"{_PSTATE_ENUM_TYPE}'({sig_name})"
        result.append((port_name, sig_name))
    return result


def _contract_wire_specs(entries: list[dict]) -> list[tuple[str, str | None]]:
    return [(entry["name"], entry["value"] or None) for entry in entries]


def _noc_bundle_ports(node) -> list[dict]:
    return [port for port in _wrapper_contract(node)["module_ports"] if port["name"].startswith("noc_")]


def _noc_bundle_wire(node, port_name: str) -> str:
    return f"w_{node['node_id']}_{port_name}"


def _wrapper_noc_bindings(node) -> list[tuple[str, str]]:
    return [(port["name"], _noc_bundle_wire(node, port["name"])) for port in _noc_bundle_ports(node)]


def _emit_noc_aux_wire_decls(node) -> list[str]:
    lines = []
    for port in _noc_bundle_ports(node):
        lines.append(f"  logic{_fmt_logic_width(int(port['width']))} {_noc_bundle_wire(node, port['name'])};")
    return lines


def _emit_iniu_payload_bridge(lines, node):
    bridge = _wrapper_contract(node)["payload_bridge"]
    lines.append(f"  assign w_{node['node_id']}_noc_valid = {_noc_bundle_wire(node, bridge['fabric_valid_wire'])};")
    lines.append(
        f"  assign w_{node['node_id']}_noc_payload = {{{_noc_bundle_wire(node, 'noc_atbytes')}, "
        f"{_noc_bundle_wire(node, 'noc_atid')}, {_noc_bundle_wire(node, bridge['fabric_data_wire'])}}};"
    )
    for binding in bridge.get("tieoffs", []):
        lines.append(f"  assign {_noc_bundle_wire(node, binding['port'])} = {binding['signal']};")


def _emit_tniu_payload_defaults(lines, node):
    bridge = _wrapper_contract(node)["payload_bridge"]
    lines.append(f"  assign {_noc_bundle_wire(node, bridge['fabric_valid_wire'])} = w_{node['node_id']}_noc_valid;")
    lines.append(f"  assign {_noc_bundle_wire(node, bridge['fabric_data_wire'])} = w_{node['node_id']}_noc_data;")
    lines.append(f"  assign {_noc_bundle_wire(node, 'noc_atbytes')} = '0;")
    lines.append(f"  assign {_noc_bundle_wire(node, 'noc_atid')} = '0;")
    for binding in bridge.get("defaults", []):
        lines.append(f"  assign {_noc_bundle_wire(node, binding['port'])} = {binding['signal']};")


def _emit_iniu_reverse_control(lines, iniu_nodes, tniu_nodes):
    # ATB reverse control channel for single-sink topology:
    # propagate sink-side ready/flush/sync indications back to every INIU noc-side wrapper.
    if len(tniu_nodes) != 1:
        for node in iniu_nodes:
            lines.append(f"  assign {_noc_bundle_wire(node, 'noc_atready')} = 1'b1;")
            lines.append(f"  assign {_noc_bundle_wire(node, 'noc_afvalid')} = 1'b0;")
            lines.append(f"  assign {_noc_bundle_wire(node, 'noc_syncreq')} = 1'b0;")
        return

    sink = tniu_nodes[0]
    sink_ready = _noc_bundle_wire(sink, "noc_atready")
    sink_afvalid = _noc_bundle_wire(sink, "noc_afvalid")
    sink_syncreq = _noc_bundle_wire(sink, "noc_syncreq")
    for node in iniu_nodes:
        lines.append(f"  assign {_noc_bundle_wire(node, 'noc_atready')} = {sink_ready};")
        lines.append(f"  assign {_noc_bundle_wire(node, 'noc_afvalid')} = {sink_afvalid};")
        lines.append(f"  assign {_noc_bundle_wire(node, 'noc_syncreq')} = {sink_syncreq};")


def _sv_decl(direction: str, name: str, width_expr: str | None = None) -> str:
    width = "" if not width_expr else f" [{width_expr}]"
    return f"  {direction} logic{width} {name}"


def _sv_wire_decl(name: str, width_expr: str | None = None) -> str:
    width = "" if not width_expr else f" [{width_expr}]"
    return f"  logic{width} {name};"


def _sv_render_instance(module_name: str, inst_name: str, ports: list[tuple[str, str]], params: list[tuple[str, str]] | None = None) -> list[str]:
    param_text = ""
    if params:
        param_text = " #(" + ", ".join(f".{k}({v})" for k, v in params) + ")"
    lines = [f"  {module_name}{param_text} {inst_name} ("]
    for idx, (port_name, sig_name) in enumerate(ports):
        comma = "," if idx < len(ports) - 1 else ""
        lines.append(f"    .{port_name}({sig_name}){comma}")
    lines.append("  );")
    return lines


def _sv_render_module(module_name: str, parameters: list[tuple[str, str]], ports: list[tuple[str, str, str | None]], body_lines: list[str]) -> str:
    lines = [f"module {module_name} #("]
    for idx, (ptype, pname) in enumerate(parameters):
        comma = "," if idx < len(parameters) - 1 else ""
        lines.append(f"  parameter {ptype} {pname}{comma}")
    lines.append(") (")
    for idx, (direction, name, width_expr) in enumerate(ports):
        comma = "," if idx < len(ports) - 1 else ""
        lines.append(f"{_sv_decl(direction, name, width_expr)}{comma}")
    lines.append(");")
    lines.extend(body_lines)
    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _gen_real_iniu_sys_wrapper(node) -> str:
    module_name = _sys_module_name(node)
    data_w = node["sys_data_w"]
    if node["kind"] != "atb_iniu":
        raise ValueError(f"unexpected node kind for iniu wrapper: {node['kind']}")

    contract = _wrapper_contract(node)
    payload_prefix = _sys_payload_prefix(node)
    iniu_sys_mod = f"{payload_prefix}_atb_iniu_sys"
    iniu_noc_mod = f"{node['node_id']}_atb_iniu_noc"

    body = ["// Real-subIP anchored wrapper: iniu sys-side ingress + iniu noc-side egress."]
    for name, value in _contract_name_values(contract["localparams"]):
        body.append(f"  localparam int {name} = {value};")
    body.append("")
    for name, width in _contract_wire_specs(contract["internals"]):
        body.append(_sv_wire_decl(name, width))
    body.append("")

    body.extend(
        _sv_render_instance(
            module_name=iniu_sys_mod,
            inst_name="u_real_iniu_sys",
            params=_contract_name_values(contract["instances"]["sys"]["params"]),
            ports=_cast_pstate_bindings(_contract_bindings(contract["instances"]["sys"]["ports"])),
        )
    )
    body.append("")
    body.extend(
        _sv_render_instance(
            module_name=iniu_noc_mod,
            inst_name="u_real_iniu_noc",
            params=_contract_name_values(contract["instances"]["noc"]["params"]),
            ports=_contract_bindings(contract["instances"]["noc"]["ports"]),
        )
    )

    return _sv_render_module(
        module_name=module_name,
        parameters=[("int", f"DATA_W = {data_w}")],
        ports=_contract_port_decls(node),
        body_lines=body,
    )


def _gen_real_tniu_noc_wrapper(node) -> str:
    module_name = _tniu_noc_module_name(node)
    data_w = node["fabric_data_w"]
    contract = _wrapper_contract(node)

    body = ["// Real-subIP anchored wrapper: tniu noc-side only."]
    for name, value in _contract_name_values(contract["localparams"]):
        body.append(f"  localparam int {name} = {value};")
    body.append("")
    for name, width in _contract_wire_specs(contract["internals"]):
        body.append(_sv_wire_decl(name, width))
    body.append("")
    body.extend(
        _sv_render_instance(
            module_name=f"{node['node_id']}_atb_tniu_noc",
            inst_name="u_real_tniu_noc",
            params=_contract_name_values(contract["instances"]["noc"]["params"]),
            ports=_contract_bindings(contract["instances"]["noc"]["ports"]),
        )
    )

    return _sv_render_module(
        module_name=module_name,
        parameters=[("int", f"DATA_W = {data_w}")],
        ports=_contract_port_decls(node),
        body_lines=body,
    )


def _strip_line_comment(line: str) -> str:
    idx = line.find("//")
    return line if idx < 0 else line[:idx]


def _expand_vars(text: str, env_map: dict) -> str:
    def _repl(match):
        var = match.group(1)
        return env_map.get(var, match.group(0))

    return re.sub(r"\$([A-Za-z_][A-Za-z0-9_]*)", _repl, text)


def _flatten_filelist(filelist_path: Path, env_map: dict, seen: set | None = None) -> list[str]:
    if seen is None:
        seen = set()
    real_filelist = filelist_path.resolve()
    if real_filelist in seen:
        return []
    seen.add(real_filelist)

    out = []
    for raw_line in real_filelist.read_text().splitlines():
        line = _strip_line_comment(raw_line).strip()
        if not line:
            continue
        line = _expand_vars(line, env_map).strip()
        if line.startswith("-f"):
            inc = line[2:].strip()
            inc_path = Path(inc)
            if not inc_path.is_absolute():
                inc_path = (real_filelist.parent / inc_path).resolve()
            out.extend(_flatten_filelist(inc_path, env_map, seen))
            continue
        item_path = Path(line)
        if not item_path.is_absolute():
            item_path = (real_filelist.parent / item_path).resolve()
        out.append(str(item_path))
    return out


def _build_real_subip_expanded_list() -> list[str]:
    common_root = Path(os.environ.get("COMMON_IP_PATH", str(_default_common_ip_root()))).resolve()
    lowpower_root = Path(os.environ.get("LOWPOWER_PATH", str(_default_lowpower_root()))).resolve()
    env_map = {
        "ATB_INIU": str(ATB_SUBIP_ROOT),
        "RTL_PATH": str(ATB_SUBIP_ROOT),
        "COMMON_IP_PATH": str(common_root),
        "LOWPOWER_PATH": str(lowpower_root),
        "FCIP_DIR": str(common_root),
        "LWNOC_LOWPOWER_COMPONENT": str(lowpower_root),
    }
    vc_root = ATB_SUBIP_ROOT / "vc"
    seeds = [
        vc_root / "atb_iniu_sys.f",
        vc_root / "atb_iniu_noc.f",
        vc_root / "atb_tniu_sys.f",
        vc_root / "atb_tniu_noc.f",
    ]
    files = []
    seen_files = set()
    for seed in seeds:
        for f in _flatten_filelist(seed, env_map):
            if f not in seen_files:
                seen_files.add(f)
                files.append(f)
    return files


def _split_atb_subip_files(flat_files: list[str]) -> tuple[list[Path], list[Path], list[Path], list[Path], list[Path]]:
    """Return (common_files, iniu_sys_only, iniu_noc_only, tniu_sys_only, tniu_noc_only)."""
    common_files: list[Path] = []
    iniu_sys_only: list[Path] = []
    iniu_noc_only: list[Path] = []
    tniu_sys_only: list[Path] = []
    tniu_noc_only: list[Path] = []
    atb_root = ATB_SUBIP_ROOT.resolve()
    for f in flat_files:
        p = Path(f).resolve()
        if not str(p).startswith(str(atb_root) + "/"):
            continue
        if p.name == "atb_iniu_sys.sv":
            iniu_sys_only.append(p)
            continue
        if p.name == "atb_iniu_noc.sv":
            iniu_noc_only.append(p)
            continue
        if p.name == "atb_tniu_sys.sv":
            tniu_sys_only.append(p)
            continue
        if p.name == "atb_tniu_noc.sv":
            tniu_noc_only.append(p)
            continue
        common_files.append(p)
    return common_files, iniu_sys_only, iniu_noc_only, tniu_sys_only, tniu_noc_only


def _materialize_prefixed_sys_payload(
    node,
    publish_dir: Path,
    common_files: list[Path],
    role_files: list[Path],
    prefix_override: str | None = None,
) -> list[Path]:
    """Copy real-subIP payload into per-SS sys folder with true node-id prefix expansion."""
    copied: list[Path] = []
    sources = [*common_files, *role_files]

    declared_syms: set[str] = set()
    decl_pat = re.compile(r"^\s*(module|package)\s+([A-Za-z_][A-Za-z0-9_]*)\b", re.MULTILINE)
    for src in sources:
        text = src.read_text()
        for _, sym in decl_pat.findall(text):
            declared_syms.add(sym)

    sym_order = sorted(declared_syms, key=len, reverse=True)
    node_id = prefix_override or node["node_id"]

    for src in sources:
        text = src.read_text()

        # Expand legacy macro naming into explicit node-local prefix names.
        text = re.sub(r"`_PREFIX_\(([^)]+)\)", lambda m: f"{node_id}_{m.group(1).strip()}", text)

        # Prefix all declared module/package symbols in this copied payload closure.
        for sym in sym_order:
            text = re.sub(rf"\b{re.escape(sym)}\b", f"{node_id}_{sym}", text)

        dst = (publish_dir / f"{node_id}_{src.name}").resolve()
        dst.write_text(text)
        copied.append(dst)

    return copied


def _emit_port_list_lines(topo_nodes=None):
    return _emit_port_list_lines_from_ports(_collect_boundary_ports(topo_nodes))


def _emit_port_list_lines_from_ports(ports):
    lines = []
    for idx, (direction, name, width) in enumerate(ports):
        comma = "," if idx < len(ports) - 1 else ""
        lines.append(f"  {direction} logic{_fmt_logic_width(width)} {name}{comma}")
    return lines


def _wire_valid(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_valid"


def _wire_data(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_data"


def _wire_atvalid(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atvalid"


def _wire_atready(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atready"


def _wire_atbytes(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atbytes"


def _wire_atdata(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atdata"


def _wire_atid(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atid"


def _wire_afvalid(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_afvalid"


def _wire_afready(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_afready"


def _wire_syncreq(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_syncreq"


def _wire_atwakeup(edge) -> str:
    return f"w_{edge['src']}_to_{edge['dst']}_atwakeup"


def _is_harden_dn_node(node_id: str) -> bool:
    # Per soc_atb_topo partition note:
    # harden-up: dsp_ss* -> left_funnel -> async_bridge_slv
    # harden-dn: async_bridge_mst -> right_funnel -> debug_tniu_ss + camera/mipi paths
    return node_id in {
        "camera_ss",
        "mipi_ss",
        "camera_funnel",
        "async_bridge_mst",
        "right_funnel",
        "debug_tniu_ss",
    }


def _node_clk_sig(node_id: str) -> str:
    return "clk_async" if _is_harden_dn_node(node_id) else "clk_core"


def _node_rst_sig(node_id: str) -> str:
    return "rst_async_n" if _is_harden_dn_node(node_id) else "rst_core_n"


def _node_index(nodes):
    return {n["node_id"]: n for n in nodes}


def _edge_index(edges):
    in_edges = {}
    out_edges = {}
    for e in edges:
        in_edges.setdefault(e["dst"], []).append(e)
        out_edges.setdefault(e["src"], []).append(e)
    return in_edges, out_edges


def _emit_wire_decl(lines, edge):
    width = int(edge["width"])
    lines.append(f"  logic {_wire_valid(edge)};")
    lines.append(f"  logic{_fmt_logic_width(width)} {_wire_data(edge)};")


def _emit_atb_edge_decl(lines, edge, data_w: int, id_w: int, bytes_w: int):
    lines.append(f"  logic {_wire_atvalid(edge)};")
    lines.append(f"  logic {_wire_atready(edge)};")
    lines.append(f"  logic [{bytes_w-1}:0] {_wire_atbytes(edge)};")
    lines.append(f"  logic [{data_w-1}:0] {_wire_atdata(edge)};")
    lines.append(f"  logic [{id_w-1}:0] {_wire_atid(edge)};")
    lines.append(f"  logic {_wire_afvalid(edge)};")
    lines.append(f"  logic {_wire_afready(edge)};")
    lines.append(f"  logic {_wire_syncreq(edge)};")
    lines.append(f"  logic {_wire_atwakeup(edge)};")


def _emit_single_stage_inst(lines, inst_name: str, node, in_edge, out_edge):
    module = node["param"]["module"]
    if node["kind"] == "atb_buffer":
        tie_off = "1'b1" if node["param"].get("tie_off") else "1'b0"
        lines.append(f"  {module} #(.DATA_W({in_edge['width']}), .TIE_OFF({tie_off})) {inst_name} (")
    elif node["kind"] == "atb_upsizer":
        lines.append(f"  {module} #(.IN_W({in_edge['width']}), .OUT_W({out_edge['width']})) {inst_name} (")
    else:
        lines.append(f"  {module} #(.DATA_W({in_edge['width']})) {inst_name} (")
    lines.append("    .clk(clk_core),")
    lines.append("    .rst_n(rst_core_n),")
    lines.append("    .in_valid(in_valid),")
    lines.append("    .in_data(in_data),")
    lines.append("    .out_valid(out_valid),")
    lines.append("    .out_data(out_data)")
    lines.append("  );")


def _emit_funnel_inst(lines, inst_name: str, in_edges, out_edge):
    input_num = len(in_edges)
    if input_num <= 3:
        module = "atb_funnel3"
        total_ports = 3
    else:
        module = "atb_funnel6"
        total_ports = 6
    lines.append(f"  {module} #(.DATA_W({out_edge['width']})) {inst_name} (")
    for i in range(total_ports):
        if i < input_num:
            lines.append(f"    .in{i}_valid(in{i}_valid), .in{i}_data(in{i}_data),")
        else:
            lines.append(f"    .in{i}_valid(1'b0), .in{i}_data({out_edge['width']}'b0),")
    lines.append("    .out_valid(out_valid),")
    lines.append("    .out_data(out_data)")
    lines.append("  );")


def _emit_top_node_inst(lines, node, in_edges, out_edges):
    node_id = node["node_id"]
    kind = node["kind"]
    if kind == "atb_funnel":
        lines.append(f"  // {node_id}: direct upstream atb_funnel; exposes full ATB protocol.")
        input_num = len(in_edges)
        id_w = 7
        bytes_w = 4
        data_w = 128
        lines.append(f"  logic [{input_num-1}:0] w_{node_id}_atvalids;")
        lines.append(f"  logic [{input_num-1}:0] w_{node_id}_afreadys;")
        lines.append(f"  logic [{input_num-1}:0][{id_w-1}:0] w_{node_id}_atids;")
        lines.append(f"  logic [{input_num-1}:0][{data_w-1}:0] w_{node_id}_atdatas;")
        lines.append(f"  logic [{input_num-1}:0][{bytes_w-1}:0] w_{node_id}_atbytess;")
        lines.append(f"  logic [{input_num-1}:0] w_{node_id}_atreadys;")
        lines.append(f"  logic [{input_num-1}:0] w_{node_id}_afvalids;")
        lines.append(f"  logic [{input_num-1}:0] w_{node_id}_syncreqs;")
        for idx, edge in enumerate(in_edges):
            lines.append(f"  assign w_{node_id}_atvalids[{idx}] = {_wire_atvalid(edge)};")
            lines.append(f"  assign w_{node_id}_afreadys[{idx}] = {_wire_afready(edge)};")
            lines.append(f"  assign w_{node_id}_atids[{idx}] = {_wire_atid(edge)};")
            lines.append(f"  assign w_{node_id}_atdatas[{idx}] = {_wire_atdata(edge)};")
            lines.append(f"  assign w_{node_id}_atbytess[{idx}] = {_wire_atbytes(edge)};")
            lines.append(f"  assign {_wire_atready(edge)} = w_{node_id}_atreadys[{idx}];")
            lines.append(f"  assign {_wire_afvalid(edge)} = w_{node_id}_afvalids[{idx}];")
            lines.append(f"  assign {_wire_syncreq(edge)} = w_{node_id}_syncreqs[{idx}];")
        lines.append(f"  atb_funnel #(.ATB_DATA_WIDTH({data_w}), .ATB_ID_WIDTH({id_w}), .N_ATB({input_num})) u_{node_id} (")
        lines.append(f"    .clk({_node_clk_sig(node_id)}),")
        lines.append(f"    .resetn({_node_rst_sig(node_id)}),")
        lines.append(f"    .pclkendbg({node_id}_pclkendbg),")
        lines.append(f"    .pseldbg({node_id}_pseldbg),")
        lines.append(f"    .penabledbg({node_id}_penabledbg),")
        lines.append(f"    .pwritedbg({node_id}_pwritedbg),")
        lines.append(f"    .paddrdbg31({node_id}_paddrdbg31),")
        lines.append(f"    .paddrdbg({node_id}_paddrdbg),")
        lines.append(f"    .pwdatadbg({node_id}_pwdatadbg),")
        lines.append(f"    .atvalids(w_{node_id}_atvalids),")
        lines.append(f"    .afreadys(w_{node_id}_afreadys),")
        lines.append(f"    .atids(w_{node_id}_atids),")
        lines.append(f"    .atdatas(w_{node_id}_atdatas),")
        lines.append(f"    .atbytess(w_{node_id}_atbytess),")
        lines.append(f"    .atreadym({_wire_atready(out_edges[0])}),")
        lines.append(f"    .afvalidm({_wire_afvalid(out_edges[0])}),")
        lines.append(f"    .syncreqm({_wire_syncreq(out_edges[0])}),")
        lines.append(f"    .atvalidm({_wire_atvalid(out_edges[0])}),")
        lines.append(f"    .afreadym({_wire_afready(out_edges[0])}),")
        lines.append(f"    .atidm({_wire_atid(out_edges[0])}),")
        lines.append(f"    .atdatam({_wire_atdata(out_edges[0])}),")
        lines.append(f"    .atbytesm({_wire_atbytes(out_edges[0])}),")
        lines.append(f"    .atreadys(w_{node_id}_atreadys),")
        lines.append(f"    .afvalids(w_{node_id}_afvalids),")
        lines.append(f"    .syncreqs(w_{node_id}_syncreqs),")
        lines.append(f"    .preadydbg({node_id}_preadydbg),")
        lines.append(f"    .pslverrdbg({node_id}_pslverrdbg),")
        lines.append(f"    .prdatadbg({node_id}_prdatadbg)")
        lines.append("  );")
    elif kind in {"atb_async_bridge_slv", "atb_async_bridge_mst"}:
        lines.append(f"  // {node_id}: direct upstream atb_async_bridge_top; exposes full ATB protocol.")
        id_w = 7
        bytes_w = 4
        data_w = 128
        if node_id == "async_bridge_mst":
            s_clk = "clk_async"
            m_clk = "clk_async"
        else:
            s_clk = "clk_core"
            m_clk = "clk_async"
        s_rst = "rst_async_n" if node_id == "async_bridge_mst" else "rst_core_n"
        lines.append(f"  atb_async_bridge_top #(.ATB_DATA_WIDTH({data_w}), .ATB_ID_WIDTH({id_w})) u_{node_id} (")
        lines.append(f"    .clk_atb_s({s_clk}),")
        lines.append(f"    .rstn_atb_s({s_rst}),")
        in_edge = in_edges[0]
        lines.append(f"    .s_atvalid({_wire_atvalid(in_edge)}),")
        lines.append(f"    .s_atready({_wire_atready(in_edge)}),")
        lines.append(f"    .s_atbytes({_wire_atbytes(in_edge)}),")
        lines.append(f"    .s_atdata({_wire_atdata(in_edge)}),")
        lines.append(f"    .s_atid({_wire_atid(in_edge)}),")
        lines.append(f"    .s_afvalid({_wire_afvalid(in_edge)}),")
        lines.append(f"    .s_afready({_wire_afready(in_edge)}),")
        lines.append(f"    .s_syncreq({_wire_syncreq(in_edge)}),")
        lines.append(f"    .s_atwakeup({_wire_atwakeup(in_edge)}),")
        lines.append("    .slv_full_zero(),")
        lines.append(f"    .clk_atb_m({m_clk}),")
        lines.append("    .rstn_atb_m(rst_async_n),")
        out_edge = out_edges[0]
        lines.append(f"    .m_atvalid({_wire_atvalid(out_edge)}),")
        lines.append(f"    .m_atready({_wire_atready(out_edge)}),")
        lines.append(f"    .m_atbytes({_wire_atbytes(out_edge)}),")
        lines.append(f"    .m_atdata({_wire_atdata(out_edge)}),")
        lines.append(f"    .m_atid({_wire_atid(out_edge)}),")
        lines.append(f"    .m_afvalid({_wire_afvalid(out_edge)}),")
        lines.append(f"    .m_afready({_wire_afready(out_edge)}),")
        lines.append(f"    .m_syncreq({_wire_syncreq(out_edge)}),")
        lines.append(f"    .m_atwakeup({_wire_atwakeup(out_edge)}),")
        lines.append("    .mst_full_zero(),")
        lines.append("    .mst_read_idle()")
        lines.append("  );")
    lines.append("")


def _clean_publish_root(build_root: Path, topo, flow: str):
    if not build_root.exists():
        return
    nodes = topo["nodes"]
    keep_dirs = {TOPO_ID}
    keep_dirs.update(_sys_publish_group_dir(node) for node in nodes if node["kind"] in {"atb_iniu", "atb_tniu"})
    if flow == "pd":
        keep_dirs.update({"atb_soc_harden_dn", "atb_soc_harden_up"})
    for child in build_root.iterdir():
        if child.is_dir() and child.name not in keep_dirs:
            shutil.rmtree(child)


def _gen_network_layer_sv(topo) -> str:
    nodes = topo["nodes"]
    edges = topo["edges"]
    in_edges, out_edges = _edge_index(edges)
    iniu_nodes = _boundary_nodes(nodes, "atb_iniu")
    tniu_nodes = _boundary_nodes(nodes, "atb_tniu")
    funnel_nodes = _boundary_nodes(nodes, "atb_funnel")

    data_w = 128
    id_w = 7
    bytes_w = 4

    lines = []
    lines.append("// ATB network layer assembly for noc-top publication.")
    lines.append(f"module {NETWORK_LAYER_ID} (")
    port_lines = [
        "  input logic clk_core,",
        "  input logic clk_async,",
        "  input logic rst_core_n,",
        "  input logic rst_async_n,",
    ]
    for node in iniu_nodes:
        nid = node["node_id"]
        port_lines += [
            f"  input  logic          {nid}_in_atvalid,",
            f"  input  logic [{bytes_w-1}:0]   {nid}_in_atbytes,",
            f"  input  logic [{data_w-1}:0] {nid}_in_atdata,",
            f"  input  logic [{id_w-1}:0]   {nid}_in_atid,",
            f"  input  logic          {nid}_in_afready,",
            f"  input  logic          {nid}_in_atwakeup,",
            f"  output logic          {nid}_out_atready,",
            f"  output logic          {nid}_out_afvalid,",
            f"  output logic          {nid}_out_syncreq,",
        ]
    for idx, node in enumerate(tniu_nodes):
        nid = node["node_id"]
        has_following_funnel_ports = len(funnel_nodes) > 0
        needs_comma = (idx < len(tniu_nodes) - 1) or has_following_funnel_ports
        port_lines += [
            f"  output logic          {nid}_out_atvalid,",
            f"  output logic [{bytes_w-1}:0]   {nid}_out_atbytes,",
            f"  output logic [{data_w-1}:0] {nid}_out_atdata,",
            f"  output logic [{id_w-1}:0]   {nid}_out_atid,",
            f"  output logic          {nid}_out_afready,",
            f"  output logic          {nid}_out_atwakeup,",
            f"  input  logic          {nid}_in_atready,",
            f"  input  logic          {nid}_in_afvalid,",
            f"  input  logic          {nid}_in_syncreq{',' if needs_comma else ''}",
        ]
    for idx, node in enumerate(funnel_nodes):
        nid = node["node_id"]
        last = (idx == len(funnel_nodes) - 1)
        port_lines += [
            f"  input  logic          {nid}_pclkendbg,",
            f"  input  logic          {nid}_pseldbg,",
            f"  input  logic          {nid}_penabledbg,",
            f"  input  logic          {nid}_pwritedbg,",
            f"  input  logic          {nid}_paddrdbg31,",
            f"  input  logic [9:0]    {nid}_paddrdbg,",
            f"  input  logic [31:0]   {nid}_pwdatadbg,",
            f"  output logic          {nid}_preadydbg,",
            f"  output logic          {nid}_pslverrdbg,",
            f"  output logic [31:0]   {nid}_prdatadbg{'  ' if last else ','}",
        ]
    lines.extend(port_lines)
    lines.append(");")
    lines.append("")
    lines.append("  // Topology edge wires: full ATB protocol per source-to-destination connection.")
    for edge in edges:
        _emit_atb_edge_decl(lines, edge, data_w=data_w, id_w=id_w, bytes_w=bytes_w)
    lines.append("")

    # INIU boundary: source-side ATB signals enter the network layer directly.
    for node in iniu_nodes:
        nid = node["node_id"]
        edge = out_edges[node["node_id"]][0]
        lines.append(f"  assign {_wire_atvalid(edge)} = {nid}_in_atvalid;")
        lines.append(f"  assign {_wire_atbytes(edge)} = {nid}_in_atbytes;")
        lines.append(f"  assign {_wire_atdata(edge)} = {nid}_in_atdata;")
        lines.append(f"  assign {_wire_atid(edge)} = {nid}_in_atid;")
        lines.append(f"  assign {_wire_afready(edge)} = {nid}_in_afready;")
        lines.append(f"  assign {_wire_atwakeup(edge)} = {nid}_in_atwakeup;")
        lines.append(f"  assign {nid}_out_atready = {_wire_atready(edge)};")
        lines.append(f"  assign {nid}_out_afvalid = {_wire_afvalid(edge)};")
        lines.append(f"  assign {nid}_out_syncreq = {_wire_syncreq(edge)};")

    # TNIU boundary: sink-side ATB signals leave the network layer directly.
    for node in tniu_nodes:
        nid = node["node_id"]
        edge = in_edges[node["node_id"]][0]
        lines.append(f"  assign {nid}_out_atvalid = {_wire_atvalid(edge)};")
        lines.append(f"  assign {nid}_out_atbytes = {_wire_atbytes(edge)};")
        lines.append(f"  assign {nid}_out_atdata = {_wire_atdata(edge)};")
        lines.append(f"  assign {nid}_out_atid = {_wire_atid(edge)};")
        lines.append(f"  assign {nid}_out_afready = {_wire_afready(edge)};")
        lines.append(f"  assign {nid}_out_atwakeup = {_wire_atwakeup(edge)};")
        lines.append(f"  assign {_wire_atready(edge)} = {nid}_in_atready;")
        lines.append(f"  assign {_wire_afvalid(edge)} = {nid}_in_afvalid;")
        lines.append(f"  assign {_wire_syncreq(edge)} = {nid}_in_syncreq;")
    lines.append("")

    lines.append("  // Generated topology instances")
    for node in nodes:
        node_id = node["node_id"]
        node_in = in_edges.get(node_id, [])
        node_out = out_edges.get(node_id, [])

        if node["kind"] in {"atb_iniu", "atb_tniu"}:
            continue
        if node["kind"] == "atb_funnel" and len(node_out) != 1:
            continue
        if node["kind"] not in {"atb_iniu", "atb_tniu", "atb_funnel"} and (len(node_in) != 1 or len(node_out) != 1):
            continue
        _emit_top_node_inst(lines, node, node_in, node_out)

    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _external_network_unit_files() -> list[Path]:
        files = [
                ATB_SUBIP_ROOT / "rtl" / "network" / "atb_if.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "atb_funnel_reg_blk.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "atb_funnel_arbiter.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "atb_funnel.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "network_atb_slv.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "network_atb_mst.sv",
                ATB_SUBIP_ROOT / "rtl" / "network" / "atb_async_bridge_top.sv",
        ]
        missing = [str(p) for p in files if not p.exists()]
        if missing:
                raise FileNotFoundError(
                        "Missing required external ATB network RTL files under ATB_SUBIP_ROOT:\n" + "\n".join(missing)
                )
        return [p.resolve() for p in files]


def _gen_network_compat_sv() -> str:
        return """`ifndef _PREFIX_
`define _PREFIX_(x) x
`endif

// Compatibility wrappers: keep legacy/simple network-layer instance interfaces
// while binding to lwnoc_atb_noc/rtl canonical modules.

module atb_async_bridge_slv #(
    parameter int DATA_W = 139,
    parameter int FIFO_DEPTH = 16,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              clk,
    input  logic              clk_async,
    input  logic              rst_n,
    input  logic              in_valid,
    input  logic [DATA_W-1:0] in_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [ATB_BYTES_W-1:0] s_atbytes;
    logic [ATB_ID_W-1:0]    s_atid;
    logic [ATB_DATA_W-1:0]  s_atdata;
    logic [ATB_BYTES_W-1:0] m_atbytes;
    logic [ATB_ID_W-1:0]    m_atid;
    logic [ATB_DATA_W-1:0]  m_atdata;
    logic                   m_atvalid;

    assign {s_atbytes, s_atid, s_atdata} = in_data;
    assign out_valid = m_atvalid;
    assign out_data = {m_atbytes, m_atid, m_atdata};

    atb_async_bridge_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W)
    ) u_async_bridge_top (
        .clk_atb_s(clk),
        .rstn_atb_s(rst_n),
        .s_atvalid(in_valid),
        .s_atready(),
        .s_atbytes(s_atbytes),
        .s_atdata(s_atdata),
        .s_atid(s_atid),
        .s_afvalid(),
        .s_afready(1'b1),
        .s_syncreq(),
        .s_atwakeup(1'b0),
        .slv_full_zero(),
        .clk_atb_m(clk_async),
        .rstn_atb_m(rst_n),
        .m_atvalid(m_atvalid),
        .m_atready(1'b1),
        .m_atbytes(m_atbytes),
        .m_atdata(m_atdata),
        .m_atid(m_atid),
        .m_afvalid(1'b0),
        .m_afready(),
        .m_syncreq(1'b0),
        .m_atwakeup(),
        .mst_full_zero(),
        .mst_read_idle()
    );
endmodule

module atb_async_bridge_mst #(
    parameter int DATA_W = 139,
    parameter int FIFO_DEPTH = 16,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              clk,
    input  logic              clk_async,
    input  logic              rst_n,
    input  logic              in_valid,
    input  logic [DATA_W-1:0] in_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [ATB_BYTES_W-1:0] s_atbytes;
    logic [ATB_ID_W-1:0]    s_atid;
    logic [ATB_DATA_W-1:0]  s_atdata;
    logic [ATB_BYTES_W-1:0] m_atbytes;
    logic [ATB_ID_W-1:0]    m_atid;
    logic [ATB_DATA_W-1:0]  m_atdata;
    logic                   m_atvalid;

    assign {s_atbytes, s_atid, s_atdata} = in_data;
    assign out_valid = m_atvalid;
    assign out_data = {m_atbytes, m_atid, m_atdata};

    atb_async_bridge_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W)
    ) u_async_bridge_top (
        .clk_atb_s(clk_async),
        .rstn_atb_s(rst_n),
        .s_atvalid(in_valid),
        .s_atready(),
        .s_atbytes(s_atbytes),
        .s_atdata(s_atdata),
        .s_atid(s_atid),
        .s_afvalid(),
        .s_afready(1'b1),
        .s_syncreq(),
        .s_atwakeup(1'b0),
        .slv_full_zero(),
        .clk_atb_m(clk),
        .rstn_atb_m(rst_n),
        .m_atvalid(m_atvalid),
        .m_atready(1'b1),
        .m_atbytes(m_atbytes),
        .m_atdata(m_atdata),
        .m_atid(m_atid),
        .m_afvalid(1'b0),
        .m_afready(),
        .m_syncreq(1'b0),
        .m_atwakeup(),
        .mst_full_zero(),
        .mst_read_idle()
    );
endmodule

module atb_funnel3 #(
    parameter int DATA_W = 139,
    parameter int N_ATB = 3,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              in0_valid,
    input  logic [DATA_W-1:0] in0_data,
    input  logic              in1_valid,
    input  logic [DATA_W-1:0] in1_data,
    input  logic              in2_valid,
    input  logic [DATA_W-1:0] in2_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [N_ATB-1:0] atvalids, afreadys, atreadys, afvalids, syncreqs;
    logic [N_ATB-1:0][ATB_ID_W-1:0] atids;
    logic [N_ATB-1:0][ATB_DATA_W-1:0] atdatas;
    logic [N_ATB-1:0][ATB_BYTES_W-1:0] atbytess;
    logic [ATB_ID_W-1:0] atidm;
    logic [ATB_DATA_W-1:0] atdatam;
    logic [ATB_BYTES_W-1:0] atbytesm;
    logic atvalidm;

    assign atvalids = {in2_valid, in1_valid, in0_valid};
    assign afreadys = '1;
    assign {atbytess[0], atids[0], atdatas[0]} = in0_data;
    assign {atbytess[1], atids[1], atdatas[1]} = in1_data;
    assign {atbytess[2], atids[2], atdatas[2]} = in2_data;
    assign out_valid = atvalidm;
    assign out_data = {atbytesm, atidm, atdatam};

    atb_funnel #(
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W),
        .N_ATB(N_ATB),
        .FIXED_CONFIGURATION(1'b1),
        .FIXED_HOLD_TIME(4'b0011)
    ) u_atb_funnel (
        .clk(1'b0),
        .resetn(1'b1),
        .pclkendbg(1'b0),
        .pseldbg(1'b0),
        .penabledbg(1'b0),
        .pwritedbg(1'b0),
        .paddrdbg31(1'b0),
        .paddrdbg('0),
        .pwdatadbg('0),
        .atvalids(atvalids),
        .afreadys(afreadys),
        .atids(atids),
        .atdatas(atdatas),
        .atbytess(atbytess),
        .atreadym(1'b1),
        .afvalidm(1'b0),
        .syncreqm(1'b0),
        .preadydbg(),
        .pslverrdbg(),
        .prdatadbg(),
        .atvalidm(atvalidm),
        .afreadym(),
        .atidm(atidm),
        .atdatam(atdatam),
        .atbytesm(atbytesm),
        .atreadys(atreadys),
        .afvalids(afvalids),
        .syncreqs(syncreqs)
    );
endmodule

module atb_funnel6 #(
    parameter int DATA_W = 139,
    parameter int N_ATB = 6,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              in0_valid,
    input  logic [DATA_W-1:0] in0_data,
    input  logic              in1_valid,
    input  logic [DATA_W-1:0] in1_data,
    input  logic              in2_valid,
    input  logic [DATA_W-1:0] in2_data,
    input  logic              in3_valid,
    input  logic [DATA_W-1:0] in3_data,
    input  logic              in4_valid,
    input  logic [DATA_W-1:0] in4_data,
    input  logic              in5_valid,
    input  logic [DATA_W-1:0] in5_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [N_ATB-1:0] atvalids, afreadys, atreadys, afvalids, syncreqs;
    logic [N_ATB-1:0][ATB_ID_W-1:0] atids;
    logic [N_ATB-1:0][ATB_DATA_W-1:0] atdatas;
    logic [N_ATB-1:0][ATB_BYTES_W-1:0] atbytess;
    logic [ATB_ID_W-1:0] atidm;
    logic [ATB_DATA_W-1:0] atdatam;
    logic [ATB_BYTES_W-1:0] atbytesm;
    logic atvalidm;

    assign atvalids = {in5_valid, in4_valid, in3_valid, in2_valid, in1_valid, in0_valid};
    assign afreadys = '1;
    assign {atbytess[0], atids[0], atdatas[0]} = in0_data;
    assign {atbytess[1], atids[1], atdatas[1]} = in1_data;
    assign {atbytess[2], atids[2], atdatas[2]} = in2_data;
    assign {atbytess[3], atids[3], atdatas[3]} = in3_data;
    assign {atbytess[4], atids[4], atdatas[4]} = in4_data;
    assign {atbytess[5], atids[5], atdatas[5]} = in5_data;
    assign out_valid = atvalidm;
    assign out_data = {atbytesm, atidm, atdatam};

    atb_funnel #(
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W),
        .N_ATB(N_ATB),
        .FIXED_CONFIGURATION(1'b1),
        .FIXED_HOLD_TIME(4'b0011)
    ) u_atb_funnel (
        .clk(1'b0),
        .resetn(1'b1),
        .pclkendbg(1'b0),
        .pseldbg(1'b0),
        .penabledbg(1'b0),
        .pwritedbg(1'b0),
        .paddrdbg31(1'b0),
        .paddrdbg('0),
        .pwdatadbg('0),
        .atvalids(atvalids),
        .afreadys(afreadys),
        .atids(atids),
        .atdatas(atdatas),
        .atbytess(atbytess),
        .atreadym(1'b1),
        .afvalidm(1'b0),
        .syncreqm(1'b0),
        .preadydbg(),
        .pslverrdbg(),
        .prdatadbg(),
        .atvalidm(atvalidm),
        .afreadym(),
        .atidm(atidm),
        .atdatam(atdatam),
        .atbytesm(atbytesm),
        .atreadys(atreadys),
        .afvalids(afvalids),
        .syncreqs(syncreqs)
    );
endmodule
"""


def _gen_top_sv(topo) -> str:
    nodes = topo["nodes"]
    iniu_nodes = _boundary_nodes(nodes, "atb_iniu")
    tniu_nodes = _boundary_nodes(nodes, "atb_tniu")
    funnel_nodes = _boundary_nodes(nodes, "atb_funnel")

    lines = []
    lines.append("// ATB SoC top-level publish wrapper.")
    lines.append("module atb_soc_topo (")
    # Boundary ports + timeout_val appended before closing paren
    boundary_ports = _collect_boundary_ports(nodes)
    for direction, name, width in boundary_ports:
        lines.append(f"  {direction} logic{_fmt_logic_width(width)} {name},")
    lines.append("  input  logic [9:0] timeout_val")
    lines.append(");")
    lines.append("")

    # Wire declarations: NOC aux wires (individual ATB signals per INIU/TNIU)
    for node in iniu_nodes:
        lines.extend(_emit_noc_aux_wire_decls(node))
    for node in tniu_nodes:
        lines.extend(_emit_noc_aux_wire_decls(node))
        lines.append(f"  logic w_{node['node_id']}_syncreq_level;")
        lines.append(f"  logic w_{node['node_id']}_flush_req_level;")
        lines.append(f"  logic [8:0] w_{node['node_id']}_lp_sys_to_noc;")
        lines.append(f"  logic [8:0] w_{node['node_id']}_lp_noc_to_sys;")
        lines.append(f"  logic [8:0] w_{node['node_id']}_lp_afifo_sys_to_noc;")
        lines.append(f"  logic [8:0] w_{node['node_id']}_lp_afifo_noc_to_sys;")
        lines.append(f"  logic [15:0] w_{node['node_id']}_wptr_async;")
        lines.append(f"  logic [15:0] w_{node['node_id']}_rptr_async;")
        lines.append(f"  logic [15:0] w_{node['node_id']}_rptr_sync;")
        lines.append(f"  logic [142:0] w_{node['node_id']}_pld_sync;")
    lines.append("")

    # INIU sys-side instances — no payload packing, just pass individual ATB signals through
    for node in iniu_nodes:
        module_name = _sys_module_name(node)
        sys_clk = f"{node['node_id']}_clk_sys"
        sys_rst = f"{node['node_id']}_rst_sys_n"
        inst_ports = [
            ("clk", sys_clk),
            ("rst_n", sys_rst),
            ("sys_atvalid", _sys_sig(node, "atvalid")),
            ("sys_atready", _sys_sig(node, "atready")),
            ("sys_atbytes", _sys_sig(node, "atbytes")),
            ("sys_atdata", _sys_sig(node, "atdata")),
            ("sys_atid", _sys_sig(node, "atid")),
            ("sys_afvalid", _sys_sig(node, "afvalid")),
            ("sys_afready", _sys_sig(node, "afready")),
            ("sys_syncreq", _sys_sig(node, "syncreq")),
            ("sys_atwakeup", _sys_sig(node, "atwakeup")),
            ("sys_preq", _sys_sig(node, "preq")),
            ("sys_pstate", _sys_sig(node, "pstate")),
            ("sys_pactive", _sys_sig(node, "pactive")),
            ("sys_paccept", _sys_sig(node, "paccept")),
            ("sys_pdeny", _sys_sig(node, "pdeny")),
            ("timeout_val", "timeout_val"),
            *_wrapper_noc_bindings(node),
        ]
        lines.extend(
            _sv_render_instance(
                module_name=module_name,
                inst_name=f"u_{node['node_id']}_sys_side",
                params=[("DATA_W", str(node["sys_data_w"]))],
                ports=inst_ports,
            )
        )
        lines.append("")

    # TNIU noc-side and sys-side instances — no payload unpacking in top
    for node in tniu_nodes:
        nid = node["node_id"]
        tniu_noc_clk = _node_clk_sig(nid)
        tniu_noc_rst = _node_rst_sig(nid)
        tniu_sys_clk = f"{nid}_clk_sys"
        tniu_sys_rst = f"{nid}_rst_sys_n"
        noc_inst_ports = [
            ("clk", tniu_noc_clk),
            ("rst_n", tniu_noc_rst),
            *_wrapper_noc_bindings(node),
            ("timeout_val", "timeout_val"),
            ("syncreq_level", f"w_{nid}_syncreq_level"),
            ("flush_req_level", f"w_{nid}_flush_req_level"),
            ("lp_sys_to_noc", f"w_{nid}_lp_sys_to_noc"),
            ("lp_noc_to_sys", f"w_{nid}_lp_noc_to_sys"),
            ("lp_afifo_sys_to_noc", f"w_{nid}_lp_afifo_sys_to_noc"),
            ("lp_afifo_noc_to_sys", f"w_{nid}_lp_afifo_noc_to_sys"),
            ("wptr_async", f"w_{nid}_wptr_async"),
            ("rptr_async", f"w_{nid}_rptr_async"),
            ("rptr_sync", f"w_{nid}_rptr_sync"),
            ("pld_sync", f"w_{nid}_pld_sync"),
        ]
        lines.extend(
            _sv_render_instance(
                module_name=_tniu_noc_module_name(node),
                inst_name=f"u_{nid}_noc_side",
                params=[("DATA_W", str(node["fabric_data_w"]))],
                ports=noc_inst_ports,
            )
        )
        lines.append("")

        lines.append(f"  {nid}_atb_tniu_sys #(.FIFO_DEPTH(16)) u_{nid}_sys_side (")
        lines.append(f"    .clk_atb_m({tniu_sys_clk}),")
        lines.append(f"    .rstn_atb_m({tniu_sys_rst}),")
        lines.append(f"    .m_atvalid({_sys_sig(node, 'atvalid')}),")
        lines.append(f"    .m_atready({_sys_sig(node, 'atready')}),")
        lines.append(f"    .m_atbytes({_sys_sig(node, 'atbytes')}),")
        lines.append(f"    .m_atdata({_sys_sig(node, 'atdata')}),")
        lines.append(f"    .m_atid({_sys_sig(node, 'atid')}),")
        lines.append(f"    .m_afvalid({_sys_sig(node, 'afvalid')}),")
        lines.append(f"    .m_afready({_sys_sig(node, 'afready')}),")
        lines.append(f"    .m_syncreq({_sys_sig(node, 'syncreq')}),")
        lines.append(f"    .m_atwakeup({_sys_sig(node, 'atwakeup')}),")
        lines.append(f"    .preq({_sys_sig(node, 'preq')}),")
        lines.append(f"    .pstate({_PSTATE_ENUM_TYPE}'({_sys_sig(node, 'pstate')})),")
        lines.append(f"    .pactive({_sys_sig(node, 'pactive')}),")
        lines.append(f"    .paccept({_sys_sig(node, 'paccept')}),")
        lines.append(f"    .pdeny({_sys_sig(node, 'pdeny')}),")
        lines.append(f"    .syncreq_level(w_{nid}_syncreq_level),")
        lines.append(f"    .flush_req_level(w_{nid}_flush_req_level),")
        lines.append(f"    .lw_rx_req(w_{nid}_lp_noc_to_sys),")
        lines.append(f"    .lw_tx_req(w_{nid}_lp_sys_to_noc),")
        lines.append(f"    .afifo_slv_rx_req(w_{nid}_lp_afifo_noc_to_sys),")
        lines.append(f"    .afifo_slv_tx_req(w_{nid}_lp_afifo_sys_to_noc),")
        lines.append(f"    .wptr_async(w_{nid}_wptr_async),")
        lines.append(f"    .rptr_async(w_{nid}_rptr_async),")
        lines.append(f"    .rptr_sync(w_{nid}_rptr_sync),")
        lines.append(f"    .pld_sync(w_{nid}_pld_sync),")
        lines.append("    .timeout_val(timeout_val)")
        lines.append("  );")
        lines.append("")

    # Network layer — no packing/unpacking in top; individual ATB signals pass through.
    # Reverse signals (atready/afvalid/syncreq) flow through network layer, not fan-out here.
    lines.append(f"  {NETWORK_LAYER_ID} u_{NETWORK_LAYER_ID} (")
    lines.append("    .clk_core(clk_core),")
    lines.append("    .clk_async(clk_async),")
    lines.append("    .rst_core_n(rst_core_n),")
    lines.append("    .rst_async_n(rst_async_n),")
    nl_ports = []
    for node in iniu_nodes:
        nid = node["node_id"]
        nl_ports += [
            f"    .{nid}_in_atvalid(w_{nid}_noc_atvalid),",
            f"    .{nid}_in_atbytes(w_{nid}_noc_atbytes),",
            f"    .{nid}_in_atdata(w_{nid}_noc_atdata),",
            f"    .{nid}_in_atid(w_{nid}_noc_atid),",
            f"    .{nid}_in_afready(w_{nid}_noc_afready),",
            f"    .{nid}_in_atwakeup(w_{nid}_noc_atwakeup),",
            f"    .{nid}_out_atready(w_{nid}_noc_atready),",
            f"    .{nid}_out_afvalid(w_{nid}_noc_afvalid),",
            f"    .{nid}_out_syncreq(w_{nid}_noc_syncreq),",
        ]
    for idx, node in enumerate(tniu_nodes):
        nid = node["node_id"]
        has_following_funnel_ports = len(funnel_nodes) > 0
        needs_comma = (idx < len(tniu_nodes) - 1) or has_following_funnel_ports
        nl_ports += [
            f"    .{nid}_out_atvalid(w_{nid}_noc_atvalid),",
            f"    .{nid}_out_atbytes(w_{nid}_noc_atbytes),",
            f"    .{nid}_out_atdata(w_{nid}_noc_atdata),",
            f"    .{nid}_out_atid(w_{nid}_noc_atid),",
            f"    .{nid}_out_afready(w_{nid}_noc_afready),",
            f"    .{nid}_out_atwakeup(w_{nid}_noc_atwakeup),",
            f"    .{nid}_in_atready(w_{nid}_noc_atready),",
            f"    .{nid}_in_afvalid(w_{nid}_noc_afvalid),",
            f"    .{nid}_in_syncreq(w_{nid}_noc_syncreq){',' if needs_comma else '  '}",
        ]
    for idx, node in enumerate(funnel_nodes):
        nid = node["node_id"]
        last = (idx == len(funnel_nodes) - 1)
        nl_ports += [
            f"    .{nid}_pclkendbg({nid}_pclkendbg),",
            f"    .{nid}_pseldbg({nid}_pseldbg),",
            f"    .{nid}_penabledbg({nid}_penabledbg),",
            f"    .{nid}_pwritedbg({nid}_pwritedbg),",
            f"    .{nid}_paddrdbg31({nid}_paddrdbg31),",
            f"    .{nid}_paddrdbg({nid}_paddrdbg),",
            f"    .{nid}_pwdatadbg({nid}_pwdatadbg),",
            f"    .{nid}_preadydbg({nid}_preadydbg),",
            f"    .{nid}_pslverrdbg({nid}_pslverrdbg),",
            f"    .{nid}_prdatadbg({nid}_prdatadbg){'  ' if last else ','}",
        ]
    lines.extend(nl_ports)
    lines.append("  );")
    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _gen_harden_wrap_sv(wrapper_name: str, child_name: str, topo) -> str:
    lines = []
    lines.append(f"module {wrapper_name} (")
    lines.extend(_emit_port_list_lines())
    lines.append("  input  logic [9:0] timeout_val")
    lines.append(");")
    lines.append(f"  {child_name} u_{child_name} (")
    ports = _collect_boundary_ports(topo["nodes"])
    for idx, (_, name, _) in enumerate(ports):
        comma = ","
        lines.append(f"    .{name}({name}){comma}")
    lines.append("    .timeout_val(timeout_val)")
    lines.append("  );")
    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _gen_pd_harden_dn_wrap_sv(topo) -> str:
    node_map = _node_index(topo["nodes"])
    down_iniu_nodes = [node_map["camera_ss"], node_map["mipi_ss"]]
    tniu_node = node_map["debug_tniu_ss"]
    bridge_width = int(node_map["async_bridge_mst"]["fabric_data_w"])
    ports = _collect_boundary_ports_for_node_dicts([*down_iniu_nodes, tniu_node])
    ports.extend([
        ("input", "harden_up_valid", 1),
        ("input", "harden_up_data", bridge_width),
        ("input", "timeout_val", 10),
    ])

    lines = []
    lines.append("// PD harden-down partition: camera/mipi INIU delivery, async bridge mst, right-side funnels, and debug TNIU.")
    lines.append("module atb_soc_harden_dn_wrap (")
    lines.extend(_emit_port_list_lines_from_ports(ports))
    lines.append(");")
    lines.append("")

    for node in down_iniu_nodes:
        lines.append(f"  logic w_{node['node_id']}_sys_valid;")
        lines.append(f"  logic{_fmt_logic_width(node['sys_data_w'])} w_{node['node_id']}_sys_data;")
        lines.append(f"  logic w_{node['node_id']}_noc_valid;")
        lines.append(f"  logic{_fmt_logic_width(node['fabric_data_w'])} w_{node['node_id']}_noc_data;")
        lines.extend(_emit_noc_aux_wire_decls(node))
    lines.append(f"  logic w_{tniu_node['node_id']}_noc_valid;")
    lines.append(f"  logic{_fmt_logic_width(tniu_node['fabric_data_w'])} w_{tniu_node['node_id']}_noc_data;")
    lines.extend(_emit_noc_aux_wire_decls(tniu_node))
    lines.append(f"  logic w_{tniu_node['node_id']}_sys_valid;")
    lines.append(f"  logic{_fmt_logic_width(tniu_node['sys_data_w'])} w_{tniu_node['node_id']}_sys_data;")
    lines.append(f"  logic w_{tniu_node['node_id']}_syncreq_level;")
    lines.append(f"  logic w_{tniu_node['node_id']}_flush_req_level;")
    lines.append(f"  logic [8:0] w_{tniu_node['node_id']}_lp_sys_to_noc;")
    lines.append(f"  logic [8:0] w_{tniu_node['node_id']}_lp_noc_to_sys;")
    lines.append(f"  logic [8:0] w_{tniu_node['node_id']}_lp_afifo_sys_to_noc;")
    lines.append(f"  logic [8:0] w_{tniu_node['node_id']}_lp_afifo_noc_to_sys;")
    lines.append(f"  logic [15:0] w_{tniu_node['node_id']}_wptr_async;")
    lines.append(f"  logic [15:0] w_{tniu_node['node_id']}_rptr_async;")
    lines.append(f"  logic [15:0] w_{tniu_node['node_id']}_rptr_sync;")
    lines.append(f"  logic [142:0] w_{tniu_node['node_id']}_pld_sync;")
    lines.append("  logic w_camera_funnel_valid;")
    lines.append(f"  logic{_fmt_logic_width(bridge_width)} w_camera_funnel_data;")
    lines.append("  logic w_async_bridge_mst_valid;")
    lines.append(f"  logic{_fmt_logic_width(bridge_width)} w_async_bridge_mst_data;")
    lines.append("")

    for node in down_iniu_nodes:
        module_name = _sys_module_name(node)
        node_clk = f"{node['node_id']}_clk_sys"
        node_rst = f"{node['node_id']}_rst_sys_n"
        inst_ports = [
            ("clk", node_clk),
            ("rst_n", node_rst),
            ("sys_atvalid", _sys_sig(node, "atvalid")),
            ("sys_atready", _sys_sig(node, "atready")),
            ("sys_atbytes", _sys_sig(node, "atbytes")),
            ("sys_atdata", _sys_sig(node, "atdata")),
            ("sys_atid", _sys_sig(node, "atid")),
            ("sys_afvalid", _sys_sig(node, "afvalid")),
            ("sys_afready", _sys_sig(node, "afready")),
            ("sys_syncreq", _sys_sig(node, "syncreq")),
            ("sys_atwakeup", _sys_sig(node, "atwakeup")),
            ("sys_preq", _sys_sig(node, "preq")),
            ("sys_pstate", _sys_sig(node, "pstate")),
            ("sys_pactive", _sys_sig(node, "pactive")),
            ("sys_paccept", _sys_sig(node, "paccept")),
            ("sys_pdeny", _sys_sig(node, "pdeny")),
            ("timeout_val", "timeout_val"),
            *_wrapper_noc_bindings(node),
        ]
        lines.extend(
            _sv_render_instance(
                module_name=module_name,
                inst_name=f"u_{node['node_id']}_sys_side",
                params=[("DATA_W", str(node["sys_data_w"]))],
                ports=inst_ports,
            )
        )
        _emit_iniu_payload_bridge(lines, node)
        lines.append("")

    lines.append(f"  atb_async_bridge_mst #(.DATA_W({bridge_width})) u_async_bridge_mst (")
    lines.append("    .clk(clk_async),")
    lines.append("    .clk_async(clk_async),")
    lines.append("    .rst_n(rst_async_n),")
    lines.append("    .in_valid(harden_up_valid),")
    lines.append("    .in_data(harden_up_data),")
    lines.append("    .out_valid(w_async_bridge_mst_valid),")
    lines.append("    .out_data(w_async_bridge_mst_data)")
    lines.append("  );")
    lines.append("")

    lines.append(f"  atb_funnel3 #(.DATA_W({bridge_width})) u_camera_funnel (")
    lines.append("    .in0_valid(w_camera_ss_noc_valid), .in0_data(w_camera_ss_noc_data),")
    lines.append("    .in1_valid(w_mipi_ss_noc_valid), .in1_data(w_mipi_ss_noc_data),")
    lines.append(f"    .in2_valid(1'b0), .in2_data({bridge_width}'b0),")
    lines.append("    .out_valid(w_camera_funnel_valid),")
    lines.append("    .out_data(w_camera_funnel_data)")
    lines.append("  );")
    lines.append("")

    lines.append(f"  atb_funnel3 #(.DATA_W({bridge_width})) u_right_funnel (")
    lines.append("    .in0_valid(w_async_bridge_mst_valid), .in0_data(w_async_bridge_mst_data),")
    lines.append("    .in1_valid(w_camera_funnel_valid), .in1_data(w_camera_funnel_data),")
    lines.append(f"    .in2_valid(1'b0), .in2_data({bridge_width}'b0),")
    lines.append(f"    .out_valid(w_{tniu_node['node_id']}_noc_valid),")
    lines.append(f"    .out_data(w_{tniu_node['node_id']}_noc_data)")
    lines.append("  );")
    lines.append("")

    _emit_tniu_payload_defaults(lines, tniu_node)
    lines.extend(
        _sv_render_instance(
            module_name=_tniu_noc_module_name(tniu_node),
            inst_name=f"u_{tniu_node['node_id']}_noc_side",
            params=[("DATA_W", str(tniu_node["fabric_data_w"]))],
            ports=[
                ("clk", _node_clk_sig(tniu_node["node_id"])),
                ("rst_n", _node_rst_sig(tniu_node["node_id"])),
                *_wrapper_noc_bindings(tniu_node),
                ("timeout_val", "timeout_val"),
                ("syncreq_level", f"w_{tniu_node['node_id']}_syncreq_level"),
                ("flush_req_level", f"w_{tniu_node['node_id']}_flush_req_level"),
                ("lp_sys_to_noc", f"w_{tniu_node['node_id']}_lp_sys_to_noc"),
                ("lp_noc_to_sys", f"w_{tniu_node['node_id']}_lp_noc_to_sys"),
                ("lp_afifo_sys_to_noc", f"w_{tniu_node['node_id']}_lp_afifo_sys_to_noc"),
                ("lp_afifo_noc_to_sys", f"w_{tniu_node['node_id']}_lp_afifo_noc_to_sys"),
                ("wptr_async", f"w_{tniu_node['node_id']}_wptr_async"),
                ("rptr_async", f"w_{tniu_node['node_id']}_rptr_async"),
                ("rptr_sync", f"w_{tniu_node['node_id']}_rptr_sync"),
                ("pld_sync", f"w_{tniu_node['node_id']}_pld_sync"),
            ],
        )
    )
    lines.append("")

    lines.append(f"  {tniu_node['node_id']}_atb_tniu_sys #(.FIFO_DEPTH(16)) u_{tniu_node['node_id']}_sys_side (")
    lines.append(f"    .clk_atb_m({tniu_node['node_id']}_clk_sys),")
    lines.append(f"    .rstn_atb_m({tniu_node['node_id']}_rst_sys_n),")
    lines.append(f"    .m_atvalid({_sys_sig(tniu_node, 'atvalid')}),")
    lines.append(f"    .m_atready({_sys_sig(tniu_node, 'atready')}),")
    lines.append(f"    .m_atbytes({_sys_sig(tniu_node, 'atbytes')}),")
    lines.append(f"    .m_atdata({_sys_sig(tniu_node, 'atdata')}),")
    lines.append(f"    .m_atid({_sys_sig(tniu_node, 'atid')}),")
    lines.append(f"    .m_afvalid({_sys_sig(tniu_node, 'afvalid')}),")
    lines.append(f"    .m_afready({_sys_sig(tniu_node, 'afready')}),")
    lines.append(f"    .m_syncreq({_sys_sig(tniu_node, 'syncreq')}),")
    lines.append(f"    .m_atwakeup({_sys_sig(tniu_node, 'atwakeup')}),")
    lines.append(f"    .preq({_sys_sig(tniu_node, 'preq')}),")
    lines.append(f"    .pstate({_PSTATE_ENUM_TYPE}'({_sys_sig(tniu_node, 'pstate')})),")
    lines.append(f"    .pactive({_sys_sig(tniu_node, 'pactive')}),")
    lines.append(f"    .paccept({_sys_sig(tniu_node, 'paccept')}),")
    lines.append(f"    .pdeny({_sys_sig(tniu_node, 'pdeny')}),")
    lines.append(f"    .syncreq_level(w_{tniu_node['node_id']}_syncreq_level),")
    lines.append(f"    .flush_req_level(w_{tniu_node['node_id']}_flush_req_level),")
    lines.append(f"    .lw_rx_req(w_{tniu_node['node_id']}_lp_noc_to_sys),")
    lines.append(f"    .lw_tx_req(w_{tniu_node['node_id']}_lp_sys_to_noc),")
    lines.append(f"    .afifo_slv_rx_req(w_{tniu_node['node_id']}_lp_afifo_noc_to_sys),")
    lines.append(f"    .afifo_slv_tx_req(w_{tniu_node['node_id']}_lp_afifo_sys_to_noc),")
    lines.append(f"    .wptr_async(w_{tniu_node['node_id']}_wptr_async),")
    lines.append(f"    .rptr_async(w_{tniu_node['node_id']}_rptr_async),")
    lines.append(f"    .rptr_sync(w_{tniu_node['node_id']}_rptr_sync),")
    lines.append(f"    .pld_sync(w_{tniu_node['node_id']}_pld_sync),")
    lines.append("    .timeout_val(timeout_val)")
    lines.append("  );")
    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _gen_pd_harden_up_wrap_sv(topo) -> str:
    node_map = _node_index(topo["nodes"])
    dsp_nodes = [node_map[f"dsp_ss{i}"] for i in range(6)]
    down_nodes = [node_map["camera_ss"], node_map["mipi_ss"], node_map["debug_tniu_ss"]]
    bridge_width = int(node_map["async_bridge_slv"]["fabric_data_w"])
    funnel_module = "atb_funnel3" if len(dsp_nodes) <= 3 else "atb_funnel6"
    funnel_port_count = 3 if len(dsp_nodes) <= 3 else 6

    lines = []
    lines.append("// PD harden-up partition: DSP INIU delivery, left funnel, async bridge slv, and handoff into harden-down.")
    lines.append("module atb_soc_harden_up_wrap (")
    port_lines = _emit_port_list_lines(topo["nodes"])
    if port_lines:
        port_lines[-1] = f"{port_lines[-1]},"
    lines.extend(port_lines)
    lines.append("  input  logic [9:0] timeout_val")
    lines.append(");")
    lines.append("")

    for node in dsp_nodes:
        lines.append(f"  logic w_{node['node_id']}_sys_valid;")
        lines.append(f"  logic{_fmt_logic_width(node['sys_data_w'])} w_{node['node_id']}_sys_data;")
        lines.append(f"  logic w_{node['node_id']}_noc_valid;")
        lines.append(f"  logic{_fmt_logic_width(node['fabric_data_w'])} w_{node['node_id']}_noc_data;")
        lines.extend(_emit_noc_aux_wire_decls(node))
    lines.append("  logic w_left_funnel_valid;")
    lines.append(f"  logic{_fmt_logic_width(bridge_width)} w_left_funnel_data;")
    lines.append("  logic w_harden_up_valid;")
    lines.append(f"  logic{_fmt_logic_width(bridge_width)} w_harden_up_data;")
    lines.append("")

    for node in dsp_nodes:
        module_name = _sys_module_name(node)
        node_clk = f"{node['node_id']}_clk_sys"
        node_rst = f"{node['node_id']}_rst_sys_n"
        inst_ports = [
            ("clk", node_clk),
            ("rst_n", node_rst),
            ("sys_atvalid", _sys_sig(node, "atvalid")),
            ("sys_atready", _sys_sig(node, "atready")),
            ("sys_atbytes", _sys_sig(node, "atbytes")),
            ("sys_atdata", _sys_sig(node, "atdata")),
            ("sys_atid", _sys_sig(node, "atid")),
            ("sys_afvalid", _sys_sig(node, "afvalid")),
            ("sys_afready", _sys_sig(node, "afready")),
            ("sys_syncreq", _sys_sig(node, "syncreq")),
            ("sys_atwakeup", _sys_sig(node, "atwakeup")),
            ("sys_preq", _sys_sig(node, "preq")),
            ("sys_pstate", _sys_sig(node, "pstate")),
            ("sys_pactive", _sys_sig(node, "pactive")),
            ("sys_paccept", _sys_sig(node, "paccept")),
            ("sys_pdeny", _sys_sig(node, "pdeny")),
            ("timeout_val", "timeout_val"),
            *_wrapper_noc_bindings(node),
        ]
        lines.extend(
            _sv_render_instance(
                module_name=module_name,
                inst_name=f"u_{node['node_id']}_sys_side",
                params=[("DATA_W", str(node["sys_data_w"]))],
                ports=inst_ports,
            )
        )
        _emit_iniu_payload_bridge(lines, node)
        lines.append("")

    lines.append(f"  {funnel_module} #(.DATA_W({bridge_width})) u_left_funnel (")
    for idx in range(funnel_port_count):
        if idx < len(dsp_nodes):
            node = dsp_nodes[idx]
            lines.append(f"    .in{idx}_valid(w_{node['node_id']}_noc_valid), .in{idx}_data(w_{node['node_id']}_noc_data),")
        else:
            lines.append(f"    .in{idx}_valid(1'b0), .in{idx}_data({bridge_width}'b0),")
    lines.append("    .out_valid(w_left_funnel_valid),")
    lines.append("    .out_data(w_left_funnel_data)")
    lines.append("  );")
    lines.append("")

    lines.append(f"  atb_async_bridge_slv #(.DATA_W({bridge_width})) u_async_bridge_slv (")
    lines.append("    .clk(clk_core),")
    lines.append("    .clk_async(clk_async),")
    lines.append("    .rst_n(rst_core_n),")
    lines.append("    .in_valid(w_left_funnel_valid),")
    lines.append("    .in_data(w_left_funnel_data),")
    lines.append("    .out_valid(w_harden_up_valid),")
    lines.append("    .out_data(w_harden_up_data)")
    lines.append("  );")
    lines.append("")

    lines.append("  atb_soc_harden_dn_wrap u_atb_soc_harden_dn_wrap (")
    lines.append("    .clk_core(clk_core),")
    lines.append("    .clk_async(clk_async),")
    lines.append("    .rst_core_n(rst_core_n),")
    lines.append("    .rst_async_n(rst_async_n),")
    for node in down_nodes:
        lines.append(f"    .{node['node_id']}_clk_sys({node['node_id']}_clk_sys),")
        lines.append(f"    .{node['node_id']}_rst_sys_n({node['node_id']}_rst_sys_n),")
        iface_name = "sys_in" if node["kind"] == "atb_iniu" else "sys_out"
        for port in node["interfaces"][iface_name]:
            lines.append(f"    .{port['name']}({port['name']}),")
    lines.append("    .timeout_val(timeout_val),")
    lines.append("    .harden_up_valid(w_harden_up_valid),")
    lines.append("    .harden_up_data(w_harden_up_data)")
    lines.append("  );")
    lines.append("endmodule")
    lines.append("")
    return "\n".join(lines)


def _publish_filelists(build_root: Path, build_top_dir: Path, topo, flow: str):
    nodes = topo["nodes"]
    compat_dst = (build_top_dir / "atb_network_compat.sv").resolve()
    top_sv = (build_top_dir / "atb_soc_topo.v").resolve()
    network_sv = (build_top_dir / f"{NETWORK_LAYER_ID}.v").resolve()
    if flow == "pd":
        harden_dn_dir = (build_root / "atb_soc_harden_dn").resolve()
        harden_up_dir = (build_root / "atb_soc_harden_up").resolve()
        harden_dn_dir.mkdir(parents=True, exist_ok=True)
        harden_up_dir.mkdir(parents=True, exist_ok=True)
        harden_dn_sv = (harden_dn_dir / "atb_soc_harden_dn_wrap.v").resolve()
        harden_up_sv = (harden_up_dir / "atb_soc_harden_up_wrap.v").resolve()
    else:
        harden_dn_sv = (build_top_dir / "atb_soc_harden_dn_wrap.v").resolve()
        harden_up_sv = (build_top_dir / "atb_soc_harden_up_wrap.v").resolve()

    # Keep compat wrappers for helper cells used by PD wrappers (atb_funnel3/6, atb_async_bridge_*).
    compat_dst.write_text(_gen_network_compat_sv())
    external_network_units = _external_network_unit_files()

    flat_real_subip = _build_real_subip_expanded_list()
    common_files, iniu_sys_only, iniu_noc_only, tniu_sys_only, tniu_noc_only = _split_atb_subip_files(flat_real_subip)

    grouped_nodes: dict[str, list[dict]] = {}
    for node in nodes:
        if node["kind"] not in {"atb_iniu", "atb_tniu"}:
            continue
        group = _sys_publish_group_dir(node)
        grouped_nodes.setdefault(group, []).append(node)

    sys_filelists = []
    for group_name, group_nodes in grouped_nodes.items():
        publish_dir = build_root / group_name
        publish_dir.mkdir(parents=True, exist_ok=True)
        for child in list(publish_dir.iterdir()):
            if child.is_dir():
                shutil.rmtree(child)
            else:
                child.unlink()

        group_sys_svs: list[Path] = []
        group_payload: list[Path] = []

        for node in group_nodes:
            if node["kind"] == "atb_iniu":
                sys_sv = (publish_dir / f"{_sys_module_name(node)}.sv").resolve()
                sys_sv.write_text(_gen_real_iniu_sys_wrapper(node))
                group_sys_svs.append(sys_sv)

            role_files = iniu_sys_only if node["kind"] == "atb_iniu" else tniu_sys_only
            group_payload.extend(_materialize_prefixed_sys_payload(node, publish_dir, common_files, role_files))

        # Keep expanded list as a review artifact: wrappers + localized role payload.
        expanded = publish_dir / "expanded_filelist.f"
        expanded.write_text("\n".join([*(str(p) for p in group_sys_svs), *(str(p) for p in group_payload)]) + "\n")

        compile_only = publish_dir / "compile_filelist.f"
        compile_items = [*group_sys_svs, *group_payload]
        compile_only.write_text("\n".join(str(p) for p in compile_items) + "\n")

        group_filelist = publish_dir / "filelist.f"
        group_filelist.write_text(f"-f {compile_only.resolve()}\n")

        for node in group_nodes:
            local_name = f"{node['node_id']}_{'iniu' if node['kind'] == 'atb_iniu' else 'tniu'}_filelist.f"
            local_filelist = publish_dir / local_name
            local_filelist.write_text(f"-f {compile_only.resolve()}\n")
            if len(group_nodes) == 1:
                sys_filelists.append(local_filelist.resolve())

        if len(group_nodes) > 1:
            sys_filelists.append(group_filelist.resolve())

    iniu_top_payload: list[Path] = []
    for node in nodes:
        if node["kind"] != "atb_iniu":
            continue
        iniu_top_payload.extend(_materialize_prefixed_sys_payload(node, build_top_dir, [], iniu_noc_only))

    tniu_top_side_svs: list[Path] = []
    tniu_top_payload: list[Path] = []
    for node in nodes:
        if node["kind"] != "atb_tniu":
            continue
        tniu_top_payload.extend(_materialize_prefixed_sys_payload(node, build_top_dir, [], tniu_noc_only))
        noc_sv = (build_top_dir / f"{_tniu_noc_module_name(node)}.v").resolve()
        noc_sv.write_text(_gen_real_tniu_noc_wrapper(node))
        tniu_top_side_svs.append(noc_sv)

    if flow == "pd":
        harden_dn_sv.write_text(_gen_pd_harden_dn_wrap_sv(topo))
        harden_up_sv.write_text(_gen_pd_harden_up_wrap_sv(topo))
    else:
        harden_dn_sv.write_text(_gen_harden_wrap_sv("atb_soc_harden_dn_wrap", "atb_soc_topo", topo))
        harden_up_sv.write_text(_gen_harden_wrap_sv("atb_soc_harden_up_wrap", "atb_soc_harden_dn_wrap", topo))

    real_subip_expanded = build_top_dir / "real_subip_expanded.f"
    real_subip_expanded.write_text("\n".join(flat_real_subip) + "\n")

    expanded_filelist = build_top_dir / "expanded_filelist.f"
    expanded_lines = [
        str(compat_dst),
        *(str(p) for p in external_network_units),
        str(network_sv),
        *(str(p) for p in iniu_top_payload),
        *(str(p) for p in tniu_top_payload),
        *(str(p) for p in tniu_top_side_svs),
        str(top_sv),
    ]
    expanded_filelist.write_text("\n".join(expanded_lines) + "\n")

    generated_filelist = build_top_dir / "filelist.f"
    filelist_lines = [
        f"-f {real_subip_expanded.resolve()}",
        *(f"-f {path}" for path in sys_filelists),
        f"-f {expanded_filelist.resolve()}",
    ]
    generated_filelist.write_text("\n".join(filelist_lines) + "\n")

    harden_filelist = build_top_dir / "filelist_harden.f"
    if flow == "pd":
        harden_dn_filelist = harden_dn_sv.parent / "filelist.f"
        harden_dn_filelist.write_text("\n".join([f"-f {generated_filelist.resolve()}", str(harden_dn_sv)]) + "\n")
        harden_up_filelist = harden_up_sv.parent / "filelist.f"
        harden_up_filelist.write_text("\n".join([f"-f {harden_dn_filelist.resolve()}", str(harden_up_sv)]) + "\n")
        harden_filelist.write_text(f"-f {harden_up_filelist.resolve()}\n")
    else:
        harden_lines = [
            f"-f {generated_filelist.resolve()}",
            str(harden_dn_sv),
            str(harden_up_sv),
        ]
        harden_filelist.write_text("\n".join(harden_lines) + "\n")

    filelist_dir = THIS_DIR / ("filelist" if flow == "dv" else "filelist_pd")
    filelist_dir.mkdir(parents=True, exist_ok=True)

    top_filelist = filelist_dir / f"{TOPO_ID}.f"
    top_filelist.write_text(f"-f {(build_top_dir / 'filelist.f').resolve()}\n")

    if flow == "dv":
        compile_entry = filelist_dir / "filelist.f"
        compile_entry.write_text(f"-f {top_filelist.resolve()}\n")
    else:
        harden_entry = filelist_dir / "filelist_harden.f"
        harden_entry.write_text(f"-f {(build_top_dir / 'filelist_harden.f').resolve()}\n")
        compile_entry = filelist_dir / "filelist.f"
        compile_entry.write_text(f"-f {harden_entry.resolve()}\n")


def generate(flow: str = "dv"):
    if flow not in {"dv", "pd"}:
        raise ValueError(f"Unsupported flow '{flow}', expected dv or pd")

    _ensure_dirs()

    topology_json = THIS_DIR / ("soc_atb_logic_topology.json" if flow == "dv" else "soc_atb_logic_topology_pd.json")
    write_topology_json(topology_json)
    uhdl_plan_json = THIS_DIR / ("soc_atb_uhdl_component_plan.json" if flow == "dv" else "soc_atb_uhdl_component_plan_pd.json")
    write_uhdl_migration_plan(uhdl_plan_json)

    topo = build_topology_dict()
    build_root = THIS_DIR / ("build_logic" if flow == "dv" else "build_logic_pd")
    _clean_publish_root(build_root, topo, flow)

    build_top_dir = build_root / TOPO_ID
    build_top_dir.mkdir(parents=True, exist_ok=True)

    top_sv = build_top_dir / f"{TOPO_ID}.v"
    top_sv.write_text(_gen_top_sv(topo))
    network_sv = build_top_dir / f"{NETWORK_LAYER_ID}.v"
    network_sv.write_text(_gen_network_layer_sv(topo))

    _publish_filelists(build_root, build_top_dir, topo, flow)

    print(f"Topology JSON written to {topology_json}")
    print(f"UHDL migration plan written to {uhdl_plan_json}")
    print(f"Generated RTL written to {build_root}")
    print(f"Top filelist written to {(THIS_DIR / ('filelist' if flow == 'dv' else 'filelist_pd') / 'filelist.f')}")


if __name__ == "__main__":
    generate("dv")

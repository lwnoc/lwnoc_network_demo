#!/usr/bin/env python3
from pathlib import Path
import re
from collections import Counter

ROOT = Path(__file__).resolve().parents[2]
DUT_PATH = ROOT / "build_logic/dti_logic_topo/dti_logic_topo.v"
TB_PATH = ROOT / "sim/tb_dti_route.sv"


def strip_comments(text):
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    return re.sub(r"//.*", "", text)


def parse_dut_ports(text):
    clean = strip_comments(text)
    match = re.search(r"\bmodule\s+dti_logic_topo\s*\((.*?)\);", clean, re.S)
    if not match:
        raise RuntimeError("cannot find dti_logic_topo module header")
    ports = []
    for raw in match.group(1).split(","):
        line = " ".join(raw.split())
        if not line:
            continue
        port_match = re.match(
            r"(input|output|inout)\s+(?:wire\s+|logic\s+|reg\s+)?(\[[^\]]+\]\s*)?([A-Za-z_][A-Za-z0-9_$]*)$",
            line,
        )
        if not port_match:
            ports.append({"dir": "UNPARSED", "width": "", "name": line})
            continue
        direction, width, name = port_match.groups()
        ports.append({"dir": direction, "width": (width or "").strip(), "name": name})
    return ports


def parse_dut_connections(text):
    clean = strip_comments(text)
    match = re.search(r"\bdti_logic_topo\s+dut\s*\((.*?)\n\s*\);", clean, re.S)
    if not match:
        raise RuntimeError("cannot find dti_logic_topo dut instantiation")
    conns = {}
    for conn in re.finditer(r"\.([A-Za-z_][A-Za-z0-9_$]*)\s*\(\s*([^()]*?)\s*\)\s*,?", match.group(1), re.S):
        conns[conn.group(1)] = " ".join(conn.group(2).split())
    return conns


def parse_tb_decls(text):
    clean = strip_comments(text)
    decls = {}
    pattern = re.compile(
        r"^\s*(reg|wire|logic)\s+((?:\[[^\]]+\]\s*)?)([A-Za-z_][A-Za-z0-9_$]*)(?:\s*=\s*[^;]+)?\s*(\[[^\]]+\])?\s*;",
        re.M,
    )
    for match in pattern.finditer(clean):
        kind, width, name, array = match.groups()
        line = match.group(0).strip()
        decls[name] = {"kind": kind, "width": (width or "").strip(), "array": (array or "").strip(), "line": line}
    return decls


def expr_base(expr):
    expr = expr.strip()
    if re.match(r"^\d*'", expr) or re.match(r"^\d+$", expr):
        return None
    match = re.match(r"([A-Za-z_][A-Za-z0-9_$]*)(?:\[[^\]]+\])?$", expr)
    return match.group(1) if match else None


def is_const(expr):
    expr = expr.strip()
    return bool(re.match(r"^\d*'[bdhoxzBDHOXZ][0-9a-fA-F_xzXZ]+$", expr) or re.match(r"^\d+$", expr))


def width_bits(width):
    width = width.strip()
    if not width:
        return 1
    match = re.match(r"\[(\d+)\s*:\s*(\d+)\]", width)
    if not match:
        return None
    high, low = [int(value) for value in match.groups()]
    return abs(high - low) + 1


def collect_drivers(text):
    clean = strip_comments(text)
    drivers = []
    for match in re.finditer(r"\bassign\s+([A-Za-z_][A-Za-z0-9_$]*(?:\[[^\]]+\])?)\s*=", clean):
        drivers.append((expr_base(match.group(1)), "assign", match.group(1)))
    for match in re.finditer(r"(?<![A-Za-z0-9_$])([A-Za-z_][A-Za-z0-9_$]*(?:\[[^\]]+\])?)\s*(?:<=|=)\s*", clean):
        prefix = clean[max(0, match.start() - 16):match.start()]
        if re.search(r"\b(assign|force)\s+$", prefix):
            continue
        drivers.append((expr_base(match.group(1)), "procedural", match.group(1)))
    for vip in re.finditer(r"\bpchn_mst_vip\s*(?:#\s*\([^;]*?\)\s*)?([A-Za-z_][A-Za-z0-9_$]*)\s*\((.*?)\);", clean, re.S):
        inst, body = vip.groups()
        for port in ("preq", "pstate"):
            match = re.search(r"\." + port + r"\s*\(\s*([^()]+?)\s*\)", body, re.S)
            if match:
                signal = " ".join(match.group(1).split())
                drivers.append((expr_base(signal), f"pchn_mst_vip.{inst}.{port}", signal))
    return drivers


def driver_labels(drivers, name):
    return sorted({kind for base, kind, _signal in drivers if base == name})


def line_hits(text, pattern):
    regex = re.compile(pattern)
    return [(idx + 1, line.rstrip()) for idx, line in enumerate(text.splitlines()) if regex.search(line)]


def summarize():
    dut_text = DUT_PATH.read_text()
    tb_text = TB_PATH.read_text()
    ports = parse_dut_ports(dut_text)
    conns = parse_dut_connections(tb_text)
    decls = parse_tb_decls(tb_text)
    drivers = collect_drivers(tb_text)

    category = Counter()
    for port in ports:
        name = port["name"]
        key = port["dir"]
        if "_iniu_node_" in name:
            key += " INIU"
        elif "_tniu" in name or "cpu_ss_tniu" in name:
            key += " TNIU"
        else:
            key += " GLOBAL/OTHER"
        category[key] += 1

    missing = []
    empty = []
    const_inputs = []
    wire_inputs = []
    reg_inputs = []
    unknown_inputs = []
    for port in ports:
        if port["dir"] != "input":
            continue
        expr = conns.get(port["name"])
        if expr is None:
            missing.append(port["name"])
            continue
        if expr == "":
            empty.append(port["name"])
            continue
        if is_const(expr):
            const_inputs.append((port, expr))
            continue
        base = expr_base(expr)
        decl = decls.get(base) if base else None
        labels = driver_labels(drivers, base) if base else []
        rec = (port, expr, base, decl, labels)
        if not decl:
            unknown_inputs.append(rec)
        elif decl["kind"] == "wire":
            wire_inputs.append(rec)
        else:
            reg_inputs.append(rec)

    undriven_wire_inputs = [rec for rec in wire_inputs if not rec[4]]
    width_mismatches = []
    for port in ports:
        expr = conns.get(port["name"], "")
        base = expr_base(expr)
        decl = decls.get(base) if base else None
        if not decl:
            continue
        dut_width = width_bits(port["width"])
        tb_width = width_bits(decl["width"])
        if dut_width is not None and tb_width is not None and dut_width != tb_width:
            width_mismatches.append((port, expr, decl, dut_width, tb_width))

    print(f"DUT_PATH={DUT_PATH}")
    print(f"TB_PATH={TB_PATH}")
    print(f"PORT_COUNTS={dict(category)}")
    print(f"DUT_INPUTS={sum(1 for port in ports if port['dir'] == 'input')} missing={len(missing)} empty={len(empty)} const={len(const_inputs)} reg_or_logic={len(reg_inputs)} wire={len(wire_inputs)} unknown={len(unknown_inputs)}")
    print("\nMISSING_INPUT_PORTS")
    print("  " + ("none" if not missing else ", ".join(missing)))
    print("\nEMPTY_INPUT_PORTS")
    print("  " + ("none" if not empty else ", ".join(empty)))
    print("\nWIRE_INPUTS_WITHOUT_DRIVER")
    if not undriven_wire_inputs:
        print("  none")
    for port, expr, base, decl, labels in undriven_wire_inputs:
        print(f"  {port['name']} <- {expr}; decl={decl['line']}")
    print("\nUNKNOWN_INPUT_BASES")
    if not unknown_inputs:
        print("  none")
    for port, expr, base, _decl, _labels in unknown_inputs[:80]:
        print(f"  {port['name']} <- {expr}; base={base}")
    print("\nWIDTH_MISMATCHES")
    if not width_mismatches:
        print("  none")
    for port, expr, decl, dut_width, tb_width in width_mismatches[:120]:
        print(f"  {port['dir']} {port['name']} ({dut_width}b) <-> {expr} ({tb_width}b); {decl['line']}")
    print("\nFORCE_RELEASE_LINES")
    force_lines = line_hits(tb_text, r"\b(force|release)\b")
    if not force_lines:
        print("  none")
    for line_no, line in force_lines[:80]:
        print(f"  {line_no}: {line}")
    print("\nPCHANNEL_VIP_INSTANCES")
    vip_lines = line_hits(tb_text, r"\bpchn_mst_vip\b")
    if not vip_lines:
        print("  none")
    for line_no, line in vip_lines[:80]:
        print(f"  {line_no}: {line}")
    print("\nINPUT_FAMILY_COUNTS")
    family = Counter()
    for port, expr, base, decl, labels in reg_inputs + wire_inputs + unknown_inputs:
        name = port["name"]
        if "pchnl_ctrl" in name:
            family["pchannel"] += 1
        elif "clk" in name:
            family["clock"] += 1
        elif "rst" in name:
            family["reset"] += 1
        elif "timeout_val" in name:
            family["timeout"] += 1
        elif "dti_req" in name:
            family["dti_req_in"] += 1
        elif "dti_rsp" in name:
            family["dti_rsp_in"] += 1
        elif "twakeup" in name:
            family["twakeup"] += 1
        else:
            family["other"] += 1
    print(f"  {dict(family)}")


if __name__ == "__main__":
    summarize()

#!/usr/bin/env python3
"""Generate a basic end-to-end sanity TB for the SoC interrupt NoC wrapper."""

from __future__ import annotations

import csv
import re
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
DEMO_DIR = THIS_DIR.parent
WRAPPER_PATH = DEMO_DIR / "build_logic" / "soc_intr_noc_wrap" / "soc_intr_noc_wrap.v"
ENDPOINT_TABLE = DEMO_DIR / "build" / "soc_intr_endpoint_id_table.csv"
TB_PATH = THIS_DIR / "tb_soc_intr_noc_sanity.sv"

PORT_RE = re.compile(r"^\s*(input|output)\s+(?:logic\s+)?(?:(\[[^\]]+\])\s+)?([A-Za-z0-9_]+)\s*,?\s*$")
PORT_NAME_SET: set[str] = set()

SRC_INTR_BASE = 128
TGT_INTR_BASE = 128
SYS_WAIT = 2000


def parse_wrapper_ports() -> list[dict[str, str]]:
    ports: list[dict[str, str]] = []
    in_header = False
    for line in WRAPPER_PATH.read_text().splitlines():
        if line.startswith("module soc_intr_noc_wrap"):
            in_header = True
            continue
        if not in_header:
            continue
        if line.strip() == ");":
            break
        match = PORT_RE.match(line)
        if match is None:
            continue
        direction, width, name = match.groups()
        ports.append({"dir": direction, "width": width or "", "name": name})
    if not ports:
        raise RuntimeError(f"Failed to parse wrapper header: {WRAPPER_PATH}")
    return ports


def load_endpoints() -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    with ENDPOINT_TABLE.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    inius = [row for row in rows if row["kind"] == "iniu"]
    tnius = [row for row in rows if row["kind"] == "tniu"]
    inius.sort(key=lambda row: int(row["node_id"]))
    tnius.sort(key=lambda row: int(row["node_id"]))
    if not inius or not tnius:
        raise RuntimeError(f"Endpoint table missing INIU/TNIU rows: {ENDPOINT_TABLE}")
    return inius, tnius


def resolve_port_name(*candidates: str) -> str:
    for candidate in candidates:
        if candidate in PORT_NAME_SET:
            return candidate
    return candidates[0]


def iniu_apb_name(endpoint: str, suffix: str) -> str:
    return resolve_port_name(
        f"{endpoint}_apb_porting_apb_apb_{suffix}",
        f"{endpoint}_{endpoint}_sys_apb_porting_{endpoint}_sys_apb_porting_{suffix}",
    )


def iniu_intr_name(endpoint: str) -> str:
    return resolve_port_name(
        f"{endpoint}_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt",
        f"{endpoint}_{endpoint}_sys_v_interrupt_porting_{endpoint}_sys_v_interrupt_porting_v_interrupt",
    )


def tniu_intr_name(endpoint: str) -> str:
    return resolve_port_name(
        f"{endpoint}_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt",
        f"{endpoint}_{endpoint}_sys_v_interrupt_porting_{endpoint}_sys_v_interrupt_porting_v_interrupt",
    )


def iniu_id_name(endpoint: str) -> str:
    return resolve_port_name(
        f"{endpoint}_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id",
        f"{endpoint}_{endpoint}_sys_iniu_src_id_porting_{endpoint}_sys_iniu_src_id_porting_iniu_src_id",
    )


def tniu_id_name(endpoint: str) -> str:
    return resolve_port_name(
        f"{endpoint}_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id",
        f"{endpoint}_{endpoint}_sys_tniu_tgt_id_porting_{endpoint}_sys_tniu_tgt_id_porting_tniu_tgt_id",
    )


def classify_input_port(name: str) -> str:
    if name in {"clk_noc_up", "clk_noc_dn", "rst_noc_up_n", "rst_noc_dn_n"}:
        return "procedural"
    if "_apb_porting_" in name and name.endswith(("_p_addr", "_p_enable", "_p_wdata", "_p_write", "_p_sel")):
        return "procedural"
    if "_v_interrupt_porting_" in name and name.endswith("_v_interrupt"):
        return "procedural"
    if "_clk_sys_porting_" in name and name.endswith("_clk"):
        return "assign_clk"
    if "_rst_sys_n_porting_" in name and name.endswith("_rst_n"):
        return "assign_rst"
    if "_pchannel_porting_" in name and name.endswith("_preq"):
        return "assign_on"
    if "_pchannel_porting_" in name and name.endswith("_pstate"):
        return "assign_power_on"
    if "_timeout_val_porting" in name:
        return "assign_timeout"
    if "_iniu_src_id_porting_" in name:
        return "assign_iniu_id"
    if "_tniu_tgt_id_porting_" in name:
        return "assign_tniu_id"
    if "_local_rx_" in name and name.endswith("_ready"):
        return "assign_ready"
    if "_local_tx_" in name and name.endswith("_ready"):
        return "assign_ready"
    if "_local_tx_" in name:
        return "assign_zero"
    raise RuntimeError(f"Unhandled wrapper input port: {name}")


def sv_int_literals(values: list[int], width: int) -> str:
    return "{" + ", ".join(f"{width}'d{value}" for value in values) + "}"


def emit_case_branch(index: int, body_lines: list[str], indent: str = "            ") -> list[str]:
    branch = [f"{indent}{index}: begin"]
    branch.extend(f"{indent}    {line}" for line in body_lines)
    branch.append(f"{indent}end")
    return branch


def emit_iniu_apb_write_task(inius: list[dict[str, str]]) -> list[str]:
    lines = [
        "    task automatic iniu_apb_write(",
        "        input int unsigned iniu_idx,",
        "        input logic [31:0] addr_i,",
        "        input logic [31:0] data_i",
        "    );",
        "        int unsigned timeout;",
        "        begin",
        "            @(negedge clk_sys);",
        "            case (iniu_idx)",
    ]
    for index, row in enumerate(inius):
        endpoint = row["name"]
        body = [
            f"{iniu_apb_name(endpoint, 'p_addr')} <= addr_i;",
            f"{iniu_apb_name(endpoint, 'p_wdata')} <= data_i;",
            f"{iniu_apb_name(endpoint, 'p_write')} <= 1'b1;",
            f"{iniu_apb_name(endpoint, 'p_sel')} <= 1'b1;",
            f"{iniu_apb_name(endpoint, 'p_enable')} <= 1'b0;",
        ]
        lines.extend(emit_case_branch(index, body))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid INIU index %0d\", iniu_idx);",
            "            endcase",
            "            @(negedge clk_sys);",
            "            case (iniu_idx)",
        ]
    )
    for index, row in enumerate(inius):
        endpoint = row["name"]
        lines.extend(emit_case_branch(index, [f"{iniu_apb_name(endpoint, 'p_enable')} <= 1'b1;"]))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid INIU index %0d\", iniu_idx);",
            "            endcase",
            "            timeout = 0;",
            "            case (iniu_idx)",
        ]
    )
    for index, row in enumerate(inius):
        endpoint = row["name"]
        ready = iniu_apb_name(endpoint, "p_ready")
        body = [
            f"while (({ready} !== 1'b1) && timeout < 40) begin",
            "    @(posedge clk_sys);",
            "    timeout++;",
            "end",
        ]
        lines.extend(emit_case_branch(index, body))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid INIU index %0d\", iniu_idx);",
            "            endcase",
            "            @(negedge clk_sys);",
            "            case (iniu_idx)",
        ]
    )
    for index, row in enumerate(inius):
        endpoint = row["name"]
        body = [
            f"{iniu_apb_name(endpoint, 'p_addr')} <= '0;",
            f"{iniu_apb_name(endpoint, 'p_wdata')} <= '0;",
            f"{iniu_apb_name(endpoint, 'p_write')} <= 1'b0;",
            f"{iniu_apb_name(endpoint, 'p_sel')} <= 1'b0;",
            f"{iniu_apb_name(endpoint, 'p_enable')} <= 1'b0;",
        ]
        lines.extend(emit_case_branch(index, body))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid INIU index %0d\", iniu_idx);",
            "            endcase",
            "        end",
            "    endtask",
            "",
        ]
    )
    return lines


def emit_set_iniu_intr_task(inius: list[dict[str, str]]) -> list[str]:
    lines = [
        "    task automatic set_iniu_intr(",
        "        input int unsigned iniu_idx,",
        "        input int unsigned bit_idx,",
        "        input logic level_i",
        "    );",
        "        begin",
        "            @(negedge clk_sys);",
        "            case (iniu_idx)",
    ]
    for index, row in enumerate(inius):
        endpoint = row["name"]
        lines.extend(emit_case_branch(index, [f"{iniu_intr_name(endpoint)}[bit_idx] <= level_i;"]))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid INIU index %0d\", iniu_idx);",
            "            endcase",
            "        end",
            "    endtask",
            "",
        ]
    )
    return lines


def emit_expect_tniu_intr_task(tnius: list[dict[str, str]]) -> list[str]:
    lines = [
        "    task automatic expect_tniu_intr(",
        "        input string msg,",
        "        input int unsigned tniu_idx,",
        "        input int unsigned bit_idx,",
        "        input logic expected",
        "    );",
        "        begin",
        "            case (tniu_idx)",
    ]
    for index, row in enumerate(tnius):
        endpoint = row["name"]
        signal = tniu_intr_name(endpoint)
        lines.extend(emit_case_branch(index, [f"expect_bit(msg, {signal}[bit_idx], expected);"]))
    lines.extend(
        [
            "                default: $fatal(1, \"[TB] invalid TNIU index %0d\", tniu_idx);",
            "            endcase",
            "        end",
            "    endtask",
            "",
        ]
    )
    return lines


def generate_tb() -> str:
    global PORT_NAME_SET
    ports = parse_wrapper_ports()
    inius, tnius = load_endpoints()
    iniu_id_map = {row["name"]: int(row["node_id"]) for row in inius}
    tniu_id_map = {row["name"]: int(row["node_id"]) for row in tnius}

    input_ports = [port for port in ports if port["dir"] == "input"]
    port_names = {port["name"] for port in ports}
    PORT_NAME_SET = port_names

    lines: list[str] = [
        "// Auto-generated by gen_soc_intr_sanity_tb.py. Do not edit manually.",
        "`timescale 1ns/1ps",
        "",
        "module tb_soc_intr_noc_sanity;",
        "    timeunit 1ns;",
        "    timeprecision 1ps;",
        "",
        f"    localparam int unsigned NUM_INIUS = {len(inius)};",
        f"    localparam int unsigned NUM_TNIUS = {len(tnius)};",
        f"    localparam int unsigned SRC_INTR_BASE = {SRC_INTR_BASE};",
        f"    localparam int unsigned TGT_INTR_BASE = {TGT_INTR_BASE};",
        f"    localparam int unsigned SYS_WAIT = {SYS_WAIT};",
        f"    localparam logic [7:0] INIU_SRC_ID [NUM_INIUS] = '{sv_int_literals([int(row['node_id']) for row in inius], 8)};",
        f"    localparam logic [7:0] TNIU_RING_ID [NUM_TNIUS] = '{sv_int_literals([int(row['node_id']) for row in tnius], 8)};",
        "",
        "    localparam logic [31:0] INTR_LUT_BASE_ADDR = 32'h4000;",
        "",
        "    integer fail_count = 0;",
        "    integer pass_count = 0;",
        "    string testcase;",
        "    logic clk_sys = 1'b0;",
        "    logic rstn_sys = 1'b0;",
        "",
    ]

    for port in ports:
        width = f" {port['width']}" if port["width"] else ""
        lines.append(f"    logic{width} {port['name']};")

    lines.extend(
        [
            "",
            "    always #5  clk_sys = ~clk_sys;",
            "    always #7  clk_noc_up = ~clk_noc_up;",
            "    always #11 clk_noc_dn = ~clk_noc_dn;",
            "",
            "    initial begin",
            "        clk_noc_up = 1'b0;",
            "        clk_noc_dn = 1'b0;",
            "        rst_noc_up_n = 1'b0;",
            "        rst_noc_dn_n = 1'b0;",
        ]
    )

    for port in input_ports:
        if classify_input_port(port["name"]) == "procedural" and port["name"] not in {"clk_noc_up", "clk_noc_dn", "rst_noc_up_n", "rst_noc_dn_n"}:
            lines.append(f"        {port['name']} = '0;")

    lines.extend(
        [
            "        #100;",
            "        rstn_sys = 1'b1;",
            "        rst_noc_up_n = 1'b1;",
            "        rst_noc_dn_n = 1'b1;",
            "    end",
            "",
        ]
    )

    for port in input_ports:
        name = port["name"]
        kind = classify_input_port(name)
        if kind == "assign_clk":
            lines.append(f"    assign {name} = clk_sys;")
        elif kind == "assign_rst":
            lines.append(f"    assign {name} = rstn_sys;")
        elif kind == "assign_on":
            lines.append(f"    assign {name} = 1'b1;")
        elif kind == "assign_power_on":
            lines.append(f"    assign {name} = 2'd0;")
        elif kind == "assign_timeout":
            lines.append(f"    assign {name} = 10'd16;")
        elif kind == "assign_ready":
            lines.append(f"    assign {name} = 1'b1;")
        elif kind == "assign_zero":
            lines.append(f"    assign {name} = '0;")
        elif kind == "assign_iniu_id":
            pass
        elif kind == "assign_tniu_id":
            pass

    for row in inius:
        endpoint = row["name"]
        signal = iniu_id_name(endpoint)
        if signal in port_names:
            lines.append(f"    assign {signal} = 8'd{iniu_id_map[endpoint]};")

    for row in tnius:
        endpoint = row["name"]
        signal = tniu_id_name(endpoint)
        if signal in port_names:
            lines.append(f"    assign {signal} = 8'd{tniu_id_map[endpoint]};")

    lines.extend(
        [
            "",
            "    soc_intr_noc_wrap dut (.*);",
            "",
            "    task automatic wait_sys(input int unsigned n);",
            "        repeat (n) @(posedge clk_sys);",
            "    endtask",
            "",
            "    task automatic reset_dut();",
            "        begin",
            "            wait (rstn_sys === 1'b1 && rst_noc_up_n === 1'b1 && rst_noc_dn_n === 1'b1);",
            "            wait_sys(100);",
            "        end",
            "    endtask",
            "",
            "    task automatic expect_bit(input string msg, input logic actual, input logic expected);",
            "        begin",
            "            if (actual !== expected) begin",
            "                fail_count++;",
            "                $error(\"[FAIL] %s expected=%0b actual=%0b\", msg, expected, actual);",
            "            end else begin",
            "                pass_count++;",
            "                $display(\"[PASS] %s\", msg);",
            "            end",
            "        end",
            "    endtask",
            "",
        ]
    )

    lines.extend(emit_iniu_apb_write_task(inius))
    lines.extend(
        [
            "    task automatic program_iniu_lut(",
            "        input int unsigned iniu_idx,",
            "        input int unsigned src_intr_id,",
            "        input logic [7:0] tgt_ring_id,",
            "        input logic [11:0] tgt_intr_id",
            "    );",
            "        logic [31:0] lut_data;",
            "        begin",
            "            lut_data = {8'h00, tgt_ring_id, 4'h0, tgt_intr_id};",
            "            iniu_apb_write(iniu_idx, INTR_LUT_BASE_ADDR + 32'(src_intr_id) * 4, lut_data);",
            "        end",
            "    endtask",
            "",
        ]
    )
    lines.extend(
        [
            "    task automatic probe_cpu_to_cpu_route(input string phase);",
            "        begin",
            "            $display(\"[PROBE] %s t=%0t\", phase, $time);",
            "        end",
            "    endtask",
            "",
        ]
    )
    lines.extend(emit_set_iniu_intr_task(inius))
    lines.extend(emit_expect_tniu_intr_task(tnius))
    lines.extend(
        [
            "    task automatic tc_sanity();",
            "        int unsigned iniu_idx;",
            "        int unsigned tniu_idx;",
            "        string msg;",
            "        begin",
            "            $display(\"[TB] tc_sanity: program all INIU->TNIU routes and verify delivery/clear\");",
            "            reset_dut();",
            "            for (iniu_idx = 0; iniu_idx < NUM_INIUS; iniu_idx++) begin",
            "                for (tniu_idx = 0; tniu_idx < NUM_TNIUS; tniu_idx++) begin",
            "                    program_iniu_lut(",
            "                        iniu_idx,",
            "                        SRC_INTR_BASE + tniu_idx,",
            "                        TNIU_RING_ID[tniu_idx],",
            "                        TGT_INTR_BASE + iniu_idx",
            "                    );",
            "                end",
            "            end",
            "            wait_sys(20);",
            "            for (iniu_idx = 0; iniu_idx < NUM_INIUS; iniu_idx++) begin",
            "                for (tniu_idx = 0; tniu_idx < NUM_TNIUS; tniu_idx++) begin",
            "                    msg = $sformatf(\"iniu[%0d,id=%0d]->tniu[%0d,id=%0d]\", iniu_idx, INIU_SRC_ID[iniu_idx], tniu_idx, TNIU_RING_ID[tniu_idx]);",
            "                    set_iniu_intr(iniu_idx, SRC_INTR_BASE + tniu_idx, 1'b1);",
            "                    if ((iniu_idx == 0) && (tniu_idx == 0)) begin",
            "                        probe_cpu_to_cpu_route(\"after_raise\");",
            "                    end",
            "                    wait_sys(SYS_WAIT);",
            "                    expect_tniu_intr({msg, \" high\"}, tniu_idx, TGT_INTR_BASE + iniu_idx, 1'b1);",
            "                    set_iniu_intr(iniu_idx, SRC_INTR_BASE + tniu_idx, 1'b0);",
            "                    if ((iniu_idx == 0) && (tniu_idx == 0)) begin",
            "                        probe_cpu_to_cpu_route(\"after_clear\");",
            "                    end",
            "                    wait_sys(SYS_WAIT);",
            "                    expect_tniu_intr({msg, \" low\"}, tniu_idx, TGT_INTR_BASE + iniu_idx, 1'b0);",
            "                end",
            "            end",
            "        end",
            "    endtask",
            "",
            "    initial begin",
            "        fail_count = 0;",
            "        pass_count = 0;",
            "        if (!$value$plusargs(\"TESTCASE=%s\", testcase)) testcase = \"tc_sanity\";",
            "        if (testcase != \"tc_sanity\") begin",
            "            $fatal(1, \"[TB] Unsupported TESTCASE=%s\", testcase);",
            "        end",
            "        tc_sanity();",
            "        $display(\"[TB] pass_count=%0d fail_count=%0d\", pass_count, fail_count);",
            "        if (fail_count != 0) begin",
            "            $fatal(1, \"[TB] %0d failure(s) detected\", fail_count);",
            "        end",
            "        $display(\"[TB] soc_intr sanity test PASSED\");",
            "        $finish;",
            "    end",
            "",
            "endmodule",
        ]
    )

    return "\n".join(lines) + "\n"


def main() -> None:
    tb_text = generate_tb()
    TB_PATH.write_text(tb_text)
    inius, tnius = load_endpoints()
    print(f"[tbgen] wrote {TB_PATH}")
    print(f"[tbgen] INIUs={len(inius)} TNIUs={len(tnius)} pairs={len(inius) * len(tnius)}")


if __name__ == "__main__":
    main()
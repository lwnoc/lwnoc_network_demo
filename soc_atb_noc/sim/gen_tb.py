#!/usr/bin/env python3
"""Generate a smoke TB aligned with the current atb_soc_topo publish root."""

from pathlib import Path


SRC_SIGS = [
    "s_atvalid",
    "s_atready",
    "s_atdata",
    "s_atid",
    "s_atbytes",
    "s_afvalid",
    "s_afready",
    "s_syncreq",
    "s_atwakeup",
]
SINK_SIGS = [
    "m_atvalid",
    "m_atready",
    "m_atdata",
    "m_atid",
    "m_atbytes",
    "m_afvalid",
    "m_afready",
    "m_syncreq",
    "m_atwakeup",
]
PCHN_SIGS = ["preq", "pstate", "pactive", "paccept", "pdeny"]

WIDTHS = {
    "s_atvalid": 1,
    "s_atready": 1,
    "s_atdata": 128,
    "s_atid": 7,
    "s_atbytes": 4,
    "s_afvalid": 1,
    "s_afready": 1,
    "s_syncreq": 1,
    "s_atwakeup": 1,
    "m_atvalid": 1,
    "m_atready": 1,
    "m_atdata": 128,
    "m_atid": 7,
    "m_atbytes": 4,
    "m_afvalid": 1,
    "m_afready": 1,
    "m_syncreq": 1,
    "m_atwakeup": 1,
    "preq": 1,
    "pstate": 2,
    "pactive": 2,
    "paccept": 1,
    "pdeny": 1,
}

SOURCES = [
    {"name": "dsp_ss0", "tid": 0, "clk": "dsp_ss0_sys"},
    {"name": "dsp_ss1", "tid": 1, "clk": "dsp_ss1_sys"},
    {"name": "dsp_ss2", "tid": 2, "clk": "dsp_ss2_sys"},
    {"name": "dsp_ss3", "tid": 3, "clk": "dsp_ss3_sys"},
    {"name": "dsp_ss4", "tid": 4, "clk": "dsp_ss4_sys"},
    {"name": "dsp_ss5", "tid": 5, "clk": "dsp_ss5_sys"},
    {"name": "camera_ss", "tid": 6, "clk": "camera_ss_sys"},
    {"name": "mipi_ss", "tid": 7, "clk": "mipi_ss_sys"},
    {"name": "gpu1_ss", "tid": 8, "clk": "gpu1_ss_sys"},
    {"name": "usb_dp_ss", "tid": 9, "clk": "usb_dp_ss_sys"},
    {"name": "display_ss", "tid": 10, "clk": "display_ss_sys"},
    {"name": "aon_ss", "tid": 11, "clk": "aon_ss_sys"},
    {"name": "gpu_ss0", "tid": 12, "clk": "gpu_ss0_sys"},
    {"name": "cpu_ss", "tid": 13, "clk": "cpu_ss_sys"},
    {"name": "mcu_ss", "tid": 14, "clk": "mcu_ss_sys"},
]
SINK = {"name": "peri_ss", "clk": "peri_ss_sys"}
PHASES = [0.1, 0.4, 0.7, 1.0, 1.3, 1.6, 0.2, 0.5, 0.8, 1.1, 1.4, 1.7, 0.3, 0.9, 1.5, 0.6]


def logic_decl(name: str, width: int, init: str | None = None) -> str:
    if width == 1:
        decl = f"logic        {name}"
    else:
        decl = f"logic [{width - 1}:0] {name}"
    if init is not None:
        return f"    {decl} = {init};"
    return f"    {decl};"


def payload_for_tid(tid: int) -> str:
    return f"128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_{tid:04X}"


def src_sig(source: dict[str, object], sig: str) -> str:
    return f"{source['name']}_{sig}"


def sink_sig(sig: str) -> str:
    return f"{SINK['name']}_{sig}"


def src_port(source: dict[str, object], sig: str) -> str:
    name = source["name"]
    if sig in SRC_SIGS:
        return f"{name}_node_{name}_sys_node_s_chan_porting_{name}_sys_node_s_chan_porting_{sig}"
    return f"{name}_node_{name}_sys_node_pchnl_ctrl_porting_{name}_sys_node_pchnl_ctrl_porting_{sig}"


def sink_port(sig: str) -> str:
    name = SINK["name"]
    if sig in SINK_SIGS:
        return f"{name}_node_{name}_sys_node_m_chan_porting_{name}_sys_node_m_chan_porting_{sig}"
    return f"{name}_node_{name}_sys_node_pchnl_ctrl_porting_{name}_sys_node_pchnl_ctrl_porting_{sig}"


lines: list[str] = []
add = lines.append

add("// Auto-generated ATB smoke TB for the current atb_soc_topo publish root")
add("// `timescale set via VCS command line")
add("")
add("module tb_atb_soc_topo;")
add(f"    localparam int NUM_SOURCES = {len(SOURCES)};")
add("")

add("    // Clocks")
for source in SOURCES:
    add(f"    logic clk_{source['clk']} = 1'b0;")
add(f"    logic clk_{SINK['clk']} = 1'b0;")
add("    logic clk_noc = 1'b0;")
add("")

add("    // Resets")
for source in SOURCES:
    add(f"    logic rst_{source['clk']}_n = 1'b0;")
add(f"    logic rst_{SINK['clk']}_n = 1'b0;")
add("    logic rst_noc_n = 1'b0;")
add("")

add("    // Source-side stimulus and observation")
for source in SOURCES:
    add(logic_decl(f"{source['name']}_timeout_val", 10, "10'd1023"))
    add(logic_decl(src_sig(source, "s_atvalid"), WIDTHS["s_atvalid"], "1'b0"))
    add(logic_decl(src_sig(source, "s_atready"), WIDTHS["s_atready"]))
    add(logic_decl(src_sig(source, "s_atdata"), WIDTHS["s_atdata"], "'0"))
    add(logic_decl(src_sig(source, "s_atid"), WIDTHS["s_atid"], f"7'd{source['tid']}"))
    add(logic_decl(src_sig(source, "s_atbytes"), WIDTHS["s_atbytes"], "4'd8"))
    add(logic_decl(src_sig(source, "s_afvalid"), WIDTHS["s_afvalid"]))
    add(logic_decl(src_sig(source, "s_afready"), WIDTHS["s_afready"], "1'b1"))
    add(logic_decl(src_sig(source, "s_syncreq"), WIDTHS["s_syncreq"]))
    add(logic_decl(src_sig(source, "s_atwakeup"), WIDTHS["s_atwakeup"], "1'b0"))
    add(logic_decl(src_sig(source, "preq"), WIDTHS["preq"], "1'b1"))
    add(logic_decl(src_sig(source, "pstate"), WIDTHS["pstate"], "2'b00"))
    add(logic_decl(src_sig(source, "pactive"), WIDTHS["pactive"]))
    add(logic_decl(src_sig(source, "paccept"), WIDTHS["paccept"]))
    add(logic_decl(src_sig(source, "pdeny"), WIDTHS["pdeny"]))
    add("")

add("    // Peri sink-side stimulus and observation")
add(logic_decl(f"{SINK['name']}_timeout_val", 10, "10'd1023"))
add(logic_decl(sink_sig("m_atvalid"), WIDTHS["m_atvalid"]))
add(logic_decl(sink_sig("m_atready"), WIDTHS["m_atready"], "1'b1"))
add(logic_decl(sink_sig("m_atdata"), WIDTHS["m_atdata"]))
add(logic_decl(sink_sig("m_atid"), WIDTHS["m_atid"]))
add(logic_decl(sink_sig("m_atbytes"), WIDTHS["m_atbytes"]))
add(logic_decl(sink_sig("m_afvalid"), WIDTHS["m_afvalid"], "1'b0"))
add(logic_decl(sink_sig("m_afready"), WIDTHS["m_afready"]))
add(logic_decl(sink_sig("m_syncreq"), WIDTHS["m_syncreq"], "1'b0"))
add(logic_decl(sink_sig("m_atwakeup"), WIDTHS["m_atwakeup"]))
add(logic_decl(sink_sig("preq"), WIDTHS["preq"], "1'b1"))
add(logic_decl(sink_sig("pstate"), WIDTHS["pstate"], "2'b00"))
add(logic_decl(sink_sig("pactive"), WIDTHS["pactive"]))
add(logic_decl(sink_sig("paccept"), WIDTHS["paccept"]))
add(logic_decl(sink_sig("pdeny"), WIDTHS["pdeny"]))
add("")

add("    integer rx_count_total;")
add("    integer rx_count_by_tid [0:127];")
add("    logic [127:0] expected_data_by_tid [0:127];")
add("    logic         expected_valid_by_tid [0:127];")
add("    logic [NUM_SOURCES-1:0] flush_seen;")
add("    logic data_mismatch_seen;")
add("")

add("    atb_soc_topo dut (")
connections: list[str] = []
for source in SOURCES:
    connections.append(f"        .clk_{source['clk']}(clk_{source['clk']})")
    connections.append(f"        .rst_{source['clk']}_n(rst_{source['clk']}_n)")
connections.append(f"        .clk_{SINK['clk']}(clk_{SINK['clk']})")
connections.append(f"        .rst_{SINK['clk']}_n(rst_{SINK['clk']}_n)")
connections.append("        .clk_noc(clk_noc)")
connections.append("        .rst_noc_n(rst_noc_n)")
for source in SOURCES:
    connections.append(f"        .{source['name']}_node_timeout_val_porting({source['name']}_timeout_val)")
    for sig in SRC_SIGS:
        connections.append(f"        .{src_port(source, sig)}({src_sig(source, sig)})")
    for sig in PCHN_SIGS:
        connections.append(f"        .{src_port(source, sig)}({src_sig(source, sig)})")
connections.append(f"        .{SINK['name']}_node_timeout_val_porting({SINK['name']}_timeout_val)")
for sig in SINK_SIGS:
    connections.append(f"        .{sink_port(sig)}({sink_sig(sig)})")
for sig in PCHN_SIGS:
    connections.append(f"        .{sink_port(sig)}({sink_sig(sig)})")
for index, conn in enumerate(connections):
    suffix = "," if index != len(connections) - 1 else ""
    add(f"{conn}{suffix}")
add("    );")
add("")

add("    // Offset clock phases to avoid artificial alignment")
for phase, source in zip(PHASES, SOURCES, strict=False):
    add(f"    initial begin #{phase:.1f}; forever #5 clk_{source['clk']} = ~clk_{source['clk']}; end")
add(f"    initial begin #{PHASES[len(SOURCES)]:.1f}; forever #5 clk_{SINK['clk']} = ~clk_{SINK['clk']}; end")
add("    initial begin #0.0; forever #2 clk_noc = ~clk_noc; end")
add("")

add("    initial begin")
for source in SOURCES:
    add(f"        rst_{source['clk']}_n = 1'b0;")
add(f"        rst_{SINK['clk']}_n = 1'b0;")
add("        rst_noc_n = 1'b0;")
add("        #100;")
for source in SOURCES:
    add(f"        rst_{source['clk']}_n = 1'b1;")
add(f"        rst_{SINK['clk']}_n = 1'b1;")
add("        rst_noc_n = 1'b1;")
add("    end")
add("")

add("    task automatic send_trace(")
add("        input string src_name,")
add("        input logic [6:0] tid,")
add("        input logic [127:0] data,")
add("        const ref logic clk,")
add("        ref logic s_atvalid,")
add("        const ref logic s_atready,")
add("        ref logic [127:0] s_atdata,")
add("        ref logic [6:0] s_atid,")
add("        ref logic [3:0] s_atbytes,")
add("        ref logic s_atwakeup")
add("    );")
add("        @(negedge clk);")
add("        s_atvalid  = 1'b1;")
add("        s_atdata   = data;")
add("        s_atid     = tid;")
add("        s_atbytes  = 4'd8;")
add("        s_atwakeup = 1'b0;")
add("        do @(posedge clk); while (!s_atready);")
add("        @(posedge clk);")
add("        @(negedge clk);")
add("        s_atvalid  = 1'b0;")
add("        s_atdata   = '0;")
add("        s_atid     = '0;")
add("        s_atbytes  = '0;")
add("        s_atwakeup = 1'b0;")
add("        $display(\"[%0t] %s: sent tid=%0d data=0x%0h\", $time, src_name, tid, data);")
add("    endtask")
add("")

add(f"    always @(posedge clk_{SINK['clk']}) begin")
add(f"        if (rst_{SINK['clk']}_n && {sink_sig('m_atvalid')} && {sink_sig('m_atready')}) begin")
add("            rx_count_total <= rx_count_total + 1;")
add(f"            rx_count_by_tid[{sink_sig('m_atid')}] <= rx_count_by_tid[{sink_sig('m_atid')}] + 1;")
add(f"            $display(\"[%0t] PERI SNK: tid=%0d data=0x%0h\", $time, {sink_sig('m_atid')}, {sink_sig('m_atdata')});")
add(f"            if (expected_valid_by_tid[{sink_sig('m_atid')}] && ({sink_sig('m_atdata')} !== expected_data_by_tid[{sink_sig('m_atid')}])) begin")
add("                data_mismatch_seen <= 1'b1;")
add(f"                $error(\"PERI SNK data mismatch for tid=%0d expected=0x%0h got=0x%0h\", {sink_sig('m_atid')}, expected_data_by_tid[{sink_sig('m_atid')}], {sink_sig('m_atdata')});")
add("            end")
add("        end")
add("    end")
add("")

add("    initial begin : main_test")
add("        integer idx;")
add("        rx_count_total = 0;")
add("        flush_seen = '0;")
add("        data_mismatch_seen = 1'b0;")
add("        for (idx = 0; idx < 128; idx = idx + 1) begin")
add("            rx_count_by_tid[idx] = 0;")
add("            expected_data_by_tid[idx] = '0;")
add("            expected_valid_by_tid[idx] = 1'b0;")
add("        end")
add("")
add("        #200;")
for source in SOURCES:
    add(f"        expected_valid_by_tid[7'd{source['tid']}] = 1'b1;")
    add(f"        expected_data_by_tid[7'd{source['tid']}] = {payload_for_tid(source['tid'])};")
add("")
add('        $display("========== Phase 1: Trace smoke ==========");')
add("        fork")
for source in SOURCES:
    add(
        f"            send_trace(\"{source['name']}\", 7'd{source['tid']}, {payload_for_tid(source['tid'])}, "
        f"clk_{source['clk']}, {src_sig(source, 's_atvalid')}, {src_sig(source, 's_atready')}, "
        f"{src_sig(source, 's_atdata')}, {src_sig(source, 's_atid')}, {src_sig(source, 's_atbytes')}, {src_sig(source, 's_atwakeup')});"
    )
add("        join")
add("")
add("        fork")
add("            begin : rx_timeout")
add('                repeat (4000) @(posedge clk_noc);')
add('                $fatal(1, "Timed out waiting for %0d sink packets, observed %0d", NUM_SOURCES, rx_count_total);')
add("            end")
add("            begin : rx_wait")
add("                wait (rx_count_total == NUM_SOURCES);")
add("            end")
add("        join_any")
add("        disable fork;")
add("")
add('        $display("=== TRACE CHECK ===");')
for source in SOURCES:
    add(f"        $display(\"  TID {source['tid']:2d} ({source['name']}): got %0d packet(s)\", rx_count_by_tid[7'd{source['tid']}]);")
    add(f"        if (rx_count_by_tid[7'd{source['tid']}] != 1) begin")
    add(f"            $fatal(1, \"Expected exactly one packet for {source['name']} / tid {source['tid']}, got %0d\", rx_count_by_tid[7'd{source['tid']}]);")
    add("        end")
add("        if (data_mismatch_seen) begin")
add('            $fatal(1, "Trace data mismatch detected");')
add("        end")
add('        $display("PASS: trace packets from all active INIUs reached peri sink.");')
add("")
add('        $display("========== Phase 2: Flush smoke ==========");')
add(f"        {sink_sig('m_afvalid')} <= 1'b1;")
add("        fork")
add("            begin : flush_timeout")
add("                repeat (4000) @(posedge clk_noc);")
add('                $fatal(1, "Timed out waiting for flush acknowledgements");')
add("            end")
add("            begin : flush_wait")
add("                fork")
for index, source in enumerate(SOURCES):
    add("                    begin")
    add(f"                        wait ({src_sig(source, 's_afvalid')} === 1'b1);")
    add(f"                        flush_seen[{index}] = 1'b1;")
    add(f"                        $display(\"[%0t] FLUSH: {source['name']} accepted\", $time);")
    add("                    end")
add("                join")
add("            end")
add("        join_any")
add("        disable fork;")
add(f"        {sink_sig('m_afvalid')} <= 1'b0;")
add("")
for index, source in enumerate(SOURCES):
    add(f"        if (!flush_seen[{index}]) begin")
    add(f"            $fatal(1, \"Flush did not reach {source['name']}\");")
    add("        end")
add('        $display("PASS: peri flush reached all active INIUs.");')
add('        $display("========== SIM DONE ==========");')
add("        #100;")
add("        $finish;")
add("    end")
add("")
add("endmodule")
add("")

output_path = Path(__file__).with_name("tb_atb_soc_topo.sv")
output_path.write_text("\n".join(lines), encoding="utf-8")
print(f"Generated {output_path.name}")

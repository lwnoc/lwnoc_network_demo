`timescale 1ns/1ps

module tb_dti_logic_topo_tree;
    localparam int unsigned LEAF_NUM = 11;
    localparam int unsigned TIMEOUT_CYCLES = 2000;

    logic clk = 1'b0;
    logic rst_n = 1'b0;

    logic [LEAF_NUM-1:0] leaf_req_valid;
    logic [LEAF_NUM-1:0] leaf_req_ready;
    logic [LEAF_NUM-1:0][89:0] leaf_req_payload;
    logic [LEAF_NUM-1:0][5:0] leaf_req_srcid;
    logic [LEAF_NUM-1:0] leaf_req_last;

    logic [LEAF_NUM-1:0] leaf_rsp_valid;
    logic [LEAF_NUM-1:0] leaf_rsp_ready;
    logic [LEAF_NUM-1:0][89:0] leaf_rsp_payload;
    logic [LEAF_NUM-1:0][5:0] leaf_rsp_srcid;
    logic [LEAF_NUM-1:0] leaf_rsp_last;

    logic top_tcu_req_tniu_req_valid;
    logic top_tcu_req_tniu_req_ready;
    logic [89:0] top_tcu_req_tniu_req_payload;
    logic [5:0] top_tcu_req_tniu_req_srcid;
    logic top_tcu_req_tniu_req_last;

    logic top_tcu_rsp_tniu_rsp_valid;
    logic top_tcu_rsp_tniu_rsp_ready;
    logic [89:0] top_tcu_rsp_tniu_rsp_payload;
    logic [5:0] top_tcu_rsp_tniu_rsp_srcid;
    logic top_tcu_rsp_tniu_rsp_last;

    int unsigned leaf_min [LEAF_NUM-1:0];
    int unsigned leaf_max [LEAF_NUM-1:0];
    string leaf_name [LEAF_NUM-1:0];
    int unsigned pass_count;
    string testcase;

    always #1 clk = ~clk;

    task automatic drive_idle;
        begin
            leaf_req_valid = '0;
            leaf_req_payload = '0;
            leaf_req_srcid = '0;
            leaf_req_last = '0;
            leaf_rsp_ready = '1;
            top_tcu_req_tniu_req_ready = 1'b1;
            top_tcu_rsp_tniu_rsp_valid = 1'b0;
            top_tcu_rsp_tniu_rsp_payload = '0;
            top_tcu_rsp_tniu_rsp_srcid = '0;
            top_tcu_rsp_tniu_rsp_last = 1'b0;
        end
    endtask

    task automatic reset_dut;
        begin
            drive_idle();
            rst_n = 1'b0;
            repeat (10) @(posedge clk);
            rst_n = 1'b1;
            repeat (10) @(posedge clk);
        end
    endtask

    task automatic send_leaf_beat(
        input int unsigned leaf_idx,
        input logic [89:0] payload,
        input logic [5:0] srcid,
        input logic last
    );
        bit done;
        begin
            done = 0;
            @(negedge clk);
            leaf_req_payload[leaf_idx] = payload;
            leaf_req_srcid[leaf_idx] = srcid;
            leaf_req_last[leaf_idx] = last;
            leaf_req_valid[leaf_idx] = 1'b1;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk);
                if (leaf_req_valid[leaf_idx] && leaf_req_ready[leaf_idx]) begin
                    done = 1;
                    break;
                end
            end
            leaf_req_valid[leaf_idx] = 1'b0;
            if (!done) $fatal(1, "[DTI TREE] leaf request timeout leaf=%0d", leaf_idx);
        end
    endtask

    task automatic send_leaf_packet2(
        input int unsigned leaf_idx,
        input logic [89:0] payload0,
        input logic [89:0] payload1,
        input logic [5:0] srcid
    );
        begin
            send_leaf_beat(leaf_idx, payload0, srcid, 1'b0);
            send_leaf_beat(leaf_idx, payload1, srcid, 1'b1);
        end
    endtask

    task automatic collect_root_req(
        output logic [89:0] payload,
        output logic [5:0] srcid,
        output logic last
    );
        bit got_req;
        begin
            got_req = 0;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk);
                if (top_tcu_req_tniu_req_valid && top_tcu_req_tniu_req_ready) begin
                    payload = top_tcu_req_tniu_req_payload;
                    srcid = top_tcu_req_tniu_req_srcid;
                    last = top_tcu_req_tniu_req_last;
                    got_req = 1;
                    break;
                end
            end
            if (!got_req) $fatal(1, "[DTI TREE] root request timeout");
        end
    endtask

    task automatic expect_root_req(
        input logic [89:0] exp_payload,
        input logic [5:0] exp_srcid,
        input logic exp_last
    );
        logic [89:0] payload;
        logic [5:0] srcid;
        logic last;
        begin
            collect_root_req(payload, srcid, last);
            if (payload !== exp_payload) $fatal(1, "[DTI TREE] root payload mismatch exp=%h act=%h", exp_payload, payload);
            if (srcid !== exp_srcid) $fatal(1, "[DTI TREE] root srcid mismatch exp=%0d act=%0d", exp_srcid, srcid);
            if (last !== exp_last) $fatal(1, "[DTI TREE] root last mismatch exp=%0b act=%0b", exp_last, last);
        end
    endtask

    task automatic send_root_rsp(
        input logic [89:0] payload,
        input logic [5:0] srcid,
        input logic last
    );
        bit done;
        begin
            done = 0;
            @(negedge clk);
            top_tcu_rsp_tniu_rsp_payload = payload;
            top_tcu_rsp_tniu_rsp_srcid = srcid;
            top_tcu_rsp_tniu_rsp_last = last;
            top_tcu_rsp_tniu_rsp_valid = 1'b1;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk);
                if (top_tcu_rsp_tniu_rsp_valid && top_tcu_rsp_tniu_rsp_ready) begin
                    done = 1;
                    break;
                end
            end
            top_tcu_rsp_tniu_rsp_valid = 1'b0;
            if (!done) $fatal(1, "[DTI TREE] root response timeout srcid=%0d", srcid);
        end
    endtask

    task automatic expect_leaf_rsp(
        input int unsigned leaf_idx,
        input logic [89:0] exp_payload,
        input logic [5:0] exp_srcid,
        input logic exp_last
    );
        bit got_rsp;
        begin
            got_rsp = 0;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk);
                if (leaf_rsp_valid[leaf_idx] && leaf_rsp_ready[leaf_idx]) begin
                    got_rsp = 1;
                    if (leaf_rsp_payload[leaf_idx] !== exp_payload) $fatal(1, "[DTI TREE] leaf %0d payload mismatch exp=%h act=%h", leaf_idx, exp_payload, leaf_rsp_payload[leaf_idx]);
                    if (leaf_rsp_srcid[leaf_idx] !== exp_srcid) $fatal(1, "[DTI TREE] leaf %0d srcid mismatch exp=%0d act=%0d", leaf_idx, exp_srcid, leaf_rsp_srcid[leaf_idx]);
                    if (leaf_rsp_last[leaf_idx] !== exp_last) $fatal(1, "[DTI TREE] leaf %0d last mismatch exp=%0b act=%0b", leaf_idx, exp_last, leaf_rsp_last[leaf_idx]);
                    break;
                end
            end
            if (!got_rsp) $fatal(1, "[DTI TREE] leaf response timeout leaf=%0d", leaf_idx);
        end
    endtask

    task automatic tc_reset;
        begin
            if ($isunknown({leaf_req_ready, leaf_rsp_valid, top_tcu_req_tniu_req_valid, top_tcu_rsp_tniu_rsp_ready})) begin
                $fatal(1, "[DTI TREE] tc_reset observed X/Z after reset");
            end
            pass_count++;
        end
    endtask

    task automatic tc_req_routing;
        logic [89:0] payload;
        begin
            for (int i = 0; i < LEAF_NUM; i++) begin
                payload = 90'h1000 + i;
                fork
                    send_leaf_beat(i, payload, leaf_min[i] + 1, 1'b1);
                    expect_root_req(payload, leaf_min[i] + 1, 1'b1);
                join
            end
            pass_count++;
        end
    endtask

    task automatic tc_rsp_routing;
        logic [89:0] payload;
        begin
            for (int i = 0; i < LEAF_NUM; i++) begin
                payload = 90'h2000 + i;
                fork
                    send_root_rsp(payload, leaf_min[i] + 2, 1'b1);
                    expect_leaf_rsp(i, payload, leaf_min[i] + 2, 1'b1);
                join
            end
            pass_count++;
        end
    endtask

    task automatic tc_boundary_ids;
        logic [89:0] payload_lo;
        logic [89:0] payload_hi;
        begin
            for (int i = 0; i < LEAF_NUM; i++) begin
                payload_lo = 90'h3000 + i;
                payload_hi = 90'h4000 + i;
                fork
                    send_leaf_beat(i, payload_lo, leaf_min[i][5:0], 1'b1);
                    expect_root_req(payload_lo, leaf_min[i][5:0], 1'b1);
                join
                fork
                    send_leaf_beat(i, payload_hi, leaf_max[i][5:0], 1'b1);
                    expect_root_req(payload_hi, leaf_max[i][5:0], 1'b1);
                join
                fork
                    send_root_rsp(payload_lo, leaf_min[i][5:0], 1'b1);
                    expect_leaf_rsp(i, payload_lo, leaf_min[i][5:0], 1'b1);
                join
                fork
                    send_root_rsp(payload_hi, leaf_max[i][5:0], 1'b1);
                    expect_leaf_rsp(i, payload_hi, leaf_max[i][5:0], 1'b1);
                join
            end
            pass_count++;
        end
    endtask

    task automatic tc_concurrent_branches;
        logic [89:0] payload0;
        logic [89:0] payload1;
        logic [89:0] req_payload0;
        logic [89:0] req_payload1;
        logic [5:0] req_srcid0;
        logic [5:0] req_srcid1;
        logic req_last0;
        logic req_last1;
        begin
            payload0 = 90'h5000;
            payload1 = 90'h6000;
            fork
                send_leaf_beat(0, payload0, leaf_min[0][5:0], 1'b1);
                send_leaf_beat(6, payload1, leaf_min[6][5:0], 1'b1);
                begin
                    collect_root_req(req_payload0, req_srcid0, req_last0);
                    collect_root_req(req_payload1, req_srcid1, req_last1);
                end
            join
            if (!(((req_payload0 == payload0) && (req_srcid0 == leaf_min[0][5:0]) && (req_payload1 == payload1) && (req_srcid1 == leaf_min[6][5:0])) ||
                  ((req_payload0 == payload1) && (req_srcid0 == leaf_min[6][5:0]) && (req_payload1 == payload0) && (req_srcid1 == leaf_min[0][5:0])))) begin
                $fatal(1, "[DTI TREE] concurrent branch routing mismatch");
            end
            if (!(req_last0 && req_last1)) $fatal(1, "[DTI TREE] concurrent branch last mismatch");
            pass_count++;
        end
    endtask

    task automatic tc_req_sticky;
        logic [89:0] payload0;
        logic [89:0] payload1;
        logic [89:0] payload2;
        logic [89:0] req_payload;
        logic [5:0] req_srcid;
        logic req_last;
        begin
            payload0 = 90'h7000;
            payload1 = 90'h7001;
            payload2 = 90'h8000;
            fork
                send_leaf_packet2(0, payload0, payload1, leaf_min[0][5:0]);
                send_leaf_beat(1, payload2, leaf_min[1][5:0], 1'b1);
                begin
                    collect_root_req(req_payload, req_srcid, req_last);
                    if ((req_payload !== payload0) || (req_srcid !== leaf_min[0][5:0]) || req_last) $fatal(1, "[DTI TREE] sticky first beat mismatch");
                    collect_root_req(req_payload, req_srcid, req_last);
                    if ((req_payload !== payload1) || (req_srcid !== leaf_min[0][5:0]) || !req_last) $fatal(1, "[DTI TREE] sticky second beat mismatch");
                    collect_root_req(req_payload, req_srcid, req_last);
                    if ((req_payload !== payload2) || (req_srcid !== leaf_min[1][5:0]) || !req_last) $fatal(1, "[DTI TREE] sticky trailing beat mismatch");
                end
            join
            pass_count++;
        end
    endtask

    dti_logic_topo dut (
        .clk(clk),
        .rst_n(rst_n),
        .pcie_eth_req_iniu0_req_last(leaf_req_last[0]),
        .pcie_eth_req_iniu0_req_payload(leaf_req_payload[0]),
        .pcie_eth_req_iniu0_req_ready(leaf_req_ready[0]),
        .pcie_eth_req_iniu0_req_srcid(leaf_req_srcid[0]),
        .pcie_eth_req_iniu0_req_valid(leaf_req_valid[0]),
        .pcie_eth_rsp_iniu0_rsp_last(leaf_rsp_last[0]),
        .pcie_eth_rsp_iniu0_rsp_payload(leaf_rsp_payload[0]),
        .pcie_eth_rsp_iniu0_rsp_ready(leaf_rsp_ready[0]),
        .pcie_eth_rsp_iniu0_rsp_srcid(leaf_rsp_srcid[0]),
        .pcie_eth_rsp_iniu0_rsp_valid(leaf_rsp_valid[0]),
        .vpu_req_iniu1_req_last(leaf_req_last[1]),
        .vpu_req_iniu1_req_payload(leaf_req_payload[1]),
        .vpu_req_iniu1_req_ready(leaf_req_ready[1]),
        .vpu_req_iniu1_req_srcid(leaf_req_srcid[1]),
        .vpu_req_iniu1_req_valid(leaf_req_valid[1]),
        .vpu_rsp_iniu1_rsp_last(leaf_rsp_last[1]),
        .vpu_rsp_iniu1_rsp_payload(leaf_rsp_payload[1]),
        .vpu_rsp_iniu1_rsp_ready(leaf_rsp_ready[1]),
        .vpu_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[1]),
        .vpu_rsp_iniu1_rsp_valid(leaf_rsp_valid[1]),
        .dsp2_req_iniu2_req_last(leaf_req_last[2]),
        .dsp2_req_iniu2_req_payload(leaf_req_payload[2]),
        .dsp2_req_iniu2_req_ready(leaf_req_ready[2]),
        .dsp2_req_iniu2_req_srcid(leaf_req_srcid[2]),
        .dsp2_req_iniu2_req_valid(leaf_req_valid[2]),
        .dsp2_rsp_iniu2_rsp_last(leaf_rsp_last[2]),
        .dsp2_rsp_iniu2_rsp_payload(leaf_rsp_payload[2]),
        .dsp2_rsp_iniu2_rsp_ready(leaf_rsp_ready[2]),
        .dsp2_rsp_iniu2_rsp_srcid(leaf_rsp_srcid[2]),
        .dsp2_rsp_iniu2_rsp_valid(leaf_rsp_valid[2]),
        .dsp1_req_iniu1_req_last(leaf_req_last[3]),
        .dsp1_req_iniu1_req_payload(leaf_req_payload[3]),
        .dsp1_req_iniu1_req_ready(leaf_req_ready[3]),
        .dsp1_req_iniu1_req_srcid(leaf_req_srcid[3]),
        .dsp1_req_iniu1_req_valid(leaf_req_valid[3]),
        .dsp1_rsp_iniu1_rsp_last(leaf_rsp_last[3]),
        .dsp1_rsp_iniu1_rsp_payload(leaf_rsp_payload[3]),
        .dsp1_rsp_iniu1_rsp_ready(leaf_rsp_ready[3]),
        .dsp1_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[3]),
        .dsp1_rsp_iniu1_rsp_valid(leaf_rsp_valid[3]),
        .dsp0_req_iniu1_req_last(leaf_req_last[4]),
        .dsp0_req_iniu1_req_payload(leaf_req_payload[4]),
        .dsp0_req_iniu1_req_ready(leaf_req_ready[4]),
        .dsp0_req_iniu1_req_srcid(leaf_req_srcid[4]),
        .dsp0_req_iniu1_req_valid(leaf_req_valid[4]),
        .dsp0_rsp_iniu1_rsp_last(leaf_rsp_last[4]),
        .dsp0_rsp_iniu1_rsp_payload(leaf_rsp_payload[4]),
        .dsp0_rsp_iniu1_rsp_ready(leaf_rsp_ready[4]),
        .dsp0_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[4]),
        .dsp0_rsp_iniu1_rsp_valid(leaf_rsp_valid[4]),
        .noc_tbu1_req_iniu1_req_last(leaf_req_last[5]),
        .noc_tbu1_req_iniu1_req_payload(leaf_req_payload[5]),
        .noc_tbu1_req_iniu1_req_ready(leaf_req_ready[5]),
        .noc_tbu1_req_iniu1_req_srcid(leaf_req_srcid[5]),
        .noc_tbu1_req_iniu1_req_valid(leaf_req_valid[5]),
        .noc_tbu1_rsp_iniu1_rsp_last(leaf_rsp_last[5]),
        .noc_tbu1_rsp_iniu1_rsp_payload(leaf_rsp_payload[5]),
        .noc_tbu1_rsp_iniu1_rsp_ready(leaf_rsp_ready[5]),
        .noc_tbu1_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[5]),
        .noc_tbu1_rsp_iniu1_rsp_valid(leaf_rsp_valid[5]),
        .usb_ufs_req_iniu0_req_last(leaf_req_last[6]),
        .usb_ufs_req_iniu0_req_payload(leaf_req_payload[6]),
        .usb_ufs_req_iniu0_req_ready(leaf_req_ready[6]),
        .usb_ufs_req_iniu0_req_srcid(leaf_req_srcid[6]),
        .usb_ufs_req_iniu0_req_valid(leaf_req_valid[6]),
        .usb_ufs_rsp_iniu0_rsp_last(leaf_rsp_last[6]),
        .usb_ufs_rsp_iniu0_rsp_payload(leaf_rsp_payload[6]),
        .usb_ufs_rsp_iniu0_rsp_ready(leaf_rsp_ready[6]),
        .usb_ufs_rsp_iniu0_rsp_srcid(leaf_rsp_srcid[6]),
        .usb_ufs_rsp_iniu0_rsp_valid(leaf_rsp_valid[6]),
        .mipi0_req_iniu1_req_last(leaf_req_last[7]),
        .mipi0_req_iniu1_req_payload(leaf_req_payload[7]),
        .mipi0_req_iniu1_req_ready(leaf_req_ready[7]),
        .mipi0_req_iniu1_req_srcid(leaf_req_srcid[7]),
        .mipi0_req_iniu1_req_valid(leaf_req_valid[7]),
        .mipi0_rsp_iniu1_rsp_last(leaf_rsp_last[7]),
        .mipi0_rsp_iniu1_rsp_payload(leaf_rsp_payload[7]),
        .mipi0_rsp_iniu1_rsp_ready(leaf_rsp_ready[7]),
        .mipi0_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[7]),
        .mipi0_rsp_iniu1_rsp_valid(leaf_rsp_valid[7]),
        .mipi1_req_iniu2_req_last(leaf_req_last[8]),
        .mipi1_req_iniu2_req_payload(leaf_req_payload[8]),
        .mipi1_req_iniu2_req_ready(leaf_req_ready[8]),
        .mipi1_req_iniu2_req_srcid(leaf_req_srcid[8]),
        .mipi1_req_iniu2_req_valid(leaf_req_valid[8]),
        .mipi1_rsp_iniu2_rsp_last(leaf_rsp_last[8]),
        .mipi1_rsp_iniu2_rsp_payload(leaf_rsp_payload[8]),
        .mipi1_rsp_iniu2_rsp_ready(leaf_rsp_ready[8]),
        .mipi1_rsp_iniu2_rsp_srcid(leaf_rsp_srcid[8]),
        .mipi1_rsp_iniu2_rsp_valid(leaf_rsp_valid[8]),
        .camera_req_iniu3_req_last(leaf_req_last[9]),
        .camera_req_iniu3_req_payload(leaf_req_payload[9]),
        .camera_req_iniu3_req_ready(leaf_req_ready[9]),
        .camera_req_iniu3_req_srcid(leaf_req_srcid[9]),
        .camera_req_iniu3_req_valid(leaf_req_valid[9]),
        .camera_rsp_iniu3_rsp_last(leaf_rsp_last[9]),
        .camera_rsp_iniu3_rsp_payload(leaf_rsp_payload[9]),
        .camera_rsp_iniu3_rsp_ready(leaf_rsp_ready[9]),
        .camera_rsp_iniu3_rsp_srcid(leaf_rsp_srcid[9]),
        .camera_rsp_iniu3_rsp_valid(leaf_rsp_valid[9]),
        .noc_tbu0_req_iniu1_req_last(leaf_req_last[10]),
        .noc_tbu0_req_iniu1_req_payload(leaf_req_payload[10]),
        .noc_tbu0_req_iniu1_req_ready(leaf_req_ready[10]),
        .noc_tbu0_req_iniu1_req_srcid(leaf_req_srcid[10]),
        .noc_tbu0_req_iniu1_req_valid(leaf_req_valid[10]),
        .noc_tbu0_rsp_iniu1_rsp_last(leaf_rsp_last[10]),
        .noc_tbu0_rsp_iniu1_rsp_payload(leaf_rsp_payload[10]),
        .noc_tbu0_rsp_iniu1_rsp_ready(leaf_rsp_ready[10]),
        .noc_tbu0_rsp_iniu1_rsp_srcid(leaf_rsp_srcid[10]),
        .noc_tbu0_rsp_iniu1_rsp_valid(leaf_rsp_valid[10]),
        .top_tcu_req_tniu_req_last(top_tcu_req_tniu_req_last),
        .top_tcu_req_tniu_req_payload(top_tcu_req_tniu_req_payload),
        .top_tcu_req_tniu_req_ready(top_tcu_req_tniu_req_ready),
        .top_tcu_req_tniu_req_srcid(top_tcu_req_tniu_req_srcid),
        .top_tcu_req_tniu_req_valid(top_tcu_req_tniu_req_valid),
        .top_tcu_rsp_tniu_rsp_last(top_tcu_rsp_tniu_rsp_last),
        .top_tcu_rsp_tniu_rsp_payload(top_tcu_rsp_tniu_rsp_payload),
        .top_tcu_rsp_tniu_rsp_ready(top_tcu_rsp_tniu_rsp_ready),
        .top_tcu_rsp_tniu_rsp_srcid(top_tcu_rsp_tniu_rsp_srcid),
        .top_tcu_rsp_tniu_rsp_valid(top_tcu_rsp_tniu_rsp_valid)
    );

    initial begin
        leaf_min[0] = 0;  leaf_max[0] = 3;   leaf_name[0] = "pcie_eth";
        leaf_min[1] = 4;  leaf_max[1] = 7;   leaf_name[1] = "vpu";
        leaf_min[2] = 8;  leaf_max[2] = 11;  leaf_name[2] = "dsp2";
        leaf_min[3] = 12; leaf_max[3] = 15;  leaf_name[3] = "dsp1";
        leaf_min[4] = 16; leaf_max[4] = 19;  leaf_name[4] = "dsp0";
        leaf_min[5] = 20; leaf_max[5] = 23;  leaf_name[5] = "noc_tbu1";
        leaf_min[6] = 24; leaf_max[6] = 27;  leaf_name[6] = "usb_ufs";
        leaf_min[7] = 28; leaf_max[7] = 31;  leaf_name[7] = "mipi0";
        leaf_min[8] = 32; leaf_max[8] = 35;  leaf_name[8] = "mipi1";
        leaf_min[9] = 36; leaf_max[9] = 39;  leaf_name[9] = "camera";
        leaf_min[10] = 40; leaf_max[10] = 43; leaf_name[10] = "noc_tbu0";
    end

    initial begin
        pass_count = 0;
        if (!$value$plusargs("TESTCASE=%s", testcase)) testcase = "all";
        if ($test$plusargs("DUMP_FSDB")) begin
            $fsdbDumpfile("dti_logic_topo_tree.fsdb");
            $fsdbDumpvars(0, tb_dti_logic_topo_tree, "+all");
        end

        if (testcase == "all") begin
            reset_dut(); tc_reset();
            reset_dut(); tc_req_routing();
            reset_dut(); tc_rsp_routing();
            reset_dut(); tc_boundary_ids();
            reset_dut(); tc_concurrent_branches();
            reset_dut(); tc_req_sticky();
        end else begin
            reset_dut();
            if (testcase == "tc_reset") tc_reset();
            else if (testcase == "tc_req_routing") tc_req_routing();
            else if (testcase == "tc_rsp_routing") tc_rsp_routing();
            else if (testcase == "tc_boundary_ids") tc_boundary_ids();
            else if (testcase == "tc_concurrent_branches") tc_concurrent_branches();
            else if (testcase == "tc_req_sticky") tc_req_sticky();
            else $fatal(1, "[DTI TREE] Unknown TESTCASE=%s", testcase);
        end

        repeat (10) @(posedge clk);
        $display("[DTI TREE] PASS: %0d tests passed", pass_count);
        $finish;
    end

    initial begin
        #(TIMEOUT_CYCLES * 20);
        $fatal(1, "[DTI TREE] Global timeout");
    end
endmodule
`timescale 1ns/1ps

module tb_sts_decoder_lut_min;
    import lwnoc_sts_pack::*;

    localparam int unsigned L0_SLOT_NUM        = 10;
    localparam int unsigned L1_SLOT_NUM        = 7;
    localparam int unsigned L0_ROUTE_DST_WIDTH = $clog2(L0_SLOT_NUM);
    localparam int unsigned L1_ROUTE_DST_WIDTH = $clog2(L1_SLOT_NUM);
    localparam int unsigned TB_DBG_TIMESTAMP_WIDTH = `STS_NETWORK_DEC_DBG_TIMESTAMP_WIDTH;
    localparam int unsigned TB_DBG_DATA_WIDTH      = `STS_NETWORK_DEC_DBG_DATA_WIDTH;

    logic clk;
    logic rst_n;

    logic                     l0_mst_req_vld;
    logic                     l0_mst_req_rdy;
    logic [STS_REQ_WIDTH-1:0] l0_mst_req_pld;
    logic                     l0_mst_rsp_vld;
    logic                     l0_mst_rsp_rdy;
    logic [STS_RSP_WIDTH-1:0] l0_mst_rsp_pld;
    logic [L0_SLOT_NUM-1:0]   l0_slv_req_vld;
    logic [L0_SLOT_NUM-1:0]   l0_slv_req_rdy;
    logic [STS_REQ_WIDTH-1:0] l0_slv_req_pld;
    logic [L0_SLOT_NUM-1:0]   l0_slv_rsp_vld;
    logic [L0_SLOT_NUM-1:0]   l0_slv_rsp_rdy;
    logic [STS_RSP_WIDTH-1:0] l0_slv_rsp_pld [L0_SLOT_NUM-1:0];
    logic [L0_SLOT_NUM*CHANNEL_TOTAL_WIDTH-1:0] l0_slv_cti_channel_in;
    logic [L0_SLOT_NUM*CHANNEL_TOTAL_WIDTH-1:0] l0_slv_cti_channel_out;
    logic [CHANNEL_TOTAL_WIDTH-1:0]             l0_mst_cti_channel_in;
    logic [CHANNEL_TOTAL_WIDTH-1:0]             l0_mst_cti_channel_out;
    logic [TB_DBG_TIMESTAMP_WIDTH-1:0]             l0_mst_dbg_timestamp;
    logic [L0_SLOT_NUM*TB_DBG_TIMESTAMP_WIDTH-1:0] l0_slv_dbg_timestamp;
    logic [L0_SLOT_NUM*TB_DBG_DATA_WIDTH-1:0]      l0_slv_dbg_data;
    logic [TB_DBG_DATA_WIDTH-1:0]                  l0_mst_dbg_data;

    logic                     l1_mst_req_vld;
    logic                     l1_mst_req_rdy;
    logic [STS_REQ_WIDTH-1:0] l1_mst_req_pld;
    logic                     l1_mst_rsp_vld;
    logic                     l1_mst_rsp_rdy;
    logic [STS_RSP_WIDTH-1:0] l1_mst_rsp_pld;
    logic [L1_SLOT_NUM-1:0]   l1_slv_req_vld;
    logic [L1_SLOT_NUM-1:0]   l1_slv_req_rdy;
    logic [STS_REQ_WIDTH-1:0] l1_slv_req_pld;
    logic [L1_SLOT_NUM-1:0]   l1_slv_rsp_vld;
    logic [L1_SLOT_NUM-1:0]   l1_slv_rsp_rdy;
    logic [STS_RSP_WIDTH-1:0] l1_slv_rsp_pld [L1_SLOT_NUM-1:0];
    logic [L1_SLOT_NUM*CHANNEL_TOTAL_WIDTH-1:0] l1_slv_cti_channel_in;
    logic [L1_SLOT_NUM*CHANNEL_TOTAL_WIDTH-1:0] l1_slv_cti_channel_out;
    logic [CHANNEL_TOTAL_WIDTH-1:0]             l1_mst_cti_channel_in;
    logic [CHANNEL_TOTAL_WIDTH-1:0]             l1_mst_cti_channel_out;
    logic [TB_DBG_TIMESTAMP_WIDTH-1:0]             l1_mst_dbg_timestamp;
    logic [L1_SLOT_NUM*TB_DBG_TIMESTAMP_WIDTH-1:0] l1_slv_dbg_timestamp;
    logic [L1_SLOT_NUM*TB_DBG_DATA_WIDTH-1:0]      l1_slv_dbg_data;
    logic [TB_DBG_DATA_WIDTH-1:0]                  l1_mst_dbg_data;

    sts_req_typ l0_req_s;
    sts_req_typ l1_req_s;
    int unsigned pass_count;
    int unsigned fail_count;

    assign l0_mst_req_pld = l0_req_s;
    assign l1_mst_req_pld = l1_req_s;

    always #5 clk = ~clk;

    function automatic logic [L0_SLOT_NUM-1:0] onehot10(input int unsigned idx);
        logic [L0_SLOT_NUM-1:0] result;
        result = '0;
        result[idx] = 1'b1;
        return result;
    endfunction

    function automatic logic [L1_SLOT_NUM-1:0] onehot7(input int unsigned idx);
        logic [L1_SLOT_NUM-1:0] result;
        result = '0;
        result[idx] = 1'b1;
        return result;
    endfunction

    task automatic check_l0_hit(
        input string label,
        input logic [TGT_ID_WIDTH-1:0] tgt_id,
        input logic [L0_ROUTE_DST_WIDTH-1:0] expected_slot
    );
        l0_req_s            = '0;
        l0_req_s.cmn.src_id = 'h11;
        l0_req_s.cmn.txn_id = 'h01;
        l0_req_s.cmn.tgt_id = tgt_id;
        l0_req_s.cmn.opcode = cfgOpcode_RdReq;
        l0_mst_req_vld      = 1'b1;
        #1;
        if (!dut_l0.route_lut_hit) begin
            fail_count++;
            $display("[FAIL] l0 %-24s tgt_id=%0d route_lut_hit=0 expected_slot=%0d", label, tgt_id, expected_slot);
        end
        else if (dut_l0.route_lut_dst_idx !== expected_slot) begin
            fail_count++;
            $display("[FAIL] l0 %-24s tgt_id=%0d route_lut_dst_idx=%0d expected_slot=%0d", label, tgt_id, dut_l0.route_lut_dst_idx, expected_slot);
        end
        else if (l0_slv_req_vld !== onehot10(expected_slot)) begin
            fail_count++;
            $display("[FAIL] l0 %-24s tgt_id=%0d slv_req_vld=%b expected=%b", label, tgt_id, l0_slv_req_vld, onehot10(expected_slot));
        end
        else begin
            pass_count++;
            $display("[PASS] l0 %-24s tgt_id=%0d slot=%0d req_vld=%b", label, tgt_id, expected_slot, l0_slv_req_vld);
        end
        l0_mst_req_vld = 1'b0;
        l0_req_s       = '0;
        #1;
    endtask

    task automatic check_l1_hit(
        input string label,
        input logic [TGT_ID_WIDTH-1:0] tgt_id,
        input logic [L1_ROUTE_DST_WIDTH-1:0] expected_slot
    );
        l1_req_s            = '0;
        l1_req_s.cmn.src_id = 'h22;
        l1_req_s.cmn.txn_id = 'h02;
        l1_req_s.cmn.tgt_id = tgt_id;
        l1_req_s.cmn.opcode = cfgOpcode_RdReq;
        l1_mst_req_vld      = 1'b1;
        #1;
        if (!dut_l1.route_lut_hit) begin
            fail_count++;
            $display("[FAIL] l1 %-24s tgt_id=%0d route_lut_hit=0 expected_slot=%0d", label, tgt_id, expected_slot);
        end
        else if (dut_l1.route_lut_dst_idx !== expected_slot) begin
            fail_count++;
            $display("[FAIL] l1 %-24s tgt_id=%0d route_lut_dst_idx=%0d expected_slot=%0d", label, tgt_id, dut_l1.route_lut_dst_idx, expected_slot);
        end
        else if (l1_slv_req_vld !== onehot7(expected_slot)) begin
            fail_count++;
            $display("[FAIL] l1 %-24s tgt_id=%0d slv_req_vld=%b expected=%b", label, tgt_id, l1_slv_req_vld, onehot7(expected_slot));
        end
        else begin
            pass_count++;
            $display("[PASS] l1 %-24s tgt_id=%0d slot=%0d req_vld=%b", label, tgt_id, expected_slot, l1_slv_req_vld);
        end
        l1_mst_req_vld = 1'b0;
        l1_req_s       = '0;
        #1;
    endtask

    task automatic check_l0_miss(
        input string label,
        input logic [TGT_ID_WIDTH-1:0] tgt_id
    );
        l0_req_s            = '0;
        l0_req_s.cmn.src_id = 'h33;
        l0_req_s.cmn.txn_id = 'h03;
        l0_req_s.cmn.tgt_id = tgt_id;
        l0_req_s.cmn.opcode = cfgOpcode_RdReq;
        l0_mst_req_vld      = 1'b1;
        #1;
        if (dut_l0.route_lut_hit) begin
            fail_count++;
            $display("[FAIL] l0 %-24s tgt_id=%0d unexpected route_lut_hit=1", label, tgt_id);
        end
        else if (l0_slv_req_vld !== '0) begin
            fail_count++;
            $display("[FAIL] l0 %-24s tgt_id=%0d slv_req_vld=%b expected=0", label, tgt_id, l0_slv_req_vld);
        end
        else begin
            pass_count++;
            $display("[PASS] l0 %-24s tgt_id=%0d miss observed", label, tgt_id);
        end
        l0_mst_req_vld = 1'b0;
        l0_req_s       = '0;
        #1;
    endtask

    sts_noc_dec_node #(
        .SLAVE_NUM          (L0_SLOT_NUM),
        .ROUTE_VLD_TABLE    (`STS_NOC_DEC_NODE_1TO10_WRAP_ROUTE_VLD_TABLE),
        .ROUTE_DST_TABLE    (`STS_NOC_DEC_NODE_1TO10_WRAP_ROUTE_DST_TABLE),
        .ROUTE_BASE         (`STS_NOC_DEC_NODE_1TO10_WRAP_ROUTE_BASE),
        .ROUTE_MASK         (`STS_NOC_DEC_NODE_1TO10_WRAP_ROUTE_MASK),
        .DBG_TIMESTAMP_WIDTH(TB_DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (TB_DBG_DATA_WIDTH)
    ) dut_l0 (
        .clk                (clk                   ),
        .rst_n              (rst_n                 ),
        .mst_req_vld        (l0_mst_req_vld        ),
        .mst_req_rdy        (l0_mst_req_rdy        ),
        .mst_req_pld        (l0_mst_req_pld        ),
        .mst_rsp_vld        (l0_mst_rsp_vld        ),
        .mst_rsp_rdy        (l0_mst_rsp_rdy        ),
        .mst_rsp_pld        (l0_mst_rsp_pld        ),
        .slv_req_vld        (l0_slv_req_vld        ),
        .slv_req_rdy        (l0_slv_req_rdy        ),
        .slv_req_pld        (l0_slv_req_pld        ),
        .slv_rsp_vld        (l0_slv_rsp_vld        ),
        .slv_rsp_rdy        (l0_slv_rsp_rdy        ),
        .slv_rsp_pld        (l0_slv_rsp_pld        ),
        .mst_cti_channel_in (l0_mst_cti_channel_in ),
        .mst_cti_channel_out(l0_mst_cti_channel_out),
        .slv_cti_channel_in (l0_slv_cti_channel_in ),
        .slv_cti_channel_out(l0_slv_cti_channel_out),
        .mst_dbg_timestamp  (l0_mst_dbg_timestamp  ),
        .slv_dbg_timestamp  (l0_slv_dbg_timestamp  ),
        .slv_dbg_data       (l0_slv_dbg_data       ),
        .mst_dbg_data       (l0_mst_dbg_data       )
    );

    sts_noc_dec_node #(
        .SLAVE_NUM          (L1_SLOT_NUM),
        .ROUTE_VLD_TABLE    (`STS_NOC_DEC_NODE_1TO7_WRAP_ROUTE_VLD_TABLE),
        .ROUTE_DST_TABLE    (`STS_NOC_DEC_NODE_1TO7_WRAP_ROUTE_DST_TABLE),
        .ROUTE_BASE         (`STS_NOC_DEC_NODE_1TO7_WRAP_ROUTE_BASE),
        .ROUTE_MASK         (`STS_NOC_DEC_NODE_1TO7_WRAP_ROUTE_MASK),
        .DBG_TIMESTAMP_WIDTH(TB_DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (TB_DBG_DATA_WIDTH)
    ) dut_l1 (
        .clk                (clk                   ),
        .rst_n              (rst_n                 ),
        .mst_req_vld        (l1_mst_req_vld        ),
        .mst_req_rdy        (l1_mst_req_rdy        ),
        .mst_req_pld        (l1_mst_req_pld        ),
        .mst_rsp_vld        (l1_mst_rsp_vld        ),
        .mst_rsp_rdy        (l1_mst_rsp_rdy        ),
        .mst_rsp_pld        (l1_mst_rsp_pld        ),
        .slv_req_vld        (l1_slv_req_vld        ),
        .slv_req_rdy        (l1_slv_req_rdy        ),
        .slv_req_pld        (l1_slv_req_pld        ),
        .slv_rsp_vld        (l1_slv_rsp_vld        ),
        .slv_rsp_rdy        (l1_slv_rsp_rdy        ),
        .slv_rsp_pld        (l1_slv_rsp_pld        ),
        .mst_cti_channel_in (l1_mst_cti_channel_in ),
        .mst_cti_channel_out(l1_mst_cti_channel_out),
        .slv_cti_channel_in (l1_slv_cti_channel_in ),
        .slv_cti_channel_out(l1_slv_cti_channel_out),
        .mst_dbg_timestamp  (l1_mst_dbg_timestamp  ),
        .slv_dbg_timestamp  (l1_slv_dbg_timestamp  ),
        .slv_dbg_data       (l1_slv_dbg_data       ),
        .mst_dbg_data       (l1_mst_dbg_data       )
    );

    initial begin
        clk                   = 1'b0;
        rst_n                 = 1'b0;
        l0_mst_req_vld        = 1'b0;
        l1_mst_req_vld        = 1'b0;
        l0_mst_rsp_rdy        = 1'b1;
        l1_mst_rsp_rdy        = 1'b1;
        l0_req_s              = '0;
        l1_req_s              = '0;
        l0_slv_req_rdy        = '1;
        l1_slv_req_rdy        = '1;
        l0_slv_rsp_vld        = '0;
        l1_slv_rsp_vld        = '0;
        l0_slv_cti_channel_in = '0;
        l1_slv_cti_channel_in = '0;
        l0_mst_cti_channel_in = '0;
        l1_mst_cti_channel_in = '0;
        l0_mst_dbg_timestamp  = '0;
        l1_mst_dbg_timestamp  = '0;
        l0_slv_dbg_data       = '0;
        l1_slv_dbg_data       = '0;
        pass_count            = 0;
        fail_count            = 0;

        for (int i = 0; i < L0_SLOT_NUM; i = i + 1) begin
            l0_slv_rsp_pld[i] = '0;
        end
        for (int i = 0; i < L1_SLOT_NUM; i = i + 1) begin
            l1_slv_rsp_pld[i] = '0;
        end

        repeat (3) @(posedge clk);
        rst_n = 1'b1;
        repeat (1) @(posedge clk);

        check_l0_hit("root.direct.s0", 9'd34, 4'd0);
        check_l0_hit("root.subtree.s8", 9'd10, 4'd8);
        check_l0_hit("root.subtree.s9", 9'd25, 4'd9);
        check_l1_hit("upper.direct.s0", 9'd10, 3'd0);
        check_l1_hit("upper.subtree.s6", 9'd16, 3'd6);
        check_l0_miss("root.miss.default", 9'h1FF);

        if (fail_count != 0) begin
            $fatal(1, "decoder LUT testcase FAILED: pass=%0d fail=%0d", pass_count, fail_count);
        end

        $display("[PASS] decoder LUT testcase passed: %0d checks", pass_count);
        $finish;
    end
endmodule
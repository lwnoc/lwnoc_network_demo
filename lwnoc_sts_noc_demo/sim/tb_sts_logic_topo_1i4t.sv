`timescale 1ns/1ps

module sts_demo_apb_stub_slave #(
    parameter int unsigned WORD_NUM = 16,
    parameter logic [31:0] INIT_PATTERN = 32'h1357_0000
)(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        psel,
    input  logic        penable,
    input  logic [31:0] paddr,
    input  logic        pwrite,
    input  logic [31:0] pwdata,
    input  logic [3:0]  pstrb,
    input  logic [7:0]  stall_cycles_cfg,
    output logic        pready,
    output logic [31:0] prdata,
    output logic        pslverr
);

    localparam int unsigned WORD_ADDR_LSB = 2;
    localparam int unsigned WORD_ADDR_MSB = WORD_ADDR_LSB + $clog2(WORD_NUM) - 1;

    logic [31:0] mem [0:WORD_NUM-1];
    logic [31:0] word_idx_full;
    logic [$clog2(WORD_NUM)-1:0] word_idx;
    logic access_hit;
    logic access_pending;
    logic [7:0] stall_cycles_left;

    assign word_idx_full = paddr[31:WORD_ADDR_LSB];
    assign word_idx = paddr[WORD_ADDR_MSB:WORD_ADDR_LSB];
    assign access_hit = (word_idx_full < WORD_NUM);
    assign pready = (stall_cycles_left == 0);
    assign prdata = access_hit ? mem[word_idx] : 32'hDEAD_BEEF;
    assign pslverr = psel && penable && !access_hit;

    always_ff @(posedge clk or negedge rst_n) begin
        int idx;
        if (!rst_n) begin
            stall_cycles_left <= '0;
            access_pending <= 1'b0;
            for (idx = 0; idx < WORD_NUM; idx++) begin
                mem[idx] <= INIT_PATTERN + idx;
            end
        end else begin
            if (psel && !penable && !access_pending) begin
                access_pending <= 1'b1;
                stall_cycles_left <= stall_cycles_cfg;
            end else if (access_pending && (stall_cycles_left != 0)) begin
                stall_cycles_left <= stall_cycles_left - 1'b1;
            end

            if (psel && penable && pready) begin
                access_pending <= 1'b0;
            end

            if (psel && penable && pready && pwrite && access_hit) begin
                if (pstrb[0]) mem[word_idx][7:0] <= pwdata[7:0];
                if (pstrb[1]) mem[word_idx][15:8] <= pwdata[15:8];
                if (pstrb[2]) mem[word_idx][23:16] <= pwdata[23:16];
                if (pstrb[3]) mem[word_idx][31:24] <= pwdata[31:24];
            end
        end
    end
endmodule

module tb_sts_logic_topo_1i4t;
    localparam int unsigned TNIU_NUM = 4;
    localparam int unsigned SYS_NUM = 10;
    localparam int unsigned TIMEOUT_CYCLES = 20000;

    logic iniu0_clk_sys = 1'b0;
    logic [TNIU_NUM-1:0] tniu_clk_sys = '0;
    logic clk_dst = 1'b0;
    logic clk_dbg_timer = 1'b0;
    logic iniu0_rstn_src = 1'b0;
    logic [TNIU_NUM-1:0] tniu_rstn_src = '0;
    logic rstn_dst = 1'b0;
    logic rstn_dbg_timer = 1'b0;

    logic [7:0] iniu0_node_id_porting_node_id;
    logic [31:0] iniu0_axi_porting_s_awaddr;
    logic [1:0] iniu0_axi_porting_s_awburst;
    logic [3:0] iniu0_axi_porting_s_awcache;
    logic [7:0] iniu0_axi_porting_s_awid;
    logic [7:0] iniu0_axi_porting_s_awlen;
    logic iniu0_axi_porting_s_awlock;
    logic [2:0] iniu0_axi_porting_s_awprot;
    logic [3:0] iniu0_axi_porting_s_awqos;
    logic iniu0_axi_porting_s_awready;
    logic [2:0] iniu0_axi_porting_s_awsize;
    logic [7:0] iniu0_axi_porting_s_awuser;
    logic iniu0_axi_porting_s_awvalid;
    logic [7:0] iniu0_axi_porting_s_bid;
    logic iniu0_axi_porting_s_bready;
    logic [1:0] iniu0_axi_porting_s_bresp;
    logic iniu0_axi_porting_s_bvalid;
    logic [31:0] iniu0_axi_porting_s_rdata;
    logic [7:0] iniu0_axi_porting_s_rid;
    logic iniu0_axi_porting_s_rlast;
    logic iniu0_axi_porting_s_rready;
    logic [1:0] iniu0_axi_porting_s_rresp;
    logic iniu0_axi_porting_s_rvalid;
    logic [31:0] iniu0_axi_porting_s_wdata;
    logic iniu0_axi_porting_s_wlast;
    logic iniu0_axi_porting_s_wready;
    logic [3:0] iniu0_axi_porting_s_wstrb;
    logic iniu0_axi_porting_s_wvalid;
    logic [31:0] iniu0_axi_porting_s_araddr;
    logic [1:0] iniu0_axi_porting_s_arburst;
    logic [3:0] iniu0_axi_porting_s_arcache;
    logic [7:0] iniu0_axi_porting_s_arid;
    logic [7:0] iniu0_axi_porting_s_arlen;
    logic iniu0_axi_porting_s_arlock;
    logic [2:0] iniu0_axi_porting_s_arprot;
    logic [3:0] iniu0_axi_porting_s_arqos;
    logic iniu0_axi_porting_s_arready;
    logic [2:0] iniu0_axi_porting_s_arsize;
    logic [7:0] iniu0_axi_porting_s_aruser;
    logic iniu0_axi_porting_s_arvalid;

    logic [TNIU_NUM-1:0][31:0] pmc_paddr;
    logic [TNIU_NUM-1:0] pmc_penable;
    logic [TNIU_NUM-1:0][2:0] pmc_pprot;
    logic [TNIU_NUM-1:0][31:0] pmc_prdata;
    logic [TNIU_NUM-1:0] pmc_pready;
    logic [TNIU_NUM-1:0] pmc_psel;
    logic [TNIU_NUM-1:0] pmc_pslverr;
    logic [TNIU_NUM-1:0][3:0] pmc_pstrb;
    logic [TNIU_NUM-1:0][31:0] pmc_pwdata;
    logic [TNIU_NUM-1:0] pmc_pwrite;

    logic [TNIU_NUM-1:0][31:0] sys_paddr;
    logic [TNIU_NUM-1:0] sys_penable;
    logic [TNIU_NUM-1:0][2:0] sys_pprot;
    logic [TNIU_NUM-1:0][SYS_NUM*32-1:0] sys_prdata;
    logic [TNIU_NUM-1:0][SYS_NUM-1:0] sys_pready;
    logic [TNIU_NUM-1:0][SYS_NUM-1:0] sys_psel;
    logic [TNIU_NUM-1:0][SYS_NUM-1:0] sys_pslverr;
    logic [TNIU_NUM-1:0][3:0] sys_pstrb;
    logic [TNIU_NUM-1:0][31:0] sys_pwdata;
    logic [TNIU_NUM-1:0] sys_pwrite;

    logic [7:0] pmc_stall_cfg [TNIU_NUM-1:0];
    logic [7:0] sys_stall_cfg [TNIU_NUM-1:0][SYS_NUM-1:0];

    int unsigned pass_count;
    int unsigned debug_lines;
    string testcase;

    // Phase offsets avoid artificial edge alignment between nominally async domains.
    initial begin
        #0.4;
        forever #1 iniu0_clk_sys = ~iniu0_clk_sys;
    end
    initial begin
        #1.3;
        forever #4 tniu_clk_sys[0] = ~tniu_clk_sys[0];
    end
    initial begin
        #0.9;
        forever #5 tniu_clk_sys[1] = ~tniu_clk_sys[1];
    end
    initial begin
        #1.7;
        forever #6 tniu_clk_sys[2] = ~tniu_clk_sys[2];
    end
    initial begin
        #0.6;
        forever #7 tniu_clk_sys[3] = ~tniu_clk_sys[3];
    end
    initial begin
        #0.2;
        forever #2 clk_dst = ~clk_dst;
    end
    initial begin
        #0.8;
        forever #3 clk_dbg_timer = ~clk_dbg_timer;
    end

    always @(posedge iniu0_clk_sys) begin
        if ($test$plusargs("DEBUG_STS") && (debug_lines < 128) &&
            (iniu0_axi_porting_s_awvalid || iniu0_axi_porting_s_wvalid || iniu0_axi_porting_s_bvalid ||
             dut.iniu0_TO_noc_dec_SIG_out_req_vld || dut.noc_dec_TO_iniu0_SIG_mst_rsp_vld ||
             dut.noc_dec_TO_tniu0_SIG_slv0_req_vld || dut.noc_dec_TO_tniu1_SIG_slv1_req_vld ||
             dut.noc_dec_TO_tniu2_SIG_slv2_req_vld || dut.noc_dec_TO_tniu3_SIG_slv3_req_vld ||
             dut.tniu0_TO_noc_dec_SIG_out_rsp_vld || dut.tniu1_TO_noc_dec_SIG_out_rsp_vld ||
             dut.tniu2_TO_noc_dec_SIG_out_rsp_vld || dut.tniu3_TO_noc_dec_SIG_out_rsp_vld)) begin
            debug_lines++;
            $display("[STS DBG] t=%0t awv=%0b awr=%0b wv=%0b wr=%0b bv=%0b br=%0b req=%0b rsp=%0b slv=%0b%0b%0b%0b trsp=%0b%0b%0b%0b",
                $time,
                iniu0_axi_porting_s_awvalid,
                iniu0_axi_porting_s_awready,
                iniu0_axi_porting_s_wvalid,
                iniu0_axi_porting_s_wready,
                iniu0_axi_porting_s_bvalid,
                iniu0_axi_porting_s_bready,
                dut.iniu0_TO_noc_dec_SIG_out_req_vld,
                dut.noc_dec_TO_iniu0_SIG_mst_rsp_vld,
                dut.noc_dec_TO_tniu3_SIG_slv3_req_vld,
                dut.noc_dec_TO_tniu2_SIG_slv2_req_vld,
                dut.noc_dec_TO_tniu1_SIG_slv1_req_vld,
                dut.noc_dec_TO_tniu0_SIG_slv0_req_vld,
                dut.tniu3_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu2_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu1_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu0_TO_noc_dec_SIG_out_rsp_vld);
        end
            if ($test$plusargs("DEBUG_STS") && (debug_lines < 256) &&
                (dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.req_vld_temp ||
                 dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.rsp_vld_temp)) begin
                debug_lines++;
                $display("[STS DBG SRC] t=%0t req_temp=%0b req_rdy=%0b rsp_temp=%0b rsp_rdy=%0b",
                $time,
                dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.req_vld_temp,
                    dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.req_rdy_temp,
                    dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.rsp_vld_temp,
                    dut.iniu0.u_sts_iniu_top.u_sts_iniu_sys.rsp_rdy_temp);
            end
    end

    always @(posedge clk_dst) begin
        if ($test$plusargs("DEBUG_STS") && (debug_lines < 256) &&
            (dut.iniu0_TO_noc_dec_SIG_out_req_vld || dut.noc_dec_TO_iniu0_SIG_mst_rsp_vld ||
             dut.noc_dec_TO_tniu0_SIG_slv0_req_vld || dut.noc_dec_TO_tniu1_SIG_slv1_req_vld ||
             dut.noc_dec_TO_tniu2_SIG_slv2_req_vld || dut.noc_dec_TO_tniu3_SIG_slv3_req_vld ||
             dut.tniu0_TO_noc_dec_SIG_out_rsp_vld || dut.tniu1_TO_noc_dec_SIG_out_rsp_vld ||
             dut.tniu2_TO_noc_dec_SIG_out_rsp_vld || dut.tniu3_TO_noc_dec_SIG_out_rsp_vld)) begin
            debug_lines++;
            $display("[STS DBG DST] t=%0t req=%0b/%0b rsp=%0b/%0b slv=%0b%0b%0b%0b trsp=%0b%0b%0b%0b dec_op=%0b t0_op=%0b t0_rsp=%0b/%0b apb_state=%0d rsp_pending=%0b apb_psel=%0b pen=%0b pready=%0b",
                $time,
                dut.iniu0_TO_noc_dec_SIG_out_req_vld,
                dut.noc_dec_TO_iniu0_SIG_mst_req_rdy,
                dut.noc_dec_TO_iniu0_SIG_mst_rsp_vld,
                dut.iniu0_TO_noc_dec_SIG_in_rsp_rdy,
                dut.noc_dec_TO_tniu3_SIG_slv3_req_vld,
                dut.noc_dec_TO_tniu2_SIG_slv2_req_vld,
                dut.noc_dec_TO_tniu1_SIG_slv1_req_vld,
                dut.noc_dec_TO_tniu0_SIG_slv0_req_vld,
                dut.tniu3_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu2_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu1_TO_noc_dec_SIG_out_rsp_vld,
                dut.tniu0_TO_noc_dec_SIG_out_rsp_vld,
                dut.iniu0.u_sts_iniu_top.u_sts_iniu_noc.rsp_m_pld.cmn.opcode,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.rsp_apb_tniu_pld.cmn.opcode,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.rsp_apb_tniu_vld,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.rsp_apb_tniu_rdy,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.u_sts_tniu_apb_noc.apb_state,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.u_sts_tniu_apb_noc.rsp_pending,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.psel_pre_dec,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.penable_pre_dec,
                dut.tniu0.u_sts_tniu_top.u_sts_tniu_noc.pready_pre_dec);
        end
    end

    function automatic logic [31:0] window_base(input int unsigned tniu_idx, input int unsigned slot_idx);
        return ((tniu_idx * 12 + slot_idx) << 12);
    endfunction

    function automatic logic [31:0] pmc_init_pattern(input int unsigned tniu_idx);
        return 32'hA000_0000 + (tniu_idx * 32'h1000_0000);
    endfunction

    function automatic logic [31:0] sys_init_pattern(input int unsigned tniu_idx, input int unsigned sys_idx);
        return 32'hA100_0000 + (tniu_idx * 32'h1000_0000) + (sys_idx * 32'h0100_0000);
    endfunction

    function automatic logic [31:0] apply_strobe(
        input logic [31:0] original,
        input logic [31:0] new_data,
        input logic [3:0] strobe
    );
        logic [31:0] result;
        result = original;
        if (strobe[0]) result[7:0] = new_data[7:0];
        if (strobe[1]) result[15:8] = new_data[15:8];
        if (strobe[2]) result[23:16] = new_data[23:16];
        if (strobe[3]) result[31:24] = new_data[31:24];
        return result;
    endfunction

    task automatic drive_axi_idle;
        begin
            iniu0_node_id_porting_node_id = 8'h01;
            iniu0_axi_porting_s_awaddr = '0;
            iniu0_axi_porting_s_awburst = 2'b01;
            iniu0_axi_porting_s_awcache = '0;
            iniu0_axi_porting_s_awid = '0;
            iniu0_axi_porting_s_awlen = '0;
            iniu0_axi_porting_s_awlock = 1'b0;
            iniu0_axi_porting_s_awprot = '0;
            iniu0_axi_porting_s_awqos = '0;
            iniu0_axi_porting_s_awsize = 3'd2;
            iniu0_axi_porting_s_awuser = '0;
            iniu0_axi_porting_s_awvalid = 1'b0;
            iniu0_axi_porting_s_bready = 1'b1;
            iniu0_axi_porting_s_rready = 1'b1;
            iniu0_axi_porting_s_wdata = '0;
            iniu0_axi_porting_s_wlast = 1'b1;
            iniu0_axi_porting_s_wstrb = 4'hf;
            iniu0_axi_porting_s_wvalid = 1'b0;
            iniu0_axi_porting_s_araddr = '0;
            iniu0_axi_porting_s_arburst = 2'b01;
            iniu0_axi_porting_s_arcache = '0;
            iniu0_axi_porting_s_arid = '0;
            iniu0_axi_porting_s_arlen = '0;
            iniu0_axi_porting_s_arlock = 1'b0;
            iniu0_axi_porting_s_arprot = '0;
            iniu0_axi_porting_s_arqos = '0;
            iniu0_axi_porting_s_arsize = 3'd2;
            iniu0_axi_porting_s_aruser = '0;
            iniu0_axi_porting_s_arvalid = 1'b0;
        end
    endtask

    task automatic set_all_stall(input int unsigned cycles);
        begin
            for (int t = 0; t < TNIU_NUM; t++) begin
                pmc_stall_cfg[t] = cycles[7:0];
                for (int s = 0; s < SYS_NUM; s++) begin
                    sys_stall_cfg[t][s] = cycles[7:0];
                end
            end
        end
    endtask

    task automatic reset_dut;
        begin
            drive_axi_idle();
            set_all_stall(0);
            iniu0_rstn_src = 1'b0;
            tniu_rstn_src = '0;
            rstn_dst = 1'b0;
            rstn_dbg_timer = 1'b0;
            repeat (12) @(posedge iniu0_clk_sys);
            iniu0_rstn_src = 1'b1;
            tniu_rstn_src = '1;
            rstn_dst = 1'b1;
            rstn_dbg_timer = 1'b1;
            repeat (12) @(posedge iniu0_clk_sys);
            repeat (12) @(posedge clk_dst);
        end
    endtask

    task automatic do_axi_write(
        input logic [31:0] addr,
        input logic [31:0] data,
        input logic [7:0] id,
        input logic [3:0] strb,
        input logic [1:0] exp_resp
    );
        bit aw_done;
        bit w_done;
        bit got_b;
        begin
            aw_done = 0;
            w_done = 0;
            got_b = 0;
            @(negedge iniu0_clk_sys);
            iniu0_axi_porting_s_awaddr = addr;
            iniu0_axi_porting_s_awid = id;
            iniu0_axi_porting_s_awvalid = 1'b1;
            iniu0_axi_porting_s_wdata = data;
            iniu0_axi_porting_s_wstrb = strb;
            iniu0_axi_porting_s_wvalid = 1'b1;
            fork
                begin
                    fork : aw_wait_or_timeout
                        begin
                            @(posedge iniu0_clk_sys iff iniu0_axi_porting_s_awready);
                            iniu0_axi_porting_s_awvalid = 1'b0;
                            aw_done = 1;
                        end
                        begin
                            repeat (TIMEOUT_CYCLES) @(posedge iniu0_clk_sys);
                        end
                    join_any
                    disable aw_wait_or_timeout;
                end
                begin
                    fork : w_wait_or_timeout
                        begin
                            @(posedge iniu0_clk_sys iff iniu0_axi_porting_s_wready);
                            iniu0_axi_porting_s_wvalid = 1'b0;
                            w_done = 1;
                        end
                        begin
                            repeat (TIMEOUT_CYCLES) @(posedge iniu0_clk_sys);
                        end
                    join_any
                    disable w_wait_or_timeout;
                end
            join
            if (!(aw_done && w_done)) $fatal(1, "[STS DEMO] WRITE timeout addr=0x%08h", addr);
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge iniu0_clk_sys);
                if (iniu0_axi_porting_s_bvalid && iniu0_axi_porting_s_bready) begin
                    got_b = 1;
                    break;
                end
            end
            if (!got_b) $fatal(1, "[STS DEMO] WRITE response timeout addr=0x%08h", addr);
            if (iniu0_axi_porting_s_bid !== id) $fatal(1, "[STS DEMO] WRITE id mismatch exp=%0d act=%0d", id, iniu0_axi_porting_s_bid);
            if (iniu0_axi_porting_s_bresp !== exp_resp) $fatal(1, "[STS DEMO] WRITE resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, iniu0_axi_porting_s_bresp);
            @(posedge iniu0_clk_sys);
        end
    endtask

    task automatic do_axi_read(
        input logic [31:0] addr,
        input logic [7:0] id,
        input logic [1:0] exp_resp,
        input logic [31:0] exp_data,
        input bit check_data
    );
        bit ar_done;
        bit got_r;
        begin
            ar_done = 0;
            got_r = 0;
            @(negedge iniu0_clk_sys);
            iniu0_axi_porting_s_araddr = addr;
            iniu0_axi_porting_s_arid = id;
            iniu0_axi_porting_s_arvalid = 1'b1;
            fork : ar_wait_or_timeout
                begin
                    @(posedge iniu0_clk_sys iff iniu0_axi_porting_s_arready);
                    iniu0_axi_porting_s_arvalid = 1'b0;
                    ar_done = 1;
                end
                begin
                    repeat (TIMEOUT_CYCLES) @(posedge iniu0_clk_sys);
                end
            join_any
            disable ar_wait_or_timeout;
            if (!ar_done) $fatal(1, "[STS DEMO] READ timeout addr=0x%08h", addr);
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge iniu0_clk_sys);
                if (iniu0_axi_porting_s_rvalid && iniu0_axi_porting_s_rready) begin
                    got_r = 1;
                    break;
                end
            end
            if (!got_r) $fatal(1, "[STS DEMO] READ response timeout addr=0x%08h", addr);
            if (iniu0_axi_porting_s_rid !== id) $fatal(1, "[STS DEMO] READ id mismatch exp=%0d act=%0d", id, iniu0_axi_porting_s_rid);
            if (iniu0_axi_porting_s_rresp !== exp_resp) $fatal(1, "[STS DEMO] READ resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, iniu0_axi_porting_s_rresp);
            if (check_data && (iniu0_axi_porting_s_rdata !== exp_data)) $fatal(1, "[STS DEMO] READ data mismatch addr=0x%08h exp=0x%08h act=0x%08h", addr, exp_data, iniu0_axi_porting_s_rdata);
            @(posedge iniu0_clk_sys);
        end
    endtask

    task automatic tc_reset;
        begin
            if ($isunknown({iniu0_axi_porting_s_awready, iniu0_axi_porting_s_wready, iniu0_axi_porting_s_bvalid, iniu0_axi_porting_s_arready, iniu0_axi_porting_s_rvalid})) begin
                $fatal(1, "[STS DEMO] tc_reset observed X/Z on AXI outputs");
            end
            pass_count++;
        end
    endtask

    task automatic tc_regbank_rw;
        logic [31:0] base;
        begin
            for (int t = 0; t < TNIU_NUM; t++) begin
                base = window_base(t, 0);
                do_axi_write(base, 32'hCAFE_1000 + t, 8'(t), 4'hf, 2'b00);
                do_axi_read(base, 8'(t), 2'b00, 32'hCAFE_1000 + t, 1'b1);
                do_axi_read(base + 32'h14, 8'(t + 8), 2'b00, 32'hFFFF_FFFE, 1'b1);
            end
            pass_count++;
        end
    endtask

    task automatic tc_all_windows_rw;
        logic [31:0] base;
        logic [31:0] exp;
        begin
            for (int t = 0; t < TNIU_NUM; t++) begin
                for (int slot = 0; slot < 12; slot++) begin
                    base = window_base(t, slot);
                    if (slot == 0) begin
                        do_axi_write(base, 32'hA000_0000 + t, 8'(t), 4'hf, 2'b00);
                        do_axi_read(base, 8'(t), 2'b00, 32'hA000_0000 + t, 1'b1);
                    end else begin
                        do_axi_write(base, 32'hA100_0000 + t * 32'h100 + slot, 8'(slot), 4'hf, 2'b00);
                        do_axi_write(base + 32'h4, 32'hA200_0000 + t * 32'h100 + slot, 8'(slot + 16), 4'hf, 2'b00);
                        do_axi_write(base + 32'h3C, 32'hA300_0000 + t * 32'h100 + slot, 8'(slot + 32), 4'hf, 2'b00);
                        do_axi_read(base, 8'(slot), 2'b00, 32'hA100_0000 + t * 32'h100 + slot, 1'b1);
                        do_axi_read(base + 32'h4, 8'(slot + 16), 2'b00, 32'hA200_0000 + t * 32'h100 + slot, 1'b1);
                        do_axi_read(base + 32'h3C, 8'(slot + 32), 2'b00, 32'hA300_0000 + t * 32'h100 + slot, 1'b1);
                    end
                end
            end
            pass_count++;
        end
    endtask

    task automatic tc_decode_err;
        begin
            do_axi_write(32'h0003_0000, 32'hDEAD_BEEF, 8'h11, 4'hf, 2'b11);
            do_axi_write(32'hFFFF_0000, 32'h1234_5678, 8'h12, 4'hf, 2'b11);
            do_axi_read(32'h0003_0000, 8'h11, 2'b11, 32'h0, 1'b0);
            do_axi_read(32'h8000_0000, 8'h12, 2'b11, 32'h0, 1'b0);
            pass_count++;
        end
    endtask

    task automatic tc_slverr;
        begin
            for (int t = 0; t < TNIU_NUM; t++) begin
                do_axi_write(window_base(t, 1) + 32'h100, 32'hBAD0_0000 + t, 8'(t), 4'hf, 2'b10);
                do_axi_read(window_base(t, 1) + 32'h100, 8'(t + 16), 2'b10, 32'hDEAD_BEEF, 1'b1);
                do_axi_write(window_base(t, 11) + 32'h100, 32'hBAD1_0000 + t, 8'(t + 32), 4'hf, 2'b10);
                do_axi_read(window_base(t, 11) + 32'h100, 8'(t + 48), 2'b10, 32'hDEAD_BEEF, 1'b1);
            end
            pass_count++;
        end
    endtask

    task automatic tc_strobe_walk;
        logic [31:0] base;
        logic [31:0] original;
        logic [31:0] expected;
        logic [3:0] strb;
        begin
            base = window_base(0, 1);
            for (int word = 0; word < 16; word++) begin
                strb = word[3:0];
                original = pmc_init_pattern(0) + word;
                expected = apply_strobe(original, 32'h1234_5678, strb);
                do_axi_write(base + (word << 2), 32'h1234_5678, 8'(word), strb, 2'b00);
                do_axi_read(base + (word << 2), 8'(word), 2'b00, expected, 1'b1);
            end
            pass_count++;
        end
    endtask

    task automatic tc_apb_stall;
        int unsigned settle_cycles;
        begin
            for (int stall = 0; stall <= 4; stall++) begin
                set_all_stall(stall);
                settle_cycles = 16 + stall * 16;
                repeat (settle_cycles) @(posedge iniu0_clk_sys);
                for (int t = 0; t < TNIU_NUM; t++) begin
                    do_axi_write(window_base(t, 1), 32'hCC00_0000 + stall * 16 + t, 8'(t), 4'hf, 2'b00);
                    repeat (settle_cycles) @(posedge iniu0_clk_sys);
                    do_axi_read(window_base(t, 1), 8'(t), 2'b00, 32'hCC00_0000 + stall * 16 + t, 1'b1);
                    do_axi_write(window_base(t, 2), 32'hDD00_0000 + stall * 16 + t, 8'(t + 16), 4'hf, 2'b00);
                    repeat (settle_cycles) @(posedge iniu0_clk_sys);
                    do_axi_read(window_base(t, 2), 8'(t + 16), 2'b00, 32'hDD00_0000 + stall * 16 + t, 1'b1);
                end
            end
            set_all_stall(0);
            pass_count++;
        end
    endtask

    sts_logic_topo_1i4t dut (
        .iniu0_clk_sys(iniu0_clk_sys),
        .iniu0_rst_sys_n(iniu0_rstn_src),
        .tniu0_clk_sys(tniu_clk_sys[0]),
        .tniu0_rst_sys_n(tniu_rstn_src[0]),
        .tniu1_clk_sys(tniu_clk_sys[1]),
        .tniu1_rst_sys_n(tniu_rstn_src[1]),
        .tniu2_clk_sys(tniu_clk_sys[2]),
        .tniu2_rst_sys_n(tniu_rstn_src[2]),
        .tniu3_clk_sys(tniu_clk_sys[3]),
        .tniu3_rst_sys_n(tniu_rstn_src[3]),
        .clk_noc(clk_dst),
        .clk_dbg_timer(clk_dbg_timer),
        .rst_noc_n(rstn_dst),
        .rst_dbg_timer_n(rstn_dbg_timer),
        .iniu0_node_id_porting_node_id(iniu0_node_id_porting_node_id),
        .iniu0_axi_porting_s_araddr(iniu0_axi_porting_s_araddr),
        .iniu0_axi_porting_s_arburst(iniu0_axi_porting_s_arburst),
        .iniu0_axi_porting_s_arcache(iniu0_axi_porting_s_arcache),
        .iniu0_axi_porting_s_arid(iniu0_axi_porting_s_arid),
        .iniu0_axi_porting_s_arlen(iniu0_axi_porting_s_arlen),
        .iniu0_axi_porting_s_arlock(iniu0_axi_porting_s_arlock),
        .iniu0_axi_porting_s_arprot(iniu0_axi_porting_s_arprot),
        .iniu0_axi_porting_s_arqos(iniu0_axi_porting_s_arqos),
        .iniu0_axi_porting_s_arready(iniu0_axi_porting_s_arready),
        .iniu0_axi_porting_s_arsize(iniu0_axi_porting_s_arsize),
        .iniu0_axi_porting_s_aruser(iniu0_axi_porting_s_aruser),
        .iniu0_axi_porting_s_arvalid(iniu0_axi_porting_s_arvalid),
        .iniu0_axi_porting_s_awaddr(iniu0_axi_porting_s_awaddr),
        .iniu0_axi_porting_s_awburst(iniu0_axi_porting_s_awburst),
        .iniu0_axi_porting_s_awcache(iniu0_axi_porting_s_awcache),
        .iniu0_axi_porting_s_awid(iniu0_axi_porting_s_awid),
        .iniu0_axi_porting_s_awlen(iniu0_axi_porting_s_awlen),
        .iniu0_axi_porting_s_awlock(iniu0_axi_porting_s_awlock),
        .iniu0_axi_porting_s_awprot(iniu0_axi_porting_s_awprot),
        .iniu0_axi_porting_s_awqos(iniu0_axi_porting_s_awqos),
        .iniu0_axi_porting_s_awready(iniu0_axi_porting_s_awready),
        .iniu0_axi_porting_s_awsize(iniu0_axi_porting_s_awsize),
        .iniu0_axi_porting_s_awuser(iniu0_axi_porting_s_awuser),
        .iniu0_axi_porting_s_awvalid(iniu0_axi_porting_s_awvalid),
        .iniu0_axi_porting_s_bid(iniu0_axi_porting_s_bid),
        .iniu0_axi_porting_s_bready(iniu0_axi_porting_s_bready),
        .iniu0_axi_porting_s_bresp(iniu0_axi_porting_s_bresp),
        .iniu0_axi_porting_s_bvalid(iniu0_axi_porting_s_bvalid),
        .iniu0_axi_porting_s_rdata(iniu0_axi_porting_s_rdata),
        .iniu0_axi_porting_s_rid(iniu0_axi_porting_s_rid),
        .iniu0_axi_porting_s_rlast(iniu0_axi_porting_s_rlast),
        .iniu0_axi_porting_s_rready(iniu0_axi_porting_s_rready),
        .iniu0_axi_porting_s_rresp(iniu0_axi_porting_s_rresp),
        .iniu0_axi_porting_s_rvalid(iniu0_axi_porting_s_rvalid),
        .iniu0_axi_porting_s_wdata(iniu0_axi_porting_s_wdata),
        .iniu0_axi_porting_s_wlast(iniu0_axi_porting_s_wlast),
        .iniu0_axi_porting_s_wready(iniu0_axi_porting_s_wready),
        .iniu0_axi_porting_s_wstrb(iniu0_axi_porting_s_wstrb),
        .iniu0_axi_porting_s_wvalid(iniu0_axi_porting_s_wvalid),
        .tniu0_pmc_apb_porting_pmc_paddr(pmc_paddr[0]),
        .tniu0_pmc_apb_porting_pmc_penable(pmc_penable[0]),
        .tniu0_pmc_apb_porting_pmc_pprot(pmc_pprot[0]),
        .tniu0_pmc_apb_porting_pmc_prdata(pmc_prdata[0]),
        .tniu0_pmc_apb_porting_pmc_pready(pmc_pready[0]),
        .tniu0_pmc_apb_porting_pmc_psel(pmc_psel[0]),
        .tniu0_pmc_apb_porting_pmc_pslverr(pmc_pslverr[0]),
        .tniu0_pmc_apb_porting_pmc_pstrb(pmc_pstrb[0]),
        .tniu0_pmc_apb_porting_pmc_pwdata(pmc_pwdata[0]),
        .tniu0_pmc_apb_porting_pmc_pwrite(pmc_pwrite[0]),
        .tniu0_sys_apb_porting_m_paddr(sys_paddr[0]),
        .tniu0_sys_apb_porting_m_penable(sys_penable[0]),
        .tniu0_sys_apb_porting_m_pprot(sys_pprot[0]),
        .tniu0_sys_apb_porting_m_prdata(sys_prdata[0]),
        .tniu0_sys_apb_porting_m_pready(sys_pready[0]),
        .tniu0_sys_apb_porting_m_psel(sys_psel[0]),
        .tniu0_sys_apb_porting_m_pslverr(sys_pslverr[0]),
        .tniu0_sys_apb_porting_m_pstrb(sys_pstrb[0]),
        .tniu0_sys_apb_porting_m_pwdata(sys_pwdata[0]),
        .tniu0_sys_apb_porting_m_pwrite(sys_pwrite[0]),
        .tniu0_dbg_data_porting_dbg_data_in('0),
        .tniu0_dbg_data_porting_dbg_data_out(),
        .tniu0_dbg_timestamp_porting_dbg_timestamp_in('0),
        .tniu0_dbg_timestamp_porting_dbg_timestamp_out(),
        .tniu0_sys_cti_event_porting_sys_cti_event_in('0),
        .tniu0_sys_cti_event_porting_sys_cti_event_out(),
        .tniu0_noc_cti_event_porting_noc_cti_event_in('0),
        .tniu0_noc_cti_event_porting_noc_cti_event_out(),
        .tniu0_sys_cti_channel_porting_sys_cti_channel_in('0),
        .tniu0_sys_cti_channel_porting_sys_cti_channel_out(),
        .tniu0_noc_cti_channel_porting_noc_cti_channel_in('0),
        .tniu0_noc_cti_channel_porting_noc_cti_channel_out(),
        .tniu1_pmc_apb_porting_pmc_paddr(pmc_paddr[1]),
        .tniu1_pmc_apb_porting_pmc_penable(pmc_penable[1]),
        .tniu1_pmc_apb_porting_pmc_pprot(pmc_pprot[1]),
        .tniu1_pmc_apb_porting_pmc_prdata(pmc_prdata[1]),
        .tniu1_pmc_apb_porting_pmc_pready(pmc_pready[1]),
        .tniu1_pmc_apb_porting_pmc_psel(pmc_psel[1]),
        .tniu1_pmc_apb_porting_pmc_pslverr(pmc_pslverr[1]),
        .tniu1_pmc_apb_porting_pmc_pstrb(pmc_pstrb[1]),
        .tniu1_pmc_apb_porting_pmc_pwdata(pmc_pwdata[1]),
        .tniu1_pmc_apb_porting_pmc_pwrite(pmc_pwrite[1]),
        .tniu1_sys_apb_porting_m_paddr(sys_paddr[1]),
        .tniu1_sys_apb_porting_m_penable(sys_penable[1]),
        .tniu1_sys_apb_porting_m_pprot(sys_pprot[1]),
        .tniu1_sys_apb_porting_m_prdata(sys_prdata[1]),
        .tniu1_sys_apb_porting_m_pready(sys_pready[1]),
        .tniu1_sys_apb_porting_m_psel(sys_psel[1]),
        .tniu1_sys_apb_porting_m_pslverr(sys_pslverr[1]),
        .tniu1_sys_apb_porting_m_pstrb(sys_pstrb[1]),
        .tniu1_sys_apb_porting_m_pwdata(sys_pwdata[1]),
        .tniu1_sys_apb_porting_m_pwrite(sys_pwrite[1]),
        .tniu1_dbg_data_porting_dbg_data_in('0),
        .tniu1_dbg_data_porting_dbg_data_out(),
        .tniu1_dbg_timestamp_porting_dbg_timestamp_in('0),
        .tniu1_dbg_timestamp_porting_dbg_timestamp_out(),
        .tniu1_sys_cti_event_porting_sys_cti_event_in('0),
        .tniu1_sys_cti_event_porting_sys_cti_event_out(),
        .tniu1_noc_cti_event_porting_noc_cti_event_in('0),
        .tniu1_noc_cti_event_porting_noc_cti_event_out(),
        .tniu1_sys_cti_channel_porting_sys_cti_channel_in('0),
        .tniu1_sys_cti_channel_porting_sys_cti_channel_out(),
        .tniu1_noc_cti_channel_porting_noc_cti_channel_in('0),
        .tniu1_noc_cti_channel_porting_noc_cti_channel_out(),
        .tniu2_pmc_apb_porting_pmc_paddr(pmc_paddr[2]),
        .tniu2_pmc_apb_porting_pmc_penable(pmc_penable[2]),
        .tniu2_pmc_apb_porting_pmc_pprot(pmc_pprot[2]),
        .tniu2_pmc_apb_porting_pmc_prdata(pmc_prdata[2]),
        .tniu2_pmc_apb_porting_pmc_pready(pmc_pready[2]),
        .tniu2_pmc_apb_porting_pmc_psel(pmc_psel[2]),
        .tniu2_pmc_apb_porting_pmc_pslverr(pmc_pslverr[2]),
        .tniu2_pmc_apb_porting_pmc_pstrb(pmc_pstrb[2]),
        .tniu2_pmc_apb_porting_pmc_pwdata(pmc_pwdata[2]),
        .tniu2_pmc_apb_porting_pmc_pwrite(pmc_pwrite[2]),
        .tniu2_sys_apb_porting_m_paddr(sys_paddr[2]),
        .tniu2_sys_apb_porting_m_penable(sys_penable[2]),
        .tniu2_sys_apb_porting_m_pprot(sys_pprot[2]),
        .tniu2_sys_apb_porting_m_prdata(sys_prdata[2]),
        .tniu2_sys_apb_porting_m_pready(sys_pready[2]),
        .tniu2_sys_apb_porting_m_psel(sys_psel[2]),
        .tniu2_sys_apb_porting_m_pslverr(sys_pslverr[2]),
        .tniu2_sys_apb_porting_m_pstrb(sys_pstrb[2]),
        .tniu2_sys_apb_porting_m_pwdata(sys_pwdata[2]),
        .tniu2_sys_apb_porting_m_pwrite(sys_pwrite[2]),
        .tniu2_dbg_data_porting_dbg_data_in('0),
        .tniu2_dbg_data_porting_dbg_data_out(),
        .tniu2_dbg_timestamp_porting_dbg_timestamp_in('0),
        .tniu2_dbg_timestamp_porting_dbg_timestamp_out(),
        .tniu2_sys_cti_event_porting_sys_cti_event_in('0),
        .tniu2_sys_cti_event_porting_sys_cti_event_out(),
        .tniu2_noc_cti_event_porting_noc_cti_event_in('0),
        .tniu2_noc_cti_event_porting_noc_cti_event_out(),
        .tniu2_sys_cti_channel_porting_sys_cti_channel_in('0),
        .tniu2_sys_cti_channel_porting_sys_cti_channel_out(),
        .tniu2_noc_cti_channel_porting_noc_cti_channel_in('0),
        .tniu2_noc_cti_channel_porting_noc_cti_channel_out(),
        .tniu3_pmc_apb_porting_pmc_paddr(pmc_paddr[3]),
        .tniu3_pmc_apb_porting_pmc_penable(pmc_penable[3]),
        .tniu3_pmc_apb_porting_pmc_pprot(pmc_pprot[3]),
        .tniu3_pmc_apb_porting_pmc_prdata(pmc_prdata[3]),
        .tniu3_pmc_apb_porting_pmc_pready(pmc_pready[3]),
        .tniu3_pmc_apb_porting_pmc_psel(pmc_psel[3]),
        .tniu3_pmc_apb_porting_pmc_pslverr(pmc_pslverr[3]),
        .tniu3_pmc_apb_porting_pmc_pstrb(pmc_pstrb[3]),
        .tniu3_pmc_apb_porting_pmc_pwdata(pmc_pwdata[3]),
        .tniu3_pmc_apb_porting_pmc_pwrite(pmc_pwrite[3]),
        .tniu3_sys_apb_porting_m_paddr(sys_paddr[3]),
        .tniu3_sys_apb_porting_m_penable(sys_penable[3]),
        .tniu3_sys_apb_porting_m_pprot(sys_pprot[3]),
        .tniu3_sys_apb_porting_m_prdata(sys_prdata[3]),
        .tniu3_sys_apb_porting_m_pready(sys_pready[3]),
        .tniu3_sys_apb_porting_m_psel(sys_psel[3]),
        .tniu3_sys_apb_porting_m_pslverr(sys_pslverr[3]),
        .tniu3_sys_apb_porting_m_pstrb(sys_pstrb[3]),
        .tniu3_sys_apb_porting_m_pwdata(sys_pwdata[3]),
        .tniu3_sys_apb_porting_m_pwrite(sys_pwrite[3]),
        .tniu3_dbg_data_porting_dbg_data_in('0),
        .tniu3_dbg_data_porting_dbg_data_out(),
        .tniu3_dbg_timestamp_porting_dbg_timestamp_in('0),
        .tniu3_dbg_timestamp_porting_dbg_timestamp_out(),
        .tniu3_sys_cti_event_porting_sys_cti_event_in('0),
        .tniu3_sys_cti_event_porting_sys_cti_event_out(),
        .tniu3_noc_cti_event_porting_noc_cti_event_in('0),
        .tniu3_noc_cti_event_porting_noc_cti_event_out(),
        .tniu3_sys_cti_channel_porting_sys_cti_channel_in('0),
        .tniu3_sys_cti_channel_porting_sys_cti_channel_out(),
        .tniu3_noc_cti_channel_porting_noc_cti_channel_in('0),
        .tniu3_noc_cti_channel_porting_noc_cti_channel_out()
    );

    generate
        for (genvar t = 0; t < TNIU_NUM; t++) begin : g_tniu
            sts_demo_apb_stub_slave #(
                .INIT_PATTERN(32'hA000_0000 + (t * 32'h1000_0000))
            ) u_pmc_stub (
                .clk(clk_dst),
                .rst_n(rstn_dst),
                .psel(pmc_psel[t]),
                .penable(pmc_penable[t]),
                .paddr(pmc_paddr[t]),
                .pwrite(pmc_pwrite[t]),
                .pwdata(pmc_pwdata[t]),
                .pstrb(pmc_pstrb[t]),
                .stall_cycles_cfg(pmc_stall_cfg[t]),
                .pready(pmc_pready[t]),
                .prdata(pmc_prdata[t]),
                .pslverr(pmc_pslverr[t])
            );
            for (genvar s = 0; s < SYS_NUM; s++) begin : g_sys
                sts_demo_apb_stub_slave #(
                    .INIT_PATTERN(32'hA100_0000 + (t * 32'h1000_0000) + (s * 32'h0100_0000))
                ) u_sys_stub (
                    .clk(tniu_clk_sys[t]),
                    .rst_n(tniu_rstn_src[t]),
                    .psel(sys_psel[t][s]),
                    .penable(sys_penable[t]),
                    .paddr(sys_paddr[t]),
                    .pwrite(sys_pwrite[t]),
                    .pwdata(sys_pwdata[t]),
                    .pstrb(sys_pstrb[t]),
                    .stall_cycles_cfg(sys_stall_cfg[t][s]),
                    .pready(sys_pready[t][s]),
                    .prdata(sys_prdata[t][s*32 +: 32]),
                    .pslverr(sys_pslverr[t][s])
                );
            end
        end
    endgenerate

    initial begin
        pass_count = 0;
        debug_lines = 0;
        if (!$value$plusargs("TESTCASE=%s", testcase)) testcase = "all";
        if ($test$plusargs("DUMP_FSDB")) begin
            $fsdbDumpfile("sts_logic_topo_1i4t.fsdb");
            $fsdbDumpvars(0, tb_sts_logic_topo_1i4t, "+all");
        end

        if (testcase == "all") begin
            reset_dut(); tc_reset();
            reset_dut(); tc_regbank_rw();
            reset_dut(); tc_all_windows_rw();
            reset_dut(); tc_decode_err();
            reset_dut(); tc_slverr();
            reset_dut(); tc_strobe_walk();
            reset_dut(); tc_apb_stall();
        end else begin
            reset_dut();
            if (testcase == "tc_reset") tc_reset();
            else if (testcase == "tc_regbank_rw") tc_regbank_rw();
            else if (testcase == "tc_all_windows_rw") tc_all_windows_rw();
            else if (testcase == "tc_decode_err") tc_decode_err();
            else if (testcase == "tc_slverr") tc_slverr();
            else if (testcase == "tc_strobe_walk") tc_strobe_walk();
            else if (testcase == "tc_apb_stall") tc_apb_stall();
            else $fatal(1, "[STS DEMO] Unknown TESTCASE=%s", testcase);
        end

        repeat (10) @(posedge iniu0_clk_sys);
        $display("[STS DEMO] PASS: %0d tests passed", pass_count);
        $finish;
    end

    initial begin
        #(TIMEOUT_CYCLES * 10);
        $fatal(1, "[STS DEMO] Global timeout");
    end
endmodule
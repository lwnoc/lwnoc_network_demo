// Testbench for intr_ring_noc_4i2t
// Topology: 4 INIU + 2 TNIU in a bidirectional ring (CW order: iniu0,1,2,3,tniu0,tniu1)
// Ring station NODE_IDs: iniu0=0, iniu1=1, iniu2=2, iniu3=3, tniu0=4, tniu1=5
//
// Test plan:
//   tc001: power-on defaults
//   tc002: INIU0 LUT programming + readback
//   tc003: end-to-end: INIU0->TNIU0 interrupt delivery
//   tc004: end-to-end: interrupt clear
//   tc005: TNIU0 APB set/clr/mask controls
//   tc006: cross-ring routing: INIU3->TNIU1 (2 CW hops)
//   tc007: simultaneous: INIU0->TNIU1 (CCW 1 hop) // INIU2->TNIU0 (CW 2 hops)
//   tc008: multi-INIU flood: all 4 INIUs -> TNIU0 different interrupt IDs
`timescale 1ns/1ps

module tb_intr_ring_noc_4i2t;
    timeunit 1ns;
    timeprecision 1ps;

    // LP packages imported so lwnoc_lp_iniu controllers can be instantiated
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;

    // -------------------------------------------------------------------------
    // Address constants (from interrupt_iniu_pkg / interrupt_tniu_pkg)
    // -------------------------------------------------------------------------
    localparam logic [31:0] INTR_LUT_BASE_ADDR          = 32'h4000;
    localparam logic [31:0] INTR_RAW_BASE_ADDR          = 32'h0000;
    localparam logic [31:0] INTR_MERGE_MASK_BASE_ADDR   = 32'h0200;
    localparam logic [31:0] INTR_SET_BASE_ADDR          = 32'h1000;
    localparam logic [31:0] INTR_CLR_BASE_ADDR          = 32'h1200;
    localparam logic [31:0] INTR_INTERNAL_BASE_ADDR     = 32'h1400;
    localparam logic [31:0] INTR_CONFLICT_BASE_ADDR     = 32'h4000;

    // -------------------------------------------------------------------------
    // Node identity parameters
    // Ring position -> node: 0=iniu0, 1=iniu1, 2=iniu2, 3=iniu3, 4=tniu0, 5=tniu1
    // TNIU ring ID = ring position; programmed into INIU LUT as tgtid
    // -------------------------------------------------------------------------
    localparam logic [7:0] INIU0_SRC_ID   = 8'h10;
    localparam logic [7:0] INIU1_SRC_ID   = 8'h11;
    localparam logic [7:0] INIU2_SRC_ID   = 8'h12;
    localparam logic [7:0] INIU3_SRC_ID   = 8'h13;
    localparam logic [7:0] TNIU0_SYS_ID   = 8'h40;   // TNIU sys-side node ID
    localparam logic [7:0] TNIU1_SYS_ID   = 8'h41;
    localparam logic [7:0] TNIU0_RING_ID  = 8'd4;    // ring station NODE_ID for routing
    localparam logic [7:0] TNIU1_RING_ID  = 8'd5;

    localparam int unsigned SYS_WAIT      = 2000;    // clk_sys cycles to wait for AFIFO + ring

    // -------------------------------------------------------------------------
    // Clocks / resets (shared by all nodes)
    // -------------------------------------------------------------------------
    logic clk_sys  = 1'b0;
    logic clk_noc  = 1'b0;
    logic rstn_sys = 1'b0;
    logic rstn_noc = 1'b0;

    always #5  clk_sys = ~clk_sys;    // 100 MHz
    always #7  clk_noc = ~clk_noc;    // ~71  MHz

    initial begin
        #100;
        rstn_sys = 1'b1;
        rstn_noc = 1'b1;
    end

    // -------------------------------------------------------------------------
    // Pass/fail counters
    // -------------------------------------------------------------------------
    integer fail_count = 0;
    integer pass_count = 0;
    string testcase;

    // =========================================================================
    // INIU driver signals (one per node)
    // =========================================================================

    // --- INIU0 ---
    logic [4095:0] iniu0_iniu0_sys_v_interrupt_porting_iniu0_sys_v_interrupt_porting_v_interrupt = '0;
    logic [7:0]    iniu0_iniu0_sys_iniu_src_id_porting_iniu0_sys_iniu_src_id_porting_iniu_src_id = INIU0_SRC_ID;
    logic [31:0]   iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_addr   = '0;
    logic          iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0]   iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_wdata  = '0;
    logic          iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_write   = 1'b0;
    logic          iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]    iniu0_iniu0_sys_timeout_val_porting_iniu0_sys_timeout_val_porting_timeout_val = 10'd16;
    logic  [12:0]  iniu0_iniu0_sys_lp_hub_porting_iniu0_sys_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_iniu0

    // --- INIU1 ---
    logic [4095:0] iniu1_iniu1_sys_v_interrupt_porting_iniu1_sys_v_interrupt_porting_v_interrupt = '0;
    logic [7:0]    iniu1_iniu1_sys_iniu_src_id_porting_iniu1_sys_iniu_src_id_porting_iniu_src_id = INIU1_SRC_ID;
    logic [31:0]   iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_addr   = '0;
    logic          iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0]   iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_wdata  = '0;
    logic          iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_write   = 1'b0;
    logic          iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]    iniu1_iniu1_sys_timeout_val_porting_iniu1_sys_timeout_val_porting_timeout_val = 10'd16;
    logic  [12:0]  iniu1_iniu1_sys_lp_hub_porting_iniu1_sys_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_iniu1

    // --- INIU2 ---
    logic [4095:0] iniu2_iniu2_sys_v_interrupt_porting_iniu2_sys_v_interrupt_porting_v_interrupt = '0;
    logic [7:0]    iniu2_iniu2_sys_iniu_src_id_porting_iniu2_sys_iniu_src_id_porting_iniu_src_id = INIU2_SRC_ID;
    logic [31:0]   iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_addr   = '0;
    logic          iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0]   iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_wdata  = '0;
    logic          iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_write   = 1'b0;
    logic          iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]    iniu2_iniu2_sys_timeout_val_porting_iniu2_sys_timeout_val_porting_timeout_val = 10'd16;
    logic  [12:0]  iniu2_iniu2_sys_lp_hub_porting_iniu2_sys_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_iniu2

    // --- INIU3 ---
    logic [4095:0] iniu3_iniu3_sys_v_interrupt_porting_iniu3_sys_v_interrupt_porting_v_interrupt = '0;
    logic [7:0]    iniu3_iniu3_sys_iniu_src_id_porting_iniu3_sys_iniu_src_id_porting_iniu_src_id = INIU3_SRC_ID;
    logic [31:0]   iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_addr   = '0;
    logic          iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0]   iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_wdata  = '0;
    logic          iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_write   = 1'b0;
    logic          iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]    iniu3_iniu3_sys_timeout_val_porting_iniu3_sys_timeout_val_porting_timeout_val = 10'd16;
    logic  [12:0]  iniu3_iniu3_sys_lp_hub_porting_iniu3_sys_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_iniu3

    // =========================================================================
    // TNIU driver signals (one per node)
    // =========================================================================

    // --- TNIU0 ---
    logic [9:0]  tniu0_tniu0_top_timeout_val_porting_tniu0_top_timeout_val_porting_timeout_val = 10'd16;
    logic [12:0] tniu0_tniu0_top_lp_hub_porting_tniu0_top_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_tniu0
    logic [7:0]  tniu0_tniu0_sys_tniu_tgt_id_porting_tniu0_sys_tniu_tgt_id_porting_tniu_tgt_id = TNIU0_SYS_ID;
    logic [31:0] tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_addr   = '0;
    logic        tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0] tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_wdata  = '0;
    logic        tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_write   = 1'b0;
    logic        tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]  tniu0_tniu0_sys_timeout_val_porting_tniu0_sys_timeout_val_porting_timeout_val = 10'd16;

    // --- TNIU1 ---
    logic [9:0]  tniu1_tniu1_top_timeout_val_porting_tniu1_top_timeout_val_porting_timeout_val = 10'd16;
    logic [12:0] tniu1_tniu1_top_lp_hub_porting_tniu1_top_lp_hub_porting_lp_hub_rx_req; // driven by u_lp_ctrl_tniu1
    logic [7:0]  tniu1_tniu1_sys_tniu_tgt_id_porting_tniu1_sys_tniu_tgt_id_porting_tniu_tgt_id = TNIU1_SYS_ID;
    logic [31:0] tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_addr   = '0;
    logic        tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable  = 1'b0;
    logic [31:0] tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_wdata  = '0;
    logic        tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_write   = 1'b0;
    logic        tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_sel     = 1'b0;
    logic [9:0]  tniu1_tniu1_sys_timeout_val_porting_tniu1_sys_timeout_val_porting_timeout_val = 10'd16;

    // =========================================================================
    // DUT output signals (declared so .* works; TB reads / monitors these)
    // =========================================================================

    // INIU0 APB outputs (DUT -> TB)
    logic [31:0] iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_rdata;
    logic        iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_ready;
    logic        iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_slverr;
    logic [12:0] iniu0_iniu0_sys_lp_hub_porting_iniu0_sys_lp_hub_porting_lp_hub_tx_req;

    // INIU1 APB outputs
    logic [31:0] iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_rdata;
    logic        iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_ready;
    logic        iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_slverr;
    logic [12:0] iniu1_iniu1_sys_lp_hub_porting_iniu1_sys_lp_hub_porting_lp_hub_tx_req;

    // INIU2 APB outputs
    logic [31:0] iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_rdata;
    logic        iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_ready;
    logic        iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_slverr;
    logic [12:0] iniu2_iniu2_sys_lp_hub_porting_iniu2_sys_lp_hub_porting_lp_hub_tx_req;

    // INIU3 APB outputs
    logic [31:0] iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_rdata;
    logic        iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_ready;
    logic        iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_slverr;
    logic [12:0] iniu3_iniu3_sys_lp_hub_porting_iniu3_sys_lp_hub_porting_lp_hub_tx_req;

    // TNIU0 monitored outputs
    logic [4095:0] tniu0_tniu0_sys_v_interrupt_porting_tniu0_sys_v_interrupt_porting_v_interrupt;
    logic [127:0]  tniu0_tniu0_sys_v_merge_interrupt_porting_tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt;
    logic [31:0]   tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_rdata;
    logic          tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_ready;
    logic          tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_slverr;
    logic [12:0]   tniu0_tniu0_top_lp_hub_porting_tniu0_top_lp_hub_porting_lp_hub_tx_req;

    // TNIU1 monitored outputs
    logic [4095:0] tniu1_tniu1_sys_v_interrupt_porting_tniu1_sys_v_interrupt_porting_v_interrupt;
    logic [127:0]  tniu1_tniu1_sys_v_merge_interrupt_porting_tniu1_sys_v_merge_interrupt_porting_v_merge_interrupt;
    logic [31:0]   tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_rdata;
    logic          tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_ready;
    logic          tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_slverr;
    logic [12:0]   tniu1_tniu1_top_lp_hub_porting_tniu1_top_lp_hub_porting_lp_hub_tx_req;

    // =========================================================================
    // DUT instantiation (all ports connected via wildcard .*)
    // Clock/reset: shared across all nodes
    // =========================================================================
    assign iniu0_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign iniu0_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign iniu0_clk_noc_porting                            = clk_noc;
    assign iniu0_rst_noc_n_porting                          = rstn_noc;
    assign iniu1_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign iniu1_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign iniu1_clk_noc_porting                            = clk_noc;
    assign iniu1_rst_noc_n_porting                          = rstn_noc;
    assign iniu2_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign iniu2_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign iniu2_clk_noc_porting                            = clk_noc;
    assign iniu2_rst_noc_n_porting                          = rstn_noc;
    assign iniu3_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign iniu3_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign iniu3_clk_noc_porting                            = clk_noc;
    assign iniu3_rst_noc_n_porting                          = rstn_noc;
    assign tniu0_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign tniu0_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign tniu0_clk_noc_porting                            = clk_noc;
    assign tniu0_rst_noc_n_porting                          = rstn_noc;
    assign tniu1_clk_sys_porting_clk_sys_clk               = clk_sys;
    assign tniu1_rst_sys_n_porting_rst_sys_n_rst_n          = rstn_sys;
    assign tniu1_clk_noc_porting                            = clk_noc;
    assign tniu1_rst_noc_n_porting                          = rstn_noc;

    intr_ring_noc_4i2t dut (.*);

    // =========================================================================
    // LP controllers — one lwnoc_lp_iniu per DUT LP hub port, keeps system ON
    // INIU sys LP bridges run on clk_sys; TNIU top LP bridges run on clk_noc
    // preq=1 / pstate=P_POWER_ON(2'd0) drives LP_SLV_CMD_ON → clears stall_ptr
    // =========================================================================
    lwnoc_lp_iniu u_lp_ctrl_iniu0 (
        .clk    (clk_sys),
        .rst_n  (rstn_sys),
        .rx_req (lwnoc_lp_req_signal_t'(iniu0_iniu0_sys_lp_hub_porting_iniu0_sys_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (iniu0_iniu0_sys_lp_hub_porting_iniu0_sys_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );
    lwnoc_lp_iniu u_lp_ctrl_iniu1 (
        .clk    (clk_sys),
        .rst_n  (rstn_sys),
        .rx_req (lwnoc_lp_req_signal_t'(iniu1_iniu1_sys_lp_hub_porting_iniu1_sys_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (iniu1_iniu1_sys_lp_hub_porting_iniu1_sys_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );
    lwnoc_lp_iniu u_lp_ctrl_iniu2 (
        .clk    (clk_sys),
        .rst_n  (rstn_sys),
        .rx_req (lwnoc_lp_req_signal_t'(iniu2_iniu2_sys_lp_hub_porting_iniu2_sys_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (iniu2_iniu2_sys_lp_hub_porting_iniu2_sys_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );
    lwnoc_lp_iniu u_lp_ctrl_iniu3 (
        .clk    (clk_sys),
        .rst_n  (rstn_sys),
        .rx_req (lwnoc_lp_req_signal_t'(iniu3_iniu3_sys_lp_hub_porting_iniu3_sys_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (iniu3_iniu3_sys_lp_hub_porting_iniu3_sys_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );
    lwnoc_lp_iniu u_lp_ctrl_tniu0 (
        .clk    (clk_noc),
        .rst_n  (rstn_noc),
        .rx_req (lwnoc_lp_req_signal_t'(tniu0_tniu0_top_lp_hub_porting_tniu0_top_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (tniu0_tniu0_top_lp_hub_porting_tniu0_top_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );
    lwnoc_lp_iniu u_lp_ctrl_tniu1 (
        .clk    (clk_noc),
        .rst_n  (rstn_noc),
        .rx_req (lwnoc_lp_req_signal_t'(tniu1_tniu1_top_lp_hub_porting_tniu1_top_lp_hub_porting_lp_hub_tx_req)),
        .tx_req (tniu1_tniu1_top_lp_hub_porting_tniu1_top_lp_hub_porting_lp_hub_rx_req),
        .preq   (1'b1),
        .pstate (lwnoc_pchannel_state_t'(2'd0)),
        .pactive(), .paccept(), .pdeny()
    );

    // =========================================================================
    // Waveform dump
    // =========================================================================
    initial begin
        if ($test$plusargs("dump_fsdb")) begin
            $fsdbDumpfile("intr_ring_noc_4i2t.fsdb");
            $fsdbDumpvars(0, tb_intr_ring_noc_4i2t, "+all");
        end
    end

    // =========================================================================
    // Comprehensive diagnostic: trace packet path at key stages
    // =========================================================================
    initial begin
        #5000; // 5 us — LP should be settled
        $display("[DBG] t=%0t LP: iniu0_sys.async_write_stall=%b  iniu0_sys.niu_stall=%b  iniu0_top.async_stall=%b  tniu0_top.async_write_stall=%b  tniu0_sys.async_stall=%b",
                 $time,
                 dut.iniu0.iniu_sys.async_write_stall,
                 dut.iniu0.iniu_sys.niu_stall,
                 dut.iniu0.iniu_top.async_stall,
                 dut.tniu0.tniu_top.async_write_stall,
                 dut.tniu0.tniu_sys.async_stall);
    end
    // Monitor INIU0 SYS -> req_valid/req_ready (packet generation from INIU)
    always @(posedge clk_sys) begin
        if (dut.iniu0.iniu_sys.req_valid)
            $display("[DBG] t=%0t INIU0_SYS req: valid=%b ready=%b tgtid=%h srcid=%h payload=%h",
                     $time,
                     dut.iniu0.iniu_sys.req_valid,
                     dut.iniu0.iniu_sys.req_ready,
                     dut.iniu0.iniu_sys.req_tgtid,
                     dut.iniu0.iniu_sys.req_srcid,
                     dut.iniu0.iniu_sys.req_payload);
    end
    // Monitor TNIU0 SYS <- resp (packet received at TNIU SYS)
    always @(posedge clk_sys) begin
        if (dut.tniu0.tniu_sys.req_valid)
            $display("[DBG] t=%0t TNIU0_SYS recv: valid=%b tgtid=%h srcid=%h payload=%h",
                     $time,
                     dut.tniu0.tniu_sys.req_valid,
                     dut.tniu0.tniu_sys.req_tgtid,
                     dut.tniu0.tniu_sys.req_srcid,
                     dut.tniu0.tniu_sys.req_payload);
    end
    // Monitor INIU3 SYS -> req_valid (for tc006)
    always @(posedge clk_sys) begin
        if (dut.iniu3.iniu_sys.req_valid)
            $display("[DBG] t=%0t INIU3_SYS req: valid=%b ready=%b tgtid=%h srcid=%h payload=%h stall=%b",
                     $time,
                     dut.iniu3.iniu_sys.req_valid,
                     dut.iniu3.iniu_sys.req_ready,
                     dut.iniu3.iniu_sys.req_tgtid,
                     dut.iniu3.iniu_sys.req_srcid,
                     dut.iniu3.iniu_sys.req_payload,
                     dut.iniu3.iniu_sys.niu_stall);
    end
    // Monitor TNIU1 SYS <- resp (for tc006)
    always @(posedge clk_sys) begin
        if (dut.tniu1.tniu_sys.req_valid)
            $display("[DBG] t=%0t TNIU1_SYS recv: valid=%b tgtid=%h srcid=%h payload=%h",
                     $time,
                     dut.tniu1.tniu_sys.req_valid,
                     dut.tniu1.tniu_sys.req_tgtid,
                     dut.tniu1.tniu_sys.req_srcid,
                     dut.tniu1.tniu_sys.req_payload);
    end

    // =========================================================================
    // Helper tasks
    // =========================================================================

    task automatic wait_sys(input int unsigned n);
        repeat (n) @(posedge clk_sys);
    endtask

    task automatic reset_dut();
        // LP controllers (lwnoc_lp_iniu instances) run autonomously;
        // just wait for resets to deassert + LP handshake to stabilise
        wait (rstn_sys === 1'b1 && rstn_noc === 1'b1);
        wait_sys(100);  // allow LP stall_ptr to clear via lwnoc_lp_iniu handshake
    endtask

    task automatic check_no_x_after_reset(input string tag);
        begin
            if ($isunknown({
                iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_ready,
                iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_slverr,
                iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_ready,
                iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_slverr,
                iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_ready,
                iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_slverr,
                iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_ready,
                iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_slverr,
                tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_ready,
                tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_slverr,
                tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_ready,
                tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_slverr
            })) begin
                if ($isunknown(iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_ready)) $display("[TB][XCHK] iniu0 p_ready is X/Z");
                if ($isunknown(iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_slverr)) $display("[TB][XCHK] iniu0 p_slverr is X/Z");
                if ($isunknown(iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_ready)) $display("[TB][XCHK] iniu1 p_ready is X/Z");
                if ($isunknown(iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_slverr)) $display("[TB][XCHK] iniu1 p_slverr is X/Z");
                if ($isunknown(iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_ready)) $display("[TB][XCHK] iniu2 p_ready is X/Z");
                if ($isunknown(iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_slverr)) $display("[TB][XCHK] iniu2 p_slverr is X/Z");
                if ($isunknown(iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_ready)) $display("[TB][XCHK] iniu3 p_ready is X/Z");
                if ($isunknown(iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_slverr)) $display("[TB][XCHK] iniu3 p_slverr is X/Z");
                if ($isunknown(tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_ready)) $display("[TB][XCHK] tniu0 p_ready is X/Z");
                if ($isunknown(tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_slverr)) $display("[TB][XCHK] tniu0 p_slverr is X/Z");
                if ($isunknown(tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_ready)) $display("[TB][XCHK] tniu1 p_ready is X/Z");
                if ($isunknown(tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_slverr)) $display("[TB][XCHK] tniu1 p_slverr is X/Z");
                $fatal(1, "[TB] %s observed X/Z after reset", tag);
            end
        end
    endtask

    // ---- Generic expect helpers ----

    task automatic expect_bit(input string msg, input logic actual, input logic expected);
        if (actual !== expected) begin
            fail_count++;
            $error("[FAIL] %s  expected=%0b actual=%0b", msg, expected, actual);
        end else begin
            pass_count++;
            $display("[PASS] %s", msg);
        end
    endtask

    task automatic expect_word(input string msg, input logic [31:0] actual, input logic [31:0] expected);
        if (actual !== expected) begin
            fail_count++;
            $error("[FAIL] %s  expected=0x%08x actual=0x%08x", msg, expected, actual);
        end else begin
            pass_count++;
            $display("[PASS] %s", msg);
        end
    endtask

    // ---- APB write for each INIU (nid 0-3) ----

    task automatic iniu_apb_write(
        input int unsigned   nid,
        input logic [31:0]   addr_i,
        input logic [31:0]   data_i
    );
        int unsigned timeout;
        begin
            @(negedge clk_sys);
            case (nid)
                0: begin
                    iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_addr   <= addr_i;
                    iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_wdata  <= data_i;
                    iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_write  <= 1'b1;
                    iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_sel    <= 1'b1;
                    iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= 1'b0;
                end
                1: begin
                    iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_addr   <= addr_i;
                    iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_wdata  <= data_i;
                    iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_write  <= 1'b1;
                    iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_sel    <= 1'b1;
                    iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= 1'b0;
                end
                2: begin
                    iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_addr   <= addr_i;
                    iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_wdata  <= data_i;
                    iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_write  <= 1'b1;
                    iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_sel    <= 1'b1;
                    iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= 1'b0;
                end
                default: begin
                    iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_addr   <= addr_i;
                    iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_wdata  <= data_i;
                    iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_write  <= 1'b1;
                    iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_sel    <= 1'b1;
                    iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= 1'b0;
                end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= 1'b1;
                1: iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= 1'b1;
                2: iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= 1'b1;
                default: iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= 1'b1;
            endcase
            timeout = 0;
            case (nid)
                0: while ((iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end
                1: while ((iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end
                2: while ((iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end
                default: while ((iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_addr <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_wdata <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_write <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_sel <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= '0; end
                1: begin iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_addr <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_wdata <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_write <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_sel <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= '0; end
                2: begin iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_addr <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_wdata <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_write <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_sel <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= '0; end
                default: begin iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_addr <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_wdata <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_write <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_sel <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= '0; end
            endcase
        end
    endtask

    // ---- APB read for each INIU ----

    task automatic iniu_apb_read(
        input  int unsigned   nid,
        input  logic [31:0]   addr_i,
        output logic [31:0]   data_o
    );
        int unsigned timeout;
        begin
            @(negedge clk_sys);
            case (nid)
                0: begin iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_addr <= addr_i; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_write <= 1'b0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_sel <= 1'b1; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= 1'b0; end
                1: begin iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_addr <= addr_i; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_write <= 1'b0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_sel <= 1'b1; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= 1'b0; end
                2: begin iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_addr <= addr_i; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_write <= 1'b0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_sel <= 1'b1; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= 1'b0; end
                default: begin iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_addr <= addr_i; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_write <= 1'b0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_sel <= 1'b1; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= 1'b0; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_rdata; end
                1: begin iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_rdata; end
                2: begin iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_rdata; end
                default: begin iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_rdata; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_addr <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_write <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_sel <= '0; iniu0_iniu0_sys_apb_porting_iniu0_sys_apb_porting_p_enable <= '0; end
                1: begin iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_addr <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_write <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_sel <= '0; iniu1_iniu1_sys_apb_porting_iniu1_sys_apb_porting_p_enable <= '0; end
                2: begin iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_addr <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_write <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_sel <= '0; iniu2_iniu2_sys_apb_porting_iniu2_sys_apb_porting_p_enable <= '0; end
                default: begin iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_addr <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_write <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_sel <= '0; iniu3_iniu3_sys_apb_porting_iniu3_sys_apb_porting_p_enable <= '0; end
            endcase
        end
    endtask

    // ---- APB write / read for TNIU (nid 0-1) ----

    task automatic tniu_apb_write(
        input int unsigned   nid,
        input logic [31:0]   addr_i,
        input logic [31:0]   data_i
    );
        int unsigned timeout;
        begin
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_addr <= addr_i; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_wdata <= data_i; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_write <= 1'b1; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_sel <= 1'b1; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= 1'b0; end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_addr <= addr_i; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_wdata <= data_i; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_write <= 1'b1; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_sel <= 1'b1; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= 1'b0; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_addr <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_wdata <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_write <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_sel <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= '0; end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_addr <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_wdata <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_write <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_sel <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= '0; end
            endcase
        end
    endtask

    task automatic tniu_apb_read(
        input  int unsigned   nid,
        input  logic [31:0]   addr_i,
        output logic [31:0]   data_o
    );
        int unsigned timeout;
        begin
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_addr <= addr_i; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_write <= 1'b0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_sel <= 1'b1; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= 1'b0; end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_addr <= addr_i; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_write <= 1'b0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_sel <= 1'b1; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= 1'b0; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_rdata; end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= 1'b1; timeout = 0; while ((tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_ready !== 1'b1) && timeout < 40) begin @(posedge clk_sys); timeout++; end data_o = tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_rdata; end
            endcase
            @(negedge clk_sys);
            case (nid)
                0: begin tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_addr <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_write <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_sel <= '0; tniu0_tniu0_sys_apb_porting_tniu0_sys_apb_porting_p_enable <= '0; end
                default: begin tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_addr <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_write <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_sel <= '0; tniu1_tniu1_sys_apb_porting_tniu1_sys_apb_porting_p_enable <= '0; end
            endcase
        end
    endtask

    // ---- LUT programming (iniu_nid, src_intr_id, tgt_ring_id, tgt_intr_id) ----
    task automatic program_iniu_lut(
        input int unsigned   iniu_nid,
        input int unsigned   src_intr_id,
        input logic [7:0]    tgt_ring_id,
        input logic [11:0]   tgt_intr_id
    );
        logic [31:0] lut_data;
        begin
            lut_data = {8'h00, tgt_ring_id, 4'h0, tgt_intr_id};
            iniu_apb_write(iniu_nid, INTR_LUT_BASE_ADDR + 32'(src_intr_id) * 4, lut_data);
        end
    endtask

    // ---- Interrupt source drive ----
    task automatic set_iniu_intr(input int unsigned iniu_nid, input int unsigned bit_idx, input logic level_i);
        @(negedge clk_sys);
        case (iniu_nid)
            0: iniu0_iniu0_sys_v_interrupt_porting_iniu0_sys_v_interrupt_porting_v_interrupt[bit_idx] <= level_i;
            1: iniu1_iniu1_sys_v_interrupt_porting_iniu1_sys_v_interrupt_porting_v_interrupt[bit_idx] <= level_i;
            2: iniu2_iniu2_sys_v_interrupt_porting_iniu2_sys_v_interrupt_porting_v_interrupt[bit_idx] <= level_i;
            default: iniu3_iniu3_sys_v_interrupt_porting_iniu3_sys_v_interrupt_porting_v_interrupt[bit_idx] <= level_i;
        endcase
    endtask

    // ---- TNIU interrupt bit check ----
    task automatic expect_tniu_intr(
        input string         msg,
        input int unsigned   tniu_nid,
        input int unsigned   bit_idx,
        input logic          expected
    );
        case (tniu_nid)
            0: expect_bit(msg, tniu0_tniu0_sys_v_interrupt_porting_tniu0_sys_v_interrupt_porting_v_interrupt[bit_idx], expected);
            default: expect_bit(msg, tniu1_tniu1_sys_v_interrupt_porting_tniu1_sys_v_interrupt_porting_v_interrupt[bit_idx], expected);
        endcase
    endtask

    // =========================================================================
    // Test cases
    // =========================================================================

    task automatic tc001_power_on_defaults();
        begin
            $display("[TB] tc001_power_on_defaults");
            reset_dut();
            wait_sys(50);
            check_no_x_after_reset("tc001_power_on_defaults");
            // All TNIU interrupt outputs should be 0 after reset
            expect_tniu_intr("tc001 tniu0 intr35", 0, 35, 1'b0);
            expect_tniu_intr("tc001 tniu1 intr52", 1, 52, 1'b0);
            expect_bit("tc001 tniu0 merge0", tniu0_tniu0_sys_v_merge_interrupt_porting_tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt[0], 1'b0);
            expect_bit("tc001 tniu1 merge0", tniu1_tniu1_sys_v_merge_interrupt_porting_tniu1_sys_v_merge_interrupt_porting_v_merge_interrupt[0], 1'b0);
        end
    endtask

    task automatic tc_sanity();
        begin
            tc001_power_on_defaults();
            tc002_lut_programming();
            tc003_e2e_iniu0_tniu0();
            tc004_e2e_clear();
            tc005_tniu0_apb_controls();
            tc006_cross_ring_iniu3_tniu1();
            tc007_simultaneous_multi_source();
            tc008_multi_iniu_to_tniu0();
        end
    endtask

    task automatic tc002_lut_programming();
        logic [31:0] rdata;
        begin
            $display("[TB] tc002_lut_programming");
            reset_dut();
            program_iniu_lut(0, 5, TNIU0_RING_ID, 12'd35);
            wait_sys(4);
            iniu_apb_read(0, INTR_LUT_BASE_ADDR + 32'd20, rdata);
            expect_word("tc002 lut readback iniu0", rdata, {8'h00, TNIU0_RING_ID, 4'h0, 12'd35});
        end
    endtask

    task automatic tc003_e2e_iniu0_tniu0();
        begin
            $display("[TB] tc003_e2e_iniu0_tniu0");
            reset_dut();
            program_iniu_lut(0, 5, TNIU0_RING_ID, 12'd35);
            set_iniu_intr(0, 5, 1'b1);
            wait_sys(SYS_WAIT);
            expect_tniu_intr("tc003 tniu0 intr35 high", 0, 35, 1'b1);
        end
    endtask

    task automatic tc004_e2e_clear();
        begin
            $display("[TB] tc004_e2e_clear");
            reset_dut();
            program_iniu_lut(0, 5, TNIU0_RING_ID, 12'd35);
            set_iniu_intr(0, 5, 1'b1);
            wait_sys(SYS_WAIT);
            expect_tniu_intr("tc004 tniu0 intr35 set", 0, 35, 1'b1);
            set_iniu_intr(0, 5, 1'b0);
            wait_sys(SYS_WAIT);
            expect_tniu_intr("tc004 tniu0 intr35 cleared", 0, 35, 1'b0);
        end
    endtask

    task automatic tc005_tniu0_apb_controls();
        logic [31:0] rdata;
        begin
            $display("[TB] tc005_tniu0_apb_controls");
            reset_dut();
            // SW-SET: set bit 33 via APB SET register (word 1, bit 1)
            tniu_apb_write(0, INTR_SET_BASE_ADDR + 32'd4, 32'h0000_0002);
            wait_sys(4);
            tniu_apb_read(0, INTR_RAW_BASE_ADDR + 32'd4, rdata);
            expect_word("tc005 raw after set", rdata, 32'h0000_0002);
            expect_bit("tc005 merge1 high", tniu0_tniu0_sys_v_merge_interrupt_porting_tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt[1], 1'b1);
            // Mask merge1
            tniu_apb_write(0, INTR_MERGE_MASK_BASE_ADDR + 32'd4, 32'h0000_0002);
            wait_sys(4);
            expect_bit("tc005 merge1 masked", tniu0_tniu0_sys_v_merge_interrupt_porting_tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt[1], 1'b0);
            // CLR
            tniu_apb_write(0, INTR_CLR_BASE_ADDR + 32'd4, 32'h0000_0002);
            wait_sys(4);
            tniu_apb_read(0, INTR_RAW_BASE_ADDR + 32'd4, rdata);
            expect_word("tc005 raw after clr", rdata, 32'h0000_0000);
        end
    endtask

    task automatic tc006_cross_ring_iniu3_tniu1();
        // iniu3 (pos 3) -> tniu1 (pos 5): CW distance=2, CCW=4 -> takes CW
        // tgt_intr_id must be >= 32 (first 32 are reserved for TNIU internal errors)
        begin
            $display("[TB] tc006_cross_ring_iniu3_tniu1");
            reset_dut();
            program_iniu_lut(3, 10, TNIU1_RING_ID, 12'd52);
            set_iniu_intr(3, 10, 1'b1);
            wait_sys(SYS_WAIT);
            expect_tniu_intr("tc006 tniu1 intr52 high", 1, 52, 1'b1);
        end
    endtask

    task automatic tc007_simultaneous_multi_source();
        // iniu0 (pos 0) -> tniu1 (pos 5): CCW dist=1 -> CCW path
        // iniu2 (pos 2) -> tniu0 (pos 4): CW dist=2  -> CW path
        begin
            $display("[TB] tc007_simultaneous_iniu0_tniu1__iniu2_tniu0");
            reset_dut();
            program_iniu_lut(0, 7, TNIU1_RING_ID, 12'd60);
            program_iniu_lut(2, 8, TNIU0_RING_ID, 12'd70);
            // Assert both sources together
            @(negedge clk_sys);
            iniu0_iniu0_sys_v_interrupt_porting_iniu0_sys_v_interrupt_porting_v_interrupt[7] <= 1'b1;
            iniu2_iniu2_sys_v_interrupt_porting_iniu2_sys_v_interrupt_porting_v_interrupt[8] <= 1'b1;
            wait_sys(SYS_WAIT * 2);
            expect_tniu_intr("tc007 tniu1 intr60 high", 1, 60, 1'b1);
            expect_tniu_intr("tc007 tniu0 intr70 high", 0, 70, 1'b1);
            // No cross-contamination
            expect_tniu_intr("tc007 tniu0 intr60 still 0", 0, 60, 1'b0);
            expect_tniu_intr("tc007 tniu1 intr70 still 0", 1, 70, 1'b0);
        end
    endtask

    task automatic tc008_multi_iniu_to_tniu0();
        // All 4 INIUs send to TNIU0 with distinct target interrupt IDs
        begin
            $display("[TB] tc008_multi_iniu_flood_to_tniu0");
            reset_dut();
            program_iniu_lut(0, 20, TNIU0_RING_ID, 12'd100);
            program_iniu_lut(1, 21, TNIU0_RING_ID, 12'd101);
            program_iniu_lut(2, 22, TNIU0_RING_ID, 12'd102);
            program_iniu_lut(3, 23, TNIU0_RING_ID, 12'd103);
            // Assert all 4 sources
            @(negedge clk_sys);
            iniu0_iniu0_sys_v_interrupt_porting_iniu0_sys_v_interrupt_porting_v_interrupt[20] <= 1'b1;
            iniu1_iniu1_sys_v_interrupt_porting_iniu1_sys_v_interrupt_porting_v_interrupt[21] <= 1'b1;
            iniu2_iniu2_sys_v_interrupt_porting_iniu2_sys_v_interrupt_porting_v_interrupt[22] <= 1'b1;
            iniu3_iniu3_sys_v_interrupt_porting_iniu3_sys_v_interrupt_porting_v_interrupt[23] <= 1'b1;
            wait_sys(SYS_WAIT * 4);
            expect_tniu_intr("tc008 tniu0 intr100", 0, 100, 1'b1);
            expect_tniu_intr("tc008 tniu0 intr101", 0, 101, 1'b1);
            expect_tniu_intr("tc008 tniu0 intr102", 0, 102, 1'b1);
            expect_tniu_intr("tc008 tniu0 intr103", 0, 103, 1'b1);
        end
    endtask

    // =========================================================================
    // Main test sequence
    // =========================================================================
    initial begin
        fail_count = 0;
        pass_count = 0;
        if (!$value$plusargs("TESTCASE=%s", testcase)) testcase = "tc_sanity";

        if ((testcase == "all") || (testcase == "tc_sanity")) begin
            tc_sanity();
        end else begin
            $fatal(1, "[TB] Unknown TESTCASE=%s", testcase);
        end

        $display("[TB] pass_count=%0d  fail_count=%0d", pass_count, fail_count);
        if (fail_count != 0) begin
            $fatal(1, "[TB] %0d failure(s) detected", fail_count);
        end
        $display("[TB] all interrupt ring NoC testcases PASSED");
        $finish;
    end

endmodule

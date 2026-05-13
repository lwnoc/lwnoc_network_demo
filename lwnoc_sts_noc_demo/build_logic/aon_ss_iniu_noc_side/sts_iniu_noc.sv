module sts_iniu_noc
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `STS_INIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `STS_INIU_DBG_DATA_WIDTH,
    parameter integer unsigned FIFO_DEPTH          = `STS_INIU_FIFO_DEPTH,
    parameter integer unsigned SYNC_STAGE          = `STS_INIU_SYNC_STAGE,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = `STS_INIU_ERR_INT_CNT_WIDTH,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_OH = ($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH))? $clog2(STS_REQ_WIDTH) : $clog2(STS_REQ_WIDTH)+1,
    localparam int RSP_ECC_OH = ($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH))? $clog2(STS_RSP_WIDTH) : $clog2(STS_RSP_WIDTH)+1,
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_OH,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_OH
) (
    input   logic  clk_dst,
    input   logic  rst_n_dst,
    //==========================================================
    // interface with upstream afifo mst
    //==========================================================
    // request sync
    input   logic [FIFO_DEPTH-1:0]      req_wptr_async  ,
    output  logic [FIFO_DEPTH-1:0]      req_rptr_async  ,
    output  logic [FIFO_DEPTH-1:0]      req_rptr_sync   ,
    input   logic [REQ_AFIFO_W+1:0]     req_pld_sync    ,
    // response sync
    output  logic [FIFO_DEPTH-1:0]      rsp_wptr_async  ,
    input   logic [FIFO_DEPTH-1:0]      rsp_rptr_async  ,
    input   logic [FIFO_DEPTH-1:0]      rsp_rptr_sync   ,
    output  logic [RSP_AFIFO_W+1:0]     rsp_pld_sync    ,

    //==========================================================
    // interface with downstream decoder/tniu
    //==========================================================
    // request master interface
    output  logic                       req_s_vld       ,
    input   logic                       req_s_rdy       ,
    output [REQ_PLD_WIDTH-1:0]          req_s_pld       ,

    // response slave interface
    input   logic                       rsp_m_vld       ,
    output  logic                       rsp_m_rdy       ,
    input  [RSP_PLD_WIDTH-1:0]          rsp_m_pld       ,

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    // CTI — level event I/O (CDC in top) + channel (to/from dec_node CTM)
    //   sys_side_* ports connect toward sys side (via CDC in sts_iniu_top)
    //   Forward lane:  sys_side_cti_trigin / sys_side_cti_trigin_ack
    //   Reverse lane:  sys_side_cti_trigout / sys_side_cti_trigout_ack
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigin,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigin_ack,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigout,
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigout_ack,
    input   logic [CHANNEL_TOTAL_WIDTH-1:0] ctm_channel_in,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0] ctm_channel_out,

    // CTM — level event (from CTM direct, CDC in top), bypasses sts_cti
    //   sys_side_* ports connect toward sys side (via CDC in sts_iniu_top)
    //   Forward lane:  sys_side_ctm_trigin / sys_side_ctm_trigin_ack
    //   Reverse lane:  sys_side_ctm_trigout / sys_side_ctm_trigout_ack
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigin,
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigin_ack,
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigout,
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigout_ack,

    // CTI APB (from TNIU APB decoder or top-level)
    input   logic                           cti_apb_psel,
    input   logic                           cti_apb_penable,
    input   logic [11:0]                    cti_apb_paddr,
    input   logic                           cti_apb_pwrite,
    input   logic [31:0]                    cti_apb_pwdata,
    output  logic [31:0]                    cti_apb_prdata,
    output  logic                           cti_apb_pready,
    output  logic                           cti_apb_pslverr,

    //Debug timestamp
    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out,

    input   logic [RESERVE_WIDTH-1:0]        reserved_bits_in,
    output  logic [RESERVE_WIDTH-1:0]        reserved_bits_out,

    // FUSA AFIFO ECC error outputs (clk_dst domain)
    output  logic                           req_afifo_sb_err,
    output  logic                           req_afifo_db_err
);

    // Boundary cast: top-level vector ↔ internal struct
    sts_req_typ  req_s_pld_s;
    sts_rsp_typ  rsp_m_pld_s;

    logic [REQ_PLD_WIDTH-1:0]  req_s_pld_tmp;
    logic                      req_s_last_afifo;
    logic                      rsp_m_last;

    // REQ: ECC decode after AFIFO read (clk_dst domain)
    logic [REQ_AFIFO_W-1:0] req_s_pld_ecc;
    logic [RSP_AFIFO_W-1:0] rsp_m_pld_ecc;
    logic                    req_sb_err_raw, req_db_err_raw;
    localparam int           CHANNEL_TOTAL_W = CHANNEL_TOTAL_WIDTH;
    logic [CTI_EVENT_WIDTH-1:0] cti_ev_in_pulse;
    logic [CTI_EVENT_WIDTH-1:0] cti_ev_out_pulse;
    logic [CTI_EVENT_WIDTH-1:0] cti_ev_out_req;
    logic [CTM_TRIG_WIDTH-1:0]  ctm_ev_in_pulse;
    logic [CTM_TRIG_WIDTH-1:0]  ctm_ev_out_pulse;
    logic [CTM_TRIG_WIDTH-1:0]  ctm_ev_out_req;

    assign req_s_pld_s   = sts_req_typ'(req_s_pld_tmp);
    assign req_s_pld     = REQ_PLD_WIDTH'(req_s_pld_s);
    assign rsp_m_pld_s   = sts_rsp_typ'(rsp_m_pld);
    assign rsp_m_last    = rsp_m_pld_s.rsp.last;

    fcip_ecc_dec #(.DATA_WIDTH(STS_REQ_WIDTH)) u_req_ecc_dec (
        .encode_data(req_s_pld_ecc),
        .data       (req_s_pld_tmp  ),
        .sb_err     (req_sb_err_raw ),
        .db_err     (req_db_err_raw )
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_req_pulse_sb (
        .clk(clk_dst), .rst_n(rst_n_dst), .err_in(req_sb_err_raw), .intr_out(req_afifo_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_req_pulse_db (
        .clk(clk_dst), .rst_n(rst_n_dst), .err_in(req_db_err_raw), .intr_out(req_afifo_db_err)
    );
    // RSP: ECC encode before AFIFO write (clk_dst domain)
    fcip_ecc_enc #(.DATA_WIDTH(STS_RSP_WIDTH)) u_rsp_ecc_enc (
        .data       (RSP_PLD_WIDTH'(rsp_m_pld_s)),
        .encode_data(rsp_m_pld_ecc  )
    );

    fcip_req_rsp_afifo_mst #(
        .REQ_WIDTH      (REQ_AFIFO_W),
        .RSP_WIDTH      (RSP_AFIFO_W),
        .FIFO_DEPTH     (FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_sts_iniu_afifo_dst (
        .clk            (clk_dst        ),
        .rst_n          (rst_n_dst      ),
        .req_s_vld      (req_s_vld      ),
        .req_s_rdy      (req_s_rdy      ),
        .req_s_pld      (req_s_pld_ecc  ),
        .req_s_last     (req_s_last_afifo),
        .rsp_m_vld      (rsp_m_vld      ),
        .rsp_m_rdy      (rsp_m_rdy      ),
        .rsp_m_pld      (rsp_m_pld_ecc  ),
        .rsp_m_last     (rsp_m_last     ),
        .req_wptr_async (req_wptr_async ),
        .req_rptr_async (req_rptr_async ),
        .req_rptr_sync  (req_rptr_sync  ),
        .req_pld_sync   (req_pld_sync   ),
        .rsp_wptr_async (rsp_wptr_async ),
        .rsp_rptr_async (rsp_rptr_async ),
        .rsp_rptr_sync  (rsp_rptr_sync  ),
        .rsp_pld_sync   (rsp_pld_sync   )
    );

    fcip_marker #(
        .DATA_WIDTH(DBG_DATA_WIDTH)
    ) u_debug_data_marker (
        .I(dbg_data_in ),
        .Z(dbg_data_out)
    );

    fcip_sync_cell #(
        .DATA_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .SYN_STAGE   (SYNC_STAGE), // must upper than 1
        .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
        .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
    ) u_dbg_ts_sync (
        .clk         (clk_dst       ),
        .rst_n       (rst_n_dst     ),
        .d           (dbg_timestamp_in),
        .q           (dbg_timestamp_out)
    );

    fcip_marker #(
        .DATA_WIDTH(RESERVE_WIDTH)
    ) u_reserved_marker (
        .I(reserved_bits_in ),
        .Z(reserved_bits_out)
    );

    // =================================================================
    // CTI — pulse mode (EVENT_IN_LEVEL=0, SW_HANDSHAKE=0, no APB access)
    // cti_trig_in (level, CDC in parent) → CTI transmitter → pulse → sts_cti
    // sts_cti.trig_out → receiver → level → cti_trig_out
    // =================================================================
    // CTM trig — bypasses sts_cti: level→pulse → ctm_channel_out upper bits
    // ctm_channel_in upper bits → pulse→level → ctm_trig_out
    // ctm_channel = {ctm_trig_pulse, cti_channel}
    // =================================================================

    // IN→CTI: level→pulse conversion via transmitter
    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTI_EVENT_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_cti_ev_in_tx (
        .clk_tx        (clk_dst            ),
        .rstn_tx       (rst_n_dst          ),
        .pulse_out     (cti_ev_in_pulse    ),
        .pulse_req     (sys_side_cti_trigin     ),
        .pulse_ack     (sys_side_cti_trigin_ack ),
        .clk_tx_qactive(                   )
    );

    // IN→CTM: level→pulse conversion — goes directly to ctm_channel_out upper bits
    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTM_TRIG_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_ctm_ev_in_tx (
        .clk_tx        (clk_dst            ),
        .rstn_tx       (rst_n_dst          ),
        .pulse_out     (ctm_ev_in_pulse    ),
        .pulse_req     (sys_side_ctm_trigin     ),
        .pulse_ack     (sys_side_ctm_trigin_ack ),
        .clk_tx_qactive(                   )
    );

    // sts_cti only sees CTI events (not CTM)
    sts_cti #(
        .TRIG_IN_NUM    (CTI_EVENT_WIDTH   ),
        .TRIG_OUT_NUM   (CTI_EVENT_WIDTH   ),
        .CHANNEL_NUM    (CTI_CHANNEL_WIDTH ),
        .EVENT_IN_LEVEL ('0                ),  // pulse mode
        .SW_HANDSHAKE   ('0                ),  // pulse mode
        .SYNC_STAGE     (SYNC_STAGE        ),
        .APB_ADDR_WIDTH (12                )
    ) u_sts_cti (
        .clk            (clk_dst                                ),
        .rst_n          (rst_n_dst                              ),
        .psel           (cti_apb_psel                           ),
        .penable        (cti_apb_penable                        ),
        .paddr          (cti_apb_paddr                          ),
        .pwrite         (cti_apb_pwrite                         ),
        .pwdata         (cti_apb_pwdata                         ),
        .prdata         (cti_apb_prdata                         ),
        .pready         (cti_apb_pready                         ),
        .pslverr        (cti_apb_pslverr                        ),
        .trig_in        (cti_ev_in_pulse                        ),  // CTI only
        .trig_out       (cti_ev_out_pulse                       ),
        .channel_in     (ctm_channel_in[CTI_CHANNEL_WIDTH-1:0]  ),  // lower: CTI channel
        .channel_out    (ctm_channel_out[CTI_CHANNEL_WIDTH-1:0] ),  // lower: CTI channel
        .asicctrl       (                                       )
    );

    // CTM trig in — bypasses sts_cti, goes directly into channel upper bits
    assign ctm_channel_out[CHANNEL_TOTAL_W-1 : CTI_CHANNEL_WIDTH] = ctm_ev_in_pulse;

    // CTI: sts_cti.trig_out → receiver → level
    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTI_EVENT_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_cti_ev_out_rx (
        .clk_rx        (clk_dst            ),
        .rstn_rx       (rst_n_dst          ),
        .pulse_in      (cti_ev_out_pulse   ),
        .pulse_req     (cti_ev_out_req     ),
        .pulse_ack     (sys_side_cti_trigout_ack),
        .clk_rx_qactive(                   )
    );

    assign sys_side_cti_trigout = cti_ev_out_req;

    // CTM trig out — from ctm_channel_in upper bits → receiver → level
    assign ctm_ev_out_pulse = ctm_channel_in[CHANNEL_TOTAL_W-1 : CTI_CHANNEL_WIDTH];

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTM_TRIG_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_ctm_ev_out_rx (
        .clk_rx        (clk_dst            ),
        .rstn_rx       (rst_n_dst          ),
        .pulse_in      (ctm_ev_out_pulse   ),
        .pulse_req     (ctm_ev_out_req     ),
        .pulse_ack     (sys_side_ctm_trigout_ack),
        .clk_rx_qactive(                   )
    );

    assign sys_side_ctm_trigout = ctm_ev_out_req;

endmodule

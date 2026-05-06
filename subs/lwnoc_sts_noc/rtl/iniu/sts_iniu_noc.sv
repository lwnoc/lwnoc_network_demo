module `_PREFIX_(sts_iniu_noc)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned FIFO_DEPTH          = 4,
    parameter integer unsigned SYNC_STAGE          = 2,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = 16,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_OH = ($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH))? 8 : 9,
    localparam int RSP_ECC_OH = ($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH))? 8 : 9,
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_OH,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_OH
) (
    input   logic  clk_dst,
    input   logic  rst_n_dst,
    input   logic  clk_src,
    input   logic  rst_n_src,
    //==========================================================
    // interface with upstream afifo mst
    //==========================================================
    // request sync
    input   logic [FIFO_DEPTH-1:0]      req_wptr_async  ,
    output  logic [FIFO_DEPTH-1:0]      req_rptr_async  ,
    output  logic [FIFO_DEPTH-1:0]      req_rptr_sync   ,
    input   logic [REQ_PLD_WIDTH+1:0]   req_pld_sync    ,
    // response sync
    output  logic [FIFO_DEPTH-1:0]      rsp_wptr_async  ,
    input   logic [FIFO_DEPTH-1:0]      rsp_rptr_async  ,
    input   logic [FIFO_DEPTH-1:0]      rsp_rptr_sync   ,
    output  logic [RSP_PLD_WIDTH+1:0]   rsp_pld_sync    , 

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
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_in_ack,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_out_ack,
    input   logic [CTI_CHANNEL_WIDTH-1:0]   cti_channel_in,
    output  logic [CTI_CHANNEL_WIDTH-1:0]   cti_channel_out,

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
    // FUSA AFIFO ECC error outputs (clk_dst domain)
    output  logic                           req_afifo_sb_err,
    output  logic                           req_afifo_db_err
);

    // Boundary cast: top-level vector ↔ internal struct
    sts_req_typ  req_s_pld_s;
    sts_rsp_typ  rsp_m_pld_s;
    assign req_s_pld_s   = sts_req_typ'(req_s_pld);
    assign rsp_m_pld_s   = sts_rsp_typ'(rsp_m_pld);

    logic [REQ_PLD_WIDTH-1:0]  req_s_pld_tmp;
    logic                      req_s_last_afifo;
    logic                      rsp_m_last;

    // REQ: ECC decode after AFIFO read (clk_dst domain)
    logic [REQ_AFIFO_W-1:0] req_s_pld_ecc;
    logic [RSP_AFIFO_W-1:0] rsp_m_pld_ecc;
    logic                    req_sb_err_raw, req_db_err_raw;
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
        .data       (rsp_m_pld      ),
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

    localparam int RSP_LAST_BIT = $bits(sts_rsp_typ) - $bits(sts_rsp_ext_typ);  // .rsp.last = LSB of .rsp field
    assign rsp_m_last    = rsp_m_pld[RSP_LAST_BIT];

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

    // =================================================================
    // CTI — level mode (EVENT_IN_LEVEL=1, SW_HANDSHAKE=0, no APB access)
    // =================================================================
    // cti_event_in: level → sts_cti.trig_in (level mode, internal edge detect)
    // cti_event_in_ack: rising edge captured → level for CDC to sys
    // cti_event_out: sts_cti.trig_out (pulse) → pulse_async_bridge_receiver → level
    // cti_event_out_ack: sys ack → receiver.pulse_ack → clear level
    // cti_channel_in/out: to/from dec_node CTM (same noc domain)
    // =================================================================

    // cti_event_in_ack: rising edge captured → level for CDC to sys
    logic [CTI_EVENT_WIDTH-1:0]     ev_in_d1;
    logic [CTI_EVENT_WIDTH-1:0]     ev_in_rise;

    always_ff @(posedge clk_dst or negedge rst_n_dst) begin
        if (!rst_n_dst) begin
            ev_in_d1 <= '0;
        end else begin
            ev_in_d1 <= cti_event_in;
        end
    end
    assign ev_in_rise = cti_event_in & ~ev_in_d1;

    always_ff @(posedge clk_dst or negedge rst_n_dst) begin
        if (!rst_n_dst) begin
            cti_event_in_ack <= '0;
        end else begin
            for (int i = 0; i < CTI_EVENT_WIDTH; i = i + 1) begin
                if (ev_in_rise[i])              cti_event_in_ack[i] <= 1'b1;
                else if (~cti_event_in[i])      cti_event_in_ack[i] <= 1'b0;
            end
        end
    end

    `_PREFIX_(sts_cti) #(
        .TRIG_IN_NUM    (CTI_EVENT_WIDTH ),
        .TRIG_OUT_NUM   (CTI_EVENT_WIDTH ),
        .CHANNEL_NUM    (CTI_CHANNEL_WIDTH),
        .EVENT_IN_LEVEL ({CTI_EVENT_WIDTH{1'b1}}),  // level mode
        .SW_HANDSHAKE   ('0               ),  // pulse mode
        .SYNC_STAGE     (SYNC_STAGE       ),
        .APB_ADDR_WIDTH (12               )
    ) u_sts_cti (
        .clk            (clk_dst            ),
        .rst_n          (rst_n_dst          ),
        .psel           (cti_apb_psel       ),
        .penable        (cti_apb_penable    ),
        .paddr          (cti_apb_paddr      ),
        .pwrite         (cti_apb_pwrite     ),
        .pwdata         (cti_apb_pwdata     ),
        .prdata         (cti_apb_prdata     ),
        .pready         (cti_apb_pready     ),
        .pslverr        (cti_apb_pslverr    ),
        .trig_in        (cti_event_in       ),  // level, internal edge detect
        .trig_out       (ev_out_pulse       ),  // pulse → external receiver
        .channel_in     (cti_channel_in     ),
        .channel_out    (cti_channel_out    ),
        .asicctrl       (                   )
    );

    // CTI→sys: pulse_async_bridge_receiver (pulse→level latch)
    logic [CTI_EVENT_WIDTH-1:0]     ev_out_pulse;
    logic [CTI_EVENT_WIDTH-1:0]     ev_out_req;

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTI_EVENT_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_ev_out_rx (
        .clk_rx        (clk_dst            ),
        .rstn_rx       (rst_n_dst          ),
        .pulse_in      (ev_out_pulse       ),
        .pulse_req     (ev_out_req         ),
        .pulse_ack     (cti_event_out_ack  ),
        .clk_rx_qactive(                   )
    );

    assign cti_event_out = ev_out_req;
    
endmodule 
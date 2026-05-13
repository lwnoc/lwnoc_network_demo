module sts_tniu_top
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `STS_TNIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `STS_TNIU_DBG_DATA_WIDTH,
    parameter integer unsigned APB_ADDR_WIDTH      = `STS_TNIU_APB_ADDR_WIDTH,
    parameter integer unsigned SYNC_STAGE          = `STS_TNIU_SYNC_STAGE,
    parameter integer unsigned ASYNC_FIFO_DEPTH    = `STS_TNIU_ASYNC_FIFO_DEPTH,
    parameter integer unsigned FIFO_DEPTH          = `STS_TNIU_FIFO_DEPTH,
    parameter integer unsigned ERR_INT_CNT_WIDTH   = `STS_TNIU_ERR_INT_CNT_WIDTH,
    // --- tgt_id routing parameters ---
    // tgt_id[TGT_ID_WIDTH-1 -: TGT_TYPE_WIDTH] selects the target class:
    //   == LOCAL_APB_TGT_TYPE  -> local APB path (regbank / RSC)
    //   != LOCAL_APB_TGT_TYPE  -> forwarded to remote NOC NIU via ring
    parameter integer unsigned TGT_TYPE_WIDTH = `STS_TNIU_TGT_TYPE_WIDTH,
    parameter logic [TGT_TYPE_WIDTH-1:0] LOCAL_APB_TGT_TYPE = `STS_TNIU_LOCAL_APB_TGT_TYPE,
    // Exact tgt_id values for NOC-side local APB decode (first stage)
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_INIU_CTI_TGT_ID = `STS_TNIU_LOCAL_INIU_CTI_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_INIU_CTI_TGT_MASK = `STS_TNIU_LOCAL_INIU_CTI_TGT_MASK,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_ID = `STS_TNIU_LOCAL_REGBANK_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_MASK = `STS_TNIU_LOCAL_REGBANK_TGT_MASK,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_CTI_TGT_ID    = `STS_TNIU_LOCAL_CTI_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_CTI_TGT_MASK = `STS_TNIU_LOCAL_CTI_TGT_MASK,
    parameter logic                      HAS_INIU_CTI_APB   = `STS_TNIU_HAS_INIU_CTI_APB,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_OH = ($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH))? $clog2(STS_REQ_WIDTH) : $clog2(STS_REQ_WIDTH)+1,
    localparam int RSP_ECC_OH = ($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH))? $clog2(STS_RSP_WIDTH) : $clog2(STS_RSP_WIDTH)+1,
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_OH,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_OH
) (
    input   logic               clk_src ,
    input   logic               clk_dst ,
    input   logic               clk_dbg_timer,
    input   logic               rstn_src,
    input   logic               rstn_dst,
    input   logic               rstn_dbg_timer,

    input   logic               in_req_vld,
    output  logic               in_req_rdy,
    input  [REQ_PLD_WIDTH-1:0]  in_req_pld,

    output  logic               out_rsp_vld,
    input   logic               out_rsp_rdy,
    output [RSP_PLD_WIDTH-1:0] out_rsp_pld,

    //============================================================
    // APB with PMC
    //============================================================
    output  logic                  top_psel,
    output  logic                  top_penable,
    output  logic [APB_ADDR_WIDTH-1:0] top_paddr,
    output  logic                  top_pwrite,
    output  logic [31:0]           top_pwdata,
    input   logic [31:0]           top_prdata,
    input   logic                  top_pready,
    output  logic [3:0]            top_pstrb,
    output  logic [2:0]            top_pprot,
    input   logic                  top_pslverr,

    // External sys-side APB master
    output  logic                                m_psel      ,
    output  logic [APB_ADDR_WIDTH-1:0]           m_paddr     ,
    input   logic                                m_pready    ,
    input   logic [31:0]                         m_prdata    ,
    input   logic                                m_pslverr   ,
    output  logic [2:0]                          m_pprot     ,
    output  logic                                m_penable   ,
    output  logic                                m_pwrite    ,
    output  logic [31:0]                         m_pwdata    ,
    output  logic [3:0]                          m_pstrb     ,
    output  logic [319:0]                        v_tniu_sys_reg,

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out,

    input   logic [RESERVE_WIDTH-1:0]        reserved_bits_in,
    output  logic [RESERVE_WIDTH-1:0]        reserved_bits_out,

    // CTI — level event I/O (CDC in this module) + channel (to/from dec_node CTM)
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_trig_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_trig_out,

    // CTM — level event (CTM direct), CDC in this module
    input   logic [CTM_TRIG_WIDTH-1:0]      ctm_trig_in,
    output  logic [CTM_TRIG_WIDTH-1:0]      ctm_trig_out,

    input   logic [CHANNEL_TOTAL_WIDTH-1:0]   ctm_channel_in,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]   ctm_channel_out,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]   ctm_channel_dec_out,
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]   ctm_channel_dec_in,

    ///============================================================
    // Static Signal
    //=============================================================
    output  logic [31:0] timing_bus1,
    output  logic [31:0] timing_bus2,
    output  logic [31:0] timing_bus3,
    output  logic [31:0] dbg_en,
    output  logic [9:0]  hw_dbg_sel,
    output  logic        tniu_regbank_parity_err,
    output  logic        tniu_req_afifo_sb_err,
    output  logic        tniu_req_afifo_db_err,
    output  logic        tniu_rsp_afifo_sb_err,
    output  logic        tniu_rsp_afifo_db_err
);

    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_wptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_rptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_rptr_sync;
    logic [REQ_AFIFO_W+1:0]         tmp_req_pld_sync;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_wptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_rptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_rptr_sync;
    logic [RSP_AFIFO_W+1:0]         tmp_rsp_pld_sync;

    logic [DBG_DATA_WIDTH-1:0]      dbg_data_tmp;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;
    logic [RESERVE_WIDTH-1:0]       reserved_bits_tmp;

    // CTI CDC: sys→noc event, noc→sys event
    logic [CTI_EVENT_WIDTH-1:0]  cti_sys_to_noc;
    logic [CTI_EVENT_WIDTH-1:0]  cti_noc_to_sys;
    logic [CTI_EVENT_WIDTH-1:0]  cti_noc_in_ack;
    logic [CTI_EVENT_WIDTH-1:0]  cti_sys_ack_from_noc;
    logic [CTI_EVENT_WIDTH-1:0]  cti_sys_ev_from_noc;
    logic [CTI_EVENT_WIDTH-1:0]  cti_out_ack_to_noc;
    logic [CTI_EVENT_WIDTH-1:0]  cti_sys_event_auto_ack;

    // CTM CDC: sys→noc event, noc→sys event
    logic [CTM_TRIG_WIDTH-1:0]   ctm_sys_to_noc;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_noc_to_sys;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_noc_in_ack;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_sys_ack_from_noc;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_sys_ev_from_noc;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_out_ack_to_noc;
    logic [CTM_TRIG_WIDTH-1:0]   ctm_sys_event_auto_ack;
    logic                        tniu_noc_regbank_parity_err;
    logic                        tniu_sys_regbank_parity_err;
    logic [9:0]                  hw_dbg_sel_noc;

    sts_req_typ  in_req_pld_s;
    sts_rsp_typ  out_rsp_pld_s;

    // Boundary cast: top-level vector ↔ internal struct
    assign in_req_pld_s = sts_req_typ'(in_req_pld);
    assign out_rsp_pld  = RSP_PLD_WIDTH'(out_rsp_pld_s);
    assign cti_sys_event_auto_ack = '1;
    assign ctm_sys_event_auto_ack = '1;
    assign tniu_regbank_parity_err = tniu_noc_regbank_parity_err | tniu_sys_regbank_parity_err;

    sts_tniu_noc  #(
        .DBG_TIMESTAMP_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH       (DBG_DATA_WIDTH),
        .APB_ADDR_WIDTH       (APB_ADDR_WIDTH),
        .SYNC_STAGE           (SYNC_STAGE),
        .ASYNC_FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .FIFO_DEPTH           (FIFO_DEPTH),
        .TGT_TYPE_WIDTH       (TGT_TYPE_WIDTH),
        .LOCAL_APB_TGT_TYPE   (LOCAL_APB_TGT_TYPE),
        .LOCAL_INIU_CTI_TGT_ID     (LOCAL_INIU_CTI_TGT_ID),
        .LOCAL_INIU_CTI_TGT_MASK   (LOCAL_INIU_CTI_TGT_MASK),
        .LOCAL_REGBANK_TGT_ID (LOCAL_REGBANK_TGT_ID),
        .LOCAL_REGBANK_TGT_MASK    (LOCAL_REGBANK_TGT_MASK),
        .HAS_INIU_CTI_APB     (HAS_INIU_CTI_APB    ),
        .LOCAL_CTI_TGT_ID     (LOCAL_CTI_TGT_ID),
        .LOCAL_CTI_TGT_MASK        (LOCAL_CTI_TGT_MASK),
        .ERR_INT_CNT_WIDTH    (ERR_INT_CNT_WIDTH)
    ) u_sts_tniu_noc (
        .clk_src            (clk_src),
        .rstn_src           (rstn_src),
        .in_req_vld         (in_req_vld),
        .in_req_rdy         (in_req_rdy),
        .in_req_pld         (in_req_pld_s),
        .out_rsp_vld        (out_rsp_vld),
        .out_rsp_rdy        (out_rsp_rdy),
        .out_rsp_pld        (out_rsp_pld_s),
        .req_wptr_async     (tmp_req_wptr_async),
        .req_rptr_async     (tmp_req_rptr_async),
        .req_rptr_sync      (tmp_req_rptr_sync),
        .req_pld_sync       (tmp_req_pld_sync),
        .rsp_wptr_async     (tmp_rsp_wptr_async),
        .rsp_rptr_async     (tmp_rsp_rptr_async),
        .rsp_rptr_sync      (tmp_rsp_rptr_sync),
        .rsp_pld_sync       (tmp_rsp_pld_sync),
        .psel               (top_psel),
        .penable            (top_penable),
        .paddr              (top_paddr),
        .pwrite             (top_pwrite),
        .pwdata             (top_pwdata),
        .prdata             (top_prdata),
        .pready             (top_pready),
        .pstrb              (top_pstrb),
        .pprot              (top_pprot),
        .pslverr            (top_pslverr),
        .dbg_data_in        (dbg_data_in),
        .dbg_data_out       (dbg_data_tmp),
        .dbg_timestamp_in   (dbg_timestamp_in),
        .reserved_bits_in   (reserved_bits_in),
        .reserved_bits_out  (reserved_bits_tmp),
        .dbg_timestamp_out  (dbg_timestamp_tmp),
        .sys_side_cti_trigin     (cti_sys_to_noc     ),  // sys→noc event → sts_cti
        .sys_side_cti_trigin_ack (cti_noc_in_ack     ),  // noc→sys ack for event_in path
        .sys_side_cti_trigout    (cti_noc_to_sys     ),  // sts_cti event → sys
        .sys_side_cti_trigout_ack(cti_out_ack_to_noc ),
        .ctm_channel_in    (ctm_channel_dec_in ),
        .ctm_channel_out   (ctm_channel_dec_out),
        .sys_side_ctm_trigin     (ctm_sys_to_noc     ),
        .sys_side_ctm_trigin_ack (ctm_noc_in_ack     ),
        .sys_side_ctm_trigout    (ctm_noc_to_sys     ),
        .sys_side_ctm_trigout_ack(ctm_out_ack_to_noc ),
        .timing_bus1        (timing_bus1),
        .timing_bus2        (timing_bus2),
        .timing_bus3        (timing_bus3),
        .dbg_en             (dbg_en     ),
        .hw_dbg_sel         (hw_dbg_sel_noc),
        .tniu_regbank_parity_err(tniu_noc_regbank_parity_err),
        .rsp_afifo_sb_err   (tniu_rsp_afifo_sb_err),
        .rsp_afifo_db_err   (tniu_rsp_afifo_db_err)
    );

    sts_tniu_sys #(
        .DBG_TIMESTAMP_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH       (DBG_DATA_WIDTH),
        .APB_ADDR_WIDTH       (APB_ADDR_WIDTH),
        .SYNC_STAGE           (SYNC_STAGE),
        .ASYNC_FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .ERR_INT_CNT_WIDTH    (ERR_INT_CNT_WIDTH)
    ) u_sts_tniu_sys (
        .clk_dst            (clk_dst),
        .clk_dbg_timer      (clk_dbg_timer),
        .rstn_dst           (rstn_dst),
        .rstn_dbg_timer     (rstn_dbg_timer),
        .req_wptr_async     (tmp_req_wptr_async),
        .req_rptr_async     (tmp_req_rptr_async),
        .req_rptr_sync      (tmp_req_rptr_sync),
        .req_pld_sync       (tmp_req_pld_sync),
        .rsp_wptr_async     (tmp_rsp_wptr_async),
        .rsp_rptr_async     (tmp_rsp_rptr_async),
        .rsp_rptr_sync      (tmp_rsp_rptr_sync),
        .rsp_pld_sync       (tmp_rsp_pld_sync),
        .m_psel             (m_psel),
        .m_paddr            (m_paddr),
        .m_pready           (m_pready),
        .m_prdata           (m_prdata),
        .m_pslverr          (m_pslverr),
        .m_pprot            (m_pprot),
        .m_penable          (m_penable),
        .m_pwrite           (m_pwrite),
        .m_pwdata           (m_pwdata),
        .m_pstrb            (m_pstrb),
        .v_tniu_sys_reg     (v_tniu_sys_reg),
        .sys_cti_trigin     (cti_trig_in     ),
        .noc_cti_trigin     (cti_sys_to_noc       ),
        .noc_cti_trigin_ack (cti_noc_in_ack       ),
        .sys_cti_trigin_ack (cti_sys_ack_from_noc ),
        .noc_cti_trigout    (cti_noc_to_sys       ),
        .sys_cti_trigout    (cti_sys_ev_from_noc  ),
        .sys_cti_trigout_ack(cti_sys_event_auto_ack),
        .noc_cti_trigout_ack(cti_out_ack_to_noc   ),
        .sys_ctm_trigin     (ctm_trig_in     ),
        .noc_ctm_trigin     (ctm_sys_to_noc       ),
        .noc_ctm_trigin_ack (ctm_noc_in_ack       ),
        .sys_ctm_trigin_ack (ctm_sys_ack_from_noc ),
        .noc_ctm_trigout    (ctm_noc_to_sys       ),
        .sys_ctm_trigout    (ctm_sys_ev_from_noc  ),
        .sys_ctm_trigout_ack(ctm_sys_event_auto_ack),
        .noc_ctm_trigout_ack(ctm_out_ack_to_noc   ),
        .dbg_data_in        (dbg_data_tmp),
        .reserved_bits_in   (reserved_bits_tmp),
        .reserved_bits_out  (reserved_bits_out),
        .dbg_data_out       (dbg_data_out),
        .dbg_timestamp_in   (dbg_timestamp_tmp),
        .dbg_timestamp_out  (dbg_timestamp_out),
        .tniu_sys_regbank_parity_err(tniu_sys_regbank_parity_err),
        .sts_tniu_req_afifo_sb_err(tniu_req_afifo_sb_err),
        .sts_tniu_req_afifo_db_err(tniu_req_afifo_db_err),
        .hw_dbg_sel_in     (hw_dbg_sel_noc),
        .hw_dbg_sel_out    (hw_dbg_sel)
    );
always_comb begin
    cti_trig_out  = cti_sys_ev_from_noc;
    ctm_trig_out  = ctm_sys_ev_from_noc;
    ctm_channel_out = ctm_channel_dec_in;
end
endmodule

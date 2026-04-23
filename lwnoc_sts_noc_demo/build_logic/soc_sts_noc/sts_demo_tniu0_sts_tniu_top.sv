module sts_demo_tniu0_sts_tniu_top
import sts_demo_tniu0_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned APB_ADDR_WIDTH      = 32,
    parameter integer unsigned SYNC_STAGE = 2,
    parameter integer unsigned ASYNC_FIFO_DEPTH = 4,
    // --- tgt_id routing parameters ---
    // tgt_id[TGT_ID_WIDTH-1 -: TGT_TYPE_WIDTH] selects the target class:
    //   == LOCAL_APB_TGT_TYPE  -> local APB path (regbank / RSC)
    //   != LOCAL_APB_TGT_TYPE  -> forwarded to remote NOC NIU via ring
    parameter integer unsigned TGT_TYPE_WIDTH = 2,
    parameter logic [TGT_TYPE_WIDTH-1:0] LOCAL_APB_TGT_TYPE = 2'b01,
    // Exact tgt_id values for NOC-side local APB decode (first stage)
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_RSC_TGT_ID = '0,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_ID = 'd1,
    // Exact tgt_id values for SYS-side APB parameterized decoder
    parameter integer unsigned SYS_APB_MASTER_NUM = 2,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_BASE = '0,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_MASK = '0,
    localparam int REQ_PLD_WIDTH = $bits(sts_req_typ),
    localparam int RSP_PLD_WIDTH = $bits(sts_rsp_typ)
) (
    input   logic               clk_src ,
    input   logic               clk_dst ,
    input   logic               clk_dbg_timer,
    input   logic               rstn_src,
    input   logic               rstn_dst,
    input   logic               rstn_dbg_timer,

    input   logic               in_req_vld,
    output  logic               in_req_rdy,
    input   sts_req_typ         in_req_pld,

    output  logic               out_rsp_vld,
    input   logic               out_rsp_rdy,
    output  sts_rsp_typ         out_rsp_pld,

    //============================================================
    // APB with PMC
    //============================================================
    output  logic                  pmc_psel,
    output  logic                  pmc_penable,
    output  logic [APB_ADDR_WIDTH-1:0] pmc_paddr,
    output  logic                  pmc_pwrite,
    output  logic [31:0]           pmc_pwdata,
    input   logic [31:0]           pmc_prdata,
    input   logic                  pmc_pready,
    output  logic [3:0]            pmc_pstrb,
    output  logic [2:0]            pmc_pprot,
    input   logic                  pmc_pslverr,

    // APB to NOC NIU — parameterized arrays
    output  logic [SYS_APB_MASTER_NUM-1:0]       m_psel      ,
    output  logic [APB_ADDR_WIDTH-1:0]           m_paddr     ,
    input   logic [SYS_APB_MASTER_NUM-1:0]       m_pready    ,
    input   logic [SYS_APB_MASTER_NUM*32-1:0]    m_prdata    ,
    input   logic [SYS_APB_MASTER_NUM-1:0]       m_pslverr   ,
    output  logic [2:0]                          m_pprot     ,
    output  logic                                m_penable   ,
    output  logic                                m_pwrite    ,
    output  logic [31:0]                         m_pwdata    ,
    output  logic [3:0]                          m_pstrb     ,

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out,

    // CTI
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_out,
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_event_in,

    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_channel_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_channel_out,
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_channel_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_channel_in,

    ///============================================================
    // Static Signal
    //=============================================================
    output  logic [31:0] timing_bus1,
    output  logic [31:0] timing_bus2,
    output  logic [31:0] timing_bus3,
    output  logic [31:0] dbg_en
);

    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_wptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_rptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_req_rptr_sync;
    logic [REQ_PLD_WIDTH+1:0]       tmp_req_pld_sync;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_wptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_rptr_async;
    logic [ASYNC_FIFO_DEPTH-1:0]    tmp_rsp_rptr_sync;
    logic [RSP_PLD_WIDTH+1:0]       tmp_rsp_pld_sync;

    logic [DBG_DATA_WIDTH-1:0]      dbg_data_tmp;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;

    logic [CTI_EVENT_WIDTH-1:0]     tmp_event_in_req;
    logic [CTI_EVENT_WIDTH-1:0]     tmp_event_in_ack;
    logic [CTI_EVENT_WIDTH-1:0]     tmp_event_out_req;
    logic [CTI_EVENT_WIDTH-1:0]     tmp_event_out_ack;
    logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_in_req;
    logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_in_ack;
    logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_out_req;
    logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_out_ack;

    sts_demo_tniu0_sts_tniu_noc  #(
        .DBG_TIMESTAMP_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH       (DBG_DATA_WIDTH),
        .APB_ADDR_WIDTH       (APB_ADDR_WIDTH),
        .SYNC_STAGE           (SYNC_STAGE),
        .ASYNC_FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .TGT_TYPE_WIDTH       (TGT_TYPE_WIDTH),
        .LOCAL_APB_TGT_TYPE   (LOCAL_APB_TGT_TYPE),
        .LOCAL_RSC_TGT_ID     (LOCAL_RSC_TGT_ID),
        .LOCAL_REGBANK_TGT_ID (LOCAL_REGBANK_TGT_ID)
    ) u_sts_tniu_noc (
        .clk_src            (clk_src),
        .clk_dst            (clk_dst),
        .rstn_src           (rstn_src),
        .rstn_dst           (rstn_dst),
        .in_req_vld         (in_req_vld),
        .in_req_rdy         (in_req_rdy),
        .in_req_pld         (in_req_pld),
        .out_rsp_vld        (out_rsp_vld),
        .out_rsp_rdy        (out_rsp_rdy),
        .out_rsp_pld        (out_rsp_pld),
        .req_wptr_async     (tmp_req_wptr_async),
        .req_rptr_async     (tmp_req_rptr_async),
        .req_rptr_sync      (tmp_req_rptr_sync),
        .req_pld_sync       (tmp_req_pld_sync),
        .rsp_wptr_async     (tmp_rsp_wptr_async),
        .rsp_rptr_async     (tmp_rsp_rptr_async),
        .rsp_rptr_sync      (tmp_rsp_rptr_sync),
        .rsp_pld_sync       (tmp_rsp_pld_sync),
        .psel               (pmc_psel),
        .penable            (pmc_penable),
        .paddr              (pmc_paddr),
        .pwrite             (pmc_pwrite),
        .pwdata             (pmc_pwdata),
        .prdata             (pmc_prdata),
        .pready             (pmc_pready),
        .pstrb              (pmc_pstrb),
        .pprot              (pmc_pprot),
        .pslverr            (pmc_pslverr),
        .dbg_data_in        (dbg_data_in),
        .dbg_data_out       (dbg_data_tmp),
        .dbg_timestamp_in   (dbg_timestamp_in),
        .dbg_timestamp_out  (dbg_timestamp_tmp),
        .cti_event_in       (noc_cti_event_in),
        .cti_event_in_req   (tmp_event_in_req),
        .cti_event_in_ack   (tmp_event_in_ack),
        .cti_event_out      (noc_cti_event_out),
        .cti_event_out_req  (tmp_event_out_req),
        .cti_event_out_ack  (tmp_event_out_ack),
        .cti_channel_in     (noc_cti_channel_in),
        .cti_channel_in_req (tmp_channel_in_req),
        .cti_channel_in_ack (tmp_channel_in_ack),
        .cti_channel_out    (noc_cti_channel_out),
        .cti_channel_out_req(tmp_channel_out_req),
        .cti_channel_out_ack(tmp_channel_out_ack),
        .timing_bus1        (timing_bus1),
        .timing_bus2        (timing_bus2),
        .timing_bus3        (timing_bus3),
        .dbg_en             (dbg_en     )
    );

    sts_demo_tniu0_sts_tniu_sys #(
        .DBG_TIMESTAMP_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH       (DBG_DATA_WIDTH),
        .APB_ADDR_WIDTH       (APB_ADDR_WIDTH),
        .SYNC_STAGE           (SYNC_STAGE),
        .ASYNC_FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .SYS_APB_MASTER_NUM   (SYS_APB_MASTER_NUM),
        .SYS_APB_ROUTE_BASE   (SYS_APB_ROUTE_BASE),
        .SYS_APB_ROUTE_MASK   (SYS_APB_ROUTE_MASK)
    ) u_sts_tniu_sys (
        .clk_src            (clk_src),
        .clk_dst            (clk_dst),
        .clk_dbg_timer      (clk_dbg_timer),
        .rstn_src           (rstn_src),
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
        .cti_event_in       (sys_cti_event_in),
        .cti_event_in_req   (tmp_event_out_req),
        .cti_event_in_ack   (tmp_event_out_ack),
        .cti_event_out      (sys_cti_event_out),
        .cti_event_out_req  (tmp_event_in_req),
        .cti_event_out_ack  (tmp_event_in_ack),
        .cti_channel_in     (sys_cti_channel_in),
        .cti_channel_in_req (tmp_channel_out_req),
        .cti_channel_in_ack (tmp_channel_out_ack),
        .cti_channel_out    (sys_cti_channel_out),
        .cti_channel_out_req(tmp_channel_in_req),
        .cti_channel_out_ack(tmp_channel_in_ack),
        .dbg_data_in        (dbg_data_tmp),
        .dbg_data_out       (dbg_data_out),
        .dbg_timestamp_in   (dbg_timestamp_tmp),
        .dbg_timestamp_out  (dbg_timestamp_out)
    );
endmodule

module `_PREFIX_(sts_iniu_noc)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned FIFO_DEPTH          = 4,
    parameter integer unsigned SYNC_STAGE          = 2,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH
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
    output  sts_req_typ                 req_s_pld       ,

    // response slave interface
    input   logic                       rsp_m_vld       ,
    output  logic                       rsp_m_rdy       ,
    input   sts_rsp_typ                 rsp_m_pld       ,

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    //CTI
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_in_req,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_in_ack,
    
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_out_req,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_out_ack,

    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in_req,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in_ack,

    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out_req,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out_ack,

    //Debug timestamp
    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out
);

    logic [REQ_PLD_WIDTH-1:0]  req_s_pld_tmp;
    logic                      req_s_last_afifo;
    logic                      rsp_m_last;

    fcip_req_rsp_afifo_mst #(
        .REQ_WIDTH      (REQ_PLD_WIDTH),
        .RSP_WIDTH      (RSP_PLD_WIDTH),
        .FIFO_DEPTH     (FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_sts_iniu_afifo_dst (
        .clk            (clk_dst        ),
        .rst_n          (rst_n_dst      ),
        .req_s_vld      (req_s_vld      ),
        .req_s_rdy      (req_s_rdy      ),
        .req_s_pld      (req_s_pld_tmp  ),
        .req_s_last     (req_s_last_afifo),
        .rsp_m_vld      (rsp_m_vld      ),
        .rsp_m_rdy      (rsp_m_rdy      ),
        .rsp_m_pld      (rsp_m_pld      ),
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

    assign req_s_pld     = req_s_pld_tmp;
    assign rsp_m_last    = rsp_m_pld.rsp.last;

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

    `_PREFIX_(cti_handle) #(
        .SYNC_STAGE(SYNC_STAGE)
    ) u_cti_handle_iniu_sys (
        .clk_src            (clk_src            ),
        .clk_dst            (clk_dst            ),
        .rstn_src           (rst_n_src          ),
        .rstn_dst           (rst_n_dst          ),
        .cti_event_in       (cti_event_in       ),
        .cti_event_in_req   (cti_event_in_req   ),
        .cti_event_in_ack   (cti_event_in_ack   ),
        .cti_event_out      (cti_event_out      ),
        .cti_event_out_req  (cti_event_out_req  ),
        .cti_event_out_ack  (cti_event_out_ack  ),
        .cti_channel_in     (cti_channel_in     ),
        .cti_channel_in_req (cti_channel_in_req ),
        .cti_channel_in_ack (cti_channel_in_ack ),
        .cti_channel_out    (cti_channel_out    ),
        .cti_channel_out_req(cti_channel_out_req),
        .cti_channel_out_ack(cti_channel_out_ack)
    );

    
endmodule 
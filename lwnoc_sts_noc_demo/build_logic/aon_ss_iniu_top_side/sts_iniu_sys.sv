module sts_iniu_sys
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned FIFO_DEPTH          = 4,
    parameter integer unsigned SYNC_STAGE          = 2,
    parameter integer unsigned NODE_NUM            = 2,
    parameter integer unsigned ADDR_MAP_ENTRY_NUM  = 1,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_BASE_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_MASK_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = '0,
    parameter bit                          ADDR_MAP_LINEAR_EN         = 0,
    parameter logic [AXI_ADDR_WIDTH-1:0]   ADDR_MAP_LINEAR_BASE       = '0,
    parameter integer unsigned             ADDR_MAP_LINEAR_NUM        = 1,
    parameter integer unsigned             ADDR_MAP_LINEAR_STRIDE_LOG2 = 0,
    parameter logic [TGT_ID_WIDTH-1:0]     ADDR_MAP_LINEAR_TGT_BASE   = '0,
    parameter logic [TGT_ID_WIDTH-1:0]                      ADDR_MAP_DEFAULT_TGT_ID = '0,
    localparam int REQ_PLD_AFIFO_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_AFIFO_WIDTH = STS_RSP_WIDTH
) (
    input logic clk_src ,
    input logic clk_dst ,
    // input logic clk_dbg_timer,

    input logic rstn_src,
    input logic rstn_dst,
    // input logic rstn_dbg_timer,

    //=================================================================
    // interface with axi iniu
    //=================================================================
    input   logic [SRC_ID_WIDTH-1:0]          node_id,

    input   logic                             s_awvalid,
    output  logic                             s_awready,
    input   logic [AXI_AWID_WIDTH-1:0]        s_awid,
    input   logic [AXI_ADDR_WIDTH-1:0]        s_awaddr,
    input   logic [AXI_AWLEN_WIDTH-1:0]       s_awlen,
    input   logic [2:0]                       s_awsize,
    input   logic [1:0]                       s_awburst,
    input   logic                             s_awlock,
    input   logic [3:0]                       s_awcache,
    input   logic [2:0]                       s_awprot,
    input   logic [3:0]                       s_awqos,
    input   logic [AXI_USER_WIDTH-1:0]      s_awuser,

    input   logic                             s_wvalid,
    output  logic                             s_wready,
    input   logic [AXI_DATA_WIDTH-1:0]        s_wdata,
    input   logic [AXI_STRB_WIDTH-1:0]        s_wstrb,
    input   logic                             s_wlast,

    output  logic                             s_bvalid,
    input   logic                             s_bready,
    output  logic [AXI_BID_WIDTH-1:0]         s_bid,
    output  logic [1:0]                       s_bresp,

    input   logic                             s_arvalid,
    output  logic                             s_arready,
    input   logic [AXI_ARID_WIDTH-1:0]        s_arid,
    input   logic [AXI_ADDR_WIDTH-1:0]        s_araddr,
    input   logic [AXI_ARLEN_WIDTH-1:0]       s_arlen,
    input   logic [2:0]                       s_arsize,
    input   logic [1:0]                       s_arburst,
    input   logic                             s_arlock,
    input   logic [3:0]                       s_arcache,
    input   logic [2:0]                       s_arprot,
    input   logic [3:0]                       s_arqos,
    input   logic [AXI_USER_WIDTH-1:0]        s_aruser,

    output  logic                             s_rvalid,
    input   logic                             s_rready,
    output  logic [AXI_RID_WIDTH-1:0]         s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]        s_rdata,
    output  logic [1:0]                       s_rresp,
    output  logic                             s_rlast,

    //=================================================================
    // interface with async fifo mst,width(paylod)+1(insert bubble)
    //=================================================================
    // request sync
    output  logic [FIFO_DEPTH-1:0]          req_wptr_async  ,
    input   logic [FIFO_DEPTH-1:0]          req_rptr_async  ,
    input   logic [FIFO_DEPTH-1:0]          req_rptr_sync   ,
    output  logic [REQ_PLD_AFIFO_WIDTH+1:0]   req_pld_sync    ,
    // response sync
    input   logic [FIFO_DEPTH-1:0]          rsp_wptr_async  ,
    output  logic [FIFO_DEPTH-1:0]          rsp_rptr_async  ,
    output  logic [FIFO_DEPTH-1:0]          rsp_rptr_sync   ,
    input   logic [RSP_PLD_AFIFO_WIDTH+1:0]   rsp_pld_sync    ,

    // CTI
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

    input   logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out,

    input   logic [DBG_DATA_WIDTH-1:0]      dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out
);



    logic                   bundle_aw_vld;
    logic                   bundle_aw_rdy;
    wire sts_iniu_axi_aw_chnl    bundle_aw_pld;

    logic                   bundle_w_vld;
    logic                   bundle_w_rdy;
    wire sts_iniu_axi_w_chnl     bundle_w_pld;

    logic                   bundle_b_vld;
    logic                   bundle_b_rdy;
    wire sts_iniu_axi_b_chnl     bundle_b_pld;

    logic                   bundle_ar_vld;
    logic                   bundle_ar_rdy;
    wire sts_iniu_axi_ar_chnl    bundle_ar_pld;

    logic                   bundle_r_vld;
    logic                   bundle_r_rdy;
    wire sts_iniu_axi_r_chnl     bundle_r_pld;

    logic                   req_vld_temp;
    logic                   req_rdy_temp;
    sts_req_typ             req_pld_temp;
    logic                   req_last_temp;

    logic                   rsp_vld_temp;
    logic                   rsp_rdy_temp;
    sts_rsp_typ             rsp_pld_temp;
    logic                   rsp_last_temp;
    logic                   rsp_last_afifo;

    logic [REQ_PLD_AFIFO_WIDTH-1:0] req_pld_afifo;
    logic [RSP_PLD_AFIFO_WIDTH-1:0] rsp_pld_afifo;

    sts_iniu_axi_bundle u_axi_bundle (
        .s_awvalid (s_awvalid ),
        .s_awready (s_awready ),
        .s_awid    (s_awid    ),
        .s_awaddr  (s_awaddr  ),
        .s_awlen   (s_awlen   ),
        .s_awsize  (s_awsize  ),
        .s_awburst (s_awburst ),
        .s_awlock  (s_awlock  ),
        .s_awcache (s_awcache ),
        .s_awprot  (s_awprot  ),
        .s_awqos   (s_awqos   ),
        .s_awuser  (s_awuser  ),
        .s_wvalid  (s_wvalid  ),
        .s_wready  (s_wready  ),
        .s_wdata   (s_wdata   ),
        .s_wstrb   (s_wstrb   ),
        .s_wlast   (s_wlast   ),
        .s_bvalid  (s_bvalid  ),
        .s_bready  (s_bready  ),
        .s_bid     (s_bid     ),
        .s_bresp   (s_bresp   ),
        .s_arvalid (s_arvalid ),
        .s_arready (s_arready ),
        .s_arid    (s_arid    ),
        .s_araddr  (s_araddr  ),
        .s_arlen   (s_arlen   ),
        .s_arsize  (s_arsize  ),
        .s_arburst (s_arburst ),
        .s_arlock  (s_arlock  ),
        .s_arcache (s_arcache ),
        .s_arprot  (s_arprot  ),
        .s_arqos   (s_arqos   ),
        .s_aruser  (s_aruser  ),
        .s_rvalid  (s_rvalid  ),
        .s_rready  (s_rready  ),
        .s_rid     (s_rid     ),
        .s_rdata   (s_rdata   ),
        .s_rresp   (s_rresp   ),
        .s_rlast   (s_rlast   ),
        .m_aw_vld  (bundle_aw_vld   ),
        .m_aw_rdy  (bundle_aw_rdy   ),
        .m_aw_pld  (bundle_aw_pld   ),
        .m_w_vld   (bundle_w_vld    ),
        .m_w_rdy   (bundle_w_rdy    ),
        .m_w_pld   (bundle_w_pld    ),
        .m_b_vld   (bundle_b_vld    ),
        .m_b_rdy   (bundle_b_rdy    ),
        .m_b_pld   (bundle_b_pld    ),
        .m_ar_vld  (bundle_ar_vld   ),
        .m_ar_rdy  (bundle_ar_rdy   ),
        .m_ar_pld  (bundle_ar_pld   ),
        .m_r_vld   (bundle_r_vld    ),
        .m_r_rdy   (bundle_r_rdy    ),
        .m_r_pld   (bundle_r_pld    )
    );

    sts_iniu_axi_iniu #(
        .NODE_NUM              (NODE_NUM),
        .ADDR_MAP_ENTRY_NUM    (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_BASE_TABLE   (ADDR_MAP_BASE_TABLE),
        .ADDR_MAP_MASK_TABLE   (ADDR_MAP_MASK_TABLE),
        .ADDR_MAP_TGT_ID_TABLE (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_LINEAR_EN         (ADDR_MAP_LINEAR_EN),
        .ADDR_MAP_LINEAR_BASE       (ADDR_MAP_LINEAR_BASE),
        .ADDR_MAP_LINEAR_NUM        (ADDR_MAP_LINEAR_NUM),
        .ADDR_MAP_LINEAR_STRIDE_LOG2(ADDR_MAP_LINEAR_STRIDE_LOG2),
        .ADDR_MAP_LINEAR_TGT_BASE   (ADDR_MAP_LINEAR_TGT_BASE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID)
    ) u_sts_axi_iniu_sys_side (
        .clk             (clk_src         ),
        .rst_n           (rstn_src        ),
        .node_id         (node_id         ),
        // .flow_ctrl_busy  (flow_ctrl_busy  ),
        // .flow_ctrl_update(flow_ctrl_update),
        .upstrm_aw_vld   (bundle_aw_vld   ),
        .upstrm_aw_rdy   (bundle_aw_rdy   ),
        .upstrm_aw_pld   (bundle_aw_pld   ),
        .upstrm_w_vld    (bundle_w_vld    ),
        .upstrm_w_rdy    (bundle_w_rdy    ),
        .upstrm_w_pld    (bundle_w_pld    ),
        .upstrm_b_vld    (bundle_b_vld    ),
        .upstrm_b_rdy    (bundle_b_rdy    ),
        .upstrm_b_pld    (bundle_b_pld    ),
        .upstrm_ar_vld   (bundle_ar_vld   ),
        .upstrm_ar_rdy   (bundle_ar_rdy   ),
        .upstrm_ar_pld   (bundle_ar_pld   ),
        .upstrm_r_vld    (bundle_r_vld    ),
        .upstrm_r_rdy    (bundle_r_rdy    ),
        .upstrm_r_pld    (bundle_r_pld    ),
        .out_req_vld     (req_vld_temp    ),
        .out_req_rdy     (req_rdy_temp    ),
        .out_req_pld     (req_pld_temp    ),
        .in_rsp_vld      (rsp_vld_temp    ),
        .in_rsp_rdy      (rsp_rdy_temp    ),
        .in_rsp_pld      (rsp_pld_temp    )
    );

    // Connect struct payloads to the AFIFO sideband explicitly through their last fields.
    assign req_last_temp = req_pld_temp.req.last;
    assign req_pld_afifo = req_pld_temp;

    assign rsp_pld_temp  = rsp_pld_afifo;
    assign rsp_last_temp = rsp_last_afifo;


    fcip_req_rsp_afifo_slv #(
        .REQ_WIDTH      (REQ_PLD_AFIFO_WIDTH),
        .RSP_WIDTH      (RSP_PLD_AFIFO_WIDTH),
        .FIFO_DEPTH     (FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_sts_iniu_afifo_src (
        .clk            (clk_src),
        .rst_n          (rstn_src),
        .req_s_vld      (req_vld_temp),
        .req_s_rdy      (req_rdy_temp),
        .req_s_pld      (req_pld_afifo),
        .req_s_last     (req_last_temp),
        .rsp_m_vld      (rsp_vld_temp),
        .rsp_m_rdy      (rsp_rdy_temp),
        .rsp_m_pld      (rsp_pld_afifo),
        .rsp_m_last     (rsp_last_afifo),
        .req_wptr_async (req_wptr_async),
        .req_rptr_async (req_rptr_async),
        .req_rptr_sync  (req_rptr_sync),
        .req_pld_sync   (req_pld_sync),
        .rsp_wptr_async (rsp_wptr_async),
        .rsp_rptr_async (rsp_rptr_async),
        .rsp_rptr_sync  (rsp_rptr_sync),
        .rsp_pld_sync   (rsp_pld_sync)
    );

    fcip_marker #(
        .DATA_WIDTH(DBG_DATA_WIDTH)
    ) u_debug_data_marker (
        .I(dbg_data_in ),
        .Z(dbg_data_out)
    );

    // assign dbg_data_out = dbg_data_in;

    fcip_marker #(
        .DATA_WIDTH(DBG_TIMESTAMP_WIDTH)
    ) u_timestamp_marker (
        .I(dbg_timestamp_in ),
        .Z(dbg_timestamp_out)
    );

    cti_handle #(
        .SYNC_STAGE(SYNC_STAGE)
    ) u_cti_handle_iniu_sys (
        .clk_src            (clk_src            ),
        .clk_dst            (clk_dst            ),
        .rstn_src           (rstn_src           ),
        .rstn_dst           (rstn_dst           ),
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

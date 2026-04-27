module `_PREFIX_(sts_iniu_top)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned FIFO_DEPTH          = 4,
    parameter integer unsigned NODE_NUM            = 2,
    // --- Address-to-tgtid mapping (see sts_iniu_addr_map for constraints) ---
    // Each INIU instance should override these with its own address plan.
    // BASE/MASK/TGT_ID are flattened vectors, LSB = entry 0.
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
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH
) (
    input logic clk_src ,
    input logic clk_dst ,
    input logic rstn_src,
    input logic rstn_dst,

    input   logic [SRC_ID_WIDTH-1:0]          node_id,

    //============================================================
    // interface with initial axi 
    //============================================================
    input   logic                             sts_iniu_s_awvalid,
    output  logic                             sts_iniu_s_awready,
    input   logic [AXI_AWID_WIDTH-1:0]        sts_iniu_s_awid,
    input   logic [AXI_ADDR_WIDTH-1:0]        sts_iniu_s_awaddr,
    input   logic [AXI_AWLEN_WIDTH-1:0]       sts_iniu_s_awlen,
    input   logic [2:0]                       sts_iniu_s_awsize,
    input   logic [1:0]                       sts_iniu_s_awburst,
    input   logic                             sts_iniu_s_awlock,
    input   logic [3:0]                       sts_iniu_s_awcache,
    input   logic [2:0]                       sts_iniu_s_awprot,
    input   logic [3:0]                       sts_iniu_s_awqos,
    input   logic [AXI_USER_WIDTH-1:0]      sts_iniu_s_awuser,

    input   logic                             sts_iniu_s_wvalid,
    output  logic                             sts_iniu_s_wready,
    input   logic [AXI_DATA_WIDTH-1:0]        sts_iniu_s_wdata,
    input   logic [AXI_STRB_WIDTH-1:0]        sts_iniu_s_wstrb,
    input   logic                             sts_iniu_s_wlast,

    output  logic                             sts_iniu_s_bvalid,
    input   logic                             sts_iniu_s_bready,
    output  logic [AXI_BID_WIDTH-1:0]         sts_iniu_s_bid,
    output  logic [1:0]                       sts_iniu_s_bresp,

    input   logic                             sts_iniu_s_arvalid,
    output  logic                             sts_iniu_s_arready,
    input   logic [AXI_ARID_WIDTH-1:0]        sts_iniu_s_arid,
    input   logic [AXI_ADDR_WIDTH-1:0]        sts_iniu_s_araddr,
    input   logic [AXI_ARLEN_WIDTH-1:0]       sts_iniu_s_arlen,
    input   logic [2:0]                       sts_iniu_s_arsize,
    input   logic [1:0]                       sts_iniu_s_arburst,
    input   logic                             sts_iniu_s_arlock,
    input   logic [3:0]                       sts_iniu_s_arcache,
    input   logic [2:0]                       sts_iniu_s_arprot,
    input   logic [3:0]                       sts_iniu_s_arqos,
    input   logic [AXI_USER_WIDTH-1:0]      sts_iniu_s_aruser,

    output  logic                             sts_iniu_s_rvalid,
    input   logic                             sts_iniu_s_rready,
    output  logic [AXI_RID_WIDTH-1:0]         sts_iniu_s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]        sts_iniu_s_rdata,
    output  logic [1:0]                       sts_iniu_s_rresp,
    output  logic                             sts_iniu_s_rlast,
    
    //============================================================
    // interface with noc dec/tniu
    //============================================================
    output  logic               out_req_vld,
    input   logic               out_req_rdy,
    output [REQ_PLD_WIDTH-1:0] out_req_pld,

    input   logic               in_rsp_vld,
    output  logic               in_rsp_rdy,
    input  [RSP_PLD_WIDTH-1:0]  in_rsp_pld,

    // CTI
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_out,
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_event_in,
    
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_channel_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_channel_out,
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_channel_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_channel_in,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out,

    input   logic [DBG_DATA_WIDTH-1:0]      dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out
);

logic [FIFO_DEPTH-1:0]          tmp_req_wptr_async;
logic [FIFO_DEPTH-1:0]          tmp_req_rptr_async;
logic [FIFO_DEPTH-1:0]          tmp_req_rptr_sync ;
logic [REQ_PLD_WIDTH+1:0]         tmp_req_pld_sync  ;

logic [FIFO_DEPTH-1:0]          tmp_rsp_wptr_async;
logic [FIFO_DEPTH-1:0]          tmp_rsp_rptr_async;
logic [FIFO_DEPTH-1:0]          tmp_rsp_rptr_sync ;
logic [RSP_PLD_WIDTH+1:0]         tmp_rsp_pld_sync  ;

logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;
logic [DBG_DATA_WIDTH-1:0]      dbg_data_tmp;

logic [CTI_EVENT_WIDTH-1:0]     tmp_event_in_req;
logic [CTI_EVENT_WIDTH-1:0]     tmp_event_in_ack;
logic [CTI_EVENT_WIDTH-1:0]     tmp_event_out_req;
logic [CTI_EVENT_WIDTH-1:0]     tmp_event_out_ack;
logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_in_req;
logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_in_ack;
logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_out_req;
logic [CTI_CHANNEL_WIDTH-1:0]   tmp_channel_out_ack;

`_PREFIX_(sts_iniu_sys) #(
    .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM),
    .ADDR_MAP_BASE_TABLE    (ADDR_MAP_BASE_TABLE),
    .ADDR_MAP_MASK_TABLE    (ADDR_MAP_MASK_TABLE),
    .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE),
    .ADDR_MAP_LINEAR_BASE       (ADDR_MAP_LINEAR_BASE),
    .ADDR_MAP_LINEAR_STRIDE_LOG2(ADDR_MAP_LINEAR_STRIDE_LOG2),
    .ADDR_MAP_LINEAR_TGT_BASE   (ADDR_MAP_LINEAR_TGT_BASE),
    .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID)
) u_sts_iniu_sys (
    .clk_src(clk_src),
    .clk_dst(clk_dst),
    // .clk_dbg_timer(clk_dbg_timer),
    .rstn_src(rstn_src),
    .rstn_dst(rstn_dst),
    // .rstn_dbg_timer(rstn_dbg_timer),

    .node_id(node_id),
    // .flow_ctrl_busy(flow_ctrl_busy),
    // .flow_ctrl_update(flow_ctrl_update),

    .s_awvalid(sts_iniu_s_awvalid),
    .s_awready(sts_iniu_s_awready),
    .s_awid(sts_iniu_s_awid),
    .s_awaddr(sts_iniu_s_awaddr),
    .s_awlen(sts_iniu_s_awlen),
    .s_awsize(sts_iniu_s_awsize),
    .s_awburst(sts_iniu_s_awburst),
    .s_awlock(sts_iniu_s_awlock),
    .s_awcache(sts_iniu_s_awcache),
    .s_awprot(sts_iniu_s_awprot),
    .s_awqos(sts_iniu_s_awqos),
    .s_awuser(sts_iniu_s_awuser),

    .s_wvalid(sts_iniu_s_wvalid),
    .s_wready(sts_iniu_s_wready),
    .s_wdata(sts_iniu_s_wdata),
    .s_wstrb(sts_iniu_s_wstrb),
    .s_wlast(sts_iniu_s_wlast),

    .s_bvalid(sts_iniu_s_bvalid),
    .s_bready(sts_iniu_s_bready),
    .s_bid(sts_iniu_s_bid),
    .s_bresp(sts_iniu_s_bresp),

    .s_arvalid(sts_iniu_s_arvalid),
    .s_arready(sts_iniu_s_arready),
    .s_arid(sts_iniu_s_arid),
    .s_araddr(sts_iniu_s_araddr),
    .s_arlen(sts_iniu_s_arlen),
    .s_arsize(sts_iniu_s_arsize),
    .s_arburst(sts_iniu_s_arburst),
    .s_arlock(sts_iniu_s_arlock),
    .s_arcache(sts_iniu_s_arcache),
    .s_arprot(sts_iniu_s_arprot),
    .s_arqos(sts_iniu_s_arqos),
    .s_aruser(sts_iniu_s_aruser),

    .s_rvalid(sts_iniu_s_rvalid),
    .s_rready(sts_iniu_s_rready),
    .s_rid(sts_iniu_s_rid),
    .s_rdata(sts_iniu_s_rdata),
    .s_rresp(sts_iniu_s_rresp),
    .s_rlast(sts_iniu_s_rlast),
    .req_wptr_async     (tmp_req_wptr_async),
    .req_rptr_async     (tmp_req_rptr_async),
    .req_rptr_sync      (tmp_req_rptr_sync ),
    .req_pld_sync       (tmp_req_pld_sync  ),
    .rsp_wptr_async     (tmp_rsp_wptr_async),
    .rsp_rptr_async     (tmp_rsp_rptr_async),
    .rsp_rptr_sync      (tmp_rsp_rptr_sync ),
    .rsp_pld_sync       (tmp_rsp_pld_sync  ),

    .cti_event_in       (sys_cti_event_in   ),
    .cti_event_in_req   (tmp_event_in_req   ),
    .cti_event_in_ack   (tmp_event_in_ack   ),
    .cti_event_out      (sys_cti_event_out  ),
    .cti_event_out_req  (tmp_event_out_req  ),
    .cti_event_out_ack  (tmp_event_out_ack  ),
    .cti_channel_in     (sys_cti_channel_in ),
    .cti_channel_in_req (tmp_channel_in_req ),
    .cti_channel_in_ack (tmp_channel_in_ack ),
    .cti_channel_out    (sys_cti_channel_out),
    .cti_channel_out_req(tmp_channel_out_req),
    .cti_channel_out_ack(tmp_channel_out_ack),

    .dbg_timestamp_in   (dbg_timestamp_in),
    .dbg_timestamp_out  (dbg_timestamp_tmp),
    .dbg_data_in        (dbg_data_tmp),
    .dbg_data_out       (dbg_data_out)
);

// Boundary cast: top-level vector ↔ internal struct
    sts_req_typ  out_req_pld_s;
    sts_rsp_typ  in_rsp_pld_s;
    assign out_req_pld_s = sts_req_typ'(out_req_pld);
    assign in_rsp_pld = in_rsp_pld_s;

`_PREFIX_(sts_iniu_noc) u_sts_iniu_noc (
    .clk_dst        (clk_dst),
    .rst_n_dst      (rstn_dst),
    .clk_src        (clk_src),
    .rst_n_src      (rstn_src),

    .req_wptr_async (tmp_req_wptr_async),
    .req_rptr_async (tmp_req_rptr_async),
    .req_rptr_sync  (tmp_req_rptr_sync ),
    .req_pld_sync   (tmp_req_pld_sync  ),
    .rsp_wptr_async (tmp_rsp_wptr_async),
    .rsp_rptr_async (tmp_rsp_rptr_async),
    .rsp_rptr_sync  (tmp_rsp_rptr_sync ),
    .rsp_pld_sync   (tmp_rsp_pld_sync  ),

    .req_s_vld      (out_req_vld      ),
    .req_s_rdy      (out_req_rdy      ),
    .req_s_pld      (out_req_pld_s),

    .rsp_m_vld      (in_rsp_vld       ),
    .rsp_m_rdy      (in_rsp_rdy       ),
    .rsp_m_pld      (in_rsp_pld_s),

    .cti_event_in       (noc_cti_event_in   ),
    .cti_event_in_req   (tmp_event_out_req  ),
    .cti_event_in_ack   (tmp_event_out_ack  ),
    .cti_event_out      (noc_cti_event_out  ),
    .cti_event_out_req  (tmp_event_in_req   ),
    .cti_event_out_ack  (tmp_event_in_ack   ),
    .cti_channel_in     (noc_cti_channel_in ),
    .cti_channel_in_req (tmp_channel_out_req ),
    .cti_channel_in_ack (tmp_channel_out_ack ),
    .cti_channel_out    (noc_cti_channel_out),
    .cti_channel_out_req(tmp_channel_in_req),
    .cti_channel_out_ack(tmp_channel_in_ack),

    .dbg_data_in        (dbg_data_in),
    .dbg_data_out       (dbg_data_tmp),
    .dbg_timestamp_in   (dbg_timestamp_tmp),
    .dbg_timestamp_out  (dbg_timestamp_out) 
);

// assign out_req_pld      = {out_req_pld_tmp,out_req_last_tmp};
// assign in_rsp_pld_tmp   = in_rsp_pld[RSP_PLD_WIDTH-1:1];
// assign in_rsp_last_tmp  = in_rsp_pld[0];


endmodule
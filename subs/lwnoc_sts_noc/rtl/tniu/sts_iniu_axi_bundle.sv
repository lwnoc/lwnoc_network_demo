module `_PREFIX_(sts_iniu_axi_bundle) 
import `_PREFIX_(lwnoc_sts_pack)::*;
(
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
    input   logic [AXI_USER_WIDTH-1:0]      s_aruser,

    output  logic                             s_rvalid,
    input   logic                             s_rready,
    output  logic [AXI_RID_WIDTH-1:0]         s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]        s_rdata,
    output  logic [1:0]                       s_rresp,
    output  logic                             s_rlast,

    output  logic                           m_aw_vld,
    input   logic                           m_aw_rdy,
    output  sts_iniu_axi_aw_chnl            m_aw_pld,

    output  logic                           m_w_vld ,
    input   logic                           m_w_rdy ,
    output  sts_iniu_axi_w_chnl             m_w_pld ,

    input   logic                           m_b_vld , 
    output  logic                           m_b_rdy , 
    input   sts_iniu_axi_b_chnl             m_b_pld , 

    output  logic                           m_ar_vld, 
    input   logic                           m_ar_rdy, 
    output  sts_iniu_axi_ar_chnl            m_ar_pld, 
    
    input   logic                           m_r_vld , 
    output  logic                           m_r_rdy , 
    input   sts_iniu_axi_r_chnl             m_r_pld 
);

assign m_aw_vld         = s_awvalid ;
assign s_awready        = m_aw_rdy  ;
assign m_aw_pld.awid    = s_awid    ;
assign m_aw_pld.awaddr  = s_awaddr  ;
assign m_aw_pld.awlen   = s_awlen   ;
assign m_aw_pld.awsize  = s_awsize  ;
assign m_aw_pld.awlock  = s_awlock  ;
assign m_aw_pld.awburst = s_awburst ;
assign m_aw_pld.awcache = s_awcache ;
assign m_aw_pld.awport  = s_awport  ;
assign m_aw_pld.awqos   = s_awqos   ;
assign m_aw_pld.awuser  = s_awuser  ;

assign m_w_vld          = s_wvalid;
assign s_wready         = m_w_rdy;
assign m_w_pld.wdata    = s_wdata;
assign m_w_pld.wstrb    = s_wstrb;
assign m_w_pld.wlast    = s_wlast;

assign s_bvalid    = m_b_vld;
assign m_b_rdy     = s_bready;
assign s_bid       = m_b_pld.bid;
assign s_bresp     = m_b_pld.bresp;

assign m_ar_vld         = s_arvalid ;
assign s_arready        = m_ar_rdy  ;
assign m_ar_pld.arid    = s_arid    ;
assign m_ar_pld.araddr  = s_araddr  ;
assign m_ar_pld.arlen   = s_arlen   ;
assign m_ar_pld.arsize  = s_arsize  ;
assign m_ar_pld.arlock  = s_arlock  ;
assign m_ar_pld.arburst = s_arburst ;
assign m_ar_pld.arcache = s_arcache ;
assign m_ar_pld.arport  = s_arport  ;
assign m_ar_pld.arqos   = s_arqos   ;
assign m_ar_pld.aruser  = s_aruser  ;

assign m_r_vld          = s_rvalid;
assign s_rready         = m_r_rdy;
assign m_r_pld.rid      = s_rid;
assign m_r_pld.rlast    = s_rlast;
assign m_r_pld.rresp    = s_rresp;
assign m_r_pld.rlast    = s_rlast;

endmodule
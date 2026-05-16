module sts_noc_aon_ss_iniu_sts_iniu_sys
import sts_noc_aon_ss_iniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `sts_noc_aon_ss_iniu_STS_INIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `sts_noc_aon_ss_iniu_STS_INIU_DBG_DATA_WIDTH,
    parameter integer unsigned FIFO_DEPTH          = `sts_noc_aon_ss_iniu_STS_INIU_FIFO_DEPTH,
    parameter integer unsigned SYNC_STAGE          = `sts_noc_aon_ss_iniu_STS_INIU_SYNC_STAGE,
    parameter integer unsigned NODE_NUM            = `sts_noc_aon_ss_iniu_STS_INIU_NODE_NUM,
    parameter integer unsigned SAFETY_TIMEOUT_CYCLES = `sts_noc_aon_ss_iniu_STS_INIU_SAFETY_TIMEOUT_CYCLES,
    parameter integer unsigned ADDR_MAP_ENTRY_NUM  = `sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_ENTRY_NUM,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_START_TABLE = `sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_START_TABLE,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_END_TABLE   = `sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_END_TABLE,
    parameter logic [ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = `sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_TGT_ID_TABLE,
    parameter logic [TGT_ID_WIDTH-1:0]                      ADDR_MAP_DEFAULT_TGT_ID = `sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_DEFAULT_TGT_ID,
    parameter integer unsigned ADDR_MASK_BITS  = 0,
    // ECC: REQ_WIDTH=119 → CODE_WIDTH=7+1=8 overhead → 127, RSP_WIDTH=65 → 73
    localparam int REQ_PLD_AFIFO_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_AFIFO_WIDTH = STS_RSP_WIDTH,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = `sts_noc_aon_ss_iniu_STS_INIU_ERR_INT_CNT_WIDTH,
    localparam int REQ_ECC_OH = ($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH))? $clog2(STS_REQ_WIDTH) : $clog2(STS_REQ_WIDTH)+1,
    localparam int RSP_ECC_OH = ($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH))? $clog2(STS_RSP_WIDTH) : $clog2(STS_RSP_WIDTH)+1,
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_OH,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_OH
) (
    input logic clk_src ,
    // input logic clk_dbg_timer,

    input logic rstn_src,
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
    output  logic [REQ_AFIFO_W+1:0]           req_pld_sync    ,
    // response sync
    input   logic [FIFO_DEPTH-1:0]          rsp_wptr_async  ,
    output  logic [FIFO_DEPTH-1:0]          rsp_rptr_async  ,
    output  logic [FIFO_DEPTH-1:0]          rsp_rptr_sync   ,
    input   logic [RSP_AFIFO_W+1:0]           rsp_pld_sync    ,

    // CTI — level pass-through (sys clock domain)
    //   Each signal: input → wire → output
    //   sys_* ports connect to sys-side top; noc_* ports connect to noc side via CDC
    //   Forward lane (sys→noc):  sys_cti_trigin / sys_cti_trigin_ack (sys), noc_cti_trigin / noc_cti_trigin_ack (noc)
    //   Reverse lane (noc→sys):  noc_cti_trigout / noc_cti_trigout_ack (noc), sys_cti_trigout / sys_cti_trigout_ack (sys)
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_trigin,       // from sys top
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_trigin_ack,   // to sys top
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_trigin,       // to noc side (via CDC)
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_trigin_ack,   // from noc side (via CDC)
    input   logic [CTI_EVENT_WIDTH-1:0]     noc_cti_trigout,      // from noc side (via CDC)
    output  logic [CTI_EVENT_WIDTH-1:0]     noc_cti_trigout_ack,  // to noc side (via CDC)
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_trigout,      // to sys top
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_trigout_ack,  // from sys top

    // CTM — level pass-through (sys clock domain, CTM direct)
    //   Each signal: input → wire → output
    //   Forward lane (sys→noc):  sys_ctm_trigin / sys_ctm_trigin_ack (sys), noc_ctm_trigin / noc_ctm_trigin_ack (noc)
    //   Reverse lane (noc→sys):  noc_ctm_trigout / noc_ctm_trigout_ack (noc), sys_ctm_trigout / sys_ctm_trigout_ack (sys)
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigin,       // from sys top (CTM direct)
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigin_ack,   // to sys top
    output  logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigin,       // to noc side (via CDC)
    input   logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigin_ack,   // from noc side (via CDC)
    input   logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigout,      // from noc side (via CDC)
    output  logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigout_ack,  // to noc side (via CDC)
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigout,      // to sys top
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigout_ack,  // from sys top

    input   logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out,

    input   logic [RESERVE_WIDTH-1:0]       reserved_bits_in,
    output  logic [RESERVE_WIDTH-1:0]       reserved_bits_out,

    input   logic [DBG_DATA_WIDTH-1:0]      dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out,

    // Raw safety error outputs. sts_iniu_top repacks these into safety_err[7:0].
    //   [7] = arb_lockstep_err,   [6] = addr_map_wr_err,
    //   [5] = addr_map_rd_err,    [4] = afifo_rsp_ecc_err,
    //   [3] = afifo_req_ecc_err,  [2] = ar_timeout_err,
    //   [1] = w_timeout_err,      [0] = aw_timeout_err
    output  logic                           safety_arb_lockstep_err,
    output  logic                           safety_addr_map_wr_err,
    output  logic                           safety_addr_map_rd_err,
    output  logic                           safety_afifo_rsp_ecc_err,
    output  logic                           safety_afifo_req_ecc_err,
    output  logic                           safety_ar_timeout_err,
    output  logic                           safety_w_timeout_err,
    output  logic                           safety_aw_timeout_err,
    // FUSA AFIFO ECC error outputs
    output  logic                           safety_afifo_rsp_sb_err,
    output  logic                           safety_afifo_rsp_db_err
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
    logic                           safety_req_timeout_err;
    logic                           safety_rsp_timeout_err;
    logic [REQ_AFIFO_W-1:0]         req_pld_ecc;
    logic [RSP_AFIFO_W-1:0]         rsp_pld_ecc;
    logic                           req_sb_err_raw;
    logic                           req_db_err_raw;
    logic                           rsp_sb_err_raw;
    logic                           rsp_db_err_raw;

    sts_noc_aon_ss_iniu_sts_iniu_axi_bundle u_axi_bundle (
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

    sts_noc_aon_ss_iniu_sts_iniu_axi_iniu #(
        .NODE_NUM              (NODE_NUM),
        .SAFETY_TIMEOUT_CYCLES (SAFETY_TIMEOUT_CYCLES),
        .ADDR_MAP_ENTRY_NUM    (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_START_TABLE (ADDR_MAP_START_TABLE),
        .ADDR_MAP_END_TABLE   (ADDR_MAP_END_TABLE  ),
        .ADDR_MAP_TGT_ID_TABLE (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID),
        .ADDR_MASK_BITS       (ADDR_MASK_BITS)
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
        .in_rsp_pld      (rsp_pld_temp    ),
        .safety_req_timeout_err(safety_req_timeout_err),
        .safety_rsp_timeout_err(safety_rsp_timeout_err),
        .safety_aw_timeout_err(safety_aw_timeout_err),
        .safety_w_timeout_err(safety_w_timeout_err),
        .safety_ar_timeout_err(safety_ar_timeout_err),
        .safety_arb_lockstep_err(safety_arb_lockstep_err),
        .addr_map_wr_err(safety_addr_map_wr_err),
        .addr_map_rd_err(safety_addr_map_rd_err)
    );

    // Connect struct payloads to the AFIFO sideband explicitly through their last fields.
    assign req_last_temp = req_pld_temp.req.last;
    assign req_pld_afifo = req_pld_temp;

    assign rsp_pld_temp  = rsp_pld_afifo;
    assign rsp_last_temp = rsp_last_afifo;


    // REQ: ECC encode before AFIFO write (clk_src domain)
    fcip_ecc_enc #(.DATA_WIDTH(STS_REQ_WIDTH)) u_req_ecc_enc (
        .data       (req_pld_afifo ),
        .encode_data(req_pld_ecc   )
    );
    // RSP: ECC decode after AFIFO read (clk_src domain)
    fcip_ecc_dec #(.DATA_WIDTH(STS_RSP_WIDTH)) u_rsp_ecc_dec (
        .encode_data(rsp_pld_ecc),
        .data       (rsp_pld_afifo),
        .sb_err     (rsp_sb_err_raw),
        .db_err     (rsp_db_err_raw)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_rsp_pulse_sb (
        .clk(clk_src), .rst_n(rstn_src), .err_in(rsp_sb_err_raw), .intr_out(safety_afifo_rsp_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_rsp_pulse_db (
        .clk(clk_src), .rst_n(rstn_src), .err_in(rsp_db_err_raw), .intr_out(safety_afifo_rsp_db_err)
    );
    assign safety_afifo_req_ecc_err = 1'b0; // REQ ECC decoded in sts_iniu_noc (req_afifo_sb/db_err at top wrapper)
    assign safety_afifo_rsp_ecc_err = safety_afifo_rsp_sb_err | safety_afifo_rsp_db_err;

    fcip_req_rsp_afifo_slv #(
        .REQ_WIDTH      (REQ_AFIFO_W),
        .RSP_WIDTH      (RSP_AFIFO_W),
        .FIFO_DEPTH     (FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_sts_iniu_afifo_src (
        .clk            (clk_src),
        .rst_n          (rstn_src),
        .req_s_vld      (req_vld_temp),
        .req_s_rdy      (req_rdy_temp),
        .req_s_pld      (req_pld_ecc),
        .req_s_last     (req_last_temp),
        .rsp_m_vld      (rsp_vld_temp),
        .rsp_m_rdy      (rsp_rdy_temp),
        .rsp_m_pld      (rsp_pld_ecc),
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

    fcip_marker #(
        .DATA_WIDTH(RESERVE_WIDTH)
    ) u_reserved_marker (
        .I(reserved_bits_in ),
        .Z(reserved_bits_out)
    );

    // CTI level pass-through (wire pairs, no CDC in sys side)
    assign noc_cti_trigin      = sys_cti_trigin;
    assign sys_cti_trigin_ack  = noc_cti_trigin_ack;
    assign sys_cti_trigout     = noc_cti_trigout;
    assign noc_cti_trigout_ack = sys_cti_trigout_ack;

    // CTM level pass-through (wire pairs, no CDC in sys side)
    assign noc_ctm_trigin      = sys_ctm_trigin;
    assign sys_ctm_trigin_ack  = noc_ctm_trigin_ack;
    assign sys_ctm_trigout     = noc_ctm_trigout;
    assign noc_ctm_trigout_ack = sys_ctm_trigout_ack;

    assign safety_block_req = safety_arb_lockstep_err
                            | safety_addr_map_wr_err
                            | safety_addr_map_rd_err
                            | safety_afifo_rsp_ecc_err
                            | safety_afifo_req_ecc_err
                            | safety_ar_timeout_err
                            | safety_w_timeout_err
                            | safety_aw_timeout_err;


endmodule

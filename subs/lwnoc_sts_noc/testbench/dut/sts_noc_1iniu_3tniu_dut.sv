module `_PREFIX_(sts_noc_1iniu_3tniu_dut)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned APB_ADDR_WIDTH      = 32,
    parameter integer unsigned NODE_NUM            = 2
)(
    input   logic                       clk_src,
    input   logic                       clk_dst,
    input   logic                       clk_dbg_timer,
    input   logic                       rstn_src,
    input   logic                       rstn_dst,
    input   logic                       rstn_dbg_timer,

    input   logic [SRC_ID_WIDTH-1:0]    node_id,

    input   logic                       s_awvalid,
    output  logic                       s_awready,
    input   logic [AXI_AWID_WIDTH-1:0]  s_awid,
    input   logic [AXI_ADDR_WIDTH-1:0]  s_awaddr,
    input   logic [AXI_AWLEN_WIDTH-1:0] s_awlen,
    input   logic [2:0]                 s_awsize,
    input   logic [1:0]                 s_awburst,
    input   logic                       s_awlock,
    input   logic [3:0]                 s_awcache,
    input   logic [2:0]                 s_awprot,
    input   logic [3:0]                 s_awqos,
    input   logic [AXI_USER_WIDTH-1:0]  s_awuser,
    input   logic                       s_wvalid,
    output  logic                       s_wready,
    input   logic [AXI_DATA_WIDTH-1:0]  s_wdata,
    input   logic [AXI_STRB_WIDTH-1:0]  s_wstrb,
    input   logic                       s_wlast,
    output  logic                       s_bvalid,
    input   logic                       s_bready,
    output  logic [AXI_BID_WIDTH-1:0]   s_bid,
    output  logic [1:0]                 s_bresp,
    input   logic                       s_arvalid,
    output  logic                       s_arready,
    input   logic [AXI_ARID_WIDTH-1:0]  s_arid,
    input   logic [AXI_ADDR_WIDTH-1:0]  s_araddr,
    input   logic [AXI_ARLEN_WIDTH-1:0] s_arlen,
    input   logic [2:0]                 s_arsize,
    input   logic [1:0]                 s_arburst,
    input   logic                       s_arlock,
    input   logic [3:0]                 s_arcache,
    input   logic [2:0]                 s_arprot,
    input   logic [3:0]                 s_arqos,
    input   logic [AXI_USER_WIDTH-1:0]  s_aruser,
    output  logic                       s_rvalid,
    input   logic                       s_rready,
    output  logic [AXI_RID_WIDTH-1:0]   s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]  s_rdata,
    output  logic [1:0]                 s_rresp,
    output  logic                       s_rlast,

    input   logic [CTI_EVENT_WIDTH-1:0] sys_cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0] sys_cti_event_out,
    input   logic [CTI_CHANNEL_WIDTH-1:0] sys_cti_channel_in,
    output  logic [CTI_CHANNEL_WIDTH-1:0] sys_cti_channel_out,
    // CTI APB — INIU side (for sts_cti register access)
    input   logic                           iniu_cti_apb_psel,
    input   logic                           iniu_cti_apb_penable,
    input   logic [11:0]                    iniu_cti_apb_paddr,
    input   logic                           iniu_cti_apb_pwrite,
    input   logic [31:0]                    iniu_cti_apb_pwdata,
    output  logic [31:0]                    iniu_cti_apb_prdata,
    output  logic                           iniu_cti_apb_pready,
    output  logic                           iniu_cti_apb_pslverr,
    input   logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_in,
    input   logic [DBG_DATA_WIDTH-1:0]      dbg_data_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_0,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_1,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_2,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_0,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_1,
    output  logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_2,
    output  logic [2:0][31:0]               timing_bus1,
    output  logic [2:0][31:0]               timing_bus2,
    output  logic [2:0][31:0]               timing_bus3,
    output  logic [2:0][31:0]               dbg_en
);
    logic                iniu_req_vld;
    logic                iniu_req_rdy;
    sts_req_typ          iniu_req_pld;
    logic                iniu_rsp_vld;
    logic                iniu_rsp_rdy;
    sts_rsp_typ          iniu_rsp_pld;

    logic                tniu0_req_vld;
    logic                tniu0_req_rdy;
    sts_req_typ          tniu0_req_pld;
    logic                tniu1_req_vld;
    logic                tniu1_req_rdy;
    sts_req_typ          tniu1_req_pld;
    logic                tniu2_req_vld;
    logic                tniu2_req_rdy;
    sts_req_typ          tniu2_req_pld;

    logic                tniu0_rsp_vld;
    logic                tniu0_rsp_rdy;
    sts_rsp_typ          tniu0_rsp_pld;
    logic                tniu1_rsp_vld;
    logic                tniu1_rsp_rdy;
    sts_rsp_typ          tniu1_rsp_pld;
    logic                tniu2_rsp_vld;
    logic                tniu2_rsp_rdy;
    sts_rsp_typ          tniu2_rsp_pld;

    logic                decerr_rsp_vld;
    logic                decerr_rsp_rdy;
    sts_rsp_typ          decerr_rsp_pld;

    // Unpacked array for dec_node rsp input (descending range to match dec_node port)
    sts_rsp_typ          dec_slv_rsp_pld [2:0];
    sts_req_typ          dec_slv_req_pld;

    logic [CTI_EVENT_WIDTH-1:0]   noc_cti_event_out_0;
    logic [CTI_EVENT_WIDTH-1:0]   noc_cti_event_out_1;
    logic [CTI_EVENT_WIDTH-1:0]   noc_cti_event_out_2;
    logic [CTI_CHANNEL_WIDTH-1:0] noc_cti_channel_out_0;
    logic [CTI_CHANNEL_WIDTH-1:0] noc_cti_channel_out_1;
    logic [CTI_CHANNEL_WIDTH-1:0] noc_cti_channel_out_2;
    logic [CTI_EVENT_WIDTH-1:0]   iniu_noc_cti_event_out;
    logic [CTI_CHANNEL_WIDTH-1:0] iniu_noc_cti_channel_out;

    // dec_node sideband outputs
    logic [CTI_CHANNEL_WIDTH-1:0]   dec_mst_cti_channel_out;
    logic [CTI_EVENT_WIDTH-1:0]     dec_mst_cti_event_out;
    logic [3*CTI_CHANNEL_WIDTH-1:0] dec_slv_cti_channel_out;
    logic [3*CTI_EVENT_WIDTH-1:0]   dec_slv_cti_event_out;
    logic [3*DBG_TIMESTAMP_WIDTH-1:0] dec_slv_dbg_timestamp;
    logic [DBG_DATA_WIDTH-1:0]      dec_mst_dbg_data;

    logic pmc_psel_0;
    logic pmc_penable_0;
    logic [APB_ADDR_WIDTH-1:0] pmc_paddr_0;
    logic pmc_pwrite_0;
    logic [31:0] pmc_pwdata_0;
    logic [31:0] pmc_prdata_0;
    logic pmc_pready_0;
    logic [3:0] pmc_pstrb_0;
    logic [2:0] pmc_pprot_0;
    logic pmc_pslverr_0;
    // TNIU0 sys APB — packed arrays + individual stub signals
    logic [1:0]              tniu0_sys_psel;
    logic [APB_ADDR_WIDTH-1:0] tniu0_sys_paddr;
    logic [1:0]              tniu0_sys_pready;
    logic [63:0]             tniu0_sys_prdata;
    logic [1:0]              tniu0_sys_pslverr;
    logic [2:0]              tniu0_sys_pprot;
    logic                    tniu0_sys_penable;
    logic                    tniu0_sys_pwrite;
    logic [31:0]             tniu0_sys_pwdata;
    logic [3:0]              tniu0_sys_pstrb;
    logic                    pready_00;
    logic [31:0]             prdata_00;
    logic                    pslverr_00;
    logic                    pready_01;
    logic [31:0]             prdata_01;
    logic                    pslverr_01;
    assign tniu0_sys_pready  = {pready_01,  pready_00};
    assign tniu0_sys_prdata  = {prdata_01,  prdata_00};
    assign tniu0_sys_pslverr = {pslverr_01, pslverr_00};

    logic pmc_psel_1;
    logic pmc_penable_1;
    logic [APB_ADDR_WIDTH-1:0] pmc_paddr_1;
    logic pmc_pwrite_1;
    logic [31:0] pmc_pwdata_1;
    logic [31:0] pmc_prdata_1;
    logic pmc_pready_1;
    logic [3:0] pmc_pstrb_1;
    logic [2:0] pmc_pprot_1;
    logic pmc_pslverr_1;
    // TNIU1 sys APB — packed arrays + individual stub signals
    logic [1:0]              tniu1_sys_psel;
    logic [APB_ADDR_WIDTH-1:0] tniu1_sys_paddr;
    logic [1:0]              tniu1_sys_pready;
    logic [63:0]             tniu1_sys_prdata;
    logic [1:0]              tniu1_sys_pslverr;
    logic [2:0]              tniu1_sys_pprot;
    logic                    tniu1_sys_penable;
    logic                    tniu1_sys_pwrite;
    logic [31:0]             tniu1_sys_pwdata;
    logic [3:0]              tniu1_sys_pstrb;
    logic                    pready_10;
    logic [31:0]             prdata_10;
    logic                    pslverr_10;
    logic                    pready_11;
    logic [31:0]             prdata_11;
    logic                    pslverr_11;
    assign tniu1_sys_pready  = {pready_11,  pready_10};
    assign tniu1_sys_prdata  = {prdata_11,  prdata_10};
    assign tniu1_sys_pslverr = {pslverr_11, pslverr_10};

    logic pmc_psel_2;
    logic pmc_penable_2;
    logic [APB_ADDR_WIDTH-1:0] pmc_paddr_2;
    logic pmc_pwrite_2;
    logic [31:0] pmc_pwdata_2;
    logic [31:0] pmc_prdata_2;
    logic pmc_pready_2;
    logic [3:0] pmc_pstrb_2;
    logic [2:0] pmc_pprot_2;
    logic pmc_pslverr_2;
    // TNIU2 sys APB — packed arrays + individual stub signals
    logic [1:0]              tniu2_sys_psel;
    logic [APB_ADDR_WIDTH-1:0] tniu2_sys_paddr;
    logic [1:0]              tniu2_sys_pready;
    logic [63:0]             tniu2_sys_prdata;
    logic [1:0]              tniu2_sys_pslverr;
    logic [2:0]              tniu2_sys_pprot;
    logic                    tniu2_sys_penable;
    logic                    tniu2_sys_pwrite;
    logic [31:0]             tniu2_sys_pwdata;
    logic [3:0]              tniu2_sys_pstrb;
    logic                    pready_20;
    logic [31:0]             prdata_20;
    logic                    pslverr_20;
    logic                    pready_21;
    logic [31:0]             prdata_21;
    logic                    pslverr_21;
    logic [7:0]              iniu_safety_err;
    assign tniu2_sys_pready  = {pready_21,  pready_20};
    assign tniu2_sys_prdata  = {prdata_21,  prdata_20};
    assign tniu2_sys_pslverr = {pslverr_21, pslverr_20};

    `_PREFIX_(sts_iniu_top) #(
        .NODE_NUM                (NODE_NUM),
        .ADDR_MAP_ENTRY_NUM      (15),
        .ADDR_MAP_BASE_TABLE     ({32'h0000_E000, 32'h0000_D000, 32'h0000_C000,
                                   32'h0000_B000, 32'h0000_A000, 32'h0000_9000, 32'h0000_8000,
                                   32'h0000_7000, 32'h0000_6000, 32'h0000_5000, 32'h0000_4000,
                                   32'h0000_3000, 32'h0000_2000, 32'h0000_1000, 32'h0000_0000}),
        .ADDR_MAP_MASK_TABLE     ({32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000,
                                   32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000,
                                   32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000,
                                   32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000}),
        .ADDR_MAP_TGT_ID_TABLE   ({8'h64, 8'h62, 8'h60,
                                   8'h55, 8'h54, 8'h45, 8'h44, 8'h53, 8'h52, 8'h43, 8'h42, 8'h51, 8'h50, 8'h41, 8'h40}),
        .ADDR_MAP_DEFAULT_TGT_ID (8'hFF)
    ) u_iniu (
        .clk_src             (clk_src),
        .clk_dst             (clk_dst),
        .rstn_src            (rstn_src),
        .rstn_dst            (rstn_dst),
        .node_id             (node_id),
        // .flow_ctrl_busy      (flow_ctrl_busy),
        // .flow_ctrl_update    (flow_ctrl_update),
        .sts_iniu_s_awvalid  (s_awvalid),
        .sts_iniu_s_awready  (s_awready),
        .sts_iniu_s_awid     (s_awid),
        .sts_iniu_s_awaddr   (s_awaddr),
        .sts_iniu_s_awlen    (s_awlen),
        .sts_iniu_s_awsize   (s_awsize),
        .sts_iniu_s_awburst  (s_awburst),
        .sts_iniu_s_awlock   (s_awlock),
        .sts_iniu_s_awcache  (s_awcache),
        .sts_iniu_s_awprot   (s_awprot),
        .sts_iniu_s_awqos    (s_awqos),
        .sts_iniu_s_awuser   (s_awuser),
        .sts_iniu_s_wvalid   (s_wvalid),
        .sts_iniu_s_wready   (s_wready),
        .sts_iniu_s_wdata    (s_wdata),
        .sts_iniu_s_wstrb    (s_wstrb),
        .sts_iniu_s_wlast    (s_wlast),
        .sts_iniu_s_bvalid   (s_bvalid),
        .sts_iniu_s_bready   (s_bready),
        .sts_iniu_s_bid      (s_bid),
        .sts_iniu_s_bresp    (s_bresp),
        .sts_iniu_s_arvalid  (s_arvalid),
        .sts_iniu_s_arready  (s_arready),
        .sts_iniu_s_arid     (s_arid),
        .sts_iniu_s_araddr   (s_araddr),
        .sts_iniu_s_arlen    (s_arlen),
        .sts_iniu_s_arsize   (s_arsize),
        .sts_iniu_s_arburst  (s_arburst),
        .sts_iniu_s_arlock   (s_arlock),
        .sts_iniu_s_arcache  (s_arcache),
        .sts_iniu_s_arprot   (s_arprot),
        .sts_iniu_s_arqos    (s_arqos),
        .sts_iniu_s_aruser   (s_aruser),
        .sts_iniu_s_rvalid   (s_rvalid),
        .sts_iniu_s_rready   (s_rready),
        .sts_iniu_s_rid      (s_rid),
        .sts_iniu_s_rdata    (s_rdata),
        .sts_iniu_s_rresp    (s_rresp),
        .sts_iniu_s_rlast    (s_rlast),
        .out_req_vld         (iniu_req_vld),
        .out_req_rdy         (iniu_req_rdy),
        .out_req_pld         (iniu_req_pld),
        .in_rsp_vld          (iniu_rsp_vld),
        .in_rsp_rdy          (iniu_rsp_rdy),
        .in_rsp_pld          (iniu_rsp_pld),
        .sys_cti_event_in    (sys_cti_event_in),
        .sys_cti_event_out   (sys_cti_event_out),
        .noc_cti_event_out   (iniu_noc_cti_event_out),
        .noc_cti_event_in    (dec_mst_cti_event_out),
        .sys_cti_channel_in  (sys_cti_channel_in),
        .sys_cti_channel_out (sys_cti_channel_out),
        .noc_cti_channel_out (iniu_noc_cti_channel_out),
        .noc_cti_channel_in  (dec_mst_cti_channel_out),
        .cti_apb_psel        (iniu_cti_apb_psel    ),
        .cti_apb_penable     (iniu_cti_apb_penable ),
        .cti_apb_paddr       (iniu_cti_apb_paddr   ),
        .cti_apb_pwrite      (iniu_cti_apb_pwrite  ),
        .cti_apb_pwdata      (iniu_cti_apb_pwdata  ),
        .cti_apb_prdata      (iniu_cti_apb_prdata  ),
        .cti_apb_pready      (iniu_cti_apb_pready  ),
        .cti_apb_pslverr     (iniu_cti_apb_pslverr ),
        .dbg_timestamp_in    (dbg_timestamp_in),
        .dbg_timestamp_out   (),
        .dbg_data_in         (dbg_data_in),
        .dbg_data_out        (),
        .safety_err          (iniu_safety_err)
    );

    assign dec_slv_rsp_pld[0] = tniu0_rsp_pld;
    assign dec_slv_rsp_pld[1] = tniu1_rsp_pld;
    assign dec_slv_rsp_pld[2] = tniu2_rsp_pld;

    `_PREFIX_(sts_noc_dec_node) #(
        .SLAVE_NUM  (3),
        .ROUTE_BASE ({8'h44, 8'h42, 8'h40}),
        .ROUTE_MASK ({8'hCE, 8'hCE, 8'hCE})
    ) u_noc_dec (
        .clk         (clk_dst),
        .rst_n       (rstn_dst),
        .mst_req_vld (iniu_req_vld),
        .mst_req_rdy (iniu_req_rdy),
        .mst_req_pld (iniu_req_pld),
        .mst_rsp_vld (iniu_rsp_vld),
        .mst_rsp_rdy (iniu_rsp_rdy),
        .mst_rsp_pld (iniu_rsp_pld),
        .slv_req_vld ({tniu2_req_vld, tniu1_req_vld, tniu0_req_vld}),
        .slv_req_rdy ({tniu2_req_rdy, tniu1_req_rdy, tniu0_req_rdy}),
        .slv_req_pld (dec_slv_req_pld),
        .slv_rsp_vld ({tniu2_rsp_vld, tniu1_rsp_vld, tniu0_rsp_vld}),
        .slv_rsp_rdy ({tniu2_rsp_rdy, tniu1_rsp_rdy, tniu0_rsp_rdy}),
        .slv_rsp_pld (dec_slv_rsp_pld),
        // CTI Channel CTM
        .mst_cti_channel_in  (iniu_noc_cti_channel_out),
        .mst_cti_channel_out (dec_mst_cti_channel_out),
        .slv_cti_channel_in  ({noc_cti_channel_out_2, noc_cti_channel_out_1, noc_cti_channel_out_0}),
        .slv_cti_channel_out (dec_slv_cti_channel_out),
        // CTI Event CTM
        .mst_cti_event_in    (iniu_noc_cti_event_out),
        .mst_cti_event_out   (dec_mst_cti_event_out),
        .slv_cti_event_in    ({noc_cti_event_out_2, noc_cti_event_out_1, noc_cti_event_out_0}),
        .slv_cti_event_out   (dec_slv_cti_event_out),
        // Debug Timestamp Fanout
        .mst_dbg_timestamp   (dbg_timestamp_in),
        .slv_dbg_timestamp   (dec_slv_dbg_timestamp),
        // Debug Data OR
        .slv_dbg_data        ({dbg_data_out_2, dbg_data_out_1, dbg_data_out_0}),
        .mst_dbg_data        (dec_mst_dbg_data)
    );

    assign tniu0_req_pld = dec_slv_req_pld;
    assign tniu1_req_pld = dec_slv_req_pld;
    assign tniu2_req_pld = dec_slv_req_pld;

    `_PREFIX_(sts_tniu_top) #(
        .APB_ADDR_WIDTH        (APB_ADDR_WIDTH),
        .LOCAL_RSC_TGT_ID      (8'h41),
        .LOCAL_REGBANK_TGT_ID  (8'h40),
        .LOCAL_CTI_TGT_ID      (8'h60),
        .SYS_APB_ROUTE_BASE    ({8'h51, 8'h50}),
        .SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
    ) u_tniu0 (
        .clk_src            (clk_dst), .clk_dst(clk_src), .clk_dbg_timer(clk_dbg_timer),
        .rstn_src           (rstn_dst), .rstn_dst(rstn_src), .rstn_dbg_timer(rstn_dbg_timer),
        .in_req_vld         (tniu0_req_vld), .in_req_rdy(tniu0_req_rdy), .in_req_pld(tniu0_req_pld),
        .out_rsp_vld        (tniu0_rsp_vld), .out_rsp_rdy(tniu0_rsp_rdy), .out_rsp_pld(tniu0_rsp_pld),
        .pmc_psel           (pmc_psel_0), .pmc_penable(pmc_penable_0), .pmc_paddr(pmc_paddr_0), .pmc_pwrite(pmc_pwrite_0), .pmc_pwdata(pmc_pwdata_0), .pmc_prdata(pmc_prdata_0), .pmc_pready(pmc_pready_0), .pmc_pstrb(pmc_pstrb_0), .pmc_pprot(pmc_pprot_0), .pmc_pslverr(pmc_pslverr_0),
        .m_psel(tniu0_sys_psel), .m_paddr(tniu0_sys_paddr), .m_pready(tniu0_sys_pready), .m_prdata(tniu0_sys_prdata), .m_pslverr(tniu0_sys_pslverr), .m_pprot(tniu0_sys_pprot), .m_penable(tniu0_sys_penable), .m_pwrite(tniu0_sys_pwrite), .m_pwdata(tniu0_sys_pwdata), .m_pstrb(tniu0_sys_pstrb),
        .dbg_data_in        (dbg_data_in), .dbg_data_out(dbg_data_out_0), .dbg_timestamp_in(dec_slv_dbg_timestamp[0*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH]), .dbg_timestamp_out(dbg_timestamp_out_0),
        .sys_cti_event_in   (sys_cti_event_in), .sys_cti_event_out(), .noc_cti_event_out(noc_cti_event_out_0), .noc_cti_event_in(dec_slv_cti_event_out[0*CTI_EVENT_WIDTH +: CTI_EVENT_WIDTH]),
        .sys_cti_channel_in (sys_cti_channel_in), .sys_cti_channel_out(), .noc_cti_channel_out(noc_cti_channel_out_0), .noc_cti_channel_in(dec_slv_cti_channel_out[0*CTI_CHANNEL_WIDTH +: CTI_CHANNEL_WIDTH]),
        .timing_bus1        (timing_bus1[0]), .timing_bus2(timing_bus2[0]), .timing_bus3(timing_bus3[0]), .dbg_en(dbg_en[0])
    );

    `_PREFIX_(sts_tniu_top) #(
        .APB_ADDR_WIDTH        (APB_ADDR_WIDTH),
        .LOCAL_RSC_TGT_ID      (8'h43),
        .LOCAL_REGBANK_TGT_ID  (8'h42),
        .LOCAL_CTI_TGT_ID      (8'h62),
        .SYS_APB_ROUTE_BASE    ({8'h53, 8'h52}),
        .SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
    ) u_tniu1 (
        .clk_src            (clk_dst), .clk_dst(clk_src), .clk_dbg_timer(clk_dbg_timer),
        .rstn_src           (rstn_dst), .rstn_dst(rstn_src), .rstn_dbg_timer(rstn_dbg_timer),
        .in_req_vld         (tniu1_req_vld), .in_req_rdy(tniu1_req_rdy), .in_req_pld(tniu1_req_pld),
        .out_rsp_vld        (tniu1_rsp_vld), .out_rsp_rdy(tniu1_rsp_rdy), .out_rsp_pld(tniu1_rsp_pld),
        .pmc_psel           (pmc_psel_1), .pmc_penable(pmc_penable_1), .pmc_paddr(pmc_paddr_1), .pmc_pwrite(pmc_pwrite_1), .pmc_pwdata(pmc_pwdata_1), .pmc_prdata(pmc_prdata_1), .pmc_pready(pmc_pready_1), .pmc_pstrb(pmc_pstrb_1), .pmc_pprot(pmc_pprot_1), .pmc_pslverr(pmc_pslverr_1),
        .m_psel(tniu1_sys_psel), .m_paddr(tniu1_sys_paddr), .m_pready(tniu1_sys_pready), .m_prdata(tniu1_sys_prdata), .m_pslverr(tniu1_sys_pslverr), .m_pprot(tniu1_sys_pprot), .m_penable(tniu1_sys_penable), .m_pwrite(tniu1_sys_pwrite), .m_pwdata(tniu1_sys_pwdata), .m_pstrb(tniu1_sys_pstrb),
        .dbg_data_in        (dbg_data_in), .dbg_data_out(dbg_data_out_1), .dbg_timestamp_in(dec_slv_dbg_timestamp[1*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH]), .dbg_timestamp_out(dbg_timestamp_out_1),
        .sys_cti_event_in   (sys_cti_event_in), .sys_cti_event_out(), .noc_cti_event_out(noc_cti_event_out_1), .noc_cti_event_in(dec_slv_cti_event_out[1*CTI_EVENT_WIDTH +: CTI_EVENT_WIDTH]),
        .sys_cti_channel_in (sys_cti_channel_in), .sys_cti_channel_out(), .noc_cti_channel_out(noc_cti_channel_out_1), .noc_cti_channel_in(dec_slv_cti_channel_out[1*CTI_CHANNEL_WIDTH +: CTI_CHANNEL_WIDTH]),
        .timing_bus1        (timing_bus1[1]), .timing_bus2(timing_bus2[1]), .timing_bus3(timing_bus3[1]), .dbg_en(dbg_en[1])
    );

    `_PREFIX_(sts_tniu_top) #(
        .APB_ADDR_WIDTH        (APB_ADDR_WIDTH),
        .LOCAL_RSC_TGT_ID      (8'h45),
        .LOCAL_REGBANK_TGT_ID  (8'h44),
        .LOCAL_CTI_TGT_ID      (8'h64),
        .SYS_APB_ROUTE_BASE    ({8'h55, 8'h54}),
        .SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
    ) u_tniu2 (
        .clk_src            (clk_dst), .clk_dst(clk_src), .clk_dbg_timer(clk_dbg_timer),
        .rstn_src           (rstn_dst), .rstn_dst(rstn_src), .rstn_dbg_timer(rstn_dbg_timer),
        .in_req_vld         (tniu2_req_vld), .in_req_rdy(tniu2_req_rdy), .in_req_pld(tniu2_req_pld),
        .out_rsp_vld        (tniu2_rsp_vld), .out_rsp_rdy(tniu2_rsp_rdy), .out_rsp_pld(tniu2_rsp_pld),
        .pmc_psel           (pmc_psel_2), .pmc_penable(pmc_penable_2), .pmc_paddr(pmc_paddr_2), .pmc_pwrite(pmc_pwrite_2), .pmc_pwdata(pmc_pwdata_2), .pmc_prdata(pmc_prdata_2), .pmc_pready(pmc_pready_2), .pmc_pstrb(pmc_pstrb_2), .pmc_pprot(pmc_pprot_2), .pmc_pslverr(pmc_pslverr_2),
        .m_psel(tniu2_sys_psel), .m_paddr(tniu2_sys_paddr), .m_pready(tniu2_sys_pready), .m_prdata(tniu2_sys_prdata), .m_pslverr(tniu2_sys_pslverr), .m_pprot(tniu2_sys_pprot), .m_penable(tniu2_sys_penable), .m_pwrite(tniu2_sys_pwrite), .m_pwdata(tniu2_sys_pwdata), .m_pstrb(tniu2_sys_pstrb),
        .dbg_data_in        (dbg_data_in), .dbg_data_out(dbg_data_out_2), .dbg_timestamp_in(dec_slv_dbg_timestamp[2*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH]), .dbg_timestamp_out(dbg_timestamp_out_2),
        .sys_cti_event_in   (sys_cti_event_in), .sys_cti_event_out(), .noc_cti_event_out(noc_cti_event_out_2), .noc_cti_event_in(dec_slv_cti_event_out[2*CTI_EVENT_WIDTH +: CTI_EVENT_WIDTH]),
        .sys_cti_channel_in (sys_cti_channel_in), .sys_cti_channel_out(), .noc_cti_channel_out(noc_cti_channel_out_2), .noc_cti_channel_in(dec_slv_cti_channel_out[2*CTI_CHANNEL_WIDTH +: CTI_CHANNEL_WIDTH]),
        .timing_bus1        (timing_bus1[2]), .timing_bus2(timing_bus2[2]), .timing_bus3(timing_bus3[2]), .dbg_en(dbg_en[2])
    );

    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hA000_0000)) u_pmc0  (.clk(clk_dst), .rst_n(rstn_dst), .psel(pmc_psel_0), .penable(pmc_penable_0), .paddr(pmc_paddr_0), .pwrite(pmc_pwrite_0), .pwdata(pmc_pwdata_0), .pstrb(pmc_pstrb_0), .pready(pmc_pready_0), .prdata(pmc_prdata_0), .pslverr(pmc_pslverr_0));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hA100_0000)) u_sys00 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu0_sys_psel[0]), .penable(tniu0_sys_penable), .paddr(tniu0_sys_paddr), .pwrite(tniu0_sys_pwrite), .pwdata(tniu0_sys_pwdata), .pstrb(tniu0_sys_pstrb), .pready(pready_00), .prdata(prdata_00), .pslverr(pslverr_00));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hA200_0000)) u_sys01 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu0_sys_psel[1]), .penable(tniu0_sys_penable), .paddr(tniu0_sys_paddr), .pwrite(tniu0_sys_pwrite), .pwdata(tniu0_sys_pwdata), .pstrb(tniu0_sys_pstrb), .pready(pready_01), .prdata(prdata_01), .pslverr(pslverr_01));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hB000_0000)) u_pmc1  (.clk(clk_dst), .rst_n(rstn_dst), .psel(pmc_psel_1), .penable(pmc_penable_1), .paddr(pmc_paddr_1), .pwrite(pmc_pwrite_1), .pwdata(pmc_pwdata_1), .pstrb(pmc_pstrb_1), .pready(pmc_pready_1), .prdata(pmc_prdata_1), .pslverr(pmc_pslverr_1));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hB100_0000)) u_sys10 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu1_sys_psel[0]), .penable(tniu1_sys_penable), .paddr(tniu1_sys_paddr), .pwrite(tniu1_sys_pwrite), .pwdata(tniu1_sys_pwdata), .pstrb(tniu1_sys_pstrb), .pready(pready_10), .prdata(prdata_10), .pslverr(pslverr_10));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hB200_0000)) u_sys11 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu1_sys_psel[1]), .penable(tniu1_sys_penable), .paddr(tniu1_sys_paddr), .pwrite(tniu1_sys_pwrite), .pwdata(tniu1_sys_pwdata), .pstrb(tniu1_sys_pstrb), .pready(pready_11), .prdata(prdata_11), .pslverr(pslverr_11));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hC000_0000)) u_pmc2  (.clk(clk_dst), .rst_n(rstn_dst), .psel(pmc_psel_2), .penable(pmc_penable_2), .paddr(pmc_paddr_2), .pwrite(pmc_pwrite_2), .pwdata(pmc_pwdata_2), .pstrb(pmc_pstrb_2), .pready(pmc_pready_2), .prdata(pmc_prdata_2), .pslverr(pmc_pslverr_2));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hC100_0000)) u_sys20 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu2_sys_psel[0]), .penable(tniu2_sys_penable), .paddr(tniu2_sys_paddr), .pwrite(tniu2_sys_pwrite), .pwdata(tniu2_sys_pwdata), .pstrb(tniu2_sys_pstrb), .pready(pready_20), .prdata(prdata_20), .pslverr(pslverr_20));
    `_PREFIX_(sts_apb_stub_slave) #(.ADDR_WIDTH(APB_ADDR_WIDTH), .INIT_PATTERN(32'hC200_0000)) u_sys21 (.clk(clk_src), .rst_n(rstn_src), .psel(tniu2_sys_psel[1]), .penable(tniu2_sys_penable), .paddr(tniu2_sys_paddr), .pwrite(tniu2_sys_pwrite), .pwdata(tniu2_sys_pwdata), .pstrb(tniu2_sys_pstrb), .pready(pready_21), .prdata(prdata_21), .pslverr(pslverr_21));

endmodule
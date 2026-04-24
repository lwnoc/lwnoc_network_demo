// DUT adapter: wraps sts_noc_top_wrap with the SAME external port list as
// sts_noc_1iniu_3tniu_dut so the nouvm testbench can instantiate it unchanged.
//
// Topology:
//   clk_src/rstn_src  = clk_sys  (AXI slave + APB master SYS domain)
//   clk_dst/rstn_dst  = clk_noc  (NOC ring domain)
//   NOC ring loopback: iniu_noc REQ output  -> tniu_noc REQ input
//                      tniu_noc RSP output  -> iniu_noc RSP input
//
// Address map (4 entries, matched to new TNIU defaults):
//   0x0000_0000 -> TGT=8'h01  LOCAL_REGBANK_TGT_ID
//   0x0000_1000 -> TGT=8'h00  LOCAL_RSC_TGT_ID  (PMC APB stub u_pmc0)
//   0x0000_2000 -> TGT=8'h02  SYS_APB_ROUTE[0]  (u_sys00)
//   0x0000_3000 -> TGT=8'h03  SYS_APB_ROUTE[1]  (u_sys01)
//   others      -> TGT=8'hFF  decode error

module `_PREFIX_(sts_wrap_1iniu_1tniu_dut)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned APB_ADDR_WIDTH      = 32,
    parameter integer unsigned NODE_NUM            = 2
)(
    input   logic                           clk_src,
    input   logic                           clk_dst,
    input   logic                           clk_dbg_timer,
    input   logic                           rstn_src,
    input   logic                           rstn_dst,
    input   logic                           rstn_dbg_timer,

    input   logic [SRC_ID_WIDTH-1:0]        node_id,

    input   logic                           s_awvalid,
    output  logic                           s_awready,
    input   logic [AXI_AWID_WIDTH-1:0]      s_awid,
    input   logic [AXI_ADDR_WIDTH-1:0]      s_awaddr,
    input   logic [AXI_AWLEN_WIDTH-1:0]     s_awlen,
    input   logic [2:0]                     s_awsize,
    input   logic [1:0]                     s_awburst,
    input   logic                           s_awlock,
    input   logic [3:0]                     s_awcache,
    input   logic [2:0]                     s_awprot,
    input   logic [3:0]                     s_awqos,
    input   logic [AXI_USER_WIDTH-1:0]      s_awuser,
    input   logic                           s_wvalid,
    output  logic                           s_wready,
    input   logic [AXI_DATA_WIDTH-1:0]      s_wdata,
    input   logic [AXI_STRB_WIDTH-1:0]      s_wstrb,
    input   logic                           s_wlast,
    output  logic                           s_bvalid,
    input   logic                           s_bready,
    output  logic [AXI_BID_WIDTH-1:0]       s_bid,
    output  logic [1:0]                     s_bresp,
    input   logic                           s_arvalid,
    output  logic                           s_arready,
    input   logic [AXI_ARID_WIDTH-1:0]      s_arid,
    input   logic [AXI_ADDR_WIDTH-1:0]      s_araddr,
    input   logic [AXI_ARLEN_WIDTH-1:0]     s_arlen,
    input   logic [2:0]                     s_arsize,
    input   logic [1:0]                     s_arburst,
    input   logic                           s_arlock,
    input   logic [3:0]                     s_arcache,
    input   logic [2:0]                     s_arprot,
    input   logic [3:0]                     s_arqos,
    input   logic [AXI_USER_WIDTH-1:0]      s_aruser,
    output  logic                           s_rvalid,
    input   logic                           s_rready,
    output  logic [AXI_RID_WIDTH-1:0]       s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]      s_rdata,
    output  logic [1:0]                     s_rresp,
    output  logic                           s_rlast,

    input   logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_out,
    input   logic [CTI_CHANNEL_WIDTH-1:0]   sys_cti_channel_in,
    output  logic [CTI_CHANNEL_WIDTH-1:0]   sys_cti_channel_out,
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

    // ---------------------------------------------------------------
    // NOC ring loopback wires (iniu_noc output → tniu_noc input and back)
    // ---------------------------------------------------------------
    logic           noc_req_vld ;
    logic           noc_req_rdy ;
    sts_req_typ     noc_req_pld ;
    logic           noc_rsp_vld ;
    logic           noc_rsp_rdy ;
    sts_rsp_typ     noc_rsp_pld ;

    // ---------------------------------------------------------------
    // Internal probe wires — testbench accesses these via hierarchical path
    // tniu0_rsp_* and iniu_rsp_* both alias the loopback RSP signals
    // ---------------------------------------------------------------
    logic           iniu_rsp_vld ;
    logic           iniu_rsp_rdy ;
    sts_rsp_typ     iniu_rsp_pld ;
    logic           tniu0_rsp_vld;
    logic           tniu0_rsp_rdy;
    sts_rsp_typ     tniu0_rsp_pld;

    assign iniu_rsp_vld  = noc_rsp_vld;
    assign iniu_rsp_rdy  = noc_rsp_rdy;
    assign iniu_rsp_pld  = noc_rsp_pld;
    assign tniu0_rsp_vld = noc_rsp_vld;
    assign tniu0_rsp_rdy = noc_rsp_rdy;
    assign tniu0_rsp_pld = noc_rsp_pld;

    // ---------------------------------------------------------------
    // tniu_noc APB (PMC side): connected to u_pmc0
    // ---------------------------------------------------------------
    logic                            tniu_noc_psel    ;
    logic                            tniu_noc_penable ;
    logic [APB_ADDR_WIDTH-1:0]       tniu_noc_paddr   ;
    logic                            tniu_noc_pwrite  ;
    logic [31:0]                     tniu_noc_pwdata  ;
    logic [31:0]                     tniu_noc_prdata  ;
    logic                            tniu_noc_pready  ;
    logic [3:0]                      tniu_noc_pstrb   ;
    logic [2:0]                      tniu_noc_pprot   ;
    logic                            tniu_noc_pslverr ;

    // ---------------------------------------------------------------
    // tniu_sys APB master array: [0]→u_sys00, [1]→u_sys01
    // ---------------------------------------------------------------
    logic [1:0]              tniu_sys_psel    ;
    logic [APB_ADDR_WIDTH-1:0] tniu_sys_paddr ;
    logic [1:0]              tniu_sys_pready  ;
    logic [63:0]             tniu_sys_prdata  ;
    logic [1:0]              tniu_sys_pslverr ;
    logic [2:0]              tniu_sys_pprot   ;
    logic                    tniu_sys_penable ;
    logic                    tniu_sys_pwrite  ;
    logic [31:0]             tniu_sys_pwdata  ;
    logic [3:0]              tniu_sys_pstrb   ;

    // Individual slave responses aggregated into arrays
    logic       pready_sys00;
    logic [31:0] prdata_sys00;
    logic       pslverr_sys00;
    logic       pready_sys01;
    logic [31:0] prdata_sys01;
    logic       pslverr_sys01;

    assign tniu_sys_pready  = {pready_sys01,  pready_sys00};
    assign tniu_sys_prdata  = {prdata_sys01,  prdata_sys00};
    assign tniu_sys_pslverr = {pslverr_sys01, pslverr_sys00};

    // ---------------------------------------------------------------
    // Tied-off stubs for TNIU1/2 APB ports (testbench just sets stall_cycles_cfg)
    // ---------------------------------------------------------------
    logic pmc_psel_1, pmc_psel_2;
    logic pmc_penable_1, pmc_penable_2;
    logic [APB_ADDR_WIDTH-1:0] pmc_paddr_1, pmc_paddr_2;
    logic pmc_pwrite_1, pmc_pwrite_2;
    logic [31:0] pmc_pwdata_1, pmc_pwdata_2;
    logic [31:0] pmc_prdata_1, pmc_prdata_2;
    logic pmc_pready_1, pmc_pready_2;
    logic [3:0] pmc_pstrb_1, pmc_pstrb_2;
    logic pmc_pslverr_1, pmc_pslverr_2;

    assign pmc_psel_1    = 1'b0;
    assign pmc_penable_1 = 1'b0;
    assign pmc_paddr_1   = '0;
    assign pmc_pwrite_1  = 1'b0;
    assign pmc_pwdata_1  = '0;
    assign pmc_pstrb_1   = '0;
    assign pmc_psel_2    = 1'b0;
    assign pmc_penable_2 = 1'b0;
    assign pmc_paddr_2   = '0;
    assign pmc_pwrite_2  = 1'b0;
    assign pmc_pwdata_2  = '0;
    assign pmc_pstrb_2   = '0;

    // sys1x/2x stubs (unused)
    logic tniu1_sys_penable, tniu2_sys_penable;
    logic tniu1_sys_pwrite,  tniu2_sys_pwrite;
    logic [31:0] tniu1_sys_pwdata, tniu2_sys_pwdata;
    logic [3:0]  tniu1_sys_pstrb,  tniu2_sys_pstrb;
    logic [APB_ADDR_WIDTH-1:0] tniu1_sys_paddr, tniu2_sys_paddr;
    logic [1:0] tniu1_sys_psel,   tniu2_sys_psel;
    logic [1:0] tniu1_sys_pready, tniu2_sys_pready;
    logic [63:0] tniu1_sys_prdata, tniu2_sys_prdata;
    logic [1:0]  tniu1_sys_pslverr, tniu2_sys_pslverr;
    logic pready_10, pready_11, pready_20, pready_21;
    logic [31:0] prdata_10, prdata_11, prdata_20, prdata_21;
    logic pslverr_10, pslverr_11, pslverr_20, pslverr_21;

    assign tniu1_sys_psel    = '0;
    assign tniu1_sys_paddr   = '0;
    assign tniu1_sys_penable = 1'b0;
    assign tniu1_sys_pwrite  = 1'b0;
    assign tniu1_sys_pwdata  = '0;
    assign tniu1_sys_pstrb   = '0;
    assign tniu1_sys_pready  = {pready_11,  pready_10};
    assign tniu1_sys_prdata  = {prdata_11,  prdata_10};
    assign tniu1_sys_pslverr = {pslverr_11, pslverr_10};

    assign tniu2_sys_psel    = '0;
    assign tniu2_sys_paddr   = '0;
    assign tniu2_sys_penable = 1'b0;
    assign tniu2_sys_pwrite  = 1'b0;
    assign tniu2_sys_pwdata  = '0;
    assign tniu2_sys_pstrb   = '0;
    assign tniu2_sys_pready  = {pready_21,  pready_20};
    assign tniu2_sys_prdata  = {prdata_21,  prdata_20};
    assign tniu2_sys_pslverr = {pslverr_21, pslverr_20};

    // ---------------------------------------------------------------
    // sts_noc_top_wrap instantiation
    // clk_sys = clk_src (AXI/APB domain), clk_noc = clk_dst (NOC ring)
    // ---------------------------------------------------------------
    `_PREFIX_(sts_noc_top_wrap) #(
        .DBG_TIMESTAMP_WIDTH    (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH         (DBG_DATA_WIDTH     ),
        .APB_ADDR_WIDTH         (APB_ADDR_WIDTH     ),
        .NODE_NUM               (NODE_NUM           ),
        .SYS_APB_MASTER_NUM     (2                  ),
        .SYS_APB_ROUTE_BASE     ({8'h03, 8'h02}     ),   // TGT 8'h02→psel[0], 8'h03→psel[1]
        .SYS_APB_ROUTE_MASK     ({8'hFF, 8'hFF}     ),   // exact match
        .ADDR_MAP_ENTRY_NUM     (4                  ),
        // Entry ordering: entry0=LSB, entry3=MSB (concatenated into flat vector)
        // [0] 0x0000_0000 → TGT=8'h01  regbank
        // [1] 0x0000_1000 → TGT=8'h00  RSC (PMC APB)
        // [2] 0x0000_2000 → TGT=8'h02  SYS APB route[0]
        // [3] 0x0000_3000 → TGT=8'h03  SYS APB route[1]
        .ADDR_MAP_BASE_TABLE    ({32'h0000_3000, 32'h0000_2000,
                                  32'h0000_1000, 32'h0000_0000}),
        .ADDR_MAP_MASK_TABLE    ({32'hFFFF_F000, 32'hFFFF_F000,
                                  32'hFFFF_F000, 32'hFFFF_F000}),
        .ADDR_MAP_TGT_ID_TABLE  ({8'h03, 8'h02, 8'h00, 8'h01} ),
        .ADDR_MAP_DEFAULT_TGT_ID(8'hFF                         )
    ) u_top_wrap (
        .clk_sys            (clk_src            ),
        .rstn_sys           (rstn_src           ),
        .clk_noc            (clk_dst            ),
        .rstn_noc           (rstn_dst           ),
        .clk_dbg_timer      (clk_dbg_timer      ),
        .rstn_dbg_timer     (rstn_dbg_timer     ),
        // INIU AXI slave
        .node_id            (node_id            ),
        // .flow_ctrl_busy     (flow_ctrl_busy     ),
        // .flow_ctrl_update   (flow_ctrl_update   ),
        .s_awvalid          (s_awvalid          ),
        .s_awready          (s_awready          ),
        .s_awid             (s_awid             ),
        .s_awaddr           (s_awaddr           ),
        .s_awlen            (s_awlen            ),
        .s_awsize           (s_awsize           ),
        .s_awburst          (s_awburst          ),
        .s_awlock           (s_awlock           ),
        .s_awcache          (s_awcache          ),
        .s_awprot           (s_awprot           ),
        .s_awqos            (s_awqos            ),
        .s_awuser           (s_awuser           ),
        .s_wvalid           (s_wvalid           ),
        .s_wready           (s_wready           ),
        .s_wdata            (s_wdata            ),
        .s_wstrb            (s_wstrb            ),
        .s_wlast            (s_wlast            ),
        .s_bvalid           (s_bvalid           ),
        .s_bready           (s_bready           ),
        .s_bid              (s_bid              ),
        .s_bresp            (s_bresp            ),
        .s_arvalid          (s_arvalid          ),
        .s_arready          (s_arready          ),
        .s_arid             (s_arid             ),
        .s_araddr           (s_araddr           ),
        .s_arlen            (s_arlen            ),
        .s_arsize           (s_arsize           ),
        .s_arburst          (s_arburst          ),
        .s_arlock           (s_arlock           ),
        .s_arcache          (s_arcache          ),
        .s_arprot           (s_arprot           ),
        .s_arqos            (s_arqos            ),
        .s_aruser           (s_aruser           ),
        .s_rvalid           (s_rvalid           ),
        .s_rready           (s_rready           ),
        .s_rid              (s_rid              ),
        .s_rdata            (s_rdata            ),
        .s_rresp            (s_rresp            ),
        .s_rlast            (s_rlast            ),
        // NOC ring loopback: INIU REQ ↔ TNIU REQ (same wires = loopback)
        .noc_req_s_vld      (noc_req_vld        ),   // output → drives wire
        .noc_req_s_rdy      (noc_req_rdy        ),   // input  ← from noc_in_req_rdy
        .noc_req_s_pld      (noc_req_pld        ),   // output
        .noc_in_req_vld     (noc_req_vld        ),   // input  ← from noc_req_s_vld
        .noc_in_req_rdy     (noc_req_rdy        ),   // output → feeds noc_req_s_rdy
        .noc_in_req_pld     (noc_req_pld        ),   // input
        // NOC ring loopback: TNIU RSP ↔ INIU RSP
        .noc_out_rsp_vld    (noc_rsp_vld        ),   // output → drives wire
        .noc_out_rsp_rdy    (noc_rsp_rdy        ),   // input  ← from noc_rsp_m_rdy
        .noc_out_rsp_pld    (noc_rsp_pld        ),   // output
        .noc_rsp_m_vld      (noc_rsp_vld        ),   // input  ← from noc_out_rsp_vld
        .noc_rsp_m_rdy      (noc_rsp_rdy        ),   // output → feeds noc_out_rsp_rdy
        .noc_rsp_m_pld      (noc_rsp_pld        ),   // input
        // tniu_noc PMC APB → u_pmc0
        .tniu_noc_psel      (tniu_noc_psel      ),
        .tniu_noc_penable   (tniu_noc_penable   ),
        .tniu_noc_paddr     (tniu_noc_paddr     ),
        .tniu_noc_pwrite    (tniu_noc_pwrite    ),
        .tniu_noc_pwdata    (tniu_noc_pwdata    ),
        .tniu_noc_prdata    (tniu_noc_prdata    ),
        .tniu_noc_pready    (tniu_noc_pready    ),
        .tniu_noc_pstrb     (tniu_noc_pstrb     ),
        .tniu_noc_pprot     (tniu_noc_pprot     ),
        .tniu_noc_pslverr   (tniu_noc_pslverr   ),
        // tniu_sys APB master → u_sys00, u_sys01
        .tniu_sys_m_psel    (tniu_sys_psel      ),
        .tniu_sys_m_paddr   (tniu_sys_paddr     ),
        .tniu_sys_m_pready  (tniu_sys_pready    ),
        .tniu_sys_m_prdata  (tniu_sys_prdata    ),
        .tniu_sys_m_pslverr (tniu_sys_pslverr   ),
        .tniu_sys_m_pprot   (tniu_sys_pprot     ),
        .tniu_sys_m_penable (tniu_sys_penable   ),
        .tniu_sys_m_pwrite  (tniu_sys_pwrite    ),
        .tniu_sys_m_pwdata  (tniu_sys_pwdata    ),
        .tniu_sys_m_pstrb   (tniu_sys_pstrb     ),
        // debug passthrough (CTI tied off inside top_wrap)
        .dbg_timestamp_in   (dbg_timestamp_in   ),
        .dbg_data_in        (dbg_data_in        )
    );

    // ---------------------------------------------------------------
    // APB slave stubs — u_pmc0 / u_sys00 / u_sys01 are the REAL stubs
    // ---------------------------------------------------------------

    // u_pmc0: TNIU_NOC RSC window stub (clk_dst = NOC domain)
    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hA000_0000   )
    ) u_pmc0 (
        .clk     (clk_dst           ),
        .rst_n   (rstn_dst          ),
        .psel    (tniu_noc_psel     ),
        .penable (tniu_noc_penable  ),
        .paddr   (tniu_noc_paddr    ),
        .pwrite  (tniu_noc_pwrite   ),
        .pwdata  (tniu_noc_pwdata   ),
        .pstrb   (tniu_noc_pstrb    ),
        .pready  (tniu_noc_pready   ),
        .prdata  (tniu_noc_prdata   ),
        .pslverr (tniu_noc_pslverr  )
    );

    // u_sys00: TNIU_SYS APB route[0] stub (clk_src = SYS domain)
    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hA100_0000   )
    ) u_sys00 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu_sys_psel[0]    ),
        .penable (tniu_sys_penable    ),
        .paddr   (tniu_sys_paddr      ),
        .pwrite  (tniu_sys_pwrite     ),
        .pwdata  (tniu_sys_pwdata     ),
        .pstrb   (tniu_sys_pstrb      ),
        .pready  (pready_sys00        ),
        .prdata  (prdata_sys00        ),
        .pslverr (pslverr_sys00       )
    );

    // u_sys01: TNIU_SYS APB route[1] stub (clk_src = SYS domain)
    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hA200_0000   )
    ) u_sys01 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu_sys_psel[1]    ),
        .penable (tniu_sys_penable    ),
        .paddr   (tniu_sys_paddr      ),
        .pwrite  (tniu_sys_pwrite     ),
        .pwdata  (tniu_sys_pwdata     ),
        .pstrb   (tniu_sys_pstrb      ),
        .pready  (pready_sys01        ),
        .prdata  (prdata_sys01        ),
        .pslverr (pslverr_sys01       )
    );

    // ---------------------------------------------------------------
    // TNIU1/2 stubs — tied-off, present only for testbench hierarchy
    // Testbench accesses u_pmc1.stall_cycles_cfg etc. via h-path;
    // no real APB traffic flows to these in the 1-TNIU loopback.
    // ---------------------------------------------------------------

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hB000_0000   )
    ) u_pmc1 (
        .clk     (clk_dst           ),
        .rst_n   (rstn_dst          ),
        .psel    (pmc_psel_1        ),
        .penable (pmc_penable_1     ),
        .paddr   (pmc_paddr_1       ),
        .pwrite  (pmc_pwrite_1      ),
        .pwdata  (pmc_pwdata_1      ),
        .pstrb   (pmc_pstrb_1       ),
        .pready  (pmc_pready_1      ),
        .prdata  (pmc_prdata_1      ),
        .pslverr (pmc_pslverr_1     )
    );

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hB100_0000   )
    ) u_sys10 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu1_sys_psel[0]   ),
        .penable (tniu1_sys_penable   ),
        .paddr   (tniu1_sys_paddr     ),
        .pwrite  (tniu1_sys_pwrite    ),
        .pwdata  (tniu1_sys_pwdata    ),
        .pstrb   (tniu1_sys_pstrb     ),
        .pready  (pready_10           ),
        .prdata  (prdata_10           ),
        .pslverr (pslverr_10          )
    );

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hB200_0000   )
    ) u_sys11 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu1_sys_psel[1]   ),
        .penable (tniu1_sys_penable   ),
        .paddr   (tniu1_sys_paddr     ),
        .pwrite  (tniu1_sys_pwrite    ),
        .pwdata  (tniu1_sys_pwdata    ),
        .pstrb   (tniu1_sys_pstrb     ),
        .pready  (pready_11           ),
        .prdata  (prdata_11           ),
        .pslverr (pslverr_11          )
    );

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hC000_0000   )
    ) u_pmc2 (
        .clk     (clk_dst           ),
        .rst_n   (rstn_dst          ),
        .psel    (pmc_psel_2        ),
        .penable (pmc_penable_2     ),
        .paddr   (pmc_paddr_2       ),
        .pwrite  (pmc_pwrite_2      ),
        .pwdata  (pmc_pwdata_2      ),
        .pstrb   (pmc_pstrb_2       ),
        .pready  (pmc_pready_2      ),
        .prdata  (pmc_prdata_2      ),
        .pslverr (pmc_pslverr_2     )
    );

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hC100_0000   )
    ) u_sys20 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu2_sys_psel[0]   ),
        .penable (tniu2_sys_penable   ),
        .paddr   (tniu2_sys_paddr     ),
        .pwrite  (tniu2_sys_pwrite    ),
        .pwdata  (tniu2_sys_pwdata    ),
        .pstrb   (tniu2_sys_pstrb     ),
        .pready  (pready_20           ),
        .prdata  (prdata_20           ),
        .pslverr (pslverr_20          )
    );

    `_PREFIX_(sts_apb_stub_slave) #(
        .ADDR_WIDTH   (APB_ADDR_WIDTH  ),
        .INIT_PATTERN (32'hC200_0000   )
    ) u_sys21 (
        .clk     (clk_src             ),
        .rst_n   (rstn_src            ),
        .psel    (tniu2_sys_psel[1]   ),
        .penable (tniu2_sys_penable   ),
        .paddr   (tniu2_sys_paddr     ),
        .pwrite  (tniu2_sys_pwrite    ),
        .pwdata  (tniu2_sys_pwdata    ),
        .pstrb   (tniu2_sys_pstrb     ),
        .pready  (pready_21           ),
        .prdata  (prdata_21           ),
        .pslverr (pslverr_21          )
    );

    // ---------------------------------------------------------------
    // Tie off ports that have no equivalent in sts_noc_top_wrap
    // ---------------------------------------------------------------
    assign sys_cti_event_out   = '0;
    assign sys_cti_channel_out = '0;
    assign dbg_timestamp_out_0 = '0;
    assign dbg_timestamp_out_1 = '0;
    assign dbg_timestamp_out_2 = '0;
    assign dbg_data_out_0      = '0;
    assign dbg_data_out_1      = '0;
    assign dbg_data_out_2      = '0;
    assign timing_bus1         = '0;
    assign timing_bus2         = '0;
    assign timing_bus3         = '0;
    assign dbg_en              = '0;

endmodule

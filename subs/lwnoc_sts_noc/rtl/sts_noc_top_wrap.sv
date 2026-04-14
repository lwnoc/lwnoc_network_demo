// STS NoC Top Wrapper — 1 sts_iniu_sys / 1 sts_iniu_noc / 1 sts_tniu_noc / 1 sts_tniu_sys
// Clock mapping:
//   clk_sys (AXI / APB domain):
//     sts_iniu_sys.clk_src, sts_iniu_noc.clk_src, sts_tniu_noc.clk_dst, sts_tniu_sys.clk_dst
//   clk_noc (NOC fabric domain):
//     sts_iniu_sys.clk_dst, sts_iniu_noc.clk_dst, sts_tniu_noc.clk_src, sts_tniu_sys.clk_src
//   clk_dbg_timer : sts_tniu_sys debug timer clock
// Internal AFIFO handshakes:
//   INIU-REQ: iniu_sys write → iniu_noc read
//   INIU-RSP: iniu_noc write → iniu_sys read
//   TNIU-REQ: tniu_noc write → tniu_sys read
//   TNIU-RSP: tniu_sys write → tniu_noc read
// NOC ring ports are exposed; CTI/DBG signals tied off for brevity.

module `_PREFIX_(sts_noc_top_wrap)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    // INIU side AFIFO depth (sts_iniu_sys / sts_iniu_noc)
    parameter integer unsigned INIU_FIFO_DEPTH          = 4,
    parameter integer unsigned SYNC_STAGE               = 2,
    parameter integer unsigned NODE_NUM                 = 2,
    parameter integer unsigned DBG_TIMESTAMP_WIDTH      = 64,
    parameter integer unsigned DBG_DATA_WIDTH           = 32,
    // TNIU side AFIFO depth
    parameter integer unsigned TNIU_ASYNC_FIFO_DEPTH    = 4,
    parameter integer unsigned TNIU_FIFO_DEPTH          = 16,
    parameter integer unsigned APB_ADDR_WIDTH           = 32,
    // sts_tniu_sys APB master num
    parameter integer unsigned SYS_APB_MASTER_NUM       = 2,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_BASE = '0,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_MASK = '0,
    // sts_iniu_sys address map (one-entry default)
    parameter integer unsigned ADDR_MAP_ENTRY_NUM       = 1,
    parameter logic [AXI_ADDR_WIDTH-1:0] ADDR_MAP_BASE_TABLE = '0,
    parameter logic [AXI_ADDR_WIDTH-1:0] ADDR_MAP_MASK_TABLE = '0,
    parameter logic [TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = '0,
    parameter logic [TGT_ID_WIDTH-1:0]   ADDR_MAP_DEFAULT_TGT_ID = '0,
    localparam int REQ_PLD_WIDTH = $bits(sts_req_typ),
    localparam int RSP_PLD_WIDTH = $bits(sts_rsp_typ)
)(
    // -----------------------------------------------------------------
    // Clocks and resets
    // -----------------------------------------------------------------
    input  logic                            clk_sys             ,
    input  logic                            rstn_sys            ,
    input  logic                            clk_noc             ,
    input  logic                            rstn_noc            ,
    input  logic                            clk_dbg_timer       ,
    input  logic                            rstn_dbg_timer      ,

    // -----------------------------------------------------------------
    // INIU system side — AXI4 slave (trace / coherency initiator)
    // -----------------------------------------------------------------
    input  logic [SRC_ID_WIDTH-1:0]         node_id             ,
    input  logic [NODE_NUM-1:0]             flow_ctrl_busy      ,
    output logic                            flow_ctrl_update    ,

    input  logic                            s_awvalid           ,
    output logic                            s_awready           ,
    input  logic [AXI_AWID_WIDTH-1:0]       s_awid              ,
    input  logic [AXI_ADDR_WIDTH-1:0]       s_awaddr            ,
    input  logic [AXI_AWLEN_WIDTH-1:0]      s_awlen             ,
    input  logic [2:0]                      s_awsize            ,
    input  logic [1:0]                      s_awburst           ,
    input  logic                            s_awlock            ,
    input  logic [3:0]                      s_awcache           ,
    input  logic [2:0]                      s_awprot            ,
    input  logic [3:0]                      s_awqos             ,
    input  logic [AXI_USER_WIDTH-1:0]       s_awuser            ,

    input  logic                            s_wvalid            ,
    output logic                            s_wready            ,
    input  logic [AXI_DATA_WIDTH-1:0]       s_wdata             ,
    input  logic [AXI_STRB_WIDTH-1:0]       s_wstrb             ,
    input  logic                            s_wlast             ,

    output logic                            s_bvalid            ,
    input  logic                            s_bready            ,
    output logic [AXI_BID_WIDTH-1:0]        s_bid               ,
    output logic [1:0]                      s_bresp             ,

    input  logic                            s_arvalid           ,
    output logic                            s_arready           ,
    input  logic [AXI_ARID_WIDTH-1:0]       s_arid              ,
    input  logic [AXI_ADDR_WIDTH-1:0]       s_araddr            ,
    input  logic [AXI_ARLEN_WIDTH-1:0]      s_arlen             ,
    input  logic [2:0]                      s_arsize            ,
    input  logic [1:0]                      s_arburst           ,
    input  logic                            s_arlock            ,
    input  logic [3:0]                      s_arcache           ,
    input  logic [2:0]                      s_arprot            ,
    input  logic [3:0]                      s_arqos             ,
    input  logic [AXI_USER_WIDTH-1:0]       s_aruser            ,

    output logic                            s_rvalid            ,
    input  logic                            s_rready            ,
    output logic [AXI_RID_WIDTH-1:0]        s_rid               ,
    output logic [AXI_DATA_WIDTH-1:0]       s_rdata             ,
    output logic [1:0]                      s_rresp             ,
    output logic                            s_rlast             ,

    // -----------------------------------------------------------------
    // NOC ring side — iniu_noc REQ output + RSP input
    // -----------------------------------------------------------------
    output logic                            noc_req_s_vld       ,
    input  logic                            noc_req_s_rdy       ,
    output sts_req_typ                      noc_req_s_pld       ,

    input  logic                            noc_rsp_m_vld       ,
    output logic                            noc_rsp_m_rdy       ,
    input  sts_rsp_typ                      noc_rsp_m_pld       ,

    // -----------------------------------------------------------------
    // NOC ring side — tniu_noc REQ input + RSP output
    // -----------------------------------------------------------------
    input  logic                            noc_in_req_vld      ,
    output logic                            noc_in_req_rdy      ,
    input  sts_req_typ                      noc_in_req_pld      ,

    output logic                            noc_out_rsp_vld     ,
    input  logic                            noc_out_rsp_rdy     ,
    output sts_rsp_typ                      noc_out_rsp_pld     ,

    // -----------------------------------------------------------------
    // TNIU NOC → tniu_noc write stall/clear/status
    // -----------------------------------------------------------------
    input  logic                            write_stall         ,
    input  logic                            write_clear         ,
    output logic                            write_full_zero     ,

    // -----------------------------------------------------------------
    // TNIU system side — APB master array (tniu_noc) 
    // -----------------------------------------------------------------
    output logic                            tniu_noc_psel       ,
    output logic                            tniu_noc_penable    ,
    output logic [APB_ADDR_WIDTH-1:0]       tniu_noc_paddr      ,
    output logic                            tniu_noc_pwrite     ,
    output logic [31:0]                     tniu_noc_pwdata     ,
    input  logic [31:0]                     tniu_noc_prdata     ,
    input  logic                            tniu_noc_pready     ,
    output logic [3:0]                      tniu_noc_pstrb      ,
    output logic [2:0]                      tniu_noc_pprot      ,
    input  logic                            tniu_noc_pslverr    ,

    // TNIU system side — APB master array (tniu_sys)
    output logic [SYS_APB_MASTER_NUM-1:0]       tniu_sys_m_psel ,
    output logic [APB_ADDR_WIDTH-1:0]           tniu_sys_m_paddr,
    input  logic [SYS_APB_MASTER_NUM-1:0]       tniu_sys_m_pready,
    input  logic [SYS_APB_MASTER_NUM*32-1:0]    tniu_sys_m_prdata,
    input  logic [SYS_APB_MASTER_NUM-1:0]       tniu_sys_m_pslverr,
    output logic [2:0]                          tniu_sys_m_pprot,
    output logic                                tniu_sys_m_penable,
    output logic                                tniu_sys_m_pwrite,
    output logic [31:0]                         tniu_sys_m_pwdata,
    output logic [3:0]                          tniu_sys_m_pstrb,

    // -----------------------------------------------------------------
    // Debug timestamp input (chains through iniu_sys then iniu_noc)
    // -----------------------------------------------------------------
    input  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in    ,
    input  logic [DBG_DATA_WIDTH-1:0]       dbg_data_in
);

    // -----------------------------------------------------------------
    // Internal — INIU REQ AFIFO (iniu_sys write → iniu_noc read)
    // -----------------------------------------------------------------
    logic [INIU_FIFO_DEPTH-1:0]     iniu_req_wptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]     iniu_req_rptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]     iniu_req_rptr_sync  ;
    logic [REQ_PLD_WIDTH+1:0]       iniu_req_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — INIU RSP AFIFO (iniu_noc write → iniu_sys read)
    // -----------------------------------------------------------------
    logic [INIU_FIFO_DEPTH-1:0]     iniu_rsp_wptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]     iniu_rsp_rptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]     iniu_rsp_rptr_sync  ;
    logic [RSP_PLD_WIDTH+1:0]       iniu_rsp_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — TNIU REQ AFIFO (tniu_noc write → tniu_sys read)
    // -----------------------------------------------------------------
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_req_wptr_async ;
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_req_rptr_async ;
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_req_rptr_sync  ;
    logic [REQ_PLD_WIDTH+1:0]          tniu_req_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — TNIU RSP AFIFO (tniu_sys write → tniu_noc read)
    // -----------------------------------------------------------------
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_rsp_wptr_async ;
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_rsp_rptr_async ;
    logic [TNIU_ASYNC_FIFO_DEPTH-1:0]  tniu_rsp_rptr_sync  ;
    logic [RSP_PLD_WIDTH+1:0]          tniu_rsp_pld_sync   ;

    // Tie-off debug/CTI chains (unused in this example wrapper)
    logic [CTI_EVENT_WIDTH-1:0]     cti_unused          ;
    logic [DBG_TIMESTAMP_WIDTH-1:0] ts_iniu_sys_out     ;
    logic [DBG_TIMESTAMP_WIDTH-1:0] ts_iniu_noc_out     ;
    logic [DBG_TIMESTAMP_WIDTH-1:0] ts_tniu_noc_out     ;
    logic [DBG_DATA_WIDTH-1:0]      dbg_iniu_sys_out    ;
    logic [DBG_DATA_WIDTH-1:0]      dbg_iniu_noc_out    ;
    logic [DBG_DATA_WIDTH-1:0]      dbg_tniu_noc_out    ;

    // -----------------------------------------------------------------
    // u_iniu_sys : AXI slave (clk_sys) — REQ AFIFO write, RSP AFIFO read
    // clk_src = clk_sys (AXI domain), clk_dst = clk_noc (NOC domain)
    // -----------------------------------------------------------------
    `_PREFIX_(sts_iniu_sys) #(
        .DBG_TIMESTAMP_WIDTH    (DBG_TIMESTAMP_WIDTH    ),
        .DBG_DATA_WIDTH         (DBG_DATA_WIDTH         ),
        .FIFO_DEPTH             (INIU_FIFO_DEPTH        ),
        .SYNC_STAGE             (SYNC_STAGE             ),
        .NODE_NUM               (NODE_NUM               ),
        .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM     ),
        .ADDR_MAP_BASE_TABLE    (ADDR_MAP_BASE_TABLE    ),
        .ADDR_MAP_MASK_TABLE    (ADDR_MAP_MASK_TABLE    ),
        .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE  ),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID)
    ) u_iniu_sys (
        .clk_src            (clk_sys            ),
        .clk_dst            (clk_noc            ),
        .rstn_src           (rstn_sys           ),
        .rstn_dst           (rstn_noc           ),
        // NOC topology
        .node_id            (node_id            ),
        .flow_ctrl_busy     (flow_ctrl_busy     ),
        .flow_ctrl_update   (flow_ctrl_update   ),
        // AXI slave
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
        // REQ AFIFO write side (internal)
        .req_wptr_async     (iniu_req_wptr_async),
        .req_rptr_async     (iniu_req_rptr_async),
        .req_rptr_sync      (iniu_req_rptr_sync ),
        .req_pld_sync       (iniu_req_pld_sync  ),
        // RSP AFIFO read side (internal)
        .rsp_wptr_async     (iniu_rsp_wptr_async),
        .rsp_rptr_async     (iniu_rsp_rptr_async),
        .rsp_rptr_sync      (iniu_rsp_rptr_sync ),
        .rsp_pld_sync       (iniu_rsp_pld_sync  ),
        // CTI: tie off
        .cti_event_in       ('0                 ),
        .cti_event_in_req   (/* unused */       ),
        .cti_event_in_ack   ('0                 ),
        .cti_event_out      (/* unused */       ),
        .cti_event_out_req  ('0                 ),
        .cti_event_out_ack  (/* unused */       ),
        .cti_channel_in     ('0                 ),
        .cti_channel_in_req (/* unused */       ),
        .cti_channel_in_ack ('0                 ),
        .cti_channel_out    (/* unused */       ),
        .cti_channel_out_req('0                 ),
        .cti_channel_out_ack(/* unused */       ),
        // DBG
        .dbg_timestamp_in   (dbg_timestamp_in   ),
        .dbg_timestamp_out  (ts_iniu_sys_out    ),
        .dbg_data_in        (dbg_data_in        ),
        .dbg_data_out       (dbg_iniu_sys_out   )
    );

    // -----------------------------------------------------------------
    // u_iniu_noc : REQ AFIFO read, RSP AFIFO write (clk_noc=clk_dst)
    // clk_dst = clk_noc (NOC domain), clk_src = clk_sys (AXI domain)
    // -----------------------------------------------------------------
    `_PREFIX_(sts_iniu_noc) #(
        .DBG_TIMESTAMP_WIDTH(DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (DBG_DATA_WIDTH     ),
        .FIFO_DEPTH         (INIU_FIFO_DEPTH    ),
        .SYNC_STAGE         (SYNC_STAGE         )
    ) u_iniu_noc (
        .clk_dst            (clk_noc            ),
        .rst_n_dst          (rstn_noc           ),
        .clk_src            (clk_sys            ),
        .rst_n_src          (rstn_sys           ),
        // REQ AFIFO read side (internal)
        .req_wptr_async     (iniu_req_wptr_async),
        .req_rptr_async     (iniu_req_rptr_async),
        .req_rptr_sync      (iniu_req_rptr_sync ),
        .req_pld_sync       (iniu_req_pld_sync  ),
        // RSP AFIFO write side (internal)
        .rsp_wptr_async     (iniu_rsp_wptr_async),
        .rsp_rptr_async     (iniu_rsp_rptr_async),
        .rsp_rptr_sync      (iniu_rsp_rptr_sync ),
        .rsp_pld_sync       (iniu_rsp_pld_sync  ),
        // NOC ring REQ output
        .req_s_vld          (noc_req_s_vld      ),
        .req_s_rdy          (noc_req_s_rdy      ),
        .req_s_pld          (noc_req_s_pld      ),
        // NOC ring RSP input
        .rsp_m_vld          (noc_rsp_m_vld      ),
        .rsp_m_rdy          (noc_rsp_m_rdy      ),
        .rsp_m_pld          (noc_rsp_m_pld      ),
        // CTI: tie off
        .cti_event_in       ('0                 ),
        .cti_event_in_req   (/* unused */       ),
        .cti_event_in_ack   ('0                 ),
        .cti_event_out      (/* unused */       ),
        .cti_event_out_req  ('0                 ),
        .cti_event_out_ack  (/* unused */       ),
        .cti_channel_in     ('0                 ),
        .cti_channel_in_req (/* unused */       ),
        .cti_channel_in_ack ('0                 ),
        .cti_channel_out    (/* unused */       ),
        .cti_channel_out_req('0                 ),
        .cti_channel_out_ack(/* unused */       ),
        // DBG
        .dbg_timestamp_in   (ts_iniu_sys_out    ),
        .dbg_timestamp_out  (ts_iniu_noc_out    ),
        .dbg_data_in        (dbg_iniu_sys_out   ),
        .dbg_data_out       (dbg_iniu_noc_out   )
    );

    // -----------------------------------------------------------------
    // u_tniu_noc : NOC ring input → TNIU REQ AFIFO write, RSP AFIFO read
    // clk_src = clk_noc (NOC domain), clk_dst = clk_sys (APB domain)
    // -----------------------------------------------------------------
    `_PREFIX_(sts_tniu_noc) #(
        .DBG_TIMESTAMP_WIDTH(DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (DBG_DATA_WIDTH     ),
        .APB_ADDR_WIDTH     (APB_ADDR_WIDTH     ),
        .SYNC_STAGE         (SYNC_STAGE         ),
        .ASYNC_FIFO_DEPTH   (TNIU_ASYNC_FIFO_DEPTH),
        .FIFO_DEPTH         (TNIU_FIFO_DEPTH    )
    ) u_tniu_noc (
        .clk_src            (clk_noc            ),
        .clk_dst            (clk_sys            ),
        .rstn_src           (rstn_noc           ),
        .rstn_dst           (rstn_sys           ),
        // NOC ring REQ input
        .in_req_vld         (noc_in_req_vld     ),
        .in_req_rdy         (noc_in_req_rdy     ),
        .in_req_pld         (noc_in_req_pld     ),
        // NOC ring RSP output
        .out_rsp_vld        (noc_out_rsp_vld    ),
        .out_rsp_rdy        (noc_out_rsp_rdy    ),
        .out_rsp_pld        (noc_out_rsp_pld    ),
        // REQ AFIFO write side (internal)
        .req_wptr_async     (tniu_req_wptr_async),
        .req_rptr_async     (tniu_req_rptr_async),
        .req_rptr_sync      (tniu_req_rptr_sync ),
        .req_pld_sync       (tniu_req_pld_sync  ),
        // RSP AFIFO read side (internal)
        .rsp_wptr_async     (tniu_rsp_wptr_async),
        .rsp_rptr_async     (tniu_rsp_rptr_async),
        .rsp_rptr_sync      (tniu_rsp_rptr_sync ),
        .rsp_pld_sync       (tniu_rsp_pld_sync  ),
        // Write stall/clear
        .write_stall        (write_stall        ),
        .write_clear        (write_clear        ),
        .write_full_zero    (write_full_zero    ),
        // APB master (downstream from tniu_noc regbank)
        .psel               (tniu_noc_psel      ),
        .penable            (tniu_noc_penable   ),
        .paddr              (tniu_noc_paddr     ),
        .pwrite             (tniu_noc_pwrite    ),
        .pwdata             (tniu_noc_pwdata    ),
        .prdata             (tniu_noc_prdata    ),
        .pready             (tniu_noc_pready    ),
        .pstrb              (tniu_noc_pstrb     ),
        .pprot              (tniu_noc_pprot     ),
        .pslverr            (tniu_noc_pslverr   ),
        // CTI: tie off
        .cti_event_in       ('0                 ),
        .cti_event_in_req   (/* unused */       ),
        .cti_event_in_ack   ('0                 ),
        .cti_event_out      (/* unused */       ),
        .cti_event_out_req  ('0                 ),
        .cti_event_out_ack  (/* unused */       ),
        .cti_channel_in     ('0                 ),
        .cti_channel_in_req (/* unused */       ),
        .cti_channel_in_ack ('0                 ),
        .cti_channel_out    (/* unused */       ),
        .cti_channel_out_req('0                 ),
        .cti_channel_out_ack(/* unused */       ),
        // DBG
        .dbg_timestamp_in   (ts_iniu_noc_out    ),
        .dbg_timestamp_out  (ts_tniu_noc_out    ),
        .dbg_data_in        (dbg_iniu_noc_out   ),
        .dbg_data_out       (dbg_tniu_noc_out   )
    );

    // -----------------------------------------------------------------
    // u_tniu_sys : TNIU REQ AFIFO read, RSP AFIFO write (clk_sys=clk_dst)
    // clk_src = clk_noc, clk_dst = clk_sys
    // -----------------------------------------------------------------
    `_PREFIX_(sts_tniu_sys) #(
        .DBG_TIMESTAMP_WIDTH    (DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH         (DBG_DATA_WIDTH     ),
        .APB_ADDR_WIDTH         (APB_ADDR_WIDTH     ),
        .SYNC_STAGE             (SYNC_STAGE         ),
        .ASYNC_FIFO_DEPTH       (TNIU_ASYNC_FIFO_DEPTH),
        .SYS_APB_MASTER_NUM     (SYS_APB_MASTER_NUM ),
        .SYS_APB_ROUTE_BASE     (SYS_APB_ROUTE_BASE ),
        .SYS_APB_ROUTE_MASK     (SYS_APB_ROUTE_MASK )
    ) u_tniu_sys (
        .clk_src            (clk_noc            ),
        .clk_dst            (clk_sys            ),
        .clk_dbg_timer      (clk_dbg_timer      ),
        .rstn_src           (rstn_noc           ),
        .rstn_dst           (rstn_sys           ),
        .rstn_dbg_timer     (rstn_dbg_timer     ),
        // REQ AFIFO read side (internal)
        .req_wptr_async     (tniu_req_wptr_async),
        .req_rptr_async     (tniu_req_rptr_async),
        .req_rptr_sync      (tniu_req_rptr_sync ),
        .req_pld_sync       (tniu_req_pld_sync  ),
        // RSP AFIFO write side (internal)
        .rsp_wptr_async     (tniu_rsp_wptr_async),
        .rsp_rptr_async     (tniu_rsp_rptr_async),
        .rsp_rptr_sync      (tniu_rsp_rptr_sync ),
        .rsp_pld_sync       (tniu_rsp_pld_sync  ),
        // APB master array
        .m_psel             (tniu_sys_m_psel    ),
        .m_paddr            (tniu_sys_m_paddr   ),
        .m_pready           (tniu_sys_m_pready  ),
        .m_prdata           (tniu_sys_m_prdata  ),
        .m_pslverr          (tniu_sys_m_pslverr ),
        .m_pprot            (tniu_sys_m_pprot   ),
        .m_penable          (tniu_sys_m_penable ),
        .m_pwrite           (tniu_sys_m_pwrite  ),
        .m_pwdata           (tniu_sys_m_pwdata  ),
        .m_pstrb            (tniu_sys_m_pstrb   ),
        // CTI: tie off
        .cti_event_in       ('0                 ),
        .cti_event_in_req   (/* unused */       ),
        .cti_event_in_ack   ('0                 ),
        .cti_event_out      (/* unused */       ),
        .cti_event_out_req  ('0                 ),
        .cti_event_out_ack  (/* unused */       ),
        .cti_channel_in     ('0                 ),
        .cti_channel_in_req (/* unused */       ),
        .cti_channel_in_ack ('0                 ),
        .cti_channel_out    (/* unused */       ),
        .cti_channel_out_req('0                 ),
        .cti_channel_out_ack(/* unused */       ),
        // DBG
        .dbg_data_in        (dbg_tniu_noc_out   ),
        .dbg_data_out       (/* unused */       ),
        .dbg_timestamp_in   (ts_tniu_noc_out    ),
        .dbg_timestamp_out  (/* unused */       )
    );

endmodule

module sts_demo_tniu0_sts_tniu_sys
import sts_demo_tniu0_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32,
    parameter integer unsigned APB_ADDR_WIDTH      = 32,
    parameter integer unsigned SYNC_STAGE           = 2,
    parameter integer unsigned ASYNC_FIFO_DEPTH     = 4,
    parameter integer unsigned SYS_APB_MASTER_NUM   = 2,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_BASE = '0,
    parameter logic [SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_MASK = '0,
    localparam int REQ_PLD_WIDTH = $bits(sts_req_typ),
    localparam int RSP_PLD_WIDTH = $bits(sts_rsp_typ)
) (
    input   logic   clk_src ,
    input   logic   clk_dst ,
    input   logic   clk_dbg_timer,
    input   logic   rstn_src,
    input   logic   rstn_dst,
    input   logic   rstn_dbg_timer,
    //============================================================
    // async bridge signal with tniu noc side
    //============================================================
    // request sync
    input   logic [ASYNC_FIFO_DEPTH-1:0]    req_wptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]    req_rptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]    req_rptr_sync   ,
    input   logic [REQ_PLD_WIDTH+1:0]       req_pld_sync    ,

    // response sync
    output  logic [ASYNC_FIFO_DEPTH-1:0]    rsp_wptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]    rsp_rptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]    rsp_rptr_sync   ,
    output  logic [RSP_PLD_WIDTH+1:0]       rsp_pld_sync    ,

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

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out

);

    // req to APB TNIU in sys side
    logic                       req_apb_tniu_vld;
    logic                       req_apb_tniu_rdy;
    sts_req_typ                 req_apb_tniu_pld;
    sts_req_typ                 req_apb_tniu_pld_tmp;
    logic                       req_apb_tniu_last;

    // rsp from APB TNIU in sys side
    logic                       rsp_apb_tniu_vld;
    logic                       rsp_apb_tniu_rdy;
    sts_rsp_typ                 rsp_apb_tniu_pld;
    sts_rsp_typ                 rsp_async_fifo_pld_tmp;
    logic                       rsp_async_fifo_last;
    logic                       psel_pre_dec;
    logic                       penable_pre_dec;
    logic [APB_ADDR_WIDTH-1:0]  paddr_pre_dec;
    logic [TGT_ID_WIDTH-1:0]    ptgt_pre_dec;
    logic                       pwrite_pre_dec;
    logic [31:0]                pwdata_pre_dec;
    logic [31:0]                prdata_pre_dec;
    logic                       pready_pre_dec;
    logic [3:0]                 pstrb_pre_dec;
    logic [2:0]                 pprot_pre_dec;
    logic                       pslver_pre_dec;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;

    fcip_req_rsp_afifo_mst #(
        .REQ_WIDTH      (REQ_PLD_WIDTH),
        .RSP_WIDTH      (RSP_PLD_WIDTH),
        .FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_tniu_sys_afifo_mst (
        .clk            (clk_dst),
        .rst_n          (rstn_dst),
        .req_s_vld      (req_apb_tniu_vld  ),
        .req_s_rdy      (req_apb_tniu_rdy),
        .req_s_pld      (req_apb_tniu_pld_tmp),
        .req_s_last     (req_apb_tniu_last),
        .rsp_m_vld      (rsp_apb_tniu_vld),
        .rsp_m_rdy      (rsp_apb_tniu_rdy),
        .rsp_m_pld      (rsp_async_fifo_pld_tmp),
        .rsp_m_last     (rsp_async_fifo_last),
        .req_wptr_async (req_wptr_async),
        .req_rptr_async (req_rptr_async),
        .req_rptr_sync  (req_rptr_sync ),
        .req_pld_sync   (req_pld_sync  ),
        .rsp_wptr_async (rsp_wptr_async),
        .rsp_rptr_async (rsp_rptr_async),
        .rsp_rptr_sync  (rsp_rptr_sync ),
        .rsp_pld_sync   (rsp_pld_sync  )
    );

    assign req_apb_tniu_pld       = req_apb_tniu_pld_tmp;
    assign rsp_async_fifo_pld_tmp = rsp_apb_tniu_pld;
    assign rsp_async_fifo_last    = rsp_apb_tniu_pld.rsp.last;

    sts_demo_tniu0_sts_tniu_apb u_sts_tniu_apb_sys (
        .clk            (clk_dst          ),
        .rst_n          (rstn_dst         ),
        .in_req_vld     (req_apb_tniu_vld ),
        .in_req_pld     (req_apb_tniu_pld ),
        .in_req_rdy     (req_apb_tniu_rdy ),
        .out_rsp_vld    (rsp_apb_tniu_vld ),
        .out_rsp_pld    (rsp_apb_tniu_pld ),
        .out_rsp_rdy    (rsp_apb_tniu_rdy ),
        .ptgt_id        (ptgt_pre_dec     ),
        .psel           (psel_pre_dec     ),
        .penable        (penable_pre_dec  ),
        .paddr          (paddr_pre_dec    ),
        .pwrite         (pwrite_pre_dec   ),
        .pwdata         (pwdata_pre_dec   ),
        .prdata         (prdata_pre_dec   ),
        .pready         (pready_pre_dec   ),
        .pstrb          (pstrb_pre_dec    ),
        .pprot          (pprot_pre_dec    ),
        .pslverr        (pslver_pre_dec   )
    );

    sts_demo_tniu0_sts_tniu_apb_dec #(
        .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
        .MASTER_NUM    (SYS_APB_MASTER_NUM),
        .ROUTE_BASE    (SYS_APB_ROUTE_BASE),
        .ROUTE_MASK    (SYS_APB_ROUTE_MASK)
    ) u_sts_tniu_apb_dec (
        .clk            (clk_dst            ),
        .rst_n          (rstn_dst           ),
        .s_psel         (psel_pre_dec       ),
        .s_penable      (penable_pre_dec    ),
        .s_paddr        (paddr_pre_dec      ),
        .s_ptgt_id      (ptgt_pre_dec       ),
        .s_pwrite       (pwrite_pre_dec     ),
        .s_pwdata       (pwdata_pre_dec     ),
        .s_prdata       (prdata_pre_dec     ),
        .s_pready       (pready_pre_dec     ),
        .s_pstrb        (pstrb_pre_dec      ),
        .s_pprot        (pprot_pre_dec      ),
        .s_pslverr      (pslver_pre_dec     ),
        .m_psel         (m_psel             ),
        .m_paddr        (m_paddr            ),
        .m_pready       (m_pready           ),
        .m_prdata       (m_prdata           ),
        .m_pslverr      (m_pslverr          ),
        .m_pprot        (m_pprot            ),
        .m_penable      (m_penable          ),
        .m_pwrite       (m_pwrite           ),
        .m_pwdata       (m_pwdata           ),
        .m_pstrb        (m_pstrb            )
    );

    // assign dbg_data_out = dbg_data_in;

    // ts_gray2bin #(
    //     .N       (DBG_TIMESTAMP_WIDTH),
    //     .REG_OUT (1)
    // ) u_ts_gray2bin (
    //     .clk    (clk_src    ),
    //     .rst_n  (rstn_src   ),
    //     .gray   (dbg_timestamp_in   ),
    //     .bin    (dbg_timestamp_tmp  )
    // );

    fcip_marker #(
        .DATA_WIDTH(DBG_DATA_WIDTH)
    ) u_debug_data_marker (
        .I(dbg_data_in ),
        .Z(dbg_data_out)
    );

    fcip_marker #(
        .DATA_WIDTH(DBG_TIMESTAMP_WIDTH)
    ) u_timestamp_marker (
        .I(dbg_timestamp_in ),
        .Z(dbg_timestamp_tmp)
    );

    fcip_sync_cell #(
        .DATA_WIDTH  (DBG_TIMESTAMP_WIDTH),
        .SYN_STAGE   (SYNC_STAGE), // must upper than 1
        .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
        .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
    ) u_dbg_ts_sync (
        .clk         (clk_dbg_timer   ),
        .rst_n       (rstn_dbg_timer  ),
        .d           (dbg_timestamp_tmp),
        .q           (dbg_timestamp_out)
    );

    sts_demo_tniu0_cti_handle #(
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

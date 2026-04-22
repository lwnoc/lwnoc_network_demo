module ddr0_tniu_sts_tniu_noc
import ddr0_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH  = 64,
    parameter integer unsigned DBG_DATA_WIDTH       = 32,
    parameter integer unsigned APB_ADDR_WIDTH       = 32,
    parameter integer unsigned SYNC_STAGE           = 2,
    parameter integer unsigned ASYNC_FIFO_DEPTH     = 4,
    parameter integer unsigned FIFO_DEPTH           = 16,
    parameter integer unsigned TGT_TYPE_WIDTH       = 2,
    parameter logic [TGT_TYPE_WIDTH-1:0] LOCAL_APB_TGT_TYPE = 2'b01,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_RSC_TGT_ID = '0,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_ID = 'd1,
    localparam int REQ_PLD_WIDTH = $bits(sts_req_typ),
    localparam int RSP_PLD_WIDTH = $bits(sts_rsp_typ)
) (
    input   logic   clk_src ,
    input   logic   clk_dst ,
    input   logic   rstn_src,
    input   logic   rstn_dst,

    //============================================================
    // vld/rdy/pld with noc side dec/iniu
    //============================================================
    input   logic               in_req_vld,
    output  logic               in_req_rdy,
    input   sts_req_typ         in_req_pld,

    output  logic               out_rsp_vld,
    input   logic               out_rsp_rdy,
    output  sts_rsp_typ         out_rsp_pld,
    //============================================================
    // async bridge signal with tniu sys side
    //============================================================
    output  logic [ASYNC_FIFO_DEPTH-1:0]   req_wptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]   req_rptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]   req_rptr_sync   ,
    output  logic [REQ_PLD_WIDTH+1:0]      req_pld_sync    ,

    input   logic [ASYNC_FIFO_DEPTH-1:0]   rsp_wptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]   rsp_rptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]   rsp_rptr_sync   ,
    input   logic [RSP_PLD_WIDTH+1:0]      rsp_pld_sync    ,

    //============================================================
    // APB with PMC
    //============================================================
    output  logic                  psel,
    output  logic                  penable,
    output  logic [APB_ADDR_WIDTH-1:0] paddr,
    output  logic                  pwrite,
    output  logic [31:0]           pwdata,
    input   logic [31:0]           prdata,
    input   logic                  pready,
    output  logic [3:0]            pstrb,
    output  logic [2:0]            pprot,
    input   logic                  pslverr,

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in    ,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out   ,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in   ,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out  ,

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

    ///============================================================
    // Static Signal
    //=============================================================
    output  logic [31:0] timing_bus1,
    output  logic [31:0] timing_bus2,
    output  logic [31:0] timing_bus3,
    output  logic [31:0] dbg_en

);

    // req to control apb slaves in tniu noc side
    logic                   req_apb_tniu_vld;
    sts_req_typ             req_apb_tniu_pld;
    logic                   req_apb_tniu_rdy;
    // rsp from control apb slaves in tniu noc side
    logic                   rsp_apb_tniu_vld;
    sts_rsp_typ             rsp_apb_tniu_pld;
    logic                   rsp_apb_tniu_rdy;
    // req to tniu sys side
    logic                   req_tniu_sys_vld;
    sts_req_typ             req_tniu_sys_pld;
    logic                   req_tniu_sys_rdy;
    // rsp from tniu sys side
    logic                   rsp_tniu_sys_vld;
    sts_rsp_typ             rsp_tniu_sys_pld;
    logic                   rsp_tniu_sys_rdy;

    logic [1:0]                 v_arb_rsp_vld;
    logic [1:0]                 v_arb_rsp_rdy;
    logic [RSP_PLD_WIDTH-1:0]   v_arb_rsp_pld[1:0];

    logic                       req_async_fifo_vld;
    sts_req_typ                 req_async_fifo_pld;
    logic                       req_async_fifo_rdy;
    sts_req_typ                 req_async_fifo_pld_tmp;
    logic                       req_async_fifo_last;

    logic [REQ_PLD_WIDTH-1:0]   out_req_pld_tmp ;
    logic                       out_req_last_tmp;

    logic                       psel_pre_dec    ;
    logic                       penable_pre_dec ;
    logic [APB_ADDR_WIDTH-1:0]  paddr_pre_dec   ;
    logic                       pwrite_pre_dec  ;
    logic [31:0]                pwdata_pre_dec  ;
    logic [31:0]                prdata_pre_dec  ;
    logic                       pready_pre_dec  ;
    logic [3:0]                 pstrb_pre_dec   ;
    logic [2:0]                 pprot_pre_dec   ;
    logic                       pslverr_pre_dec  ;
    logic [TGT_ID_WIDTH-1:0]    ptgt_pre_dec    ;

    logic                       psel_reg        ;
    logic [APB_ADDR_WIDTH-1:0]  paddr_reg       ;
    logic                       pready_reg      ;
    logic [31:0]                prdata_reg      ;
    logic                       pslverr_reg     ;
    logic [2:0]                 pprot_reg       ;
    logic                       penable_reg     ;
    logic                       pwrite_reg      ;
    logic [31:0]                pwdata_reg      ;
    logic [3:0]                 pstrb_reg       ;

    logic                       psel_pre_sync   ;
    logic [APB_ADDR_WIDTH-1:0]  paddr_pre_sync  ;
    logic                       pready_pre_sync ;
    logic [31:0]                prdata_pre_sync ;
    logic                       pslverr_pre_sync;
    logic [2:0]                 pprot_pre_sync  ;
    logic                       penable_pre_sync;
    logic                       pwrite_pre_sync ;
    logic [31:0]                pwdata_pre_sync ;
    logic [3:0]                 pstrb_pre_sync  ;
    logic [2:0]                 cmn_pprot       ;
    logic                       cmn_penable     ;
    logic                       cmn_pwrite      ;
    logic [31:0]                cmn_pwdata      ;
    logic [3:0]                 cmn_pstrb       ;

    logic                       req_afifo_vld;
    sts_req_typ                 req_afifo_pld;
    logic                       req_afifo_rdy;
    logic                       rsp_afifo_vld;
    sts_rsp_typ                 rsp_afifo_pld;
    logic                       rsp_afifo_rdy;

    logic [31:0]                    dbg_data_gate;
    logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_tmp;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;
    sts_rsp_typ                     rsp_tniu_sys_pld_tmp;
    logic                           rsp_tniu_sys_last;
    logic                           req_is_local_apb;

    ///============================================================
    // Request Channel
    //=============================================================
    assign req_is_local_apb =
        (in_req_pld.cmn.tgt_id == LOCAL_RSC_TGT_ID) ||
        (in_req_pld.cmn.tgt_id == LOCAL_REGBANK_TGT_ID);

    ddr0_tniu_sts_tniu_noc_dec2 #(
        .WIDTH(REQ_PLD_WIDTH)
    ) u_tniu_noc_req_dec2 (
        .s_req_vld  (in_req_vld),
        .s_req_pld  (in_req_pld),
        .s_req_rdy  (in_req_rdy),
        .sel        (~req_is_local_apb),
        .m_req0_vld (req_apb_tniu_vld),
        .m_req0_pld (req_apb_tniu_pld),
        .m_req0_rdy (req_apb_tniu_rdy),
        .m_req1_vld (req_async_fifo_vld),
        .m_req1_pld (req_async_fifo_pld),
        .m_req1_rdy (req_async_fifo_rdy)
    );

    ddr0_tniu_sts_tniu_apb u_sts_tniu_apb_noc (
        .clk        (clk_src),
        .rst_n      (rstn_src),
        .in_req_vld  (req_apb_tniu_vld),
        .in_req_pld  (req_apb_tniu_pld),
        .in_req_rdy  (req_apb_tniu_rdy),
        .out_rsp_vld  (rsp_apb_tniu_vld),
        .out_rsp_pld  (rsp_apb_tniu_pld),
        .out_rsp_rdy  (rsp_apb_tniu_rdy),
        .psel       (psel_pre_dec     ),
        .penable    (penable_pre_dec  ),
        .paddr      (paddr_pre_dec    ),
        .ptgt_id    (ptgt_pre_dec     ),
        .pwrite     (pwrite_pre_dec   ),
        .pwdata     (pwdata_pre_dec   ),
        .prdata     (prdata_pre_dec   ),
        .pready     (pready_pre_dec   ),
        .pstrb      (pstrb_pre_dec    ),
        .pprot      (pprot_pre_dec    ),
        .pslverr    (pslverr_pre_dec  )
    );

    // packed array wires for parameterised apb_dec
    logic [1:0]                 loc_apb_m_psel;
    logic [APB_ADDR_WIDTH-1:0]  loc_apb_m_paddr;
    logic [1:0]                 loc_apb_m_pready;
    logic [63:0]                loc_apb_m_prdata;
    logic [1:0]                 loc_apb_m_pslverr;

    assign loc_apb_m_pready  = {pready_pre_sync, pready_reg};
    assign loc_apb_m_prdata  = {prdata_pre_sync, prdata_reg};
    assign loc_apb_m_pslverr = {pslverr_pre_sync, pslverr_reg};

    assign psel_reg       = loc_apb_m_psel[0];
    assign paddr_reg      = loc_apb_m_paddr;
    assign psel_pre_sync  = loc_apb_m_psel[1];
    assign paddr_pre_sync = loc_apb_m_paddr;

    ddr0_tniu_sts_tniu_apb_dec #(
        .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
        .MASTER_NUM    (2),
        .ROUTE_BASE    ({LOCAL_RSC_TGT_ID, LOCAL_REGBANK_TGT_ID}),
        .ROUTE_MASK    ({8'hFF, 8'hFF})
    ) u_sts_tniu_apb_dec (
        .clk            (clk_src            ),
        .rst_n          (rstn_src           ),
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
        .s_pslverr      (pslverr_pre_dec    ),
        .m_psel         (loc_apb_m_psel     ),
        .m_paddr        (loc_apb_m_paddr    ),
        .m_pready       (loc_apb_m_pready   ),
        .m_prdata       (loc_apb_m_prdata   ),
        .m_pslverr      (loc_apb_m_pslverr  ),
        //fanout signals
        .m_pprot        (cmn_pprot          ),
        .m_penable      (cmn_penable        ),
        .m_pwrite       (cmn_pwrite         ),
        .m_pwdata       (cmn_pwdata         ),
        .m_pstrb        (cmn_pstrb          )
    );

    assign pprot_reg    = pprot_pre_dec   ;
    assign penable_reg  = penable_pre_dec ;
    assign pwrite_reg   = pwrite_pre_dec  ;
    assign pwdata_reg   = pwdata_pre_dec  ;
    assign pstrb_reg    = pstrb_pre_dec   ;

    assign pprot_pre_sync   = pprot_pre_dec    ;
    assign penable_pre_sync = penable_pre_dec  ;
    assign pwrite_pre_sync  = pwrite_pre_dec   ;
    assign pwdata_pre_sync  = pwdata_pre_dec   ;
    assign pstrb_pre_sync   = pstrb_pre_dec    ;

    ddr0_tniu_RegSpaceBase_cfg_reg_bank_table u_regbank_sts_tniu (
        .clk            (clk_src        ),
        .rst_n          (rstn_src       ),
        .p_addr         (paddr_reg[15:0]),
        .p_sel          (psel_reg),
        .p_enable       (penable_reg),
        .p_write        (pwrite_reg),
        .p_wdata        (pwdata_reg),
        .p_strb         (pstrb_reg),
        .p_ready        (pready_reg),
        .p_rdata        (prdata_reg),
        .p_slverr       (pslverr_reg),
        .debug_en_debug_en_rdat             (dbg_en     ),
        .timing_bus1_timing_bus1_rdat       (timing_bus1),
        .timing_bus2_timing_bus2_rdat       (timing_bus2),
        .timing_bus3_timing_bus3_rdat       (timing_bus3),
        .debug_data_gate_debug_data_gate_rdat(dbg_data_gate)
    );

    apb2apb_async_bridge_qual  #(
        .ADDR_WIDTH(APB_ADDR_WIDTH),
        .SYNC_STAGE(SYNC_STAGE)
    ) u_tniu_apb_async_bridge (
        .clk_s       (clk_src),
        .rstn_s      (rstn_src),
        .clk_m       (clk_dst),
        .rstn_m      (rstn_dst),
        .psel_s      (psel_pre_sync),
        .penable_s   (penable_pre_sync),
        .paddr_s     (paddr_pre_sync),
        .pwrite_s    (pwrite_pre_sync),
        .pwdata_s    (pwdata_pre_sync),
        .prdata_s    (prdata_pre_sync),
        .pready_s    (pready_pre_sync),
        .pstrb_s     (pstrb_pre_sync),
        .pprot_s     (pprot_pre_sync),
        .pslverr_s   (pslverr_pre_sync),
        .psel_m      (psel),
        .penable_m   (penable),
        .paddr_m     (paddr),
        .pwrite_m    (pwrite),
        .pwdata_m    (pwdata),
        .prdata_m    (prdata),
        .pready_m    (pready),
        .pstrb_m     (pstrb),
        .pprot_m     (pprot),
        .pslverr_m   (pslverr)
    );

    assign req_async_fifo_pld_tmp = req_async_fifo_pld;
    assign req_async_fifo_last    = req_async_fifo_pld.req.last;

    fcip_req_rsp_afifo_slv #(
        .SYNC_STAGE     (SYNC_STAGE),
        .FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .REQ_WIDTH      (REQ_PLD_WIDTH),
        .RSP_WIDTH      (RSP_PLD_WIDTH)
    ) u_tniu_noc_afifo_slv (
        .clk            (clk_src    ),
        .rst_n          (rstn_src   ),
        .req_s_vld      (req_async_fifo_vld),
        .req_s_rdy      (req_async_fifo_rdy),
        .req_s_pld      (req_async_fifo_pld_tmp),
        .req_s_last     (req_async_fifo_last),

        .rsp_m_vld      (rsp_tniu_sys_vld),
        .rsp_m_rdy      (rsp_tniu_sys_rdy),
        .rsp_m_pld      (rsp_tniu_sys_pld_tmp),
        .rsp_m_last     (rsp_tniu_sys_last),

        .req_wptr_async (req_wptr_async),
        .req_rptr_async (req_rptr_async),
        .req_rptr_sync  (req_rptr_sync ),
        .req_pld_sync   (req_pld_sync  ),

        .rsp_wptr_async (rsp_wptr_async),
        .rsp_rptr_async (rsp_rptr_async),
        .rsp_rptr_sync  (rsp_rptr_sync ),
        .rsp_pld_sync   (rsp_pld_sync  )
    );

    //=============================================================
    // Response Channel
    //=============================================================
    assign rsp_tniu_sys_pld = rsp_tniu_sys_pld_tmp;
    assign v_arb_rsp_vld    = {rsp_apb_tniu_vld,rsp_tniu_sys_vld};
    assign v_arb_rsp_pld[0] = rsp_tniu_sys_pld;
    assign v_arb_rsp_pld[1] = rsp_apb_tniu_pld;
    assign rsp_apb_tniu_rdy = v_arb_rsp_rdy[1];
    assign rsp_tniu_sys_rdy = v_arb_rsp_rdy[0];

    fcip_arb_vrp #(
        .MODE     (1),
        .HSK_MODE (0),
        .WIDTH    (2),
        .PLD_WIDTH(RSP_PLD_WIDTH)
    ) u_tniu_noc_rsp_arb2 (
        .clk     ( clk_src          ),
        .rst_n   ( rstn_src         ),
        .v_vld_s ( v_arb_rsp_vld    ),
        .v_rdy_s ( v_arb_rsp_rdy    ),
        .v_pld_s ( v_arb_rsp_pld    ),
        .vld_m   ( out_rsp_vld      ),
        .rdy_m   ( out_rsp_rdy      ),
        .pld_m   ( out_rsp_pld      )
    );


    //============================================================
    // Debug Data Gate
    //============================================================
    assign dbg_data_out_tmp = dbg_data_gate[0] ? dbg_data_in : '0;

    fcip_marker #(
        .DATA_WIDTH(DBG_DATA_WIDTH)
    ) u_debug_data_marker (
        .I(dbg_data_out_tmp),
        .Z(dbg_data_out)
    );

    always_ff @(posedge clk_src or negedge rstn_src) begin
        if (!rstn_src) begin
            dbg_timestamp_tmp <= '0;
        end else begin
            dbg_timestamp_tmp <= dbg_timestamp_in;
        end
    end

    fcip_marker #(
        .DATA_WIDTH(DBG_TIMESTAMP_WIDTH)
    ) u_timestamp_marker (
        .I(dbg_timestamp_tmp),
        .Z(dbg_timestamp_out)
    );

    ddr0_tniu_cti_handle #(
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

module sts_noc_display_ss_tniu_sts_tniu_noc
import sts_noc_display_ss_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH  = `sts_noc_display_ss_tniu_STS_TNIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH       = `sts_noc_display_ss_tniu_STS_TNIU_DBG_DATA_WIDTH,
    parameter integer unsigned APB_ADDR_WIDTH       = `sts_noc_display_ss_tniu_STS_TNIU_APB_ADDR_WIDTH,
    parameter integer unsigned SYNC_STAGE           = `sts_noc_display_ss_tniu_STS_TNIU_SYNC_STAGE,
    parameter integer unsigned ASYNC_FIFO_DEPTH     = `sts_noc_display_ss_tniu_STS_TNIU_ASYNC_FIFO_DEPTH,
    parameter integer unsigned FIFO_DEPTH           = `sts_noc_display_ss_tniu_STS_TNIU_FIFO_DEPTH,
    parameter integer unsigned TGT_TYPE_WIDTH       = `sts_noc_display_ss_tniu_STS_TNIU_TGT_TYPE_WIDTH,
    parameter logic [TGT_TYPE_WIDTH-1:0] LOCAL_APB_TGT_TYPE = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_APB_TGT_TYPE,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_INIU_CTI_TGT_ID = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_INIU_CTI_TGT_MASK = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_MASK,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_ID = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_REGBANK_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_REGBANK_TGT_MASK = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_REGBANK_TGT_MASK,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_CTI_TGT_ID = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_CTI_TGT_ID,
    parameter logic [TGT_ID_WIDTH-1:0]   LOCAL_CTI_TGT_MASK = `sts_noc_display_ss_tniu_STS_TNIU_LOCAL_CTI_TGT_MASK,
    parameter logic                      HAS_INIU_CTI_APB   = `sts_noc_display_ss_tniu_STS_TNIU_HAS_INIU_CTI_APB,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = `sts_noc_display_ss_tniu_STS_TNIU_ERR_INT_CNT_WIDTH,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_CODE_WIDTH = (($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH)) ? $clog2(STS_REQ_WIDTH) : $clog2(STS_REQ_WIDTH)+1),
    localparam int RSP_ECC_CODE_WIDTH = (($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH)) ? $clog2(STS_RSP_WIDTH) : $clog2(STS_RSP_WIDTH)+1),
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_CODE_WIDTH + 1,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_CODE_WIDTH + 1
) (
    input   logic   clk_src ,
    input   logic   rstn_src,

    //============================================================
    // vld/rdy/pld with noc side dec/iniu
    //============================================================
    input   logic               in_req_vld,
    output  logic               in_req_rdy,
    input  [REQ_PLD_WIDTH-1:0]  in_req_pld,

    output  logic               out_rsp_vld,
    input   logic               out_rsp_rdy,
    output [RSP_PLD_WIDTH-1:0] out_rsp_pld,
    //============================================================
    // async bridge signal with tniu sys side
    //============================================================
    output  logic [ASYNC_FIFO_DEPTH-1:0]   req_wptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]   req_rptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]   req_rptr_sync   ,
    output  logic [REQ_AFIFO_W+1:0]        req_pld_sync    ,

    input   logic [ASYNC_FIFO_DEPTH-1:0]   rsp_wptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]   rsp_rptr_async  ,
    output  logic [ASYNC_FIFO_DEPTH-1:0]   rsp_rptr_sync   ,
    input   logic [RSP_AFIFO_W+1:0]        rsp_pld_sync    ,

    //============================================================
    // INIU CTI APB — direct passthrough (clk_src domain, to INIU noc-side CTI)
    // Gated by HAS_INIU_CTI_APB: when 0, internal default_slv absorbs transactions
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

    input   logic [RESERVE_WIDTH-1:0]        reserved_bits_in,
    output  logic [RESERVE_WIDTH-1:0]        reserved_bits_out,

    // CTI — level event I/O (CDC in tniu_top) + channel (to/from dec_node CTM)
    //   sys_* ports connect toward sys side (via CDC in sts_tniu_top)
    //   Forward lane:  sys_side_cti_trigin / sys_side_cti_trigin_ack
    //   Reverse lane:  sys_side_cti_trigout / sys_side_cti_trigout_ack
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigin,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigin_ack,
    output  logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigout,
    input   logic [CTI_EVENT_WIDTH-1:0]     sys_side_cti_trigout_ack,
    input   logic [CHANNEL_TOTAL_WIDTH-1:0] ctm_channel_in,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0] ctm_channel_out,

    // CTM — level event (from CTM direct, CDC in top), bypasses sts_cti
    //   sys_* ports connect toward sys side (via CDC in sts_tniu_top)
    //   Forward lane:  sys_side_ctm_trigin / sys_side_ctm_trigin_ack
    //   Reverse lane:  sys_side_ctm_trigout / sys_side_ctm_trigout_ack
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigin,
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigin_ack,
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigout,
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_side_ctm_trigout_ack,

    ///============================================================
    // Static Signal
    //=============================================================
    output  logic [31:0] timing_bus1,
    output  logic [31:0] timing_bus2,
    output  logic [31:0] timing_bus3,
    output  logic [31:0] dbg_en,
    output  logic [9:0]  hw_dbg_sel,
    output  logic        tniu_regbank_parity_err,
    output  logic        rsp_afifo_sb_err,
    output  logic        rsp_afifo_db_err
);

    // Boundary cast: top-level vector ↔ internal struct
    sts_req_typ  in_req_pld_s;
    sts_rsp_typ  out_rsp_pld_s;

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
    logic [REQ_AFIFO_W-1:0]     req_async_fifo_pld_ecc;
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
    logic [RSP_AFIFO_W-1:0]         rsp_tniu_sys_pld_ecc;
    sts_rsp_typ                     rsp_tniu_sys_pld_tmp;
    logic                           rsp_tniu_sys_last;
    logic                           req_is_local_apb;
    logic                           req_match_local_iniu_cti;
    logic                           req_match_local_regbank;
    logic                           req_match_local_cti;
    logic                           rsp_sb_err_raw;
    logic                           rsp_db_err_raw;
    logic [2:0]                     loc_apb_m_psel;
    logic [APB_ADDR_WIDTH-1:0]      loc_apb_m_paddr;
    logic [2:0]                     loc_apb_m_pready;
    logic [95:0]                    loc_apb_m_prdata;
    logic [2:0]                     loc_apb_m_pslverr;
    logic                           cti_pready;
    logic [31:0]                    cti_prdata;
    logic                           cti_pslverr;
    logic                           cti_psel;
    logic                           parity_sw_check_err;
    logic                           regbank_parity_err_raw;
    logic                           debug_en_parity_hw_check_err;
    logic                           timing_bus1_parity_hw_check_err;
    logic                           timing_bus2_parity_hw_check_err;
    logic                           timing_bus3_parity_hw_check_err;
    logic                           debug_data_gate_parity_hw_check_err;
    logic                           hw_dbg_sel_parity_hw_check_err;
    logic [31:0]                    hw_dbg_sel_cfg;
    localparam int                  CHANNEL_TOTAL_W = CHANNEL_TOTAL_WIDTH;
    logic [CTI_EVENT_WIDTH-1:0]     cti_ev_in_pulse;
    logic [CTI_EVENT_WIDTH-1:0]     cti_ev_out_pulse;
    logic [CTI_EVENT_WIDTH-1:0]     cti_ev_out_req;
    logic [CTM_TRIG_WIDTH-1:0]      ctm_ev_in_pulse;
    logic [CTM_TRIG_WIDTH-1:0]      ctm_ev_out_pulse;
    logic [CTM_TRIG_WIDTH-1:0]      ctm_ev_out_req;

    assign in_req_pld_s = sts_req_typ'(in_req_pld);
    assign out_rsp_pld  = RSP_PLD_WIDTH'(out_rsp_pld_s);

    ///============================================================
    // Request Channel
    //=============================================================
    assign req_match_local_iniu_cti =
        (in_req_pld_s.cmn.tgt_id & LOCAL_INIU_CTI_TGT_MASK) ==
        (LOCAL_INIU_CTI_TGT_ID & LOCAL_INIU_CTI_TGT_MASK);
    assign req_match_local_regbank =
        (in_req_pld_s.cmn.tgt_id & LOCAL_REGBANK_TGT_MASK) ==
        (LOCAL_REGBANK_TGT_ID & LOCAL_REGBANK_TGT_MASK);
    assign req_match_local_cti =
        (in_req_pld_s.cmn.tgt_id & LOCAL_CTI_TGT_MASK) ==
        (LOCAL_CTI_TGT_ID & LOCAL_CTI_TGT_MASK);

    assign req_is_local_apb =
        req_match_local_iniu_cti ||
        req_match_local_regbank ||
        req_match_local_cti;

    sts_noc_display_ss_tniu_sts_tniu_noc_dec2 #(
        .WIDTH(REQ_PLD_WIDTH)
    ) u_tniu_noc_req_dec2 (
        .s_req_vld  (in_req_vld),
        .s_req_pld  (in_req_pld_s),
        .s_req_rdy  (in_req_rdy),
        .sel        (~req_is_local_apb),
        .m_req0_vld (req_apb_tniu_vld),
        .m_req0_pld (req_apb_tniu_pld),
        .m_req0_rdy (req_apb_tniu_rdy),
        .m_req1_vld (req_async_fifo_vld),
        .m_req1_pld (req_async_fifo_pld),
        .m_req1_rdy (req_async_fifo_rdy)
    );

    sts_noc_display_ss_tniu_sts_tniu_apb u_sts_tniu_apb_noc (
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
    assign loc_apb_m_pready  = {pready_pre_sync, cti_pready, pready_reg};
    assign loc_apb_m_prdata  = {prdata_pre_sync, cti_prdata, prdata_reg};
    assign loc_apb_m_pslverr = {pslverr_pre_sync, cti_pslverr, pslverr_reg};

    assign psel_reg       = loc_apb_m_psel[0];   // Master[0] → REGBANK
    assign paddr_reg      = loc_apb_m_paddr;
    assign cti_psel       = loc_apb_m_psel[1];   // Master[1] → CTI
    assign psel_pre_sync  = loc_apb_m_psel[2];   // Master[2] → INIU CTI APB
    assign paddr_pre_sync = loc_apb_m_paddr;

    sts_noc_display_ss_tniu_sts_tniu_apb_dec #(
        .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
        .MASTER_NUM    (3),
        .ROUTE_BASE    ({LOCAL_INIU_CTI_TGT_ID, LOCAL_CTI_TGT_ID, LOCAL_REGBANK_TGT_ID}),
        .ROUTE_MASK    ({LOCAL_INIU_CTI_TGT_MASK, LOCAL_CTI_TGT_MASK, LOCAL_REGBANK_TGT_MASK})
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

    sts_noc_display_ss_tniu_RegSpaceBase_cfg_reg_bank_table u_regbank_sts_tniu (
        .clk            (clk_src        ),
        .rst_n          (rstn_src       ),
        .p_addr         (paddr_reg[15:0]),
        .p_sel          (psel_reg),
        .p_enable       (penable_reg),
        .p_write        (pwrite_reg),
        .p_wdata        (pwdata_reg),
        .p_ready        (pready_reg),
        .p_rdata        (prdata_reg),
        .p_slverr       (pslverr_reg),
        .debug_en_debug_en_rdat             (dbg_en     ),
        .debug_en_parity_hw_check_err       (debug_en_parity_hw_check_err),
        .timing_bus1_timing_bus1_rdat       (timing_bus1),
        .timing_bus1_parity_hw_check_err    (timing_bus1_parity_hw_check_err),
        .timing_bus2_timing_bus2_rdat       (timing_bus2),
        .timing_bus2_parity_hw_check_err    (timing_bus2_parity_hw_check_err),
        .timing_bus3_timing_bus3_rdat       (timing_bus3),
        .timing_bus3_parity_hw_check_err    (timing_bus3_parity_hw_check_err),
        .debug_data_gate_debug_data_gate_rdat(dbg_data_gate),
        .debug_data_gate_parity_hw_check_err(debug_data_gate_parity_hw_check_err),
        .hw_dbg_sel_hw_dbg_sel_rdat         (hw_dbg_sel_cfg),
        .hw_dbg_sel_parity_hw_check_err     (hw_dbg_sel_parity_hw_check_err),
        .parity_sw_check_err                (parity_sw_check_err)
    );

    assign hw_dbg_sel = hw_dbg_sel_cfg[9:0];

    assign regbank_parity_err_raw = parity_sw_check_err
                                  | debug_en_parity_hw_check_err
                                  | timing_bus1_parity_hw_check_err
                                  | timing_bus2_parity_hw_check_err
                                  | timing_bus3_parity_hw_check_err
                                  | debug_data_gate_parity_hw_check_err
                                  | hw_dbg_sel_parity_hw_check_err;

    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_parity (
        .clk(clk_src), .rst_n(rstn_src), .err_in(regbank_parity_err_raw), .intr_out(tniu_regbank_parity_err)
    );

    // INIU CTI APB: gated by HAS_INIU_CTI_APB.
    // When enabled, APB signals go directly to module ports (clk_src domain).
    // When disabled, an internal default_slv absorbs the transactions.
    generate
        if (HAS_INIU_CTI_APB) begin : g_iniu_cti_apb
            assign psel      = psel_pre_sync;
            assign penable   = penable_pre_sync;
            assign paddr     = paddr_pre_sync;
            assign pwrite    = pwrite_pre_sync;
            assign pwdata    = pwdata_pre_sync;
            assign pstrb     = pstrb_pre_sync;
            assign pprot     = pprot_pre_sync;
            assign prdata_pre_sync   = prdata;
            assign pready_pre_sync   = pready;
            assign pslverr_pre_sync  = pslverr;
        end else begin : g_iniu_cti_default_slv
            assign psel               = 1'b0;
            assign penable            = 1'b0;
            assign paddr              = '0;
            assign pwrite             = 1'b0;
            assign pwdata             = '0;
            assign pstrb              = '0;
            assign pprot              = '0;
            assign prdata_pre_sync    = '0;
            assign pready_pre_sync    = 1'b1;
            assign pslverr_pre_sync   = 1'b0;
        end
    endgenerate

    assign req_async_fifo_pld_tmp = req_async_fifo_pld;
    assign req_async_fifo_last    = req_async_fifo_pld.req.last;

    fcip_ecc_enc #(.DATA_WIDTH(STS_REQ_WIDTH)) u_req_ecc_enc (
        .data       (req_async_fifo_pld_tmp),
        .encode_data(req_async_fifo_pld_ecc)
    );

    fcip_ecc_dec #(.DATA_WIDTH(STS_RSP_WIDTH)) u_rsp_ecc_dec (
        .encode_data(rsp_tniu_sys_pld_ecc),
        .data       (rsp_tniu_sys_pld_tmp),
        .sb_err     (rsp_sb_err_raw),
        .db_err     (rsp_db_err_raw)
    );

    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_rsp_pulse_sb (
        .clk(clk_src), .rst_n(rstn_src), .err_in(rsp_sb_err_raw), .intr_out(rsp_afifo_sb_err)
    );

    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_rsp_pulse_db (
        .clk(clk_src), .rst_n(rstn_src), .err_in(rsp_db_err_raw), .intr_out(rsp_afifo_db_err)
    );

    fcip_req_rsp_afifo_slv #(
        .SYNC_STAGE     (SYNC_STAGE),
        .FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .REQ_WIDTH      (REQ_AFIFO_W),
        .RSP_WIDTH      (RSP_AFIFO_W)
    ) u_tniu_noc_afifo_slv (
        .clk            (clk_src    ),
        .rst_n          (rstn_src   ),
        .req_s_vld      (req_async_fifo_vld),
        .req_s_rdy      (req_async_fifo_rdy),
        .req_s_pld      (req_async_fifo_pld_ecc),
        .req_s_last     (req_async_fifo_last),

        .rsp_m_vld      (rsp_tniu_sys_vld),
        .rsp_m_rdy      (rsp_tniu_sys_rdy),
        .rsp_m_pld      (rsp_tniu_sys_pld_ecc),
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
        .pld_m   ( out_rsp_pld_s    )
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

    always_ff @(posedge clk_src or negedge rstn_src) begin
        if (!rstn_src) begin
            reserved_bits_out <= '0;
        end else begin
            reserved_bits_out <= reserved_bits_in;
        end
    end

    // =================================================================
    // CTI — pulse mode (EVENT_IN_LEVEL=0, SW_HANDSHAKE=0)
    // cti_trig_in (level, CDC in parent) → CTI transmitter → pulse → sts_cti
    // sts_cti.trig_out → receiver → level → cti_trig_out
    // =================================================================
    // CTM trig — bypasses sts_cti: level→pulse → ctm_channel_out upper bits
    // ctm_channel_in upper bits → pulse→level → ctm_trig_out
    // ctm_channel = {ctm_trig_pulse, cti_channel}
    // =================================================================

    // IN→CTI: level→pulse conversion via transmitter
    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTI_EVENT_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_cti_ev_in_tx (
        .clk_tx        (clk_src            ),
        .rstn_tx       (rstn_src           ),
        .pulse_out     (cti_ev_in_pulse    ),
        .pulse_req     (sys_side_cti_trigin     ),
        .pulse_ack     (sys_side_cti_trigin_ack ),
        .clk_tx_qactive(                   )
    );

    // IN→CTM: level→pulse conversion — goes directly to ctm_channel_out upper bits
    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTM_TRIG_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_ctm_ev_in_tx (
        .clk_tx        (clk_src            ),
        .rstn_tx       (rstn_src           ),
        .pulse_out     (ctm_ev_in_pulse    ),
        .pulse_req     (sys_side_ctm_trigin     ),
        .pulse_ack     (sys_side_ctm_trigin_ack ),
        .clk_tx_qactive(                   )
    );
    // sts_cti only sees CTI events (not CTM)
    sts_noc_display_ss_tniu_sts_cti #(
        .TRIG_IN_NUM    (CTI_EVENT_WIDTH   ),
        .TRIG_OUT_NUM   (CTI_EVENT_WIDTH   ),
        .CHANNEL_NUM    (CTI_CHANNEL_WIDTH ),
        .EVENT_IN_LEVEL ('0                ),  // pulse mode
        .SW_HANDSHAKE   ('0                ),  // pulse mode
        .SYNC_STAGE     (SYNC_STAGE        ),
        .APB_ADDR_WIDTH (12                )
    ) u_sts_cti (
        .clk            (clk_src                                ),
        .rst_n          (rstn_src                               ),
        .psel           (cti_psel                               ),
        .penable        (cmn_penable                            ),
        .paddr          (paddr_reg[11:0]                        ),
        .pwrite         (cmn_pwrite                             ),
        .pwdata         (cmn_pwdata                             ),
        .prdata         (cti_prdata                             ),
        .pready         (cti_pready                             ),
        .pslverr        (cti_pslverr                            ),
        .trig_in        (cti_ev_in_pulse                        ),  // CTI only
        .trig_out       (cti_ev_out_pulse                       ),
        .channel_in     (ctm_channel_in[CTI_CHANNEL_WIDTH-1:0]  ),  // lower: CTI channel
        .channel_out    (ctm_channel_out[CTI_CHANNEL_WIDTH-1:0] ),  // lower: CTI channel
        .asicctrl       (                                       )
    );

    // CTM trig in — bypasses sts_cti, goes directly into channel upper bits
    assign ctm_channel_out[CHANNEL_TOTAL_W-1 : CTI_CHANNEL_WIDTH] = ctm_ev_in_pulse;

    // CTI: sts_cti.trig_out → receiver → level

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTI_EVENT_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_cti_ev_out_rx (
        .clk_rx        (clk_src            ),
        .rstn_rx       (rstn_src           ),
        .pulse_in      (cti_ev_out_pulse   ),
        .pulse_req     (cti_ev_out_req     ),
        .pulse_ack     (sys_side_cti_trigout_ack),
        .clk_rx_qactive(                   )
    );

    assign sys_side_cti_trigout = cti_ev_out_req;

    // CTM trig out — from ctm_channel_in upper bits → receiver → level
    assign ctm_ev_out_pulse = ctm_channel_in[CHANNEL_TOTAL_W-1 : CTI_CHANNEL_WIDTH];

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTM_TRIG_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_ctm_ev_out_rx (
        .clk_rx        (clk_src            ),
        .rstn_rx       (rstn_src           ),
        .pulse_in      (ctm_ev_out_pulse   ),
        .pulse_req     (ctm_ev_out_req     ),
        .pulse_ack     (sys_side_ctm_trigout_ack),
        .clk_rx_qactive(                   )
    );

    assign sys_side_ctm_trigout = ctm_ev_out_req;

endmodule

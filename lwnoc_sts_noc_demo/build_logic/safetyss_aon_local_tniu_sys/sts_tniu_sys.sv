module sts_tniu_sys
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `STS_TNIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `STS_TNIU_DBG_DATA_WIDTH,
    parameter integer unsigned APB_ADDR_WIDTH      = `STS_TNIU_APB_ADDR_WIDTH,
    parameter integer unsigned SYNC_STAGE           = `STS_TNIU_SYNC_STAGE,
    parameter integer unsigned ASYNC_FIFO_DEPTH     = `STS_TNIU_ASYNC_FIFO_DEPTH,
    parameter logic [TGT_ID_WIDTH-1:0] SYS_REG_ROUTE_BASE = `STS_TNIU_SYS_REG_ROUTE_BASE,
    parameter logic [TGT_ID_WIDTH-1:0] SYS_REG_ROUTE_MASK = `STS_TNIU_SYS_REG_ROUTE_MASK,
    parameter logic [TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_BASE = `STS_TNIU_SYS_APB_ROUTE_BASE,
    parameter logic [TGT_ID_WIDTH-1:0] SYS_APB_ROUTE_MASK = `STS_TNIU_SYS_APB_ROUTE_MASK,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = `STS_TNIU_ERR_INT_CNT_WIDTH,
    localparam int SYS_APB_DEC_NUM = 2,
    localparam int SYS_REG_WORD_NUM = 10,
    localparam logic [SYS_APB_DEC_NUM*TGT_ID_WIDTH-1:0] SYS_APB_DEC_ROUTE_BASE = {SYS_APB_ROUTE_BASE, SYS_REG_ROUTE_BASE},
    localparam logic [SYS_APB_DEC_NUM*TGT_ID_WIDTH-1:0] SYS_APB_DEC_ROUTE_MASK = {SYS_APB_ROUTE_MASK, SYS_REG_ROUTE_MASK},
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_OH = ($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH))? 8 : 9,
    localparam int RSP_ECC_OH = ($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH))? 8 : 9,
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_OH,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_OH
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
    input   logic [REQ_AFIFO_W+1:0]         req_pld_sync    ,

    // response sync
    output  logic [ASYNC_FIFO_DEPTH-1:0]    rsp_wptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]    rsp_rptr_async  ,
    input   logic [ASYNC_FIFO_DEPTH-1:0]    rsp_rptr_sync   ,
    output  logic [RSP_AFIFO_W+1:0]         rsp_pld_sync    ,

    // External sys-side APB master
    output  logic                                m_psel      ,
    output  logic [APB_ADDR_WIDTH-1:0]           m_paddr     ,
    input   logic                                m_pready    ,
    input   logic [31:0]                         m_prdata    ,
    input   logic                                m_pslverr   ,
    output  logic [2:0]                          m_pprot     ,
    output  logic                                m_penable   ,
    output  logic                                m_pwrite    ,
    output  logic [31:0]                         m_pwdata    ,
    output  logic [3:0]                          m_pstrb     ,
    output  logic [SYS_REG_WORD_NUM*32-1:0]      v_tniu_sys_reg,

    // CTI — level pass-through (sys clock domain)
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
    //   Forward lane:  sys_ctm_trigin / sys_ctm_trigin_ack, noc_ctm_trigin / noc_ctm_trigin_ack
    //   Reverse lane:  noc_ctm_trigout / noc_ctm_trigout_ack, sys_ctm_trigout / sys_ctm_trigout_ack
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigin,       // from sys top (CTM direct)
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigin_ack,   // to sys top
    output  logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigin,       // to noc side (via CDC)
    input   logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigin_ack,   // from noc side (via CDC)
    input   logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigout,      // from noc side (via CDC)
    output  logic [CTM_TRIG_WIDTH-1:0]      noc_ctm_trigout_ack,  // to noc side (via CDC)
    output  logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigout,      // to sys top
    input   logic [CTM_TRIG_WIDTH-1:0]      sys_ctm_trigout_ack,  // from sys top

    input   logic [DBG_DATA_WIDTH-1:0]       dbg_data_in,
    output  logic [DBG_DATA_WIDTH-1:0]       dbg_data_out,

    input   logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_in,
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]  dbg_timestamp_out,
    // FUSA ECC error outputs (REQ AFIFO mst-side decode)
    output  logic                            tniu_sys_regbank_parity_err,
    output  logic                            sts_tniu_req_afifo_sb_err,
    output  logic                            sts_tniu_req_afifo_db_err
);

    // req to APB TNIU in sys side
    logic                       req_apb_tniu_vld;
    logic                       req_apb_tniu_rdy;
    sts_req_typ                 req_apb_tniu_pld;
    sts_req_typ                 req_apb_tniu_pld_tmp;
    logic                       req_apb_tniu_last;
    logic [REQ_PLD_WIDTH-1:0]   req_s_pld_tmp;

    // rsp from APB TNIU in sys side
    logic                       rsp_apb_tniu_vld;
    logic                       rsp_apb_tniu_rdy;
    sts_rsp_typ                 rsp_apb_tniu_pld;
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
    logic [SYS_APB_DEC_NUM-1:0] apb_dec_m_psel;
    logic [SYS_APB_DEC_NUM-1:0] apb_dec_m_pready;
    logic [SYS_APB_DEC_NUM*32-1:0] apb_dec_m_prdata;
    logic [SYS_APB_DEC_NUM-1:0] apb_dec_m_pslverr;
    logic [APB_ADDR_WIDTH-1:0]  sys_apb_paddr;
    logic [2:0]                 sys_apb_pprot;
    logic                       sys_apb_penable;
    logic                       sys_apb_pwrite;
    logic [31:0]                sys_apb_pwdata;
    logic [3:0]                 sys_apb_pstrb;
    logic [31:0]                sys_reg_prdata;
    logic                       sys_reg_pready;
    logic                       sys_reg_pslverr;
    logic                       sys_reg_pslverr_raw;
    logic                       sys_reg_parity_sw_check_err;
    logic                       sys_reg_parity_err_any;
    logic                       sys_regbank_parity_err_raw;
    logic [SYS_REG_WORD_NUM-1:0] sys_reg_parity_hw_check_err;
    logic [31:0]                sys_reg_word_rdat [SYS_REG_WORD_NUM-1:0];
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_tmp;
    genvar                      sys_reg_gi;

    // REQ: ECC decode after AFIFO read
    logic [REQ_AFIFO_W-1:0] req_s_pld_ecc;
    logic [RSP_AFIFO_W-1:0] rsp_m_pld_ecc;
    logic                    req_sb_err_raw, req_db_err_raw;
    fcip_ecc_dec #(.DATA_WIDTH(STS_REQ_WIDTH)) u_tniu_req_ecc_dec (
        .encode_data(req_s_pld_ecc),
        .data       (req_s_pld_tmp  ),
        .sb_err     (req_sb_err_raw ),
        .db_err     (req_db_err_raw )
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_tniu_req_pulse_sb (
        .clk(clk_dst), .rst_n(rstn_dst), .err_in(req_sb_err_raw), .intr_out(sts_tniu_req_afifo_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_tniu_req_pulse_db (
        .clk(clk_dst), .rst_n(rstn_dst), .err_in(req_db_err_raw), .intr_out(sts_tniu_req_afifo_db_err)
    );
    // RSP: ECC encode before AFIFO write: rsp_apb_tniu_pld → fcip_ecc_enc → AFIFO
    fcip_ecc_enc #(.DATA_WIDTH(STS_RSP_WIDTH)) u_tniu_rsp_ecc_enc (
        .data       (rsp_apb_tniu_pld),
        .encode_data(rsp_m_pld_ecc  )
    );

    fcip_req_rsp_afifo_mst #(
        .REQ_WIDTH      (REQ_AFIFO_W),
        .RSP_WIDTH      (RSP_AFIFO_W),
        .FIFO_DEPTH     (ASYNC_FIFO_DEPTH),
        .AUTO_CLEAR_EN  (1'b1),
        .SYNC_STAGE     (SYNC_STAGE)
    ) u_tniu_sys_afifo_mst (
        .clk            (clk_dst),
        .rst_n          (rstn_dst),
        .req_s_vld      (req_apb_tniu_vld  ),
        .req_s_rdy      (req_apb_tniu_rdy),
        .req_s_pld      (req_s_pld_ecc),
        .req_s_last     (req_apb_tniu_last),
        .rsp_m_vld      (rsp_apb_tniu_vld),
        .rsp_m_rdy      (rsp_apb_tniu_rdy),
        .rsp_m_pld      (rsp_m_pld_ecc),
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

    assign req_apb_tniu_pld_tmp   = sts_req_typ'(req_s_pld_tmp);
    assign req_apb_tniu_pld       = req_apb_tniu_pld_tmp;
    assign rsp_async_fifo_last    = rsp_apb_tniu_pld.rsp.last;
    assign sys_reg_parity_err_any = |sys_reg_parity_hw_check_err;
    assign sys_regbank_parity_err_raw = sys_reg_parity_sw_check_err | sys_reg_parity_err_any;
    assign sys_reg_pslverr        = sys_reg_pslverr_raw
                                  || (apb_dec_m_psel[0] && sys_apb_penable
                                   && (sys_reg_parity_sw_check_err || sys_reg_parity_err_any));
    assign apb_dec_m_pready       = {m_pready, sys_reg_pready};
    assign apb_dec_m_prdata       = {m_prdata, sys_reg_prdata};
    assign apb_dec_m_pslverr      = {m_pslverr, sys_reg_pslverr};
    assign m_psel                 = apb_dec_m_psel[1];
    assign m_paddr                = sys_apb_paddr;
    assign m_pprot                = sys_apb_pprot;
    assign m_penable              = sys_apb_penable;
    assign m_pwrite               = sys_apb_pwrite;
    assign m_pwdata               = sys_apb_pwdata;
    assign m_pstrb                = sys_apb_pstrb;

    generate
        for (sys_reg_gi = 0; sys_reg_gi < SYS_REG_WORD_NUM; sys_reg_gi = sys_reg_gi + 1) begin : g_v_tniu_sys_reg
            assign v_tniu_sys_reg[sys_reg_gi*32 +: 32] = sys_reg_word_rdat[sys_reg_gi];
        end
    endgenerate

    RegSpaceBase_cfg_reg_bank_table_sys u_regbank_sts_tniu_sys (
        .clk                      (clk_dst                     ),
        .rst_n                    (rstn_dst                    ),
        .p_addr                   (sys_apb_paddr[15:0]         ),
        .p_sel                    (apb_dec_m_psel[0]           ),
        .p_enable                 (sys_apb_penable             ),
        .p_write                  (sys_apb_pwrite              ),
        .p_wdata                  (sys_apb_pwdata              ),
        .p_strb                   (sys_apb_pstrb               ),
        .p_ready                  (sys_reg_pready              ),
        .p_rdata                  (sys_reg_prdata              ),
        .p_slverr                 (sys_reg_pslverr_raw         ),
        .parity_sw_check_err      (sys_reg_parity_sw_check_err ),
        .sys_reg0_sys_reg0_rdat   (sys_reg_word_rdat[0]        ),
        .sys_reg0_parity_hw_check_err(sys_reg_parity_hw_check_err[0]),
        .sys_reg1_sys_reg1_rdat   (sys_reg_word_rdat[1]        ),
        .sys_reg1_parity_hw_check_err(sys_reg_parity_hw_check_err[1]),
        .sys_reg2_sys_reg2_rdat   (sys_reg_word_rdat[2]        ),
        .sys_reg2_parity_hw_check_err(sys_reg_parity_hw_check_err[2]),
        .sys_reg3_sys_reg3_rdat   (sys_reg_word_rdat[3]        ),
        .sys_reg3_parity_hw_check_err(sys_reg_parity_hw_check_err[3]),
        .sys_reg4_sys_reg4_rdat   (sys_reg_word_rdat[4]        ),
        .sys_reg4_parity_hw_check_err(sys_reg_parity_hw_check_err[4]),
        .sys_reg5_sys_reg5_rdat   (sys_reg_word_rdat[5]        ),
        .sys_reg5_parity_hw_check_err(sys_reg_parity_hw_check_err[5]),
        .sys_reg6_sys_reg6_rdat   (sys_reg_word_rdat[6]        ),
        .sys_reg6_parity_hw_check_err(sys_reg_parity_hw_check_err[6]),
        .sys_reg7_sys_reg7_rdat   (sys_reg_word_rdat[7]        ),
        .sys_reg7_parity_hw_check_err(sys_reg_parity_hw_check_err[7]),
        .sys_reg8_sys_reg8_rdat   (sys_reg_word_rdat[8]        ),
        .sys_reg8_parity_hw_check_err(sys_reg_parity_hw_check_err[8]),
        .sys_reg9_sys_reg9_rdat   (sys_reg_word_rdat[9]        ),
        .sys_reg9_parity_hw_check_err(sys_reg_parity_hw_check_err[9])
    );

    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_tniu_sys_regbank_parity_pulse (
        .clk      (clk_dst                   ),
        .rst_n    (rstn_dst                  ),
        .err_in   (sys_regbank_parity_err_raw),
        .intr_out (tniu_sys_regbank_parity_err)
    );

    sts_tniu_apb u_sts_tniu_apb_sys (
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

    sts_tniu_apb_dec #(
        .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
        .MASTER_NUM    (SYS_APB_DEC_NUM),
        .ROUTE_BASE    (SYS_APB_DEC_ROUTE_BASE),
        .ROUTE_MASK    (SYS_APB_DEC_ROUTE_MASK)
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
        .m_psel         (apb_dec_m_psel     ),
        .m_paddr        (sys_apb_paddr      ),
        .m_pready       (apb_dec_m_pready   ),
        .m_prdata       (apb_dec_m_prdata   ),
        .m_pslverr      (apb_dec_m_pslverr  ),
        .m_pprot        (sys_apb_pprot      ),
        .m_penable      (sys_apb_penable    ),
        .m_pwrite       (sys_apb_pwrite     ),
        .m_pwdata       (sys_apb_pwdata     ),
        .m_pstrb        (sys_apb_pstrb      )
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

endmodule

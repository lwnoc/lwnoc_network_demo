module sts_noc_cpu_ss_tniu_sts_tniu_sys
import sts_noc_cpu_ss_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `sts_noc_cpu_ss_tniu_STS_TNIU_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `sts_noc_cpu_ss_tniu_STS_TNIU_DBG_DATA_WIDTH,
    parameter integer unsigned APB_ADDR_WIDTH      = `sts_noc_cpu_ss_tniu_STS_TNIU_APB_ADDR_WIDTH,
    parameter integer unsigned SYNC_STAGE           = `sts_noc_cpu_ss_tniu_STS_TNIU_SYNC_STAGE,
    parameter integer unsigned ASYNC_FIFO_DEPTH     = `sts_noc_cpu_ss_tniu_STS_TNIU_ASYNC_FIFO_DEPTH,
    parameter integer unsigned  ERR_INT_CNT_WIDTH = `sts_noc_cpu_ss_tniu_STS_TNIU_ERR_INT_CNT_WIDTH,
    localparam int SYS_REG_WORD_NUM = 10,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH,
    localparam int REQ_ECC_CODE_WIDTH = (($clog2(STS_REQ_WIDTH)+STS_REQ_WIDTH+1 <= 2**$clog2(STS_REQ_WIDTH)) ? $clog2(STS_REQ_WIDTH) : $clog2(STS_REQ_WIDTH)+1),
    localparam int RSP_ECC_CODE_WIDTH = (($clog2(STS_RSP_WIDTH)+STS_RSP_WIDTH+1 <= 2**$clog2(STS_RSP_WIDTH)) ? $clog2(STS_RSP_WIDTH) : $clog2(STS_RSP_WIDTH)+1),
    localparam int REQ_AFIFO_W = STS_REQ_WIDTH + REQ_ECC_CODE_WIDTH + 1,
    localparam int RSP_AFIFO_W = STS_RSP_WIDTH + RSP_ECC_CODE_WIDTH + 1
) (
    input   logic   clk_dst ,
    input   logic   clk_dbg_timer,
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

    input   logic [RESERVE_WIDTH-1:0]        reserved_bits_in,
    output  logic [RESERVE_WIDTH-1:0]        reserved_bits_out,

    // FUSA ECC error outputs (REQ AFIFO mst-side decode)
    output  logic                            tniu_sys_regbank_parity_err,
    output  logic                            sts_tniu_req_afifo_sb_err,
    output  logic                            sts_tniu_req_afifo_db_err,
    // Hardware debug select (feed-through from noc regbank)
    input   logic [9:0]                      hw_dbg_sel_in,
    output  logic [9:0]                      hw_dbg_sel_out
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

    // ── Tgt-id decode: split sys APB from sys regbank ──
    logic                       req_is_sys_reg;
    logic                       req_is_sys_apb;

    assign req_is_sys_reg = (req_apb_tniu_pld.cmn.tgt_id[TGT_ID_WIDTH-1 -: 3] == 3'b001);
    assign req_is_sys_apb = (req_apb_tniu_pld.cmn.tgt_id[TGT_ID_WIDTH-1 -: 3] == 3'b000);

    // ── Sys regbank path ──
    logic                       reg_apb_psel;
    logic                       reg_apb_penable;
    logic [APB_ADDR_WIDTH-1:0]  reg_apb_paddr;
    logic                       reg_apb_pwrite;
    logic [31:0]                reg_apb_pwdata;
    logic [31:0]                reg_apb_prdata;
    logic                       reg_apb_pready;
    logic [3:0]                 reg_apb_pstrb;
    logic [2:0]                 reg_apb_pprot;
    logic                       reg_apb_pslverr;
    logic                       reg_req_vld;
    logic                       reg_req_rdy;
    sts_req_typ                 reg_req_pld;
    logic                       reg_rsp_vld;
    logic                       reg_rsp_rdy;
    sts_rsp_typ                 reg_rsp_pld;

    // ── External sys APB path ──
    logic                       ext_apb_psel;
    logic                       ext_apb_penable;
    logic [APB_ADDR_WIDTH-1:0]  ext_apb_paddr;
    logic                       ext_apb_pwrite;
    logic [31:0]                ext_apb_pwdata;
    logic [31:0]                ext_apb_prdata;
    logic                       ext_apb_pready;
    logic [3:0]                 ext_apb_pstrb;
    logic [2:0]                 ext_apb_pprot;
    logic                       ext_apb_pslverr;
    logic                       ext_req_vld;
    logic                       ext_req_rdy;
    sts_req_typ                 ext_req_pld;
    logic                       ext_rsp_vld;
    logic                       ext_rsp_rdy;
    sts_rsp_typ                 ext_rsp_pld;

    // ── Miss responder ──
    logic                       req_is_miss;
    logic                       miss_req_vld;
    logic                       miss_req_rdy;
    sts_req_typ                 miss_req_pld;
    logic                       miss_rsp_vld;
    logic                       miss_rsp_rdy;
    sts_rsp_typ                 miss_rsp_pld;

    // ── Response merge: 3-way ready-aware arbiter (reg / ext / miss) ──
    logic [2:0]                 v_rsp_vld;
    logic [2:0]                 v_rsp_rdy;
    sts_rsp_typ                 v_rsp_pld [2:0];

    assign v_rsp_vld[0] = reg_rsp_vld;
    assign v_rsp_pld[0] = reg_rsp_pld;
    assign v_rsp_vld[1] = ext_rsp_vld;
    assign v_rsp_pld[1] = ext_rsp_pld;
    assign v_rsp_vld[2] = miss_rsp_vld;
    assign v_rsp_pld[2] = miss_rsp_pld;

    assign reg_rsp_rdy  = v_rsp_rdy[0];
    assign ext_rsp_rdy  = v_rsp_rdy[1];
    assign miss_rsp_rdy = v_rsp_rdy[2];

    fcip_arb_vrp #(
        .MODE     (1),         // round-robin
        .HSK_MODE (0),
        .WIDTH    (3),
        .PLD_WIDTH($bits(sts_rsp_typ))
    ) u_sys_rsp_arb (
        .clk     (clk_dst            ),
        .rst_n   (rstn_dst           ),
        .v_vld_s (v_rsp_vld          ),
        .v_rdy_s (v_rsp_rdy          ),
        .v_pld_s (v_rsp_pld          ),
        .vld_m   (rsp_apb_tniu_vld   ),
        .rdy_m   (rsp_apb_tniu_rdy   ),
        .pld_m   (rsp_apb_tniu_pld   )
    );

    // ── Request split: route to regbank, external APB, or miss responder ──
    assign req_is_miss = !req_is_sys_reg && !req_is_sys_apb;

    assign reg_req_vld  = req_apb_tniu_vld && req_is_sys_reg;
    assign reg_req_pld  = req_apb_tniu_pld;
    assign ext_req_vld  = req_apb_tniu_vld && req_is_sys_apb;
    assign ext_req_pld  = req_apb_tniu_pld;
    assign miss_req_vld = req_apb_tniu_vld && req_is_miss;
    assign miss_req_pld = req_apb_tniu_pld;

    // Accept request if the selected path's downstream is ready
    assign req_apb_tniu_rdy =
        (req_is_sys_reg && reg_req_rdy) ||
        (req_is_sys_apb && ext_req_rdy) ||
        (req_is_miss    && miss_req_rdy);

    // ── Miss responder: accept request, return DECERR after 0-cycle stall ──
    assign miss_req_rdy  = 1'b1;
    assign miss_rsp_vld  = miss_req_vld;
    assign miss_rsp_pld  = '{cmn: '{opcode: miss_req_pld.cmn.opcode,
                                    src_id: miss_req_pld.cmn.src_id,
                                    tgt_id: miss_req_pld.cmn.tgt_id,
                                    txn_id: miss_req_pld.cmn.txn_id,
                                    default: '0},
                             rsp:  '{resp: 2'b11,  // DECERR
                                     last: 1'b1,
                                     default: '0},
                             default: '0};

    // ── External APB m_* ports ──
    assign m_psel    = ext_apb_psel;
    assign m_paddr   = ext_apb_paddr;
    assign m_pprot   = ext_apb_pprot;
    assign m_penable = ext_apb_penable;
    assign m_pwrite  = ext_apb_pwrite;
    assign m_pwdata  = ext_apb_pwdata;
    assign m_pstrb   = ext_apb_pstrb;

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
                                  || (reg_apb_psel && reg_apb_penable
                                   && (sys_reg_parity_sw_check_err || sys_reg_parity_err_any));

    generate
        for (sys_reg_gi = 0; sys_reg_gi < SYS_REG_WORD_NUM; sys_reg_gi = sys_reg_gi + 1) begin : g_v_tniu_sys_reg
            assign v_tniu_sys_reg[sys_reg_gi*32 +: 32] = sys_reg_word_rdat[sys_reg_gi];
        end
    endgenerate

    sts_noc_cpu_ss_tniu_RegSpaceBase_cfg_reg_bank_table_sys u_regbank_sts_tniu_sys (
        .clk                      (clk_dst                     ),
        .rst_n                    (rstn_dst                    ),
        .p_addr                   (reg_apb_paddr[15:0]         ),
        .p_sel                    (reg_apb_psel                ),
        .p_enable                 (reg_apb_penable             ),
        .p_write                  (reg_apb_pwrite              ),
        .p_wdata                  (reg_apb_pwdata              ),
        .p_strb                   (reg_apb_pstrb               ),
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

    // ── Regbank APB path (tgt_id = TNIU_SYS_REG) ──
    sts_noc_cpu_ss_tniu_sts_tniu_apb u_sts_tniu_sys_reg_apb (
        .clk            (clk_dst          ),
        .rst_n          (rstn_dst         ),
        .in_req_vld     (reg_req_vld      ),
        .in_req_pld     (reg_req_pld      ),
        .in_req_rdy     (reg_req_rdy      ),
        .out_rsp_vld    (reg_rsp_vld      ),
        .out_rsp_pld    (reg_rsp_pld      ),
        .out_rsp_rdy    (reg_rsp_rdy      ),
        .ptgt_id        (),
        .psel           (reg_apb_psel     ),
        .penable        (reg_apb_penable  ),
        .paddr          (reg_apb_paddr    ),
        .pwrite         (reg_apb_pwrite   ),
        .pwdata         (reg_apb_pwdata   ),
        .prdata         (sys_reg_prdata   ),
        .pready         (sys_reg_pready   ),
        .pstrb          (reg_apb_pstrb    ),
        .pprot          (reg_apb_pprot    ),
        .pslverr        (sys_reg_pslverr  )
    );

    // ── External sys APB path (tgt_id = SYS_APB) ──
    sts_noc_cpu_ss_tniu_sts_tniu_apb u_sts_tniu_sys_ext_apb (
        .clk            (clk_dst          ),
        .rst_n          (rstn_dst         ),
        .in_req_vld     (ext_req_vld      ),
        .in_req_pld     (ext_req_pld      ),
        .in_req_rdy     (ext_req_rdy      ),
        .out_rsp_vld    (ext_rsp_vld      ),
        .out_rsp_pld    (ext_rsp_pld      ),
        .out_rsp_rdy    (ext_rsp_rdy      ),
        .ptgt_id        (),
        .psel           (ext_apb_psel     ),
        .penable        (ext_apb_penable  ),
        .paddr          (ext_apb_paddr    ),
        .pwrite         (ext_apb_pwrite   ),
        .pwdata         (ext_apb_pwdata   ),
        .prdata         (m_prdata         ),
        .pready         (m_pready         ),
        .pstrb          (ext_apb_pstrb    ),
        .pprot          (ext_apb_pprot    ),
        .pslverr        (m_pslverr        )
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

    // Hardware debug select feed-through
    assign hw_dbg_sel_out = hw_dbg_sel_in;

endmodule

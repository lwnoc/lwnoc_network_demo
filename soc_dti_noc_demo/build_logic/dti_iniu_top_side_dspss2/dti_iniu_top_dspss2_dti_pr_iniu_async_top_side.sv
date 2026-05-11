module dti_iniu_top_dspss2_dti_pr_iniu_async_top_side
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import dti_iniu_top_dspss2_dti_iniu_pack::*;
    #(
        parameter integer unsigned ASYNC_FIFO_DEPTH   = `dti_iniu_top_dspss2_INIU_ASYNC_FIFO_DEPTH,
        parameter integer unsigned ROUTE_BASE         = `dti_iniu_top_dspss2_INIU_ROUTE_BASE,

        // ECC overhead: DATA_WIDTH=104 → CODE_WIDTH=7 + parity=1 → overhead=8
        localparam integer unsigned  ORG_PLD_WIDTH    = 90+6+6+1+1,
        localparam integer unsigned  ECC_OVERHEAD     = 8,
        localparam integer unsigned  ECC_PLD_WIDTH    = ORG_PLD_WIDTH + ECC_OVERHEAD,
        localparam integer unsigned  AFIFO_DATA_WIDTH = ECC_PLD_WIDTH,
        parameter integer unsigned  ERR_INT_CNT_WIDTH = `dti_iniu_top_dspss2_INIU_ERR_INT_CNT_WIDTH,
        localparam int LP_SIG_WIDTH = $bits(lwnoc_lp_req_signal_t)
    )(
    input   logic                                              clk           ,
    input   logic                                              rst_n         ,
    // RSP_data channel
    input   logic                                              rsp_valid     ,
    input   logic   [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0]  rsp_payload   ,
    input   logic                                              rsp_last      ,
    input   logic   [TBU_NUM_WIDTH-1                      :0]  rsp_srcid     ,
    input   logic   [TBU_NUM_WIDTH-1                      :0]  rsp_tgtid     ,
    input   logic                                              rsp_qos       , //tie 1
    output  logic                                              rsp_threshold ,
    output  logic                                              rsp_ready     , //async rdy
    // REQ_data channel
    output  logic                                              req_valid     ,
    output  logic   [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0]  req_payload   ,
    output  logic                                              req_last      ,
    output  logic   [TBU_NUM_WIDTH-1                      :0]  req_srcid     ,
    output  logic   [TBU_NUM_WIDTH-1                      :0]  req_tgtid     ,
    output  logic                                              req_qos       , //tie 1
    input   logic                                              req_threshold ,
    input   logic                                              req_ready     , //custom rdy
    // async fifo req
    input  logic    [ASYNC_FIFO_DEPTH-1                   :0]  req_wptr_async,
    output logic    [ASYNC_FIFO_DEPTH-1                   :0]  req_rptr_async,
    output logic    [ASYNC_FIFO_DEPTH-1                   :0]  req_rptr_sync ,
    input  logic    [AFIFO_DATA_WIDTH                     :0]  req_pld_sync  ,
    // FUSA ECC error outputs (REQ AFIFO mst-side decode, clk_noc domain)
    output logic                                               req_afifo_sb_err,
    output logic                                               req_afifo_db_err,
    // async fifo rsp
    output logic    [ASYNC_FIFO_DEPTH-1                   :0]  rsp_wptr_async,
    input  logic    [ASYNC_FIFO_DEPTH-1                   :0]  rsp_rptr_async,
    input  logic    [ASYNC_FIFO_DEPTH-1                   :0]  rsp_rptr_sync ,
    output logic    [AFIFO_DATA_WIDTH                     :0]  rsp_pld_sync  ,
    // LP
    input  logic [LP_SIG_WIDTH-1:0]                            lp_hub_rx_req ,
    output logic [LP_SIG_WIDTH-1:0]                            lp_hub_tx_req
    );

    logic [90+6+6+1+1-1:0]  req_pld_vector     ;
    logic [AFIFO_DATA_WIDTH-1:0] req_pld_fifo_out  ;
    logic                   req_async_clear    ;
    logic                   req_async_stall    ;
    logic                   req_async_full_zero;
    logic                   req_async_idle     ;
    logic                   req_async_almost_empty_unused;
    logic [90+6+6+1+1-1:0]  rsp_pld_vector     ;
    logic [AFIFO_DATA_WIDTH-1:0] rsp_pld_fifo_in   ;
    logic                   async_rsp_stall    ;
    logic                   async_rsp_clear    ;
    logic                   async_rsp_full_zero;
    logic                   async_rsp_almost_full_unused;
    logic [TBU_NUM_WIDTH-1:0] req_srcid_local  ;
    logic [TBU_NUM_WIDTH-1:0] rsp_srcid_local  ;
    lwnoc_lp_req_signal_t   async_slave_hub_rx_req;
    lwnoc_lp_req_signal_t   async_slave_hub_tx_req;
    lwnoc_lp_req_signal_t   async_master_hub_rx_req;
    lwnoc_lp_req_signal_t   async_master_hub_tx_req;
    lwnoc_lp_req_signal_t   v_stage_1_hub_rx_req[2:0];
    lwnoc_lp_req_signal_t   v_stage_1_hub_tx_req[2:0];

    localparam logic [TBU_NUM_WIDTH-1:0] ROUTE_BASE_TID = TBU_NUM_WIDTH'(ROUTE_BASE);

    //=================================================
    // LP
    //=================================================
    assign v_stage_1_hub_rx_req[0] = lwnoc_lp_req_signal_t'(lp_hub_rx_req);
    assign v_stage_1_hub_rx_req[1] = async_slave_hub_rx_req;
    assign v_stage_1_hub_rx_req[2] = async_master_hub_rx_req;
    assign lp_hub_tx_req           = v_stage_1_hub_tx_req[0];
    assign async_slave_hub_tx_req  = v_stage_1_hub_tx_req[1];
    assign async_master_hub_tx_req = v_stage_1_hub_tx_req[2];

    lwnoc_lp_tniu_async_bridge u_slv_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .rx_req             (async_slave_hub_tx_req     ),
        .tx_req             (async_slave_hub_rx_req     ),
        .stall_ptr          (async_rsp_stall            ),
        .clear_ptr          (async_rsp_clear            ),
        .trans_idle         (1'b1                       ),
        .full_zero          (async_rsp_full_zero        )
    );

    lwnoc_lp_tniu_async_bridge u_mst_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .rx_req             (async_master_hub_tx_req    ),
        .tx_req             (async_master_hub_rx_req    ),
        .stall_ptr          (req_async_stall            ),
        .clear_ptr          (req_async_clear            ),
        .trans_idle         (1'b1                       ),
        .full_zero          (req_async_full_zero        )
    );

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL       (3                          )
    ) u_stage_1_hub (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .v_rx_req           (v_stage_1_hub_rx_req       ),
        .v_tx_req           (v_stage_1_hub_tx_req       )
    );
    //===========================================================================
    // async fifo req mst — ECC decode (FUSA_ECC_EN) after AFIFO read
    //===========================================================================
    assign req_last      = req_pld_vector[0];
    assign req_qos       = req_pld_vector[1];
    assign req_tgtid     = req_pld_vector[7:2];
    assign req_srcid_local = req_pld_vector[13:8];
    assign req_srcid     = req_srcid_local + ROUTE_BASE_TID;
    assign req_payload   = req_pld_vector[103:14];

    fcip_afifo_mst #(
        .DATA_WIDTH         (AFIFO_DATA_WIDTH        ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH       ))
    u_dti_pr_async_fifo_mst (
        .clk                (clk                    ),
        .rst_n              (rst_n                  ),
        .stall              (req_async_stall        ),
        .clear              (req_async_clear        ),
        .full_zero          (req_async_full_zero    ),
        .idle               (req_async_idle         ),

        .m_vld              (req_valid              ),
        .m_pld              (req_pld_fifo_out       ),
        .m_rdy              (req_ready              ),
        .almost_empty       (req_async_almost_empty_unused),

        .wptr_async         (req_wptr_async         ),

        .rptr_async         (req_rptr_async         ),
        .rptr_sync          (req_rptr_sync          ),
        .pld_sync           (req_pld_sync           )
    );
    generate
        logic   req_afifo_sb_err_raw;
        logic   req_afifo_db_err_raw;
        // always ECC enabled
        fcip_ecc_dec #(.DATA_WIDTH(ORG_PLD_WIDTH)) u_req_afifo_ecc_dec (
            .encode_data(req_pld_fifo_out),
            .data       (req_pld_vector  ),
            .sb_err     (req_afifo_sb_err_raw),
            .db_err     (req_afifo_db_err_raw)
        );
        fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_req_sb (
            .clk(clk), .rst_n(rst_n), .err_in(req_afifo_sb_err_raw), .intr_out(req_afifo_sb_err)
        );
        fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_req_db (
            .clk(clk), .rst_n(rst_n), .err_in(req_afifo_db_err_raw), .intr_out(req_afifo_db_err)
        );
    endgenerate
    //===========================================================================
    // async fifo rsp slv — ECC encode (FUSA_ECC_EN) before AFIFO write
    //===========================================================================
    assign rsp_srcid_local = rsp_srcid - ROUTE_BASE_TID;
    assign rsp_pld_vector = {rsp_payload,rsp_srcid_local,rsp_tgtid,rsp_qos,rsp_last};
    assign rsp_threshold  = 1'b1; //tie 1
    // always ECC enabled
    fcip_ecc_enc #(.DATA_WIDTH(ORG_PLD_WIDTH)) u_rsp_afifo_ecc_enc (
        .data       (rsp_pld_vector ),
        .encode_data(rsp_pld_fifo_in)
    );

    fcip_afifo_slv #(
        .DATA_WIDTH         (AFIFO_DATA_WIDTH     ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH    ))
    u_dti_pr_async_fifo_slv (
        .clk                (clk                    ),
        .rst_n              (rst_n                  ),
        .stall              (async_rsp_stall        ),
        .clear              (async_rsp_clear        ),
        .full_zero          (async_rsp_full_zero    ),

        .s_vld              (rsp_valid              ),
        .s_pld              (rsp_pld_fifo_in        ),
        .s_rdy              (rsp_ready              ),
        .almost_full        (async_rsp_almost_full_unused),

        .wptr_async         (rsp_wptr_async         ),

        .rptr_async         (rsp_rptr_async         ),
        .rptr_sync          (rsp_rptr_sync          ),
        .pld_sync           (rsp_pld_sync           )
    );

endmodule

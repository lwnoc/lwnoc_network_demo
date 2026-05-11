module npu_ss_tniu_interrupt_tniu_async_sys_side

    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import npu_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = `npu_ss_tniu_INTR_TNIU_INTERRUPT_MAX_NUM,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM),
    parameter integer unsigned  TIME_OUT_WIDTH      = `npu_ss_tniu_INTR_TNIU_TIME_OUT_WIDTH,
    parameter integer unsigned  ASYNC_FIFO_DEPTH    = `npu_ss_tniu_INTR_TNIU_SYS_ASYNC_FIFO_DEPTH,
    parameter logic             FUSA_ECC_EN         = `npu_ss_tniu_INTR_TNIU_FUSA_ECC_EN,
    parameter integer unsigned  ERR_INT_CNT_WIDTH   = `npu_ss_tniu_INTR_TNIU_ERR_INT_CNT_WIDTH,
    localparam integer unsigned PLD_ORG_WIDTH       = 40+8+8+4+1,
    localparam integer unsigned ECC_CODE_WIDTH      = ($clog2(PLD_ORG_WIDTH)+PLD_ORG_WIDTH+1 <= 2**$clog2(PLD_ORG_WIDTH))? $clog2(PLD_ORG_WIDTH) : $clog2(PLD_ORG_WIDTH)+1,
    localparam integer unsigned ECC_OVERHEAD        = ECC_CODE_WIDTH + 1,
    localparam integer unsigned PLD_ECC_WIDTH       = PLD_ORG_WIDTH + ECC_OVERHEAD,
    localparam integer unsigned FIFO_DATA_WIDTH     = PLD_ECC_WIDTH

)(
    input  logic                                    clk                             ,
    input  logic                                    rst_n                           ,
    // interrupt interface
    input  logic [NIU_ID_WIDTH-1                :0] tniu_tgt_id                     ,
    output logic [INTERRUPT_NUM-1               :0] v_interrupt                     ,
    output logic [INTERRUPT_NUM/32-1            :0] v_merge_interrupt               ,
    // apb interface
	input  logic [31                            :0] p_addr                          ,
	input  logic                                    p_sel                           ,
	input  logic                                    p_enable                        ,
	input  logic                                    p_write                         ,
	input  logic [31                            :0] p_wdata                         ,
	output logic                                    p_ready                         ,
	output logic [31                            :0] p_rdata                         ,
	output logic                                    p_slverr                        ,
    //async fifo interface
    input  logic [ASYNC_FIFO_DEPTH-1            :0] wptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_sync                       ,
    input  logic [FIFO_DATA_WIDTH                :0] pld_sync                        ,
    output logic                                    afifo_sb_err                     ,
    output logic                                    afifo_db_err                     ,
    //lp interface
    input  logic [TIME_OUT_WIDTH-1              :0] timeout_val                     ,

    output lwnoc_lp_req_signal_t                    m_async_master_hub_rx_req       ,
    input  lwnoc_lp_req_signal_t                    m_async_master_hub_tx_req       ,

    input  logic                                    preq                            ,
    input  lwnoc_pchannel_state_t                   pstate                          ,
    output lwnoc_pchannel_active_t                  pactive                         ,
    output logic                                    paccept                         ,
    output logic                                    pdeny                           ,

    // regbank parity error: tracks APB write→read parity consistency
    output logic                                    regbank_parity_err       ,
    // memory (SPRAM) ECC error outputs
    output logic                                    tniu_lut_sb_err          ,
    output logic                                    tniu_lut_db_err

);

//===========================================================================
// logic declarations
//===========================================================================
    logic                                   req_valid                   ;
    logic                                   req_ready                   ;
    logic [39                           :0] req_payload                 ;
    logic [7                            :0] req_srcid                   ;
    logic [7                            :0] req_tgtid                   ;
    logic [3                            :0] req_qos                     ;
    logic                                   req_last                    ;
    logic                                   req_threshold               ;

    logic                                   resp_valid                  ;
    logic                                   resp_ready                  ;
    logic [40+8+8+4+1-1                 :0] resp_pld_vector             ;
    logic [FIFO_DATA_WIDTH-1            :0] afifo_mst_pld               ;

    logic                                   async_stall                 ;
    logic                                   async_clear                 ;
    logic                                   async_idle                  ;
    logic                                   async_full_zero             ;
    logic                                   async_almost_empty          ;

    logic                                   niu_partical_rst            ;
    logic                                   niu_idle                    ;

    logic [INTERRUPT_NUM_WIDTH-1        :0] mem_addr                    ;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] mem_din                     ;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] mem_dout                    ;
    logic                                   mem_en                      ;
    logic                                   mem_wren                    ;
    logic                                   mem_sb_err                  ;
    logic                                   mem_db_err                  ;

    lwnoc_lp_req_signal_t                   intr_niu_rx_req             ;
    lwnoc_lp_req_signal_t                   intr_niu_tx_req             ;
    lwnoc_lp_req_signal_t                   async_mst_hub_rx_req        ;
    lwnoc_lp_req_signal_t                   async_mst_hub_tx_req        ;
    lwnoc_lp_req_signal_t                   lp_iniu_hub_rx_req          ;
    lwnoc_lp_req_signal_t                   lp_iniu_hub_tx_req          ;
    lwnoc_lp_req_signal_t                   lp_nest_rx_req              ;
    lwnoc_lp_req_signal_t                   lp_nest_tx_req              ;

    lwnoc_lp_req_signal_t                   v_stage_1_hub_rx_req    [3:0];
    lwnoc_lp_req_signal_t                   v_stage_1_hub_tx_req    [3:0];

//===========================================================================
// package
//===========================================================================


    assign req_valid            = resp_valid;
    assign resp_ready           = req_ready;
    assign req_last             = resp_pld_vector[0];
    assign req_qos              = resp_pld_vector[4:1];
    assign req_tgtid            = resp_pld_vector[12:5];
    assign req_srcid            = resp_pld_vector[20:13];
    assign req_payload          = resp_pld_vector[60:21];

//===========================================================================
// lp,path 0-connect to lp iniu(connect from RSC p channel)
//    path 1-connect to async master hub(connect to async bridge slave)
//    path 2-connect to barrier lp hub(connect to lp tniu,then control interrupt_tniu)
//    path 3-connect to lp nest(connect to tniu noc side async fifo mst)
//===========================================================================

    assign v_stage_1_hub_rx_req[0] = lp_iniu_hub_rx_req;
    assign v_stage_1_hub_rx_req[1] = async_mst_hub_rx_req;
    assign v_stage_1_hub_rx_req[2] = intr_niu_rx_req;
    assign v_stage_1_hub_rx_req[3] = lp_nest_rx_req;

    assign lp_iniu_hub_tx_req      = v_stage_1_hub_tx_req[0];
    assign async_mst_hub_tx_req    = v_stage_1_hub_tx_req[1];
    assign intr_niu_tx_req         = v_stage_1_hub_tx_req[2];
    assign lp_nest_tx_req          = v_stage_1_hub_tx_req[3];

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL       (4                          )
    ) u_stage_1_hub (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .v_rx_req           (v_stage_1_hub_rx_req       ),
        .v_tx_req           (v_stage_1_hub_tx_req       )
    );

    lwnoc_lp_tniu_async_bridge u_mst_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (async_mst_hub_tx_req       ),
        .tx_req             (async_mst_hub_rx_req       ),

        .stall_ptr          (async_stall                ),
        .clear_ptr          (async_clear                ),
        .trans_idle         (async_idle                 ),
        .full_zero          (async_full_zero            )
    );

    lwnoc_lp_iniu u_lwnoc_lp_iniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .rx_req             (lp_iniu_hub_tx_req         ),
        .tx_req             (lp_iniu_hub_rx_req         ),
        .preq               (preq                       ),
        .pstate             (pstate                     ),
        .pactive            (pactive                    ),
        .paccept            (paccept                    ),
        .pdeny              (pdeny                      )
    );


    lwnoc_lp_tniu_func_tniu #(
        .TIME_OUT_WIDTH     (TIME_OUT_WIDTH             )
    ) u_intr_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (intr_niu_tx_req            ),
        .tx_req             (intr_niu_rx_req            ),

        .partial_reset      (niu_partical_rst           ),
        .trans_idle         (niu_idle                   ),
        .timeout_val        (timeout_val + TIME_OUT_WIDTH'(32))
    );

    lwnoc_lp_nest u_lwnoc_lp_nest(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req_main        (lp_nest_tx_req             ),
        .tx_req_main        (lp_nest_rx_req             ),
        .rx_req_sub         (m_async_master_hub_tx_req  ),
        .tx_req_sub         (m_async_master_hub_rx_req  )

    );


//===========================================================================
// async fifo
//===========================================================================
    fcip_afifo_mst #(
        .DATA_WIDTH         (FIFO_DATA_WIDTH        ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH       )
    ) u_intr_async_fifo (
        .clk                (clk                    ),
        .rst_n              (rst_n                  ),
        .stall              (async_stall            ),
        .clear              (async_clear            ),
        .full_zero          (async_full_zero        ),
        .idle               (async_idle             ),
        .almost_empty       (async_almost_empty     ),

        .m_vld              (resp_valid             ),
        .m_pld              (afifo_mst_pld          ),
        .m_rdy              (resp_ready             ),

        .wptr_async         (wptr_async             ),

        .rptr_async         (rptr_async             ),
        .rptr_sync          (rptr_sync              ),
        .pld_sync           (pld_sync               )
    );

    logic ecc_sb_err_raw;
    logic ecc_db_err_raw;
    fcip_ecc_dec #(.DATA_WIDTH(PLD_ORG_WIDTH)) u_rsp_afifo_ecc_dec (
        .encode_data(afifo_mst_pld   ),
        .data       (resp_pld_vector ),
        .sb_err     (ecc_sb_err_raw  ),
        .db_err     (ecc_db_err_raw  )
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_sb (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_sb_err_raw), .intr_out(afifo_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_db (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_db_err_raw), .intr_out(afifo_db_err)
    );
//===========================================================================
// niu
//===========================================================================

    npu_ss_tniu_interrupt_tniu #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu (
        .clk            (clk                            ),
        .rst_n          (rst_n                          ),

        .tniu_tgt_id    (tniu_tgt_id                    ),

        .req_valid      (req_valid                      ),
        .req_ready      (req_ready                      ),
        .req_payload    (req_payload                    ),
        .req_srcid      (req_srcid                      ),
        .req_tgtid      (req_tgtid                      ),
        .req_qos        (req_qos                        ),
        .req_last       (req_last                       ),
        .req_threshold  (req_threshold                  ),

        .p_addr         (p_addr                         ),
        .p_sel          (p_sel                          ),
        .p_enable       (p_enable                       ),
        .p_write        (p_write                        ),
        .p_wdata        (p_wdata                        ),
        .p_ready        (p_ready                        ),
        .p_rdata        (p_rdata                        ),
        .p_slverr       (p_slverr                       ),

        .v_interrupt    (v_interrupt                    ),
        .v_merge_interrupt(v_merge_interrupt            ),

        .addr           (mem_addr                       ),
        .din            (mem_din                        ),
        .dout           (mem_dout                       ),
        .en             (mem_en                         ),
        .wren           (mem_wren                       ),

        .partial_rst    (niu_partical_rst               ),
        .idle           (niu_idle                       ),
        .regbank_parity_err(regbank_parity_err          )
    );


    // Memory ECC: encode write data, decode read data
    localparam MEM_RAW_W = NIU_ID_WIDTH+INTR_ID_WIDTH;
    localparam MEM_ECC_CODE_W = ($clog2(MEM_RAW_W)+MEM_RAW_W+1 <= 2**$clog2(MEM_RAW_W))? $clog2(MEM_RAW_W) : $clog2(MEM_RAW_W)+1;
    localparam MEM_ECC_OH    = MEM_ECC_CODE_W + 1;
    localparam MEM_ECC_WIDTH = MEM_RAW_W + MEM_ECC_OH;
    logic [MEM_ECC_WIDTH-1:0] spram_wr_ecc;
    logic [MEM_ECC_WIDTH-1:0] spram_rd_ecc;
    fcip_ecc_enc #(.DATA_WIDTH(MEM_RAW_W)) u_mem_ecc_enc (
        .data       (mem_din        ),
        .encode_data(spram_wr_ecc   )
    );
    fcip_ecc_dec #(.DATA_WIDTH(MEM_RAW_W)) u_mem_ecc_dec (
        .encode_data(spram_rd_ecc),
        .data       (mem_dout      ),
        .sb_err     (mem_sb_err    ),
        .db_err     (mem_db_err    )
    );


    generate
        if(INTERRUPT_NUM==4096)begin
            npu_ss_tniu_spram_4096x26 u_sp_4096_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
        else if(INTERRUPT_NUM==2048)begin
            npu_ss_tniu_spram_2048x26 u_sp_2048_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
        else if(INTERRUPT_NUM==1024)begin
            npu_ss_tniu_spram_1024x26 u_sp_1024_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
        else if(INTERRUPT_NUM==512)begin
            npu_ss_tniu_spram_512x26 u_sp_512_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
        else if(INTERRUPT_NUM==256)begin
            npu_ss_tniu_spram_256x26 u_sp_256_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
        else if(INTERRUPT_NUM==128)begin
            npu_ss_tniu_spram_128x26 u_sp_128_26 ( .clk(clk), .en(mem_en), .addr(mem_addr), .rd_data(spram_rd_ecc), .wr_data(spram_wr_ecc), .wr_bit_en(1'b1), .wr_en(mem_wren) );
        end
    endgenerate

    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_lut_sb (
        .clk(clk), .rst_n(rst_n), .err_in(mem_sb_err), .intr_out(tniu_lut_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_lut_db (
        .clk(clk), .rst_n(rst_n), .err_in(mem_db_err), .intr_out(tniu_lut_db_err)
    );

endmodule

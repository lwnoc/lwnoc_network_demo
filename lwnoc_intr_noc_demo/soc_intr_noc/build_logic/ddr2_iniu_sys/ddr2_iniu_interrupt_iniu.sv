module ddr2_iniu_interrupt_iniu
    import ddr2_iniu_interrupt_iniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                            clk                             ,
    input  logic                            rst_n                           ,

    //===========================================================================
    // interrupt input interface
    //===========================================================================
    input  logic [INTERRUPT_NUM-1       :0] v_interrupt                     ,
    //===========================================================================
    // interrupt noc interface
    //===========================================================================
    // | Channel Name | Direction | Payload Width | ID Width | Qos Width |
    // | ------------ | --------- | ------------- | -------- | --------- |
    // | Req          | I2T       | 40            | 8        | 4         |
    //===========================================================================
    // output logic                            iniu_out_vld                    ,
    // input  logic                            iniu_out_rdy                    ,
    // output ecc_pkg                          iniu_out_pld                    ,
    output logic                            req_valid                       ,
    input  logic                            req_ready                       ,
    output logic [39                    :0] req_payload                     ,
    output logic [7                     :0] req_srcid                       ,
    output logic [7                     :0] req_tgtid                       ,
    output logic [3                     :0] req_qos                         ,
    output logic                            req_last                        ,
    input  logic                            req_threshold                   ,

    //===========================================================================
    // APB interface
    //===========================================================================
	input  logic [31                    :0] p_addr                          ,
	input  logic                            p_sel                           ,
	input  logic                            p_enable                        ,
	input  logic                            p_write                         ,
	input  logic [31                    :0] p_wdata                         ,
	output logic                            p_ready                         ,
	output logic [31                    :0] p_rdata                         ,
	output logic                            p_slverr                        ,
    //===========================================================================
    // niu configure interface
    //===========================================================================
    input  logic [NIU_ID_WIDTH-1        :0] iniu_src_id                     ,
    //===========================================================================
    // mem interface
    //===========================================================================
    output logic [INTERRUPT_NUM_WIDTH-1 :0] addr                            ,
    output logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1:0] din                       ,
    input  logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1:0] dout                      ,
    output logic                            en                              ,
    output logic                            wren                            ,


    //===========================================================================
    // lp interface
    //===========================================================================
    input  logic                            stall                           ,
    input  logic                            partial_rst                     ,
    output logic                            idle

);

    function automatic logic [5:0] calc_intr_ecc (
        input logic        internal_init_i,
        input logic        toggle_flag_i,
        input logic [11:0] src_intr_id_i,
        input logic [7:0]  src_id_i,
        input logic [11:0] tgt_intr_id_i
    );
        logic [33:0] data;
        logic [5:0]  ecc;
        begin
            data = {internal_init_i, toggle_flag_i, src_intr_id_i, src_id_i, tgt_intr_id_i};
            ecc  = '0;
            for (int unsigned bit_idx = 0; bit_idx < 34; bit_idx++) begin
                if (data[bit_idx]) begin
                    // 1-based bit position parity mapping.
                    ecc ^= (bit_idx + 1);
                end
            end
            calc_intr_ecc = ecc;
        end
    endfunction


//===========================================================================
// logic declarations
//===========================================================================
    logic [INTERRUPT_NUM-1              :0]     v_enable;
    logic [INTERRUPT_NUM-1              :0]     v_intr_pulse_mode;
    logic [INTERRUPT_NUM-1              :0]     v_event_vld;
    logic [INTERRUPT_NUM-1              :0]     v_event_rdy;
    recorder_pkg                                v_event_pld[INTERRUPT_NUM-1:0];

    logic                                       m_event_vld;
    logic                                       m_event_rdy;
    recorder_pkg                                m_event_pld;

    logic                                       apb_w_req_rdy;
    logic                                       apb_w_req_vld;
    logic [INTERRUPT_NUM_WIDTH-1        :0]     apb_w_req_addr;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0]     apb_w_req_data;
    logic                                       apb_r_req_rdy;
    logic                                       apb_r_req_vld;
    logic [INTERRUPT_NUM_WIDTH-1        :0]     apb_r_req_addr;
    logic                                       apb_r_ack_vld;
    logic                                       apb_r_ack_rdy;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0]     apb_r_ack_data;

    logic                                       event_resp_vld;
    logic                                       event_resp_rdy;
    lut_pkg                                     event_resp_pld;

    logic                                       partial_rst_reg;
    logic                                       stall_reg;
    logic                                       idle_init;
    logic                                       arb_idle;
    logic [INTERRUPT_NUM-1              :0]     v_recorder_idle;
    logic [$clog2(IDLE_DELAY_MAX + 1)-1 :0]     idle_delay_cnt;
    //=======================================================================
    // for timing
    //=======================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            partial_rst_reg <= 1'b0;
            stall_reg       <= 1'b0;
            idle            <= 1'b0;
        end
        else begin
            partial_rst_reg <= partial_rst;
            stall_reg       <= stall;
            idle            <= (idle_delay_cnt >= IDLE_DELAY_MAX) && ~req_valid;
        end
    end
    //===========================================================================
    // lp idle
    //===========================================================================
    assign idle_init = &v_recorder_idle && arb_idle;
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            idle_delay_cnt <= 0;
        end
        else if(idle_init)begin
            if(idle_delay_cnt < IDLE_DELAY_MAX)begin
                idle_delay_cnt <= idle_delay_cnt + 1;
            end
        end
        else begin
            idle_delay_cnt <= 0;
        end
    end

    //===========================================================================
    // recorder
    //===========================================================================
`ifndef VERILATOR
    generate
        for(genvar i = 0; i < INTERRUPT_NUM; i=i+1) begin : gen_interrupt_iniu_event_recorder
            ddr2_iniu_interrupt_iniu_event_recorder #(
                .INTERRUPT_ID   (i                      )
            )u_interrupt_iniu_event_recorder (
                .clk            (clk                    ),
                .rst_n          (rst_n                  ),
                .enable         (v_enable[i]            ),
                .interrupt      (v_interrupt[i]         ),
                .event_vld      (v_event_vld[i]         ),
                .event_rdy      (v_event_rdy[i]         ),
                .event_pld      (v_event_pld[i]         ),

                .stall          (stall_reg              ),
                .partial_rst    (partial_rst_reg        ),
                .idle           (v_recorder_idle[i]     ),

                .intr_type      (v_intr_pulse_mode[i]   )
            );
        end
    endgenerate
`endif


    //===========================================================================
    // arbiter
    //===========================================================================

    ddr2_iniu_interrupt_iniu_arb #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_iniu_arb(
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .v_s_event_vld  (v_event_vld            ),
        .v_s_event_rdy  (v_event_rdy            ),
        .v_s_event_pld  (v_event_pld            ),

        .m_event_vld    (m_event_vld            ),
        .m_event_rdy    (m_event_rdy            ),
        .m_event_pld    (m_event_pld            ),

        .idle           (arb_idle               )
    );

    //===========================================================================
    // APB reg bank
    //===========================================================================
    ddr2_iniu_interrupt_iniu_reg_bank #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    ) u_interrupt_iniu_reg_bank(
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),
        .p_addr         (p_addr                 ),
        .p_sel          (p_sel                  ),
        .p_enable       (p_enable               ),
        .p_write        (p_write                ),
        .p_wdata        (p_wdata                ),
        .p_ready        (p_ready                ),
        .p_rdata        (p_rdata                ),
        .p_slverr       (p_slverr               ),

        .intr_lut_sram_enable(v_enable          ),
        .intr_pulse_mode    (v_intr_pulse_mode  ),

        .apb_w_req_rdy  (apb_w_req_rdy          ),
        .apb_w_req_vld  (apb_w_req_vld          ),
        .apb_w_req_addr (apb_w_req_addr         ),
        .apb_w_req_data (apb_w_req_data         ),

        .apb_r_req_rdy  (apb_r_req_rdy          ),
        .apb_r_req_vld  (apb_r_req_vld          ),
        .apb_r_req_addr (apb_r_req_addr         ),

        .apb_r_ack_vld  (apb_r_ack_vld          ),
        .apb_r_ack_rdy  (apb_r_ack_rdy          ),
        .apb_r_ack_data (apb_r_ack_data         )

    );

    //===========================================================================
    // lut
    //===========================================================================
    ddr2_iniu_interrupt_iniu_lut #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_iniu_lut (
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        // .iniu_src_id    (iniu_src_id            ),

        .event_req_vld  (m_event_vld            ),
        .event_req_rdy  (m_event_rdy            ),
        .event_req_pld  (m_event_pld            ),

        .apb_w_req_vld  (apb_w_req_vld          ),
        .apb_w_req_rdy  (apb_w_req_rdy          ),
        .apb_w_req_addr (apb_w_req_addr         ),
        .apb_w_req_data (apb_w_req_data         ),
        .apb_r_req_vld  (apb_r_req_vld          ),
        .apb_r_req_rdy  (apb_r_req_rdy          ),
        .apb_r_req_addr (apb_r_req_addr         ),
        .apb_resp_vld   (apb_r_ack_vld          ),
        .apb_resp_rdy   (apb_r_ack_rdy          ),
        .apb_resp_data  (apb_r_ack_data         ),

        .event_resp_vld (event_resp_vld         ),
        .event_resp_rdy (event_resp_rdy         ),
        .event_resp_pld (event_resp_pld         ),

        .addr           (addr                   ),
        .din            (din                    ),
        .dout           (dout                   ),
        .en             (en                     ),
        .wren           (wren                   )

        // .stall          (stall_reg              ),
        // .clear          (partial_rst_reg        ),
        // .idle           (lut_memory_idle        )
    );

    //===========================================================================
    // ecc encode done
    //===========================================================================


    logic           ecc_vld;
    logic           ecc_rdy;
    ecc_pkg         ecc_pld;

    assign ecc_vld = event_resp_vld;
    assign event_resp_rdy = ecc_rdy;
    assign ecc_pld.tgt_id = event_resp_pld.tgt_id;
    assign ecc_pld.tgt_intr_id = event_resp_pld.tgt_intr_id;
    assign ecc_pld.src_intr_id = event_resp_pld.src_intr_id;
    assign ecc_pld.toggle_flag = event_resp_pld.toggle_flag;
    assign ecc_pld.internal_init = event_resp_pld.internal_init;
    assign ecc_pld.ecc = calc_intr_ecc(
        event_resp_pld.internal_init,
        event_resp_pld.toggle_flag,
        event_resp_pld.src_intr_id,
        iniu_src_id,
        event_resp_pld.tgt_intr_id
    );

    //===========================================================================
    // reg slice
    //===========================================================================

    logic          ecc_reg_vld;
    logic          ecc_reg_rdy;
    ecc_pkg        ecc_reg_pld;

    fcip_reg_slice #(
        .PLD_TYPE      (ecc_pkg                )
    ) u_reg_slice (
        .clk           (clk                    ),
        .rst_n         (rst_n                  ),

        .s_vld         (ecc_vld                ),
        .s_rdy         (ecc_rdy                ),
        .s_pld         (ecc_pld                ),

        .m_vld         (ecc_reg_vld            ),
        .m_rdy         (ecc_reg_rdy            ),
        .m_pld         (ecc_reg_pld            )
    );
    //===========================================================================
    // noc interface
    //===========================================================================

    assign req_valid    = ecc_reg_vld;
    assign ecc_reg_rdy  = req_ready;
    assign req_payload  = {ecc_reg_pld.ecc, ecc_reg_pld.internal_init, ecc_reg_pld.toggle_flag, ecc_reg_pld.src_intr_id, iniu_src_id, ecc_reg_pld.tgt_intr_id};//12+12+8+1+1+6=40bit
    assign req_srcid    = iniu_src_id; //8bit
    assign req_tgtid    = ecc_reg_pld.tgt_id; //8bit
    assign req_qos      = 4'b0;
    assign req_last     = 1'b1;

endmodule

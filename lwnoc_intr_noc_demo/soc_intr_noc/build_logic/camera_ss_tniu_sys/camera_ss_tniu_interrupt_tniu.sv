module camera_ss_tniu_interrupt_tniu
    import camera_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                            clk                             ,
    input  logic                            rst_n                           ,

    //===========================================================================
    // interrupt noc interface
    //===========================================================================
    // | Channel Name | Direction | Payload Width | ID Width | Qos Width |
    // | ------------ | --------- | ------------- | -------- | --------- |
    // | Req          | I2T       | 40            | 8        | 4         |
    //===========================================================================
    // input  logic                            s_intr_niu_vld                  ,
    // output logic                            s_intr_niu_rdy                  ,
    // input  ecc_pkg                          s_intr_niu_pld                  ,

    input  logic                            req_valid                       ,
    output logic                            req_ready                       ,
    input  logic [39                    :0] req_payload                     ,
    input  logic [7                     :0] req_srcid                       ,
    input  logic [7                     :0] req_tgtid                       ,
    input  logic [3                     :0] req_qos                         ,
    input  logic                            req_last                        ,
    output                                  req_threshold                   ,

    //===========================================================================
    // interrupt interface
    //===========================================================================

    output logic [INTERRUPT_NUM-1       :0] v_interrupt                     ,
    output logic [INTERRUPT_NUM/32-1    :0] v_merge_interrupt               ,
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
    input  logic [NIU_ID_WIDTH-1        :0] tniu_tgt_id                     ,
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
    logic                                       p_ready_gen;
    logic                                       p_ready_internal;
    logic                                       p_ready_mem;
    logic                                       p_slverr_gen;
    logic                                       p_slverr_internal;
    logic                                       p_slverr_mem;
    logic [31                           :0]     p_rdata_gen;
    logic [31                           :0]     p_rdata_internal;
    logic [31                           :0]     p_rdata_mem;

    logic                                       ecc_vld;
    logic                                       ecc_rdy;
    logic                                       event_ecc_vld;
    logic                                       internal_interrupt_ecc_vld;
    logic                                       internal_interrupt_ecc_rdy;
    logic                                       context_pre_alloc_vld;
    logic                                       context_pre_alloc_rdy;
    logic                                       internal_interrupt_tgt_id_vld;
    logic                                       internal_interrupt_tgt_id_rdy;
    logic                                       internal_interrupt_overflow_vld;
    logic                                       internal_interrupt_overflow_rdy;
    logic                                       inernal_interrupt_tgt_intr_id_vld;
    logic                                       inernal_interrupt_tgt_intr_id_rdy;
    logic                                       event_interrupt_vld;
    logic                                       event_interrupt_rdy;
    logic                                       conflict_flag_en;
    logic                                       conflict_check_en;
    logic                                       conflict_check_en_r;
    logic                                       context_intr_toggle_flag;
    logic                                       partial_rst_reg;
    logic [5                            :0]     ecc_expected;
    logic                                       ecc_error;

    logic [INTERRUPT_NUM-1              :0]     v_context_intr_en;
    logic [31                           :0]     internal_intr_ecc_wdata;
    logic [INTERNAL_INTR_NUM-1          :0]     internal_intr_en;
    logic [CONTEXT_NUM_WIDTH-1          :0]     context_pre_alloc_id;
    logic [31                           :0]     internal_intr_tgt_id_wdata;
    logic [31                           :0]     internal_intr_overflow_wdata;
    logic [31                           :0]     internal_intr_intr_id_wdata;
    logic [31                           :0]     internal_intr_conflict_wdata;
    logic [INTERRUPT_NUM-1              :0]     intr_raw_status;
    logic [INTERRUPT_NUM-1              :0]     intr_merge_mask;
    logic [INTERRUPT_NUM-1              :0]     intr_pulse_mode;
    logic [INTERRUPT_NUM-1              :0]     intr_set;
    logic [INTERRUPT_NUM-1              :0]     intr_clr;
    logic [INTERRUPT_NUM-1              :0]     v_interrupt_idle;

    ecc_pkg                                     ecc_pld;
    event_pkg                                   event_interrupt_pld;
    event_pkg                                   conflict_check_pld;
    event_pkg                                   conflict_check_pld_r;

    //=======================================================================
    // for timing
    //=======================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            partial_rst_reg <= 1'b0;
        end
        else begin
            partial_rst_reg <= partial_rst;
        end
    end

    //===========================================================================
    // lp idle
    //===========================================================================
    assign idle = &v_interrupt_idle;
    //===========================================================================
    // ecc decode done
    //===========================================================================
    assign req_threshold = 1'b1;
    assign ecc_vld = req_valid;
    assign ecc_pld.ecc = req_payload[39:34];
    assign ecc_pld.internal_init = req_payload[33];
    assign ecc_pld.toggle_flag = req_payload[32];
    assign ecc_pld.src_intr_id = req_payload[31:20];
    assign ecc_pld.src_id = req_payload[19:12];
    assign ecc_pld.tgt_intr_id = req_payload[11:0];

    assign ecc_expected = calc_intr_ecc(
        ecc_pld.internal_init,
        ecc_pld.toggle_flag,
        ecc_pld.src_intr_id,
        ecc_pld.src_id,
        ecc_pld.tgt_intr_id
    );
    assign ecc_error = (ecc_pld.ecc != ecc_expected);

    assign event_ecc_vld = ecc_vld && ~ecc_error;
    assign req_ready = ecc_error ? internal_interrupt_ecc_rdy : ecc_rdy;

    assign internal_interrupt_ecc_vld = ecc_vld && req_ready && ecc_error;
    assign internal_interrupt_ecc_rdy = 1'b1;
    assign internal_intr_ecc_wdata = {8'b0,ecc_pld.src_id,4'b0,ecc_pld.src_intr_id};;


    //===========================================================================
    // pre alloc && internal interrupt
    //===========================================================================

    camera_ss_tniu_interrupt_tniu_xbar_internal #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu_xbar_internal(
        .clk                            (clk                            ),
        .rst_n                          (rst_n                          ),

        .ecc_vld                        (event_ecc_vld                  ),
        .ecc_rdy                        (ecc_rdy                        ),
        .ecc_pld                        (ecc_pld                        ),

        .context_pre_alloc_vld          (context_pre_alloc_vld          ),
        .context_pre_alloc_rdy          (context_pre_alloc_rdy          ),
        .context_pre_alloc_id           (context_pre_alloc_id           ),

        .internal_interrupt_tgt_id_vld  (internal_interrupt_tgt_id_vld  ),
        .internal_interrupt_tgt_id_rdy  (internal_interrupt_tgt_id_rdy  ),
        .internal_interrupt_tgt_id_wdat (internal_intr_tgt_id_wdata     ),

        .internal_interrupt_overflow_vld(internal_interrupt_overflow_vld),
        .internal_interrupt_overflow_rdy(internal_interrupt_overflow_rdy),
        .internal_interrupt_overflow_wdat(internal_intr_overflow_wdata  ),

        .inernal_interrupt_tgt_intr_id_vld(inernal_interrupt_tgt_intr_id_vld),
        .inernal_interrupt_tgt_intr_id_rdy(inernal_interrupt_tgt_intr_id_rdy),
        .inernal_interrupt_tgt_intr_id_wdat(internal_intr_intr_id_wdata     ),

        .event_interrupt_vld            (event_interrupt_vld            ),
        .event_interrupt_rdy            (event_interrupt_rdy            ),
        .event_interrupt_pld            (event_interrupt_pld            )
    );
    //===========================================================================
    // glue logic
    //===========================================================================
    assign internal_interrupt_tgt_id_rdy = 1'b1;
    assign internal_interrupt_overflow_rdy = 1'b1;
    assign inernal_interrupt_tgt_intr_id_rdy = 1'b1;
    always_comb begin
        internal_intr_en = {INTERNAL_INTR_NUM{1'b0}};
        internal_intr_en[INTERNAL_TGT_ID_ERROR_ID] = internal_interrupt_tgt_id_vld && internal_interrupt_tgt_id_rdy;
        internal_intr_en[INTERNAL_OVERFLOW_ERROR_ID] = internal_interrupt_overflow_vld && internal_interrupt_overflow_rdy;
        internal_intr_en[INTERNAL_TGT_INTR_ID_ERROR_ID] = inernal_interrupt_tgt_intr_id_vld && inernal_interrupt_tgt_intr_id_rdy;
        internal_intr_en[INTERNAL_ECC_ERROR_ID] = internal_interrupt_ecc_vld && internal_interrupt_ecc_rdy;
        internal_intr_en[INTERNAL_CONFLICT_ERROR_ID] = conflict_flag_en;

    end

    //===========================================================================
    // APB ready arb
    //===========================================================================

    always_comb begin
        if(p_addr < INTR_INTERNAL_BASE_ADDR)begin
            p_ready = p_ready_gen;
        end
        else if(p_addr < INTR_CONFLICT_BASE_ADDR)begin
            p_ready = p_ready_internal;
        end
        else begin
            p_ready = p_ready_mem;
        end
    end
    always_comb begin
        if(p_addr < INTR_INTERNAL_BASE_ADDR)begin
            p_slverr = p_slverr_gen;
        end
        else if(p_addr < INTR_CONFLICT_BASE_ADDR)begin
            p_slverr = p_slverr_internal;
        end
        else begin
            p_slverr = p_slverr_mem;
        end
    end
    always_comb begin
        if(p_addr < INTR_INTERNAL_BASE_ADDR)begin
            p_rdata = p_rdata_gen;
        end
        else if(p_addr < INTR_CONFLICT_BASE_ADDR)begin
            p_rdata = p_rdata_internal;
        end
        else begin
            p_rdata = p_rdata_mem;
        end
    end
    //===========================================================================
    // APB reg bank -- raw mask set clear
    //===========================================================================

    camera_ss_tniu_interrupt_tniu_generate_reg_bank #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu_generate_reg_bank(
        .clk           (clk                    ),
        .rst_n         (rst_n                  ),
        .p_addr        (p_addr                 ),
        .p_sel         (p_sel                  ),
        .p_enable      (p_enable               ),
        .p_write       (p_write                ),
        .p_wdata       (p_wdata                ),
        .p_ready       (p_ready_gen            ),
        .p_rdata       (p_rdata_gen            ),
        .p_slverr      (p_slverr_gen           ),

        .intr_raw_status(intr_raw_status       ),
        .intr_merge_mask(intr_merge_mask       ),
        .intr_pulse_mode(intr_pulse_mode       ),
        .intr_set      (intr_set               ),
        .intr_clr      (intr_clr               )

    );


    //===========================================================================
    // APB reg bank -- conflict checker
    //===========================================================================
    camera_ss_tniu_interrupt_tniu_mem_reg_bank #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu_mem_reg_bank(
        .clk           (clk                    ),
        .rst_n         (rst_n                  ),
        .p_addr        (p_addr                 ),
        .p_sel         (p_sel                  ),
        .p_enable      (p_enable               ),
        .p_write       (p_write                ),
        .p_wdata       (p_wdata                ),
        .p_ready       (p_ready_mem            ),
        .p_rdata       (p_rdata_mem            ),
        .p_slverr      (p_slverr_mem           ),

        .apb_r_req_rdy (apb_r_req_rdy          ),
        .apb_r_req_vld (apb_r_req_vld          ),
        .apb_r_req_addr(apb_r_req_addr         ),

        .apb_r_ack_vld (apb_r_ack_vld          ),
        .apb_r_ack_rdy (apb_r_ack_rdy          ),
        .apb_r_ack_data(apb_r_ack_data         )
    );

    //===========================================================================
    // APB reg bank -- internal inerrupt message
    //===========================================================================
    camera_ss_tniu_Regbank_regbank_tniu_internal_intr u_apb_internal_reg_bank(
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .paddr          (p_addr                 ),
        .psel           (p_sel                  ),
        .penable        (p_enable               ),
        .pwrite         (p_write                ),
        .pwdata         (p_wdata                ),
        .pready         (p_ready_internal       ),
        .prdata         (p_rdata_internal       ),
        .pslverr        (p_slverr_internal      ),

        .internal_intr_message_0_internal_intr_message_wdat(internal_intr_overflow_wdata),
        .internal_intr_message_0_internal_intr_message_wena(internal_intr_en[INTERNAL_OVERFLOW_ERROR_ID]  ),
        .internal_intr_message_1_internal_intr_message_wdat(internal_intr_ecc_wdata     ),
        .internal_intr_message_1_internal_intr_message_wena(internal_intr_en[INTERNAL_ECC_ERROR_ID]       ),
        .internal_intr_message_2_internal_intr_message_wdat(internal_intr_conflict_wdata),
        .internal_intr_message_2_internal_intr_message_wena(internal_intr_en[INTERNAL_CONFLICT_ERROR_ID]  ),
        .internal_intr_message_3_internal_intr_message_wdat(internal_intr_tgt_id_wdata  ),
        .internal_intr_message_3_internal_intr_message_wena(internal_intr_en[INTERNAL_TGT_ID_ERROR_ID]    ),
        .internal_intr_message_4_internal_intr_message_wdat(internal_intr_intr_id_wdata ),
        .internal_intr_message_4_internal_intr_message_wena(internal_intr_en[INTERNAL_TGT_INTR_ID_ERROR_ID]   ),

        .internal_intr_message_5_internal_intr_message_wdat(32'b0                       ),
        .internal_intr_message_5_internal_intr_message_wena(1'b0                        ),
        .internal_intr_message_6_internal_intr_message_wdat(32'b0                       ),
        .internal_intr_message_6_internal_intr_message_wena(1'b0                        ),
        .internal_intr_message_7_internal_intr_message_wdat(32'b0                       ),
        .internal_intr_message_7_internal_intr_message_wena(1'b0                        ),
        .internal_intr_message_8_internal_intr_message_wdat(32'b0                       ),
        .internal_intr_message_8_internal_intr_message_wena(1'b0                        ),
        .internal_intr_message_9_internal_intr_message_wdat(32'b0                       ),
        .internal_intr_message_9_internal_intr_message_wena(1'b0                        ),
        .internal_intr_message_10_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_10_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_11_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_11_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_12_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_12_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_13_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_13_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_14_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_14_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_15_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_15_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_16_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_16_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_17_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_17_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_18_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_18_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_19_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_19_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_20_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_20_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_21_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_21_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_22_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_22_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_23_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_23_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_24_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_24_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_25_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_25_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_26_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_26_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_27_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_27_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_28_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_28_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_29_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_29_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_30_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_30_internal_intr_message_wena(1'b0                       ),
        .internal_intr_message_31_internal_intr_message_wdat(32'b0                      ),
        .internal_intr_message_31_internal_intr_message_wena(1'b0                       )
    );




    //===========================================================================
    // conflict check
    //===========================================================================

    camera_ss_tniu_interrupt_tniu_event_conflict_check #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu_event_conflict_check (
        .clk                    (clk                    ),
        .rst_n                  (rst_n                  ),

        .event_req_vld          (event_interrupt_vld    ),
        .event_req_rdy          (event_interrupt_rdy    ),
        .event_req_pld          (event_interrupt_pld    ),

        .apb_r_req_vld          (apb_r_req_vld          ),
        .apb_r_req_rdy          (apb_r_req_rdy          ),
        .apb_r_req_addr         (apb_r_req_addr         ),

        .apb_resp_vld           (apb_r_ack_vld          ),
        .apb_resp_rdy           (apb_r_ack_rdy          ),
        .apb_resp_data          (apb_r_ack_data         ),

        .conflict_check_en      (conflict_check_en      ),
        .conflict_check_pld     (conflict_check_pld     ),

        .conflict_flag_en       (conflict_flag_en       ),
        .conflict_message       (internal_intr_conflict_wdata),

        //mem port
        .addr                   (addr                   ),
        .din                    (din                    ),
        .dout                   (dout                   ),
        .en                     (en                     ),
        .wren                   (wren                   )

        // //lowpower
        // .stall                  (stall_reg              ),
        // .clear                  (partial_rst_reg        ),
        // .idle                   (conflict_idle          )
    );
    // for timing
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            conflict_check_en_r <= 1'b0;
        end
        else begin
            conflict_check_en_r <= conflict_check_en;
        end
    end
    always_ff @(posedge clk) begin
        if(conflict_check_en)begin
            conflict_check_pld_r <= conflict_check_pld;
        end
    end
    //===========================================================================
    // interrupt_tniu_context
    //===========================================================================
    camera_ss_tniu_interrupt_tniu_context #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu_context(
        .clk                    (clk                    ),
        .rst_n                  (rst_n                  ),

        .context_pre_alloc_vld  (context_pre_alloc_vld  ),
        .context_pre_alloc_rdy  (context_pre_alloc_rdy  ),
        .context_pre_alloc_id   (context_pre_alloc_id   ),

        .context_en             (conflict_check_en_r    ),
        .context_pld            (conflict_check_pld_r   ),

        .v_context_intr_en      (v_context_intr_en      ),
        .context_intr_toggle_flag(context_intr_toggle_flag)

    );

    //===========================================================================
    // glue logic
    //===========================================================================
    generate
        for(genvar i=0; i<INTERRUPT_NUM/32; i=i+1) begin : GEN_INTR_MERGE

            camera_ss_tniu_interrupt_tniu_event_merge u_interrupt_tniu_event_merge(
                .clk            (clk                        ),
                .rst_n          (rst_n                      ),

                .intr_mask      (intr_merge_mask[i*32 +:32] ),

                .intr_en        (intr_raw_status[i*32 +:32] ),
                .intr_merge     (v_merge_interrupt[i]       )
            );
        end
        for(genvar i=0; i<INTERRUPT_NUM; i=i+1) begin : GEN_INTR_NORMAL
            if(i<INTERNAL_INTR_NUM) begin : GEN_INTERNAL_EN
                camera_ss_tniu_interrupt_tniu_event_repeater u_interrupt_tniu_event_repeater(
                    .clk            (clk                        ),
                    .rst_n          (rst_n                      ),

                    .intr_set       (intr_set[i]                ),
                    .intr_clr       (intr_clr[i]                ),

                    .intr_en        (internal_intr_en[i]        ),
                    .intr_toggle    (1'b1                       ),

                    .intr_type      (1'b0                       ),

                    .interrupt      (intr_raw_status[i]         ),

                    .partial_reset  (partial_rst_reg            ),
                    .idle           (v_interrupt_idle[i]        )
                );
            end
            else begin : GEN_NORMAL_EN
                camera_ss_tniu_interrupt_tniu_event_repeater u_interrupt_tniu_event_repeater(
                    .clk            (clk                        ),
                    .rst_n          (rst_n                      ),

                    .intr_set       (intr_set[i]                ),
                    .intr_clr       (intr_clr[i]                ),

                    .intr_en        (v_context_intr_en[i]       ),
                    .intr_toggle    (context_intr_toggle_flag   ),

                    .intr_type      (intr_pulse_mode[i]         ),

                    .interrupt      (intr_raw_status[i]         ),

                    .partial_reset  (partial_rst_reg            ),
                    .idle           (v_interrupt_idle[i]        )
                );
            end
        end

    endgenerate

    assign v_interrupt = intr_raw_status;




endmodule

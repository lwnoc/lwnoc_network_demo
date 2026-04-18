module ucie_ss0_iniu_interrupt_iniu_arb
    import ucie_ss0_iniu_interrupt_iniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                            clk                             ,
    input  logic                            rst_n                           ,

    input  logic [INTERRUPT_NUM-1       :0] v_s_event_vld                   ,
    output logic [INTERRUPT_NUM-1       :0] v_s_event_rdy                   ,
    input  recorder_pkg                     v_s_event_pld[INTERRUPT_NUM-1:0],

    output logic                            m_event_vld                     ,
    input  logic                            m_event_rdy                     ,
    output recorder_pkg                     m_event_pld                     ,

    output logic                            idle



);

    //===========================================================================
    // logic declarations
    //===========================================================================

    logic                                       m_event_vld_comb                                ;
    logic                                       m_event_rdy_comb                                ;
    logic [$bits(recorder_pkg)-1        :0]     m_event_pld_vector                              ;
    logic [$bits(recorder_pkg)-1        :0]     m_event_pld_comb_vector                         ;
    logic [$bits(recorder_pkg)-1        :0]     v_event_pld_vector      [INTERRUPT_NUM-1    :0] ;

    logic [ARB_LEVEL_0-1                :0]     v_event_vld_level                               ;
    logic [ARB_LEVEL_0-1                :0]     v_event_rdy_level                               ;
    logic [$bits(recorder_pkg)-1        :0]     v_event_pld_level       [ARB_LEVEL_0-1      :0] ;
    logic [ARB_LEVEL_0-1                :0]     v_event_vld_level_reg                           ;
    logic [ARB_LEVEL_0-1                :0]     v_event_rdy_level_reg                           ;
    logic [$bits(recorder_pkg)-1        :0]     v_event_pld_level_reg   [ARB_LEVEL_0-1      :0] ;

    logic [ARB_LEVEL_1-1                :0]     v_event_vld_level_2                             ;
    logic [ARB_LEVEL_1-1                :0]     v_event_rdy_level_2                             ;
    logic [$bits(recorder_pkg)-1        :0]     v_event_pld_level_2     [ARB_LEVEL_1-1      :0] ;
    logic [ARB_LEVEL_1-1                :0]     v_event_vld_level_2_reg                         ;
    logic [ARB_LEVEL_1-1                :0]     v_event_rdy_level_2_reg                         ;
    logic [$bits(recorder_pkg)-1        :0]     v_event_pld_level_2_reg [ARB_LEVEL_1-1      :0] ;
    //===========================================================================
    // type switch
    //===========================================================================

    generate
        for(genvar i = 0; i < INTERRUPT_NUM; i=i+1) begin : gen_interrupt_iniu_event_pld_vector
            assign v_event_pld_vector[i] = v_s_event_pld[i];
        end
    endgenerate
    assign m_event_pld = recorder_pkg'(m_event_pld_vector);

    //===========================================================================
    // arb
    //===========================================================================
    generate
        //===========================================================================
        // 1 level arb
        //===========================================================================

        if(INTERRUPT_NUM<=ARB_LEVEL_0)begin
            fcip_arb_vrp #(
                .WIDTH          (INTERRUPT_NUM               ),
                .PLD_WIDTH      ($bits(recorder_pkg)         ),
                .MODE           (1                           ),
                .HSK_MODE       (1                           )
            ) u_fcip_arb_vrp (
                .clk            (clk                         ),
                .rst_n          (rst_n                       ),

                .v_vld_s        (v_s_event_vld               ),
                .v_rdy_s        (v_s_event_rdy               ),
                .v_pld_s        (v_event_pld_vector          ),

                .vld_m          (m_event_vld_comb            ),
                .rdy_m          (m_event_rdy_comb            ),
                .pld_m          (m_event_pld_comb_vector     )
            );

            fcip_reg_slice #(
                .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
            ) u_reg_slice   (
                .clk           (clk                             ),
                .rst_n         (rst_n                           ),

                .s_vld         (m_event_vld_comb                ),
                .s_rdy         (m_event_rdy_comb                ),
                .s_pld         (m_event_pld_comb_vector         ),

                .m_vld         (m_event_vld                     ),
                .m_rdy         (m_event_rdy                     ),
                .m_pld         (m_event_pld_vector              )
            );

            assign idle = ~m_event_vld;

        end

        //===========================================================================
        // 2 level arb
        //===========================================================================

        else if(INTERRUPT_NUM<=ARB_LEVEL_1)begin
            //parameter
            localparam integer unsigned ADAPTER_WIDTH        = INTERRUPT_NUM/ARB_LEVEL_0;
            //  idle
            assign idle = ~|v_event_vld_level_reg && ~m_event_vld;
            // l1 arbiter
            for(genvar i = 0; i < ARB_LEVEL_0; i=i+1) begin : gen_fcip_arb_vrp_array
                fcip_arb_vrp #(
                    .WIDTH          (ADAPTER_WIDTH               ),
                    .PLD_WIDTH      ($bits(recorder_pkg)         ),
                    .MODE           (1                           ),
                    .HSK_MODE       (1                           )
                ) u_fcip_arb_vrp (
                    .clk            (clk                         ),
                    .rst_n          (rst_n                       ),

                    .v_vld_s        (v_s_event_vld[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]     ),
                    .v_rdy_s        (v_s_event_rdy[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]     ),
                    .v_pld_s        (v_event_pld_vector[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]),

                    .vld_m          (v_event_vld_level[i]        ),
                    .rdy_m          (v_event_rdy_level[i]        ),
                    .pld_m          (v_event_pld_level[i]        )
                );

                fcip_reg_slice #(
                    .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
                ) u_reg_slice   (
                    .clk           (clk                             ),
                    .rst_n         (rst_n                           ),

                    .s_vld         (v_event_vld_level[i]            ),
                    .s_rdy         (v_event_rdy_level[i]            ),
                    .s_pld         (v_event_pld_level[i]            ),

                    .m_vld         (v_event_vld_level_reg[i]        ),
                    .m_rdy         (v_event_rdy_level_reg[i]        ),
                    .m_pld         (v_event_pld_level_reg[i]        )
                );
            end
            // level 2 arbiter
            fcip_arb_vrp #(
                .WIDTH          (ARB_LEVEL_0                 ),
                .PLD_WIDTH      ($bits(recorder_pkg)         ),
                .MODE           (1                           ),
                .HSK_MODE       (1                           )
            ) u_fcip_arb_vrp (
                .clk            (clk                         ),
                .rst_n          (rst_n                       ),

                .v_vld_s        (v_event_vld_level_reg       ),
                .v_rdy_s        (v_event_rdy_level_reg       ),
                .v_pld_s        (v_event_pld_level_reg       ),

                .vld_m          (m_event_vld_comb            ),
                .rdy_m          (m_event_rdy_comb            ),
                .pld_m          (m_event_pld_comb_vector     )
            );

            fcip_reg_slice #(
                .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
            ) u_reg_slice   (
                .clk           (clk                             ),
                .rst_n         (rst_n                           ),

                .s_vld         (m_event_vld_comb                ),
                .s_rdy         (m_event_rdy_comb                ),
                .s_pld         (m_event_pld_comb_vector         ),

                .m_vld         (m_event_vld                     ),
                .m_rdy         (m_event_rdy                     ),
                .m_pld         (m_event_pld_vector              )
            );


        end
        //===========================================================================
        // 3 level arb
        //===========================================================================

        else begin
            //  parameter declaration
            localparam integer unsigned ADAPTER_WIDTH        = INTERRUPT_NUM/ARB_LEVEL_1;
            localparam integer unsigned L1_WIDTH             = ARB_LEVEL_1/ARB_LEVEL_0;
            //  idle
            assign idle = ~|v_event_vld_level_2_reg && ~|v_event_vld_level_reg && ~m_event_vld;
            // l1 arbiter
            for(genvar i = 0; i < ARB_LEVEL_1; i=i+1) begin : gen_fcip_arb_vrp_array_2
                fcip_arb_vrp #(
                    .WIDTH          (ADAPTER_WIDTH                 ),
                    .PLD_WIDTH      ($bits(recorder_pkg)           ),
                    .MODE           (1                             ),
                    .HSK_MODE       (1                             )
                ) u_fcip_arb_vrp (
                    .clk            (clk                           ),
                    .rst_n          (rst_n                         ),

                    .v_vld_s        (v_s_event_vld[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]     ),
                    .v_rdy_s        (v_s_event_rdy[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]     ),
                    .v_pld_s        (v_event_pld_vector[i*ADAPTER_WIDTH+:ADAPTER_WIDTH]),

                    .vld_m          (v_event_vld_level_2[i]        ),
                    .rdy_m          (v_event_rdy_level_2[i]        ),
                    .pld_m          (v_event_pld_level_2[i]        )
                );

                fcip_reg_slice #(
                    .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
                ) u_reg_slice   (
                    .clk           (clk                               ),
                    .rst_n         (rst_n                             ),

                    .s_vld         (v_event_vld_level_2[i]            ),
                    .s_rdy         (v_event_rdy_level_2[i]            ),
                    .s_pld         (v_event_pld_level_2[i]            ),

                    .m_vld         (v_event_vld_level_2_reg[i]        ),
                    .m_rdy         (v_event_rdy_level_2_reg[i]        ),
                    .m_pld         (v_event_pld_level_2_reg[i]        )
                );
            end
            // level 2 arbiter
            for(genvar i = 0; i < ARB_LEVEL_0; i=i+1) begin : gen_fcip_arb_vrp_array
                fcip_arb_vrp #(
                    .WIDTH          (L1_WIDTH                    ),
                    .PLD_WIDTH      ($bits(recorder_pkg)         ),
                    .MODE           (1                           ),
                    .HSK_MODE       (1                           )
                ) u_fcip_arb_vrp (
                    .clk            (clk                         ),
                    .rst_n          (rst_n                       ),

                    .v_vld_s        (v_event_vld_level_2_reg[i*L1_WIDTH+:L1_WIDTH]  ),
                    .v_rdy_s        (v_event_rdy_level_2_reg[i*L1_WIDTH+:L1_WIDTH]  ),
                    .v_pld_s        (v_event_pld_level_2_reg[i*L1_WIDTH+:L1_WIDTH]  ),

                    .vld_m          (v_event_vld_level[i]        ),
                    .rdy_m          (v_event_rdy_level[i]        ),
                    .pld_m          (v_event_pld_level[i]        )
                );

                fcip_reg_slice #(
                    .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
                ) u_reg_slice   (
                    .clk           (clk                             ),
                    .rst_n         (rst_n                           ),

                    .s_vld         (v_event_vld_level[i]            ),
                    .s_rdy         (v_event_rdy_level[i]            ),
                    .s_pld         (v_event_pld_level[i]            ),

                    .m_vld         (v_event_vld_level_reg[i]        ),
                    .m_rdy         (v_event_rdy_level_reg[i]        ),
                    .m_pld         (v_event_pld_level_reg[i]        )
                );
            end
            // level 3 arbiter
            fcip_arb_vrp #(
                .WIDTH          (ARB_LEVEL_0                 ),
                .PLD_WIDTH      ($bits(recorder_pkg)         ),
                .MODE           (1                           ),
                .HSK_MODE       (1                           )
            ) u_fcip_arb_vrp (
                .clk            (clk                         ),
                .rst_n          (rst_n                       ),

                .v_vld_s        (v_event_vld_level_reg       ),
                .v_rdy_s        (v_event_rdy_level_reg       ),
                .v_pld_s        (v_event_pld_level_reg       ),

                .vld_m          (m_event_vld_comb            ),
                .rdy_m          (m_event_rdy_comb            ),
                .pld_m          (m_event_pld_comb_vector     )
            );

            fcip_reg_slice #(
                .PLD_TYPE      (logic [$bits(recorder_pkg)-1:0] )
            ) u_reg_slice   (
                .clk           (clk                             ),
                .rst_n         (rst_n                           ),

                .s_vld         (m_event_vld_comb                ),
                .s_rdy         (m_event_rdy_comb                ),
                .s_pld         (m_event_pld_comb_vector         ),

                .m_vld         (m_event_vld                     ),
                .m_rdy         (m_event_rdy                     ),
                .m_pld         (m_event_pld_vector              )
            );
        end

    endgenerate


endmodule

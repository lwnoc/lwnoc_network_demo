//[UHDL]Content Start [md5:22d6e018a1e108e9420d0c5404509362]
module ucie_ss_tniu_Regbank_regbank_tniu_internal_intr (
	input             clk                                                ,
	input             rst_n                                              ,
	input      [31:0] p_addr                                             ,
	input             p_sel                                              ,
	input             p_enable                                           ,
	input             p_write                                            ,
	input      [31:0] p_wdata                                            ,
	output            p_ready                                            ,
	output     [31:0] p_rdata                                            ,
	output            p_slverr                                           ,
	output reg        parity_sw_check_err                                ,
	input      [31:0] internal_intr_message_0_internal_intr_message_wdat ,
	input             internal_intr_message_0_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_0_internal_intr_message_rdat ,
	output            internal_intr_message_0_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_1_internal_intr_message_wdat ,
	input             internal_intr_message_1_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_1_internal_intr_message_rdat ,
	output            internal_intr_message_1_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_2_internal_intr_message_wdat ,
	input             internal_intr_message_2_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_2_internal_intr_message_rdat ,
	output            internal_intr_message_2_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_3_internal_intr_message_wdat ,
	input             internal_intr_message_3_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_3_internal_intr_message_rdat ,
	output            internal_intr_message_3_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_4_internal_intr_message_wdat ,
	input             internal_intr_message_4_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_4_internal_intr_message_rdat ,
	output            internal_intr_message_4_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_5_internal_intr_message_wdat ,
	input             internal_intr_message_5_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_5_internal_intr_message_rdat ,
	output            internal_intr_message_5_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_6_internal_intr_message_wdat ,
	input             internal_intr_message_6_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_6_internal_intr_message_rdat ,
	output            internal_intr_message_6_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_7_internal_intr_message_wdat ,
	input             internal_intr_message_7_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_7_internal_intr_message_rdat ,
	output            internal_intr_message_7_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_8_internal_intr_message_wdat ,
	input             internal_intr_message_8_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_8_internal_intr_message_rdat ,
	output            internal_intr_message_8_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_9_internal_intr_message_wdat ,
	input             internal_intr_message_9_internal_intr_message_wena ,
	output     [31:0] internal_intr_message_9_internal_intr_message_rdat ,
	output            internal_intr_message_9_parity_hw_check_err        ,
	input      [31:0] internal_intr_message_10_internal_intr_message_wdat,
	input             internal_intr_message_10_internal_intr_message_wena,
	output     [31:0] internal_intr_message_10_internal_intr_message_rdat,
	output            internal_intr_message_10_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_11_internal_intr_message_wdat,
	input             internal_intr_message_11_internal_intr_message_wena,
	output     [31:0] internal_intr_message_11_internal_intr_message_rdat,
	output            internal_intr_message_11_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_12_internal_intr_message_wdat,
	input             internal_intr_message_12_internal_intr_message_wena,
	output     [31:0] internal_intr_message_12_internal_intr_message_rdat,
	output            internal_intr_message_12_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_13_internal_intr_message_wdat,
	input             internal_intr_message_13_internal_intr_message_wena,
	output     [31:0] internal_intr_message_13_internal_intr_message_rdat,
	output            internal_intr_message_13_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_14_internal_intr_message_wdat,
	input             internal_intr_message_14_internal_intr_message_wena,
	output     [31:0] internal_intr_message_14_internal_intr_message_rdat,
	output            internal_intr_message_14_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_15_internal_intr_message_wdat,
	input             internal_intr_message_15_internal_intr_message_wena,
	output     [31:0] internal_intr_message_15_internal_intr_message_rdat,
	output            internal_intr_message_15_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_16_internal_intr_message_wdat,
	input             internal_intr_message_16_internal_intr_message_wena,
	output     [31:0] internal_intr_message_16_internal_intr_message_rdat,
	output            internal_intr_message_16_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_17_internal_intr_message_wdat,
	input             internal_intr_message_17_internal_intr_message_wena,
	output     [31:0] internal_intr_message_17_internal_intr_message_rdat,
	output            internal_intr_message_17_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_18_internal_intr_message_wdat,
	input             internal_intr_message_18_internal_intr_message_wena,
	output     [31:0] internal_intr_message_18_internal_intr_message_rdat,
	output            internal_intr_message_18_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_19_internal_intr_message_wdat,
	input             internal_intr_message_19_internal_intr_message_wena,
	output     [31:0] internal_intr_message_19_internal_intr_message_rdat,
	output            internal_intr_message_19_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_20_internal_intr_message_wdat,
	input             internal_intr_message_20_internal_intr_message_wena,
	output     [31:0] internal_intr_message_20_internal_intr_message_rdat,
	output            internal_intr_message_20_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_21_internal_intr_message_wdat,
	input             internal_intr_message_21_internal_intr_message_wena,
	output     [31:0] internal_intr_message_21_internal_intr_message_rdat,
	output            internal_intr_message_21_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_22_internal_intr_message_wdat,
	input             internal_intr_message_22_internal_intr_message_wena,
	output     [31:0] internal_intr_message_22_internal_intr_message_rdat,
	output            internal_intr_message_22_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_23_internal_intr_message_wdat,
	input             internal_intr_message_23_internal_intr_message_wena,
	output     [31:0] internal_intr_message_23_internal_intr_message_rdat,
	output            internal_intr_message_23_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_24_internal_intr_message_wdat,
	input             internal_intr_message_24_internal_intr_message_wena,
	output     [31:0] internal_intr_message_24_internal_intr_message_rdat,
	output            internal_intr_message_24_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_25_internal_intr_message_wdat,
	input             internal_intr_message_25_internal_intr_message_wena,
	output     [31:0] internal_intr_message_25_internal_intr_message_rdat,
	output            internal_intr_message_25_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_26_internal_intr_message_wdat,
	input             internal_intr_message_26_internal_intr_message_wena,
	output     [31:0] internal_intr_message_26_internal_intr_message_rdat,
	output            internal_intr_message_26_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_27_internal_intr_message_wdat,
	input             internal_intr_message_27_internal_intr_message_wena,
	output     [31:0] internal_intr_message_27_internal_intr_message_rdat,
	output            internal_intr_message_27_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_28_internal_intr_message_wdat,
	input             internal_intr_message_28_internal_intr_message_wena,
	output     [31:0] internal_intr_message_28_internal_intr_message_rdat,
	output            internal_intr_message_28_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_29_internal_intr_message_wdat,
	input             internal_intr_message_29_internal_intr_message_wena,
	output     [31:0] internal_intr_message_29_internal_intr_message_rdat,
	output            internal_intr_message_29_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_30_internal_intr_message_wdat,
	input             internal_intr_message_30_internal_intr_message_wena,
	output     [31:0] internal_intr_message_30_internal_intr_message_rdat,
	output            internal_intr_message_30_parity_hw_check_err       ,
	input      [31:0] internal_intr_message_31_internal_intr_message_wdat,
	input             internal_intr_message_31_internal_intr_message_wena,
	output     [31:0] internal_intr_message_31_internal_intr_message_rdat,
	output            internal_intr_message_31_parity_hw_check_err       );

	//Wire define for this module.
	wire [31:0] rreq_addr                                            ;
	reg  [31:0] rack_data                                            ;
	wire [31:0] wreq_addr                                            ;
	wire [31:0] wreq_data                                            ;
	wire [0:0]  wreq_vld                                             ;
	wire [31:0] internal_intr_message_0_rdat                         ;
	reg  [31:0] internal_intr_message_0_internal_intr_message        ;
	reg  [31:0] internal_intr_message_0_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_0_parity_ena                   ;
	wire [31:0] internal_intr_message_0_parity_wdata                 ;
	wire [3:0]  internal_intr_message_0_parity_update                ;
	reg  [3:0]  internal_intr_message_0_parity_bit                   ;
	wire [3:0]  internal_intr_message_0_parity_check_bit             ;
	wire [31:0] internal_intr_message_0_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_0_parity_check_err             ;
	wire [31:0] internal_intr_message_1_rdat                         ;
	reg  [31:0] internal_intr_message_1_internal_intr_message        ;
	reg  [31:0] internal_intr_message_1_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_1_parity_ena                   ;
	wire [31:0] internal_intr_message_1_parity_wdata                 ;
	wire [3:0]  internal_intr_message_1_parity_update                ;
	reg  [3:0]  internal_intr_message_1_parity_bit                   ;
	wire [3:0]  internal_intr_message_1_parity_check_bit             ;
	wire [31:0] internal_intr_message_1_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_1_parity_check_err             ;
	wire [31:0] internal_intr_message_2_rdat                         ;
	reg  [31:0] internal_intr_message_2_internal_intr_message        ;
	reg  [31:0] internal_intr_message_2_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_2_parity_ena                   ;
	wire [31:0] internal_intr_message_2_parity_wdata                 ;
	wire [3:0]  internal_intr_message_2_parity_update                ;
	reg  [3:0]  internal_intr_message_2_parity_bit                   ;
	wire [3:0]  internal_intr_message_2_parity_check_bit             ;
	wire [31:0] internal_intr_message_2_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_2_parity_check_err             ;
	wire [31:0] internal_intr_message_3_rdat                         ;
	reg  [31:0] internal_intr_message_3_internal_intr_message        ;
	reg  [31:0] internal_intr_message_3_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_3_parity_ena                   ;
	wire [31:0] internal_intr_message_3_parity_wdata                 ;
	wire [3:0]  internal_intr_message_3_parity_update                ;
	reg  [3:0]  internal_intr_message_3_parity_bit                   ;
	wire [3:0]  internal_intr_message_3_parity_check_bit             ;
	wire [31:0] internal_intr_message_3_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_3_parity_check_err             ;
	wire [31:0] internal_intr_message_4_rdat                         ;
	reg  [31:0] internal_intr_message_4_internal_intr_message        ;
	reg  [31:0] internal_intr_message_4_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_4_parity_ena                   ;
	wire [31:0] internal_intr_message_4_parity_wdata                 ;
	wire [3:0]  internal_intr_message_4_parity_update                ;
	reg  [3:0]  internal_intr_message_4_parity_bit                   ;
	wire [3:0]  internal_intr_message_4_parity_check_bit             ;
	wire [31:0] internal_intr_message_4_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_4_parity_check_err             ;
	wire [31:0] internal_intr_message_5_rdat                         ;
	reg  [31:0] internal_intr_message_5_internal_intr_message        ;
	reg  [31:0] internal_intr_message_5_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_5_parity_ena                   ;
	wire [31:0] internal_intr_message_5_parity_wdata                 ;
	wire [3:0]  internal_intr_message_5_parity_update                ;
	reg  [3:0]  internal_intr_message_5_parity_bit                   ;
	wire [3:0]  internal_intr_message_5_parity_check_bit             ;
	wire [31:0] internal_intr_message_5_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_5_parity_check_err             ;
	wire [31:0] internal_intr_message_6_rdat                         ;
	reg  [31:0] internal_intr_message_6_internal_intr_message        ;
	reg  [31:0] internal_intr_message_6_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_6_parity_ena                   ;
	wire [31:0] internal_intr_message_6_parity_wdata                 ;
	wire [3:0]  internal_intr_message_6_parity_update                ;
	reg  [3:0]  internal_intr_message_6_parity_bit                   ;
	wire [3:0]  internal_intr_message_6_parity_check_bit             ;
	wire [31:0] internal_intr_message_6_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_6_parity_check_err             ;
	wire [31:0] internal_intr_message_7_rdat                         ;
	reg  [31:0] internal_intr_message_7_internal_intr_message        ;
	reg  [31:0] internal_intr_message_7_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_7_parity_ena                   ;
	wire [31:0] internal_intr_message_7_parity_wdata                 ;
	wire [3:0]  internal_intr_message_7_parity_update                ;
	reg  [3:0]  internal_intr_message_7_parity_bit                   ;
	wire [3:0]  internal_intr_message_7_parity_check_bit             ;
	wire [31:0] internal_intr_message_7_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_7_parity_check_err             ;
	wire [31:0] internal_intr_message_8_rdat                         ;
	reg  [31:0] internal_intr_message_8_internal_intr_message        ;
	reg  [31:0] internal_intr_message_8_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_8_parity_ena                   ;
	wire [31:0] internal_intr_message_8_parity_wdata                 ;
	wire [3:0]  internal_intr_message_8_parity_update                ;
	reg  [3:0]  internal_intr_message_8_parity_bit                   ;
	wire [3:0]  internal_intr_message_8_parity_check_bit             ;
	wire [31:0] internal_intr_message_8_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_8_parity_check_err             ;
	wire [31:0] internal_intr_message_9_rdat                         ;
	reg  [31:0] internal_intr_message_9_internal_intr_message        ;
	reg  [31:0] internal_intr_message_9_internal_intr_message_parity ;
	wire [0:0]  internal_intr_message_9_parity_ena                   ;
	wire [31:0] internal_intr_message_9_parity_wdata                 ;
	wire [3:0]  internal_intr_message_9_parity_update                ;
	reg  [3:0]  internal_intr_message_9_parity_bit                   ;
	wire [3:0]  internal_intr_message_9_parity_check_bit             ;
	wire [31:0] internal_intr_message_9_parity_check_wdata           ;
	wire [0:0]  internal_intr_message_9_parity_check_err             ;
	wire [31:0] internal_intr_message_10_rdat                        ;
	reg  [31:0] internal_intr_message_10_internal_intr_message       ;
	reg  [31:0] internal_intr_message_10_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_10_parity_ena                  ;
	wire [31:0] internal_intr_message_10_parity_wdata                ;
	wire [3:0]  internal_intr_message_10_parity_update               ;
	reg  [3:0]  internal_intr_message_10_parity_bit                  ;
	wire [3:0]  internal_intr_message_10_parity_check_bit            ;
	wire [31:0] internal_intr_message_10_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_10_parity_check_err            ;
	wire [31:0] internal_intr_message_11_rdat                        ;
	reg  [31:0] internal_intr_message_11_internal_intr_message       ;
	reg  [31:0] internal_intr_message_11_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_11_parity_ena                  ;
	wire [31:0] internal_intr_message_11_parity_wdata                ;
	wire [3:0]  internal_intr_message_11_parity_update               ;
	reg  [3:0]  internal_intr_message_11_parity_bit                  ;
	wire [3:0]  internal_intr_message_11_parity_check_bit            ;
	wire [31:0] internal_intr_message_11_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_11_parity_check_err            ;
	wire [31:0] internal_intr_message_12_rdat                        ;
	reg  [31:0] internal_intr_message_12_internal_intr_message       ;
	reg  [31:0] internal_intr_message_12_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_12_parity_ena                  ;
	wire [31:0] internal_intr_message_12_parity_wdata                ;
	wire [3:0]  internal_intr_message_12_parity_update               ;
	reg  [3:0]  internal_intr_message_12_parity_bit                  ;
	wire [3:0]  internal_intr_message_12_parity_check_bit            ;
	wire [31:0] internal_intr_message_12_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_12_parity_check_err            ;
	wire [31:0] internal_intr_message_13_rdat                        ;
	reg  [31:0] internal_intr_message_13_internal_intr_message       ;
	reg  [31:0] internal_intr_message_13_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_13_parity_ena                  ;
	wire [31:0] internal_intr_message_13_parity_wdata                ;
	wire [3:0]  internal_intr_message_13_parity_update               ;
	reg  [3:0]  internal_intr_message_13_parity_bit                  ;
	wire [3:0]  internal_intr_message_13_parity_check_bit            ;
	wire [31:0] internal_intr_message_13_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_13_parity_check_err            ;
	wire [31:0] internal_intr_message_14_rdat                        ;
	reg  [31:0] internal_intr_message_14_internal_intr_message       ;
	reg  [31:0] internal_intr_message_14_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_14_parity_ena                  ;
	wire [31:0] internal_intr_message_14_parity_wdata                ;
	wire [3:0]  internal_intr_message_14_parity_update               ;
	reg  [3:0]  internal_intr_message_14_parity_bit                  ;
	wire [3:0]  internal_intr_message_14_parity_check_bit            ;
	wire [31:0] internal_intr_message_14_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_14_parity_check_err            ;
	wire [31:0] internal_intr_message_15_rdat                        ;
	reg  [31:0] internal_intr_message_15_internal_intr_message       ;
	reg  [31:0] internal_intr_message_15_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_15_parity_ena                  ;
	wire [31:0] internal_intr_message_15_parity_wdata                ;
	wire [3:0]  internal_intr_message_15_parity_update               ;
	reg  [3:0]  internal_intr_message_15_parity_bit                  ;
	wire [3:0]  internal_intr_message_15_parity_check_bit            ;
	wire [31:0] internal_intr_message_15_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_15_parity_check_err            ;
	wire [31:0] internal_intr_message_16_rdat                        ;
	reg  [31:0] internal_intr_message_16_internal_intr_message       ;
	reg  [31:0] internal_intr_message_16_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_16_parity_ena                  ;
	wire [31:0] internal_intr_message_16_parity_wdata                ;
	wire [3:0]  internal_intr_message_16_parity_update               ;
	reg  [3:0]  internal_intr_message_16_parity_bit                  ;
	wire [3:0]  internal_intr_message_16_parity_check_bit            ;
	wire [31:0] internal_intr_message_16_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_16_parity_check_err            ;
	wire [31:0] internal_intr_message_17_rdat                        ;
	reg  [31:0] internal_intr_message_17_internal_intr_message       ;
	reg  [31:0] internal_intr_message_17_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_17_parity_ena                  ;
	wire [31:0] internal_intr_message_17_parity_wdata                ;
	wire [3:0]  internal_intr_message_17_parity_update               ;
	reg  [3:0]  internal_intr_message_17_parity_bit                  ;
	wire [3:0]  internal_intr_message_17_parity_check_bit            ;
	wire [31:0] internal_intr_message_17_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_17_parity_check_err            ;
	wire [31:0] internal_intr_message_18_rdat                        ;
	reg  [31:0] internal_intr_message_18_internal_intr_message       ;
	reg  [31:0] internal_intr_message_18_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_18_parity_ena                  ;
	wire [31:0] internal_intr_message_18_parity_wdata                ;
	wire [3:0]  internal_intr_message_18_parity_update               ;
	reg  [3:0]  internal_intr_message_18_parity_bit                  ;
	wire [3:0]  internal_intr_message_18_parity_check_bit            ;
	wire [31:0] internal_intr_message_18_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_18_parity_check_err            ;
	wire [31:0] internal_intr_message_19_rdat                        ;
	reg  [31:0] internal_intr_message_19_internal_intr_message       ;
	reg  [31:0] internal_intr_message_19_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_19_parity_ena                  ;
	wire [31:0] internal_intr_message_19_parity_wdata                ;
	wire [3:0]  internal_intr_message_19_parity_update               ;
	reg  [3:0]  internal_intr_message_19_parity_bit                  ;
	wire [3:0]  internal_intr_message_19_parity_check_bit            ;
	wire [31:0] internal_intr_message_19_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_19_parity_check_err            ;
	wire [31:0] internal_intr_message_20_rdat                        ;
	reg  [31:0] internal_intr_message_20_internal_intr_message       ;
	reg  [31:0] internal_intr_message_20_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_20_parity_ena                  ;
	wire [31:0] internal_intr_message_20_parity_wdata                ;
	wire [3:0]  internal_intr_message_20_parity_update               ;
	reg  [3:0]  internal_intr_message_20_parity_bit                  ;
	wire [3:0]  internal_intr_message_20_parity_check_bit            ;
	wire [31:0] internal_intr_message_20_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_20_parity_check_err            ;
	wire [31:0] internal_intr_message_21_rdat                        ;
	reg  [31:0] internal_intr_message_21_internal_intr_message       ;
	reg  [31:0] internal_intr_message_21_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_21_parity_ena                  ;
	wire [31:0] internal_intr_message_21_parity_wdata                ;
	wire [3:0]  internal_intr_message_21_parity_update               ;
	reg  [3:0]  internal_intr_message_21_parity_bit                  ;
	wire [3:0]  internal_intr_message_21_parity_check_bit            ;
	wire [31:0] internal_intr_message_21_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_21_parity_check_err            ;
	wire [31:0] internal_intr_message_22_rdat                        ;
	reg  [31:0] internal_intr_message_22_internal_intr_message       ;
	reg  [31:0] internal_intr_message_22_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_22_parity_ena                  ;
	wire [31:0] internal_intr_message_22_parity_wdata                ;
	wire [3:0]  internal_intr_message_22_parity_update               ;
	reg  [3:0]  internal_intr_message_22_parity_bit                  ;
	wire [3:0]  internal_intr_message_22_parity_check_bit            ;
	wire [31:0] internal_intr_message_22_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_22_parity_check_err            ;
	wire [31:0] internal_intr_message_23_rdat                        ;
	reg  [31:0] internal_intr_message_23_internal_intr_message       ;
	reg  [31:0] internal_intr_message_23_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_23_parity_ena                  ;
	wire [31:0] internal_intr_message_23_parity_wdata                ;
	wire [3:0]  internal_intr_message_23_parity_update               ;
	reg  [3:0]  internal_intr_message_23_parity_bit                  ;
	wire [3:0]  internal_intr_message_23_parity_check_bit            ;
	wire [31:0] internal_intr_message_23_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_23_parity_check_err            ;
	wire [31:0] internal_intr_message_24_rdat                        ;
	reg  [31:0] internal_intr_message_24_internal_intr_message       ;
	reg  [31:0] internal_intr_message_24_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_24_parity_ena                  ;
	wire [31:0] internal_intr_message_24_parity_wdata                ;
	wire [3:0]  internal_intr_message_24_parity_update               ;
	reg  [3:0]  internal_intr_message_24_parity_bit                  ;
	wire [3:0]  internal_intr_message_24_parity_check_bit            ;
	wire [31:0] internal_intr_message_24_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_24_parity_check_err            ;
	wire [31:0] internal_intr_message_25_rdat                        ;
	reg  [31:0] internal_intr_message_25_internal_intr_message       ;
	reg  [31:0] internal_intr_message_25_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_25_parity_ena                  ;
	wire [31:0] internal_intr_message_25_parity_wdata                ;
	wire [3:0]  internal_intr_message_25_parity_update               ;
	reg  [3:0]  internal_intr_message_25_parity_bit                  ;
	wire [3:0]  internal_intr_message_25_parity_check_bit            ;
	wire [31:0] internal_intr_message_25_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_25_parity_check_err            ;
	wire [31:0] internal_intr_message_26_rdat                        ;
	reg  [31:0] internal_intr_message_26_internal_intr_message       ;
	reg  [31:0] internal_intr_message_26_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_26_parity_ena                  ;
	wire [31:0] internal_intr_message_26_parity_wdata                ;
	wire [3:0]  internal_intr_message_26_parity_update               ;
	reg  [3:0]  internal_intr_message_26_parity_bit                  ;
	wire [3:0]  internal_intr_message_26_parity_check_bit            ;
	wire [31:0] internal_intr_message_26_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_26_parity_check_err            ;
	wire [31:0] internal_intr_message_27_rdat                        ;
	reg  [31:0] internal_intr_message_27_internal_intr_message       ;
	reg  [31:0] internal_intr_message_27_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_27_parity_ena                  ;
	wire [31:0] internal_intr_message_27_parity_wdata                ;
	wire [3:0]  internal_intr_message_27_parity_update               ;
	reg  [3:0]  internal_intr_message_27_parity_bit                  ;
	wire [3:0]  internal_intr_message_27_parity_check_bit            ;
	wire [31:0] internal_intr_message_27_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_27_parity_check_err            ;
	wire [31:0] internal_intr_message_28_rdat                        ;
	reg  [31:0] internal_intr_message_28_internal_intr_message       ;
	reg  [31:0] internal_intr_message_28_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_28_parity_ena                  ;
	wire [31:0] internal_intr_message_28_parity_wdata                ;
	wire [3:0]  internal_intr_message_28_parity_update               ;
	reg  [3:0]  internal_intr_message_28_parity_bit                  ;
	wire [3:0]  internal_intr_message_28_parity_check_bit            ;
	wire [31:0] internal_intr_message_28_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_28_parity_check_err            ;
	wire [31:0] internal_intr_message_29_rdat                        ;
	reg  [31:0] internal_intr_message_29_internal_intr_message       ;
	reg  [31:0] internal_intr_message_29_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_29_parity_ena                  ;
	wire [31:0] internal_intr_message_29_parity_wdata                ;
	wire [3:0]  internal_intr_message_29_parity_update               ;
	reg  [3:0]  internal_intr_message_29_parity_bit                  ;
	wire [3:0]  internal_intr_message_29_parity_check_bit            ;
	wire [31:0] internal_intr_message_29_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_29_parity_check_err            ;
	wire [31:0] internal_intr_message_30_rdat                        ;
	reg  [31:0] internal_intr_message_30_internal_intr_message       ;
	reg  [31:0] internal_intr_message_30_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_30_parity_ena                  ;
	wire [31:0] internal_intr_message_30_parity_wdata                ;
	wire [3:0]  internal_intr_message_30_parity_update               ;
	reg  [3:0]  internal_intr_message_30_parity_bit                  ;
	wire [3:0]  internal_intr_message_30_parity_check_bit            ;
	wire [31:0] internal_intr_message_30_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_30_parity_check_err            ;
	wire [31:0] internal_intr_message_31_rdat                        ;
	reg  [31:0] internal_intr_message_31_internal_intr_message       ;
	reg  [31:0] internal_intr_message_31_internal_intr_message_parity;
	wire [0:0]  internal_intr_message_31_parity_ena                  ;
	wire [31:0] internal_intr_message_31_parity_wdata                ;
	wire [3:0]  internal_intr_message_31_parity_update               ;
	reg  [3:0]  internal_intr_message_31_parity_bit                  ;
	wire [3:0]  internal_intr_message_31_parity_check_bit            ;
	wire [31:0] internal_intr_message_31_parity_check_wdata          ;
	wire [0:0]  internal_intr_message_31_parity_check_err            ;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign p_ready = 1'b1;

	assign p_rdata = rack_data;

	assign p_slverr = 1'b0;

	assign rreq_addr = p_addr;

	always @(*) begin
	    if((rreq_addr == 32'h1400)) rack_data = internal_intr_message_0_rdat;
	    else if((rreq_addr == 32'h1404)) rack_data = internal_intr_message_1_rdat;
	    else if((rreq_addr == 32'h1408)) rack_data = internal_intr_message_2_rdat;
	    else if((rreq_addr == 32'h140c)) rack_data = internal_intr_message_3_rdat;
	    else if((rreq_addr == 32'h1410)) rack_data = internal_intr_message_4_rdat;
	    else if((rreq_addr == 32'h1414)) rack_data = internal_intr_message_5_rdat;
	    else if((rreq_addr == 32'h1418)) rack_data = internal_intr_message_6_rdat;
	    else if((rreq_addr == 32'h141c)) rack_data = internal_intr_message_7_rdat;
	    else if((rreq_addr == 32'h1420)) rack_data = internal_intr_message_8_rdat;
	    else if((rreq_addr == 32'h1424)) rack_data = internal_intr_message_9_rdat;
	    else if((rreq_addr == 32'h1428)) rack_data = internal_intr_message_10_rdat;
	    else if((rreq_addr == 32'h142c)) rack_data = internal_intr_message_11_rdat;
	    else if((rreq_addr == 32'h1430)) rack_data = internal_intr_message_12_rdat;
	    else if((rreq_addr == 32'h1434)) rack_data = internal_intr_message_13_rdat;
	    else if((rreq_addr == 32'h1438)) rack_data = internal_intr_message_14_rdat;
	    else if((rreq_addr == 32'h143c)) rack_data = internal_intr_message_15_rdat;
	    else if((rreq_addr == 32'h1440)) rack_data = internal_intr_message_16_rdat;
	    else if((rreq_addr == 32'h1444)) rack_data = internal_intr_message_17_rdat;
	    else if((rreq_addr == 32'h1448)) rack_data = internal_intr_message_18_rdat;
	    else if((rreq_addr == 32'h144c)) rack_data = internal_intr_message_19_rdat;
	    else if((rreq_addr == 32'h1450)) rack_data = internal_intr_message_20_rdat;
	    else if((rreq_addr == 32'h1454)) rack_data = internal_intr_message_21_rdat;
	    else if((rreq_addr == 32'h1458)) rack_data = internal_intr_message_22_rdat;
	    else if((rreq_addr == 32'h145c)) rack_data = internal_intr_message_23_rdat;
	    else if((rreq_addr == 32'h1460)) rack_data = internal_intr_message_24_rdat;
	    else if((rreq_addr == 32'h1464)) rack_data = internal_intr_message_25_rdat;
	    else if((rreq_addr == 32'h1468)) rack_data = internal_intr_message_26_rdat;
	    else if((rreq_addr == 32'h146c)) rack_data = internal_intr_message_27_rdat;
	    else if((rreq_addr == 32'h1470)) rack_data = internal_intr_message_28_rdat;
	    else if((rreq_addr == 32'h1474)) rack_data = internal_intr_message_29_rdat;
	    else if((rreq_addr == 32'h1478)) rack_data = internal_intr_message_30_rdat;
	    else if((rreq_addr == 32'h147c)) rack_data = internal_intr_message_31_rdat;
	    else rack_data = 32'hfffffffe;
	end

	assign wreq_addr = p_addr;

	assign wreq_data = p_wdata;

	assign wreq_vld = (p_write & p_sel & p_enable);

	always @(*) begin
	    if((rreq_addr == 32'h1400)) parity_sw_check_err = internal_intr_message_0_parity_check_err;
	    else if((rreq_addr == 32'h1404)) parity_sw_check_err = internal_intr_message_1_parity_check_err;
	    else if((rreq_addr == 32'h1408)) parity_sw_check_err = internal_intr_message_2_parity_check_err;
	    else if((rreq_addr == 32'h140c)) parity_sw_check_err = internal_intr_message_3_parity_check_err;
	    else if((rreq_addr == 32'h1410)) parity_sw_check_err = internal_intr_message_4_parity_check_err;
	    else if((rreq_addr == 32'h1414)) parity_sw_check_err = internal_intr_message_5_parity_check_err;
	    else if((rreq_addr == 32'h1418)) parity_sw_check_err = internal_intr_message_6_parity_check_err;
	    else if((rreq_addr == 32'h141c)) parity_sw_check_err = internal_intr_message_7_parity_check_err;
	    else if((rreq_addr == 32'h1420)) parity_sw_check_err = internal_intr_message_8_parity_check_err;
	    else if((rreq_addr == 32'h1424)) parity_sw_check_err = internal_intr_message_9_parity_check_err;
	    else if((rreq_addr == 32'h1428)) parity_sw_check_err = internal_intr_message_10_parity_check_err;
	    else if((rreq_addr == 32'h142c)) parity_sw_check_err = internal_intr_message_11_parity_check_err;
	    else if((rreq_addr == 32'h1430)) parity_sw_check_err = internal_intr_message_12_parity_check_err;
	    else if((rreq_addr == 32'h1434)) parity_sw_check_err = internal_intr_message_13_parity_check_err;
	    else if((rreq_addr == 32'h1438)) parity_sw_check_err = internal_intr_message_14_parity_check_err;
	    else if((rreq_addr == 32'h143c)) parity_sw_check_err = internal_intr_message_15_parity_check_err;
	    else if((rreq_addr == 32'h1440)) parity_sw_check_err = internal_intr_message_16_parity_check_err;
	    else if((rreq_addr == 32'h1444)) parity_sw_check_err = internal_intr_message_17_parity_check_err;
	    else if((rreq_addr == 32'h1448)) parity_sw_check_err = internal_intr_message_18_parity_check_err;
	    else if((rreq_addr == 32'h144c)) parity_sw_check_err = internal_intr_message_19_parity_check_err;
	    else if((rreq_addr == 32'h1450)) parity_sw_check_err = internal_intr_message_20_parity_check_err;
	    else if((rreq_addr == 32'h1454)) parity_sw_check_err = internal_intr_message_21_parity_check_err;
	    else if((rreq_addr == 32'h1458)) parity_sw_check_err = internal_intr_message_22_parity_check_err;
	    else if((rreq_addr == 32'h145c)) parity_sw_check_err = internal_intr_message_23_parity_check_err;
	    else if((rreq_addr == 32'h1460)) parity_sw_check_err = internal_intr_message_24_parity_check_err;
	    else if((rreq_addr == 32'h1464)) parity_sw_check_err = internal_intr_message_25_parity_check_err;
	    else if((rreq_addr == 32'h1468)) parity_sw_check_err = internal_intr_message_26_parity_check_err;
	    else if((rreq_addr == 32'h146c)) parity_sw_check_err = internal_intr_message_27_parity_check_err;
	    else if((rreq_addr == 32'h1470)) parity_sw_check_err = internal_intr_message_28_parity_check_err;
	    else if((rreq_addr == 32'h1474)) parity_sw_check_err = internal_intr_message_29_parity_check_err;
	    else if((rreq_addr == 32'h1478)) parity_sw_check_err = internal_intr_message_30_parity_check_err;
	    else if((rreq_addr == 32'h147c)) parity_sw_check_err = internal_intr_message_31_parity_check_err;
	    else parity_sw_check_err = 1'b0;
	end

	assign internal_intr_message_0_rdat = {internal_intr_message_0_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_0_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_0_internal_intr_message_wena) internal_intr_message_0_internal_intr_message <= internal_intr_message_0_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_0_internal_intr_message_rdat = internal_intr_message_0_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_0_internal_intr_message_wena) internal_intr_message_0_internal_intr_message_parity = internal_intr_message_0_internal_intr_message_wdat;
	    else internal_intr_message_0_internal_intr_message_parity = internal_intr_message_0_internal_intr_message;
	end

	assign internal_intr_message_0_parity_ena = (internal_intr_message_0_internal_intr_message_wena);

	assign internal_intr_message_0_parity_wdata = {internal_intr_message_0_internal_intr_message_parity[31], internal_intr_message_0_internal_intr_message_parity[30], internal_intr_message_0_internal_intr_message_parity[29], internal_intr_message_0_internal_intr_message_parity[28], internal_intr_message_0_internal_intr_message_parity[27], internal_intr_message_0_internal_intr_message_parity[26], internal_intr_message_0_internal_intr_message_parity[25], internal_intr_message_0_internal_intr_message_parity[24], internal_intr_message_0_internal_intr_message_parity[23], internal_intr_message_0_internal_intr_message_parity[22], internal_intr_message_0_internal_intr_message_parity[21], internal_intr_message_0_internal_intr_message_parity[20], internal_intr_message_0_internal_intr_message_parity[19], internal_intr_message_0_internal_intr_message_parity[18], internal_intr_message_0_internal_intr_message_parity[17], internal_intr_message_0_internal_intr_message_parity[16], internal_intr_message_0_internal_intr_message_parity[15], internal_intr_message_0_internal_intr_message_parity[14], internal_intr_message_0_internal_intr_message_parity[13], internal_intr_message_0_internal_intr_message_parity[12], internal_intr_message_0_internal_intr_message_parity[11], internal_intr_message_0_internal_intr_message_parity[10], internal_intr_message_0_internal_intr_message_parity[9], internal_intr_message_0_internal_intr_message_parity[8], internal_intr_message_0_internal_intr_message_parity[7], internal_intr_message_0_internal_intr_message_parity[6], internal_intr_message_0_internal_intr_message_parity[5], internal_intr_message_0_internal_intr_message_parity[4], internal_intr_message_0_internal_intr_message_parity[3], internal_intr_message_0_internal_intr_message_parity[2], internal_intr_message_0_internal_intr_message_parity[1], internal_intr_message_0_internal_intr_message_parity[0]};

	assign internal_intr_message_0_parity_update = {(^internal_intr_message_0_parity_wdata[31:24]), (^internal_intr_message_0_parity_wdata[23:16]), (^internal_intr_message_0_parity_wdata[15:8]), (^internal_intr_message_0_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_0_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_0_parity_ena) internal_intr_message_0_parity_bit <= internal_intr_message_0_parity_update;
	    end
	end

	assign internal_intr_message_0_parity_check_bit = {(^internal_intr_message_0_parity_check_wdata[31:24]), (^internal_intr_message_0_parity_check_wdata[23:16]), (^internal_intr_message_0_parity_check_wdata[15:8]), (^internal_intr_message_0_parity_check_wdata[7:0])};

	assign internal_intr_message_0_parity_check_wdata = {internal_intr_message_0_internal_intr_message[31], internal_intr_message_0_internal_intr_message[30], internal_intr_message_0_internal_intr_message[29], internal_intr_message_0_internal_intr_message[28], internal_intr_message_0_internal_intr_message[27], internal_intr_message_0_internal_intr_message[26], internal_intr_message_0_internal_intr_message[25], internal_intr_message_0_internal_intr_message[24], internal_intr_message_0_internal_intr_message[23], internal_intr_message_0_internal_intr_message[22], internal_intr_message_0_internal_intr_message[21], internal_intr_message_0_internal_intr_message[20], internal_intr_message_0_internal_intr_message[19], internal_intr_message_0_internal_intr_message[18], internal_intr_message_0_internal_intr_message[17], internal_intr_message_0_internal_intr_message[16], internal_intr_message_0_internal_intr_message[15], internal_intr_message_0_internal_intr_message[14], internal_intr_message_0_internal_intr_message[13], internal_intr_message_0_internal_intr_message[12], internal_intr_message_0_internal_intr_message[11], internal_intr_message_0_internal_intr_message[10], internal_intr_message_0_internal_intr_message[9], internal_intr_message_0_internal_intr_message[8], internal_intr_message_0_internal_intr_message[7], internal_intr_message_0_internal_intr_message[6], internal_intr_message_0_internal_intr_message[5], internal_intr_message_0_internal_intr_message[4], internal_intr_message_0_internal_intr_message[3], internal_intr_message_0_internal_intr_message[2], internal_intr_message_0_internal_intr_message[1], internal_intr_message_0_internal_intr_message[0]};

	assign internal_intr_message_0_parity_check_err = (internal_intr_message_0_parity_check_bit != internal_intr_message_0_parity_bit);

	assign internal_intr_message_0_parity_hw_check_err = internal_intr_message_0_parity_check_err;

	assign internal_intr_message_1_rdat = {internal_intr_message_1_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_1_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_1_internal_intr_message_wena) internal_intr_message_1_internal_intr_message <= internal_intr_message_1_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_1_internal_intr_message_rdat = internal_intr_message_1_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_1_internal_intr_message_wena) internal_intr_message_1_internal_intr_message_parity = internal_intr_message_1_internal_intr_message_wdat;
	    else internal_intr_message_1_internal_intr_message_parity = internal_intr_message_1_internal_intr_message;
	end

	assign internal_intr_message_1_parity_ena = (internal_intr_message_1_internal_intr_message_wena);

	assign internal_intr_message_1_parity_wdata = {internal_intr_message_1_internal_intr_message_parity[31], internal_intr_message_1_internal_intr_message_parity[30], internal_intr_message_1_internal_intr_message_parity[29], internal_intr_message_1_internal_intr_message_parity[28], internal_intr_message_1_internal_intr_message_parity[27], internal_intr_message_1_internal_intr_message_parity[26], internal_intr_message_1_internal_intr_message_parity[25], internal_intr_message_1_internal_intr_message_parity[24], internal_intr_message_1_internal_intr_message_parity[23], internal_intr_message_1_internal_intr_message_parity[22], internal_intr_message_1_internal_intr_message_parity[21], internal_intr_message_1_internal_intr_message_parity[20], internal_intr_message_1_internal_intr_message_parity[19], internal_intr_message_1_internal_intr_message_parity[18], internal_intr_message_1_internal_intr_message_parity[17], internal_intr_message_1_internal_intr_message_parity[16], internal_intr_message_1_internal_intr_message_parity[15], internal_intr_message_1_internal_intr_message_parity[14], internal_intr_message_1_internal_intr_message_parity[13], internal_intr_message_1_internal_intr_message_parity[12], internal_intr_message_1_internal_intr_message_parity[11], internal_intr_message_1_internal_intr_message_parity[10], internal_intr_message_1_internal_intr_message_parity[9], internal_intr_message_1_internal_intr_message_parity[8], internal_intr_message_1_internal_intr_message_parity[7], internal_intr_message_1_internal_intr_message_parity[6], internal_intr_message_1_internal_intr_message_parity[5], internal_intr_message_1_internal_intr_message_parity[4], internal_intr_message_1_internal_intr_message_parity[3], internal_intr_message_1_internal_intr_message_parity[2], internal_intr_message_1_internal_intr_message_parity[1], internal_intr_message_1_internal_intr_message_parity[0]};

	assign internal_intr_message_1_parity_update = {(^internal_intr_message_1_parity_wdata[31:24]), (^internal_intr_message_1_parity_wdata[23:16]), (^internal_intr_message_1_parity_wdata[15:8]), (^internal_intr_message_1_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_1_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_1_parity_ena) internal_intr_message_1_parity_bit <= internal_intr_message_1_parity_update;
	    end
	end

	assign internal_intr_message_1_parity_check_bit = {(^internal_intr_message_1_parity_check_wdata[31:24]), (^internal_intr_message_1_parity_check_wdata[23:16]), (^internal_intr_message_1_parity_check_wdata[15:8]), (^internal_intr_message_1_parity_check_wdata[7:0])};

	assign internal_intr_message_1_parity_check_wdata = {internal_intr_message_1_internal_intr_message[31], internal_intr_message_1_internal_intr_message[30], internal_intr_message_1_internal_intr_message[29], internal_intr_message_1_internal_intr_message[28], internal_intr_message_1_internal_intr_message[27], internal_intr_message_1_internal_intr_message[26], internal_intr_message_1_internal_intr_message[25], internal_intr_message_1_internal_intr_message[24], internal_intr_message_1_internal_intr_message[23], internal_intr_message_1_internal_intr_message[22], internal_intr_message_1_internal_intr_message[21], internal_intr_message_1_internal_intr_message[20], internal_intr_message_1_internal_intr_message[19], internal_intr_message_1_internal_intr_message[18], internal_intr_message_1_internal_intr_message[17], internal_intr_message_1_internal_intr_message[16], internal_intr_message_1_internal_intr_message[15], internal_intr_message_1_internal_intr_message[14], internal_intr_message_1_internal_intr_message[13], internal_intr_message_1_internal_intr_message[12], internal_intr_message_1_internal_intr_message[11], internal_intr_message_1_internal_intr_message[10], internal_intr_message_1_internal_intr_message[9], internal_intr_message_1_internal_intr_message[8], internal_intr_message_1_internal_intr_message[7], internal_intr_message_1_internal_intr_message[6], internal_intr_message_1_internal_intr_message[5], internal_intr_message_1_internal_intr_message[4], internal_intr_message_1_internal_intr_message[3], internal_intr_message_1_internal_intr_message[2], internal_intr_message_1_internal_intr_message[1], internal_intr_message_1_internal_intr_message[0]};

	assign internal_intr_message_1_parity_check_err = (internal_intr_message_1_parity_check_bit != internal_intr_message_1_parity_bit);

	assign internal_intr_message_1_parity_hw_check_err = internal_intr_message_1_parity_check_err;

	assign internal_intr_message_2_rdat = {internal_intr_message_2_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_2_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_2_internal_intr_message_wena) internal_intr_message_2_internal_intr_message <= internal_intr_message_2_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_2_internal_intr_message_rdat = internal_intr_message_2_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_2_internal_intr_message_wena) internal_intr_message_2_internal_intr_message_parity = internal_intr_message_2_internal_intr_message_wdat;
	    else internal_intr_message_2_internal_intr_message_parity = internal_intr_message_2_internal_intr_message;
	end

	assign internal_intr_message_2_parity_ena = (internal_intr_message_2_internal_intr_message_wena);

	assign internal_intr_message_2_parity_wdata = {internal_intr_message_2_internal_intr_message_parity[31], internal_intr_message_2_internal_intr_message_parity[30], internal_intr_message_2_internal_intr_message_parity[29], internal_intr_message_2_internal_intr_message_parity[28], internal_intr_message_2_internal_intr_message_parity[27], internal_intr_message_2_internal_intr_message_parity[26], internal_intr_message_2_internal_intr_message_parity[25], internal_intr_message_2_internal_intr_message_parity[24], internal_intr_message_2_internal_intr_message_parity[23], internal_intr_message_2_internal_intr_message_parity[22], internal_intr_message_2_internal_intr_message_parity[21], internal_intr_message_2_internal_intr_message_parity[20], internal_intr_message_2_internal_intr_message_parity[19], internal_intr_message_2_internal_intr_message_parity[18], internal_intr_message_2_internal_intr_message_parity[17], internal_intr_message_2_internal_intr_message_parity[16], internal_intr_message_2_internal_intr_message_parity[15], internal_intr_message_2_internal_intr_message_parity[14], internal_intr_message_2_internal_intr_message_parity[13], internal_intr_message_2_internal_intr_message_parity[12], internal_intr_message_2_internal_intr_message_parity[11], internal_intr_message_2_internal_intr_message_parity[10], internal_intr_message_2_internal_intr_message_parity[9], internal_intr_message_2_internal_intr_message_parity[8], internal_intr_message_2_internal_intr_message_parity[7], internal_intr_message_2_internal_intr_message_parity[6], internal_intr_message_2_internal_intr_message_parity[5], internal_intr_message_2_internal_intr_message_parity[4], internal_intr_message_2_internal_intr_message_parity[3], internal_intr_message_2_internal_intr_message_parity[2], internal_intr_message_2_internal_intr_message_parity[1], internal_intr_message_2_internal_intr_message_parity[0]};

	assign internal_intr_message_2_parity_update = {(^internal_intr_message_2_parity_wdata[31:24]), (^internal_intr_message_2_parity_wdata[23:16]), (^internal_intr_message_2_parity_wdata[15:8]), (^internal_intr_message_2_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_2_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_2_parity_ena) internal_intr_message_2_parity_bit <= internal_intr_message_2_parity_update;
	    end
	end

	assign internal_intr_message_2_parity_check_bit = {(^internal_intr_message_2_parity_check_wdata[31:24]), (^internal_intr_message_2_parity_check_wdata[23:16]), (^internal_intr_message_2_parity_check_wdata[15:8]), (^internal_intr_message_2_parity_check_wdata[7:0])};

	assign internal_intr_message_2_parity_check_wdata = {internal_intr_message_2_internal_intr_message[31], internal_intr_message_2_internal_intr_message[30], internal_intr_message_2_internal_intr_message[29], internal_intr_message_2_internal_intr_message[28], internal_intr_message_2_internal_intr_message[27], internal_intr_message_2_internal_intr_message[26], internal_intr_message_2_internal_intr_message[25], internal_intr_message_2_internal_intr_message[24], internal_intr_message_2_internal_intr_message[23], internal_intr_message_2_internal_intr_message[22], internal_intr_message_2_internal_intr_message[21], internal_intr_message_2_internal_intr_message[20], internal_intr_message_2_internal_intr_message[19], internal_intr_message_2_internal_intr_message[18], internal_intr_message_2_internal_intr_message[17], internal_intr_message_2_internal_intr_message[16], internal_intr_message_2_internal_intr_message[15], internal_intr_message_2_internal_intr_message[14], internal_intr_message_2_internal_intr_message[13], internal_intr_message_2_internal_intr_message[12], internal_intr_message_2_internal_intr_message[11], internal_intr_message_2_internal_intr_message[10], internal_intr_message_2_internal_intr_message[9], internal_intr_message_2_internal_intr_message[8], internal_intr_message_2_internal_intr_message[7], internal_intr_message_2_internal_intr_message[6], internal_intr_message_2_internal_intr_message[5], internal_intr_message_2_internal_intr_message[4], internal_intr_message_2_internal_intr_message[3], internal_intr_message_2_internal_intr_message[2], internal_intr_message_2_internal_intr_message[1], internal_intr_message_2_internal_intr_message[0]};

	assign internal_intr_message_2_parity_check_err = (internal_intr_message_2_parity_check_bit != internal_intr_message_2_parity_bit);

	assign internal_intr_message_2_parity_hw_check_err = internal_intr_message_2_parity_check_err;

	assign internal_intr_message_3_rdat = {internal_intr_message_3_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_3_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_3_internal_intr_message_wena) internal_intr_message_3_internal_intr_message <= internal_intr_message_3_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_3_internal_intr_message_rdat = internal_intr_message_3_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_3_internal_intr_message_wena) internal_intr_message_3_internal_intr_message_parity = internal_intr_message_3_internal_intr_message_wdat;
	    else internal_intr_message_3_internal_intr_message_parity = internal_intr_message_3_internal_intr_message;
	end

	assign internal_intr_message_3_parity_ena = (internal_intr_message_3_internal_intr_message_wena);

	assign internal_intr_message_3_parity_wdata = {internal_intr_message_3_internal_intr_message_parity[31], internal_intr_message_3_internal_intr_message_parity[30], internal_intr_message_3_internal_intr_message_parity[29], internal_intr_message_3_internal_intr_message_parity[28], internal_intr_message_3_internal_intr_message_parity[27], internal_intr_message_3_internal_intr_message_parity[26], internal_intr_message_3_internal_intr_message_parity[25], internal_intr_message_3_internal_intr_message_parity[24], internal_intr_message_3_internal_intr_message_parity[23], internal_intr_message_3_internal_intr_message_parity[22], internal_intr_message_3_internal_intr_message_parity[21], internal_intr_message_3_internal_intr_message_parity[20], internal_intr_message_3_internal_intr_message_parity[19], internal_intr_message_3_internal_intr_message_parity[18], internal_intr_message_3_internal_intr_message_parity[17], internal_intr_message_3_internal_intr_message_parity[16], internal_intr_message_3_internal_intr_message_parity[15], internal_intr_message_3_internal_intr_message_parity[14], internal_intr_message_3_internal_intr_message_parity[13], internal_intr_message_3_internal_intr_message_parity[12], internal_intr_message_3_internal_intr_message_parity[11], internal_intr_message_3_internal_intr_message_parity[10], internal_intr_message_3_internal_intr_message_parity[9], internal_intr_message_3_internal_intr_message_parity[8], internal_intr_message_3_internal_intr_message_parity[7], internal_intr_message_3_internal_intr_message_parity[6], internal_intr_message_3_internal_intr_message_parity[5], internal_intr_message_3_internal_intr_message_parity[4], internal_intr_message_3_internal_intr_message_parity[3], internal_intr_message_3_internal_intr_message_parity[2], internal_intr_message_3_internal_intr_message_parity[1], internal_intr_message_3_internal_intr_message_parity[0]};

	assign internal_intr_message_3_parity_update = {(^internal_intr_message_3_parity_wdata[31:24]), (^internal_intr_message_3_parity_wdata[23:16]), (^internal_intr_message_3_parity_wdata[15:8]), (^internal_intr_message_3_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_3_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_3_parity_ena) internal_intr_message_3_parity_bit <= internal_intr_message_3_parity_update;
	    end
	end

	assign internal_intr_message_3_parity_check_bit = {(^internal_intr_message_3_parity_check_wdata[31:24]), (^internal_intr_message_3_parity_check_wdata[23:16]), (^internal_intr_message_3_parity_check_wdata[15:8]), (^internal_intr_message_3_parity_check_wdata[7:0])};

	assign internal_intr_message_3_parity_check_wdata = {internal_intr_message_3_internal_intr_message[31], internal_intr_message_3_internal_intr_message[30], internal_intr_message_3_internal_intr_message[29], internal_intr_message_3_internal_intr_message[28], internal_intr_message_3_internal_intr_message[27], internal_intr_message_3_internal_intr_message[26], internal_intr_message_3_internal_intr_message[25], internal_intr_message_3_internal_intr_message[24], internal_intr_message_3_internal_intr_message[23], internal_intr_message_3_internal_intr_message[22], internal_intr_message_3_internal_intr_message[21], internal_intr_message_3_internal_intr_message[20], internal_intr_message_3_internal_intr_message[19], internal_intr_message_3_internal_intr_message[18], internal_intr_message_3_internal_intr_message[17], internal_intr_message_3_internal_intr_message[16], internal_intr_message_3_internal_intr_message[15], internal_intr_message_3_internal_intr_message[14], internal_intr_message_3_internal_intr_message[13], internal_intr_message_3_internal_intr_message[12], internal_intr_message_3_internal_intr_message[11], internal_intr_message_3_internal_intr_message[10], internal_intr_message_3_internal_intr_message[9], internal_intr_message_3_internal_intr_message[8], internal_intr_message_3_internal_intr_message[7], internal_intr_message_3_internal_intr_message[6], internal_intr_message_3_internal_intr_message[5], internal_intr_message_3_internal_intr_message[4], internal_intr_message_3_internal_intr_message[3], internal_intr_message_3_internal_intr_message[2], internal_intr_message_3_internal_intr_message[1], internal_intr_message_3_internal_intr_message[0]};

	assign internal_intr_message_3_parity_check_err = (internal_intr_message_3_parity_check_bit != internal_intr_message_3_parity_bit);

	assign internal_intr_message_3_parity_hw_check_err = internal_intr_message_3_parity_check_err;

	assign internal_intr_message_4_rdat = {internal_intr_message_4_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_4_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_4_internal_intr_message_wena) internal_intr_message_4_internal_intr_message <= internal_intr_message_4_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_4_internal_intr_message_rdat = internal_intr_message_4_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_4_internal_intr_message_wena) internal_intr_message_4_internal_intr_message_parity = internal_intr_message_4_internal_intr_message_wdat;
	    else internal_intr_message_4_internal_intr_message_parity = internal_intr_message_4_internal_intr_message;
	end

	assign internal_intr_message_4_parity_ena = (internal_intr_message_4_internal_intr_message_wena);

	assign internal_intr_message_4_parity_wdata = {internal_intr_message_4_internal_intr_message_parity[31], internal_intr_message_4_internal_intr_message_parity[30], internal_intr_message_4_internal_intr_message_parity[29], internal_intr_message_4_internal_intr_message_parity[28], internal_intr_message_4_internal_intr_message_parity[27], internal_intr_message_4_internal_intr_message_parity[26], internal_intr_message_4_internal_intr_message_parity[25], internal_intr_message_4_internal_intr_message_parity[24], internal_intr_message_4_internal_intr_message_parity[23], internal_intr_message_4_internal_intr_message_parity[22], internal_intr_message_4_internal_intr_message_parity[21], internal_intr_message_4_internal_intr_message_parity[20], internal_intr_message_4_internal_intr_message_parity[19], internal_intr_message_4_internal_intr_message_parity[18], internal_intr_message_4_internal_intr_message_parity[17], internal_intr_message_4_internal_intr_message_parity[16], internal_intr_message_4_internal_intr_message_parity[15], internal_intr_message_4_internal_intr_message_parity[14], internal_intr_message_4_internal_intr_message_parity[13], internal_intr_message_4_internal_intr_message_parity[12], internal_intr_message_4_internal_intr_message_parity[11], internal_intr_message_4_internal_intr_message_parity[10], internal_intr_message_4_internal_intr_message_parity[9], internal_intr_message_4_internal_intr_message_parity[8], internal_intr_message_4_internal_intr_message_parity[7], internal_intr_message_4_internal_intr_message_parity[6], internal_intr_message_4_internal_intr_message_parity[5], internal_intr_message_4_internal_intr_message_parity[4], internal_intr_message_4_internal_intr_message_parity[3], internal_intr_message_4_internal_intr_message_parity[2], internal_intr_message_4_internal_intr_message_parity[1], internal_intr_message_4_internal_intr_message_parity[0]};

	assign internal_intr_message_4_parity_update = {(^internal_intr_message_4_parity_wdata[31:24]), (^internal_intr_message_4_parity_wdata[23:16]), (^internal_intr_message_4_parity_wdata[15:8]), (^internal_intr_message_4_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_4_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_4_parity_ena) internal_intr_message_4_parity_bit <= internal_intr_message_4_parity_update;
	    end
	end

	assign internal_intr_message_4_parity_check_bit = {(^internal_intr_message_4_parity_check_wdata[31:24]), (^internal_intr_message_4_parity_check_wdata[23:16]), (^internal_intr_message_4_parity_check_wdata[15:8]), (^internal_intr_message_4_parity_check_wdata[7:0])};

	assign internal_intr_message_4_parity_check_wdata = {internal_intr_message_4_internal_intr_message[31], internal_intr_message_4_internal_intr_message[30], internal_intr_message_4_internal_intr_message[29], internal_intr_message_4_internal_intr_message[28], internal_intr_message_4_internal_intr_message[27], internal_intr_message_4_internal_intr_message[26], internal_intr_message_4_internal_intr_message[25], internal_intr_message_4_internal_intr_message[24], internal_intr_message_4_internal_intr_message[23], internal_intr_message_4_internal_intr_message[22], internal_intr_message_4_internal_intr_message[21], internal_intr_message_4_internal_intr_message[20], internal_intr_message_4_internal_intr_message[19], internal_intr_message_4_internal_intr_message[18], internal_intr_message_4_internal_intr_message[17], internal_intr_message_4_internal_intr_message[16], internal_intr_message_4_internal_intr_message[15], internal_intr_message_4_internal_intr_message[14], internal_intr_message_4_internal_intr_message[13], internal_intr_message_4_internal_intr_message[12], internal_intr_message_4_internal_intr_message[11], internal_intr_message_4_internal_intr_message[10], internal_intr_message_4_internal_intr_message[9], internal_intr_message_4_internal_intr_message[8], internal_intr_message_4_internal_intr_message[7], internal_intr_message_4_internal_intr_message[6], internal_intr_message_4_internal_intr_message[5], internal_intr_message_4_internal_intr_message[4], internal_intr_message_4_internal_intr_message[3], internal_intr_message_4_internal_intr_message[2], internal_intr_message_4_internal_intr_message[1], internal_intr_message_4_internal_intr_message[0]};

	assign internal_intr_message_4_parity_check_err = (internal_intr_message_4_parity_check_bit != internal_intr_message_4_parity_bit);

	assign internal_intr_message_4_parity_hw_check_err = internal_intr_message_4_parity_check_err;

	assign internal_intr_message_5_rdat = {internal_intr_message_5_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_5_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_5_internal_intr_message_wena) internal_intr_message_5_internal_intr_message <= internal_intr_message_5_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_5_internal_intr_message_rdat = internal_intr_message_5_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_5_internal_intr_message_wena) internal_intr_message_5_internal_intr_message_parity = internal_intr_message_5_internal_intr_message_wdat;
	    else internal_intr_message_5_internal_intr_message_parity = internal_intr_message_5_internal_intr_message;
	end

	assign internal_intr_message_5_parity_ena = (internal_intr_message_5_internal_intr_message_wena);

	assign internal_intr_message_5_parity_wdata = {internal_intr_message_5_internal_intr_message_parity[31], internal_intr_message_5_internal_intr_message_parity[30], internal_intr_message_5_internal_intr_message_parity[29], internal_intr_message_5_internal_intr_message_parity[28], internal_intr_message_5_internal_intr_message_parity[27], internal_intr_message_5_internal_intr_message_parity[26], internal_intr_message_5_internal_intr_message_parity[25], internal_intr_message_5_internal_intr_message_parity[24], internal_intr_message_5_internal_intr_message_parity[23], internal_intr_message_5_internal_intr_message_parity[22], internal_intr_message_5_internal_intr_message_parity[21], internal_intr_message_5_internal_intr_message_parity[20], internal_intr_message_5_internal_intr_message_parity[19], internal_intr_message_5_internal_intr_message_parity[18], internal_intr_message_5_internal_intr_message_parity[17], internal_intr_message_5_internal_intr_message_parity[16], internal_intr_message_5_internal_intr_message_parity[15], internal_intr_message_5_internal_intr_message_parity[14], internal_intr_message_5_internal_intr_message_parity[13], internal_intr_message_5_internal_intr_message_parity[12], internal_intr_message_5_internal_intr_message_parity[11], internal_intr_message_5_internal_intr_message_parity[10], internal_intr_message_5_internal_intr_message_parity[9], internal_intr_message_5_internal_intr_message_parity[8], internal_intr_message_5_internal_intr_message_parity[7], internal_intr_message_5_internal_intr_message_parity[6], internal_intr_message_5_internal_intr_message_parity[5], internal_intr_message_5_internal_intr_message_parity[4], internal_intr_message_5_internal_intr_message_parity[3], internal_intr_message_5_internal_intr_message_parity[2], internal_intr_message_5_internal_intr_message_parity[1], internal_intr_message_5_internal_intr_message_parity[0]};

	assign internal_intr_message_5_parity_update = {(^internal_intr_message_5_parity_wdata[31:24]), (^internal_intr_message_5_parity_wdata[23:16]), (^internal_intr_message_5_parity_wdata[15:8]), (^internal_intr_message_5_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_5_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_5_parity_ena) internal_intr_message_5_parity_bit <= internal_intr_message_5_parity_update;
	    end
	end

	assign internal_intr_message_5_parity_check_bit = {(^internal_intr_message_5_parity_check_wdata[31:24]), (^internal_intr_message_5_parity_check_wdata[23:16]), (^internal_intr_message_5_parity_check_wdata[15:8]), (^internal_intr_message_5_parity_check_wdata[7:0])};

	assign internal_intr_message_5_parity_check_wdata = {internal_intr_message_5_internal_intr_message[31], internal_intr_message_5_internal_intr_message[30], internal_intr_message_5_internal_intr_message[29], internal_intr_message_5_internal_intr_message[28], internal_intr_message_5_internal_intr_message[27], internal_intr_message_5_internal_intr_message[26], internal_intr_message_5_internal_intr_message[25], internal_intr_message_5_internal_intr_message[24], internal_intr_message_5_internal_intr_message[23], internal_intr_message_5_internal_intr_message[22], internal_intr_message_5_internal_intr_message[21], internal_intr_message_5_internal_intr_message[20], internal_intr_message_5_internal_intr_message[19], internal_intr_message_5_internal_intr_message[18], internal_intr_message_5_internal_intr_message[17], internal_intr_message_5_internal_intr_message[16], internal_intr_message_5_internal_intr_message[15], internal_intr_message_5_internal_intr_message[14], internal_intr_message_5_internal_intr_message[13], internal_intr_message_5_internal_intr_message[12], internal_intr_message_5_internal_intr_message[11], internal_intr_message_5_internal_intr_message[10], internal_intr_message_5_internal_intr_message[9], internal_intr_message_5_internal_intr_message[8], internal_intr_message_5_internal_intr_message[7], internal_intr_message_5_internal_intr_message[6], internal_intr_message_5_internal_intr_message[5], internal_intr_message_5_internal_intr_message[4], internal_intr_message_5_internal_intr_message[3], internal_intr_message_5_internal_intr_message[2], internal_intr_message_5_internal_intr_message[1], internal_intr_message_5_internal_intr_message[0]};

	assign internal_intr_message_5_parity_check_err = (internal_intr_message_5_parity_check_bit != internal_intr_message_5_parity_bit);

	assign internal_intr_message_5_parity_hw_check_err = internal_intr_message_5_parity_check_err;

	assign internal_intr_message_6_rdat = {internal_intr_message_6_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_6_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_6_internal_intr_message_wena) internal_intr_message_6_internal_intr_message <= internal_intr_message_6_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_6_internal_intr_message_rdat = internal_intr_message_6_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_6_internal_intr_message_wena) internal_intr_message_6_internal_intr_message_parity = internal_intr_message_6_internal_intr_message_wdat;
	    else internal_intr_message_6_internal_intr_message_parity = internal_intr_message_6_internal_intr_message;
	end

	assign internal_intr_message_6_parity_ena = (internal_intr_message_6_internal_intr_message_wena);

	assign internal_intr_message_6_parity_wdata = {internal_intr_message_6_internal_intr_message_parity[31], internal_intr_message_6_internal_intr_message_parity[30], internal_intr_message_6_internal_intr_message_parity[29], internal_intr_message_6_internal_intr_message_parity[28], internal_intr_message_6_internal_intr_message_parity[27], internal_intr_message_6_internal_intr_message_parity[26], internal_intr_message_6_internal_intr_message_parity[25], internal_intr_message_6_internal_intr_message_parity[24], internal_intr_message_6_internal_intr_message_parity[23], internal_intr_message_6_internal_intr_message_parity[22], internal_intr_message_6_internal_intr_message_parity[21], internal_intr_message_6_internal_intr_message_parity[20], internal_intr_message_6_internal_intr_message_parity[19], internal_intr_message_6_internal_intr_message_parity[18], internal_intr_message_6_internal_intr_message_parity[17], internal_intr_message_6_internal_intr_message_parity[16], internal_intr_message_6_internal_intr_message_parity[15], internal_intr_message_6_internal_intr_message_parity[14], internal_intr_message_6_internal_intr_message_parity[13], internal_intr_message_6_internal_intr_message_parity[12], internal_intr_message_6_internal_intr_message_parity[11], internal_intr_message_6_internal_intr_message_parity[10], internal_intr_message_6_internal_intr_message_parity[9], internal_intr_message_6_internal_intr_message_parity[8], internal_intr_message_6_internal_intr_message_parity[7], internal_intr_message_6_internal_intr_message_parity[6], internal_intr_message_6_internal_intr_message_parity[5], internal_intr_message_6_internal_intr_message_parity[4], internal_intr_message_6_internal_intr_message_parity[3], internal_intr_message_6_internal_intr_message_parity[2], internal_intr_message_6_internal_intr_message_parity[1], internal_intr_message_6_internal_intr_message_parity[0]};

	assign internal_intr_message_6_parity_update = {(^internal_intr_message_6_parity_wdata[31:24]), (^internal_intr_message_6_parity_wdata[23:16]), (^internal_intr_message_6_parity_wdata[15:8]), (^internal_intr_message_6_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_6_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_6_parity_ena) internal_intr_message_6_parity_bit <= internal_intr_message_6_parity_update;
	    end
	end

	assign internal_intr_message_6_parity_check_bit = {(^internal_intr_message_6_parity_check_wdata[31:24]), (^internal_intr_message_6_parity_check_wdata[23:16]), (^internal_intr_message_6_parity_check_wdata[15:8]), (^internal_intr_message_6_parity_check_wdata[7:0])};

	assign internal_intr_message_6_parity_check_wdata = {internal_intr_message_6_internal_intr_message[31], internal_intr_message_6_internal_intr_message[30], internal_intr_message_6_internal_intr_message[29], internal_intr_message_6_internal_intr_message[28], internal_intr_message_6_internal_intr_message[27], internal_intr_message_6_internal_intr_message[26], internal_intr_message_6_internal_intr_message[25], internal_intr_message_6_internal_intr_message[24], internal_intr_message_6_internal_intr_message[23], internal_intr_message_6_internal_intr_message[22], internal_intr_message_6_internal_intr_message[21], internal_intr_message_6_internal_intr_message[20], internal_intr_message_6_internal_intr_message[19], internal_intr_message_6_internal_intr_message[18], internal_intr_message_6_internal_intr_message[17], internal_intr_message_6_internal_intr_message[16], internal_intr_message_6_internal_intr_message[15], internal_intr_message_6_internal_intr_message[14], internal_intr_message_6_internal_intr_message[13], internal_intr_message_6_internal_intr_message[12], internal_intr_message_6_internal_intr_message[11], internal_intr_message_6_internal_intr_message[10], internal_intr_message_6_internal_intr_message[9], internal_intr_message_6_internal_intr_message[8], internal_intr_message_6_internal_intr_message[7], internal_intr_message_6_internal_intr_message[6], internal_intr_message_6_internal_intr_message[5], internal_intr_message_6_internal_intr_message[4], internal_intr_message_6_internal_intr_message[3], internal_intr_message_6_internal_intr_message[2], internal_intr_message_6_internal_intr_message[1], internal_intr_message_6_internal_intr_message[0]};

	assign internal_intr_message_6_parity_check_err = (internal_intr_message_6_parity_check_bit != internal_intr_message_6_parity_bit);

	assign internal_intr_message_6_parity_hw_check_err = internal_intr_message_6_parity_check_err;

	assign internal_intr_message_7_rdat = {internal_intr_message_7_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_7_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_7_internal_intr_message_wena) internal_intr_message_7_internal_intr_message <= internal_intr_message_7_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_7_internal_intr_message_rdat = internal_intr_message_7_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_7_internal_intr_message_wena) internal_intr_message_7_internal_intr_message_parity = internal_intr_message_7_internal_intr_message_wdat;
	    else internal_intr_message_7_internal_intr_message_parity = internal_intr_message_7_internal_intr_message;
	end

	assign internal_intr_message_7_parity_ena = (internal_intr_message_7_internal_intr_message_wena);

	assign internal_intr_message_7_parity_wdata = {internal_intr_message_7_internal_intr_message_parity[31], internal_intr_message_7_internal_intr_message_parity[30], internal_intr_message_7_internal_intr_message_parity[29], internal_intr_message_7_internal_intr_message_parity[28], internal_intr_message_7_internal_intr_message_parity[27], internal_intr_message_7_internal_intr_message_parity[26], internal_intr_message_7_internal_intr_message_parity[25], internal_intr_message_7_internal_intr_message_parity[24], internal_intr_message_7_internal_intr_message_parity[23], internal_intr_message_7_internal_intr_message_parity[22], internal_intr_message_7_internal_intr_message_parity[21], internal_intr_message_7_internal_intr_message_parity[20], internal_intr_message_7_internal_intr_message_parity[19], internal_intr_message_7_internal_intr_message_parity[18], internal_intr_message_7_internal_intr_message_parity[17], internal_intr_message_7_internal_intr_message_parity[16], internal_intr_message_7_internal_intr_message_parity[15], internal_intr_message_7_internal_intr_message_parity[14], internal_intr_message_7_internal_intr_message_parity[13], internal_intr_message_7_internal_intr_message_parity[12], internal_intr_message_7_internal_intr_message_parity[11], internal_intr_message_7_internal_intr_message_parity[10], internal_intr_message_7_internal_intr_message_parity[9], internal_intr_message_7_internal_intr_message_parity[8], internal_intr_message_7_internal_intr_message_parity[7], internal_intr_message_7_internal_intr_message_parity[6], internal_intr_message_7_internal_intr_message_parity[5], internal_intr_message_7_internal_intr_message_parity[4], internal_intr_message_7_internal_intr_message_parity[3], internal_intr_message_7_internal_intr_message_parity[2], internal_intr_message_7_internal_intr_message_parity[1], internal_intr_message_7_internal_intr_message_parity[0]};

	assign internal_intr_message_7_parity_update = {(^internal_intr_message_7_parity_wdata[31:24]), (^internal_intr_message_7_parity_wdata[23:16]), (^internal_intr_message_7_parity_wdata[15:8]), (^internal_intr_message_7_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_7_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_7_parity_ena) internal_intr_message_7_parity_bit <= internal_intr_message_7_parity_update;
	    end
	end

	assign internal_intr_message_7_parity_check_bit = {(^internal_intr_message_7_parity_check_wdata[31:24]), (^internal_intr_message_7_parity_check_wdata[23:16]), (^internal_intr_message_7_parity_check_wdata[15:8]), (^internal_intr_message_7_parity_check_wdata[7:0])};

	assign internal_intr_message_7_parity_check_wdata = {internal_intr_message_7_internal_intr_message[31], internal_intr_message_7_internal_intr_message[30], internal_intr_message_7_internal_intr_message[29], internal_intr_message_7_internal_intr_message[28], internal_intr_message_7_internal_intr_message[27], internal_intr_message_7_internal_intr_message[26], internal_intr_message_7_internal_intr_message[25], internal_intr_message_7_internal_intr_message[24], internal_intr_message_7_internal_intr_message[23], internal_intr_message_7_internal_intr_message[22], internal_intr_message_7_internal_intr_message[21], internal_intr_message_7_internal_intr_message[20], internal_intr_message_7_internal_intr_message[19], internal_intr_message_7_internal_intr_message[18], internal_intr_message_7_internal_intr_message[17], internal_intr_message_7_internal_intr_message[16], internal_intr_message_7_internal_intr_message[15], internal_intr_message_7_internal_intr_message[14], internal_intr_message_7_internal_intr_message[13], internal_intr_message_7_internal_intr_message[12], internal_intr_message_7_internal_intr_message[11], internal_intr_message_7_internal_intr_message[10], internal_intr_message_7_internal_intr_message[9], internal_intr_message_7_internal_intr_message[8], internal_intr_message_7_internal_intr_message[7], internal_intr_message_7_internal_intr_message[6], internal_intr_message_7_internal_intr_message[5], internal_intr_message_7_internal_intr_message[4], internal_intr_message_7_internal_intr_message[3], internal_intr_message_7_internal_intr_message[2], internal_intr_message_7_internal_intr_message[1], internal_intr_message_7_internal_intr_message[0]};

	assign internal_intr_message_7_parity_check_err = (internal_intr_message_7_parity_check_bit != internal_intr_message_7_parity_bit);

	assign internal_intr_message_7_parity_hw_check_err = internal_intr_message_7_parity_check_err;

	assign internal_intr_message_8_rdat = {internal_intr_message_8_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_8_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_8_internal_intr_message_wena) internal_intr_message_8_internal_intr_message <= internal_intr_message_8_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_8_internal_intr_message_rdat = internal_intr_message_8_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_8_internal_intr_message_wena) internal_intr_message_8_internal_intr_message_parity = internal_intr_message_8_internal_intr_message_wdat;
	    else internal_intr_message_8_internal_intr_message_parity = internal_intr_message_8_internal_intr_message;
	end

	assign internal_intr_message_8_parity_ena = (internal_intr_message_8_internal_intr_message_wena);

	assign internal_intr_message_8_parity_wdata = {internal_intr_message_8_internal_intr_message_parity[31], internal_intr_message_8_internal_intr_message_parity[30], internal_intr_message_8_internal_intr_message_parity[29], internal_intr_message_8_internal_intr_message_parity[28], internal_intr_message_8_internal_intr_message_parity[27], internal_intr_message_8_internal_intr_message_parity[26], internal_intr_message_8_internal_intr_message_parity[25], internal_intr_message_8_internal_intr_message_parity[24], internal_intr_message_8_internal_intr_message_parity[23], internal_intr_message_8_internal_intr_message_parity[22], internal_intr_message_8_internal_intr_message_parity[21], internal_intr_message_8_internal_intr_message_parity[20], internal_intr_message_8_internal_intr_message_parity[19], internal_intr_message_8_internal_intr_message_parity[18], internal_intr_message_8_internal_intr_message_parity[17], internal_intr_message_8_internal_intr_message_parity[16], internal_intr_message_8_internal_intr_message_parity[15], internal_intr_message_8_internal_intr_message_parity[14], internal_intr_message_8_internal_intr_message_parity[13], internal_intr_message_8_internal_intr_message_parity[12], internal_intr_message_8_internal_intr_message_parity[11], internal_intr_message_8_internal_intr_message_parity[10], internal_intr_message_8_internal_intr_message_parity[9], internal_intr_message_8_internal_intr_message_parity[8], internal_intr_message_8_internal_intr_message_parity[7], internal_intr_message_8_internal_intr_message_parity[6], internal_intr_message_8_internal_intr_message_parity[5], internal_intr_message_8_internal_intr_message_parity[4], internal_intr_message_8_internal_intr_message_parity[3], internal_intr_message_8_internal_intr_message_parity[2], internal_intr_message_8_internal_intr_message_parity[1], internal_intr_message_8_internal_intr_message_parity[0]};

	assign internal_intr_message_8_parity_update = {(^internal_intr_message_8_parity_wdata[31:24]), (^internal_intr_message_8_parity_wdata[23:16]), (^internal_intr_message_8_parity_wdata[15:8]), (^internal_intr_message_8_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_8_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_8_parity_ena) internal_intr_message_8_parity_bit <= internal_intr_message_8_parity_update;
	    end
	end

	assign internal_intr_message_8_parity_check_bit = {(^internal_intr_message_8_parity_check_wdata[31:24]), (^internal_intr_message_8_parity_check_wdata[23:16]), (^internal_intr_message_8_parity_check_wdata[15:8]), (^internal_intr_message_8_parity_check_wdata[7:0])};

	assign internal_intr_message_8_parity_check_wdata = {internal_intr_message_8_internal_intr_message[31], internal_intr_message_8_internal_intr_message[30], internal_intr_message_8_internal_intr_message[29], internal_intr_message_8_internal_intr_message[28], internal_intr_message_8_internal_intr_message[27], internal_intr_message_8_internal_intr_message[26], internal_intr_message_8_internal_intr_message[25], internal_intr_message_8_internal_intr_message[24], internal_intr_message_8_internal_intr_message[23], internal_intr_message_8_internal_intr_message[22], internal_intr_message_8_internal_intr_message[21], internal_intr_message_8_internal_intr_message[20], internal_intr_message_8_internal_intr_message[19], internal_intr_message_8_internal_intr_message[18], internal_intr_message_8_internal_intr_message[17], internal_intr_message_8_internal_intr_message[16], internal_intr_message_8_internal_intr_message[15], internal_intr_message_8_internal_intr_message[14], internal_intr_message_8_internal_intr_message[13], internal_intr_message_8_internal_intr_message[12], internal_intr_message_8_internal_intr_message[11], internal_intr_message_8_internal_intr_message[10], internal_intr_message_8_internal_intr_message[9], internal_intr_message_8_internal_intr_message[8], internal_intr_message_8_internal_intr_message[7], internal_intr_message_8_internal_intr_message[6], internal_intr_message_8_internal_intr_message[5], internal_intr_message_8_internal_intr_message[4], internal_intr_message_8_internal_intr_message[3], internal_intr_message_8_internal_intr_message[2], internal_intr_message_8_internal_intr_message[1], internal_intr_message_8_internal_intr_message[0]};

	assign internal_intr_message_8_parity_check_err = (internal_intr_message_8_parity_check_bit != internal_intr_message_8_parity_bit);

	assign internal_intr_message_8_parity_hw_check_err = internal_intr_message_8_parity_check_err;

	assign internal_intr_message_9_rdat = {internal_intr_message_9_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_9_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_9_internal_intr_message_wena) internal_intr_message_9_internal_intr_message <= internal_intr_message_9_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_9_internal_intr_message_rdat = internal_intr_message_9_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_9_internal_intr_message_wena) internal_intr_message_9_internal_intr_message_parity = internal_intr_message_9_internal_intr_message_wdat;
	    else internal_intr_message_9_internal_intr_message_parity = internal_intr_message_9_internal_intr_message;
	end

	assign internal_intr_message_9_parity_ena = (internal_intr_message_9_internal_intr_message_wena);

	assign internal_intr_message_9_parity_wdata = {internal_intr_message_9_internal_intr_message_parity[31], internal_intr_message_9_internal_intr_message_parity[30], internal_intr_message_9_internal_intr_message_parity[29], internal_intr_message_9_internal_intr_message_parity[28], internal_intr_message_9_internal_intr_message_parity[27], internal_intr_message_9_internal_intr_message_parity[26], internal_intr_message_9_internal_intr_message_parity[25], internal_intr_message_9_internal_intr_message_parity[24], internal_intr_message_9_internal_intr_message_parity[23], internal_intr_message_9_internal_intr_message_parity[22], internal_intr_message_9_internal_intr_message_parity[21], internal_intr_message_9_internal_intr_message_parity[20], internal_intr_message_9_internal_intr_message_parity[19], internal_intr_message_9_internal_intr_message_parity[18], internal_intr_message_9_internal_intr_message_parity[17], internal_intr_message_9_internal_intr_message_parity[16], internal_intr_message_9_internal_intr_message_parity[15], internal_intr_message_9_internal_intr_message_parity[14], internal_intr_message_9_internal_intr_message_parity[13], internal_intr_message_9_internal_intr_message_parity[12], internal_intr_message_9_internal_intr_message_parity[11], internal_intr_message_9_internal_intr_message_parity[10], internal_intr_message_9_internal_intr_message_parity[9], internal_intr_message_9_internal_intr_message_parity[8], internal_intr_message_9_internal_intr_message_parity[7], internal_intr_message_9_internal_intr_message_parity[6], internal_intr_message_9_internal_intr_message_parity[5], internal_intr_message_9_internal_intr_message_parity[4], internal_intr_message_9_internal_intr_message_parity[3], internal_intr_message_9_internal_intr_message_parity[2], internal_intr_message_9_internal_intr_message_parity[1], internal_intr_message_9_internal_intr_message_parity[0]};

	assign internal_intr_message_9_parity_update = {(^internal_intr_message_9_parity_wdata[31:24]), (^internal_intr_message_9_parity_wdata[23:16]), (^internal_intr_message_9_parity_wdata[15:8]), (^internal_intr_message_9_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_9_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_9_parity_ena) internal_intr_message_9_parity_bit <= internal_intr_message_9_parity_update;
	    end
	end

	assign internal_intr_message_9_parity_check_bit = {(^internal_intr_message_9_parity_check_wdata[31:24]), (^internal_intr_message_9_parity_check_wdata[23:16]), (^internal_intr_message_9_parity_check_wdata[15:8]), (^internal_intr_message_9_parity_check_wdata[7:0])};

	assign internal_intr_message_9_parity_check_wdata = {internal_intr_message_9_internal_intr_message[31], internal_intr_message_9_internal_intr_message[30], internal_intr_message_9_internal_intr_message[29], internal_intr_message_9_internal_intr_message[28], internal_intr_message_9_internal_intr_message[27], internal_intr_message_9_internal_intr_message[26], internal_intr_message_9_internal_intr_message[25], internal_intr_message_9_internal_intr_message[24], internal_intr_message_9_internal_intr_message[23], internal_intr_message_9_internal_intr_message[22], internal_intr_message_9_internal_intr_message[21], internal_intr_message_9_internal_intr_message[20], internal_intr_message_9_internal_intr_message[19], internal_intr_message_9_internal_intr_message[18], internal_intr_message_9_internal_intr_message[17], internal_intr_message_9_internal_intr_message[16], internal_intr_message_9_internal_intr_message[15], internal_intr_message_9_internal_intr_message[14], internal_intr_message_9_internal_intr_message[13], internal_intr_message_9_internal_intr_message[12], internal_intr_message_9_internal_intr_message[11], internal_intr_message_9_internal_intr_message[10], internal_intr_message_9_internal_intr_message[9], internal_intr_message_9_internal_intr_message[8], internal_intr_message_9_internal_intr_message[7], internal_intr_message_9_internal_intr_message[6], internal_intr_message_9_internal_intr_message[5], internal_intr_message_9_internal_intr_message[4], internal_intr_message_9_internal_intr_message[3], internal_intr_message_9_internal_intr_message[2], internal_intr_message_9_internal_intr_message[1], internal_intr_message_9_internal_intr_message[0]};

	assign internal_intr_message_9_parity_check_err = (internal_intr_message_9_parity_check_bit != internal_intr_message_9_parity_bit);

	assign internal_intr_message_9_parity_hw_check_err = internal_intr_message_9_parity_check_err;

	assign internal_intr_message_10_rdat = {internal_intr_message_10_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_10_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_10_internal_intr_message_wena) internal_intr_message_10_internal_intr_message <= internal_intr_message_10_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_10_internal_intr_message_rdat = internal_intr_message_10_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_10_internal_intr_message_wena) internal_intr_message_10_internal_intr_message_parity = internal_intr_message_10_internal_intr_message_wdat;
	    else internal_intr_message_10_internal_intr_message_parity = internal_intr_message_10_internal_intr_message;
	end

	assign internal_intr_message_10_parity_ena = (internal_intr_message_10_internal_intr_message_wena);

	assign internal_intr_message_10_parity_wdata = {internal_intr_message_10_internal_intr_message_parity[31], internal_intr_message_10_internal_intr_message_parity[30], internal_intr_message_10_internal_intr_message_parity[29], internal_intr_message_10_internal_intr_message_parity[28], internal_intr_message_10_internal_intr_message_parity[27], internal_intr_message_10_internal_intr_message_parity[26], internal_intr_message_10_internal_intr_message_parity[25], internal_intr_message_10_internal_intr_message_parity[24], internal_intr_message_10_internal_intr_message_parity[23], internal_intr_message_10_internal_intr_message_parity[22], internal_intr_message_10_internal_intr_message_parity[21], internal_intr_message_10_internal_intr_message_parity[20], internal_intr_message_10_internal_intr_message_parity[19], internal_intr_message_10_internal_intr_message_parity[18], internal_intr_message_10_internal_intr_message_parity[17], internal_intr_message_10_internal_intr_message_parity[16], internal_intr_message_10_internal_intr_message_parity[15], internal_intr_message_10_internal_intr_message_parity[14], internal_intr_message_10_internal_intr_message_parity[13], internal_intr_message_10_internal_intr_message_parity[12], internal_intr_message_10_internal_intr_message_parity[11], internal_intr_message_10_internal_intr_message_parity[10], internal_intr_message_10_internal_intr_message_parity[9], internal_intr_message_10_internal_intr_message_parity[8], internal_intr_message_10_internal_intr_message_parity[7], internal_intr_message_10_internal_intr_message_parity[6], internal_intr_message_10_internal_intr_message_parity[5], internal_intr_message_10_internal_intr_message_parity[4], internal_intr_message_10_internal_intr_message_parity[3], internal_intr_message_10_internal_intr_message_parity[2], internal_intr_message_10_internal_intr_message_parity[1], internal_intr_message_10_internal_intr_message_parity[0]};

	assign internal_intr_message_10_parity_update = {(^internal_intr_message_10_parity_wdata[31:24]), (^internal_intr_message_10_parity_wdata[23:16]), (^internal_intr_message_10_parity_wdata[15:8]), (^internal_intr_message_10_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_10_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_10_parity_ena) internal_intr_message_10_parity_bit <= internal_intr_message_10_parity_update;
	    end
	end

	assign internal_intr_message_10_parity_check_bit = {(^internal_intr_message_10_parity_check_wdata[31:24]), (^internal_intr_message_10_parity_check_wdata[23:16]), (^internal_intr_message_10_parity_check_wdata[15:8]), (^internal_intr_message_10_parity_check_wdata[7:0])};

	assign internal_intr_message_10_parity_check_wdata = {internal_intr_message_10_internal_intr_message[31], internal_intr_message_10_internal_intr_message[30], internal_intr_message_10_internal_intr_message[29], internal_intr_message_10_internal_intr_message[28], internal_intr_message_10_internal_intr_message[27], internal_intr_message_10_internal_intr_message[26], internal_intr_message_10_internal_intr_message[25], internal_intr_message_10_internal_intr_message[24], internal_intr_message_10_internal_intr_message[23], internal_intr_message_10_internal_intr_message[22], internal_intr_message_10_internal_intr_message[21], internal_intr_message_10_internal_intr_message[20], internal_intr_message_10_internal_intr_message[19], internal_intr_message_10_internal_intr_message[18], internal_intr_message_10_internal_intr_message[17], internal_intr_message_10_internal_intr_message[16], internal_intr_message_10_internal_intr_message[15], internal_intr_message_10_internal_intr_message[14], internal_intr_message_10_internal_intr_message[13], internal_intr_message_10_internal_intr_message[12], internal_intr_message_10_internal_intr_message[11], internal_intr_message_10_internal_intr_message[10], internal_intr_message_10_internal_intr_message[9], internal_intr_message_10_internal_intr_message[8], internal_intr_message_10_internal_intr_message[7], internal_intr_message_10_internal_intr_message[6], internal_intr_message_10_internal_intr_message[5], internal_intr_message_10_internal_intr_message[4], internal_intr_message_10_internal_intr_message[3], internal_intr_message_10_internal_intr_message[2], internal_intr_message_10_internal_intr_message[1], internal_intr_message_10_internal_intr_message[0]};

	assign internal_intr_message_10_parity_check_err = (internal_intr_message_10_parity_check_bit != internal_intr_message_10_parity_bit);

	assign internal_intr_message_10_parity_hw_check_err = internal_intr_message_10_parity_check_err;

	assign internal_intr_message_11_rdat = {internal_intr_message_11_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_11_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_11_internal_intr_message_wena) internal_intr_message_11_internal_intr_message <= internal_intr_message_11_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_11_internal_intr_message_rdat = internal_intr_message_11_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_11_internal_intr_message_wena) internal_intr_message_11_internal_intr_message_parity = internal_intr_message_11_internal_intr_message_wdat;
	    else internal_intr_message_11_internal_intr_message_parity = internal_intr_message_11_internal_intr_message;
	end

	assign internal_intr_message_11_parity_ena = (internal_intr_message_11_internal_intr_message_wena);

	assign internal_intr_message_11_parity_wdata = {internal_intr_message_11_internal_intr_message_parity[31], internal_intr_message_11_internal_intr_message_parity[30], internal_intr_message_11_internal_intr_message_parity[29], internal_intr_message_11_internal_intr_message_parity[28], internal_intr_message_11_internal_intr_message_parity[27], internal_intr_message_11_internal_intr_message_parity[26], internal_intr_message_11_internal_intr_message_parity[25], internal_intr_message_11_internal_intr_message_parity[24], internal_intr_message_11_internal_intr_message_parity[23], internal_intr_message_11_internal_intr_message_parity[22], internal_intr_message_11_internal_intr_message_parity[21], internal_intr_message_11_internal_intr_message_parity[20], internal_intr_message_11_internal_intr_message_parity[19], internal_intr_message_11_internal_intr_message_parity[18], internal_intr_message_11_internal_intr_message_parity[17], internal_intr_message_11_internal_intr_message_parity[16], internal_intr_message_11_internal_intr_message_parity[15], internal_intr_message_11_internal_intr_message_parity[14], internal_intr_message_11_internal_intr_message_parity[13], internal_intr_message_11_internal_intr_message_parity[12], internal_intr_message_11_internal_intr_message_parity[11], internal_intr_message_11_internal_intr_message_parity[10], internal_intr_message_11_internal_intr_message_parity[9], internal_intr_message_11_internal_intr_message_parity[8], internal_intr_message_11_internal_intr_message_parity[7], internal_intr_message_11_internal_intr_message_parity[6], internal_intr_message_11_internal_intr_message_parity[5], internal_intr_message_11_internal_intr_message_parity[4], internal_intr_message_11_internal_intr_message_parity[3], internal_intr_message_11_internal_intr_message_parity[2], internal_intr_message_11_internal_intr_message_parity[1], internal_intr_message_11_internal_intr_message_parity[0]};

	assign internal_intr_message_11_parity_update = {(^internal_intr_message_11_parity_wdata[31:24]), (^internal_intr_message_11_parity_wdata[23:16]), (^internal_intr_message_11_parity_wdata[15:8]), (^internal_intr_message_11_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_11_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_11_parity_ena) internal_intr_message_11_parity_bit <= internal_intr_message_11_parity_update;
	    end
	end

	assign internal_intr_message_11_parity_check_bit = {(^internal_intr_message_11_parity_check_wdata[31:24]), (^internal_intr_message_11_parity_check_wdata[23:16]), (^internal_intr_message_11_parity_check_wdata[15:8]), (^internal_intr_message_11_parity_check_wdata[7:0])};

	assign internal_intr_message_11_parity_check_wdata = {internal_intr_message_11_internal_intr_message[31], internal_intr_message_11_internal_intr_message[30], internal_intr_message_11_internal_intr_message[29], internal_intr_message_11_internal_intr_message[28], internal_intr_message_11_internal_intr_message[27], internal_intr_message_11_internal_intr_message[26], internal_intr_message_11_internal_intr_message[25], internal_intr_message_11_internal_intr_message[24], internal_intr_message_11_internal_intr_message[23], internal_intr_message_11_internal_intr_message[22], internal_intr_message_11_internal_intr_message[21], internal_intr_message_11_internal_intr_message[20], internal_intr_message_11_internal_intr_message[19], internal_intr_message_11_internal_intr_message[18], internal_intr_message_11_internal_intr_message[17], internal_intr_message_11_internal_intr_message[16], internal_intr_message_11_internal_intr_message[15], internal_intr_message_11_internal_intr_message[14], internal_intr_message_11_internal_intr_message[13], internal_intr_message_11_internal_intr_message[12], internal_intr_message_11_internal_intr_message[11], internal_intr_message_11_internal_intr_message[10], internal_intr_message_11_internal_intr_message[9], internal_intr_message_11_internal_intr_message[8], internal_intr_message_11_internal_intr_message[7], internal_intr_message_11_internal_intr_message[6], internal_intr_message_11_internal_intr_message[5], internal_intr_message_11_internal_intr_message[4], internal_intr_message_11_internal_intr_message[3], internal_intr_message_11_internal_intr_message[2], internal_intr_message_11_internal_intr_message[1], internal_intr_message_11_internal_intr_message[0]};

	assign internal_intr_message_11_parity_check_err = (internal_intr_message_11_parity_check_bit != internal_intr_message_11_parity_bit);

	assign internal_intr_message_11_parity_hw_check_err = internal_intr_message_11_parity_check_err;

	assign internal_intr_message_12_rdat = {internal_intr_message_12_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_12_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_12_internal_intr_message_wena) internal_intr_message_12_internal_intr_message <= internal_intr_message_12_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_12_internal_intr_message_rdat = internal_intr_message_12_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_12_internal_intr_message_wena) internal_intr_message_12_internal_intr_message_parity = internal_intr_message_12_internal_intr_message_wdat;
	    else internal_intr_message_12_internal_intr_message_parity = internal_intr_message_12_internal_intr_message;
	end

	assign internal_intr_message_12_parity_ena = (internal_intr_message_12_internal_intr_message_wena);

	assign internal_intr_message_12_parity_wdata = {internal_intr_message_12_internal_intr_message_parity[31], internal_intr_message_12_internal_intr_message_parity[30], internal_intr_message_12_internal_intr_message_parity[29], internal_intr_message_12_internal_intr_message_parity[28], internal_intr_message_12_internal_intr_message_parity[27], internal_intr_message_12_internal_intr_message_parity[26], internal_intr_message_12_internal_intr_message_parity[25], internal_intr_message_12_internal_intr_message_parity[24], internal_intr_message_12_internal_intr_message_parity[23], internal_intr_message_12_internal_intr_message_parity[22], internal_intr_message_12_internal_intr_message_parity[21], internal_intr_message_12_internal_intr_message_parity[20], internal_intr_message_12_internal_intr_message_parity[19], internal_intr_message_12_internal_intr_message_parity[18], internal_intr_message_12_internal_intr_message_parity[17], internal_intr_message_12_internal_intr_message_parity[16], internal_intr_message_12_internal_intr_message_parity[15], internal_intr_message_12_internal_intr_message_parity[14], internal_intr_message_12_internal_intr_message_parity[13], internal_intr_message_12_internal_intr_message_parity[12], internal_intr_message_12_internal_intr_message_parity[11], internal_intr_message_12_internal_intr_message_parity[10], internal_intr_message_12_internal_intr_message_parity[9], internal_intr_message_12_internal_intr_message_parity[8], internal_intr_message_12_internal_intr_message_parity[7], internal_intr_message_12_internal_intr_message_parity[6], internal_intr_message_12_internal_intr_message_parity[5], internal_intr_message_12_internal_intr_message_parity[4], internal_intr_message_12_internal_intr_message_parity[3], internal_intr_message_12_internal_intr_message_parity[2], internal_intr_message_12_internal_intr_message_parity[1], internal_intr_message_12_internal_intr_message_parity[0]};

	assign internal_intr_message_12_parity_update = {(^internal_intr_message_12_parity_wdata[31:24]), (^internal_intr_message_12_parity_wdata[23:16]), (^internal_intr_message_12_parity_wdata[15:8]), (^internal_intr_message_12_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_12_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_12_parity_ena) internal_intr_message_12_parity_bit <= internal_intr_message_12_parity_update;
	    end
	end

	assign internal_intr_message_12_parity_check_bit = {(^internal_intr_message_12_parity_check_wdata[31:24]), (^internal_intr_message_12_parity_check_wdata[23:16]), (^internal_intr_message_12_parity_check_wdata[15:8]), (^internal_intr_message_12_parity_check_wdata[7:0])};

	assign internal_intr_message_12_parity_check_wdata = {internal_intr_message_12_internal_intr_message[31], internal_intr_message_12_internal_intr_message[30], internal_intr_message_12_internal_intr_message[29], internal_intr_message_12_internal_intr_message[28], internal_intr_message_12_internal_intr_message[27], internal_intr_message_12_internal_intr_message[26], internal_intr_message_12_internal_intr_message[25], internal_intr_message_12_internal_intr_message[24], internal_intr_message_12_internal_intr_message[23], internal_intr_message_12_internal_intr_message[22], internal_intr_message_12_internal_intr_message[21], internal_intr_message_12_internal_intr_message[20], internal_intr_message_12_internal_intr_message[19], internal_intr_message_12_internal_intr_message[18], internal_intr_message_12_internal_intr_message[17], internal_intr_message_12_internal_intr_message[16], internal_intr_message_12_internal_intr_message[15], internal_intr_message_12_internal_intr_message[14], internal_intr_message_12_internal_intr_message[13], internal_intr_message_12_internal_intr_message[12], internal_intr_message_12_internal_intr_message[11], internal_intr_message_12_internal_intr_message[10], internal_intr_message_12_internal_intr_message[9], internal_intr_message_12_internal_intr_message[8], internal_intr_message_12_internal_intr_message[7], internal_intr_message_12_internal_intr_message[6], internal_intr_message_12_internal_intr_message[5], internal_intr_message_12_internal_intr_message[4], internal_intr_message_12_internal_intr_message[3], internal_intr_message_12_internal_intr_message[2], internal_intr_message_12_internal_intr_message[1], internal_intr_message_12_internal_intr_message[0]};

	assign internal_intr_message_12_parity_check_err = (internal_intr_message_12_parity_check_bit != internal_intr_message_12_parity_bit);

	assign internal_intr_message_12_parity_hw_check_err = internal_intr_message_12_parity_check_err;

	assign internal_intr_message_13_rdat = {internal_intr_message_13_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_13_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_13_internal_intr_message_wena) internal_intr_message_13_internal_intr_message <= internal_intr_message_13_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_13_internal_intr_message_rdat = internal_intr_message_13_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_13_internal_intr_message_wena) internal_intr_message_13_internal_intr_message_parity = internal_intr_message_13_internal_intr_message_wdat;
	    else internal_intr_message_13_internal_intr_message_parity = internal_intr_message_13_internal_intr_message;
	end

	assign internal_intr_message_13_parity_ena = (internal_intr_message_13_internal_intr_message_wena);

	assign internal_intr_message_13_parity_wdata = {internal_intr_message_13_internal_intr_message_parity[31], internal_intr_message_13_internal_intr_message_parity[30], internal_intr_message_13_internal_intr_message_parity[29], internal_intr_message_13_internal_intr_message_parity[28], internal_intr_message_13_internal_intr_message_parity[27], internal_intr_message_13_internal_intr_message_parity[26], internal_intr_message_13_internal_intr_message_parity[25], internal_intr_message_13_internal_intr_message_parity[24], internal_intr_message_13_internal_intr_message_parity[23], internal_intr_message_13_internal_intr_message_parity[22], internal_intr_message_13_internal_intr_message_parity[21], internal_intr_message_13_internal_intr_message_parity[20], internal_intr_message_13_internal_intr_message_parity[19], internal_intr_message_13_internal_intr_message_parity[18], internal_intr_message_13_internal_intr_message_parity[17], internal_intr_message_13_internal_intr_message_parity[16], internal_intr_message_13_internal_intr_message_parity[15], internal_intr_message_13_internal_intr_message_parity[14], internal_intr_message_13_internal_intr_message_parity[13], internal_intr_message_13_internal_intr_message_parity[12], internal_intr_message_13_internal_intr_message_parity[11], internal_intr_message_13_internal_intr_message_parity[10], internal_intr_message_13_internal_intr_message_parity[9], internal_intr_message_13_internal_intr_message_parity[8], internal_intr_message_13_internal_intr_message_parity[7], internal_intr_message_13_internal_intr_message_parity[6], internal_intr_message_13_internal_intr_message_parity[5], internal_intr_message_13_internal_intr_message_parity[4], internal_intr_message_13_internal_intr_message_parity[3], internal_intr_message_13_internal_intr_message_parity[2], internal_intr_message_13_internal_intr_message_parity[1], internal_intr_message_13_internal_intr_message_parity[0]};

	assign internal_intr_message_13_parity_update = {(^internal_intr_message_13_parity_wdata[31:24]), (^internal_intr_message_13_parity_wdata[23:16]), (^internal_intr_message_13_parity_wdata[15:8]), (^internal_intr_message_13_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_13_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_13_parity_ena) internal_intr_message_13_parity_bit <= internal_intr_message_13_parity_update;
	    end
	end

	assign internal_intr_message_13_parity_check_bit = {(^internal_intr_message_13_parity_check_wdata[31:24]), (^internal_intr_message_13_parity_check_wdata[23:16]), (^internal_intr_message_13_parity_check_wdata[15:8]), (^internal_intr_message_13_parity_check_wdata[7:0])};

	assign internal_intr_message_13_parity_check_wdata = {internal_intr_message_13_internal_intr_message[31], internal_intr_message_13_internal_intr_message[30], internal_intr_message_13_internal_intr_message[29], internal_intr_message_13_internal_intr_message[28], internal_intr_message_13_internal_intr_message[27], internal_intr_message_13_internal_intr_message[26], internal_intr_message_13_internal_intr_message[25], internal_intr_message_13_internal_intr_message[24], internal_intr_message_13_internal_intr_message[23], internal_intr_message_13_internal_intr_message[22], internal_intr_message_13_internal_intr_message[21], internal_intr_message_13_internal_intr_message[20], internal_intr_message_13_internal_intr_message[19], internal_intr_message_13_internal_intr_message[18], internal_intr_message_13_internal_intr_message[17], internal_intr_message_13_internal_intr_message[16], internal_intr_message_13_internal_intr_message[15], internal_intr_message_13_internal_intr_message[14], internal_intr_message_13_internal_intr_message[13], internal_intr_message_13_internal_intr_message[12], internal_intr_message_13_internal_intr_message[11], internal_intr_message_13_internal_intr_message[10], internal_intr_message_13_internal_intr_message[9], internal_intr_message_13_internal_intr_message[8], internal_intr_message_13_internal_intr_message[7], internal_intr_message_13_internal_intr_message[6], internal_intr_message_13_internal_intr_message[5], internal_intr_message_13_internal_intr_message[4], internal_intr_message_13_internal_intr_message[3], internal_intr_message_13_internal_intr_message[2], internal_intr_message_13_internal_intr_message[1], internal_intr_message_13_internal_intr_message[0]};

	assign internal_intr_message_13_parity_check_err = (internal_intr_message_13_parity_check_bit != internal_intr_message_13_parity_bit);

	assign internal_intr_message_13_parity_hw_check_err = internal_intr_message_13_parity_check_err;

	assign internal_intr_message_14_rdat = {internal_intr_message_14_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_14_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_14_internal_intr_message_wena) internal_intr_message_14_internal_intr_message <= internal_intr_message_14_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_14_internal_intr_message_rdat = internal_intr_message_14_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_14_internal_intr_message_wena) internal_intr_message_14_internal_intr_message_parity = internal_intr_message_14_internal_intr_message_wdat;
	    else internal_intr_message_14_internal_intr_message_parity = internal_intr_message_14_internal_intr_message;
	end

	assign internal_intr_message_14_parity_ena = (internal_intr_message_14_internal_intr_message_wena);

	assign internal_intr_message_14_parity_wdata = {internal_intr_message_14_internal_intr_message_parity[31], internal_intr_message_14_internal_intr_message_parity[30], internal_intr_message_14_internal_intr_message_parity[29], internal_intr_message_14_internal_intr_message_parity[28], internal_intr_message_14_internal_intr_message_parity[27], internal_intr_message_14_internal_intr_message_parity[26], internal_intr_message_14_internal_intr_message_parity[25], internal_intr_message_14_internal_intr_message_parity[24], internal_intr_message_14_internal_intr_message_parity[23], internal_intr_message_14_internal_intr_message_parity[22], internal_intr_message_14_internal_intr_message_parity[21], internal_intr_message_14_internal_intr_message_parity[20], internal_intr_message_14_internal_intr_message_parity[19], internal_intr_message_14_internal_intr_message_parity[18], internal_intr_message_14_internal_intr_message_parity[17], internal_intr_message_14_internal_intr_message_parity[16], internal_intr_message_14_internal_intr_message_parity[15], internal_intr_message_14_internal_intr_message_parity[14], internal_intr_message_14_internal_intr_message_parity[13], internal_intr_message_14_internal_intr_message_parity[12], internal_intr_message_14_internal_intr_message_parity[11], internal_intr_message_14_internal_intr_message_parity[10], internal_intr_message_14_internal_intr_message_parity[9], internal_intr_message_14_internal_intr_message_parity[8], internal_intr_message_14_internal_intr_message_parity[7], internal_intr_message_14_internal_intr_message_parity[6], internal_intr_message_14_internal_intr_message_parity[5], internal_intr_message_14_internal_intr_message_parity[4], internal_intr_message_14_internal_intr_message_parity[3], internal_intr_message_14_internal_intr_message_parity[2], internal_intr_message_14_internal_intr_message_parity[1], internal_intr_message_14_internal_intr_message_parity[0]};

	assign internal_intr_message_14_parity_update = {(^internal_intr_message_14_parity_wdata[31:24]), (^internal_intr_message_14_parity_wdata[23:16]), (^internal_intr_message_14_parity_wdata[15:8]), (^internal_intr_message_14_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_14_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_14_parity_ena) internal_intr_message_14_parity_bit <= internal_intr_message_14_parity_update;
	    end
	end

	assign internal_intr_message_14_parity_check_bit = {(^internal_intr_message_14_parity_check_wdata[31:24]), (^internal_intr_message_14_parity_check_wdata[23:16]), (^internal_intr_message_14_parity_check_wdata[15:8]), (^internal_intr_message_14_parity_check_wdata[7:0])};

	assign internal_intr_message_14_parity_check_wdata = {internal_intr_message_14_internal_intr_message[31], internal_intr_message_14_internal_intr_message[30], internal_intr_message_14_internal_intr_message[29], internal_intr_message_14_internal_intr_message[28], internal_intr_message_14_internal_intr_message[27], internal_intr_message_14_internal_intr_message[26], internal_intr_message_14_internal_intr_message[25], internal_intr_message_14_internal_intr_message[24], internal_intr_message_14_internal_intr_message[23], internal_intr_message_14_internal_intr_message[22], internal_intr_message_14_internal_intr_message[21], internal_intr_message_14_internal_intr_message[20], internal_intr_message_14_internal_intr_message[19], internal_intr_message_14_internal_intr_message[18], internal_intr_message_14_internal_intr_message[17], internal_intr_message_14_internal_intr_message[16], internal_intr_message_14_internal_intr_message[15], internal_intr_message_14_internal_intr_message[14], internal_intr_message_14_internal_intr_message[13], internal_intr_message_14_internal_intr_message[12], internal_intr_message_14_internal_intr_message[11], internal_intr_message_14_internal_intr_message[10], internal_intr_message_14_internal_intr_message[9], internal_intr_message_14_internal_intr_message[8], internal_intr_message_14_internal_intr_message[7], internal_intr_message_14_internal_intr_message[6], internal_intr_message_14_internal_intr_message[5], internal_intr_message_14_internal_intr_message[4], internal_intr_message_14_internal_intr_message[3], internal_intr_message_14_internal_intr_message[2], internal_intr_message_14_internal_intr_message[1], internal_intr_message_14_internal_intr_message[0]};

	assign internal_intr_message_14_parity_check_err = (internal_intr_message_14_parity_check_bit != internal_intr_message_14_parity_bit);

	assign internal_intr_message_14_parity_hw_check_err = internal_intr_message_14_parity_check_err;

	assign internal_intr_message_15_rdat = {internal_intr_message_15_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_15_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_15_internal_intr_message_wena) internal_intr_message_15_internal_intr_message <= internal_intr_message_15_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_15_internal_intr_message_rdat = internal_intr_message_15_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_15_internal_intr_message_wena) internal_intr_message_15_internal_intr_message_parity = internal_intr_message_15_internal_intr_message_wdat;
	    else internal_intr_message_15_internal_intr_message_parity = internal_intr_message_15_internal_intr_message;
	end

	assign internal_intr_message_15_parity_ena = (internal_intr_message_15_internal_intr_message_wena);

	assign internal_intr_message_15_parity_wdata = {internal_intr_message_15_internal_intr_message_parity[31], internal_intr_message_15_internal_intr_message_parity[30], internal_intr_message_15_internal_intr_message_parity[29], internal_intr_message_15_internal_intr_message_parity[28], internal_intr_message_15_internal_intr_message_parity[27], internal_intr_message_15_internal_intr_message_parity[26], internal_intr_message_15_internal_intr_message_parity[25], internal_intr_message_15_internal_intr_message_parity[24], internal_intr_message_15_internal_intr_message_parity[23], internal_intr_message_15_internal_intr_message_parity[22], internal_intr_message_15_internal_intr_message_parity[21], internal_intr_message_15_internal_intr_message_parity[20], internal_intr_message_15_internal_intr_message_parity[19], internal_intr_message_15_internal_intr_message_parity[18], internal_intr_message_15_internal_intr_message_parity[17], internal_intr_message_15_internal_intr_message_parity[16], internal_intr_message_15_internal_intr_message_parity[15], internal_intr_message_15_internal_intr_message_parity[14], internal_intr_message_15_internal_intr_message_parity[13], internal_intr_message_15_internal_intr_message_parity[12], internal_intr_message_15_internal_intr_message_parity[11], internal_intr_message_15_internal_intr_message_parity[10], internal_intr_message_15_internal_intr_message_parity[9], internal_intr_message_15_internal_intr_message_parity[8], internal_intr_message_15_internal_intr_message_parity[7], internal_intr_message_15_internal_intr_message_parity[6], internal_intr_message_15_internal_intr_message_parity[5], internal_intr_message_15_internal_intr_message_parity[4], internal_intr_message_15_internal_intr_message_parity[3], internal_intr_message_15_internal_intr_message_parity[2], internal_intr_message_15_internal_intr_message_parity[1], internal_intr_message_15_internal_intr_message_parity[0]};

	assign internal_intr_message_15_parity_update = {(^internal_intr_message_15_parity_wdata[31:24]), (^internal_intr_message_15_parity_wdata[23:16]), (^internal_intr_message_15_parity_wdata[15:8]), (^internal_intr_message_15_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_15_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_15_parity_ena) internal_intr_message_15_parity_bit <= internal_intr_message_15_parity_update;
	    end
	end

	assign internal_intr_message_15_parity_check_bit = {(^internal_intr_message_15_parity_check_wdata[31:24]), (^internal_intr_message_15_parity_check_wdata[23:16]), (^internal_intr_message_15_parity_check_wdata[15:8]), (^internal_intr_message_15_parity_check_wdata[7:0])};

	assign internal_intr_message_15_parity_check_wdata = {internal_intr_message_15_internal_intr_message[31], internal_intr_message_15_internal_intr_message[30], internal_intr_message_15_internal_intr_message[29], internal_intr_message_15_internal_intr_message[28], internal_intr_message_15_internal_intr_message[27], internal_intr_message_15_internal_intr_message[26], internal_intr_message_15_internal_intr_message[25], internal_intr_message_15_internal_intr_message[24], internal_intr_message_15_internal_intr_message[23], internal_intr_message_15_internal_intr_message[22], internal_intr_message_15_internal_intr_message[21], internal_intr_message_15_internal_intr_message[20], internal_intr_message_15_internal_intr_message[19], internal_intr_message_15_internal_intr_message[18], internal_intr_message_15_internal_intr_message[17], internal_intr_message_15_internal_intr_message[16], internal_intr_message_15_internal_intr_message[15], internal_intr_message_15_internal_intr_message[14], internal_intr_message_15_internal_intr_message[13], internal_intr_message_15_internal_intr_message[12], internal_intr_message_15_internal_intr_message[11], internal_intr_message_15_internal_intr_message[10], internal_intr_message_15_internal_intr_message[9], internal_intr_message_15_internal_intr_message[8], internal_intr_message_15_internal_intr_message[7], internal_intr_message_15_internal_intr_message[6], internal_intr_message_15_internal_intr_message[5], internal_intr_message_15_internal_intr_message[4], internal_intr_message_15_internal_intr_message[3], internal_intr_message_15_internal_intr_message[2], internal_intr_message_15_internal_intr_message[1], internal_intr_message_15_internal_intr_message[0]};

	assign internal_intr_message_15_parity_check_err = (internal_intr_message_15_parity_check_bit != internal_intr_message_15_parity_bit);

	assign internal_intr_message_15_parity_hw_check_err = internal_intr_message_15_parity_check_err;

	assign internal_intr_message_16_rdat = {internal_intr_message_16_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_16_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_16_internal_intr_message_wena) internal_intr_message_16_internal_intr_message <= internal_intr_message_16_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_16_internal_intr_message_rdat = internal_intr_message_16_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_16_internal_intr_message_wena) internal_intr_message_16_internal_intr_message_parity = internal_intr_message_16_internal_intr_message_wdat;
	    else internal_intr_message_16_internal_intr_message_parity = internal_intr_message_16_internal_intr_message;
	end

	assign internal_intr_message_16_parity_ena = (internal_intr_message_16_internal_intr_message_wena);

	assign internal_intr_message_16_parity_wdata = {internal_intr_message_16_internal_intr_message_parity[31], internal_intr_message_16_internal_intr_message_parity[30], internal_intr_message_16_internal_intr_message_parity[29], internal_intr_message_16_internal_intr_message_parity[28], internal_intr_message_16_internal_intr_message_parity[27], internal_intr_message_16_internal_intr_message_parity[26], internal_intr_message_16_internal_intr_message_parity[25], internal_intr_message_16_internal_intr_message_parity[24], internal_intr_message_16_internal_intr_message_parity[23], internal_intr_message_16_internal_intr_message_parity[22], internal_intr_message_16_internal_intr_message_parity[21], internal_intr_message_16_internal_intr_message_parity[20], internal_intr_message_16_internal_intr_message_parity[19], internal_intr_message_16_internal_intr_message_parity[18], internal_intr_message_16_internal_intr_message_parity[17], internal_intr_message_16_internal_intr_message_parity[16], internal_intr_message_16_internal_intr_message_parity[15], internal_intr_message_16_internal_intr_message_parity[14], internal_intr_message_16_internal_intr_message_parity[13], internal_intr_message_16_internal_intr_message_parity[12], internal_intr_message_16_internal_intr_message_parity[11], internal_intr_message_16_internal_intr_message_parity[10], internal_intr_message_16_internal_intr_message_parity[9], internal_intr_message_16_internal_intr_message_parity[8], internal_intr_message_16_internal_intr_message_parity[7], internal_intr_message_16_internal_intr_message_parity[6], internal_intr_message_16_internal_intr_message_parity[5], internal_intr_message_16_internal_intr_message_parity[4], internal_intr_message_16_internal_intr_message_parity[3], internal_intr_message_16_internal_intr_message_parity[2], internal_intr_message_16_internal_intr_message_parity[1], internal_intr_message_16_internal_intr_message_parity[0]};

	assign internal_intr_message_16_parity_update = {(^internal_intr_message_16_parity_wdata[31:24]), (^internal_intr_message_16_parity_wdata[23:16]), (^internal_intr_message_16_parity_wdata[15:8]), (^internal_intr_message_16_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_16_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_16_parity_ena) internal_intr_message_16_parity_bit <= internal_intr_message_16_parity_update;
	    end
	end

	assign internal_intr_message_16_parity_check_bit = {(^internal_intr_message_16_parity_check_wdata[31:24]), (^internal_intr_message_16_parity_check_wdata[23:16]), (^internal_intr_message_16_parity_check_wdata[15:8]), (^internal_intr_message_16_parity_check_wdata[7:0])};

	assign internal_intr_message_16_parity_check_wdata = {internal_intr_message_16_internal_intr_message[31], internal_intr_message_16_internal_intr_message[30], internal_intr_message_16_internal_intr_message[29], internal_intr_message_16_internal_intr_message[28], internal_intr_message_16_internal_intr_message[27], internal_intr_message_16_internal_intr_message[26], internal_intr_message_16_internal_intr_message[25], internal_intr_message_16_internal_intr_message[24], internal_intr_message_16_internal_intr_message[23], internal_intr_message_16_internal_intr_message[22], internal_intr_message_16_internal_intr_message[21], internal_intr_message_16_internal_intr_message[20], internal_intr_message_16_internal_intr_message[19], internal_intr_message_16_internal_intr_message[18], internal_intr_message_16_internal_intr_message[17], internal_intr_message_16_internal_intr_message[16], internal_intr_message_16_internal_intr_message[15], internal_intr_message_16_internal_intr_message[14], internal_intr_message_16_internal_intr_message[13], internal_intr_message_16_internal_intr_message[12], internal_intr_message_16_internal_intr_message[11], internal_intr_message_16_internal_intr_message[10], internal_intr_message_16_internal_intr_message[9], internal_intr_message_16_internal_intr_message[8], internal_intr_message_16_internal_intr_message[7], internal_intr_message_16_internal_intr_message[6], internal_intr_message_16_internal_intr_message[5], internal_intr_message_16_internal_intr_message[4], internal_intr_message_16_internal_intr_message[3], internal_intr_message_16_internal_intr_message[2], internal_intr_message_16_internal_intr_message[1], internal_intr_message_16_internal_intr_message[0]};

	assign internal_intr_message_16_parity_check_err = (internal_intr_message_16_parity_check_bit != internal_intr_message_16_parity_bit);

	assign internal_intr_message_16_parity_hw_check_err = internal_intr_message_16_parity_check_err;

	assign internal_intr_message_17_rdat = {internal_intr_message_17_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_17_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_17_internal_intr_message_wena) internal_intr_message_17_internal_intr_message <= internal_intr_message_17_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_17_internal_intr_message_rdat = internal_intr_message_17_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_17_internal_intr_message_wena) internal_intr_message_17_internal_intr_message_parity = internal_intr_message_17_internal_intr_message_wdat;
	    else internal_intr_message_17_internal_intr_message_parity = internal_intr_message_17_internal_intr_message;
	end

	assign internal_intr_message_17_parity_ena = (internal_intr_message_17_internal_intr_message_wena);

	assign internal_intr_message_17_parity_wdata = {internal_intr_message_17_internal_intr_message_parity[31], internal_intr_message_17_internal_intr_message_parity[30], internal_intr_message_17_internal_intr_message_parity[29], internal_intr_message_17_internal_intr_message_parity[28], internal_intr_message_17_internal_intr_message_parity[27], internal_intr_message_17_internal_intr_message_parity[26], internal_intr_message_17_internal_intr_message_parity[25], internal_intr_message_17_internal_intr_message_parity[24], internal_intr_message_17_internal_intr_message_parity[23], internal_intr_message_17_internal_intr_message_parity[22], internal_intr_message_17_internal_intr_message_parity[21], internal_intr_message_17_internal_intr_message_parity[20], internal_intr_message_17_internal_intr_message_parity[19], internal_intr_message_17_internal_intr_message_parity[18], internal_intr_message_17_internal_intr_message_parity[17], internal_intr_message_17_internal_intr_message_parity[16], internal_intr_message_17_internal_intr_message_parity[15], internal_intr_message_17_internal_intr_message_parity[14], internal_intr_message_17_internal_intr_message_parity[13], internal_intr_message_17_internal_intr_message_parity[12], internal_intr_message_17_internal_intr_message_parity[11], internal_intr_message_17_internal_intr_message_parity[10], internal_intr_message_17_internal_intr_message_parity[9], internal_intr_message_17_internal_intr_message_parity[8], internal_intr_message_17_internal_intr_message_parity[7], internal_intr_message_17_internal_intr_message_parity[6], internal_intr_message_17_internal_intr_message_parity[5], internal_intr_message_17_internal_intr_message_parity[4], internal_intr_message_17_internal_intr_message_parity[3], internal_intr_message_17_internal_intr_message_parity[2], internal_intr_message_17_internal_intr_message_parity[1], internal_intr_message_17_internal_intr_message_parity[0]};

	assign internal_intr_message_17_parity_update = {(^internal_intr_message_17_parity_wdata[31:24]), (^internal_intr_message_17_parity_wdata[23:16]), (^internal_intr_message_17_parity_wdata[15:8]), (^internal_intr_message_17_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_17_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_17_parity_ena) internal_intr_message_17_parity_bit <= internal_intr_message_17_parity_update;
	    end
	end

	assign internal_intr_message_17_parity_check_bit = {(^internal_intr_message_17_parity_check_wdata[31:24]), (^internal_intr_message_17_parity_check_wdata[23:16]), (^internal_intr_message_17_parity_check_wdata[15:8]), (^internal_intr_message_17_parity_check_wdata[7:0])};

	assign internal_intr_message_17_parity_check_wdata = {internal_intr_message_17_internal_intr_message[31], internal_intr_message_17_internal_intr_message[30], internal_intr_message_17_internal_intr_message[29], internal_intr_message_17_internal_intr_message[28], internal_intr_message_17_internal_intr_message[27], internal_intr_message_17_internal_intr_message[26], internal_intr_message_17_internal_intr_message[25], internal_intr_message_17_internal_intr_message[24], internal_intr_message_17_internal_intr_message[23], internal_intr_message_17_internal_intr_message[22], internal_intr_message_17_internal_intr_message[21], internal_intr_message_17_internal_intr_message[20], internal_intr_message_17_internal_intr_message[19], internal_intr_message_17_internal_intr_message[18], internal_intr_message_17_internal_intr_message[17], internal_intr_message_17_internal_intr_message[16], internal_intr_message_17_internal_intr_message[15], internal_intr_message_17_internal_intr_message[14], internal_intr_message_17_internal_intr_message[13], internal_intr_message_17_internal_intr_message[12], internal_intr_message_17_internal_intr_message[11], internal_intr_message_17_internal_intr_message[10], internal_intr_message_17_internal_intr_message[9], internal_intr_message_17_internal_intr_message[8], internal_intr_message_17_internal_intr_message[7], internal_intr_message_17_internal_intr_message[6], internal_intr_message_17_internal_intr_message[5], internal_intr_message_17_internal_intr_message[4], internal_intr_message_17_internal_intr_message[3], internal_intr_message_17_internal_intr_message[2], internal_intr_message_17_internal_intr_message[1], internal_intr_message_17_internal_intr_message[0]};

	assign internal_intr_message_17_parity_check_err = (internal_intr_message_17_parity_check_bit != internal_intr_message_17_parity_bit);

	assign internal_intr_message_17_parity_hw_check_err = internal_intr_message_17_parity_check_err;

	assign internal_intr_message_18_rdat = {internal_intr_message_18_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_18_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_18_internal_intr_message_wena) internal_intr_message_18_internal_intr_message <= internal_intr_message_18_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_18_internal_intr_message_rdat = internal_intr_message_18_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_18_internal_intr_message_wena) internal_intr_message_18_internal_intr_message_parity = internal_intr_message_18_internal_intr_message_wdat;
	    else internal_intr_message_18_internal_intr_message_parity = internal_intr_message_18_internal_intr_message;
	end

	assign internal_intr_message_18_parity_ena = (internal_intr_message_18_internal_intr_message_wena);

	assign internal_intr_message_18_parity_wdata = {internal_intr_message_18_internal_intr_message_parity[31], internal_intr_message_18_internal_intr_message_parity[30], internal_intr_message_18_internal_intr_message_parity[29], internal_intr_message_18_internal_intr_message_parity[28], internal_intr_message_18_internal_intr_message_parity[27], internal_intr_message_18_internal_intr_message_parity[26], internal_intr_message_18_internal_intr_message_parity[25], internal_intr_message_18_internal_intr_message_parity[24], internal_intr_message_18_internal_intr_message_parity[23], internal_intr_message_18_internal_intr_message_parity[22], internal_intr_message_18_internal_intr_message_parity[21], internal_intr_message_18_internal_intr_message_parity[20], internal_intr_message_18_internal_intr_message_parity[19], internal_intr_message_18_internal_intr_message_parity[18], internal_intr_message_18_internal_intr_message_parity[17], internal_intr_message_18_internal_intr_message_parity[16], internal_intr_message_18_internal_intr_message_parity[15], internal_intr_message_18_internal_intr_message_parity[14], internal_intr_message_18_internal_intr_message_parity[13], internal_intr_message_18_internal_intr_message_parity[12], internal_intr_message_18_internal_intr_message_parity[11], internal_intr_message_18_internal_intr_message_parity[10], internal_intr_message_18_internal_intr_message_parity[9], internal_intr_message_18_internal_intr_message_parity[8], internal_intr_message_18_internal_intr_message_parity[7], internal_intr_message_18_internal_intr_message_parity[6], internal_intr_message_18_internal_intr_message_parity[5], internal_intr_message_18_internal_intr_message_parity[4], internal_intr_message_18_internal_intr_message_parity[3], internal_intr_message_18_internal_intr_message_parity[2], internal_intr_message_18_internal_intr_message_parity[1], internal_intr_message_18_internal_intr_message_parity[0]};

	assign internal_intr_message_18_parity_update = {(^internal_intr_message_18_parity_wdata[31:24]), (^internal_intr_message_18_parity_wdata[23:16]), (^internal_intr_message_18_parity_wdata[15:8]), (^internal_intr_message_18_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_18_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_18_parity_ena) internal_intr_message_18_parity_bit <= internal_intr_message_18_parity_update;
	    end
	end

	assign internal_intr_message_18_parity_check_bit = {(^internal_intr_message_18_parity_check_wdata[31:24]), (^internal_intr_message_18_parity_check_wdata[23:16]), (^internal_intr_message_18_parity_check_wdata[15:8]), (^internal_intr_message_18_parity_check_wdata[7:0])};

	assign internal_intr_message_18_parity_check_wdata = {internal_intr_message_18_internal_intr_message[31], internal_intr_message_18_internal_intr_message[30], internal_intr_message_18_internal_intr_message[29], internal_intr_message_18_internal_intr_message[28], internal_intr_message_18_internal_intr_message[27], internal_intr_message_18_internal_intr_message[26], internal_intr_message_18_internal_intr_message[25], internal_intr_message_18_internal_intr_message[24], internal_intr_message_18_internal_intr_message[23], internal_intr_message_18_internal_intr_message[22], internal_intr_message_18_internal_intr_message[21], internal_intr_message_18_internal_intr_message[20], internal_intr_message_18_internal_intr_message[19], internal_intr_message_18_internal_intr_message[18], internal_intr_message_18_internal_intr_message[17], internal_intr_message_18_internal_intr_message[16], internal_intr_message_18_internal_intr_message[15], internal_intr_message_18_internal_intr_message[14], internal_intr_message_18_internal_intr_message[13], internal_intr_message_18_internal_intr_message[12], internal_intr_message_18_internal_intr_message[11], internal_intr_message_18_internal_intr_message[10], internal_intr_message_18_internal_intr_message[9], internal_intr_message_18_internal_intr_message[8], internal_intr_message_18_internal_intr_message[7], internal_intr_message_18_internal_intr_message[6], internal_intr_message_18_internal_intr_message[5], internal_intr_message_18_internal_intr_message[4], internal_intr_message_18_internal_intr_message[3], internal_intr_message_18_internal_intr_message[2], internal_intr_message_18_internal_intr_message[1], internal_intr_message_18_internal_intr_message[0]};

	assign internal_intr_message_18_parity_check_err = (internal_intr_message_18_parity_check_bit != internal_intr_message_18_parity_bit);

	assign internal_intr_message_18_parity_hw_check_err = internal_intr_message_18_parity_check_err;

	assign internal_intr_message_19_rdat = {internal_intr_message_19_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_19_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_19_internal_intr_message_wena) internal_intr_message_19_internal_intr_message <= internal_intr_message_19_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_19_internal_intr_message_rdat = internal_intr_message_19_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_19_internal_intr_message_wena) internal_intr_message_19_internal_intr_message_parity = internal_intr_message_19_internal_intr_message_wdat;
	    else internal_intr_message_19_internal_intr_message_parity = internal_intr_message_19_internal_intr_message;
	end

	assign internal_intr_message_19_parity_ena = (internal_intr_message_19_internal_intr_message_wena);

	assign internal_intr_message_19_parity_wdata = {internal_intr_message_19_internal_intr_message_parity[31], internal_intr_message_19_internal_intr_message_parity[30], internal_intr_message_19_internal_intr_message_parity[29], internal_intr_message_19_internal_intr_message_parity[28], internal_intr_message_19_internal_intr_message_parity[27], internal_intr_message_19_internal_intr_message_parity[26], internal_intr_message_19_internal_intr_message_parity[25], internal_intr_message_19_internal_intr_message_parity[24], internal_intr_message_19_internal_intr_message_parity[23], internal_intr_message_19_internal_intr_message_parity[22], internal_intr_message_19_internal_intr_message_parity[21], internal_intr_message_19_internal_intr_message_parity[20], internal_intr_message_19_internal_intr_message_parity[19], internal_intr_message_19_internal_intr_message_parity[18], internal_intr_message_19_internal_intr_message_parity[17], internal_intr_message_19_internal_intr_message_parity[16], internal_intr_message_19_internal_intr_message_parity[15], internal_intr_message_19_internal_intr_message_parity[14], internal_intr_message_19_internal_intr_message_parity[13], internal_intr_message_19_internal_intr_message_parity[12], internal_intr_message_19_internal_intr_message_parity[11], internal_intr_message_19_internal_intr_message_parity[10], internal_intr_message_19_internal_intr_message_parity[9], internal_intr_message_19_internal_intr_message_parity[8], internal_intr_message_19_internal_intr_message_parity[7], internal_intr_message_19_internal_intr_message_parity[6], internal_intr_message_19_internal_intr_message_parity[5], internal_intr_message_19_internal_intr_message_parity[4], internal_intr_message_19_internal_intr_message_parity[3], internal_intr_message_19_internal_intr_message_parity[2], internal_intr_message_19_internal_intr_message_parity[1], internal_intr_message_19_internal_intr_message_parity[0]};

	assign internal_intr_message_19_parity_update = {(^internal_intr_message_19_parity_wdata[31:24]), (^internal_intr_message_19_parity_wdata[23:16]), (^internal_intr_message_19_parity_wdata[15:8]), (^internal_intr_message_19_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_19_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_19_parity_ena) internal_intr_message_19_parity_bit <= internal_intr_message_19_parity_update;
	    end
	end

	assign internal_intr_message_19_parity_check_bit = {(^internal_intr_message_19_parity_check_wdata[31:24]), (^internal_intr_message_19_parity_check_wdata[23:16]), (^internal_intr_message_19_parity_check_wdata[15:8]), (^internal_intr_message_19_parity_check_wdata[7:0])};

	assign internal_intr_message_19_parity_check_wdata = {internal_intr_message_19_internal_intr_message[31], internal_intr_message_19_internal_intr_message[30], internal_intr_message_19_internal_intr_message[29], internal_intr_message_19_internal_intr_message[28], internal_intr_message_19_internal_intr_message[27], internal_intr_message_19_internal_intr_message[26], internal_intr_message_19_internal_intr_message[25], internal_intr_message_19_internal_intr_message[24], internal_intr_message_19_internal_intr_message[23], internal_intr_message_19_internal_intr_message[22], internal_intr_message_19_internal_intr_message[21], internal_intr_message_19_internal_intr_message[20], internal_intr_message_19_internal_intr_message[19], internal_intr_message_19_internal_intr_message[18], internal_intr_message_19_internal_intr_message[17], internal_intr_message_19_internal_intr_message[16], internal_intr_message_19_internal_intr_message[15], internal_intr_message_19_internal_intr_message[14], internal_intr_message_19_internal_intr_message[13], internal_intr_message_19_internal_intr_message[12], internal_intr_message_19_internal_intr_message[11], internal_intr_message_19_internal_intr_message[10], internal_intr_message_19_internal_intr_message[9], internal_intr_message_19_internal_intr_message[8], internal_intr_message_19_internal_intr_message[7], internal_intr_message_19_internal_intr_message[6], internal_intr_message_19_internal_intr_message[5], internal_intr_message_19_internal_intr_message[4], internal_intr_message_19_internal_intr_message[3], internal_intr_message_19_internal_intr_message[2], internal_intr_message_19_internal_intr_message[1], internal_intr_message_19_internal_intr_message[0]};

	assign internal_intr_message_19_parity_check_err = (internal_intr_message_19_parity_check_bit != internal_intr_message_19_parity_bit);

	assign internal_intr_message_19_parity_hw_check_err = internal_intr_message_19_parity_check_err;

	assign internal_intr_message_20_rdat = {internal_intr_message_20_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_20_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_20_internal_intr_message_wena) internal_intr_message_20_internal_intr_message <= internal_intr_message_20_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_20_internal_intr_message_rdat = internal_intr_message_20_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_20_internal_intr_message_wena) internal_intr_message_20_internal_intr_message_parity = internal_intr_message_20_internal_intr_message_wdat;
	    else internal_intr_message_20_internal_intr_message_parity = internal_intr_message_20_internal_intr_message;
	end

	assign internal_intr_message_20_parity_ena = (internal_intr_message_20_internal_intr_message_wena);

	assign internal_intr_message_20_parity_wdata = {internal_intr_message_20_internal_intr_message_parity[31], internal_intr_message_20_internal_intr_message_parity[30], internal_intr_message_20_internal_intr_message_parity[29], internal_intr_message_20_internal_intr_message_parity[28], internal_intr_message_20_internal_intr_message_parity[27], internal_intr_message_20_internal_intr_message_parity[26], internal_intr_message_20_internal_intr_message_parity[25], internal_intr_message_20_internal_intr_message_parity[24], internal_intr_message_20_internal_intr_message_parity[23], internal_intr_message_20_internal_intr_message_parity[22], internal_intr_message_20_internal_intr_message_parity[21], internal_intr_message_20_internal_intr_message_parity[20], internal_intr_message_20_internal_intr_message_parity[19], internal_intr_message_20_internal_intr_message_parity[18], internal_intr_message_20_internal_intr_message_parity[17], internal_intr_message_20_internal_intr_message_parity[16], internal_intr_message_20_internal_intr_message_parity[15], internal_intr_message_20_internal_intr_message_parity[14], internal_intr_message_20_internal_intr_message_parity[13], internal_intr_message_20_internal_intr_message_parity[12], internal_intr_message_20_internal_intr_message_parity[11], internal_intr_message_20_internal_intr_message_parity[10], internal_intr_message_20_internal_intr_message_parity[9], internal_intr_message_20_internal_intr_message_parity[8], internal_intr_message_20_internal_intr_message_parity[7], internal_intr_message_20_internal_intr_message_parity[6], internal_intr_message_20_internal_intr_message_parity[5], internal_intr_message_20_internal_intr_message_parity[4], internal_intr_message_20_internal_intr_message_parity[3], internal_intr_message_20_internal_intr_message_parity[2], internal_intr_message_20_internal_intr_message_parity[1], internal_intr_message_20_internal_intr_message_parity[0]};

	assign internal_intr_message_20_parity_update = {(^internal_intr_message_20_parity_wdata[31:24]), (^internal_intr_message_20_parity_wdata[23:16]), (^internal_intr_message_20_parity_wdata[15:8]), (^internal_intr_message_20_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_20_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_20_parity_ena) internal_intr_message_20_parity_bit <= internal_intr_message_20_parity_update;
	    end
	end

	assign internal_intr_message_20_parity_check_bit = {(^internal_intr_message_20_parity_check_wdata[31:24]), (^internal_intr_message_20_parity_check_wdata[23:16]), (^internal_intr_message_20_parity_check_wdata[15:8]), (^internal_intr_message_20_parity_check_wdata[7:0])};

	assign internal_intr_message_20_parity_check_wdata = {internal_intr_message_20_internal_intr_message[31], internal_intr_message_20_internal_intr_message[30], internal_intr_message_20_internal_intr_message[29], internal_intr_message_20_internal_intr_message[28], internal_intr_message_20_internal_intr_message[27], internal_intr_message_20_internal_intr_message[26], internal_intr_message_20_internal_intr_message[25], internal_intr_message_20_internal_intr_message[24], internal_intr_message_20_internal_intr_message[23], internal_intr_message_20_internal_intr_message[22], internal_intr_message_20_internal_intr_message[21], internal_intr_message_20_internal_intr_message[20], internal_intr_message_20_internal_intr_message[19], internal_intr_message_20_internal_intr_message[18], internal_intr_message_20_internal_intr_message[17], internal_intr_message_20_internal_intr_message[16], internal_intr_message_20_internal_intr_message[15], internal_intr_message_20_internal_intr_message[14], internal_intr_message_20_internal_intr_message[13], internal_intr_message_20_internal_intr_message[12], internal_intr_message_20_internal_intr_message[11], internal_intr_message_20_internal_intr_message[10], internal_intr_message_20_internal_intr_message[9], internal_intr_message_20_internal_intr_message[8], internal_intr_message_20_internal_intr_message[7], internal_intr_message_20_internal_intr_message[6], internal_intr_message_20_internal_intr_message[5], internal_intr_message_20_internal_intr_message[4], internal_intr_message_20_internal_intr_message[3], internal_intr_message_20_internal_intr_message[2], internal_intr_message_20_internal_intr_message[1], internal_intr_message_20_internal_intr_message[0]};

	assign internal_intr_message_20_parity_check_err = (internal_intr_message_20_parity_check_bit != internal_intr_message_20_parity_bit);

	assign internal_intr_message_20_parity_hw_check_err = internal_intr_message_20_parity_check_err;

	assign internal_intr_message_21_rdat = {internal_intr_message_21_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_21_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_21_internal_intr_message_wena) internal_intr_message_21_internal_intr_message <= internal_intr_message_21_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_21_internal_intr_message_rdat = internal_intr_message_21_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_21_internal_intr_message_wena) internal_intr_message_21_internal_intr_message_parity = internal_intr_message_21_internal_intr_message_wdat;
	    else internal_intr_message_21_internal_intr_message_parity = internal_intr_message_21_internal_intr_message;
	end

	assign internal_intr_message_21_parity_ena = (internal_intr_message_21_internal_intr_message_wena);

	assign internal_intr_message_21_parity_wdata = {internal_intr_message_21_internal_intr_message_parity[31], internal_intr_message_21_internal_intr_message_parity[30], internal_intr_message_21_internal_intr_message_parity[29], internal_intr_message_21_internal_intr_message_parity[28], internal_intr_message_21_internal_intr_message_parity[27], internal_intr_message_21_internal_intr_message_parity[26], internal_intr_message_21_internal_intr_message_parity[25], internal_intr_message_21_internal_intr_message_parity[24], internal_intr_message_21_internal_intr_message_parity[23], internal_intr_message_21_internal_intr_message_parity[22], internal_intr_message_21_internal_intr_message_parity[21], internal_intr_message_21_internal_intr_message_parity[20], internal_intr_message_21_internal_intr_message_parity[19], internal_intr_message_21_internal_intr_message_parity[18], internal_intr_message_21_internal_intr_message_parity[17], internal_intr_message_21_internal_intr_message_parity[16], internal_intr_message_21_internal_intr_message_parity[15], internal_intr_message_21_internal_intr_message_parity[14], internal_intr_message_21_internal_intr_message_parity[13], internal_intr_message_21_internal_intr_message_parity[12], internal_intr_message_21_internal_intr_message_parity[11], internal_intr_message_21_internal_intr_message_parity[10], internal_intr_message_21_internal_intr_message_parity[9], internal_intr_message_21_internal_intr_message_parity[8], internal_intr_message_21_internal_intr_message_parity[7], internal_intr_message_21_internal_intr_message_parity[6], internal_intr_message_21_internal_intr_message_parity[5], internal_intr_message_21_internal_intr_message_parity[4], internal_intr_message_21_internal_intr_message_parity[3], internal_intr_message_21_internal_intr_message_parity[2], internal_intr_message_21_internal_intr_message_parity[1], internal_intr_message_21_internal_intr_message_parity[0]};

	assign internal_intr_message_21_parity_update = {(^internal_intr_message_21_parity_wdata[31:24]), (^internal_intr_message_21_parity_wdata[23:16]), (^internal_intr_message_21_parity_wdata[15:8]), (^internal_intr_message_21_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_21_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_21_parity_ena) internal_intr_message_21_parity_bit <= internal_intr_message_21_parity_update;
	    end
	end

	assign internal_intr_message_21_parity_check_bit = {(^internal_intr_message_21_parity_check_wdata[31:24]), (^internal_intr_message_21_parity_check_wdata[23:16]), (^internal_intr_message_21_parity_check_wdata[15:8]), (^internal_intr_message_21_parity_check_wdata[7:0])};

	assign internal_intr_message_21_parity_check_wdata = {internal_intr_message_21_internal_intr_message[31], internal_intr_message_21_internal_intr_message[30], internal_intr_message_21_internal_intr_message[29], internal_intr_message_21_internal_intr_message[28], internal_intr_message_21_internal_intr_message[27], internal_intr_message_21_internal_intr_message[26], internal_intr_message_21_internal_intr_message[25], internal_intr_message_21_internal_intr_message[24], internal_intr_message_21_internal_intr_message[23], internal_intr_message_21_internal_intr_message[22], internal_intr_message_21_internal_intr_message[21], internal_intr_message_21_internal_intr_message[20], internal_intr_message_21_internal_intr_message[19], internal_intr_message_21_internal_intr_message[18], internal_intr_message_21_internal_intr_message[17], internal_intr_message_21_internal_intr_message[16], internal_intr_message_21_internal_intr_message[15], internal_intr_message_21_internal_intr_message[14], internal_intr_message_21_internal_intr_message[13], internal_intr_message_21_internal_intr_message[12], internal_intr_message_21_internal_intr_message[11], internal_intr_message_21_internal_intr_message[10], internal_intr_message_21_internal_intr_message[9], internal_intr_message_21_internal_intr_message[8], internal_intr_message_21_internal_intr_message[7], internal_intr_message_21_internal_intr_message[6], internal_intr_message_21_internal_intr_message[5], internal_intr_message_21_internal_intr_message[4], internal_intr_message_21_internal_intr_message[3], internal_intr_message_21_internal_intr_message[2], internal_intr_message_21_internal_intr_message[1], internal_intr_message_21_internal_intr_message[0]};

	assign internal_intr_message_21_parity_check_err = (internal_intr_message_21_parity_check_bit != internal_intr_message_21_parity_bit);

	assign internal_intr_message_21_parity_hw_check_err = internal_intr_message_21_parity_check_err;

	assign internal_intr_message_22_rdat = {internal_intr_message_22_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_22_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_22_internal_intr_message_wena) internal_intr_message_22_internal_intr_message <= internal_intr_message_22_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_22_internal_intr_message_rdat = internal_intr_message_22_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_22_internal_intr_message_wena) internal_intr_message_22_internal_intr_message_parity = internal_intr_message_22_internal_intr_message_wdat;
	    else internal_intr_message_22_internal_intr_message_parity = internal_intr_message_22_internal_intr_message;
	end

	assign internal_intr_message_22_parity_ena = (internal_intr_message_22_internal_intr_message_wena);

	assign internal_intr_message_22_parity_wdata = {internal_intr_message_22_internal_intr_message_parity[31], internal_intr_message_22_internal_intr_message_parity[30], internal_intr_message_22_internal_intr_message_parity[29], internal_intr_message_22_internal_intr_message_parity[28], internal_intr_message_22_internal_intr_message_parity[27], internal_intr_message_22_internal_intr_message_parity[26], internal_intr_message_22_internal_intr_message_parity[25], internal_intr_message_22_internal_intr_message_parity[24], internal_intr_message_22_internal_intr_message_parity[23], internal_intr_message_22_internal_intr_message_parity[22], internal_intr_message_22_internal_intr_message_parity[21], internal_intr_message_22_internal_intr_message_parity[20], internal_intr_message_22_internal_intr_message_parity[19], internal_intr_message_22_internal_intr_message_parity[18], internal_intr_message_22_internal_intr_message_parity[17], internal_intr_message_22_internal_intr_message_parity[16], internal_intr_message_22_internal_intr_message_parity[15], internal_intr_message_22_internal_intr_message_parity[14], internal_intr_message_22_internal_intr_message_parity[13], internal_intr_message_22_internal_intr_message_parity[12], internal_intr_message_22_internal_intr_message_parity[11], internal_intr_message_22_internal_intr_message_parity[10], internal_intr_message_22_internal_intr_message_parity[9], internal_intr_message_22_internal_intr_message_parity[8], internal_intr_message_22_internal_intr_message_parity[7], internal_intr_message_22_internal_intr_message_parity[6], internal_intr_message_22_internal_intr_message_parity[5], internal_intr_message_22_internal_intr_message_parity[4], internal_intr_message_22_internal_intr_message_parity[3], internal_intr_message_22_internal_intr_message_parity[2], internal_intr_message_22_internal_intr_message_parity[1], internal_intr_message_22_internal_intr_message_parity[0]};

	assign internal_intr_message_22_parity_update = {(^internal_intr_message_22_parity_wdata[31:24]), (^internal_intr_message_22_parity_wdata[23:16]), (^internal_intr_message_22_parity_wdata[15:8]), (^internal_intr_message_22_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_22_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_22_parity_ena) internal_intr_message_22_parity_bit <= internal_intr_message_22_parity_update;
	    end
	end

	assign internal_intr_message_22_parity_check_bit = {(^internal_intr_message_22_parity_check_wdata[31:24]), (^internal_intr_message_22_parity_check_wdata[23:16]), (^internal_intr_message_22_parity_check_wdata[15:8]), (^internal_intr_message_22_parity_check_wdata[7:0])};

	assign internal_intr_message_22_parity_check_wdata = {internal_intr_message_22_internal_intr_message[31], internal_intr_message_22_internal_intr_message[30], internal_intr_message_22_internal_intr_message[29], internal_intr_message_22_internal_intr_message[28], internal_intr_message_22_internal_intr_message[27], internal_intr_message_22_internal_intr_message[26], internal_intr_message_22_internal_intr_message[25], internal_intr_message_22_internal_intr_message[24], internal_intr_message_22_internal_intr_message[23], internal_intr_message_22_internal_intr_message[22], internal_intr_message_22_internal_intr_message[21], internal_intr_message_22_internal_intr_message[20], internal_intr_message_22_internal_intr_message[19], internal_intr_message_22_internal_intr_message[18], internal_intr_message_22_internal_intr_message[17], internal_intr_message_22_internal_intr_message[16], internal_intr_message_22_internal_intr_message[15], internal_intr_message_22_internal_intr_message[14], internal_intr_message_22_internal_intr_message[13], internal_intr_message_22_internal_intr_message[12], internal_intr_message_22_internal_intr_message[11], internal_intr_message_22_internal_intr_message[10], internal_intr_message_22_internal_intr_message[9], internal_intr_message_22_internal_intr_message[8], internal_intr_message_22_internal_intr_message[7], internal_intr_message_22_internal_intr_message[6], internal_intr_message_22_internal_intr_message[5], internal_intr_message_22_internal_intr_message[4], internal_intr_message_22_internal_intr_message[3], internal_intr_message_22_internal_intr_message[2], internal_intr_message_22_internal_intr_message[1], internal_intr_message_22_internal_intr_message[0]};

	assign internal_intr_message_22_parity_check_err = (internal_intr_message_22_parity_check_bit != internal_intr_message_22_parity_bit);

	assign internal_intr_message_22_parity_hw_check_err = internal_intr_message_22_parity_check_err;

	assign internal_intr_message_23_rdat = {internal_intr_message_23_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_23_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_23_internal_intr_message_wena) internal_intr_message_23_internal_intr_message <= internal_intr_message_23_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_23_internal_intr_message_rdat = internal_intr_message_23_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_23_internal_intr_message_wena) internal_intr_message_23_internal_intr_message_parity = internal_intr_message_23_internal_intr_message_wdat;
	    else internal_intr_message_23_internal_intr_message_parity = internal_intr_message_23_internal_intr_message;
	end

	assign internal_intr_message_23_parity_ena = (internal_intr_message_23_internal_intr_message_wena);

	assign internal_intr_message_23_parity_wdata = {internal_intr_message_23_internal_intr_message_parity[31], internal_intr_message_23_internal_intr_message_parity[30], internal_intr_message_23_internal_intr_message_parity[29], internal_intr_message_23_internal_intr_message_parity[28], internal_intr_message_23_internal_intr_message_parity[27], internal_intr_message_23_internal_intr_message_parity[26], internal_intr_message_23_internal_intr_message_parity[25], internal_intr_message_23_internal_intr_message_parity[24], internal_intr_message_23_internal_intr_message_parity[23], internal_intr_message_23_internal_intr_message_parity[22], internal_intr_message_23_internal_intr_message_parity[21], internal_intr_message_23_internal_intr_message_parity[20], internal_intr_message_23_internal_intr_message_parity[19], internal_intr_message_23_internal_intr_message_parity[18], internal_intr_message_23_internal_intr_message_parity[17], internal_intr_message_23_internal_intr_message_parity[16], internal_intr_message_23_internal_intr_message_parity[15], internal_intr_message_23_internal_intr_message_parity[14], internal_intr_message_23_internal_intr_message_parity[13], internal_intr_message_23_internal_intr_message_parity[12], internal_intr_message_23_internal_intr_message_parity[11], internal_intr_message_23_internal_intr_message_parity[10], internal_intr_message_23_internal_intr_message_parity[9], internal_intr_message_23_internal_intr_message_parity[8], internal_intr_message_23_internal_intr_message_parity[7], internal_intr_message_23_internal_intr_message_parity[6], internal_intr_message_23_internal_intr_message_parity[5], internal_intr_message_23_internal_intr_message_parity[4], internal_intr_message_23_internal_intr_message_parity[3], internal_intr_message_23_internal_intr_message_parity[2], internal_intr_message_23_internal_intr_message_parity[1], internal_intr_message_23_internal_intr_message_parity[0]};

	assign internal_intr_message_23_parity_update = {(^internal_intr_message_23_parity_wdata[31:24]), (^internal_intr_message_23_parity_wdata[23:16]), (^internal_intr_message_23_parity_wdata[15:8]), (^internal_intr_message_23_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_23_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_23_parity_ena) internal_intr_message_23_parity_bit <= internal_intr_message_23_parity_update;
	    end
	end

	assign internal_intr_message_23_parity_check_bit = {(^internal_intr_message_23_parity_check_wdata[31:24]), (^internal_intr_message_23_parity_check_wdata[23:16]), (^internal_intr_message_23_parity_check_wdata[15:8]), (^internal_intr_message_23_parity_check_wdata[7:0])};

	assign internal_intr_message_23_parity_check_wdata = {internal_intr_message_23_internal_intr_message[31], internal_intr_message_23_internal_intr_message[30], internal_intr_message_23_internal_intr_message[29], internal_intr_message_23_internal_intr_message[28], internal_intr_message_23_internal_intr_message[27], internal_intr_message_23_internal_intr_message[26], internal_intr_message_23_internal_intr_message[25], internal_intr_message_23_internal_intr_message[24], internal_intr_message_23_internal_intr_message[23], internal_intr_message_23_internal_intr_message[22], internal_intr_message_23_internal_intr_message[21], internal_intr_message_23_internal_intr_message[20], internal_intr_message_23_internal_intr_message[19], internal_intr_message_23_internal_intr_message[18], internal_intr_message_23_internal_intr_message[17], internal_intr_message_23_internal_intr_message[16], internal_intr_message_23_internal_intr_message[15], internal_intr_message_23_internal_intr_message[14], internal_intr_message_23_internal_intr_message[13], internal_intr_message_23_internal_intr_message[12], internal_intr_message_23_internal_intr_message[11], internal_intr_message_23_internal_intr_message[10], internal_intr_message_23_internal_intr_message[9], internal_intr_message_23_internal_intr_message[8], internal_intr_message_23_internal_intr_message[7], internal_intr_message_23_internal_intr_message[6], internal_intr_message_23_internal_intr_message[5], internal_intr_message_23_internal_intr_message[4], internal_intr_message_23_internal_intr_message[3], internal_intr_message_23_internal_intr_message[2], internal_intr_message_23_internal_intr_message[1], internal_intr_message_23_internal_intr_message[0]};

	assign internal_intr_message_23_parity_check_err = (internal_intr_message_23_parity_check_bit != internal_intr_message_23_parity_bit);

	assign internal_intr_message_23_parity_hw_check_err = internal_intr_message_23_parity_check_err;

	assign internal_intr_message_24_rdat = {internal_intr_message_24_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_24_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_24_internal_intr_message_wena) internal_intr_message_24_internal_intr_message <= internal_intr_message_24_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_24_internal_intr_message_rdat = internal_intr_message_24_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_24_internal_intr_message_wena) internal_intr_message_24_internal_intr_message_parity = internal_intr_message_24_internal_intr_message_wdat;
	    else internal_intr_message_24_internal_intr_message_parity = internal_intr_message_24_internal_intr_message;
	end

	assign internal_intr_message_24_parity_ena = (internal_intr_message_24_internal_intr_message_wena);

	assign internal_intr_message_24_parity_wdata = {internal_intr_message_24_internal_intr_message_parity[31], internal_intr_message_24_internal_intr_message_parity[30], internal_intr_message_24_internal_intr_message_parity[29], internal_intr_message_24_internal_intr_message_parity[28], internal_intr_message_24_internal_intr_message_parity[27], internal_intr_message_24_internal_intr_message_parity[26], internal_intr_message_24_internal_intr_message_parity[25], internal_intr_message_24_internal_intr_message_parity[24], internal_intr_message_24_internal_intr_message_parity[23], internal_intr_message_24_internal_intr_message_parity[22], internal_intr_message_24_internal_intr_message_parity[21], internal_intr_message_24_internal_intr_message_parity[20], internal_intr_message_24_internal_intr_message_parity[19], internal_intr_message_24_internal_intr_message_parity[18], internal_intr_message_24_internal_intr_message_parity[17], internal_intr_message_24_internal_intr_message_parity[16], internal_intr_message_24_internal_intr_message_parity[15], internal_intr_message_24_internal_intr_message_parity[14], internal_intr_message_24_internal_intr_message_parity[13], internal_intr_message_24_internal_intr_message_parity[12], internal_intr_message_24_internal_intr_message_parity[11], internal_intr_message_24_internal_intr_message_parity[10], internal_intr_message_24_internal_intr_message_parity[9], internal_intr_message_24_internal_intr_message_parity[8], internal_intr_message_24_internal_intr_message_parity[7], internal_intr_message_24_internal_intr_message_parity[6], internal_intr_message_24_internal_intr_message_parity[5], internal_intr_message_24_internal_intr_message_parity[4], internal_intr_message_24_internal_intr_message_parity[3], internal_intr_message_24_internal_intr_message_parity[2], internal_intr_message_24_internal_intr_message_parity[1], internal_intr_message_24_internal_intr_message_parity[0]};

	assign internal_intr_message_24_parity_update = {(^internal_intr_message_24_parity_wdata[31:24]), (^internal_intr_message_24_parity_wdata[23:16]), (^internal_intr_message_24_parity_wdata[15:8]), (^internal_intr_message_24_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_24_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_24_parity_ena) internal_intr_message_24_parity_bit <= internal_intr_message_24_parity_update;
	    end
	end

	assign internal_intr_message_24_parity_check_bit = {(^internal_intr_message_24_parity_check_wdata[31:24]), (^internal_intr_message_24_parity_check_wdata[23:16]), (^internal_intr_message_24_parity_check_wdata[15:8]), (^internal_intr_message_24_parity_check_wdata[7:0])};

	assign internal_intr_message_24_parity_check_wdata = {internal_intr_message_24_internal_intr_message[31], internal_intr_message_24_internal_intr_message[30], internal_intr_message_24_internal_intr_message[29], internal_intr_message_24_internal_intr_message[28], internal_intr_message_24_internal_intr_message[27], internal_intr_message_24_internal_intr_message[26], internal_intr_message_24_internal_intr_message[25], internal_intr_message_24_internal_intr_message[24], internal_intr_message_24_internal_intr_message[23], internal_intr_message_24_internal_intr_message[22], internal_intr_message_24_internal_intr_message[21], internal_intr_message_24_internal_intr_message[20], internal_intr_message_24_internal_intr_message[19], internal_intr_message_24_internal_intr_message[18], internal_intr_message_24_internal_intr_message[17], internal_intr_message_24_internal_intr_message[16], internal_intr_message_24_internal_intr_message[15], internal_intr_message_24_internal_intr_message[14], internal_intr_message_24_internal_intr_message[13], internal_intr_message_24_internal_intr_message[12], internal_intr_message_24_internal_intr_message[11], internal_intr_message_24_internal_intr_message[10], internal_intr_message_24_internal_intr_message[9], internal_intr_message_24_internal_intr_message[8], internal_intr_message_24_internal_intr_message[7], internal_intr_message_24_internal_intr_message[6], internal_intr_message_24_internal_intr_message[5], internal_intr_message_24_internal_intr_message[4], internal_intr_message_24_internal_intr_message[3], internal_intr_message_24_internal_intr_message[2], internal_intr_message_24_internal_intr_message[1], internal_intr_message_24_internal_intr_message[0]};

	assign internal_intr_message_24_parity_check_err = (internal_intr_message_24_parity_check_bit != internal_intr_message_24_parity_bit);

	assign internal_intr_message_24_parity_hw_check_err = internal_intr_message_24_parity_check_err;

	assign internal_intr_message_25_rdat = {internal_intr_message_25_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_25_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_25_internal_intr_message_wena) internal_intr_message_25_internal_intr_message <= internal_intr_message_25_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_25_internal_intr_message_rdat = internal_intr_message_25_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_25_internal_intr_message_wena) internal_intr_message_25_internal_intr_message_parity = internal_intr_message_25_internal_intr_message_wdat;
	    else internal_intr_message_25_internal_intr_message_parity = internal_intr_message_25_internal_intr_message;
	end

	assign internal_intr_message_25_parity_ena = (internal_intr_message_25_internal_intr_message_wena);

	assign internal_intr_message_25_parity_wdata = {internal_intr_message_25_internal_intr_message_parity[31], internal_intr_message_25_internal_intr_message_parity[30], internal_intr_message_25_internal_intr_message_parity[29], internal_intr_message_25_internal_intr_message_parity[28], internal_intr_message_25_internal_intr_message_parity[27], internal_intr_message_25_internal_intr_message_parity[26], internal_intr_message_25_internal_intr_message_parity[25], internal_intr_message_25_internal_intr_message_parity[24], internal_intr_message_25_internal_intr_message_parity[23], internal_intr_message_25_internal_intr_message_parity[22], internal_intr_message_25_internal_intr_message_parity[21], internal_intr_message_25_internal_intr_message_parity[20], internal_intr_message_25_internal_intr_message_parity[19], internal_intr_message_25_internal_intr_message_parity[18], internal_intr_message_25_internal_intr_message_parity[17], internal_intr_message_25_internal_intr_message_parity[16], internal_intr_message_25_internal_intr_message_parity[15], internal_intr_message_25_internal_intr_message_parity[14], internal_intr_message_25_internal_intr_message_parity[13], internal_intr_message_25_internal_intr_message_parity[12], internal_intr_message_25_internal_intr_message_parity[11], internal_intr_message_25_internal_intr_message_parity[10], internal_intr_message_25_internal_intr_message_parity[9], internal_intr_message_25_internal_intr_message_parity[8], internal_intr_message_25_internal_intr_message_parity[7], internal_intr_message_25_internal_intr_message_parity[6], internal_intr_message_25_internal_intr_message_parity[5], internal_intr_message_25_internal_intr_message_parity[4], internal_intr_message_25_internal_intr_message_parity[3], internal_intr_message_25_internal_intr_message_parity[2], internal_intr_message_25_internal_intr_message_parity[1], internal_intr_message_25_internal_intr_message_parity[0]};

	assign internal_intr_message_25_parity_update = {(^internal_intr_message_25_parity_wdata[31:24]), (^internal_intr_message_25_parity_wdata[23:16]), (^internal_intr_message_25_parity_wdata[15:8]), (^internal_intr_message_25_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_25_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_25_parity_ena) internal_intr_message_25_parity_bit <= internal_intr_message_25_parity_update;
	    end
	end

	assign internal_intr_message_25_parity_check_bit = {(^internal_intr_message_25_parity_check_wdata[31:24]), (^internal_intr_message_25_parity_check_wdata[23:16]), (^internal_intr_message_25_parity_check_wdata[15:8]), (^internal_intr_message_25_parity_check_wdata[7:0])};

	assign internal_intr_message_25_parity_check_wdata = {internal_intr_message_25_internal_intr_message[31], internal_intr_message_25_internal_intr_message[30], internal_intr_message_25_internal_intr_message[29], internal_intr_message_25_internal_intr_message[28], internal_intr_message_25_internal_intr_message[27], internal_intr_message_25_internal_intr_message[26], internal_intr_message_25_internal_intr_message[25], internal_intr_message_25_internal_intr_message[24], internal_intr_message_25_internal_intr_message[23], internal_intr_message_25_internal_intr_message[22], internal_intr_message_25_internal_intr_message[21], internal_intr_message_25_internal_intr_message[20], internal_intr_message_25_internal_intr_message[19], internal_intr_message_25_internal_intr_message[18], internal_intr_message_25_internal_intr_message[17], internal_intr_message_25_internal_intr_message[16], internal_intr_message_25_internal_intr_message[15], internal_intr_message_25_internal_intr_message[14], internal_intr_message_25_internal_intr_message[13], internal_intr_message_25_internal_intr_message[12], internal_intr_message_25_internal_intr_message[11], internal_intr_message_25_internal_intr_message[10], internal_intr_message_25_internal_intr_message[9], internal_intr_message_25_internal_intr_message[8], internal_intr_message_25_internal_intr_message[7], internal_intr_message_25_internal_intr_message[6], internal_intr_message_25_internal_intr_message[5], internal_intr_message_25_internal_intr_message[4], internal_intr_message_25_internal_intr_message[3], internal_intr_message_25_internal_intr_message[2], internal_intr_message_25_internal_intr_message[1], internal_intr_message_25_internal_intr_message[0]};

	assign internal_intr_message_25_parity_check_err = (internal_intr_message_25_parity_check_bit != internal_intr_message_25_parity_bit);

	assign internal_intr_message_25_parity_hw_check_err = internal_intr_message_25_parity_check_err;

	assign internal_intr_message_26_rdat = {internal_intr_message_26_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_26_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_26_internal_intr_message_wena) internal_intr_message_26_internal_intr_message <= internal_intr_message_26_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_26_internal_intr_message_rdat = internal_intr_message_26_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_26_internal_intr_message_wena) internal_intr_message_26_internal_intr_message_parity = internal_intr_message_26_internal_intr_message_wdat;
	    else internal_intr_message_26_internal_intr_message_parity = internal_intr_message_26_internal_intr_message;
	end

	assign internal_intr_message_26_parity_ena = (internal_intr_message_26_internal_intr_message_wena);

	assign internal_intr_message_26_parity_wdata = {internal_intr_message_26_internal_intr_message_parity[31], internal_intr_message_26_internal_intr_message_parity[30], internal_intr_message_26_internal_intr_message_parity[29], internal_intr_message_26_internal_intr_message_parity[28], internal_intr_message_26_internal_intr_message_parity[27], internal_intr_message_26_internal_intr_message_parity[26], internal_intr_message_26_internal_intr_message_parity[25], internal_intr_message_26_internal_intr_message_parity[24], internal_intr_message_26_internal_intr_message_parity[23], internal_intr_message_26_internal_intr_message_parity[22], internal_intr_message_26_internal_intr_message_parity[21], internal_intr_message_26_internal_intr_message_parity[20], internal_intr_message_26_internal_intr_message_parity[19], internal_intr_message_26_internal_intr_message_parity[18], internal_intr_message_26_internal_intr_message_parity[17], internal_intr_message_26_internal_intr_message_parity[16], internal_intr_message_26_internal_intr_message_parity[15], internal_intr_message_26_internal_intr_message_parity[14], internal_intr_message_26_internal_intr_message_parity[13], internal_intr_message_26_internal_intr_message_parity[12], internal_intr_message_26_internal_intr_message_parity[11], internal_intr_message_26_internal_intr_message_parity[10], internal_intr_message_26_internal_intr_message_parity[9], internal_intr_message_26_internal_intr_message_parity[8], internal_intr_message_26_internal_intr_message_parity[7], internal_intr_message_26_internal_intr_message_parity[6], internal_intr_message_26_internal_intr_message_parity[5], internal_intr_message_26_internal_intr_message_parity[4], internal_intr_message_26_internal_intr_message_parity[3], internal_intr_message_26_internal_intr_message_parity[2], internal_intr_message_26_internal_intr_message_parity[1], internal_intr_message_26_internal_intr_message_parity[0]};

	assign internal_intr_message_26_parity_update = {(^internal_intr_message_26_parity_wdata[31:24]), (^internal_intr_message_26_parity_wdata[23:16]), (^internal_intr_message_26_parity_wdata[15:8]), (^internal_intr_message_26_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_26_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_26_parity_ena) internal_intr_message_26_parity_bit <= internal_intr_message_26_parity_update;
	    end
	end

	assign internal_intr_message_26_parity_check_bit = {(^internal_intr_message_26_parity_check_wdata[31:24]), (^internal_intr_message_26_parity_check_wdata[23:16]), (^internal_intr_message_26_parity_check_wdata[15:8]), (^internal_intr_message_26_parity_check_wdata[7:0])};

	assign internal_intr_message_26_parity_check_wdata = {internal_intr_message_26_internal_intr_message[31], internal_intr_message_26_internal_intr_message[30], internal_intr_message_26_internal_intr_message[29], internal_intr_message_26_internal_intr_message[28], internal_intr_message_26_internal_intr_message[27], internal_intr_message_26_internal_intr_message[26], internal_intr_message_26_internal_intr_message[25], internal_intr_message_26_internal_intr_message[24], internal_intr_message_26_internal_intr_message[23], internal_intr_message_26_internal_intr_message[22], internal_intr_message_26_internal_intr_message[21], internal_intr_message_26_internal_intr_message[20], internal_intr_message_26_internal_intr_message[19], internal_intr_message_26_internal_intr_message[18], internal_intr_message_26_internal_intr_message[17], internal_intr_message_26_internal_intr_message[16], internal_intr_message_26_internal_intr_message[15], internal_intr_message_26_internal_intr_message[14], internal_intr_message_26_internal_intr_message[13], internal_intr_message_26_internal_intr_message[12], internal_intr_message_26_internal_intr_message[11], internal_intr_message_26_internal_intr_message[10], internal_intr_message_26_internal_intr_message[9], internal_intr_message_26_internal_intr_message[8], internal_intr_message_26_internal_intr_message[7], internal_intr_message_26_internal_intr_message[6], internal_intr_message_26_internal_intr_message[5], internal_intr_message_26_internal_intr_message[4], internal_intr_message_26_internal_intr_message[3], internal_intr_message_26_internal_intr_message[2], internal_intr_message_26_internal_intr_message[1], internal_intr_message_26_internal_intr_message[0]};

	assign internal_intr_message_26_parity_check_err = (internal_intr_message_26_parity_check_bit != internal_intr_message_26_parity_bit);

	assign internal_intr_message_26_parity_hw_check_err = internal_intr_message_26_parity_check_err;

	assign internal_intr_message_27_rdat = {internal_intr_message_27_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_27_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_27_internal_intr_message_wena) internal_intr_message_27_internal_intr_message <= internal_intr_message_27_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_27_internal_intr_message_rdat = internal_intr_message_27_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_27_internal_intr_message_wena) internal_intr_message_27_internal_intr_message_parity = internal_intr_message_27_internal_intr_message_wdat;
	    else internal_intr_message_27_internal_intr_message_parity = internal_intr_message_27_internal_intr_message;
	end

	assign internal_intr_message_27_parity_ena = (internal_intr_message_27_internal_intr_message_wena);

	assign internal_intr_message_27_parity_wdata = {internal_intr_message_27_internal_intr_message_parity[31], internal_intr_message_27_internal_intr_message_parity[30], internal_intr_message_27_internal_intr_message_parity[29], internal_intr_message_27_internal_intr_message_parity[28], internal_intr_message_27_internal_intr_message_parity[27], internal_intr_message_27_internal_intr_message_parity[26], internal_intr_message_27_internal_intr_message_parity[25], internal_intr_message_27_internal_intr_message_parity[24], internal_intr_message_27_internal_intr_message_parity[23], internal_intr_message_27_internal_intr_message_parity[22], internal_intr_message_27_internal_intr_message_parity[21], internal_intr_message_27_internal_intr_message_parity[20], internal_intr_message_27_internal_intr_message_parity[19], internal_intr_message_27_internal_intr_message_parity[18], internal_intr_message_27_internal_intr_message_parity[17], internal_intr_message_27_internal_intr_message_parity[16], internal_intr_message_27_internal_intr_message_parity[15], internal_intr_message_27_internal_intr_message_parity[14], internal_intr_message_27_internal_intr_message_parity[13], internal_intr_message_27_internal_intr_message_parity[12], internal_intr_message_27_internal_intr_message_parity[11], internal_intr_message_27_internal_intr_message_parity[10], internal_intr_message_27_internal_intr_message_parity[9], internal_intr_message_27_internal_intr_message_parity[8], internal_intr_message_27_internal_intr_message_parity[7], internal_intr_message_27_internal_intr_message_parity[6], internal_intr_message_27_internal_intr_message_parity[5], internal_intr_message_27_internal_intr_message_parity[4], internal_intr_message_27_internal_intr_message_parity[3], internal_intr_message_27_internal_intr_message_parity[2], internal_intr_message_27_internal_intr_message_parity[1], internal_intr_message_27_internal_intr_message_parity[0]};

	assign internal_intr_message_27_parity_update = {(^internal_intr_message_27_parity_wdata[31:24]), (^internal_intr_message_27_parity_wdata[23:16]), (^internal_intr_message_27_parity_wdata[15:8]), (^internal_intr_message_27_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_27_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_27_parity_ena) internal_intr_message_27_parity_bit <= internal_intr_message_27_parity_update;
	    end
	end

	assign internal_intr_message_27_parity_check_bit = {(^internal_intr_message_27_parity_check_wdata[31:24]), (^internal_intr_message_27_parity_check_wdata[23:16]), (^internal_intr_message_27_parity_check_wdata[15:8]), (^internal_intr_message_27_parity_check_wdata[7:0])};

	assign internal_intr_message_27_parity_check_wdata = {internal_intr_message_27_internal_intr_message[31], internal_intr_message_27_internal_intr_message[30], internal_intr_message_27_internal_intr_message[29], internal_intr_message_27_internal_intr_message[28], internal_intr_message_27_internal_intr_message[27], internal_intr_message_27_internal_intr_message[26], internal_intr_message_27_internal_intr_message[25], internal_intr_message_27_internal_intr_message[24], internal_intr_message_27_internal_intr_message[23], internal_intr_message_27_internal_intr_message[22], internal_intr_message_27_internal_intr_message[21], internal_intr_message_27_internal_intr_message[20], internal_intr_message_27_internal_intr_message[19], internal_intr_message_27_internal_intr_message[18], internal_intr_message_27_internal_intr_message[17], internal_intr_message_27_internal_intr_message[16], internal_intr_message_27_internal_intr_message[15], internal_intr_message_27_internal_intr_message[14], internal_intr_message_27_internal_intr_message[13], internal_intr_message_27_internal_intr_message[12], internal_intr_message_27_internal_intr_message[11], internal_intr_message_27_internal_intr_message[10], internal_intr_message_27_internal_intr_message[9], internal_intr_message_27_internal_intr_message[8], internal_intr_message_27_internal_intr_message[7], internal_intr_message_27_internal_intr_message[6], internal_intr_message_27_internal_intr_message[5], internal_intr_message_27_internal_intr_message[4], internal_intr_message_27_internal_intr_message[3], internal_intr_message_27_internal_intr_message[2], internal_intr_message_27_internal_intr_message[1], internal_intr_message_27_internal_intr_message[0]};

	assign internal_intr_message_27_parity_check_err = (internal_intr_message_27_parity_check_bit != internal_intr_message_27_parity_bit);

	assign internal_intr_message_27_parity_hw_check_err = internal_intr_message_27_parity_check_err;

	assign internal_intr_message_28_rdat = {internal_intr_message_28_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_28_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_28_internal_intr_message_wena) internal_intr_message_28_internal_intr_message <= internal_intr_message_28_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_28_internal_intr_message_rdat = internal_intr_message_28_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_28_internal_intr_message_wena) internal_intr_message_28_internal_intr_message_parity = internal_intr_message_28_internal_intr_message_wdat;
	    else internal_intr_message_28_internal_intr_message_parity = internal_intr_message_28_internal_intr_message;
	end

	assign internal_intr_message_28_parity_ena = (internal_intr_message_28_internal_intr_message_wena);

	assign internal_intr_message_28_parity_wdata = {internal_intr_message_28_internal_intr_message_parity[31], internal_intr_message_28_internal_intr_message_parity[30], internal_intr_message_28_internal_intr_message_parity[29], internal_intr_message_28_internal_intr_message_parity[28], internal_intr_message_28_internal_intr_message_parity[27], internal_intr_message_28_internal_intr_message_parity[26], internal_intr_message_28_internal_intr_message_parity[25], internal_intr_message_28_internal_intr_message_parity[24], internal_intr_message_28_internal_intr_message_parity[23], internal_intr_message_28_internal_intr_message_parity[22], internal_intr_message_28_internal_intr_message_parity[21], internal_intr_message_28_internal_intr_message_parity[20], internal_intr_message_28_internal_intr_message_parity[19], internal_intr_message_28_internal_intr_message_parity[18], internal_intr_message_28_internal_intr_message_parity[17], internal_intr_message_28_internal_intr_message_parity[16], internal_intr_message_28_internal_intr_message_parity[15], internal_intr_message_28_internal_intr_message_parity[14], internal_intr_message_28_internal_intr_message_parity[13], internal_intr_message_28_internal_intr_message_parity[12], internal_intr_message_28_internal_intr_message_parity[11], internal_intr_message_28_internal_intr_message_parity[10], internal_intr_message_28_internal_intr_message_parity[9], internal_intr_message_28_internal_intr_message_parity[8], internal_intr_message_28_internal_intr_message_parity[7], internal_intr_message_28_internal_intr_message_parity[6], internal_intr_message_28_internal_intr_message_parity[5], internal_intr_message_28_internal_intr_message_parity[4], internal_intr_message_28_internal_intr_message_parity[3], internal_intr_message_28_internal_intr_message_parity[2], internal_intr_message_28_internal_intr_message_parity[1], internal_intr_message_28_internal_intr_message_parity[0]};

	assign internal_intr_message_28_parity_update = {(^internal_intr_message_28_parity_wdata[31:24]), (^internal_intr_message_28_parity_wdata[23:16]), (^internal_intr_message_28_parity_wdata[15:8]), (^internal_intr_message_28_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_28_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_28_parity_ena) internal_intr_message_28_parity_bit <= internal_intr_message_28_parity_update;
	    end
	end

	assign internal_intr_message_28_parity_check_bit = {(^internal_intr_message_28_parity_check_wdata[31:24]), (^internal_intr_message_28_parity_check_wdata[23:16]), (^internal_intr_message_28_parity_check_wdata[15:8]), (^internal_intr_message_28_parity_check_wdata[7:0])};

	assign internal_intr_message_28_parity_check_wdata = {internal_intr_message_28_internal_intr_message[31], internal_intr_message_28_internal_intr_message[30], internal_intr_message_28_internal_intr_message[29], internal_intr_message_28_internal_intr_message[28], internal_intr_message_28_internal_intr_message[27], internal_intr_message_28_internal_intr_message[26], internal_intr_message_28_internal_intr_message[25], internal_intr_message_28_internal_intr_message[24], internal_intr_message_28_internal_intr_message[23], internal_intr_message_28_internal_intr_message[22], internal_intr_message_28_internal_intr_message[21], internal_intr_message_28_internal_intr_message[20], internal_intr_message_28_internal_intr_message[19], internal_intr_message_28_internal_intr_message[18], internal_intr_message_28_internal_intr_message[17], internal_intr_message_28_internal_intr_message[16], internal_intr_message_28_internal_intr_message[15], internal_intr_message_28_internal_intr_message[14], internal_intr_message_28_internal_intr_message[13], internal_intr_message_28_internal_intr_message[12], internal_intr_message_28_internal_intr_message[11], internal_intr_message_28_internal_intr_message[10], internal_intr_message_28_internal_intr_message[9], internal_intr_message_28_internal_intr_message[8], internal_intr_message_28_internal_intr_message[7], internal_intr_message_28_internal_intr_message[6], internal_intr_message_28_internal_intr_message[5], internal_intr_message_28_internal_intr_message[4], internal_intr_message_28_internal_intr_message[3], internal_intr_message_28_internal_intr_message[2], internal_intr_message_28_internal_intr_message[1], internal_intr_message_28_internal_intr_message[0]};

	assign internal_intr_message_28_parity_check_err = (internal_intr_message_28_parity_check_bit != internal_intr_message_28_parity_bit);

	assign internal_intr_message_28_parity_hw_check_err = internal_intr_message_28_parity_check_err;

	assign internal_intr_message_29_rdat = {internal_intr_message_29_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_29_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_29_internal_intr_message_wena) internal_intr_message_29_internal_intr_message <= internal_intr_message_29_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_29_internal_intr_message_rdat = internal_intr_message_29_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_29_internal_intr_message_wena) internal_intr_message_29_internal_intr_message_parity = internal_intr_message_29_internal_intr_message_wdat;
	    else internal_intr_message_29_internal_intr_message_parity = internal_intr_message_29_internal_intr_message;
	end

	assign internal_intr_message_29_parity_ena = (internal_intr_message_29_internal_intr_message_wena);

	assign internal_intr_message_29_parity_wdata = {internal_intr_message_29_internal_intr_message_parity[31], internal_intr_message_29_internal_intr_message_parity[30], internal_intr_message_29_internal_intr_message_parity[29], internal_intr_message_29_internal_intr_message_parity[28], internal_intr_message_29_internal_intr_message_parity[27], internal_intr_message_29_internal_intr_message_parity[26], internal_intr_message_29_internal_intr_message_parity[25], internal_intr_message_29_internal_intr_message_parity[24], internal_intr_message_29_internal_intr_message_parity[23], internal_intr_message_29_internal_intr_message_parity[22], internal_intr_message_29_internal_intr_message_parity[21], internal_intr_message_29_internal_intr_message_parity[20], internal_intr_message_29_internal_intr_message_parity[19], internal_intr_message_29_internal_intr_message_parity[18], internal_intr_message_29_internal_intr_message_parity[17], internal_intr_message_29_internal_intr_message_parity[16], internal_intr_message_29_internal_intr_message_parity[15], internal_intr_message_29_internal_intr_message_parity[14], internal_intr_message_29_internal_intr_message_parity[13], internal_intr_message_29_internal_intr_message_parity[12], internal_intr_message_29_internal_intr_message_parity[11], internal_intr_message_29_internal_intr_message_parity[10], internal_intr_message_29_internal_intr_message_parity[9], internal_intr_message_29_internal_intr_message_parity[8], internal_intr_message_29_internal_intr_message_parity[7], internal_intr_message_29_internal_intr_message_parity[6], internal_intr_message_29_internal_intr_message_parity[5], internal_intr_message_29_internal_intr_message_parity[4], internal_intr_message_29_internal_intr_message_parity[3], internal_intr_message_29_internal_intr_message_parity[2], internal_intr_message_29_internal_intr_message_parity[1], internal_intr_message_29_internal_intr_message_parity[0]};

	assign internal_intr_message_29_parity_update = {(^internal_intr_message_29_parity_wdata[31:24]), (^internal_intr_message_29_parity_wdata[23:16]), (^internal_intr_message_29_parity_wdata[15:8]), (^internal_intr_message_29_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_29_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_29_parity_ena) internal_intr_message_29_parity_bit <= internal_intr_message_29_parity_update;
	    end
	end

	assign internal_intr_message_29_parity_check_bit = {(^internal_intr_message_29_parity_check_wdata[31:24]), (^internal_intr_message_29_parity_check_wdata[23:16]), (^internal_intr_message_29_parity_check_wdata[15:8]), (^internal_intr_message_29_parity_check_wdata[7:0])};

	assign internal_intr_message_29_parity_check_wdata = {internal_intr_message_29_internal_intr_message[31], internal_intr_message_29_internal_intr_message[30], internal_intr_message_29_internal_intr_message[29], internal_intr_message_29_internal_intr_message[28], internal_intr_message_29_internal_intr_message[27], internal_intr_message_29_internal_intr_message[26], internal_intr_message_29_internal_intr_message[25], internal_intr_message_29_internal_intr_message[24], internal_intr_message_29_internal_intr_message[23], internal_intr_message_29_internal_intr_message[22], internal_intr_message_29_internal_intr_message[21], internal_intr_message_29_internal_intr_message[20], internal_intr_message_29_internal_intr_message[19], internal_intr_message_29_internal_intr_message[18], internal_intr_message_29_internal_intr_message[17], internal_intr_message_29_internal_intr_message[16], internal_intr_message_29_internal_intr_message[15], internal_intr_message_29_internal_intr_message[14], internal_intr_message_29_internal_intr_message[13], internal_intr_message_29_internal_intr_message[12], internal_intr_message_29_internal_intr_message[11], internal_intr_message_29_internal_intr_message[10], internal_intr_message_29_internal_intr_message[9], internal_intr_message_29_internal_intr_message[8], internal_intr_message_29_internal_intr_message[7], internal_intr_message_29_internal_intr_message[6], internal_intr_message_29_internal_intr_message[5], internal_intr_message_29_internal_intr_message[4], internal_intr_message_29_internal_intr_message[3], internal_intr_message_29_internal_intr_message[2], internal_intr_message_29_internal_intr_message[1], internal_intr_message_29_internal_intr_message[0]};

	assign internal_intr_message_29_parity_check_err = (internal_intr_message_29_parity_check_bit != internal_intr_message_29_parity_bit);

	assign internal_intr_message_29_parity_hw_check_err = internal_intr_message_29_parity_check_err;

	assign internal_intr_message_30_rdat = {internal_intr_message_30_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_30_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_30_internal_intr_message_wena) internal_intr_message_30_internal_intr_message <= internal_intr_message_30_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_30_internal_intr_message_rdat = internal_intr_message_30_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_30_internal_intr_message_wena) internal_intr_message_30_internal_intr_message_parity = internal_intr_message_30_internal_intr_message_wdat;
	    else internal_intr_message_30_internal_intr_message_parity = internal_intr_message_30_internal_intr_message;
	end

	assign internal_intr_message_30_parity_ena = (internal_intr_message_30_internal_intr_message_wena);

	assign internal_intr_message_30_parity_wdata = {internal_intr_message_30_internal_intr_message_parity[31], internal_intr_message_30_internal_intr_message_parity[30], internal_intr_message_30_internal_intr_message_parity[29], internal_intr_message_30_internal_intr_message_parity[28], internal_intr_message_30_internal_intr_message_parity[27], internal_intr_message_30_internal_intr_message_parity[26], internal_intr_message_30_internal_intr_message_parity[25], internal_intr_message_30_internal_intr_message_parity[24], internal_intr_message_30_internal_intr_message_parity[23], internal_intr_message_30_internal_intr_message_parity[22], internal_intr_message_30_internal_intr_message_parity[21], internal_intr_message_30_internal_intr_message_parity[20], internal_intr_message_30_internal_intr_message_parity[19], internal_intr_message_30_internal_intr_message_parity[18], internal_intr_message_30_internal_intr_message_parity[17], internal_intr_message_30_internal_intr_message_parity[16], internal_intr_message_30_internal_intr_message_parity[15], internal_intr_message_30_internal_intr_message_parity[14], internal_intr_message_30_internal_intr_message_parity[13], internal_intr_message_30_internal_intr_message_parity[12], internal_intr_message_30_internal_intr_message_parity[11], internal_intr_message_30_internal_intr_message_parity[10], internal_intr_message_30_internal_intr_message_parity[9], internal_intr_message_30_internal_intr_message_parity[8], internal_intr_message_30_internal_intr_message_parity[7], internal_intr_message_30_internal_intr_message_parity[6], internal_intr_message_30_internal_intr_message_parity[5], internal_intr_message_30_internal_intr_message_parity[4], internal_intr_message_30_internal_intr_message_parity[3], internal_intr_message_30_internal_intr_message_parity[2], internal_intr_message_30_internal_intr_message_parity[1], internal_intr_message_30_internal_intr_message_parity[0]};

	assign internal_intr_message_30_parity_update = {(^internal_intr_message_30_parity_wdata[31:24]), (^internal_intr_message_30_parity_wdata[23:16]), (^internal_intr_message_30_parity_wdata[15:8]), (^internal_intr_message_30_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_30_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_30_parity_ena) internal_intr_message_30_parity_bit <= internal_intr_message_30_parity_update;
	    end
	end

	assign internal_intr_message_30_parity_check_bit = {(^internal_intr_message_30_parity_check_wdata[31:24]), (^internal_intr_message_30_parity_check_wdata[23:16]), (^internal_intr_message_30_parity_check_wdata[15:8]), (^internal_intr_message_30_parity_check_wdata[7:0])};

	assign internal_intr_message_30_parity_check_wdata = {internal_intr_message_30_internal_intr_message[31], internal_intr_message_30_internal_intr_message[30], internal_intr_message_30_internal_intr_message[29], internal_intr_message_30_internal_intr_message[28], internal_intr_message_30_internal_intr_message[27], internal_intr_message_30_internal_intr_message[26], internal_intr_message_30_internal_intr_message[25], internal_intr_message_30_internal_intr_message[24], internal_intr_message_30_internal_intr_message[23], internal_intr_message_30_internal_intr_message[22], internal_intr_message_30_internal_intr_message[21], internal_intr_message_30_internal_intr_message[20], internal_intr_message_30_internal_intr_message[19], internal_intr_message_30_internal_intr_message[18], internal_intr_message_30_internal_intr_message[17], internal_intr_message_30_internal_intr_message[16], internal_intr_message_30_internal_intr_message[15], internal_intr_message_30_internal_intr_message[14], internal_intr_message_30_internal_intr_message[13], internal_intr_message_30_internal_intr_message[12], internal_intr_message_30_internal_intr_message[11], internal_intr_message_30_internal_intr_message[10], internal_intr_message_30_internal_intr_message[9], internal_intr_message_30_internal_intr_message[8], internal_intr_message_30_internal_intr_message[7], internal_intr_message_30_internal_intr_message[6], internal_intr_message_30_internal_intr_message[5], internal_intr_message_30_internal_intr_message[4], internal_intr_message_30_internal_intr_message[3], internal_intr_message_30_internal_intr_message[2], internal_intr_message_30_internal_intr_message[1], internal_intr_message_30_internal_intr_message[0]};

	assign internal_intr_message_30_parity_check_err = (internal_intr_message_30_parity_check_bit != internal_intr_message_30_parity_bit);

	assign internal_intr_message_30_parity_hw_check_err = internal_intr_message_30_parity_check_err;

	assign internal_intr_message_31_rdat = {internal_intr_message_31_internal_intr_message};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_31_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_31_internal_intr_message_wena) internal_intr_message_31_internal_intr_message <= internal_intr_message_31_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_31_internal_intr_message_rdat = internal_intr_message_31_internal_intr_message;

	always @(*) begin
	    if(internal_intr_message_31_internal_intr_message_wena) internal_intr_message_31_internal_intr_message_parity = internal_intr_message_31_internal_intr_message_wdat;
	    else internal_intr_message_31_internal_intr_message_parity = internal_intr_message_31_internal_intr_message;
	end

	assign internal_intr_message_31_parity_ena = (internal_intr_message_31_internal_intr_message_wena);

	assign internal_intr_message_31_parity_wdata = {internal_intr_message_31_internal_intr_message_parity[31], internal_intr_message_31_internal_intr_message_parity[30], internal_intr_message_31_internal_intr_message_parity[29], internal_intr_message_31_internal_intr_message_parity[28], internal_intr_message_31_internal_intr_message_parity[27], internal_intr_message_31_internal_intr_message_parity[26], internal_intr_message_31_internal_intr_message_parity[25], internal_intr_message_31_internal_intr_message_parity[24], internal_intr_message_31_internal_intr_message_parity[23], internal_intr_message_31_internal_intr_message_parity[22], internal_intr_message_31_internal_intr_message_parity[21], internal_intr_message_31_internal_intr_message_parity[20], internal_intr_message_31_internal_intr_message_parity[19], internal_intr_message_31_internal_intr_message_parity[18], internal_intr_message_31_internal_intr_message_parity[17], internal_intr_message_31_internal_intr_message_parity[16], internal_intr_message_31_internal_intr_message_parity[15], internal_intr_message_31_internal_intr_message_parity[14], internal_intr_message_31_internal_intr_message_parity[13], internal_intr_message_31_internal_intr_message_parity[12], internal_intr_message_31_internal_intr_message_parity[11], internal_intr_message_31_internal_intr_message_parity[10], internal_intr_message_31_internal_intr_message_parity[9], internal_intr_message_31_internal_intr_message_parity[8], internal_intr_message_31_internal_intr_message_parity[7], internal_intr_message_31_internal_intr_message_parity[6], internal_intr_message_31_internal_intr_message_parity[5], internal_intr_message_31_internal_intr_message_parity[4], internal_intr_message_31_internal_intr_message_parity[3], internal_intr_message_31_internal_intr_message_parity[2], internal_intr_message_31_internal_intr_message_parity[1], internal_intr_message_31_internal_intr_message_parity[0]};

	assign internal_intr_message_31_parity_update = {(^internal_intr_message_31_parity_wdata[31:24]), (^internal_intr_message_31_parity_wdata[23:16]), (^internal_intr_message_31_parity_wdata[15:8]), (^internal_intr_message_31_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_31_parity_bit <= 4'b0;
	    else begin
	        if(internal_intr_message_31_parity_ena) internal_intr_message_31_parity_bit <= internal_intr_message_31_parity_update;
	    end
	end

	assign internal_intr_message_31_parity_check_bit = {(^internal_intr_message_31_parity_check_wdata[31:24]), (^internal_intr_message_31_parity_check_wdata[23:16]), (^internal_intr_message_31_parity_check_wdata[15:8]), (^internal_intr_message_31_parity_check_wdata[7:0])};

	assign internal_intr_message_31_parity_check_wdata = {internal_intr_message_31_internal_intr_message[31], internal_intr_message_31_internal_intr_message[30], internal_intr_message_31_internal_intr_message[29], internal_intr_message_31_internal_intr_message[28], internal_intr_message_31_internal_intr_message[27], internal_intr_message_31_internal_intr_message[26], internal_intr_message_31_internal_intr_message[25], internal_intr_message_31_internal_intr_message[24], internal_intr_message_31_internal_intr_message[23], internal_intr_message_31_internal_intr_message[22], internal_intr_message_31_internal_intr_message[21], internal_intr_message_31_internal_intr_message[20], internal_intr_message_31_internal_intr_message[19], internal_intr_message_31_internal_intr_message[18], internal_intr_message_31_internal_intr_message[17], internal_intr_message_31_internal_intr_message[16], internal_intr_message_31_internal_intr_message[15], internal_intr_message_31_internal_intr_message[14], internal_intr_message_31_internal_intr_message[13], internal_intr_message_31_internal_intr_message[12], internal_intr_message_31_internal_intr_message[11], internal_intr_message_31_internal_intr_message[10], internal_intr_message_31_internal_intr_message[9], internal_intr_message_31_internal_intr_message[8], internal_intr_message_31_internal_intr_message[7], internal_intr_message_31_internal_intr_message[6], internal_intr_message_31_internal_intr_message[5], internal_intr_message_31_internal_intr_message[4], internal_intr_message_31_internal_intr_message[3], internal_intr_message_31_internal_intr_message[2], internal_intr_message_31_internal_intr_message[1], internal_intr_message_31_internal_intr_message[0]};

	assign internal_intr_message_31_parity_check_err = (internal_intr_message_31_parity_check_bit != internal_intr_message_31_parity_bit);

	assign internal_intr_message_31_parity_hw_check_err = internal_intr_message_31_parity_check_err;


	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:22d6e018a1e108e9420d0c5404509362]

//[UHDL]Content Start [md5:0ad72a4ffa860a31d542662dd5e34a46]
module soc_dti_harden_up
	(
	input                                                 clk_noc_up                                                           ,
	input                                                 rst_noc_up_n                                                         ,
	output                                                link_req_tniu_req_last                                               ,
	output [89:0]                                         link_req_tniu_req_payload                                            ,
	output                                                link_req_tniu_req_qos                                                ,
	input                                                 link_req_tniu_req_ready                                              ,
	output [5:0]                                          link_req_tniu_req_srcid                                              ,
	output [5:0]                                          link_req_tniu_req_tgtid                                              ,
	input                                                 link_req_tniu_req_threshold                                          ,
	output                                                link_req_tniu_req_valid                                              ,
	input                                                 link_rsp_tniu_rsp_last                                               ,
	input  [89:0]                                         link_rsp_tniu_rsp_payload                                            ,
	input                                                 link_rsp_tniu_rsp_qos                                                ,
	output                                                link_rsp_tniu_rsp_ready                                              ,
	input  [5:0]                                          link_rsp_tniu_rsp_srcid                                              ,
	input  [5:0]                                          link_rsp_tniu_rsp_tgtid                                              ,
	output                                                link_rsp_tniu_rsp_threshold                                          ,
	input                                                 link_rsp_tniu_rsp_valid                                              ,
	input  [104:0]                                        gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync     ,
	output [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async   ,
	output [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync    ,
	input  [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async   ,
	output [104:0]                                        gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync     ,
	input  [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async   ,
	input  [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync    ,
	output [15:0]                                         gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async   ,
	output logic [9-1:0] gpu_ss0_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req      ,
	input logic [9-1:0] gpu_ss0_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req      ,
	input  [104:0]                                        gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync     ,
	output [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async   ,
	output [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync    ,
	input  [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async   ,
	output [104:0]                                        gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync     ,
	input  [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async   ,
	input  [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync    ,
	output [15:0]                                         gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async   ,
	output logic [9-1:0] gpu_ss1_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req      ,
	input logic [9-1:0] gpu_ss1_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req      ,
	input  [104:0]                                        dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync       ,
	output [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async     ,
	output [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync      ,
	input  [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async     ,
	output [104:0]                                        dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync       ,
	input  [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async     ,
	input  [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync      ,
	output [15:0]                                         dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async     ,
	output logic [9-1:0] dp_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req        ,
	input logic [9-1:0] dp_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req        ,
	input  [104:0]                                        display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync  ,
	output [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async,
	output [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync ,
	input  [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async,
	output [104:0]                                        display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync  ,
	input  [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async,
	input  [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync ,
	output [15:0]                                         display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async,
	output logic [9-1:0] display_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req   ,
	input logic [9-1:0] display_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req   );

	//Wire define for this module.

	//Wire define for sub module.
	wire        gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid       ;
	wire [89:0] gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload     ;
	wire [5:0]  gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid       ;
	wire [5:0]  gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid       ;
	wire        gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos         ;
	wire        gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last        ;
	wire        gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready       ;
	wire        gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold   ;
	wire        gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid       ;
	wire [89:0] gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload     ;
	wire [5:0]  gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid       ;
	wire [5:0]  gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid       ;
	wire        gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos         ;
	wire        gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last        ;
	wire        gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready       ;
	wire        gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold   ;
	wire        dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid         ;
	wire [89:0] dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload       ;
	wire [5:0]  dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid         ;
	wire [5:0]  dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid         ;
	wire        dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos           ;
	wire        dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last          ;
	wire        dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready         ;
	wire        dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold     ;
	wire        display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid    ;
	wire [89:0] display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload  ;
	wire [5:0]  display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid    ;
	wire [5:0]  display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid    ;
	wire        display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos      ;
	wire        display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last     ;
	wire        display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready    ;
	wire        display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold;
	wire        sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_ready         ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_threshold     ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_last          ;
	wire [89:0] sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload       ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos           ;
	wire [5:0]  sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid         ;
	wire [5:0]  sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid         ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid         ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_ready         ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_threshold     ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_last          ;
	wire [89:0] sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload       ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos           ;
	wire [5:0]  sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid         ;
	wire [5:0]  sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid         ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid         ;
	wire        sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_ready           ;
	wire        sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_threshold       ;
	wire        sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_last            ;
	wire [89:0] sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_payload         ;
	wire        sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_qos             ;
	wire [5:0]  sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid           ;
	wire [5:0]  sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid           ;
	wire        sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_valid           ;
	wire        sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_ready      ;
	wire        sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_threshold  ;
	wire        sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_last       ;
	wire [89:0] sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_payload    ;
	wire        sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_qos        ;
	wire [5:0]  sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid      ;
	wire [5:0]  sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid      ;
	wire        sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_valid      ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	soc_dti_sw_gpu4_dti_switch_4i1o_wrap sw_gpu4 (
		.clk(clk_noc_up),
		.rst_n(rst_noc_up_n),
		.iniu0_req_valid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.iniu0_req_ready(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_ready),
		.iniu0_req_payload(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.iniu0_req_srcid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.iniu0_req_qos(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.iniu0_req_last(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.iniu0_req_threshold(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.iniu1_req_valid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_ready),
		.iniu1_req_payload(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.iniu1_req_srcid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.iniu1_req_qos(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.iniu1_req_last(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.iniu1_req_threshold(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.iniu2_req_valid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.iniu2_req_ready(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_ready),
		.iniu2_req_payload(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.iniu2_req_srcid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.iniu2_req_qos(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.iniu2_req_last(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.iniu2_req_threshold(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.iniu3_req_valid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.iniu3_req_ready(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_ready),
		.iniu3_req_payload(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.iniu3_req_srcid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.iniu3_req_qos(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.iniu3_req_last(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.iniu3_req_threshold(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.tniu_req_valid(link_req_tniu_req_valid),
		.tniu_req_ready(link_req_tniu_req_ready),
		.tniu_req_payload(link_req_tniu_req_payload),
		.tniu_req_srcid(link_req_tniu_req_srcid),
		.tniu_req_tgtid(link_req_tniu_req_tgtid),
		.tniu_req_qos(link_req_tniu_req_qos),
		.tniu_req_last(link_req_tniu_req_last),
		.tniu_req_threshold(link_req_tniu_req_threshold),
		.tniu_rsp_valid(link_rsp_tniu_rsp_valid),
		.tniu_rsp_ready(link_rsp_tniu_rsp_ready),
		.tniu_rsp_payload(link_rsp_tniu_rsp_payload),
		.tniu_rsp_srcid(link_rsp_tniu_rsp_srcid),
		.tniu_rsp_tgtid(link_rsp_tniu_rsp_tgtid),
		.tniu_rsp_qos(link_rsp_tniu_rsp_qos),
		.tniu_rsp_last(link_rsp_tniu_rsp_last),
		.tniu_rsp_threshold(link_rsp_tniu_rsp_threshold));
	gpu_ss0_iniu_top_wrap gpu_ss0_iniu_top_wrap (
		.clk_top(clk_noc_up),
		.rst_top_n(rst_noc_up_n),
		.async_fifo_req_pld_sync(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu_ss0_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu_ss0_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.top_req_req_payload(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.top_req_req_qos(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.top_req_req_ready(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.top_req_req_tgtid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(gpu_ss0_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_gpu4_TO_gpu_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid));
	gpu_ss1_iniu_top_wrap gpu_ss1_iniu_top_wrap (
		.clk_top(clk_noc_up),
		.rst_top_n(rst_noc_up_n),
		.async_fifo_req_pld_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu_ss1_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu_ss1_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.top_req_req_payload(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.top_req_req_qos(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.top_req_req_ready(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.top_req_req_tgtid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(gpu_ss1_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_gpu4_TO_gpu_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid));
	dp_ss_iniu_top_wrap dp_ss_iniu_top_wrap (
		.clk_top(clk_noc_up),
		.rst_top_n(rst_noc_up_n),
		.async_fifo_req_pld_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dp_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dp_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.top_req_req_payload(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.top_req_req_qos(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.top_req_req_ready(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(dp_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_gpu4_TO_dp_ss_iniu_top_wrap_SIG_iniu2_rsp_valid));
	display_ss_iniu_top_wrap display_ss_iniu_top_wrap (
		.clk_top(clk_noc_up),
		.rst_top_n(rst_noc_up_n),
		.async_fifo_req_pld_sync(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(display_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(display_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(display_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_last),
		.top_req_req_payload(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_payload),
		.top_req_req_qos(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_qos),
		.top_req_req_ready(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_srcid),
		.top_req_req_tgtid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(display_ss_iniu_top_wrap_TO_sw_gpu4_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_gpu4_TO_display_ss_iniu_top_wrap_SIG_iniu3_rsp_valid));

endmodule
//[UHDL]Content End [md5:0ad72a4ffa860a31d542662dd5e34a46]


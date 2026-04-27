//[UHDL]Content Start [md5:616d136f484deb4284aabdca7c87f7b7]
module dti_harden_up
	import lwnoc_lp_struct_package::*;
	(
	input                                                 clk_up_func                                                       ,
	input                                                 rst_up_func_n                                                     ,
	input  [104:0]                                        dti_req_rsp_async_bridge_mst_sync_porting_pld_sync                ,
	output [15:0]                                         dti_req_rsp_async_bridge_mst_sync_porting_rptr_async              ,
	output [15:0]                                         dti_req_rsp_async_bridge_mst_sync_porting_rptr_sync               ,
	input  [15:0]                                         dti_req_rsp_async_bridge_mst_sync_porting_wptr_async              ,
	input                                                 sw3_iniu0_req_porting_iniu0_req_last                              ,
	input  [89:0]                                         sw3_iniu0_req_porting_iniu0_req_payload                           ,
	input                                                 sw3_iniu0_req_porting_iniu0_req_qos                               ,
	output                                                sw3_iniu0_req_porting_iniu0_req_ready                             ,
	input  [5:0]                                          sw3_iniu0_req_porting_iniu0_req_srcid                             ,
	input  [5:0]                                          sw3_iniu0_req_porting_iniu0_req_tgtid                             ,
	output                                                sw3_iniu0_req_porting_iniu0_req_threshold                         ,
	input                                                 sw3_iniu0_req_porting_iniu0_req_valid                             ,
	output                                                sw3_iniu0_rsp_porting_iniu0_rsp_last                              ,
	output [89:0]                                         sw3_iniu0_rsp_porting_iniu0_rsp_payload                           ,
	output                                                sw3_iniu0_rsp_porting_iniu0_rsp_qos                               ,
	input                                                 sw3_iniu0_rsp_porting_iniu0_rsp_ready                             ,
	output [5:0]                                          sw3_iniu0_rsp_porting_iniu0_rsp_srcid                             ,
	output [5:0]                                          sw3_iniu0_rsp_porting_iniu0_rsp_tgtid                             ,
	input                                                 sw3_iniu0_rsp_porting_iniu0_rsp_threshold                         ,
	output                                                sw3_iniu0_rsp_porting_iniu0_rsp_valid                             ,
	input                                                 sw3_iniu1_req_porting_iniu1_req_last                              ,
	input  [89:0]                                         sw3_iniu1_req_porting_iniu1_req_payload                           ,
	input                                                 sw3_iniu1_req_porting_iniu1_req_qos                               ,
	output                                                sw3_iniu1_req_porting_iniu1_req_ready                             ,
	input  [5:0]                                          sw3_iniu1_req_porting_iniu1_req_srcid                             ,
	input  [5:0]                                          sw3_iniu1_req_porting_iniu1_req_tgtid                             ,
	output                                                sw3_iniu1_req_porting_iniu1_req_threshold                         ,
	input                                                 sw3_iniu1_req_porting_iniu1_req_valid                             ,
	output                                                sw3_iniu1_rsp_porting_iniu1_rsp_last                              ,
	output [89:0]                                         sw3_iniu1_rsp_porting_iniu1_rsp_payload                           ,
	output                                                sw3_iniu1_rsp_porting_iniu1_rsp_qos                               ,
	input                                                 sw3_iniu1_rsp_porting_iniu1_rsp_ready                             ,
	output [5:0]                                          sw3_iniu1_rsp_porting_iniu1_rsp_srcid                             ,
	output [5:0]                                          sw3_iniu1_rsp_porting_iniu1_rsp_tgtid                             ,
	input                                                 sw3_iniu1_rsp_porting_iniu1_rsp_threshold                         ,
	output                                                sw3_iniu1_rsp_porting_iniu1_rsp_valid                             ,
	output                                                sw3_iniu2_rsp_porting_iniu2_rsp_last                              ,
	output [89:0]                                         sw3_iniu2_rsp_porting_iniu2_rsp_payload                           ,
	output                                                sw3_iniu2_rsp_porting_iniu2_rsp_qos                               ,
	input                                                 sw3_iniu2_rsp_porting_iniu2_rsp_ready                             ,
	output [5:0]                                          sw3_iniu2_rsp_porting_iniu2_rsp_srcid                             ,
	output [5:0]                                          sw3_iniu2_rsp_porting_iniu2_rsp_tgtid                             ,
	input                                                 sw3_iniu2_rsp_porting_iniu2_rsp_threshold                         ,
	output                                                sw3_iniu2_rsp_porting_iniu2_rsp_valid                             ,
	output [104:0]                                        sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync  ,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync ,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async,
	input  [104:0]                                        sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync  ,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync ,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t sys_tcu_tniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req   ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t sys_tcu_tniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req   );

	//Wire define for this module.

	//Wire define for sub module.
	wire        sw3_TO_async_bridge_mst_SIG_iniu2_req_ready            ;
	wire        sw3_TO_async_bridge_mst_SIG_iniu2_req_threshold        ;
	wire        async_bridge_mst_TO_sw3_SIG_m_valid                    ;
	wire [89:0] async_bridge_mst_TO_sw3_SIG_m_payload                  ;
	wire        async_bridge_mst_TO_sw3_SIG_m_last                     ;
	wire [5:0]  async_bridge_mst_TO_sw3_SIG_m_srcid                    ;
	wire [5:0]  async_bridge_mst_TO_sw3_SIG_m_tgtid                    ;
	wire        async_bridge_mst_TO_sw3_SIG_m_qos                      ;
	wire        tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_ready    ;
	wire        tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_threshold;
	wire        tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_valid         ;
	wire [89:0] tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_payload       ;
	wire [5:0]  tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_srcid         ;
	wire [5:0]  tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_tgtid         ;
	wire        tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_qos           ;
	wire        tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_last          ;
	wire        sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_last             ;
	wire [89:0] sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_payload          ;
	wire        sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_qos              ;
	wire [5:0]  sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_srcid            ;
	wire [5:0]  sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_tgtid            ;
	wire        sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_valid            ;
	wire        sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_ready            ;
	wire        sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold        ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_async_bridge_mst async_bridge_mst (
		.clk(clk_up_func),
		.rst_n(rst_up_func_n),
		.stall(),
		.clear(),
		.full_zero(),
		.idle(),
		.m_valid(async_bridge_mst_TO_sw3_SIG_m_valid),
		.m_payload(async_bridge_mst_TO_sw3_SIG_m_payload),
		.m_last(async_bridge_mst_TO_sw3_SIG_m_last),
		.m_srcid(async_bridge_mst_TO_sw3_SIG_m_srcid),
		.m_tgtid(async_bridge_mst_TO_sw3_SIG_m_tgtid),
		.m_qos(async_bridge_mst_TO_sw3_SIG_m_qos),
		.m_ready(sw3_TO_async_bridge_mst_SIG_iniu2_req_ready),
		.m_threshold(sw3_TO_async_bridge_mst_SIG_iniu2_req_threshold),
		.almost_empty(),
		.wptr_async(dti_req_rsp_async_bridge_mst_sync_porting_wptr_async),
		.rptr_async(dti_req_rsp_async_bridge_mst_sync_porting_rptr_async),
		.rptr_sync(dti_req_rsp_async_bridge_mst_sync_porting_rptr_sync),
		.pld_sync(dti_req_rsp_async_bridge_mst_sync_porting_pld_sync));
	dti_sw3_dti_noc_switch_3to1_wrap sw3 (
		.clk(clk_up_func),
		.rst_n(rst_up_func_n),
		.iniu0_req_valid(sw3_iniu0_req_porting_iniu0_req_valid),
		.iniu0_req_payload(sw3_iniu0_req_porting_iniu0_req_payload),
		.iniu0_req_last(sw3_iniu0_req_porting_iniu0_req_last),
		.iniu0_req_srcid(sw3_iniu0_req_porting_iniu0_req_srcid),
		.iniu0_req_tgtid(sw3_iniu0_req_porting_iniu0_req_tgtid),
		.iniu0_req_qos(sw3_iniu0_req_porting_iniu0_req_qos),
		.iniu0_req_threshold(sw3_iniu0_req_porting_iniu0_req_threshold),
		.iniu0_req_ready(sw3_iniu0_req_porting_iniu0_req_ready),
		.iniu1_req_valid(sw3_iniu1_req_porting_iniu1_req_valid),
		.iniu1_req_payload(sw3_iniu1_req_porting_iniu1_req_payload),
		.iniu1_req_last(sw3_iniu1_req_porting_iniu1_req_last),
		.iniu1_req_srcid(sw3_iniu1_req_porting_iniu1_req_srcid),
		.iniu1_req_tgtid(sw3_iniu1_req_porting_iniu1_req_tgtid),
		.iniu1_req_qos(sw3_iniu1_req_porting_iniu1_req_qos),
		.iniu1_req_threshold(sw3_iniu1_req_porting_iniu1_req_threshold),
		.iniu1_req_ready(sw3_iniu1_req_porting_iniu1_req_ready),
		.iniu2_req_valid(async_bridge_mst_TO_sw3_SIG_m_valid),
		.iniu2_req_payload(async_bridge_mst_TO_sw3_SIG_m_payload),
		.iniu2_req_last(async_bridge_mst_TO_sw3_SIG_m_last),
		.iniu2_req_srcid(async_bridge_mst_TO_sw3_SIG_m_srcid),
		.iniu2_req_tgtid(async_bridge_mst_TO_sw3_SIG_m_tgtid),
		.iniu2_req_qos(async_bridge_mst_TO_sw3_SIG_m_qos),
		.iniu2_req_threshold(sw3_TO_async_bridge_mst_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw3_TO_async_bridge_mst_SIG_iniu2_req_ready),
		.iniu0_rsp_valid(sw3_iniu0_rsp_porting_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw3_iniu0_rsp_porting_iniu0_rsp_payload),
		.iniu0_rsp_last(sw3_iniu0_rsp_porting_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw3_iniu0_rsp_porting_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw3_iniu0_rsp_porting_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw3_iniu0_rsp_porting_iniu0_rsp_qos),
		.iniu0_rsp_threshold(sw3_iniu0_rsp_porting_iniu0_rsp_threshold),
		.iniu0_rsp_ready(sw3_iniu0_rsp_porting_iniu0_rsp_ready),
		.iniu1_rsp_valid(sw3_iniu1_rsp_porting_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw3_iniu1_rsp_porting_iniu1_rsp_payload),
		.iniu1_rsp_last(sw3_iniu1_rsp_porting_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw3_iniu1_rsp_porting_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw3_iniu1_rsp_porting_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw3_iniu1_rsp_porting_iniu1_rsp_qos),
		.iniu1_rsp_threshold(sw3_iniu1_rsp_porting_iniu1_rsp_threshold),
		.iniu1_rsp_ready(sw3_iniu1_rsp_porting_iniu1_rsp_ready),
		.iniu2_rsp_valid(sw3_iniu2_rsp_porting_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw3_iniu2_rsp_porting_iniu2_rsp_payload),
		.iniu2_rsp_last(sw3_iniu2_rsp_porting_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw3_iniu2_rsp_porting_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw3_iniu2_rsp_porting_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw3_iniu2_rsp_porting_iniu2_rsp_qos),
		.iniu2_rsp_threshold(sw3_iniu2_rsp_porting_iniu2_rsp_threshold),
		.iniu2_rsp_ready(sw3_iniu2_rsp_porting_iniu2_rsp_ready),
		.tniu_req_valid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_valid),
		.tniu_req_ready(tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_ready),
		.tniu_req_payload(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_payload),
		.tniu_req_srcid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_qos),
		.tniu_req_last(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_last),
		.tniu_req_threshold(tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_threshold),
		.tniu_rsp_valid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_valid),
		.tniu_rsp_ready(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_payload),
		.tniu_rsp_srcid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_qos),
		.tniu_rsp_last(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_last),
		.tniu_rsp_threshold(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold));
	sys_tcu_tniu_top_wrap tcu_tniu_top_wrap (
		.clk_top(clk_up_func),
		.rst_top_n(rst_up_func_n),
		.async_fifo_req_pld_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(sys_tcu_tniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(sys_tcu_tniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_data_req_last(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_last),
		.top_req_data_req_payload(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_payload),
		.top_req_data_req_qos(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_qos),
		.top_req_data_req_ready(tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_ready),
		.top_req_data_req_srcid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_srcid),
		.top_req_data_req_tgtid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_tgtid),
		.top_req_data_req_threshold(tcu_tniu_top_wrap_TO_sw3_SIG_top_req_data_req_threshold),
		.top_req_data_req_valid(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_req_valid),
		.top_rsp_rsp_last(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_last),
		.top_rsp_rsp_payload(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_ready),
		.top_rsp_rsp_srcid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(sw3_TO_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold),
		.top_rsp_rsp_valid(tcu_tniu_top_wrap_TO_sw3_SIG_top_rsp_rsp_valid));

endmodule
//[UHDL]Content End [md5:616d136f484deb4284aabdca7c87f7b7]


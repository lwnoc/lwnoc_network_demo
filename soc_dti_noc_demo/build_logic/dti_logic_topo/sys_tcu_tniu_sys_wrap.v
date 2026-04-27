//[UHDL]Content Start [md5:8616c4fc89083478972b86b9dbd114f8]
module sys_tcu_tniu_sys_wrap
	import lwnoc_lp_define_package::*;
	import lwnoc_lp_struct_package::*;
	(
	input                                                   clk_sys_clk              ,
	input                                                   rst_sys_n_rst_n          ,
	output [79:0]                                           dti_req_req_tdata        ,
	output [9:0]                                            dti_req_req_tkeep        ,
	output                                                  dti_req_req_tlast        ,
	input                                                   dti_req_req_tready       ,
	output [5:0]                                            dti_req_req_ttid         ,
	output                                                  dti_req_req_tvalid       ,
	input  [79:0]                                           dti_rsp_rsp_tdata        ,
	input  [9:0]                                            dti_rsp_rsp_tkeep        ,
	input                                                   dti_rsp_rsp_tlast        ,
	output                                                  dti_rsp_rsp_tready       ,
	input  [5:0]                                            dti_rsp_rsp_ttid         ,
	input                                                   dti_rsp_rsp_tvalid       ,
	output                                                  req_twakeup_req_twakeup  ,
	input                                                   rsp_twakeup_rsp_twakeup  ,
	output                                                  pchnl_ctrl_paccept       ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t pchnl_ctrl_pactive       ,
	output                                                  pchnl_ctrl_pdeny         ,
	input                                                   pchnl_ctrl_preq          ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  pchnl_ctrl_pstate        ,
	input  [104:0]                                          async_fifo_req_pld_sync  ,
	output [9:0]                                            async_fifo_req_rptr_async,
	output [9:0]                                            async_fifo_req_rptr_sync ,
	input  [9:0]                                            async_fifo_req_wptr_async,
	output [104:0]                                          async_fifo_rsp_pld_sync  ,
	input  [9:0]                                            async_fifo_rsp_rptr_async,
	input  [9:0]                                            async_fifo_rsp_rptr_sync ,
	output [9:0]                                            async_fifo_rsp_wptr_async,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t   lp_top_tx_lp_hub_tx_req  ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t   lp_top_rx_lp_hub_rx_req  );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	sys_tcu_dti_tniu_async_sys_side sys_side (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.req_tvalid(dti_req_req_tvalid),
		.req_tdata(dti_req_req_tdata),
		.req_tkeep(dti_req_req_tkeep),
		.req_tlast(dti_req_req_tlast),
		.req_ttid(dti_req_req_ttid),
		.req_tready(dti_req_req_tready),
		.req_twakeup(req_twakeup_req_twakeup),
		.rsp_twakeup(rsp_twakeup_rsp_twakeup),
		.rsp_tvalid(dti_rsp_rsp_tvalid),
		.rsp_tdata(dti_rsp_rsp_tdata),
		.rsp_tkeep(dti_rsp_rsp_tkeep),
		.rsp_tlast(dti_rsp_rsp_tlast),
		.rsp_ttid(dti_rsp_rsp_ttid),
		.rsp_tready(dti_rsp_rsp_tready),
		.req_wptr_async(async_fifo_req_wptr_async),
		.req_rptr_async(async_fifo_req_rptr_async),
		.req_rptr_sync(async_fifo_req_rptr_sync),
		.req_pld_sync(async_fifo_req_pld_sync),
		.rsp_wptr_async(async_fifo_rsp_wptr_async),
		.rsp_rptr_async(async_fifo_rsp_rptr_async),
		.rsp_rptr_sync(async_fifo_rsp_rptr_sync),
		.rsp_pld_sync(async_fifo_rsp_pld_sync),
		.preq(pchnl_ctrl_preq),
		.pstate(pchnl_ctrl_pstate),
		.pactive(pchnl_ctrl_pactive),
		.paccept(pchnl_ctrl_paccept),
		.pdeny(pchnl_ctrl_pdeny),
		.lp_hub_rx_req(lp_top_rx_lp_hub_rx_req),
		.lp_hub_tx_req(lp_top_tx_lp_hub_tx_req));

endmodule
//[UHDL]Content End [md5:8616c4fc89083478972b86b9dbd114f8]


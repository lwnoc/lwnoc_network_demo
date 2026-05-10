//[UHDL]Content Start [md5:4ef44608bca0bdcee1e546e63814d762]
module cpu_ss_tniu1_top_wrap (
	input          clk_noc                                                        ,
	input          rst_noc_n                                                      ,
	output [112:0] async_fifo_req_pld_sync                                        ,
	input  [9:0]   async_fifo_req_rptr_async                                      ,
	input  [9:0]   async_fifo_req_rptr_sync                                       ,
	output [9:0]   async_fifo_req_wptr_async                                      ,
	input  [112:0] async_fifo_rsp_pld_sync                                        ,
	output [9:0]   async_fifo_rsp_rptr_async                                      ,
	output [9:0]   async_fifo_rsp_rptr_sync                                       ,
	input  [9:0]   async_fifo_rsp_wptr_async                                      ,
	output [12:0]  lp_top_tx_lp_hub_tx_req                                        ,
	input  [12:0]  lp_top_rx_lp_hub_rx_req                                        ,
	input          top_req_data_req_last                                          ,
	input  [89:0]  top_req_data_req_payload                                       ,
	input          top_req_data_req_qos                                           ,
	output         top_req_data_req_ready                                         ,
	input  [5:0]   top_req_data_req_srcid                                         ,
	input  [5:0]   top_req_data_req_tgtid                                         ,
	output         top_req_data_req_threshold                                     ,
	input          top_req_data_req_valid                                         ,
	output         top_rsp_rsp_last                                               ,
	output [89:0]  top_rsp_rsp_payload                                            ,
	output         top_rsp_rsp_qos                                                ,
	input          top_rsp_rsp_ready                                              ,
	output [5:0]   top_rsp_rsp_srcid                                              ,
	output [5:0]   top_rsp_rsp_tgtid                                              ,
	input          top_rsp_rsp_threshold                                          ,
	output         top_rsp_rsp_valid                                              ,
	output         cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,
	output         cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err);

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_tniu_top_dti_tniu_async_top_side top_side (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.req_valid(top_req_data_req_valid),
		.req_payload(top_req_data_req_payload),
		.req_last(top_req_data_req_last),
		.req_srcid(top_req_data_req_srcid),
		.req_tgtid(top_req_data_req_tgtid),
		.req_qos(top_req_data_req_qos),
		.req_threshold(top_req_data_req_threshold),
		.req_ready(top_req_data_req_ready),
		.req_wptr_async(async_fifo_req_wptr_async),
		.req_rptr_async(async_fifo_req_rptr_async),
		.req_rptr_sync(async_fifo_req_rptr_sync),
		.req_pld_sync(async_fifo_req_pld_sync),
		.rsp_valid(top_rsp_rsp_valid),
		.rsp_payload(top_rsp_rsp_payload),
		.rsp_last(top_rsp_rsp_last),
		.rsp_srcid(top_rsp_rsp_srcid),
		.rsp_tgtid(top_rsp_rsp_tgtid),
		.rsp_qos(top_rsp_rsp_qos),
		.rsp_threshold(top_rsp_rsp_threshold),
		.rsp_ready(top_rsp_rsp_ready),
		.rsp_wptr_async(async_fifo_rsp_wptr_async),
		.rsp_rptr_async(async_fifo_rsp_rptr_async),
		.rsp_rptr_sync(async_fifo_rsp_rptr_sync),
		.rsp_pld_sync(async_fifo_rsp_pld_sync),
		.rsp_afifo_sb_err(cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err),
		.rsp_afifo_db_err(cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err),
		.lp_hub_rx_req(lp_top_rx_lp_hub_rx_req),
		.lp_hub_tx_req(lp_top_tx_lp_hub_tx_req));

endmodule
//[UHDL]Content End [md5:4ef44608bca0bdcee1e546e63814d762]


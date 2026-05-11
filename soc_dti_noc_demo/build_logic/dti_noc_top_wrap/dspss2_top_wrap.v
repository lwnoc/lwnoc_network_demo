//[UHDL]Content Start [md5:85d92bc629d193828e1f6129af70294a]
module dspss2_top_wrap (
	input          clk_noc                      ,
	input          rst_noc_n                    ,
	input  [112:0] async_fifo_req_pld_sync      ,
	output [15:0]  async_fifo_req_rptr_async    ,
	output [15:0]  async_fifo_req_rptr_sync     ,
	input  [15:0]  async_fifo_req_wptr_async    ,
	output [112:0] async_fifo_rsp_pld_sync      ,
	input  [15:0]  async_fifo_rsp_rptr_async    ,
	input  [15:0]  async_fifo_rsp_rptr_sync     ,
	output [15:0]  async_fifo_rsp_wptr_async    ,
	output [12:0]  lp_top_tx_lp_hub_tx_req      ,
	input  [12:0]  lp_top_rx_lp_hub_rx_req      ,
	output         top_req_req_last             ,
	output [89:0]  top_req_req_payload          ,
	output         top_req_req_qos              ,
	input          top_req_req_ready            ,
	output [5:0]   top_req_req_srcid            ,
	output [5:0]   top_req_req_tgtid            ,
	input          top_req_req_threshold        ,
	output         top_req_req_valid            ,
	input          top_rsp_rsp_last             ,
	input  [89:0]  top_rsp_rsp_payload          ,
	input          top_rsp_rsp_qos              ,
	output         top_rsp_rsp_ready            ,
	input  [5:0]   top_rsp_rsp_srcid            ,
	input  [5:0]   top_rsp_rsp_tgtid            ,
	output         top_rsp_rsp_threshold        ,
	input          top_rsp_rsp_valid            ,
	output         afifo_sb_err_req_afifo_sb_err,
	output         afifo_db_err_req_afifo_db_err);

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_iniu_top_dspss2_dti_pr_iniu_async_top_side top_side (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.rsp_valid(top_rsp_rsp_valid),
		.rsp_payload(top_rsp_rsp_payload),
		.rsp_last(top_rsp_rsp_last),
		.rsp_srcid(top_rsp_rsp_srcid),
		.rsp_tgtid(top_rsp_rsp_tgtid),
		.rsp_qos(top_rsp_rsp_qos),
		.rsp_threshold(top_rsp_rsp_threshold),
		.rsp_ready(top_rsp_rsp_ready),
		.req_valid(top_req_req_valid),
		.req_payload(top_req_req_payload),
		.req_last(top_req_req_last),
		.req_srcid(top_req_req_srcid),
		.req_tgtid(top_req_req_tgtid),
		.req_qos(top_req_req_qos),
		.req_threshold(top_req_req_threshold),
		.req_ready(top_req_req_ready),
		.req_wptr_async(async_fifo_req_wptr_async),
		.req_rptr_async(async_fifo_req_rptr_async),
		.req_rptr_sync(async_fifo_req_rptr_sync),
		.req_pld_sync(async_fifo_req_pld_sync),
		.req_afifo_sb_err(afifo_sb_err_req_afifo_sb_err),
		.req_afifo_db_err(afifo_db_err_req_afifo_db_err),
		.rsp_wptr_async(async_fifo_rsp_wptr_async),
		.rsp_rptr_async(async_fifo_rsp_rptr_async),
		.rsp_rptr_sync(async_fifo_rsp_rptr_sync),
		.rsp_pld_sync(async_fifo_rsp_pld_sync),
		.lp_hub_rx_req(lp_top_rx_lp_hub_rx_req),
		.lp_hub_tx_req(lp_top_tx_lp_hub_tx_req));

endmodule
//[UHDL]Content End [md5:85d92bc629d193828e1f6129af70294a]


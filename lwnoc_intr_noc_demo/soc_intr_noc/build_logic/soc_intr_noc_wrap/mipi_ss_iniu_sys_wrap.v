//[UHDL]Content Start [md5:b40dedb05a1e8ddb0c66039c4922be42]
module mipi_ss_iniu_sys_wrap (
	input           clk_sys_func_clk                  ,
	input           rst_sys_func_n_rst_n              ,
	input  [4095:0] v_interrupt_v_interrupt           ,
	input  [7:0]    iniu_src_id_iniu_src_id           ,
	input  [31:0]   apb_p_addr                        ,
	input           apb_p_enable                      ,
	output [31:0]   apb_p_rdata                       ,
	output          apb_p_ready                       ,
	input           apb_p_sel                         ,
	output          apb_p_slverr                      ,
	input  [31:0]   apb_p_wdata                       ,
	input           apb_p_write                       ,
	output [61:0]   async_fifo_pld_sync               ,
	input  [15:0]   async_fifo_rptr_async             ,
	input  [15:0]   async_fifo_rptr_sync              ,
	output [15:0]   async_fifo_wptr_async             ,
	input  [9:0]    timeout_val_timeout_val           ,
	input  [8:0]    lp_async_s_async_master_hub_rx_req,
	output [8:0]    lp_async_s_async_master_hub_tx_req,
	output          pchannel_paccept                  ,
	output [1:0]    pchannel_pactive                  ,
	output          pchannel_pdeny                    ,
	input           pchannel_preq                     ,
	input  [1:0]    pchannel_pstate                   );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	mipi_ss_iniu_interrupt_iniu_async_sys_side iniu_sys (
		.clk(clk_sys_func_clk),
		.rst_n(rst_sys_func_n_rst_n),
		.v_interrupt(v_interrupt_v_interrupt),
		.iniu_src_id(iniu_src_id_iniu_src_id),
		.p_addr(apb_p_addr),
		.p_sel(apb_p_sel),
		.p_enable(apb_p_enable),
		.p_write(apb_p_write),
		.p_wdata(apb_p_wdata),
		.p_ready(apb_p_ready),
		.p_rdata(apb_p_rdata),
		.p_slverr(apb_p_slverr),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.timeout_val(timeout_val_timeout_val),
		.s_async_master_hub_rx_req(lp_async_s_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(lp_async_s_async_master_hub_tx_req),
		.preq(pchannel_preq),
		.pstate(pchannel_pstate),
		.pactive(pchannel_pactive),
		.paccept(pchannel_paccept),
		.pdeny(pchannel_pdeny));

endmodule
//[UHDL]Content End [md5:b40dedb05a1e8ddb0c66039c4922be42]


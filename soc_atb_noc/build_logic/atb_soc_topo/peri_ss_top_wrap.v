//[UHDL]Content Start [md5:5f7d892f1617686714fedc4a09d6dece]
module peri_ss_top_wrap (
	input          clk_clk_atb_s               ,
	input          rst_n_rstn_atb_s            ,
	input          s_chan_in_s_afready         ,
	input  [3:0]   s_chan_in_s_atbytes         ,
	input  [127:0] s_chan_in_s_atdata          ,
	input  [6:0]   s_chan_in_s_atid            ,
	input          s_chan_in_s_atvalid         ,
	input          s_chan_in_s_atwakeup        ,
	output         s_chan_out_s_afvalid        ,
	output         s_chan_out_s_atready        ,
	output         s_syncreq_s_syncreq         ,
	input          flush_req_flush_req         ,
	output [151:0] async_fifo_pld_sync         ,
	input  [15:0]  async_fifo_rptr_async       ,
	input  [15:0]  async_fifo_rptr_sync        ,
	output [15:0]  async_fifo_wptr_async       ,
	input          syncreq_level_syncreq_level ,
	input  [12:0]  lp_lw_rx_lw_rx_req          ,
	output [12:0]  lp_lw_tx_lw_tx_req          ,
	input  [12:0]  lp_afifo_rx_afifo_slv_rx_req,
	output [12:0]  lp_afifo_tx_afifo_slv_tx_req,
	input  [9:0]   timeout_val_timeout_val     );

	//Wire define for this module.
	wire [0:0] aifo_slv_full_zero_aifo_slv_full_zero;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	peri_noc_atb_tniu_noc top_side (
		.clk_atb_s(clk_clk_atb_s),
		.rstn_atb_s(rst_n_rstn_atb_s),
		.s_atvalid(s_chan_in_s_atvalid),
		.s_atready(s_chan_out_s_atready),
		.s_atbytes(s_chan_in_s_atbytes),
		.s_atdata(s_chan_in_s_atdata),
		.s_atid(s_chan_in_s_atid),
		.s_afvalid(s_chan_out_s_afvalid),
		.s_afready(s_chan_in_s_afready),
		.s_syncreq(s_syncreq_s_syncreq),
		.s_atwakeup(s_chan_in_s_atwakeup),
		.flush_req(flush_req_flush_req),
		.aifo_slv_full_zero(aifo_slv_full_zero_aifo_slv_full_zero),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.syncreq_level(syncreq_level_syncreq_level),
		.lw_rx_req(lp_lw_rx_lw_rx_req),
		.lw_tx_req(lp_lw_tx_lw_tx_req),
		.afifo_slv_rx_req(lp_afifo_rx_afifo_slv_rx_req),
		.afifo_slv_tx_req(lp_afifo_tx_afifo_slv_tx_req),
		.timeout_val(timeout_val_timeout_val));

endmodule
//[UHDL]Content End [md5:5f7d892f1617686714fedc4a09d6dece]


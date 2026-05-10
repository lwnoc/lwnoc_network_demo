//[UHDL]Content Start [md5:c19091eb2a8d196748c7215f51ae84fd]
module camera_ss_top_wrap (
	input          clk_clk_atb_m                  ,
	input          rst_n_rstn_atb_m               ,
	output         m_chan_m_afready               ,
	input          m_chan_m_afvalid               ,
	output [3:0]   m_chan_m_atbytes               ,
	output [127:0] m_chan_m_atdata                ,
	output [6:0]   m_chan_m_atid                  ,
	input          m_chan_m_atready               ,
	output         m_chan_m_atvalid               ,
	output         m_chan_m_atwakeup              ,
	input          m_chan_m_syncreq               ,
	output         syncreq_level_syncreq_level    ,
	output         flush_req_level_flush_req_level,
	input  [12:0]  lp_afifo_rx_afifo_mst_rx_req   ,
	output [12:0]  lp_afifo_tx_afifo_mst_tx_req   ,
	input  [151:0] async_fifo_pld_sync            ,
	output [15:0]  async_fifo_rptr_async          ,
	output [15:0]  async_fifo_rptr_sync           ,
	input  [15:0]  async_fifo_wptr_async          ,
	input  [12:0]  lp_rx_lw_rx_req                ,
	output [12:0]  lp_tx_lw_tx_req                ,
	input  [9:0]   timeout_val_timeout_val        );

	//Wire define for this module.
	wire [0:0] afifo_sb_err_atb_iniu_afifo_sb_err;
	wire [0:0] afifo_db_err_atb_iniu_afifo_db_err;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cam_noc_atb_iniu_noc top_side (
		.clk_atb_m(clk_clk_atb_m),
		.rstn_atb_m(rst_n_rstn_atb_m),
		.m_atvalid(m_chan_m_atvalid),
		.m_atready(m_chan_m_atready),
		.m_atbytes(m_chan_m_atbytes),
		.m_atdata(m_chan_m_atdata),
		.m_atid(m_chan_m_atid),
		.m_afvalid(m_chan_m_afvalid),
		.m_afready(m_chan_m_afready),
		.m_syncreq(m_chan_m_syncreq),
		.m_atwakeup(m_chan_m_atwakeup),
		.syncreq_level(syncreq_level_syncreq_level),
		.flush_req_level(flush_req_level_flush_req_level),
		.atb_iniu_afifo_sb_err(afifo_sb_err_atb_iniu_afifo_sb_err),
		.atb_iniu_afifo_db_err(afifo_db_err_atb_iniu_afifo_db_err),
		.afifo_mst_rx_req(lp_afifo_rx_afifo_mst_rx_req),
		.afifo_mst_tx_req(lp_afifo_tx_afifo_mst_tx_req),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.lw_rx_req(lp_rx_lw_rx_req),
		.lw_tx_req(lp_tx_lw_tx_req),
		.timeout_val(timeout_val_timeout_val));

endmodule
//[UHDL]Content End [md5:c19091eb2a8d196748c7215f51ae84fd]


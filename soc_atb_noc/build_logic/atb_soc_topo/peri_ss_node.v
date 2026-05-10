//[UHDL]Content Start [md5:9d4012b63a283154f1d8f8370545d46c]
module peri_ss_node (
	input          clk_sys_clk_atb_m                                       ,
	input          rst_sys_n_rstn_atb_m                                    ,
	input          clk_noc                                                 ,
	input          rst_noc_n                                               ,
	input  [9:0]   timeout_val                                             ,
	input          peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_afready  ,
	input  [3:0]   peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atbytes  ,
	input  [127:0] peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atdata   ,
	input  [6:0]   peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atid     ,
	input          peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atvalid  ,
	input          peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atwakeup ,
	output         peri_ss_top_wrap_s_chan_out_porting_s_chan_out_s_afvalid,
	output         peri_ss_top_wrap_s_chan_out_porting_s_chan_out_s_atready,
	output         peri_ss_top_wrap_s_syncreq_porting_s_syncreq_s_syncreq  ,
	output         peri_ss_sys_node_m_chan_porting_m_afready               ,
	input          peri_ss_sys_node_m_chan_porting_m_afvalid               ,
	output [3:0]   peri_ss_sys_node_m_chan_porting_m_atbytes               ,
	output [127:0] peri_ss_sys_node_m_chan_porting_m_atdata                ,
	output [6:0]   peri_ss_sys_node_m_chan_porting_m_atid                  ,
	input          peri_ss_sys_node_m_chan_porting_m_atready               ,
	output         peri_ss_sys_node_m_chan_porting_m_atvalid               ,
	output         peri_ss_sys_node_m_chan_porting_m_atwakeup              ,
	input          peri_ss_sys_node_m_chan_porting_m_syncreq               ,
	output         peri_ss_sys_node_pchnl_ctrl_porting_paccept             ,
	output [1:0]   peri_ss_sys_node_pchnl_ctrl_porting_pactive             ,
	output         peri_ss_sys_node_pchnl_ctrl_porting_pdeny               ,
	input          peri_ss_sys_node_pchnl_ctrl_porting_preq                ,
	input  [1:0]   peri_ss_sys_node_pchnl_ctrl_porting_pstate              );

	//Wire define for this module.
	wire [0:0] afifo_sb_err_atb_tniu_afifo_sb_err;
	wire [0:0] afifo_db_err_atb_tniu_afifo_db_err;

	//Wire define for sub module.
	wire         sys_side_TO_top_side_SIG_flush_req_level             ;
	wire [15:0]  sys_side_TO_top_side_SIG_rptr_async                  ;
	wire [15:0]  sys_side_TO_top_side_SIG_rptr_sync                   ;
	wire         sys_side_TO_top_side_SIG_syncreq_level               ;
	wire [12:0]  sys_side_TO_top_side_SIG_lw_tx_req                   ;
	wire [12:0]  sys_side_TO_top_side_SIG_afifo_slv_tx_req            ;
	wire [12:0]  top_side_TO_sys_side_SIG_lp_lw_tx_lw_tx_req          ;
	wire [12:0]  top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_slv_tx_req;
	wire [15:0]  top_side_TO_sys_side_SIG_async_fifo_wptr_async       ;
	wire [151:0] top_side_TO_sys_side_SIG_async_fifo_pld_sync         ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	peri_ss_top_wrap top_side (
		.clk_clk_atb_s(clk_noc),
		.rst_n_rstn_atb_s(rst_noc_n),
		.s_chan_in_s_afready(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_afready),
		.s_chan_in_s_atbytes(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atbytes),
		.s_chan_in_s_atdata(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atdata),
		.s_chan_in_s_atid(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atid),
		.s_chan_in_s_atvalid(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atvalid),
		.s_chan_in_s_atwakeup(peri_ss_top_wrap_s_chan_in_porting_s_chan_in_s_atwakeup),
		.s_chan_out_s_afvalid(peri_ss_top_wrap_s_chan_out_porting_s_chan_out_s_afvalid),
		.s_chan_out_s_atready(peri_ss_top_wrap_s_chan_out_porting_s_chan_out_s_atready),
		.s_syncreq_s_syncreq(peri_ss_top_wrap_s_syncreq_porting_s_syncreq_s_syncreq),
		.flush_req_flush_req(sys_side_TO_top_side_SIG_flush_req_level),
		.async_fifo_pld_sync(top_side_TO_sys_side_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(sys_side_TO_top_side_SIG_rptr_async),
		.async_fifo_rptr_sync(sys_side_TO_top_side_SIG_rptr_sync),
		.async_fifo_wptr_async(top_side_TO_sys_side_SIG_async_fifo_wptr_async),
		.syncreq_level_syncreq_level(sys_side_TO_top_side_SIG_syncreq_level),
		.lp_lw_rx_lw_rx_req(sys_side_TO_top_side_SIG_lw_tx_req),
		.lp_lw_tx_lw_tx_req(top_side_TO_sys_side_SIG_lp_lw_tx_lw_tx_req),
		.lp_afifo_rx_afifo_slv_rx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.lp_afifo_tx_afifo_slv_tx_req(top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_slv_tx_req),
		.timeout_val_timeout_val(timeout_val));
	peri_atb_tniu_sys sys_side (
		.clk_atb_m(clk_sys_clk_atb_m),
		.rstn_atb_m(rst_sys_n_rstn_atb_m),
		.m_atvalid(peri_ss_sys_node_m_chan_porting_m_atvalid),
		.m_atready(peri_ss_sys_node_m_chan_porting_m_atready),
		.m_atbytes(peri_ss_sys_node_m_chan_porting_m_atbytes),
		.m_atdata(peri_ss_sys_node_m_chan_porting_m_atdata),
		.m_atid(peri_ss_sys_node_m_chan_porting_m_atid),
		.m_afvalid(peri_ss_sys_node_m_chan_porting_m_afvalid),
		.m_afready(peri_ss_sys_node_m_chan_porting_m_afready),
		.m_syncreq(peri_ss_sys_node_m_chan_porting_m_syncreq),
		.m_atwakeup(peri_ss_sys_node_m_chan_porting_m_atwakeup),
		.preq(peri_ss_sys_node_pchnl_ctrl_porting_preq),
		.pstate(peri_ss_sys_node_pchnl_ctrl_porting_pstate),
		.pactive(peri_ss_sys_node_pchnl_ctrl_porting_pactive),
		.paccept(peri_ss_sys_node_pchnl_ctrl_porting_paccept),
		.pdeny(peri_ss_sys_node_pchnl_ctrl_porting_pdeny),
		.syncreq_level(sys_side_TO_top_side_SIG_syncreq_level),
		.flush_req_level(sys_side_TO_top_side_SIG_flush_req_level),
		.atb_tniu_afifo_sb_err(afifo_sb_err_atb_tniu_afifo_sb_err),
		.atb_tniu_afifo_db_err(afifo_db_err_atb_tniu_afifo_db_err),
		.lw_rx_req(top_side_TO_sys_side_SIG_lp_lw_tx_lw_tx_req),
		.lw_tx_req(sys_side_TO_top_side_SIG_lw_tx_req),
		.afifo_slv_rx_req(top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_slv_tx_req),
		.afifo_slv_tx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.wptr_async(top_side_TO_sys_side_SIG_async_fifo_wptr_async),
		.rptr_async(sys_side_TO_top_side_SIG_rptr_async),
		.rptr_sync(sys_side_TO_top_side_SIG_rptr_sync),
		.pld_sync(top_side_TO_sys_side_SIG_async_fifo_pld_sync),
		.timeout_val(timeout_val));

endmodule
//[UHDL]Content End [md5:9d4012b63a283154f1d8f8370545d46c]


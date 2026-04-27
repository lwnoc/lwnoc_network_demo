//[UHDL]Content Start [md5:774033ce976027dcf29f7b4695f75be8]
module debug_tniu_ss_node (
	input          clk_sys_clk_atb_m                                         ,
	input          rst_sys_n_rstn_atb_m                                      ,
	input          clk_noc                                                   ,
	input          rst_noc_n                                                 ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_afready           ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_afvalid           ,
	input  [3:0]   debug_tniu_ss_top_node_s_chan_porting_s_atbytes           ,
	input  [127:0] debug_tniu_ss_top_node_s_chan_porting_s_atdata            ,
	input  [6:0]   debug_tniu_ss_top_node_s_chan_porting_s_atid              ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_atready           ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_atvalid           ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_atwakeup          ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_syncreq           ,
	input          debug_tniu_ss_top_node_flush_req_porting_flush_req        ,
	input          debug_tniu_ss_top_node_syncreq_level_porting_syncreq_level,
	input  [12:0]  debug_tniu_ss_top_node_lp_lw_porting_lw_rx_req            ,
	output [12:0]  debug_tniu_ss_top_node_lp_lw_porting_lw_tx_req            ,
	input  [12:0]  debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_rx_req  ,
	output [12:0]  debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_tx_req  ,
	input  [9:0]   debug_tniu_ss_top_node_timeout_val_porting_timeout_val    ,
	output         debug_tniu_ss_sys_node_m_chan_porting_m_afready           ,
	input          debug_tniu_ss_sys_node_m_chan_porting_m_afvalid           ,
	output [3:0]   debug_tniu_ss_sys_node_m_chan_porting_m_atbytes           ,
	output [127:0] debug_tniu_ss_sys_node_m_chan_porting_m_atdata            ,
	output [6:0]   debug_tniu_ss_sys_node_m_chan_porting_m_atid              ,
	input          debug_tniu_ss_sys_node_m_chan_porting_m_atready           ,
	output         debug_tniu_ss_sys_node_m_chan_porting_m_atvalid           ,
	output         debug_tniu_ss_sys_node_m_chan_porting_m_atwakeup          ,
	input          debug_tniu_ss_sys_node_m_chan_porting_m_syncreq           ,
	output         debug_tniu_ss_sys_node_pchnl_ctrl_porting_paccept         ,
	output [1:0]   debug_tniu_ss_sys_node_pchnl_ctrl_porting_pactive         ,
	output         debug_tniu_ss_sys_node_pchnl_ctrl_porting_pdeny           ,
	input          debug_tniu_ss_sys_node_pchnl_ctrl_porting_preq            ,
	input  [1:0]   debug_tniu_ss_sys_node_pchnl_ctrl_porting_pstate          ,
	output         debug_tniu_ss_sys_node_sync_ctrl_porting_flush_req_level  ,
	output         debug_tniu_ss_sys_node_sync_ctrl_porting_syncreq_level    ,
	input  [12:0]  debug_tniu_ss_sys_node_lp_lw_porting_lw_rx_req            ,
	output [12:0]  debug_tniu_ss_sys_node_lp_lw_porting_lw_tx_req            ,
	input  [12:0]  debug_tniu_ss_sys_node_lp_afifo_porting_afifo_slv_rx_req  ,
	output [12:0]  debug_tniu_ss_sys_node_lp_afifo_porting_afifo_slv_tx_req  ,
	input  [9:0]   debug_tniu_ss_sys_node_timeout_val_porting_timeout_val    );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0]  sys_side_TO_top_side_SIG_rptr_async;
	wire [15:0]  sys_side_TO_top_side_SIG_rptr_sync ;
	wire [15:0]  top_side_TO_sys_side_SIG_wptr_async;
	wire [142:0] top_side_TO_sys_side_SIG_pld_sync  ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	atb_tniu_noc top_side (
		.clk_atb_s(clk_noc),
		.rstn_atb_s(rst_noc_n),
		.s_atvalid(debug_tniu_ss_top_node_s_chan_porting_s_atvalid),
		.s_atready(debug_tniu_ss_top_node_s_chan_porting_s_atready),
		.s_atbytes(debug_tniu_ss_top_node_s_chan_porting_s_atbytes),
		.s_atdata(debug_tniu_ss_top_node_s_chan_porting_s_atdata),
		.s_atid(debug_tniu_ss_top_node_s_chan_porting_s_atid),
		.s_afvalid(debug_tniu_ss_top_node_s_chan_porting_s_afvalid),
		.s_afready(debug_tniu_ss_top_node_s_chan_porting_s_afready),
		.s_syncreq(debug_tniu_ss_top_node_s_chan_porting_s_syncreq),
		.s_atwakeup(debug_tniu_ss_top_node_s_chan_porting_s_atwakeup),
		.flush_req(debug_tniu_ss_top_node_flush_req_porting_flush_req),
		.aifo_slv_full_zero(),
		.wptr_async(top_side_TO_sys_side_SIG_wptr_async),
		.rptr_async(sys_side_TO_top_side_SIG_rptr_async),
		.rptr_sync(sys_side_TO_top_side_SIG_rptr_sync),
		.pld_sync(top_side_TO_sys_side_SIG_pld_sync),
		.syncreq_level(debug_tniu_ss_top_node_syncreq_level_porting_syncreq_level),
		.lw_rx_req(debug_tniu_ss_top_node_lp_lw_porting_lw_rx_req),
		.lw_tx_req(debug_tniu_ss_top_node_lp_lw_porting_lw_tx_req),
		.afifo_slv_rx_req(debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_rx_req),
		.afifo_slv_tx_req(debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_tx_req),
		.timeout_val(debug_tniu_ss_top_node_timeout_val_porting_timeout_val));
	dbg_atb_tniu_sys sys_side (
		.clk_atb_m(clk_sys_clk_atb_m),
		.rstn_atb_m(rst_sys_n_rstn_atb_m),
		.m_atvalid(debug_tniu_ss_sys_node_m_chan_porting_m_atvalid),
		.m_atready(debug_tniu_ss_sys_node_m_chan_porting_m_atready),
		.m_atbytes(debug_tniu_ss_sys_node_m_chan_porting_m_atbytes),
		.m_atdata(debug_tniu_ss_sys_node_m_chan_porting_m_atdata),
		.m_atid(debug_tniu_ss_sys_node_m_chan_porting_m_atid),
		.m_afvalid(debug_tniu_ss_sys_node_m_chan_porting_m_afvalid),
		.m_afready(debug_tniu_ss_sys_node_m_chan_porting_m_afready),
		.m_syncreq(debug_tniu_ss_sys_node_m_chan_porting_m_syncreq),
		.m_atwakeup(debug_tniu_ss_sys_node_m_chan_porting_m_atwakeup),
		.preq(debug_tniu_ss_sys_node_pchnl_ctrl_porting_preq),
		.pstate(debug_tniu_ss_sys_node_pchnl_ctrl_porting_pstate),
		.pactive(debug_tniu_ss_sys_node_pchnl_ctrl_porting_pactive),
		.paccept(debug_tniu_ss_sys_node_pchnl_ctrl_porting_paccept),
		.pdeny(debug_tniu_ss_sys_node_pchnl_ctrl_porting_pdeny),
		.syncreq_level(debug_tniu_ss_sys_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(debug_tniu_ss_sys_node_sync_ctrl_porting_flush_req_level),
		.lw_rx_req(debug_tniu_ss_sys_node_lp_lw_porting_lw_rx_req),
		.lw_tx_req(debug_tniu_ss_sys_node_lp_lw_porting_lw_tx_req),
		.afifo_slv_rx_req(debug_tniu_ss_sys_node_lp_afifo_porting_afifo_slv_rx_req),
		.afifo_slv_tx_req(debug_tniu_ss_sys_node_lp_afifo_porting_afifo_slv_tx_req),
		.wptr_async(top_side_TO_sys_side_SIG_wptr_async),
		.rptr_async(sys_side_TO_top_side_SIG_rptr_async),
		.rptr_sync(sys_side_TO_top_side_SIG_rptr_sync),
		.pld_sync(top_side_TO_sys_side_SIG_pld_sync),
		.timeout_val(debug_tniu_ss_sys_node_timeout_val_porting_timeout_val));

endmodule
//[UHDL]Content End [md5:774033ce976027dcf29f7b4695f75be8]


//[UHDL]Content Start [md5:dc6d436f8f43696d97f7ba3775912de7]
module gpu_ss0_node (
	input          clk_sys_clk_atb_s                                ,
	input          rst_sys_n_rstn_atb_s                             ,
	input          clk_noc                                          ,
	input          rst_noc_n                                        ,
	input  [9:0]   timeout_val                                      ,
	input          gpu_ss0_sys_node_s_chan_porting_s_afready        ,
	output         gpu_ss0_sys_node_s_chan_porting_s_afvalid        ,
	input  [3:0]   gpu_ss0_sys_node_s_chan_porting_s_atbytes        ,
	input  [127:0] gpu_ss0_sys_node_s_chan_porting_s_atdata         ,
	input  [6:0]   gpu_ss0_sys_node_s_chan_porting_s_atid           ,
	output         gpu_ss0_sys_node_s_chan_porting_s_atready        ,
	input          gpu_ss0_sys_node_s_chan_porting_s_atvalid        ,
	input          gpu_ss0_sys_node_s_chan_porting_s_atwakeup       ,
	output         gpu_ss0_sys_node_s_chan_porting_s_syncreq        ,
	output         gpu_ss0_sys_node_pchnl_ctrl_porting_paccept      ,
	output [1:0]   gpu_ss0_sys_node_pchnl_ctrl_porting_pactive      ,
	output         gpu_ss0_sys_node_pchnl_ctrl_porting_pdeny        ,
	input          gpu_ss0_sys_node_pchnl_ctrl_porting_preq         ,
	input  [1:0]   gpu_ss0_sys_node_pchnl_ctrl_porting_pstate       ,
	output         gpu_ss0_top_wrap_m_chan_porting_m_chan_m_afready ,
	input          gpu_ss0_top_wrap_m_chan_porting_m_chan_m_afvalid ,
	output [3:0]   gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atbytes ,
	output [127:0] gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atdata  ,
	output [6:0]   gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atid    ,
	input          gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atready ,
	output         gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid ,
	output         gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atwakeup,
	input          gpu_ss0_top_wrap_m_chan_porting_m_chan_m_syncreq );

	//Wire define for this module.

	//Wire define for sub module.
	wire         top_side_TO_sys_side_SIG_flush_req_level_flush_req_level;
	wire [15:0]  top_side_TO_sys_side_SIG_async_fifo_rptr_async          ;
	wire [15:0]  top_side_TO_sys_side_SIG_async_fifo_rptr_sync           ;
	wire         top_side_TO_sys_side_SIG_syncreq_level_syncreq_level    ;
	wire [12:0]  top_side_TO_sys_side_SIG_lp_tx_lw_tx_req                ;
	wire [12:0]  top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_mst_tx_req   ;
	wire [12:0]  sys_side_TO_top_side_SIG_afifo_slv_tx_req               ;
	wire [151:0] sys_side_TO_top_side_SIG_pld_sync                       ;
	wire [15:0]  sys_side_TO_top_side_SIG_wptr_async                     ;
	wire [12:0]  sys_side_TO_top_side_SIG_lwnoc_tx_req                   ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	gpu0_atb_iniu_sys sys_side (
		.clk_atb_s(clk_sys_clk_atb_s),
		.rstn_atb_s(rst_sys_n_rstn_atb_s),
		.s_atvalid(gpu_ss0_sys_node_s_chan_porting_s_atvalid),
		.s_atready(gpu_ss0_sys_node_s_chan_porting_s_atready),
		.s_atbytes(gpu_ss0_sys_node_s_chan_porting_s_atbytes),
		.s_atdata(gpu_ss0_sys_node_s_chan_porting_s_atdata),
		.s_atid(gpu_ss0_sys_node_s_chan_porting_s_atid),
		.s_afvalid(gpu_ss0_sys_node_s_chan_porting_s_afvalid),
		.s_afready(gpu_ss0_sys_node_s_chan_porting_s_afready),
		.s_syncreq(gpu_ss0_sys_node_s_chan_porting_s_syncreq),
		.s_atwakeup(gpu_ss0_sys_node_s_chan_porting_s_atwakeup),
		.flush_req(top_side_TO_sys_side_SIG_flush_req_level_flush_req_level),
		.wptr_async(sys_side_TO_top_side_SIG_wptr_async),
		.rptr_async(top_side_TO_sys_side_SIG_async_fifo_rptr_async),
		.rptr_sync(top_side_TO_sys_side_SIG_async_fifo_rptr_sync),
		.pld_sync(sys_side_TO_top_side_SIG_pld_sync),
		.syncreq_level(top_side_TO_sys_side_SIG_syncreq_level_syncreq_level),
		.preq(gpu_ss0_sys_node_pchnl_ctrl_porting_preq),
		.pstate(gpu_ss0_sys_node_pchnl_ctrl_porting_pstate),
		.pactive(gpu_ss0_sys_node_pchnl_ctrl_porting_pactive),
		.paccept(gpu_ss0_sys_node_pchnl_ctrl_porting_paccept),
		.pdeny(gpu_ss0_sys_node_pchnl_ctrl_porting_pdeny),
		.lwnoc_rx_req(top_side_TO_sys_side_SIG_lp_tx_lw_tx_req),
		.lwnoc_tx_req(sys_side_TO_top_side_SIG_lwnoc_tx_req),
		.afifo_slv_rx_req(top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_mst_tx_req),
		.afifo_slv_tx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.timeout_val(timeout_val));
	gpu_ss0_top_wrap top_side (
		.clk_clk_atb_m(clk_noc),
		.rst_n_rstn_atb_m(rst_noc_n),
		.m_chan_m_afready(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_afready),
		.m_chan_m_afvalid(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_afvalid),
		.m_chan_m_atbytes(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atbytes),
		.m_chan_m_atdata(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atdata),
		.m_chan_m_atid(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atid),
		.m_chan_m_atready(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atready),
		.m_chan_m_atvalid(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid),
		.m_chan_m_atwakeup(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atwakeup),
		.m_chan_m_syncreq(gpu_ss0_top_wrap_m_chan_porting_m_chan_m_syncreq),
		.syncreq_level_syncreq_level(top_side_TO_sys_side_SIG_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(top_side_TO_sys_side_SIG_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.lp_afifo_tx_afifo_mst_tx_req(top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(sys_side_TO_top_side_SIG_pld_sync),
		.async_fifo_rptr_async(top_side_TO_sys_side_SIG_async_fifo_rptr_async),
		.async_fifo_rptr_sync(top_side_TO_sys_side_SIG_async_fifo_rptr_sync),
		.async_fifo_wptr_async(sys_side_TO_top_side_SIG_wptr_async),
		.lp_rx_lw_rx_req(sys_side_TO_top_side_SIG_lwnoc_tx_req),
		.lp_tx_lw_tx_req(top_side_TO_sys_side_SIG_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(timeout_val));

endmodule
//[UHDL]Content End [md5:dc6d436f8f43696d97f7ba3775912de7]


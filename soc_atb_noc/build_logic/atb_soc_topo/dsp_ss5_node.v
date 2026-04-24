//[UHDL]Content Start [md5:d8c521c55eb3fa9573eb23c32ffc9c4b]
module dsp_ss5_node
	import lwnoc_lp_define_package::*;
	(
	input                                                   clk_sys_clk_atb_s                                   ,
	input                                                   rst_sys_n_rstn_atb_s                                ,
	input                                                   clk_noc                                             ,
	input                                                   rst_noc_n                                           ,
	input                                                   dsp_ss5_sys_node_s_chan_porting_s_afready           ,
	output                                                  dsp_ss5_sys_node_s_chan_porting_s_afvalid           ,
	input  [3:0]                                            dsp_ss5_sys_node_s_chan_porting_s_atbytes           ,
	input  [127:0]                                          dsp_ss5_sys_node_s_chan_porting_s_atdata            ,
	input  [6:0]                                            dsp_ss5_sys_node_s_chan_porting_s_atid              ,
	output                                                  dsp_ss5_sys_node_s_chan_porting_s_atready           ,
	input                                                   dsp_ss5_sys_node_s_chan_porting_s_atvalid           ,
	input                                                   dsp_ss5_sys_node_s_chan_porting_s_atwakeup          ,
	output                                                  dsp_ss5_sys_node_s_chan_porting_s_syncreq           ,
	input                                                   dsp_ss5_sys_node_flush_req_porting_flush_req        ,
	output                                                  dsp_ss5_sys_node_pchnl_ctrl_porting_paccept         ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp_ss5_sys_node_pchnl_ctrl_porting_pactive         ,
	output                                                  dsp_ss5_sys_node_pchnl_ctrl_porting_pdeny           ,
	input                                                   dsp_ss5_sys_node_pchnl_ctrl_porting_preq            ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp_ss5_sys_node_pchnl_ctrl_porting_pstate          ,
	input                                                   dsp_ss5_sys_node_syncreq_level_porting_syncreq_level,
	input  [9:0]                                            dsp_ss5_sys_node_timeout_val_porting_timeout_val    ,
	output                                                  dsp_ss5_top_node_m_chan_porting_m_afready           ,
	input                                                   dsp_ss5_top_node_m_chan_porting_m_afvalid           ,
	output [3:0]                                            dsp_ss5_top_node_m_chan_porting_m_atbytes           ,
	output [127:0]                                          dsp_ss5_top_node_m_chan_porting_m_atdata            ,
	output [6:0]                                            dsp_ss5_top_node_m_chan_porting_m_atid              ,
	input                                                   dsp_ss5_top_node_m_chan_porting_m_atready           ,
	output                                                  dsp_ss5_top_node_m_chan_porting_m_atvalid           ,
	output                                                  dsp_ss5_top_node_m_chan_porting_m_atwakeup          ,
	input                                                   dsp_ss5_top_node_m_chan_porting_m_syncreq           ,
	output                                                  dsp_ss5_top_node_sync_ctrl_porting_flush_req_level  ,
	output                                                  dsp_ss5_top_node_sync_ctrl_porting_syncreq_level    ,
	input  [9:0]                                            dsp_ss5_top_node_timeout_val_porting_timeout_val    );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0]  top_side_TO_sys_side_SIG_rptr_async      ;
	wire [15:0]  top_side_TO_sys_side_SIG_rptr_sync       ;
	wire [12:0]  top_side_TO_sys_side_SIG_lw_tx_req       ;
	wire [12:0]  top_side_TO_sys_side_SIG_afifo_mst_tx_req;
	wire [12:0]  sys_side_TO_top_side_SIG_afifo_slv_tx_req;
	wire [15:0]  sys_side_TO_top_side_SIG_wptr_async      ;
	wire [142:0] sys_side_TO_top_side_SIG_pld_sync        ;
	wire [12:0]  sys_side_TO_top_side_SIG_lwnoc_tx_req    ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	atb_iniu_sys sys_side (
		.clk_atb_s(clk_sys_clk_atb_s),
		.rstn_atb_s(rst_sys_n_rstn_atb_s),
		.s_atvalid(dsp_ss5_sys_node_s_chan_porting_s_atvalid),
		.s_atready(dsp_ss5_sys_node_s_chan_porting_s_atready),
		.s_atbytes(dsp_ss5_sys_node_s_chan_porting_s_atbytes),
		.s_atdata(dsp_ss5_sys_node_s_chan_porting_s_atdata),
		.s_atid(dsp_ss5_sys_node_s_chan_porting_s_atid),
		.s_afvalid(dsp_ss5_sys_node_s_chan_porting_s_afvalid),
		.s_afready(dsp_ss5_sys_node_s_chan_porting_s_afready),
		.s_syncreq(dsp_ss5_sys_node_s_chan_porting_s_syncreq),
		.s_atwakeup(dsp_ss5_sys_node_s_chan_porting_s_atwakeup),
		.flush_req(dsp_ss5_sys_node_flush_req_porting_flush_req),
		.wptr_async(sys_side_TO_top_side_SIG_wptr_async),
		.rptr_async(top_side_TO_sys_side_SIG_rptr_async),
		.rptr_sync(top_side_TO_sys_side_SIG_rptr_sync),
		.pld_sync(sys_side_TO_top_side_SIG_pld_sync),
		.syncreq_level(dsp_ss5_sys_node_syncreq_level_porting_syncreq_level),
		.preq(dsp_ss5_sys_node_pchnl_ctrl_porting_preq),
		.pstate(dsp_ss5_sys_node_pchnl_ctrl_porting_pstate),
		.pactive(dsp_ss5_sys_node_pchnl_ctrl_porting_pactive),
		.paccept(dsp_ss5_sys_node_pchnl_ctrl_porting_paccept),
		.pdeny(dsp_ss5_sys_node_pchnl_ctrl_porting_pdeny),
		.lwnoc_rx_req(top_side_TO_sys_side_SIG_lw_tx_req),
		.lwnoc_tx_req(sys_side_TO_top_side_SIG_lwnoc_tx_req),
		.afifo_slv_rx_req(top_side_TO_sys_side_SIG_afifo_mst_tx_req),
		.afifo_slv_tx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.timeout_val(dsp_ss5_sys_node_timeout_val_porting_timeout_val));
	atb_iniu_noc top_side (
		.clk_atb_m(clk_noc),
		.rstn_atb_m(rst_noc_n),
		.m_atvalid(dsp_ss5_top_node_m_chan_porting_m_atvalid),
		.m_atready(dsp_ss5_top_node_m_chan_porting_m_atready),
		.m_atbytes(dsp_ss5_top_node_m_chan_porting_m_atbytes),
		.m_atdata(dsp_ss5_top_node_m_chan_porting_m_atdata),
		.m_atid(dsp_ss5_top_node_m_chan_porting_m_atid),
		.m_afvalid(dsp_ss5_top_node_m_chan_porting_m_afvalid),
		.m_afready(dsp_ss5_top_node_m_chan_porting_m_afready),
		.m_syncreq(dsp_ss5_top_node_m_chan_porting_m_syncreq),
		.m_atwakeup(dsp_ss5_top_node_m_chan_porting_m_atwakeup),
		.syncreq_level(dsp_ss5_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss5_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(sys_side_TO_top_side_SIG_afifo_slv_tx_req),
		.afifo_mst_tx_req(top_side_TO_sys_side_SIG_afifo_mst_tx_req),
		.wptr_async(sys_side_TO_top_side_SIG_wptr_async),
		.rptr_async(top_side_TO_sys_side_SIG_rptr_async),
		.rptr_sync(top_side_TO_sys_side_SIG_rptr_sync),
		.pld_sync(sys_side_TO_top_side_SIG_pld_sync),
		.lw_rx_req(sys_side_TO_top_side_SIG_lwnoc_tx_req),
		.lw_tx_req(top_side_TO_sys_side_SIG_lw_tx_req),
		.timeout_val(dsp_ss5_top_node_timeout_val_porting_timeout_val));

endmodule
//[UHDL]Content End [md5:d8c521c55eb3fa9573eb23c32ffc9c4b]


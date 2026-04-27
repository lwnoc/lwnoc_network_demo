//[UHDL]Content Start [md5:8cf5da9a7eef8ea2a8692dd6557754c7]
module atb_up_harden (
	input          clk_up_func                                                          ,
	input          rst_up_func_n                                                        ,
	output         dsp_ss0_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss0_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss0_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss0_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss0_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss0_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss0_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss0_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss0_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss0_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss0_top_node_timeout_val_porting_timeout_val                     ,
	output         dsp_ss1_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss1_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss1_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss1_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss1_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss1_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss1_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss1_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss1_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss1_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss1_top_node_timeout_val_porting_timeout_val                     ,
	output         dsp_ss2_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss2_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss2_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss2_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss2_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss2_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss2_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss2_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss2_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss2_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss2_top_node_timeout_val_porting_timeout_val                     ,
	output         dsp_ss3_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss3_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss3_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss3_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss3_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss3_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss3_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss3_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss3_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss3_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss3_top_node_timeout_val_porting_timeout_val                     ,
	output         dsp_ss4_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss4_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss4_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss4_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss4_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss4_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss4_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss4_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss4_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss4_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss4_top_node_timeout_val_porting_timeout_val                     ,
	output         dsp_ss5_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         dsp_ss5_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  dsp_ss5_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  dsp_ss5_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] dsp_ss5_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  dsp_ss5_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  dsp_ss5_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  dsp_ss5_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  dsp_ss5_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  dsp_ss5_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   dsp_ss5_top_node_timeout_val_porting_timeout_val                     ,
	input          left_funnel_node_atreadym_porting_atreadym                           ,
	input          left_funnel_node_afvalidm_porting_afvalidm                           ,
	input          left_funnel_node_syncreqm_porting_syncreqm                           ,
	output         left_funnel_node_atvalidm_porting_atvalidm                           ,
	output         left_funnel_node_afreadym_porting_afreadym                           ,
	output [6:0]   left_funnel_node_atidm_porting_atidm                                 ,
	output [127:0] left_funnel_node_atdatam_porting_atdatam                             ,
	output [3:0]   left_funnel_node_atbytesm_porting_atbytesm                           ,
	input          left_funnel_node_pclkendbg_porting_pclkendbg                         ,
	input          left_funnel_node_pseldbg_porting_pseldbg                             ,
	input          left_funnel_node_penabledbg_porting_penabledbg                       ,
	input          left_funnel_node_pwritedbg_porting_pwritedbg                         ,
	input          left_funnel_node_paddrdbg31_porting_paddrdbg31                       ,
	input  [9:0]   left_funnel_node_paddrdbg_porting_paddrdbg                           ,
	input  [31:0]  left_funnel_node_pwdatadbg_porting_pwdatadbg                         ,
	output         left_funnel_node_preadydbg_porting_preadydbg                         ,
	output         left_funnel_node_pslverrdbg_porting_pslverrdbg                       ,
	output [31:0]  left_funnel_node_prdatadbg_porting_prdatadbg                         ,
	input          async_bridge_slv_node_slv_clk_porting_clk_atb_s                      ,
	input          async_bridge_slv_node_slv_rst_n_porting_rstn_atb_s                   ,
	input          async_bridge_slv_node_s_chan_porting_s_afready                       ,
	output         async_bridge_slv_node_s_chan_porting_s_afvalid                       ,
	input  [2:0]   async_bridge_slv_node_s_chan_porting_s_atbytes                       ,
	input  [63:0]  async_bridge_slv_node_s_chan_porting_s_atdata                        ,
	input  [6:0]   async_bridge_slv_node_s_chan_porting_s_atid                          ,
	output         async_bridge_slv_node_s_chan_porting_s_atready                       ,
	input          async_bridge_slv_node_s_chan_porting_s_atvalid                       ,
	input          async_bridge_slv_node_s_chan_porting_s_atwakeup                      ,
	output         async_bridge_slv_node_s_chan_porting_s_syncreq                       ,
	output [77:0]  async_bridge_slv_node_sync_porting_pld_sync                          ,
	input  [15:0]  async_bridge_slv_node_sync_porting_rptr_async                        ,
	input  [15:0]  async_bridge_slv_node_sync_porting_rptr_sync                         ,
	input          async_bridge_slv_node_sync_porting_syncreq_level                     ,
	output [15:0]  async_bridge_slv_node_sync_porting_wptr_async                        ,
	output         async_bridge_slv_node_afifo_slv_full_zero_porting_afifo_slv_full_zero,
	input          async_bridge_slv_node_flush_req_porting_flush_req                    );

	//Wire define for this module.

	//Wire define for sub module.
	wire         left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_atready;
	wire         left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_afvalid;
	wire         left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_syncreq;
	wire         left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_atready;
	wire         left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_afvalid;
	wire         left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_syncreq;
	wire         left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_atready;
	wire         left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_afvalid;
	wire         left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_syncreq;
	wire         left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_atready;
	wire         left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_afvalid;
	wire         left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_syncreq;
	wire         left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_atready;
	wire         left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_afvalid;
	wire         left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_syncreq;
	wire         left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_atready;
	wire         left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_afvalid;
	wire         left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_syncreq;
	wire         dsp_ss0_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss0_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss0_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss0_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss0_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss0_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire         dsp_ss1_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss1_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss1_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss1_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss1_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss1_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire         dsp_ss2_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss2_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss2_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss2_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss2_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss2_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire         dsp_ss3_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss3_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss3_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss3_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss3_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss3_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire         dsp_ss4_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss4_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss4_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss4_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss4_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss4_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire         dsp_ss5_top_wrap_TO_left_agg_SIG_m_atvalid    ;
	wire [3:0]   dsp_ss5_top_wrap_TO_left_agg_SIG_m_atbytes    ;
	wire [127:0] dsp_ss5_top_wrap_TO_left_agg_SIG_m_atdata     ;
	wire [6:0]   dsp_ss5_top_wrap_TO_left_agg_SIG_m_atid       ;
	wire         dsp_ss5_top_wrap_TO_left_agg_SIG_m_afready    ;
	wire         dsp_ss5_top_wrap_TO_left_agg_SIG_m_atwakeup   ;
	wire [5:0]   left_funnel_TO_left_agg_SIG_atreadys          ;
	wire [5:0]   left_funnel_TO_left_agg_SIG_afvalids          ;
	wire [5:0]   left_funnel_TO_left_agg_SIG_syncreqs          ;
	wire [5:0]   left_agg_TO_left_funnel_SIG_atvalids          ;
	wire [5:0]   left_agg_TO_left_funnel_SIG_afreadys          ;
	wire [41:0]  left_agg_TO_left_funnel_SIG_atids             ;
	wire [767:0] left_agg_TO_left_funnel_SIG_atdatas           ;
	wire [23:0]  left_agg_TO_left_funnel_SIG_atbytess          ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	atb_iniu_noc dsp_ss0_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_atready),
		.m_atbytes(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_afvalid),
		.m_afready(dsp_ss0_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_syncreq),
		.m_atwakeup(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss0_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss0_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss0_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss0_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss0_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss0_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss0_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss0_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss0_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss0_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss0_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc dsp_ss1_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_atready),
		.m_atbytes(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_afvalid),
		.m_afready(dsp_ss1_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_syncreq),
		.m_atwakeup(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss1_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss1_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss1_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss1_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss1_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss1_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss1_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss1_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss1_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss1_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss1_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc dsp_ss2_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_atready),
		.m_atbytes(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_afvalid),
		.m_afready(dsp_ss2_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_syncreq),
		.m_atwakeup(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss2_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss2_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss2_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss2_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss2_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss2_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss2_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss2_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss2_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss2_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss2_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc dsp_ss3_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_atready),
		.m_atbytes(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_afvalid),
		.m_afready(dsp_ss3_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_syncreq),
		.m_atwakeup(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss3_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss3_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss3_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss3_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss3_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss3_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss3_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss3_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss3_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss3_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss3_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc dsp_ss4_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_atready),
		.m_atbytes(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_afvalid),
		.m_afready(dsp_ss4_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_syncreq),
		.m_atwakeup(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss4_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss4_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss4_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss4_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss4_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss4_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss4_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss4_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss4_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss4_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss4_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc dsp_ss5_top_wrap (
		.clk_atb_m(clk_up_func),
		.rstn_atb_m(rst_up_func_n),
		.m_atvalid(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atvalid),
		.m_atready(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_atready),
		.m_atbytes(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atbytes),
		.m_atdata(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atdata),
		.m_atid(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atid),
		.m_afvalid(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_afvalid),
		.m_afready(dsp_ss5_top_wrap_TO_left_agg_SIG_m_afready),
		.m_syncreq(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_syncreq),
		.m_atwakeup(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.syncreq_level(dsp_ss5_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(dsp_ss5_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(dsp_ss5_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(dsp_ss5_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(dsp_ss5_top_node_async_fifo_porting_wptr_async),
		.rptr_async(dsp_ss5_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(dsp_ss5_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(dsp_ss5_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(dsp_ss5_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(dsp_ss5_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(dsp_ss5_top_node_timeout_val_porting_timeout_val));
	atb_funnel_ingress_aggregator_6to1 left_agg (
		.ch0_m_atvalid(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch0_m_atready(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_atready),
		.ch0_m_atbytes(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch0_m_atdata(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch0_m_atid(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atid),
		.ch0_m_afvalid(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_afvalid),
		.ch0_m_afready(dsp_ss0_top_wrap_TO_left_agg_SIG_m_afready),
		.ch0_m_syncreq(left_agg_TO_dsp_ss0_top_wrap_SIG_ch0_m_syncreq),
		.ch0_m_atwakeup(dsp_ss0_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.ch1_m_atvalid(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch1_m_atready(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_atready),
		.ch1_m_atbytes(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch1_m_atdata(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch1_m_atid(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atid),
		.ch1_m_afvalid(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_afvalid),
		.ch1_m_afready(dsp_ss1_top_wrap_TO_left_agg_SIG_m_afready),
		.ch1_m_syncreq(left_agg_TO_dsp_ss1_top_wrap_SIG_ch1_m_syncreq),
		.ch1_m_atwakeup(dsp_ss1_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.ch2_m_atvalid(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch2_m_atready(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_atready),
		.ch2_m_atbytes(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch2_m_atdata(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch2_m_atid(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atid),
		.ch2_m_afvalid(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_afvalid),
		.ch2_m_afready(dsp_ss2_top_wrap_TO_left_agg_SIG_m_afready),
		.ch2_m_syncreq(left_agg_TO_dsp_ss2_top_wrap_SIG_ch2_m_syncreq),
		.ch2_m_atwakeup(dsp_ss2_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.ch3_m_atvalid(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch3_m_atready(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_atready),
		.ch3_m_atbytes(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch3_m_atdata(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch3_m_atid(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atid),
		.ch3_m_afvalid(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_afvalid),
		.ch3_m_afready(dsp_ss3_top_wrap_TO_left_agg_SIG_m_afready),
		.ch3_m_syncreq(left_agg_TO_dsp_ss3_top_wrap_SIG_ch3_m_syncreq),
		.ch3_m_atwakeup(dsp_ss3_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.ch4_m_atvalid(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch4_m_atready(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_atready),
		.ch4_m_atbytes(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch4_m_atdata(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch4_m_atid(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atid),
		.ch4_m_afvalid(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_afvalid),
		.ch4_m_afready(dsp_ss4_top_wrap_TO_left_agg_SIG_m_afready),
		.ch4_m_syncreq(left_agg_TO_dsp_ss4_top_wrap_SIG_ch4_m_syncreq),
		.ch4_m_atwakeup(dsp_ss4_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.ch5_m_atvalid(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atvalid),
		.ch5_m_atready(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_atready),
		.ch5_m_atbytes(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atbytes),
		.ch5_m_atdata(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atdata),
		.ch5_m_atid(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atid),
		.ch5_m_afvalid(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_afvalid),
		.ch5_m_afready(dsp_ss5_top_wrap_TO_left_agg_SIG_m_afready),
		.ch5_m_syncreq(left_agg_TO_dsp_ss5_top_wrap_SIG_ch5_m_syncreq),
		.ch5_m_atwakeup(dsp_ss5_top_wrap_TO_left_agg_SIG_m_atwakeup),
		.atvalids(left_agg_TO_left_funnel_SIG_atvalids),
		.afreadys(left_agg_TO_left_funnel_SIG_afreadys),
		.atids(left_agg_TO_left_funnel_SIG_atids),
		.atdatas(left_agg_TO_left_funnel_SIG_atdatas),
		.atbytess(left_agg_TO_left_funnel_SIG_atbytess),
		.atreadys(left_funnel_TO_left_agg_SIG_atreadys),
		.afvalids(left_funnel_TO_left_agg_SIG_afvalids),
		.syncreqs(left_funnel_TO_left_agg_SIG_syncreqs));
	atb_funnel left_funnel (
		.clk(clk_up_func),
		.resetn(rst_up_func_n),
		.pclkendbg(left_funnel_node_pclkendbg_porting_pclkendbg),
		.pseldbg(left_funnel_node_pseldbg_porting_pseldbg),
		.penabledbg(left_funnel_node_penabledbg_porting_penabledbg),
		.pwritedbg(left_funnel_node_pwritedbg_porting_pwritedbg),
		.paddrdbg31(left_funnel_node_paddrdbg31_porting_paddrdbg31),
		.paddrdbg(left_funnel_node_paddrdbg_porting_paddrdbg),
		.pwdatadbg(left_funnel_node_pwdatadbg_porting_pwdatadbg),
		.atvalids(left_agg_TO_left_funnel_SIG_atvalids),
		.afreadys(left_agg_TO_left_funnel_SIG_afreadys),
		.atids(left_agg_TO_left_funnel_SIG_atids),
		.atdatas(left_agg_TO_left_funnel_SIG_atdatas),
		.atbytess(left_agg_TO_left_funnel_SIG_atbytess),
		.atreadym(left_funnel_node_atreadym_porting_atreadym),
		.afvalidm(left_funnel_node_afvalidm_porting_afvalidm),
		.syncreqm(left_funnel_node_syncreqm_porting_syncreqm),
		.preadydbg(left_funnel_node_preadydbg_porting_preadydbg),
		.pslverrdbg(left_funnel_node_pslverrdbg_porting_pslverrdbg),
		.prdatadbg(left_funnel_node_prdatadbg_porting_prdatadbg),
		.atvalidm(left_funnel_node_atvalidm_porting_atvalidm),
		.afreadym(left_funnel_node_afreadym_porting_afreadym),
		.atidm(left_funnel_node_atidm_porting_atidm),
		.atdatam(left_funnel_node_atdatam_porting_atdatam),
		.atbytesm(left_funnel_node_atbytesm_porting_atbytesm),
		.atreadys(left_funnel_TO_left_agg_SIG_atreadys),
		.afvalids(left_funnel_TO_left_agg_SIG_afvalids),
		.syncreqs(left_funnel_TO_left_agg_SIG_syncreqs));
	network_atb_slv async_bridge_slv_side (
		.clk_atb_s(async_bridge_slv_node_slv_clk_porting_clk_atb_s),
		.rstn_atb_s(async_bridge_slv_node_slv_rst_n_porting_rstn_atb_s),
		.s_atvalid(async_bridge_slv_node_s_chan_porting_s_atvalid),
		.s_atready(async_bridge_slv_node_s_chan_porting_s_atready),
		.s_atbytes(async_bridge_slv_node_s_chan_porting_s_atbytes),
		.s_atdata(async_bridge_slv_node_s_chan_porting_s_atdata),
		.s_atid(async_bridge_slv_node_s_chan_porting_s_atid),
		.s_afvalid(async_bridge_slv_node_s_chan_porting_s_afvalid),
		.s_afready(async_bridge_slv_node_s_chan_porting_s_afready),
		.s_syncreq(async_bridge_slv_node_s_chan_porting_s_syncreq),
		.s_atwakeup(async_bridge_slv_node_s_chan_porting_s_atwakeup),
		.flush_req(async_bridge_slv_node_flush_req_porting_flush_req),
		.syncreq_level(async_bridge_slv_node_sync_porting_syncreq_level),
		.afifo_slv_full_zero(async_bridge_slv_node_afifo_slv_full_zero_porting_afifo_slv_full_zero),
		.wptr_async(async_bridge_slv_node_sync_porting_wptr_async),
		.rptr_async(async_bridge_slv_node_sync_porting_rptr_async),
		.rptr_sync(async_bridge_slv_node_sync_porting_rptr_sync),
		.pld_sync(async_bridge_slv_node_sync_porting_pld_sync));

endmodule
//[UHDL]Content End [md5:8cf5da9a7eef8ea2a8692dd6557754c7]


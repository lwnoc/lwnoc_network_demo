//[UHDL]Content Start [md5:b0732482b8f08552ab3e1d486c2bfe2a]
module atb_dn_harden (
	input          clk_dn_func                                                          ,
	input          rst_dn_func_n                                                        ,
	input          async_bridge_mst_node_mst_clk_porting_clk_atb_m                      ,
	input          async_bridge_mst_node_mst_rst_n_porting_rstn_atb_m                   ,
	output         async_bridge_mst_node_m_chan_porting_m_afready                       ,
	input          async_bridge_mst_node_m_chan_porting_m_afvalid                       ,
	output [2:0]   async_bridge_mst_node_m_chan_porting_m_atbytes                       ,
	output [63:0]  async_bridge_mst_node_m_chan_porting_m_atdata                        ,
	output [6:0]   async_bridge_mst_node_m_chan_porting_m_atid                          ,
	input          async_bridge_mst_node_m_chan_porting_m_atready                       ,
	output         async_bridge_mst_node_m_chan_porting_m_atvalid                       ,
	output         async_bridge_mst_node_m_chan_porting_m_atwakeup                      ,
	input          async_bridge_mst_node_m_chan_porting_m_syncreq                       ,
	input  [77:0]  async_bridge_mst_node_sync_porting_pld_sync                          ,
	output [15:0]  async_bridge_mst_node_sync_porting_rptr_async                        ,
	output [15:0]  async_bridge_mst_node_sync_porting_rptr_sync                         ,
	output         async_bridge_mst_node_sync_porting_syncreq_level                     ,
	input  [15:0]  async_bridge_mst_node_sync_porting_wptr_async                        ,
	output         async_bridge_mst_node_afifo_mst_full_zero_porting_afifo_mst_full_zero,
	output         async_bridge_mst_node_afifo_mst_read_idle_porting_afifo_mst_read_idle,
	output         async_bridge_mst_node_flush_req_level_porting_flush_req_level        ,
	input          right_agg_agg_node_ch2_chan_porting_ch2_m_afready                    ,
	output         right_agg_agg_node_ch2_chan_porting_ch2_m_afvalid                    ,
	input  [3:0]   right_agg_agg_node_ch2_chan_porting_ch2_m_atbytes                    ,
	input  [127:0] right_agg_agg_node_ch2_chan_porting_ch2_m_atdata                     ,
	input  [6:0]   right_agg_agg_node_ch2_chan_porting_ch2_m_atid                       ,
	output         right_agg_agg_node_ch2_chan_porting_ch2_m_atready                    ,
	input          right_agg_agg_node_ch2_chan_porting_ch2_m_atvalid                    ,
	input          right_agg_agg_node_ch2_chan_porting_ch2_m_atwakeup                   ,
	output         right_agg_agg_node_ch2_chan_porting_ch2_m_syncreq                    ,
	input          right_funnel_node_atreadym_porting_atreadym                          ,
	input          right_funnel_node_afvalidm_porting_afvalidm                          ,
	input          right_funnel_node_syncreqm_porting_syncreqm                          ,
	output         right_funnel_node_atvalidm_porting_atvalidm                          ,
	output         right_funnel_node_afreadym_porting_afreadym                          ,
	output [6:0]   right_funnel_node_atidm_porting_atidm                                ,
	output [127:0] right_funnel_node_atdatam_porting_atdatam                            ,
	output [3:0]   right_funnel_node_atbytesm_porting_atbytesm                          ,
	input          right_funnel_node_pclkendbg_porting_pclkendbg                        ,
	input          right_funnel_node_pseldbg_porting_pseldbg                            ,
	input          right_funnel_node_penabledbg_porting_penabledbg                      ,
	input          right_funnel_node_pwritedbg_porting_pwritedbg                        ,
	input          right_funnel_node_paddrdbg31_porting_paddrdbg31                      ,
	input  [9:0]   right_funnel_node_paddrdbg_porting_paddrdbg                          ,
	input  [31:0]  right_funnel_node_pwdatadbg_porting_pwdatadbg                        ,
	output         right_funnel_node_preadydbg_porting_preadydbg                        ,
	output         right_funnel_node_pslverrdbg_porting_pslverrdbg                      ,
	output [31:0]  right_funnel_node_prdatadbg_porting_prdatadbg                        ,
	output         camera_ss_top_node_sync_ctrl_porting_flush_req_level                 ,
	output         camera_ss_top_node_sync_ctrl_porting_syncreq_level                   ,
	input  [12:0]  camera_ss_top_node_lp_afifo_rx_porting_afifo_mst_rx_req              ,
	output [12:0]  camera_ss_top_node_lp_afifo_tx_porting_afifo_mst_tx_req              ,
	input  [142:0] camera_ss_top_node_async_fifo_porting_pld_sync                       ,
	output [15:0]  camera_ss_top_node_async_fifo_porting_rptr_async                     ,
	output [15:0]  camera_ss_top_node_async_fifo_porting_rptr_sync                      ,
	input  [15:0]  camera_ss_top_node_async_fifo_porting_wptr_async                     ,
	input  [12:0]  camera_ss_top_node_lp_rx_porting_lw_rx_req                           ,
	output [12:0]  camera_ss_top_node_lp_tx_porting_lw_tx_req                           ,
	input  [9:0]   camera_ss_top_node_timeout_val_porting_timeout_val                   ,
	output         mipi_ss_top_node_sync_ctrl_porting_flush_req_level                   ,
	output         mipi_ss_top_node_sync_ctrl_porting_syncreq_level                     ,
	input  [12:0]  mipi_ss_top_node_lp_afifo_rx_porting_afifo_mst_rx_req                ,
	output [12:0]  mipi_ss_top_node_lp_afifo_tx_porting_afifo_mst_tx_req                ,
	input  [142:0] mipi_ss_top_node_async_fifo_porting_pld_sync                         ,
	output [15:0]  mipi_ss_top_node_async_fifo_porting_rptr_async                       ,
	output [15:0]  mipi_ss_top_node_async_fifo_porting_rptr_sync                        ,
	input  [15:0]  mipi_ss_top_node_async_fifo_porting_wptr_async                       ,
	input  [12:0]  mipi_ss_top_node_lp_rx_porting_lw_rx_req                             ,
	output [12:0]  mipi_ss_top_node_lp_tx_porting_lw_tx_req                             ,
	input  [9:0]   mipi_ss_top_node_timeout_val_porting_timeout_val                     ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_afready                      ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_afvalid                      ,
	input  [3:0]   debug_tniu_ss_top_node_s_chan_porting_s_atbytes                      ,
	input  [127:0] debug_tniu_ss_top_node_s_chan_porting_s_atdata                       ,
	input  [6:0]   debug_tniu_ss_top_node_s_chan_porting_s_atid                         ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_atready                      ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_atvalid                      ,
	input          debug_tniu_ss_top_node_s_chan_porting_s_atwakeup                     ,
	output         debug_tniu_ss_top_node_s_chan_porting_s_syncreq                      ,
	input          debug_tniu_ss_top_node_flush_req_porting_flush_req                   ,
	output [142:0] debug_tniu_ss_top_node_async_fifo_porting_pld_sync                   ,
	input  [15:0]  debug_tniu_ss_top_node_async_fifo_porting_rptr_async                 ,
	input  [15:0]  debug_tniu_ss_top_node_async_fifo_porting_rptr_sync                  ,
	output [15:0]  debug_tniu_ss_top_node_async_fifo_porting_wptr_async                 ,
	input          debug_tniu_ss_top_node_syncreq_level_porting_syncreq_level           ,
	input  [12:0]  debug_tniu_ss_top_node_lp_lw_porting_lw_rx_req                       ,
	output [12:0]  debug_tniu_ss_top_node_lp_lw_porting_lw_tx_req                       ,
	input  [12:0]  debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_rx_req             ,
	output [12:0]  debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_tx_req             ,
	input  [9:0]   debug_tniu_ss_top_node_timeout_val_porting_timeout_val               );

	//Wire define for this module.

	//Wire define for sub module.
	wire         camera_ss_top_wrap_TO_right_agg_SIG_m_atvalid    ;
	wire [3:0]   camera_ss_top_wrap_TO_right_agg_SIG_m_atbytes    ;
	wire [127:0] camera_ss_top_wrap_TO_right_agg_SIG_m_atdata     ;
	wire [6:0]   camera_ss_top_wrap_TO_right_agg_SIG_m_atid       ;
	wire         camera_ss_top_wrap_TO_right_agg_SIG_m_afready    ;
	wire         camera_ss_top_wrap_TO_right_agg_SIG_m_atwakeup   ;
	wire         mipi_ss_top_wrap_TO_right_agg_SIG_m_atvalid      ;
	wire [3:0]   mipi_ss_top_wrap_TO_right_agg_SIG_m_atbytes      ;
	wire [127:0] mipi_ss_top_wrap_TO_right_agg_SIG_m_atdata       ;
	wire [6:0]   mipi_ss_top_wrap_TO_right_agg_SIG_m_atid         ;
	wire         mipi_ss_top_wrap_TO_right_agg_SIG_m_afready      ;
	wire         mipi_ss_top_wrap_TO_right_agg_SIG_m_atwakeup     ;
	wire [2:0]   right_funnel_TO_right_agg_SIG_atreadys           ;
	wire [2:0]   right_funnel_TO_right_agg_SIG_afvalids           ;
	wire [2:0]   right_funnel_TO_right_agg_SIG_syncreqs           ;
	wire [2:0]   right_agg_TO_right_funnel_SIG_atvalids           ;
	wire [2:0]   right_agg_TO_right_funnel_SIG_afreadys           ;
	wire [20:0]  right_agg_TO_right_funnel_SIG_atids              ;
	wire [383:0] right_agg_TO_right_funnel_SIG_atdatas            ;
	wire [11:0]  right_agg_TO_right_funnel_SIG_atbytess           ;
	wire         right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_atready;
	wire         right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_afvalid;
	wire         right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_syncreq;
	wire         right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_atready  ;
	wire         right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_afvalid  ;
	wire         right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_syncreq  ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	network_atb_mst async_bridge_mst_side (
		.clk_atb_m(async_bridge_mst_node_mst_clk_porting_clk_atb_m),
		.rstn_atb_m(async_bridge_mst_node_mst_rst_n_porting_rstn_atb_m),
		.m_atvalid(async_bridge_mst_node_m_chan_porting_m_atvalid),
		.m_atready(async_bridge_mst_node_m_chan_porting_m_atready),
		.m_atbytes(async_bridge_mst_node_m_chan_porting_m_atbytes),
		.m_atdata(async_bridge_mst_node_m_chan_porting_m_atdata),
		.m_atid(async_bridge_mst_node_m_chan_porting_m_atid),
		.m_afvalid(async_bridge_mst_node_m_chan_porting_m_afvalid),
		.m_afready(async_bridge_mst_node_m_chan_porting_m_afready),
		.m_syncreq(async_bridge_mst_node_m_chan_porting_m_syncreq),
		.m_atwakeup(async_bridge_mst_node_m_chan_porting_m_atwakeup),
		.syncreq_level(async_bridge_mst_node_sync_porting_syncreq_level),
		.flush_req_level(async_bridge_mst_node_flush_req_level_porting_flush_req_level),
		.afifo_mst_full_zero(async_bridge_mst_node_afifo_mst_full_zero_porting_afifo_mst_full_zero),
		.afifo_mst_read_idle(async_bridge_mst_node_afifo_mst_read_idle_porting_afifo_mst_read_idle),
		.wptr_async(async_bridge_mst_node_sync_porting_wptr_async),
		.rptr_async(async_bridge_mst_node_sync_porting_rptr_async),
		.rptr_sync(async_bridge_mst_node_sync_porting_rptr_sync),
		.pld_sync(async_bridge_mst_node_sync_porting_pld_sync));
	atb_funnel_ingress_aggregator_3to1 right_agg (
		.ch0_m_atvalid(camera_ss_top_wrap_TO_right_agg_SIG_m_atvalid),
		.ch0_m_atready(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_atready),
		.ch0_m_atbytes(camera_ss_top_wrap_TO_right_agg_SIG_m_atbytes),
		.ch0_m_atdata(camera_ss_top_wrap_TO_right_agg_SIG_m_atdata),
		.ch0_m_atid(camera_ss_top_wrap_TO_right_agg_SIG_m_atid),
		.ch0_m_afvalid(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_afvalid),
		.ch0_m_afready(camera_ss_top_wrap_TO_right_agg_SIG_m_afready),
		.ch0_m_syncreq(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_syncreq),
		.ch0_m_atwakeup(camera_ss_top_wrap_TO_right_agg_SIG_m_atwakeup),
		.ch1_m_atvalid(mipi_ss_top_wrap_TO_right_agg_SIG_m_atvalid),
		.ch1_m_atready(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_atready),
		.ch1_m_atbytes(mipi_ss_top_wrap_TO_right_agg_SIG_m_atbytes),
		.ch1_m_atdata(mipi_ss_top_wrap_TO_right_agg_SIG_m_atdata),
		.ch1_m_atid(mipi_ss_top_wrap_TO_right_agg_SIG_m_atid),
		.ch1_m_afvalid(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_afvalid),
		.ch1_m_afready(mipi_ss_top_wrap_TO_right_agg_SIG_m_afready),
		.ch1_m_syncreq(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_syncreq),
		.ch1_m_atwakeup(mipi_ss_top_wrap_TO_right_agg_SIG_m_atwakeup),
		.ch2_m_atvalid(right_agg_agg_node_ch2_chan_porting_ch2_m_atvalid),
		.ch2_m_atready(right_agg_agg_node_ch2_chan_porting_ch2_m_atready),
		.ch2_m_atbytes(right_agg_agg_node_ch2_chan_porting_ch2_m_atbytes),
		.ch2_m_atdata(right_agg_agg_node_ch2_chan_porting_ch2_m_atdata),
		.ch2_m_atid(right_agg_agg_node_ch2_chan_porting_ch2_m_atid),
		.ch2_m_afvalid(right_agg_agg_node_ch2_chan_porting_ch2_m_afvalid),
		.ch2_m_afready(right_agg_agg_node_ch2_chan_porting_ch2_m_afready),
		.ch2_m_syncreq(right_agg_agg_node_ch2_chan_porting_ch2_m_syncreq),
		.ch2_m_atwakeup(right_agg_agg_node_ch2_chan_porting_ch2_m_atwakeup),
		.atvalids(right_agg_TO_right_funnel_SIG_atvalids),
		.afreadys(right_agg_TO_right_funnel_SIG_afreadys),
		.atids(right_agg_TO_right_funnel_SIG_atids),
		.atdatas(right_agg_TO_right_funnel_SIG_atdatas),
		.atbytess(right_agg_TO_right_funnel_SIG_atbytess),
		.atreadys(right_funnel_TO_right_agg_SIG_atreadys),
		.afvalids(right_funnel_TO_right_agg_SIG_afvalids),
		.syncreqs(right_funnel_TO_right_agg_SIG_syncreqs));
	atb_funnel right_funnel (
		.clk(clk_dn_func),
		.resetn(rst_dn_func_n),
		.pclkendbg(right_funnel_node_pclkendbg_porting_pclkendbg),
		.pseldbg(right_funnel_node_pseldbg_porting_pseldbg),
		.penabledbg(right_funnel_node_penabledbg_porting_penabledbg),
		.pwritedbg(right_funnel_node_pwritedbg_porting_pwritedbg),
		.paddrdbg31(right_funnel_node_paddrdbg31_porting_paddrdbg31),
		.paddrdbg(right_funnel_node_paddrdbg_porting_paddrdbg),
		.pwdatadbg(right_funnel_node_pwdatadbg_porting_pwdatadbg),
		.atvalids(right_agg_TO_right_funnel_SIG_atvalids),
		.afreadys(right_agg_TO_right_funnel_SIG_afreadys),
		.atids(right_agg_TO_right_funnel_SIG_atids),
		.atdatas(right_agg_TO_right_funnel_SIG_atdatas),
		.atbytess(right_agg_TO_right_funnel_SIG_atbytess),
		.atreadym(right_funnel_node_atreadym_porting_atreadym),
		.afvalidm(right_funnel_node_afvalidm_porting_afvalidm),
		.syncreqm(right_funnel_node_syncreqm_porting_syncreqm),
		.preadydbg(right_funnel_node_preadydbg_porting_preadydbg),
		.pslverrdbg(right_funnel_node_pslverrdbg_porting_pslverrdbg),
		.prdatadbg(right_funnel_node_prdatadbg_porting_prdatadbg),
		.atvalidm(right_funnel_node_atvalidm_porting_atvalidm),
		.afreadym(right_funnel_node_afreadym_porting_afreadym),
		.atidm(right_funnel_node_atidm_porting_atidm),
		.atdatam(right_funnel_node_atdatam_porting_atdatam),
		.atbytesm(right_funnel_node_atbytesm_porting_atbytesm),
		.atreadys(right_funnel_TO_right_agg_SIG_atreadys),
		.afvalids(right_funnel_TO_right_agg_SIG_afvalids),
		.syncreqs(right_funnel_TO_right_agg_SIG_syncreqs));
	atb_iniu_noc camera_ss_top_wrap (
		.clk_atb_m(clk_dn_func),
		.rstn_atb_m(rst_dn_func_n),
		.m_atvalid(camera_ss_top_wrap_TO_right_agg_SIG_m_atvalid),
		.m_atready(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_atready),
		.m_atbytes(camera_ss_top_wrap_TO_right_agg_SIG_m_atbytes),
		.m_atdata(camera_ss_top_wrap_TO_right_agg_SIG_m_atdata),
		.m_atid(camera_ss_top_wrap_TO_right_agg_SIG_m_atid),
		.m_afvalid(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_afvalid),
		.m_afready(camera_ss_top_wrap_TO_right_agg_SIG_m_afready),
		.m_syncreq(right_agg_TO_camera_ss_top_wrap_SIG_ch0_m_syncreq),
		.m_atwakeup(camera_ss_top_wrap_TO_right_agg_SIG_m_atwakeup),
		.syncreq_level(camera_ss_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(camera_ss_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(camera_ss_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(camera_ss_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(camera_ss_top_node_async_fifo_porting_wptr_async),
		.rptr_async(camera_ss_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(camera_ss_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(camera_ss_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(camera_ss_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(camera_ss_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(camera_ss_top_node_timeout_val_porting_timeout_val));
	atb_iniu_noc mipi_ss_top_wrap (
		.clk_atb_m(clk_dn_func),
		.rstn_atb_m(rst_dn_func_n),
		.m_atvalid(mipi_ss_top_wrap_TO_right_agg_SIG_m_atvalid),
		.m_atready(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_atready),
		.m_atbytes(mipi_ss_top_wrap_TO_right_agg_SIG_m_atbytes),
		.m_atdata(mipi_ss_top_wrap_TO_right_agg_SIG_m_atdata),
		.m_atid(mipi_ss_top_wrap_TO_right_agg_SIG_m_atid),
		.m_afvalid(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_afvalid),
		.m_afready(mipi_ss_top_wrap_TO_right_agg_SIG_m_afready),
		.m_syncreq(right_agg_TO_mipi_ss_top_wrap_SIG_ch1_m_syncreq),
		.m_atwakeup(mipi_ss_top_wrap_TO_right_agg_SIG_m_atwakeup),
		.syncreq_level(mipi_ss_top_node_sync_ctrl_porting_syncreq_level),
		.flush_req_level(mipi_ss_top_node_sync_ctrl_porting_flush_req_level),
		.afifo_mst_rx_req(mipi_ss_top_node_lp_afifo_rx_porting_afifo_mst_rx_req),
		.afifo_mst_tx_req(mipi_ss_top_node_lp_afifo_tx_porting_afifo_mst_tx_req),
		.wptr_async(mipi_ss_top_node_async_fifo_porting_wptr_async),
		.rptr_async(mipi_ss_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(mipi_ss_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(mipi_ss_top_node_async_fifo_porting_pld_sync),
		.lw_rx_req(mipi_ss_top_node_lp_rx_porting_lw_rx_req),
		.lw_tx_req(mipi_ss_top_node_lp_tx_porting_lw_tx_req),
		.timeout_val(mipi_ss_top_node_timeout_val_porting_timeout_val));
	atb_tniu_noc debug_tniu_top_wrap (
		.clk_atb_s(clk_dn_func),
		.rstn_atb_s(rst_dn_func_n),
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
		.wptr_async(debug_tniu_ss_top_node_async_fifo_porting_wptr_async),
		.rptr_async(debug_tniu_ss_top_node_async_fifo_porting_rptr_async),
		.rptr_sync(debug_tniu_ss_top_node_async_fifo_porting_rptr_sync),
		.pld_sync(debug_tniu_ss_top_node_async_fifo_porting_pld_sync),
		.syncreq_level(debug_tniu_ss_top_node_syncreq_level_porting_syncreq_level),
		.lw_rx_req(debug_tniu_ss_top_node_lp_lw_porting_lw_rx_req),
		.lw_tx_req(debug_tniu_ss_top_node_lp_lw_porting_lw_tx_req),
		.afifo_slv_rx_req(debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_rx_req),
		.afifo_slv_tx_req(debug_tniu_ss_top_node_lp_afifo_porting_afifo_slv_tx_req),
		.timeout_val(debug_tniu_ss_top_node_timeout_val_porting_timeout_val));

endmodule
//[UHDL]Content End [md5:b0732482b8f08552ab3e1d486c2bfe2a]


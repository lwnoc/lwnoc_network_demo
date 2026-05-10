//[UHDL]Content Start [md5:a107dc761661c9342247bc24ccde3014]
module atb_soc_top_wrap (
	output         dsp_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         dsp_ss1_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss1_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss1_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss1_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss1_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss1_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss1_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss1_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         dsp_ss2_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss2_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss2_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss2_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss2_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss2_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss2_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss2_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         dsp_ss3_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss3_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss3_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss3_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss3_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss3_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss3_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss3_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         dsp_ss4_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss4_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss4_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss4_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss4_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss4_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss4_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss4_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         dsp_ss5_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         dsp_ss5_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  dsp_ss5_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  dsp_ss5_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] dsp_ss5_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  dsp_ss5_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  dsp_ss5_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   dsp_ss5_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         camera_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level       ,
	output         camera_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level ,
	input  [12:0]  camera_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req        ,
	output [12:0]  camera_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req        ,
	input  [151:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                  ,
	output [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                ,
	output [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                 ,
	input  [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                ,
	input  [12:0]  camera_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                           ,
	output [12:0]  camera_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                           ,
	input  [9:0]   camera_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val             ,
	output         mipi_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         mipi_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  mipi_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  mipi_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  mipi_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  mipi_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   mipi_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         gpu1_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         gpu1_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  gpu1_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  gpu1_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] gpu1_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  gpu1_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  gpu1_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   gpu1_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         usb_dp_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level       ,
	output         usb_dp_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level ,
	input  [12:0]  usb_dp_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req        ,
	output [12:0]  usb_dp_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req        ,
	input  [151:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                  ,
	output [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                ,
	output [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                 ,
	input  [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                ,
	input  [12:0]  usb_dp_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                           ,
	output [12:0]  usb_dp_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                           ,
	input  [9:0]   usb_dp_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val             ,
	output         display_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level      ,
	output         display_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level,
	input  [12:0]  display_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req       ,
	output [12:0]  display_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req       ,
	input  [151:0] display_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                 ,
	output [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async               ,
	output [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                ,
	input  [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async               ,
	input  [12:0]  display_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                          ,
	output [12:0]  display_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                          ,
	input  [9:0]   display_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val            ,
	output         aon_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,
	output         aon_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,
	input  [12:0]  aon_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,
	output [12:0]  aon_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,
	input  [151:0] aon_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,
	output [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,
	output [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,
	input  [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,
	input  [12:0]  aon_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,
	output [12:0]  aon_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,
	input  [9:0]   aon_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,
	output         gpu_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	output         gpu_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,
	input  [12:0]  gpu_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,
	output [12:0]  gpu_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,
	input  [151:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	output [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	output [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	input  [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input  [12:0]  gpu_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,
	output [12:0]  gpu_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,
	input  [9:0]   gpu_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	output         cpu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,
	output         cpu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,
	input  [12:0]  cpu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,
	output [12:0]  cpu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,
	input  [151:0] cpu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,
	output [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,
	output [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,
	input  [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,
	input  [12:0]  cpu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,
	output [12:0]  cpu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,
	input  [9:0]   cpu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,
	output         mcu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,
	output         mcu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,
	input  [12:0]  mcu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,
	output [12:0]  mcu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,
	input  [151:0] mcu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,
	output [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,
	output [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,
	input  [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,
	input  [12:0]  mcu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,
	output [12:0]  mcu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,
	input  [9:0]   mcu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,
	input          peri_ss_top_wrap_flush_req_porting_flush_req_flush_req                     ,
	output [151:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,
	input  [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,
	input  [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,
	output [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,
	input          peri_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,
	input  [12:0]  peri_ss_top_wrap_lp_lw_rx_porting_lp_lw_rx_lw_rx_req                       ,
	output [12:0]  peri_ss_top_wrap_lp_lw_tx_porting_lp_lw_tx_lw_tx_req                       ,
	input  [12:0]  peri_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_slv_rx_req          ,
	output [12:0]  peri_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_slv_tx_req          ,
	input  [9:0]   peri_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,
	input          u_aon_ss_clk_noc_porting                                                   ,
	input          u_aon_ss_rst_noc_n_porting                                                 );

	//Wire define for this module.

	//Wire define for sub module.
	wire         u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_syncreq         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_syncreq         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_syncreq         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_syncreq         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_syncreq         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_afvalid         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_atready         ;
	wire         u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_syncreq         ;
	wire         u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_afvalid       ;
	wire         u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_atready       ;
	wire         u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_syncreq       ;
	wire         u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_afvalid         ;
	wire         u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_atready         ;
	wire         u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_syncreq         ;
	wire         u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_afvalid         ;
	wire         u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_atready         ;
	wire         u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_syncreq         ;
	wire         u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_afvalid       ;
	wire         u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_atready       ;
	wire         u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_syncreq       ;
	wire         u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_afvalid      ;
	wire         u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_atready      ;
	wire         u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_syncreq      ;
	wire         u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_afvalid          ;
	wire         u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_atready          ;
	wire         u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_syncreq          ;
	wire         u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_afvalid          ;
	wire         u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_atready          ;
	wire         u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_syncreq          ;
	wire         u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_afvalid           ;
	wire         u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_atready           ;
	wire         u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_syncreq           ;
	wire         u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_afvalid           ;
	wire         u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_atready           ;
	wire         u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_syncreq           ;
	wire         u_left_top_funnel0_TO_u_peri_ss_SIG_m_afready              ;
	wire [3:0]   u_left_top_funnel0_TO_u_peri_ss_SIG_m_atbytes              ;
	wire [127:0] u_left_top_funnel0_TO_u_peri_ss_SIG_m_atdata               ;
	wire [6:0]   u_left_top_funnel0_TO_u_peri_ss_SIG_m_atid                 ;
	wire         u_left_top_funnel0_TO_u_peri_ss_SIG_m_atvalid              ;
	wire         u_left_top_funnel0_TO_u_peri_ss_SIG_m_atwakeup             ;
	wire         u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid         ;
	wire         u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready      ;
	wire         u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_atready;
	wire         u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_afvalid;
	wire         u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_syncreq;
	wire         u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid    ;
	wire [3:0]   u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes    ;
	wire [127:0] u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata     ;
	wire [6:0]   u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid       ;
	wire         u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready    ;
	wire         u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup   ;
	wire         u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid         ;
	wire         u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready      ;
	wire         u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid      ;
	wire [3:0]   u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes      ;
	wire [127:0] u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata       ;
	wire [6:0]   u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid         ;
	wire         u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready      ;
	wire         u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup     ;
	wire         u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid    ;
	wire [3:0]   u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes    ;
	wire [127:0] u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata     ;
	wire [6:0]   u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid       ;
	wire         u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready    ;
	wire         u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup   ;
	wire         u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid   ;
	wire [3:0]   u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes   ;
	wire [127:0] u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata    ;
	wire [6:0]   u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid      ;
	wire         u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready   ;
	wire         u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup  ;
	wire         u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid       ;
	wire [3:0]   u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes       ;
	wire [127:0] u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata        ;
	wire [6:0]   u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid          ;
	wire         u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready       ;
	wire         u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup      ;
	wire         u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_atready;
	wire         u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_afvalid;
	wire         u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_syncreq;
	wire         u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid       ;
	wire [3:0]   u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes       ;
	wire [127:0] u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atdata        ;
	wire [6:0]   u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atid          ;
	wire         u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_afready       ;
	wire         u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup      ;
	wire         u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid        ;
	wire [3:0]   u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes        ;
	wire [127:0] u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata         ;
	wire [6:0]   u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid           ;
	wire         u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready        ;
	wire         u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup       ;
	wire         u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid    ;
	wire [3:0]   u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes    ;
	wire [127:0] u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atdata     ;
	wire [6:0]   u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atid       ;
	wire         u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_afready    ;
	wire         u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup   ;
	wire         u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid    ;
	wire [3:0]   u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes    ;
	wire [127:0] u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atdata     ;
	wire [6:0]   u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atid       ;
	wire         u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_afready    ;
	wire         u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup   ;
	wire         u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid        ;
	wire [3:0]   u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes        ;
	wire [127:0] u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata         ;
	wire [6:0]   u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid           ;
	wire         u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready        ;
	wire         u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup       ;
	wire         u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_atready   ;
	wire         u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_afvalid   ;
	wire         u_peri_ss_TO_u_left_top_funnel0_SIG_s_syncreq_s_syncreq    ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dsp_ss0_top_wrap u_dsp_ss0 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_atready),
		.m_chan_m_atvalid(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	dsp_ss1_top_wrap u_dsp_ss1 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_atready),
		.m_chan_m_atvalid(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss1_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss1_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss1_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss1_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss1_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss1_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss1_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss1_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss1_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	dsp_ss2_top_wrap u_dsp_ss2 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_atready),
		.m_chan_m_atvalid(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss2_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss2_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss2_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss2_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss2_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss2_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss2_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss2_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss2_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	dsp_ss3_top_wrap u_dsp_ss3 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_atready),
		.m_chan_m_atvalid(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss3_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss3_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss3_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss3_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss3_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss3_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss3_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss3_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss3_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	dsp_ss4_top_wrap u_dsp_ss4 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_atready),
		.m_chan_m_atvalid(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss4_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss4_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss4_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss4_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss4_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss4_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss4_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss4_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss4_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	dsp_ss5_top_wrap u_dsp_ss5 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_afvalid),
		.m_chan_m_atbytes(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_atready),
		.m_chan_m_atvalid(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_syncreq),
		.syncreq_level_syncreq_level(dsp_ss5_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(dsp_ss5_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(dsp_ss5_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(dsp_ss5_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(dsp_ss5_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss5_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(dsp_ss5_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(dsp_ss5_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(dsp_ss5_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	camera_ss_top_wrap u_camera_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_afvalid),
		.m_chan_m_atbytes(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_atready),
		.m_chan_m_atvalid(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_syncreq),
		.syncreq_level_syncreq_level(camera_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(camera_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(camera_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(camera_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(camera_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(camera_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(camera_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	mipi_ss_top_wrap u_mipi_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_afvalid),
		.m_chan_m_atbytes(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_atready),
		.m_chan_m_atvalid(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_syncreq),
		.syncreq_level_syncreq_level(mipi_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(mipi_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(mipi_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(mipi_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(mipi_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(mipi_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(mipi_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	gpu1_ss_top_wrap u_gpu1_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_afvalid),
		.m_chan_m_atbytes(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_atready),
		.m_chan_m_atvalid(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_syncreq),
		.syncreq_level_syncreq_level(gpu1_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(gpu1_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(gpu1_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(gpu1_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(gpu1_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu1_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(gpu1_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(gpu1_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(gpu1_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	usb_dp_ss_top_wrap u_usb_dp_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_afvalid),
		.m_chan_m_atbytes(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_atready),
		.m_chan_m_atvalid(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_syncreq),
		.syncreq_level_syncreq_level(usb_dp_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(usb_dp_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(usb_dp_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(usb_dp_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(usb_dp_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(usb_dp_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(usb_dp_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	display_ss_top_wrap u_display_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_afvalid),
		.m_chan_m_atbytes(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_atready),
		.m_chan_m_atvalid(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_syncreq),
		.syncreq_level_syncreq_level(display_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(display_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(display_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(display_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(display_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(display_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(display_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	aon_ss_top_wrap u_aon_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_afvalid),
		.m_chan_m_atbytes(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_atready),
		.m_chan_m_atvalid(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_syncreq),
		.syncreq_level_syncreq_level(aon_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(aon_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(aon_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(aon_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(aon_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(aon_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(aon_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(aon_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(aon_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	gpu_ss0_top_wrap u_gpu_ss0 (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_afvalid),
		.m_chan_m_atbytes(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_atready),
		.m_chan_m_atvalid(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_syncreq),
		.syncreq_level_syncreq_level(gpu_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(gpu_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(gpu_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(gpu_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(gpu_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(gpu_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(gpu_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	cpu_ss_top_wrap u_cpu_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_afvalid),
		.m_chan_m_atbytes(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_atready),
		.m_chan_m_atvalid(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_syncreq),
		.syncreq_level_syncreq_level(cpu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(cpu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(cpu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(cpu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(cpu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(cpu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(cpu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(cpu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	mcu_ss_top_wrap u_mcu_ss (
		.clk_clk_atb_m(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_m(u_aon_ss_rst_noc_n_porting),
		.m_chan_m_afready(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.m_chan_m_afvalid(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_afvalid),
		.m_chan_m_atbytes(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.m_chan_m_atdata(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.m_chan_m_atid(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.m_chan_m_atready(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_atready),
		.m_chan_m_atvalid(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.m_chan_m_atwakeup(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.m_chan_m_syncreq(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_syncreq),
		.syncreq_level_syncreq_level(mcu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.flush_req_level_flush_req_level(mcu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level),
		.lp_afifo_rx_afifo_mst_rx_req(mcu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req),
		.lp_afifo_tx_afifo_mst_tx_req(mcu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req),
		.async_fifo_pld_sync(mcu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mcu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_rx_lw_rx_req(mcu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req),
		.lp_tx_lw_tx_req(mcu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req),
		.timeout_val_timeout_val(mcu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	peri_ss_top_wrap u_peri_ss (
		.clk_clk_atb_s(u_aon_ss_clk_noc_porting),
		.rst_n_rstn_atb_s(u_aon_ss_rst_noc_n_porting),
		.s_chan_in_s_afready(u_left_top_funnel0_TO_u_peri_ss_SIG_m_afready),
		.s_chan_in_s_atbytes(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atbytes),
		.s_chan_in_s_atdata(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atdata),
		.s_chan_in_s_atid(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atid),
		.s_chan_in_s_atvalid(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atvalid),
		.s_chan_in_s_atwakeup(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atwakeup),
		.s_chan_out_s_afvalid(u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_afvalid),
		.s_chan_out_s_atready(u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_atready),
		.s_syncreq_s_syncreq(u_peri_ss_TO_u_left_top_funnel0_SIG_s_syncreq_s_syncreq),
		.flush_req_flush_req(peri_ss_top_wrap_flush_req_porting_flush_req_flush_req),
		.async_fifo_pld_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.syncreq_level_syncreq_level(peri_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level),
		.lp_lw_rx_lw_rx_req(peri_ss_top_wrap_lp_lw_rx_porting_lp_lw_rx_lw_rx_req),
		.lp_lw_tx_lw_tx_req(peri_ss_top_wrap_lp_lw_tx_porting_lp_lw_tx_lw_tx_req),
		.lp_afifo_rx_afifo_slv_rx_req(peri_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_slv_rx_req),
		.lp_afifo_tx_afifo_slv_tx_req(peri_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_slv_tx_req),
		.timeout_val_timeout_val(peri_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val));
	atb_funnel_bridge_6to1 u_right_dsp_funnel0 (
		.clk(u_aon_ss_clk_noc_porting),
		.resetn(u_aon_ss_rst_noc_n_porting),
		.ch0_m_atvalid(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch0_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_atready),
		.ch0_m_atbytes(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch0_m_atdata(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch0_m_atid(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch0_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_afvalid),
		.ch0_m_afready(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch0_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss0_SIG_ch0_m_syncreq),
		.ch0_m_atwakeup(u_dsp_ss0_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.ch1_m_atvalid(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch1_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_atready),
		.ch1_m_atbytes(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch1_m_atdata(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch1_m_atid(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch1_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_afvalid),
		.ch1_m_afready(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch1_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss1_SIG_ch1_m_syncreq),
		.ch1_m_atwakeup(u_dsp_ss1_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.ch2_m_atvalid(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch2_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_atready),
		.ch2_m_atbytes(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch2_m_atdata(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch2_m_atid(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch2_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_afvalid),
		.ch2_m_afready(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch2_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss2_SIG_ch2_m_syncreq),
		.ch2_m_atwakeup(u_dsp_ss2_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.ch3_m_atvalid(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch3_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_atready),
		.ch3_m_atbytes(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch3_m_atdata(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch3_m_atid(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch3_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_afvalid),
		.ch3_m_afready(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch3_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss3_SIG_ch3_m_syncreq),
		.ch3_m_atwakeup(u_dsp_ss3_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.ch4_m_atvalid(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch4_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_atready),
		.ch4_m_atbytes(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch4_m_atdata(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch4_m_atid(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch4_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_afvalid),
		.ch4_m_afready(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch4_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss4_SIG_ch4_m_syncreq),
		.ch4_m_atwakeup(u_dsp_ss4_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.ch5_m_atvalid(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atvalid),
		.ch5_m_atready(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_atready),
		.ch5_m_atbytes(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atbytes),
		.ch5_m_atdata(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atdata),
		.ch5_m_atid(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atid),
		.ch5_m_afvalid(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_afvalid),
		.ch5_m_afready(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_afready),
		.ch5_m_syncreq(u_right_dsp_funnel0_TO_u_dsp_ss5_SIG_ch5_m_syncreq),
		.ch5_m_atwakeup(u_dsp_ss5_TO_u_right_dsp_funnel0_SIG_m_chan_m_atwakeup),
		.m_atvalid(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid),
		.m_atready(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_atready),
		.m_atbytes(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes),
		.m_atdata(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atdata),
		.m_atid(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atid),
		.m_afvalid(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_afvalid),
		.m_afready(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_afready),
		.m_syncreq(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_syncreq),
		.m_atwakeup(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup));
	atb_funnel_bridge_6to1 u_top_media_funnel0 (
		.clk(u_aon_ss_clk_noc_porting),
		.resetn(u_aon_ss_rst_noc_n_porting),
		.ch0_m_atvalid(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch0_m_atready(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_atready),
		.ch0_m_atbytes(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch0_m_atdata(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch0_m_atid(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch0_m_afvalid(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_afvalid),
		.ch0_m_afready(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch0_m_syncreq(u_top_media_funnel0_TO_u_camera_ss_SIG_ch0_m_syncreq),
		.ch0_m_atwakeup(u_camera_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.ch1_m_atvalid(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch1_m_atready(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_atready),
		.ch1_m_atbytes(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch1_m_atdata(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch1_m_atid(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch1_m_afvalid(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_afvalid),
		.ch1_m_afready(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch1_m_syncreq(u_top_media_funnel0_TO_u_mipi_ss_SIG_ch1_m_syncreq),
		.ch1_m_atwakeup(u_mipi_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.ch2_m_atvalid(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch2_m_atready(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_atready),
		.ch2_m_atbytes(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch2_m_atdata(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch2_m_atid(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch2_m_afvalid(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_afvalid),
		.ch2_m_afready(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch2_m_syncreq(u_top_media_funnel0_TO_u_gpu1_ss_SIG_ch2_m_syncreq),
		.ch2_m_atwakeup(u_gpu1_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.ch3_m_atvalid(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch3_m_atready(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_atready),
		.ch3_m_atbytes(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch3_m_atdata(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch3_m_atid(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch3_m_afvalid(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_afvalid),
		.ch3_m_afready(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch3_m_syncreq(u_top_media_funnel0_TO_u_usb_dp_ss_SIG_ch3_m_syncreq),
		.ch3_m_atwakeup(u_usb_dp_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.ch4_m_atvalid(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch4_m_atready(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_atready),
		.ch4_m_atbytes(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch4_m_atdata(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch4_m_atid(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch4_m_afvalid(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_afvalid),
		.ch4_m_afready(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch4_m_syncreq(u_top_media_funnel0_TO_u_display_ss_SIG_ch4_m_syncreq),
		.ch4_m_atwakeup(u_display_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.ch5_m_atvalid(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atvalid),
		.ch5_m_atready(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_atready),
		.ch5_m_atbytes(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atbytes),
		.ch5_m_atdata(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atdata),
		.ch5_m_atid(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atid),
		.ch5_m_afvalid(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_afvalid),
		.ch5_m_afready(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_afready),
		.ch5_m_syncreq(u_top_media_funnel0_TO_u_aon_ss_SIG_ch5_m_syncreq),
		.ch5_m_atwakeup(u_aon_ss_TO_u_top_media_funnel0_SIG_m_chan_m_atwakeup),
		.m_atvalid(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid),
		.m_atready(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_atready),
		.m_atbytes(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes),
		.m_atdata(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atdata),
		.m_atid(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atid),
		.m_afvalid(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_afvalid),
		.m_afready(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_afready),
		.m_syncreq(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_syncreq),
		.m_atwakeup(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup));
	atb_funnel_bridge_5to1 u_left_top_funnel0 (
		.clk(u_aon_ss_clk_noc_porting),
		.resetn(u_aon_ss_rst_noc_n_porting),
		.ch0_m_atvalid(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.ch0_m_atready(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_atready),
		.ch0_m_atbytes(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.ch0_m_atdata(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.ch0_m_atid(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.ch0_m_afvalid(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_afvalid),
		.ch0_m_afready(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.ch0_m_syncreq(u_left_top_funnel0_TO_u_gpu_ss0_SIG_ch0_m_syncreq),
		.ch0_m_atwakeup(u_gpu_ss0_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.ch1_m_atvalid(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.ch1_m_atready(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_atready),
		.ch1_m_atbytes(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.ch1_m_atdata(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.ch1_m_atid(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.ch1_m_afvalid(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_afvalid),
		.ch1_m_afready(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.ch1_m_syncreq(u_left_top_funnel0_TO_u_cpu_ss_SIG_ch1_m_syncreq),
		.ch1_m_atwakeup(u_cpu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.ch2_m_atvalid(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid),
		.ch2_m_atready(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_atready),
		.ch2_m_atbytes(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes),
		.ch2_m_atdata(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atdata),
		.ch2_m_atid(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atid),
		.ch2_m_afvalid(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_afvalid),
		.ch2_m_afready(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_afready),
		.ch2_m_syncreq(u_left_top_funnel0_TO_u_right_dsp_funnel0_SIG_ch2_m_syncreq),
		.ch2_m_atwakeup(u_right_dsp_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup),
		.ch3_m_atvalid(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atvalid),
		.ch3_m_atready(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_atready),
		.ch3_m_atbytes(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atbytes),
		.ch3_m_atdata(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atdata),
		.ch3_m_atid(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atid),
		.ch3_m_afvalid(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_afvalid),
		.ch3_m_afready(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_afready),
		.ch3_m_syncreq(u_left_top_funnel0_TO_u_top_media_funnel0_SIG_ch3_m_syncreq),
		.ch3_m_atwakeup(u_top_media_funnel0_TO_u_left_top_funnel0_SIG_m_atwakeup),
		.ch4_m_atvalid(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atvalid),
		.ch4_m_atready(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_atready),
		.ch4_m_atbytes(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atbytes),
		.ch4_m_atdata(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atdata),
		.ch4_m_atid(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atid),
		.ch4_m_afvalid(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_afvalid),
		.ch4_m_afready(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_afready),
		.ch4_m_syncreq(u_left_top_funnel0_TO_u_mcu_ss_SIG_ch4_m_syncreq),
		.ch4_m_atwakeup(u_mcu_ss_TO_u_left_top_funnel0_SIG_m_chan_m_atwakeup),
		.m_atvalid(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atvalid),
		.m_atready(u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_atready),
		.m_atbytes(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atbytes),
		.m_atdata(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atdata),
		.m_atid(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atid),
		.m_afvalid(u_peri_ss_TO_u_left_top_funnel0_SIG_s_chan_out_s_afvalid),
		.m_afready(u_left_top_funnel0_TO_u_peri_ss_SIG_m_afready),
		.m_syncreq(u_peri_ss_TO_u_left_top_funnel0_SIG_s_syncreq_s_syncreq),
		.m_atwakeup(u_left_top_funnel0_TO_u_peri_ss_SIG_m_atwakeup));

endmodule
//[UHDL]Content End [md5:a107dc761661c9342247bc24ccde3014]


//[UHDL]Content Start [md5:d25b160711213c2b65a7aba372a6f8c9]
module soc_intr_ring_top (
	input         clk_noc_up                                                                                                                    ,
	input         rst_noc_up_n                                                                                                                  ,
	input         clk_noc_dn                                                                                                                    ,
	input         rst_noc_dn_n                                                                                                                  ,
	input  [61:0] cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  cpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  cpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	input  [9:0]  cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	input  [9:0]  cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	output [9:0]  cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	input  [9:0]  cpu_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                              ,
	input  [8:0]  cpu_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                      ,
	output [8:0]  cpu_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                      ,
	input  [61:0] audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	output [15:0] audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	output [15:0] audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	input  [15:0] audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	output [8:0]  audio_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                    ,
	input  [8:0]  audio_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                    ,
	output [61:0] peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                  ,
	input  [9:0]  peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                ,
	input  [9:0]  peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                 ,
	output [9:0]  peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                ,
	input  [9:0]  peri_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                             ,
	input  [8:0]  peri_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                     ,
	output [8:0]  peri_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                     ,
	input  [61:0] gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                  ,
	output [15:0] gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                ,
	output [15:0] gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                 ,
	input  [15:0] gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                ,
	output [8:0]  gpu_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                     ,
	input  [8:0]  gpu_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                     ,
	output [61:0] gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                  ,
	input  [9:0]  gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                ,
	input  [9:0]  gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                 ,
	output [9:0]  gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                ,
	input  [9:0]  gpu_ss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                             ,
	input  [8:0]  gpu_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                     ,
	output [8:0]  gpu_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                     ,
	output [61:0] display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                               ,
	input  [9:0]  display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                             ,
	input  [9:0]  display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                              ,
	output [9:0]  display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                             ,
	input  [9:0]  display_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                          ,
	input  [8:0]  display_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                  ,
	output [8:0]  display_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                  ,
	input  [61:0] dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                    ,
	output [15:0] dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                  ,
	output [15:0] dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                   ,
	input  [15:0] dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                  ,
	output [8:0]  dp_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                       ,
	input  [8:0]  dp_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                       ,
	input  [61:0] ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr6_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr6_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr7_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr7_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr8_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr8_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr9_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr9_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                    ,
	output [15:0] ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                  ,
	output [15:0] ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                   ,
	input  [15:0] ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                  ,
	output [8:0]  ddr10_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                       ,
	input  [8:0]  ddr10_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                       ,
	output [61:0] ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                    ,
	input  [9:0]  ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                  ,
	input  [9:0]  ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                   ,
	output [9:0]  ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                  ,
	input  [9:0]  ddr11_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                               ,
	input  [8:0]  ddr11_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                       ,
	output [8:0]  ddr11_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                       ,
	input  [61:0] mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                  ,
	output [15:0] mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                ,
	output [15:0] mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                 ,
	input  [15:0] mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                ,
	output [8:0]  mipi_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                     ,
	input  [8:0]  mipi_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                     ,
	input  [61:0] ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  ufs_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  ufs_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                ,
	input  [9:0]  camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                              ,
	input  [9:0]  camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                               ,
	output [9:0]  camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                              ,
	input  [9:0]  camera_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                           ,
	input  [8:0]  camera_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                   ,
	output [8:0]  camera_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                   ,
	input  [61:0] camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                ,
	output [15:0] camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                              ,
	output [15:0] camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                               ,
	input  [15:0] camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                              ,
	output [8:0]  camera_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                   ,
	input  [8:0]  camera_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                   ,
	input  [61:0] pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                              ,
	output [15:0] pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                            ,
	output [15:0] pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                             ,
	input  [15:0] pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                            ,
	output [8:0]  pcie_eth_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                 ,
	input  [8:0]  pcie_eth_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                 ,
	input  [61:0] debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	output [15:0] debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	output [15:0] debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	input  [15:0] debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	output [8:0]  debug_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                    ,
	input  [8:0]  debug_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                    ,
	input  [61:0] aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  aon_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  aon_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	input  [9:0]  aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	input  [9:0]  aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	output [9:0]  aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	input  [9:0]  aon_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                              ,
	input  [8:0]  aon_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                      ,
	output [8:0]  aon_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                      ,
	input  [61:0] ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	output [15:0] ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	output [15:0] ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	input  [15:0] ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	output [8:0]  ucie_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                    ,
	input  [8:0]  ucie_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                    ,
	output [61:0] ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	input  [9:0]  ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	input  [9:0]  ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	output [9:0]  ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	input  [9:0]  ucie_ss1_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                            ,
	input  [8:0]  ucie_ss1_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                    ,
	output [8:0]  ucie_ss1_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                    ,
	input  [61:0] dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  dspss5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  dspss5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	input         default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last   ,
	input  [39:0] default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload,
	input  [3:0]  default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos    ,
	output        default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready  ,
	input  [7:0]  default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid  ,
	input  [7:0]  default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid  ,
	input         default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid  ,
	input  [61:0] vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  vpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  vpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	input  [9:0]  dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	input  [9:0]  dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	output [9:0]  dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	input  [9:0]  dspss4_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                              ,
	input  [8:0]  dspss4_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                      ,
	output [8:0]  dspss4_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                      ,
	input  [61:0] dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  dspss3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  dspss3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	input  [9:0]  dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	input  [9:0]  dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	output [9:0]  dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	input  [9:0]  dspss2_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                              ,
	input  [8:0]  dspss2_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                      ,
	output [8:0]  dspss2_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                      ,
	input  [61:0] dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	output [15:0] dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	output [15:0] dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	input  [15:0] dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	output [8:0]  dspss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                      ,
	input  [8:0]  dspss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                      ,
	output [61:0] dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                   ,
	input  [9:0]  dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                 ,
	input  [9:0]  dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                  ,
	output [9:0]  dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                 ,
	input  [9:0]  dspss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                              ,
	input  [8:0]  dspss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                      ,
	output [8:0]  dspss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                      ,
	input  [61:0] ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr2_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr2_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr4_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr4_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                     ,
	output [15:0] ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                   ,
	output [15:0] ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                    ,
	input  [15:0] ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                   ,
	output [8:0]  ddr5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                        ,
	input  [8:0]  ddr5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                        ,
	input  [61:0] ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	output [15:0] ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	output [15:0] ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	input  [15:0] ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	output [8:0]  ucie_ss0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                    ,
	input  [8:0]  ucie_ss0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                    ,
	output [61:0] ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                 ,
	input  [9:0]  ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                               ,
	input  [9:0]  ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                ,
	output [9:0]  ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                               ,
	input  [9:0]  ucie_ss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val                                                            ,
	input  [8:0]  ucie_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                    ,
	output [8:0]  ucie_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                    );

	//Wire define for this module.

	//Wire define for sub module.
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last                  ;
	wire [39:0] ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload               ;
	wire [3:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos                   ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid                 ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid                 ;
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid                 ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready                   ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready              ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last            ;
	wire [39:0] display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid           ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid           ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire [39:0] gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                      ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                    ;
	wire [39:0] ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                 ;
	wire [3:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                     ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                   ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                   ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                   ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                    ;
	wire [39:0] dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                 ;
	wire [3:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                     ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                   ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                   ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                   ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                      ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                      ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                    ;
	wire [39:0] ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                 ;
	wire [3:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                     ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                   ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                   ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                   ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                    ;
	wire [39:0] ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                 ;
	wire [3:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                     ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                   ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                   ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                   ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                     ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire [39:0] ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [3:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                      ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                   ;
	wire [39:0] ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                ;
	wire [3:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                    ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                  ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                  ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                  ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready                    ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last                   ;
	wire [39:0] ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload                ;
	wire [3:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos                    ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid                  ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid                  ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                     ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_last      ;
	wire [39:0] ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid     ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_valid     ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_ready      ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_last    ;
	wire [39:0] mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_payload ;
	wire [3:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_qos     ;
	wire [7:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_srcid   ;
	wire [7:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid   ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_valid   ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_ready        ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last                 ;
	wire [39:0] ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid                ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid                ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                ;
	wire [39:0] ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload             ;
	wire [3:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                 ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid               ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid               ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid               ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready                  ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                ;
	wire [39:0] mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload             ;
	wire [3:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                 ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid               ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid               ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid               ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready             ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last           ;
	wire [39:0] camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid          ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid          ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last           ;
	wire [39:0] camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid          ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid          ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready           ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last         ;
	wire [39:0] pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid        ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid        ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready             ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last         ;
	wire [39:0] camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid        ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid        ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready            ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last          ;
	wire [39:0] debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid         ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid         ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready           ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last          ;
	wire [39:0] pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid         ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid         ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready            ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready               ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last             ;
	wire [39:0] ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid            ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid            ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last             ;
	wire [39:0] ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid            ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid            ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready               ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready            ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last          ;
	wire [39:0] default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid         ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid         ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_last          ;
	wire [39:0] dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid         ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_valid         ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready                                      ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last                                      ;
	wire [39:0] dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload                                   ;
	wire [3:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos                                       ;
	wire [7:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid                                     ;
	wire [7:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid                                     ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid                                     ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_ready            ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire [39:0] default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire [3:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_ready                     ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire [39:0] vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [7:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire [3:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last                                             ;
	wire [39:0] dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload                                          ;
	wire [3:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos                                              ;
	wire [7:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid                                            ;
	wire [7:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid                                            ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid                                            ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready                                             ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                     ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire [39:0] ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [3:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                   ;
	wire [39:0] dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                ;
	wire [3:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                    ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                  ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                  ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                  ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                     ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready               ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last             ;
	wire [39:0] ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid            ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid            ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last             ;
	wire [39:0] ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid            ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid            ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready                 ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last                ;
	wire [39:0] ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload             ;
	wire [3:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos                 ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid               ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid               ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid               ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready               ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_last   ;
	wire [39:0] ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_payload;
	wire [3:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid  ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_valid  ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_ready       ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_last     ;
	wire [39:0] cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid    ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_valid    ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_ready     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_iniu_top_wrap cpu_ss_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(cpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(cpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	cpu_ss_tniu_top_wrap cpu_ss_tniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(cpu_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(cpu_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(cpu_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	audio_ss_iniu_top_wrap audio_ss_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(audio_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(audio_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(audio_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	peri_ss_tniu_top_wrap peri_ss_tniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(peri_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(peri_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(peri_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(peri_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	gpu_ss1_iniu_top_wrap gpu_ss1_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(gpu_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(gpu_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	gpu_ss0_tniu_top_wrap gpu_ss0_tniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(gpu_ss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(gpu_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(gpu_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	display_ss_tniu_top_wrap display_ss_tniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(display_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(display_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(display_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(display_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	dp_ss_iniu_top_wrap dp_ss_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dp_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dp_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dp_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr6_iniu_top_wrap ddr6_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr6_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr6_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr6_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr7_iniu_top_wrap ddr7_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr7_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr7_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr7_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr8_iniu_top_wrap ddr8_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr8_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr8_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr8_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr9_iniu_top_wrap ddr9_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr9_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr9_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr9_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr10_iniu_top_wrap ddr10_iniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr10_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr10_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr10_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr11_tniu_top_wrap ddr11_tniu (
		.clk_top_func(clk_noc_up),
		.rst_top_func_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr11_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(ddr11_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(ddr11_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ddr11_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	ring_async_cut_up_to_dn ring_async_cut_up_to_dn (
		.clk_src_clk_slv(clk_noc_up),
		.rst_src_n_rst_slv_n(rst_noc_up_n),
		.clk_dst_clk_mst(clk_noc_dn),
		.rst_dst_n_rst_mst_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_last(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid));
	mipi_ss_iniu_top_wrap mipi_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(mipi_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(mipi_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ufs_ss_iniu_top_wrap ufs_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ufs_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ufs_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	camera_ss_tniu_top_wrap camera_ss_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(camera_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(camera_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(camera_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	camera_ss_iniu_top_wrap camera_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(camera_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(camera_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	pcie_eth_ss_iniu_top_wrap pcie_eth_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(pcie_eth_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(pcie_eth_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	debug_ss_iniu_top_wrap debug_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(debug_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(debug_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(debug_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	aon_ss_iniu_top_wrap aon_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(aon_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(aon_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(aon_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	aon_ss_tniu_top_wrap aon_ss_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(aon_ss_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(aon_ss_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(aon_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(aon_ss_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	ucie_ss1_iniu_top_wrap ucie_ss1_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ucie_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ucie_ss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ucie_ss1_tniu_top_wrap ucie_ss1_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss1_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(ucie_ss1_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(ucie_ss1_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ucie_ss1_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	dspss5_iniu_top_wrap dspss5_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss5_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	default_tgtid_sink default_tgtid_sink (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid));
	lwnoc_intr_ring_sp_wrap #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.THRESHOLD_EN(1'b1),
		.SINGLE_THR_WIDTH(32'd1),
		.NODE_NUM(32'd39))
	dspss5_sp (
		.clk(clk_noc_dn),
		.pring_in_if_valid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_in_if_ready(dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready),
		.pring_in_if_payload(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_srcid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_tgtid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_qos(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_last(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_valid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_ready(vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_payload(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_out_if_srcid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_out_if_tgtid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_out_if_qos(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_out_if_last(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last),
		.nring_in_if_valid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_in_if_ready(dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_in_if_payload(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_srcid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_tgtid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_qos(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_last(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_valid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid),
		.nring_out_if_ready(default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_payload(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload),
		.nring_out_if_srcid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid),
		.nring_out_if_tgtid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid),
		.nring_out_if_qos(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos),
		.nring_out_if_last(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last));
	vpu_ss_iniu_top_wrap vpu_ss_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(vpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(vpu_ss_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	dspss4_tniu_top_wrap dspss4_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss4_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(dspss4_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(dspss4_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss4_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	dspss3_iniu_top_wrap dspss3_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss3_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	dspss2_tniu_top_wrap dspss2_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss2_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(dspss2_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(dspss2_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss2_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	dspss1_iniu_top_wrap dspss1_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	dspss0_tniu_top_wrap dspss0_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(dspss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(dspss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	ddr0_iniu_top_wrap ddr0_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr0_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr1_iniu_top_wrap ddr1_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr1_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr1_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr2_iniu_top_wrap ddr2_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr2_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr2_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr2_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr3_iniu_top_wrap ddr3_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr3_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr3_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr4_iniu_top_wrap ddr4_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr4_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr4_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr4_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr5_iniu_top_wrap ddr5_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr5_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr5_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ucie_ss0_iniu_top_wrap ucie_ss0_iniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ucie_ss0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ucie_ss0_iniu_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ucie_ss0_tniu_top_wrap ucie_ss0_tniu (
		.clk_top_func(clk_noc_dn),
		.rst_top_func_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss0_tniu_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(ucie_ss0_tniu_top_wrap_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(ucie_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ucie_ss0_tniu_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	ring_async_cut_dn_to_up ring_async_cut_dn_to_up (
		.clk_src_clk_slv(clk_noc_dn),
		.rst_src_n_rst_slv_n(rst_noc_dn_n),
		.clk_dst_clk_mst(clk_noc_up),
		.rst_dst_n_rst_mst_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_last(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid));

endmodule
//[UHDL]Content End [md5:d25b160711213c2b65a7aba372a6f8c9]


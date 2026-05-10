//[UHDL]Content Start [md5:bef14d8e01a6be74569ab90ebe67df8f]
module soc_intr_ring_noc_up_harden_wrap (
	input         cpu_ss_iniu_node_top_wrap_clk_porting                                                                                                                            ,
	input         cpu_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                          ,
	input  [69:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                 ,
	output [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                               ,
	output [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                ,
	input  [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                               ,
	output [12:0] cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                    ,
	input  [12:0] cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                    ,
	output        cpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                         ,
	output        cpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                         ,
	output        cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ucie_ss0_iniu_node_top_wrap_clk_porting                                                                                                                          ,
	input         ucie_ss0_iniu_node_top_wrap_rst_n_porting                                                                                                                        ,
	input  [69:0] ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                               ,
	output [15:0] ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                             ,
	output [15:0] ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                              ,
	input  [15:0] ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                             ,
	output [12:0] ucie_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                  ,
	input  [12:0] ucie_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                  ,
	output        ucie_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                       ,
	output        ucie_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                       ,
	output        ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         audio_ss_iniu_node_top_wrap_clk_porting                                                                                                                          ,
	input         audio_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                        ,
	input  [69:0] audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                               ,
	output [15:0] audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                             ,
	output [15:0] audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                              ,
	input  [15:0] audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                             ,
	output [12:0] audio_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                  ,
	input  [12:0] audio_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                  ,
	output        audio_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                       ,
	output        audio_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                       ,
	output        audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         peri_ss_tniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         peri_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	output [69:0] peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	input  [9:0]  peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	input  [9:0]  peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	output [9:0]  peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	input  [12:0] peri_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                   ,
	output [12:0] peri_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                   ,
	input  [9:0]  peri_ss_tniu_node_top_wrap_peri_ss_tniu_node_top_wrap_top_timeout_val_porting_peri_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         gpu_ss0_tniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         gpu_ss0_tniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	output [69:0] gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	input  [9:0]  gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	input  [9:0]  gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	output [9:0]  gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	input  [12:0] gpu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                   ,
	output [12:0] gpu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                   ,
	input  [9:0]  gpu_ss0_tniu_node_top_wrap_gpu_ss0_tniu_node_top_wrap_top_timeout_val_porting_gpu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         gpu_ss1_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         gpu_ss1_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        gpu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        gpu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         dp_ss_iniu_node_top_wrap_clk_porting                                                                                                                             ,
	input         dp_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                           ,
	input  [69:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                  ,
	output [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                ,
	output [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                 ,
	input  [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                ,
	output [12:0] dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                     ,
	input  [12:0] dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                     ,
	output        dp_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                          ,
	output        dp_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                          ,
	output        dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                     ,
	output [39:0] dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                  ,
	output [3:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                      ,
	input         dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                    ,
	output [7:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                    ,
	output [7:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                    ,
	output        dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                    ,
	input         display_ss_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         display_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [9:0]  display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [9:0]  display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [9:0]  display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] display_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] display_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	output        display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last                                                                                ,
	output [39:0] display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload                                                                             ,
	output [3:0]  display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos                                                                                 ,
	input         display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready                                                                               ,
	output [7:0]  display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid                                                                               ,
	output [7:0]  display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid                                                                               ,
	output        display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid                                                                               ,
	input         display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last                                                                                   ,
	input  [39:0] display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload                                                                                ,
	input  [3:0]  display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos                                                                                    ,
	output        display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready                                                                                  ,
	input  [7:0]  display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid                                                                                  ,
	input  [7:0]  display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid                                                                                  ,
	input         display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid                                                                                  ,
	input  [9:0]  display_ss_tniu_node_top_wrap_display_ss_tniu_node_top_wrap_top_timeout_val_porting_display_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val            ,
	input         pcie_eth_ss_iniu_node_top_wrap_clk_porting                                                                                                                       ,
	input         pcie_eth_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                     ,
	input  [69:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                            ,
	output [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                          ,
	output [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                           ,
	input  [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                          ,
	output [12:0] pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                               ,
	input  [12:0] pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                               ,
	input         pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last                                                                                  ,
	input  [39:0] pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload                                                                               ,
	input  [3:0]  pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos                                                                                   ,
	output        pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready                                                                                 ,
	input  [7:0]  pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid                                                                                 ,
	input  [7:0]  pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid                                                                                 ,
	input         pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid                                                                                 ,
	output        pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last                                                                               ,
	output [39:0] pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload                                                                            ,
	output [3:0]  pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos                                                                                ,
	input         pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready                                                                              ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid                                                                              ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid                                                                              ,
	output        pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid                                                                              ,
	output        pcie_eth_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                    ,
	output        pcie_eth_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                    ,
	output        pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last   ,
	output [39:0] pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload,
	output [3:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos    ,
	input         pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready  ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid  ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid  ,
	output        pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid  ,
	input         u_ring_sink_station_clk_porting                                                                                                                                  ,
	input         u_ring_sink_station_rst_n_porting                                                                                                                                );

	//Wire define for this module.

	//Wire define for sub module.
	wire        u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_last                               ;
	wire [39:0] u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_payload                            ;
	wire [3:0]  u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_qos                                ;
	wire [7:0]  u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_srcid                              ;
	wire [7:0]  u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_tgtid                              ;
	wire        u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_valid                              ;
	wire        u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ring_sp_TO_u_cpu_ss_iniu_SIG_nring_in_if_ready                               ;
	wire        u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_ready           ;
	wire        u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_last          ;
	wire [39:0] u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid         ;
	wire        u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_valid         ;
	wire        u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_last          ;
	wire [39:0] u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid         ;
	wire        u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_valid         ;
	wire        u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ready           ;
	wire        u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready               ;
	wire        u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last              ;
	wire [39:0] u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid             ;
	wire        u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid             ;
	wire        u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last              ;
	wire [39:0] u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid             ;
	wire        u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid             ;
	wire        u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready               ;
	wire        u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready    ;
	wire        u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last   ;
	wire [39:0] u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload;
	wire [3:0]  u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid  ;
	wire        u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid  ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_valid           ;
	wire [39:0] u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_payload         ;
	wire [7:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire [3:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_qos             ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_last            ;
	wire        u_cpu_ss_iniu_TO_u_ring_sp_SIG_pring_in_if_pring_in_if_ready                   ;
	wire        u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_valid                 ;
	wire [39:0] u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_payload               ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_srcid                 ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_tgtid                 ;
	wire [3:0]  u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_qos                   ;
	wire        u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_last                  ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last   ;
	wire [39:0] u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload;
	wire [3:0]  u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid  ;
	wire        u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid  ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_pring_in_if_ready                         ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_last                         ;
	wire [39:0] u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_payload                      ;
	wire [3:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_qos                          ;
	wire [7:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_srcid                        ;
	wire [7:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_tgtid                        ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_valid                        ;
	wire        u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready    ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_iniu_node_top_wrap u_cpu_ss_iniu (
		.clk(cpu_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(cpu_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_cpu_ss_iniu_TO_u_ring_sp_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ring_sp_TO_u_cpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(cpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(cpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ucie_ss0_iniu_node_top_wrap u_ucie_ss0_iniu (
		.clk(ucie_ss0_iniu_node_top_wrap_clk_porting),
		.rst_n(ucie_ss0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ucie_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ucie_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_cpu_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ucie_ss0_iniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ucie_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ucie_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ucie_ss0_iniu_node_top_wrap_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	audio_ss_iniu_node_top_wrap u_audio_ss_iniu (
		.clk(audio_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(audio_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(audio_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(audio_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(audio_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ucie_ss0_iniu_TO_u_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_audio_ss_iniu_TO_u_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(audio_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(audio_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(audio_ss_iniu_node_top_wrap_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_audio_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	peri_ss_tniu_node_top_wrap u_peri_ss_tniu (
		.clk(peri_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(peri_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(peri_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(peri_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(peri_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_audio_ss_iniu_TO_u_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_peri_ss_tniu_TO_u_audio_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.peri_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(peri_ss_tniu_node_top_wrap_peri_ss_tniu_node_top_wrap_top_timeout_val_porting_peri_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	gpu_ss0_tniu_node_top_wrap u_gpu_ss0_tniu (
		.clk(gpu_ss0_tniu_node_top_wrap_clk_porting),
		.rst_n(gpu_ss0_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(gpu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(gpu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_peri_ss_tniu_TO_u_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_gpu_ss0_tniu_TO_u_peri_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.gpu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(gpu_ss0_tniu_node_top_wrap_gpu_ss0_tniu_node_top_wrap_top_timeout_val_porting_gpu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	gpu_ss1_iniu_node_top_wrap u_gpu_ss1_iniu (
		.clk(gpu_ss1_iniu_node_top_wrap_clk_porting),
		.rst_n(gpu_ss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_gpu_ss0_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_gpu_ss1_iniu_TO_u_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(gpu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(gpu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dp_ss_iniu_node_top_wrap u_dp_ss_iniu (
		.clk(dp_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(dp_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_gpu_ss1_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dp_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dp_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dp_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	display_ss_tniu_node_top_wrap u_display_ss_tniu (
		.clk(display_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(display_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(display_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(display_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(display_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_srcid(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(display_ss_tniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_payload(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_qos(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_ready(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_tgtid(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_valid(display_ss_tniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_last(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dp_ss_iniu_TO_u_display_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_display_ss_tniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.display_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(display_ss_tniu_node_top_wrap_display_ss_tniu_node_top_wrap_top_timeout_val_porting_display_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	pcie_eth_ss_iniu_node_top_wrap u_pcie_eth_ss_iniu (
		.clk(pcie_eth_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(pcie_eth_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_payload(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_qos(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_ready(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_tgtid(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_valid(pcie_eth_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid),
		.pring_out_if_pring_out_if_last(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_srcid(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(pcie_eth_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(pcie_eth_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(pcie_eth_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	lwnoc_intr_ring_sp_wrap u_ring_sp (
		.clk(u_ring_sink_station_clk_porting),
		.pring_in_if_valid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_valid),
		.pring_in_if_ready(u_ring_sp_TO_u_ring_sink_station_SIG_pring_in_if_ready),
		.pring_in_if_payload(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_srcid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_tgtid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_qos(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_last(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_valid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_ready(u_cpu_ss_iniu_TO_u_ring_sp_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_payload(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_out_if_srcid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_out_if_tgtid(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_out_if_qos(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_out_if_last(u_ring_sp_TO_u_cpu_ss_iniu_SIG_pring_out_if_last),
		.nring_in_if_valid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_valid),
		.nring_in_if_ready(u_ring_sp_TO_u_cpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_in_if_payload(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_srcid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_tgtid(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_qos(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_last(u_cpu_ss_iniu_TO_u_ring_sp_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_valid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_valid),
		.nring_out_if_ready(u_ring_sink_station_TO_u_ring_sp_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_payload(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_payload),
		.nring_out_if_srcid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_srcid),
		.nring_out_if_tgtid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_tgtid),
		.nring_out_if_qos(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_qos),
		.nring_out_if_last(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_last));
	ring_sink_station u_ring_sink_station (
		.clk(u_ring_sink_station_clk_porting),
		.rst_n(u_ring_sink_station_rst_n_porting),
		.pring_in_if_pring_in_if_last(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ring_sp_TO_u_ring_sink_station_SIG_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ring_sink_station_TO_u_ring_sp_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_pcie_eth_ss_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ring_sink_station_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid));

endmodule
//[UHDL]Content End [md5:bef14d8e01a6be74569ab90ebe67df8f]


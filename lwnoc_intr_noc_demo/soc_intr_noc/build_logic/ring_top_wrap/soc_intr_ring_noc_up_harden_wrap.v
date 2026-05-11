//[UHDL]Content Start [md5:9b65ade29401f5e70c2100b29f8dba68]
module soc_intr_ring_noc_up_harden_wrap (
	input         cpu_ss_iniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         cpu_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	input  [69:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	output [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	output [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	input  [15:0] cpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	output [12:0] cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                 ,
	input  [12:0] cpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                 ,
	input         cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last                                                                                    ,
	input  [39:0] cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload                                                                                 ,
	input  [3:0]  cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos                                                                                     ,
	output        cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready                                                                                   ,
	input  [7:0]  cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid                                                                                   ,
	input  [7:0]  cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid                                                                                   ,
	input         cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid                                                                                   ,
	output        cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last                                                                                 ,
	output [39:0] cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload                                                                              ,
	output [3:0]  cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos                                                                                  ,
	input         cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready                                                                                ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid                                                                                ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid                                                                                ,
	output        cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid                                                                                ,
	output        cpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                      ,
	output        cpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                      ,
	output        cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         cpu_ss_tniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         cpu_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	output [69:0] cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	input  [15:0] cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	input  [15:0] cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	output [15:0] cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	input  [12:0] cpu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                 ,
	output [12:0] cpu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                 ,
	input  [9:0]  cpu_ss_tniu_node_top_wrap_cpu_ss_tniu_node_top_wrap_top_timeout_val_porting_cpu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         npu_ss0_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss0_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] npu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] npu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        npu_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        npu_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         npu_ss0_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss0_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] npu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] npu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  npu_ss0_tniu_node_top_wrap_npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         npu_ss1_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss1_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] npu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] npu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        npu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        npu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         npu_ss1_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss1_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] npu_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] npu_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  npu_ss1_tniu_node_top_wrap_npu_ss1_tniu_node_top_wrap_top_timeout_val_porting_npu_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         npu_ss2_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss2_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] npu_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] npu_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        npu_ss2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        npu_ss2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         npu_ss2_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         npu_ss2_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] npu_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] npu_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  npu_ss2_tniu_node_top_wrap_npu_ss2_tniu_node_top_wrap_top_timeout_val_porting_npu_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         gpu_ss1_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         gpu_ss1_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        gpu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        gpu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         mipi_ss_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         mipi_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        mipi_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        mipi_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dp_ss_iniu_node_top_wrap_clk_porting                                                                                                                          ,
	input         dp_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                        ,
	input  [69:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                               ,
	output [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                             ,
	output [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                              ,
	input  [15:0] dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                             ,
	output [12:0] dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                  ,
	input  [12:0] dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                  ,
	output        dp_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                       ,
	output        dp_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                       ,
	output        dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         display_ss_iniu_node_top_wrap_clk_porting                                                                                                                     ,
	input         display_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                   ,
	input  [69:0] display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                          ,
	output [15:0] display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                        ,
	output [15:0] display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                         ,
	input  [15:0] display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                        ,
	output [12:0] display_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                             ,
	input  [12:0] display_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                             ,
	output        display_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                  ,
	output        display_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                  ,
	output        display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last   ,
	output [39:0] display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload,
	output [3:0]  display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos    ,
	input         display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready  ,
	output [7:0]  display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid  ,
	output [7:0]  display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid  ,
	output        display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid  ,
	input         vpu_ss_iniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         vpu_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	input  [69:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	output [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	output [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	input  [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	output [12:0] vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                 ,
	input  [12:0] vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                 ,
	output        vpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                      ,
	output        vpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                      ,
	output        vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         aon_ss_iniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         aon_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	input  [69:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	output [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	output [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	input  [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	output [12:0] aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                 ,
	input  [12:0] aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                 ,
	output        aon_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                      ,
	output        aon_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                      ,
	output        aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         aon_ss_tniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         aon_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	output [69:0] aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	input  [15:0] aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	input  [15:0] aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	output [15:0] aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	input  [12:0] aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                 ,
	output [12:0] aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                 ,
	input  [9:0]  aon_ss_tniu_node_top_wrap_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         dsp_ss5_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss5_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss5_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss5_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss5_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss5_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss5_tniu_node_top_wrap_dsp_ss5_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss5_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dsp_ss4_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss4_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss4_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss4_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss4_tniu_node_top_wrap_dsp_ss4_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dsp_ss3_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss3_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss3_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss3_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss3_tniu_node_top_wrap_dsp_ss3_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dsp_ss2_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss2_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss2_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss2_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss2_tniu_node_top_wrap_dsp_ss2_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dsp_ss1_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss1_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss1_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss1_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss1_tniu_node_top_wrap_dsp_ss1_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dsp_ss0_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss0_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] dsp_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] dsp_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        dsp_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        dsp_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dsp_ss0_tniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         dsp_ss0_tniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	output [69:0] dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	input  [15:0] dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	input  [15:0] dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	output [15:0] dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	input  [12:0] dsp_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                ,
	output [12:0] dsp_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                ,
	input  [9:0]  dsp_ss0_tniu_node_top_wrap_dsp_ss0_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         ddr6_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         ddr6_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        ddr6_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        ddr6_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                     ,
	output [39:0] ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                  ,
	output [3:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                      ,
	input         ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                    ,
	output [7:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                    ,
	output [7:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                    ,
	output        ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                    ,
	input         ddr7_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         ddr7_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        ddr7_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        ddr7_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                     ,
	output [39:0] ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                  ,
	output [3:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                      ,
	input         ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                    ,
	output [7:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                    ,
	output [7:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                    ,
	output        ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                    ,
	input         ddr8_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         ddr8_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        ddr8_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        ddr8_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                     ,
	output [39:0] ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                  ,
	output [3:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                      ,
	input         ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                    ,
	output [7:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                    ,
	output [7:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                    ,
	output        ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                    ,
	input         ddr9_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         ddr9_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        ddr9_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        ddr9_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                     ,
	output [39:0] ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                  ,
	output [3:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                      ,
	input         ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                    ,
	output [7:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                    ,
	output [7:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                    ,
	output        ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                    ,
	input         ddr10_iniu_node_top_wrap_clk_porting                                                                                                                          ,
	input         ddr10_iniu_node_top_wrap_rst_n_porting                                                                                                                        ,
	input  [69:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                               ,
	output [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                             ,
	output [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                              ,
	input  [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                             ,
	output [12:0] ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                  ,
	input  [12:0] ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                  ,
	output        ddr10_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                       ,
	output        ddr10_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                       ,
	output        ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr11_iniu_node_top_wrap_clk_porting                                                                                                                          ,
	input         ddr11_iniu_node_top_wrap_rst_n_porting                                                                                                                        ,
	input  [69:0] ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                               ,
	output [15:0] ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                             ,
	output [15:0] ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                              ,
	input  [15:0] ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                             ,
	output [12:0] ddr11_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                  ,
	input  [12:0] ddr11_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                  ,
	output        ddr11_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                       ,
	output        ddr11_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                       ,
	output        ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         noc_ss_iniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         noc_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	input  [69:0] noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	output [15:0] noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	output [15:0] noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	input  [15:0] noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	output [12:0] noc_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                 ,
	input  [12:0] noc_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                 ,
	output        noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last                                                                                 ,
	output [39:0] noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload                                                                              ,
	output [3:0]  noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos                                                                                  ,
	input         noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready                                                                                ,
	output [7:0]  noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid                                                                                ,
	output [7:0]  noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid                                                                                ,
	output        noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid                                                                                ,
	input         noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last                                                                                    ,
	input  [39:0] noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload                                                                                 ,
	input  [3:0]  noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos                                                                                     ,
	output        noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready                                                                                   ,
	input  [7:0]  noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid                                                                                   ,
	input  [7:0]  noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid                                                                                   ,
	input         noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid                                                                                   ,
	output        noc_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                      ,
	output        noc_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                      ,
	output        noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              );

	//Wire define for this module.

	//Wire define for sub module.
	wire        u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready     ;
	wire        u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last    ;
	wire [39:0] u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload ;
	wire [3:0]  u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos     ;
	wire [7:0]  u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid   ;
	wire [7:0]  u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid   ;
	wire        u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid   ;
	wire        u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_last    ;
	wire [39:0] u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_payload ;
	wire [3:0]  u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_qos     ;
	wire [7:0]  u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_srcid   ;
	wire [7:0]  u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid   ;
	wire        u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_valid   ;
	wire        u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_pring_in_if_pring_in_if_ready    ;
	wire        u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_last   ;
	wire [39:0] u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_payload;
	wire [3:0]  u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid  ;
	wire        u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_valid  ;
	wire        u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_nring_in_if_nring_in_if_ready     ;
	wire        u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last   ;
	wire [39:0] u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload;
	wire [3:0]  u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid  ;
	wire        u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid  ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready    ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_pring_in_if_pring_in_if_ready         ;
	wire        u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_last        ;
	wire [39:0] u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_payload     ;
	wire [3:0]  u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_qos         ;
	wire [7:0]  u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid       ;
	wire [7:0]  u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid       ;
	wire        u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_valid       ;
	wire        u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_last        ;
	wire [39:0] u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_payload     ;
	wire [3:0]  u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_qos         ;
	wire [7:0]  u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_srcid       ;
	wire [7:0]  u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_tgtid       ;
	wire        u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_valid       ;
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_nring_in_if_nring_in_if_ready         ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_pring_in_if_pring_in_if_ready           ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_last          ;
	wire [39:0] u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_tgtid         ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_valid         ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_last          ;
	wire [39:0] u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_tgtid         ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_valid         ;
	wire        u_ddr11_iniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_nring_in_if_nring_in_if_ready           ;
	wire        u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_pring_in_if_pring_in_if_ready         ;
	wire        u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_last        ;
	wire [39:0] u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_payload     ;
	wire [3:0]  u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_qos         ;
	wire [7:0]  u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_srcid       ;
	wire [7:0]  u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_tgtid       ;
	wire        u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_valid       ;
	wire        u_ddr10_iniu_TO_u_ddr11_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_last        ;
	wire [39:0] u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_payload     ;
	wire [3:0]  u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_qos         ;
	wire [7:0]  u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_srcid       ;
	wire [7:0]  u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid       ;
	wire        u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_valid       ;
	wire        u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_nring_in_if_nring_in_if_ready         ;

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
		.pring_in_if_pring_in_if_last(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_payload(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_qos(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_ready(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_tgtid(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_valid(cpu_ss_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid),
		.pring_out_if_pring_out_if_last(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_srcid(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(cpu_ss_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(cpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(cpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(cpu_ss_iniu_node_top_wrap_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_cpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	cpu_ss_tniu_node_top_wrap u_cpu_ss_tniu (
		.clk(cpu_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(cpu_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(cpu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(cpu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_cpu_ss_iniu_TO_u_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_cpu_ss_tniu_TO_u_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.cpu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(cpu_ss_tniu_node_top_wrap_cpu_ss_tniu_node_top_wrap_top_timeout_val_porting_cpu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	npu_ss0_iniu_node_top_wrap u_npu_ss0_iniu (
		.clk(npu_ss0_iniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(npu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(npu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_cpu_ss_tniu_TO_u_npu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss0_iniu_TO_u_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(npu_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(npu_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(npu_ss0_iniu_node_top_wrap_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	npu_ss0_tniu_node_top_wrap u_npu_ss0_tniu (
		.clk(npu_ss0_tniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss0_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(npu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(npu_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss0_iniu_TO_u_npu_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss0_tniu_TO_u_npu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(npu_ss0_tniu_node_top_wrap_npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	npu_ss1_iniu_node_top_wrap u_npu_ss1_iniu (
		.clk(npu_ss1_iniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(npu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(npu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss0_tniu_TO_u_npu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss1_iniu_TO_u_npu_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(npu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(npu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(npu_ss1_iniu_node_top_wrap_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	npu_ss1_tniu_node_top_wrap u_npu_ss1_tniu (
		.clk(npu_ss1_tniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss1_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(npu_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(npu_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss1_iniu_TO_u_npu_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss1_tniu_TO_u_npu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.npu_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(npu_ss1_tniu_node_top_wrap_npu_ss1_tniu_node_top_wrap_top_timeout_val_porting_npu_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	npu_ss2_iniu_node_top_wrap u_npu_ss2_iniu (
		.clk(npu_ss2_iniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss2_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(npu_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(npu_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss1_tniu_TO_u_npu_ss2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss2_iniu_TO_u_npu_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(npu_ss2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(npu_ss2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(npu_ss2_iniu_node_top_wrap_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	npu_ss2_tniu_node_top_wrap u_npu_ss2_tniu (
		.clk(npu_ss2_tniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss2_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(npu_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(npu_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss2_iniu_TO_u_npu_ss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss2_tniu_TO_u_npu_ss2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.npu_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(npu_ss2_tniu_node_top_wrap_npu_ss2_tniu_node_top_wrap_top_timeout_val_porting_npu_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	gpu_ss1_iniu_node_top_wrap u_gpu_ss1_iniu (
		.clk(gpu_ss1_iniu_node_top_wrap_clk_porting),
		.rst_n(gpu_ss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(gpu_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss2_tniu_TO_u_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_gpu_ss1_iniu_TO_u_npu_ss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(gpu_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(gpu_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(gpu_ss1_iniu_node_top_wrap_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	mipi_ss_iniu_node_top_wrap u_mipi_ss_iniu (
		.clk(mipi_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(mipi_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_gpu_ss1_iniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_mipi_ss_iniu_TO_u_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(mipi_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(mipi_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dp_ss_iniu_node_top_wrap u_dp_ss_iniu (
		.clk(dp_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(dp_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dp_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dp_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_mipi_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dp_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dp_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dp_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dp_ss_iniu_node_top_wrap_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_dp_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	display_ss_iniu_node_top_wrap u_display_ss_iniu (
		.clk(display_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(display_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(display_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(display_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(display_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dp_ss_iniu_TO_u_display_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_display_ss_iniu_TO_u_dp_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(display_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(display_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(display_ss_iniu_node_top_wrap_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_display_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	vpu_ss_iniu_node_top_wrap u_vpu_ss_iniu (
		.clk(vpu_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(vpu_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_display_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_vpu_ss_iniu_TO_u_display_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(vpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(vpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	aon_ss_iniu_node_top_wrap u_aon_ss_iniu (
		.clk(aon_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(aon_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(aon_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(aon_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	aon_ss_tniu_node_top_wrap u_aon_ss_tniu (
		.clk(aon_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(aon_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(aon_ss_tniu_node_top_wrap_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss5_iniu_node_top_wrap u_dsp_ss5_iniu (
		.clk(dsp_ss5_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss5_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_aon_ss_tniu_TO_u_dsp_ss5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss5_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss5_iniu_node_top_wrap_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss5_tniu_node_top_wrap u_dsp_ss5_tniu (
		.clk(dsp_ss5_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss5_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss5_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss5_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss5_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss5_iniu_TO_u_dsp_ss5_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss5_tniu_TO_u_dsp_ss5_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss5_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss5_tniu_node_top_wrap_dsp_ss5_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss5_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss4_iniu_node_top_wrap u_dsp_ss4_iniu (
		.clk(dsp_ss4_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss4_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss5_tniu_TO_u_dsp_ss4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss4_iniu_TO_u_dsp_ss5_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss4_iniu_node_top_wrap_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss4_tniu_node_top_wrap u_dsp_ss4_tniu (
		.clk(dsp_ss4_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss4_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss4_iniu_TO_u_dsp_ss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss4_tniu_TO_u_dsp_ss4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss4_tniu_node_top_wrap_dsp_ss4_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss3_iniu_node_top_wrap u_dsp_ss3_iniu (
		.clk(dsp_ss3_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss3_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss4_tniu_TO_u_dsp_ss3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss3_iniu_TO_u_dsp_ss4_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss3_iniu_node_top_wrap_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss3_tniu_node_top_wrap u_dsp_ss3_tniu (
		.clk(dsp_ss3_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss3_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss3_iniu_TO_u_dsp_ss3_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss3_tniu_TO_u_dsp_ss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss3_tniu_node_top_wrap_dsp_ss3_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss2_iniu_node_top_wrap u_dsp_ss2_iniu (
		.clk(dsp_ss2_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss2_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss3_tniu_TO_u_dsp_ss2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss2_iniu_TO_u_dsp_ss3_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss2_iniu_node_top_wrap_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss2_tniu_node_top_wrap u_dsp_ss2_tniu (
		.clk(dsp_ss2_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss2_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss2_iniu_TO_u_dsp_ss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss2_tniu_TO_u_dsp_ss2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss2_tniu_node_top_wrap_dsp_ss2_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss1_iniu_node_top_wrap u_dsp_ss1_iniu (
		.clk(dsp_ss1_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss2_tniu_TO_u_dsp_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss1_iniu_TO_u_dsp_ss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss1_iniu_node_top_wrap_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss1_tniu_node_top_wrap u_dsp_ss1_tniu (
		.clk(dsp_ss1_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss1_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss1_iniu_TO_u_dsp_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss1_tniu_TO_u_dsp_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss1_tniu_node_top_wrap_dsp_ss1_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dsp_ss0_iniu_node_top_wrap u_dsp_ss0_iniu (
		.clk(dsp_ss0_iniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dsp_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dsp_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss1_tniu_TO_u_dsp_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss0_iniu_TO_u_dsp_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dsp_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dsp_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dsp_ss0_iniu_node_top_wrap_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_dsp_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dsp_ss0_tniu_node_top_wrap u_dsp_ss0_tniu (
		.clk(dsp_ss0_tniu_node_top_wrap_clk_porting),
		.rst_n(dsp_ss0_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dsp_ss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dsp_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dsp_ss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss0_iniu_TO_u_dsp_ss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dsp_ss0_tniu_TO_u_dsp_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dsp_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dsp_ss0_tniu_node_top_wrap_dsp_ss0_tniu_node_top_wrap_top_timeout_val_porting_dsp_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	ddr6_iniu_node_top_wrap u_ddr6_iniu (
		.clk(ddr6_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr6_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dsp_ss0_tniu_TO_u_ddr6_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr6_iniu_TO_u_dsp_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr6_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr6_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr7_iniu_node_top_wrap u_ddr7_iniu (
		.clk(ddr7_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr7_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr6_iniu_TO_u_ddr7_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr7_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr7_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr8_iniu_node_top_wrap u_ddr8_iniu (
		.clk(ddr8_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr8_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr7_iniu_TO_u_ddr8_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr8_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr8_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr9_iniu_node_top_wrap u_ddr9_iniu (
		.clk(ddr9_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr9_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr8_iniu_TO_u_ddr9_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr9_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr9_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr10_iniu_node_top_wrap u_ddr10_iniu (
		.clk(ddr10_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr10_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr9_iniu_TO_u_ddr10_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr10_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr10_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr11_iniu_node_top_wrap u_ddr11_iniu (
		.clk(ddr11_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr11_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr11_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr11_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr11_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr10_iniu_TO_u_ddr11_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr11_iniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr11_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr11_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr11_iniu_node_top_wrap_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_ddr11_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	noc_ss_iniu_node_top_wrap u_noc_ss_iniu (
		.clk(noc_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(noc_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(noc_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(noc_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(noc_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_srcid(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(noc_ss_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_payload(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_qos(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_ready(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_tgtid(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_valid(noc_ss_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_last(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr11_iniu_TO_u_noc_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_noc_ss_iniu_TO_u_ddr11_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(noc_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(noc_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(noc_ss_iniu_node_top_wrap_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_noc_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));

endmodule
//[UHDL]Content End [md5:9b65ade29401f5e70c2100b29f8dba68]


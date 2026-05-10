//[UHDL]Content Start [md5:8519f8bba7b001e32e963b10045fd6df]
module soc_intr_ring_noc_dn_harden_wrap (
	input         ddr6_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr6_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	input         ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last                                                                                   ,
	input  [39:0] ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload                                                                                ,
	input  [3:0]  ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos                                                                                    ,
	output        ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready                                                                                  ,
	input  [7:0]  ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid                                                                                  ,
	input  [7:0]  ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid                                                                                  ,
	input         ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid                                                                                  ,
	output        ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last                                                                                ,
	output [39:0] ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload                                                                             ,
	output [3:0]  ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos                                                                                 ,
	input         ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready                                                                               ,
	output [7:0]  ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid                                                                               ,
	output [7:0]  ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid                                                                               ,
	output        ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid                                                                               ,
	output        ddr6_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr6_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr6_iniu_node_top_wrap_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_ddr6_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr7_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr7_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr7_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr7_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr7_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr7_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr7_iniu_node_top_wrap_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_ddr7_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr8_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr8_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr8_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr8_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr8_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr8_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr8_iniu_node_top_wrap_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_ddr8_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr9_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr9_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr9_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr9_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr9_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr9_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr9_iniu_node_top_wrap_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_ddr9_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr10_iniu_node_top_wrap_clk_porting                                                                                                                       ,
	input         ddr10_iniu_node_top_wrap_rst_n_porting                                                                                                                     ,
	input  [69:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                            ,
	output [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                          ,
	output [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                           ,
	input  [15:0] ddr10_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                          ,
	output [12:0] ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                               ,
	input  [12:0] ddr10_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                               ,
	output        ddr10_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                    ,
	output        ddr10_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                    ,
	output        ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        ddr10_iniu_node_top_wrap_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_ddr10_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         ddr11_tniu_node_top_wrap_clk_porting                                                                                                                       ,
	input         ddr11_tniu_node_top_wrap_rst_n_porting                                                                                                                     ,
	output [69:0] ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                            ,
	input  [9:0]  ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                          ,
	input  [9:0]  ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                           ,
	output [9:0]  ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                          ,
	input  [12:0] ddr11_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                               ,
	output [12:0] ddr11_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                               ,
	input  [9:0]  ddr11_tniu_node_top_wrap_ddr11_tniu_node_top_wrap_top_timeout_val_porting_ddr11_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         mipi_ss_iniu_node_top_wrap_clk_porting                                                                                                                     ,
	input         mipi_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                   ,
	input  [69:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                          ,
	output [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                        ,
	output [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                         ,
	input  [15:0] mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                        ,
	output [12:0] mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                             ,
	input  [12:0] mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                             ,
	output        mipi_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                  ,
	output        mipi_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                  ,
	output        mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last         ,
	output [39:0] mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload      ,
	output [3:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos          ,
	input         mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready        ,
	output [7:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid        ,
	output [7:0]  mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid        ,
	output        mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid        ,
	input         ufs_ss_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         ufs_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        ufs_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        ufs_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         camera_ss_iniu_node_top_wrap_clk_porting                                                                                                                   ,
	input         camera_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                 ,
	input  [69:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                        ,
	output [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                      ,
	output [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                       ,
	input  [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                      ,
	output [12:0] camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                           ,
	input  [12:0] camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                           ,
	output        camera_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                ,
	output        camera_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                ,
	output        camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last   ,
	output [39:0] camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload,
	output [3:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos    ,
	input         camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready  ,
	output [7:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid  ,
	output [7:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid  ,
	output        camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid  ,
	input         camera_ss_tniu_node_top_wrap_clk_porting                                                                                                                   ,
	input         camera_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                 ,
	output [69:0] camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                        ,
	input  [9:0]  camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                      ,
	input  [9:0]  camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                       ,
	output [9:0]  camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                      ,
	input  [12:0] camera_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                           ,
	output [12:0] camera_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                           ,
	input  [9:0]  camera_ss_tniu_node_top_wrap_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val         ,
	input         vpu_ss_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         vpu_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        vpu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        vpu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        vpu_ss_iniu_node_top_wrap_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_vpu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         aon_ss_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         aon_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] aon_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] aon_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        aon_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        aon_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        aon_ss_iniu_node_top_wrap_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_aon_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         aon_ss_tniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         aon_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	output [69:0] aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	input  [9:0]  aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	input  [9:0]  aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	output [9:0]  aon_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	input  [12:0] aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                              ,
	output [12:0] aon_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                              ,
	input  [9:0]  aon_ss_tniu_node_top_wrap_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         debug_ss_iniu_node_top_wrap_clk_porting                                                                                                                    ,
	input         debug_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                  ,
	input  [69:0] debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                         ,
	output [15:0] debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                       ,
	output [15:0] debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                        ,
	input  [15:0] debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                       ,
	output [12:0] debug_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                            ,
	input  [12:0] debug_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                            ,
	output        debug_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                 ,
	output        debug_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                 ,
	output        debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last      ,
	output [39:0] debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload   ,
	output [3:0]  debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos       ,
	input         debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready     ,
	output [7:0]  debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid     ,
	output [7:0]  debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid     ,
	output        debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid     ,
	input         ucie_ss1_iniu_node_top_wrap_clk_porting                                                                                                                    ,
	input         ucie_ss1_iniu_node_top_wrap_rst_n_porting                                                                                                                  ,
	input  [69:0] ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                         ,
	output [15:0] ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                       ,
	output [15:0] ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                        ,
	input  [15:0] ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                       ,
	output [12:0] ucie_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                            ,
	input  [12:0] ucie_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                            ,
	output        ucie_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                 ,
	output        ucie_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                 ,
	output        ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last      ,
	output [39:0] ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload   ,
	output [3:0]  ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos       ,
	input         ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready     ,
	output [7:0]  ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid     ,
	output [7:0]  ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid     ,
	output        ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid     ,
	input         ucie_ss1_tniu_node_top_wrap_clk_porting                                                                                                                    ,
	input         ucie_ss1_tniu_node_top_wrap_rst_n_porting                                                                                                                  ,
	output [69:0] ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                         ,
	input  [9:0]  ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                       ,
	input  [9:0]  ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                        ,
	output [9:0]  ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                       ,
	input  [12:0] ucie_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                            ,
	output [12:0] ucie_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                            ,
	input  [9:0]  ucie_ss1_tniu_node_top_wrap_ucie_ss1_tniu_node_top_wrap_top_timeout_val_porting_ucie_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val            ,
	input         dspss0_tniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss0_tniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	output [69:0] dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	input  [9:0]  dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	input  [9:0]  dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	output [9:0]  dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	input  [12:0] dspss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                              ,
	output [12:0] dspss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                              ,
	input  [9:0]  dspss0_tniu_node_top_wrap_dspss0_tniu_node_top_wrap_top_timeout_val_porting_dspss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dspss1_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss1_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] dspss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] dspss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        dspss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        dspss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dspss2_tniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss2_tniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	output [69:0] dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	input  [9:0]  dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	input  [9:0]  dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	output [9:0]  dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	input  [12:0] dspss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                              ,
	output [12:0] dspss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                              ,
	input  [9:0]  dspss2_tniu_node_top_wrap_dspss2_tniu_node_top_wrap_top_timeout_val_porting_dspss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dspss3_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss3_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] dspss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] dspss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        dspss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        dspss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         dspss4_tniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss4_tniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	output [69:0] dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	input  [9:0]  dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	input  [9:0]  dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	output [9:0]  dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	input  [12:0] dspss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                              ,
	output [12:0] dspss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                              ,
	input  [9:0]  dspss4_tniu_node_top_wrap_dspss4_tniu_node_top_wrap_top_timeout_val_porting_dspss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                  ,
	input         dspss5_iniu_node_top_wrap_clk_porting                                                                                                                      ,
	input         dspss5_iniu_node_top_wrap_rst_n_porting                                                                                                                    ,
	input  [69:0] dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                           ,
	output [15:0] dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                         ,
	output [15:0] dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                          ,
	input  [15:0] dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                         ,
	output [12:0] dspss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                              ,
	input  [12:0] dspss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                              ,
	output        dspss5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                   ,
	output        dspss5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                   ,
	output        dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last            ,
	output [39:0] dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload         ,
	output [3:0]  dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos             ,
	input         dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready           ,
	output [7:0]  dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid           ,
	output [7:0]  dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid           ,
	output        dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid           ,
	input         ddr0_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr0_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr1_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr1_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr2_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr2_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr3_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr3_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr4_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr4_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         ddr5_iniu_node_top_wrap_clk_porting                                                                                                                        ,
	input         ddr5_iniu_node_top_wrap_rst_n_porting                                                                                                                      ,
	input  [69:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                             ,
	output [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                           ,
	output [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                            ,
	input  [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                           ,
	output [12:0] ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                ,
	input  [12:0] ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                ,
	output        ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last                                                                                ,
	output [39:0] ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload                                                                             ,
	output [3:0]  ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos                                                                                 ,
	input         ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready                                                                               ,
	output [7:0]  ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid                                                                               ,
	output [7:0]  ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid                                                                               ,
	output        ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid                                                                               ,
	input         ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last                                                                                   ,
	input  [39:0] ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload                                                                                ,
	input  [3:0]  ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos                                                                                    ,
	output        ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready                                                                                  ,
	input  [7:0]  ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid                                                                                  ,
	input  [7:0]  ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid                                                                                  ,
	input         ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid                                                                                  ,
	output        ddr5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                     ,
	output        ddr5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                     ,
	output        ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 );

	//Wire define for this module.

	//Wire define for sub module.
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr7_iniu_TO_u_ddr6_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr8_iniu_TO_u_ddr7_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr6_iniu_TO_u_ddr7_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr9_iniu_TO_u_ddr8_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr7_iniu_TO_u_ddr8_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr10_iniu_TO_u_ddr9_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ddr8_iniu_TO_u_ddr9_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ddr11_tniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_ddr9_iniu_TO_u_ddr10_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_ddr10_iniu_TO_u_ddr11_tniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready         ;
	wire        u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last        ;
	wire [39:0] u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload     ;
	wire [3:0]  u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos         ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid       ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid       ;
	wire        u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid       ;
	wire        u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last        ;
	wire [39:0] u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload     ;
	wire [3:0]  u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos         ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid       ;
	wire [7:0]  u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid       ;
	wire        u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid       ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready         ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready    ;
	wire        u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last   ;
	wire [39:0] u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload;
	wire [3:0]  u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid  ;
	wire        u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid  ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_last   ;
	wire [39:0] u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_payload;
	wire [3:0]  u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid  ;
	wire        u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_valid  ;
	wire        u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ready    ;
	wire        u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_aon_ss_iniu_TO_u_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_vpu_ss_iniu_TO_u_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_dspss1_iniu_TO_u_dspss0_tniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_dspss2_tniu_TO_u_dspss1_iniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_dspss0_tniu_TO_u_dspss1_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_dspss3_iniu_TO_u_dspss2_tniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_dspss1_iniu_TO_u_dspss2_tniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_dspss4_tniu_TO_u_dspss3_iniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_dspss2_tniu_TO_u_dspss3_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_dspss5_iniu_TO_u_dspss4_tniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_dspss3_iniu_TO_u_dspss4_tniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_ddr0_iniu_TO_u_dspss5_iniu_SIG_pring_in_if_pring_in_if_ready            ;
	wire        u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_last           ;
	wire [39:0] u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_tgtid          ;
	wire        u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_valid          ;
	wire        u_dspss4_tniu_TO_u_dspss5_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last           ;
	wire [39:0] u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid          ;
	wire        u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid          ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_dspss5_iniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready            ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_pring_in_if_pring_in_if_ready              ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_last             ;
	wire [39:0] u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_tgtid            ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_valid            ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_nring_in_if_nring_in_if_ready              ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_last             ;
	wire [39:0] u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_tgtid            ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_valid            ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_nring_in_if_nring_in_if_ready              ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	ddr6_iniu_node_top_wrap u_ddr6_iniu (
		.clk(ddr6_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr6_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr6_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr6_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_payload(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_qos(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_ready(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_tgtid(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_valid(ddr6_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid),
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
		.nring_out_if_nring_out_if_last(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_srcid(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(ddr6_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid),
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
		.pring_out_if_pring_out_if_last(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid),
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
	ddr11_tniu_node_top_wrap u_ddr11_tniu (
		.clk(ddr11_tniu_node_top_wrap_clk_porting),
		.rst_n(ddr11_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr11_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(ddr11_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ddr11_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr10_iniu_TO_u_ddr11_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr11_tniu_TO_u_ddr10_iniu_SIG_nring_out_if_nring_out_if_valid),
		.ddr11_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(ddr11_tniu_node_top_wrap_ddr11_tniu_node_top_wrap_top_timeout_val_porting_ddr11_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	mipi_ss_iniu_node_top_wrap u_mipi_ss_iniu (
		.clk(mipi_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(mipi_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mipi_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(mipi_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr11_tniu_TO_u_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_mipi_ss_iniu_TO_u_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(mipi_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(mipi_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(mipi_ss_iniu_node_top_wrap_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mipi_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ufs_ss_iniu_node_top_wrap u_ufs_ss_iniu (
		.clk(ufs_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(ufs_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_mipi_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ufs_ss_iniu_TO_u_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ufs_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ufs_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	camera_ss_iniu_node_top_wrap u_camera_ss_iniu (
		.clk(camera_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(camera_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(camera_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(camera_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	camera_ss_tniu_node_top_wrap u_camera_ss_tniu (
		.clk(camera_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(camera_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(camera_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(camera_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_camera_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_camera_ss_tniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(camera_ss_tniu_node_top_wrap_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	vpu_ss_iniu_node_top_wrap u_vpu_ss_iniu (
		.clk(vpu_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(vpu_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(vpu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(vpu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
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
		.nring_out_if_nring_out_if_last(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_camera_ss_tniu_TO_u_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_vpu_ss_iniu_TO_u_camera_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
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
		.pring_out_if_pring_out_if_last(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_aon_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_aon_ss_tniu_TO_u_aon_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(aon_ss_tniu_node_top_wrap_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_aon_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	debug_ss_iniu_node_top_wrap u_debug_ss_iniu (
		.clk(debug_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(debug_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(debug_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(debug_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(debug_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_aon_ss_tniu_TO_u_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_debug_ss_iniu_TO_u_aon_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(debug_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(debug_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(debug_ss_iniu_node_top_wrap_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_debug_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ucie_ss1_iniu_node_top_wrap u_ucie_ss1_iniu (
		.clk(ucie_ss1_iniu_node_top_wrap_clk_porting),
		.rst_n(ucie_ss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ucie_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ucie_ss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_debug_ss_iniu_TO_u_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ucie_ss1_iniu_TO_u_debug_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ucie_ss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ucie_ss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ucie_ss1_iniu_node_top_wrap_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_ucie_ss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ucie_ss1_tniu_node_top_wrap u_ucie_ss1_tniu (
		.clk(ucie_ss1_tniu_node_top_wrap_clk_porting),
		.rst_n(ucie_ss1_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ucie_ss1_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(ucie_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ucie_ss1_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ucie_ss1_iniu_TO_u_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ucie_ss1_tniu_TO_u_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.ucie_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(ucie_ss1_tniu_node_top_wrap_ucie_ss1_tniu_node_top_wrap_top_timeout_val_porting_ucie_ss1_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dspss0_tniu_node_top_wrap u_dspss0_tniu (
		.clk(dspss0_tniu_node_top_wrap_clk_porting),
		.rst_n(dspss0_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss0_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dspss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss0_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ucie_ss1_tniu_TO_u_dspss0_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss0_tniu_TO_u_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_valid),
		.dspss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dspss0_tniu_node_top_wrap_dspss0_tniu_node_top_wrap_top_timeout_val_porting_dspss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dspss1_iniu_node_top_wrap u_dspss1_iniu (
		.clk(dspss1_iniu_node_top_wrap_clk_porting),
		.rst_n(dspss1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss0_tniu_TO_u_dspss1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss1_iniu_TO_u_dspss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dspss1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dspss1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dspss1_iniu_node_top_wrap_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_dspss1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dspss2_tniu_node_top_wrap u_dspss2_tniu (
		.clk(dspss2_tniu_node_top_wrap_clk_porting),
		.rst_n(dspss2_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss2_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dspss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss2_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss1_iniu_TO_u_dspss2_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss2_tniu_TO_u_dspss1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dspss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dspss2_tniu_node_top_wrap_dspss2_tniu_node_top_wrap_top_timeout_val_porting_dspss2_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dspss3_iniu_node_top_wrap u_dspss3_iniu (
		.clk(dspss3_iniu_node_top_wrap_clk_porting),
		.rst_n(dspss3_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss2_tniu_TO_u_dspss3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss3_iniu_TO_u_dspss2_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dspss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dspss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dspss3_iniu_node_top_wrap_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_dspss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	dspss4_tniu_node_top_wrap u_dspss4_tniu (
		.clk(dspss4_tniu_node_top_wrap_clk_porting),
		.rst_n(dspss4_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(dspss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(dspss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss3_iniu_TO_u_dspss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss4_tniu_TO_u_dspss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.dspss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(dspss4_tniu_node_top_wrap_dspss4_tniu_node_top_wrap_top_timeout_val_porting_dspss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	dspss5_iniu_node_top_wrap u_dspss5_iniu (
		.clk(dspss5_iniu_node_top_wrap_clk_porting),
		.rst_n(dspss5_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dspss5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dspss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dspss5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss4_tniu_TO_u_dspss5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_dspss5_iniu_TO_u_dspss4_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(dspss5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(dspss5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(dspss5_iniu_node_top_wrap_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_dspss5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr0_iniu_node_top_wrap u_ddr0_iniu (
		.clk(ddr0_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_dspss5_iniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr0_iniu_TO_u_dspss5_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr1_iniu_node_top_wrap u_ddr1_iniu (
		.clk(ddr1_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr1_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr0_iniu_TO_u_ddr1_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr2_iniu_node_top_wrap u_ddr2_iniu (
		.clk(ddr2_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr2_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr1_iniu_TO_u_ddr2_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr3_iniu_node_top_wrap u_ddr3_iniu (
		.clk(ddr3_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr3_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr2_iniu_TO_u_ddr3_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr4_iniu_node_top_wrap u_ddr4_iniu (
		.clk(ddr4_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr4_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr3_iniu_TO_u_ddr4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ddr5_iniu_node_top_wrap u_ddr5_iniu (
		.clk(ddr5_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr5_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_srcid(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(ddr5_iniu_node_top_wrap_pring_out_if_porting_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_payload(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_qos(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_ready(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_tgtid(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_valid(ddr5_iniu_node_top_wrap_nring_in_if_porting_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_last(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr4_iniu_TO_u_ddr5_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ddr5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ddr5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));

endmodule
//[UHDL]Content End [md5:8519f8bba7b001e32e963b10045fd6df]


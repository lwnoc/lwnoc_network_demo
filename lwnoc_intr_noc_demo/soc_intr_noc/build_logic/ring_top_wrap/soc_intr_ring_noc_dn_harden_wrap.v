//[UHDL]Content Start [md5:5609b2cbe8c5040bd12c8ce5a682128a]
module soc_intr_ring_noc_dn_harden_wrap (
	input         npu_ss3_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         npu_ss3_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] npu_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] npu_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	input         npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last                                                                                      ,
	input  [39:0] npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload                                                                                   ,
	input  [3:0]  npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos                                                                                       ,
	output        npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready                                                                                     ,
	input  [7:0]  npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid                                                                                     ,
	input  [7:0]  npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid                                                                                     ,
	input         npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid                                                                                     ,
	output        npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last                                                                                   ,
	output [39:0] npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload                                                                                ,
	output [3:0]  npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos                                                                                    ,
	input         npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready                                                                                  ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid                                                                                  ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid                                                                                  ,
	output        npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid                                                                                  ,
	output        npu_ss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        npu_ss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         npu_ss3_tniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         npu_ss3_tniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	output [69:0] npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	input  [15:0] npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	input  [15:0] npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	output [15:0] npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	input  [12:0] npu_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                   ,
	output [12:0] npu_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                   ,
	input  [9:0]  npu_ss3_tniu_node_top_wrap_npu_ss3_tniu_node_top_wrap_top_timeout_val_porting_npu_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         peri_ss_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         peri_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] peri_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] peri_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        peri_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        peri_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         gpu_ss0_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         gpu_ss0_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] gpu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] gpu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        gpu_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        gpu_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         camera_ss_iniu_node_top_wrap_clk_porting                                                                                                                         ,
	input         camera_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                       ,
	input  [69:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                              ,
	output [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                            ,
	output [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                             ,
	input  [15:0] camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                            ,
	output [12:0] camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                 ,
	input  [12:0] camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                 ,
	output        camera_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                      ,
	output        camera_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                      ,
	output        camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last         ,
	output [39:0] camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload      ,
	output [3:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos          ,
	input         camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready        ,
	output [7:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid        ,
	output [7:0]  camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid        ,
	output        camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid        ,
	input         ufs_ss_iniu_node_top_wrap_clk_porting                                                                                                                            ,
	input         ufs_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                          ,
	input  [69:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                 ,
	output [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                               ,
	output [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                ,
	input  [15:0] ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                               ,
	output [12:0] ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                    ,
	input  [12:0] ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                    ,
	output        ufs_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                         ,
	output        ufs_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                         ,
	output        ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         pcie_eth_ss_iniu_node_top_wrap_clk_porting                                                                                                                       ,
	input         pcie_eth_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                     ,
	input  [69:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                            ,
	output [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                          ,
	output [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                           ,
	input  [15:0] pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                          ,
	output [12:0] pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                               ,
	input  [12:0] pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                               ,
	output        pcie_eth_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                    ,
	output        pcie_eth_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                    ,
	output        pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last   ,
	output [39:0] pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload,
	output [3:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos    ,
	input         pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready  ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid  ,
	output [7:0]  pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid  ,
	output        pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid  ,
	input         mcu_ss_iniu_node_top_wrap_clk_porting                                                                                                                            ,
	input         mcu_ss_iniu_node_top_wrap_rst_n_porting                                                                                                                          ,
	input  [69:0] mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                 ,
	output [15:0] mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                               ,
	output [15:0] mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                ,
	input  [15:0] mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                               ,
	output [12:0] mcu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                    ,
	input  [12:0] mcu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                    ,
	output        mcu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                         ,
	output        mcu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                         ,
	output        mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                  ,
	output [39:0] mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload               ,
	output [3:0]  mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                   ,
	input         mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                 ,
	output [7:0]  mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                 ,
	output [7:0]  mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                 ,
	output        mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                 ,
	input         mcu_ss_tniu_node_top_wrap_clk_porting                                                                                                                            ,
	input         mcu_ss_tniu_node_top_wrap_rst_n_porting                                                                                                                          ,
	output [69:0] mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                 ,
	input  [15:0] mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                               ,
	input  [15:0] mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                ,
	output [15:0] mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                               ,
	input  [12:0] mcu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                    ,
	output [12:0] mcu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                    ,
	input  [9:0]  mcu_ss_tniu_node_top_wrap_mcu_ss_tniu_node_top_wrap_top_timeout_val_porting_mcu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                        ,
	input         npu_ss4_iniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         npu_ss4_iniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	input  [69:0] npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	output [15:0] npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	output [15:0] npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	input  [15:0] npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	output [12:0] npu_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                   ,
	input  [12:0] npu_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                   ,
	output        npu_ss4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                        ,
	output        npu_ss4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                        ,
	output        npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last               ,
	output [39:0] npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload            ,
	output [3:0]  npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                ,
	input         npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready              ,
	output [7:0]  npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid              ,
	output [7:0]  npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid              ,
	output        npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid              ,
	input         npu_ss4_tniu_node_top_wrap_clk_porting                                                                                                                           ,
	input         npu_ss4_tniu_node_top_wrap_rst_n_porting                                                                                                                         ,
	output [69:0] npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                ,
	input  [15:0] npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                              ,
	input  [15:0] npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                               ,
	output [15:0] npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                              ,
	input  [12:0] npu_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req                                                                                   ,
	output [12:0] npu_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req                                                                                   ,
	input  [9:0]  npu_ss4_tniu_node_top_wrap_npu_ss4_tniu_node_top_wrap_top_timeout_val_porting_npu_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val                     ,
	input         ddr0_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr0_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr0_iniu_node_top_wrap_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_ddr0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	input         ddr1_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr1_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr1_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr1_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr1_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr1_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr1_iniu_node_top_wrap_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_ddr1_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	input         ddr2_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr2_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr2_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr2_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr2_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr2_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr2_iniu_node_top_wrap_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_ddr2_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	input         ddr3_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr3_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr3_iniu_node_top_wrap_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_ddr3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	input         ddr4_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr4_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr4_iniu_node_top_wrap_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_ddr4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	input         ddr5_iniu_node_top_wrap_clk_porting                                                                                                                              ,
	input         ddr5_iniu_node_top_wrap_rst_n_porting                                                                                                                            ,
	input  [69:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync                                                                                                   ,
	output [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async                                                                                                 ,
	output [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync                                                                                                  ,
	input  [15:0] ddr5_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async                                                                                                 ,
	output [12:0] ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req                                                                                      ,
	input  [12:0] ddr5_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req                                                                                      ,
	output        ddr5_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err                                                                                           ,
	output        ddr5_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err                                                                                           ,
	output        ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last                        ,
	output [39:0] ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload                     ,
	output [3:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos                         ,
	input         ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready                       ,
	output [7:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid                       ,
	output [7:0]  ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid                       ,
	output        ddr5_iniu_node_top_wrap_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_ddr5_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid                       ,
	output        ring_sp_pring_out_if_porting_pring_out_if_last                                                                                                                   ,
	output [39:0] ring_sp_pring_out_if_porting_pring_out_if_payload                                                                                                                ,
	output [3:0]  ring_sp_pring_out_if_porting_pring_out_if_qos                                                                                                                    ,
	input         ring_sp_pring_out_if_porting_pring_out_if_ready                                                                                                                  ,
	output [7:0]  ring_sp_pring_out_if_porting_pring_out_if_srcid                                                                                                                  ,
	output [7:0]  ring_sp_pring_out_if_porting_pring_out_if_tgtid                                                                                                                  ,
	output        ring_sp_pring_out_if_porting_pring_out_if_valid                                                                                                                  ,
	input         ring_sp_nring_in_if_porting_nring_in_if_last                                                                                                                     ,
	input  [39:0] ring_sp_nring_in_if_porting_nring_in_if_payload                                                                                                                  ,
	input  [3:0]  ring_sp_nring_in_if_porting_nring_in_if_qos                                                                                                                      ,
	output        ring_sp_nring_in_if_porting_nring_in_if_ready                                                                                                                    ,
	input  [7:0]  ring_sp_nring_in_if_porting_nring_in_if_srcid                                                                                                                    ,
	input  [7:0]  ring_sp_nring_in_if_porting_nring_in_if_tgtid                                                                                                                    ,
	input         ring_sp_nring_in_if_porting_nring_in_if_valid                                                                                                                    ,
	input         u_ring_sink_station_clk_porting                                                                                                                                  ,
	input         u_ring_sink_station_rst_n_porting                                                                                                                                );

	//Wire define for this module.

	//Wire define for sub module.
	wire        u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready     ;
	wire        u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_last    ;
	wire [39:0] u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload ;
	wire [3:0]  u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos     ;
	wire [7:0]  u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid   ;
	wire [7:0]  u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid   ;
	wire        u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid   ;
	wire        u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last    ;
	wire [39:0] u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload ;
	wire [3:0]  u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos     ;
	wire [7:0]  u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid   ;
	wire [7:0]  u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid   ;
	wire        u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid   ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready      ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last     ;
	wire [39:0] u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid    ;
	wire        u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid    ;
	wire        u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready     ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last     ;
	wire [39:0] u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid    ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid    ;
	wire        u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready    ;
	wire        u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last   ;
	wire [39:0] u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload;
	wire [3:0]  u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid  ;
	wire        u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid  ;
	wire        u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready      ;
	wire        u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_last   ;
	wire [39:0] u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_payload;
	wire [3:0]  u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid  ;
	wire        u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_valid  ;
	wire        u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready    ;
	wire        u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last   ;
	wire [39:0] u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload;
	wire [3:0]  u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid  ;
	wire        u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid  ;
	wire        u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ready    ;
	wire        u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_last   ;
	wire [39:0] u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_payload;
	wire [3:0]  u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid  ;
	wire        u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_valid  ;
	wire        u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_pring_in_if_pring_in_if_ready         ;
	wire        u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_last        ;
	wire [39:0] u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_payload     ;
	wire [3:0]  u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_qos         ;
	wire [7:0]  u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid       ;
	wire [7:0]  u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid       ;
	wire        u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_valid       ;
	wire        u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_nring_in_if_nring_in_if_ready    ;
	wire        u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_last        ;
	wire [39:0] u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_payload     ;
	wire [3:0]  u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_qos         ;
	wire [7:0]  u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid       ;
	wire [7:0]  u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid       ;
	wire        u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_valid       ;
	wire        u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_pring_in_if_pring_in_if_ready        ;
	wire        u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_last       ;
	wire [39:0] u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_payload    ;
	wire [3:0]  u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_qos        ;
	wire [7:0]  u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid      ;
	wire [7:0]  u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid      ;
	wire        u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_valid      ;
	wire        u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_nring_in_if_nring_in_if_ready         ;
	wire        u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_last       ;
	wire [39:0] u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_payload    ;
	wire [3:0]  u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_qos        ;
	wire [7:0]  u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid      ;
	wire [7:0]  u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid      ;
	wire        u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_valid      ;
	wire        u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_pring_in_if_pring_in_if_ready       ;
	wire        u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_last      ;
	wire [39:0] u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid     ;
	wire        u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_valid     ;
	wire        u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_nring_in_if_nring_in_if_ready        ;
	wire        u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_last      ;
	wire [39:0] u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire        u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_valid     ;
	wire        u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_pring_in_if_pring_in_if_ready          ;
	wire        u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_last         ;
	wire [39:0] u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid        ;
	wire        u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_valid        ;
	wire        u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last         ;
	wire [39:0] u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid        ;
	wire        u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid        ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr1_iniu_TO_u_ddr0_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready          ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr2_iniu_TO_u_ddr1_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ddr0_iniu_TO_u_ddr1_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr3_iniu_TO_u_ddr2_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ddr1_iniu_TO_u_ddr2_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr4_iniu_TO_u_ddr3_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ddr2_iniu_TO_u_ddr3_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_pring_in_if_pring_in_if_ready             ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_last            ;
	wire [39:0] u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_tgtid           ;
	wire        u_ddr5_iniu_TO_u_ddr4_iniu_SIG_nring_out_if_nring_out_if_valid           ;
	wire        u_ddr3_iniu_TO_u_ddr4_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_last            ;
	wire [39:0] u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_tgtid           ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_pring_out_if_pring_out_if_valid           ;
	wire        u_ring_sink_station_TO_u_ddr5_iniu_SIG_pring_in_if_pring_in_if_ready     ;
	wire        u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_last    ;
	wire [39:0] u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_payload ;
	wire [3:0]  u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_qos     ;
	wire [7:0]  u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_srcid   ;
	wire [7:0]  u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_tgtid   ;
	wire        u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_valid   ;
	wire        u_ddr4_iniu_TO_u_ddr5_iniu_SIG_nring_in_if_nring_in_if_ready             ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_valid     ;
	wire [39:0] u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_payload   ;
	wire [7:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_tgtid     ;
	wire [3:0]  u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_qos       ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_last      ;
	wire        u_ring_sink_station_TO_u_ring_sp_SIG_nring_in_if_nring_in_if_ready       ;
	wire        u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last    ;
	wire [39:0] u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload ;
	wire [3:0]  u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos     ;
	wire [7:0]  u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid   ;
	wire [7:0]  u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid   ;
	wire        u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid   ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_pring_in_if_ready                   ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_last                   ;
	wire [39:0] u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_payload                ;
	wire [3:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_qos                    ;
	wire [7:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_srcid                  ;
	wire [7:0]  u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_tgtid                  ;
	wire        u_ring_sp_TO_u_ring_sink_station_SIG_nring_out_if_valid                  ;
	wire        u_ddr5_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	npu_ss3_iniu_node_top_wrap u_npu_ss3_iniu (
		.clk(npu_ss3_iniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss3_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss3_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(npu_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(npu_ss3_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_payload(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_qos(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_ready(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_tgtid(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_valid(npu_ss3_iniu_node_top_wrap_pring_in_if_porting_pring_in_if_pring_in_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_srcid(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(npu_ss3_iniu_node_top_wrap_nring_out_if_porting_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(npu_ss3_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(npu_ss3_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(npu_ss3_iniu_node_top_wrap_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	npu_ss3_tniu_node_top_wrap u_npu_ss3_tniu (
		.clk(npu_ss3_tniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss3_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss3_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(npu_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(npu_ss3_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss3_iniu_TO_u_npu_ss3_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss3_tniu_TO_u_npu_ss3_iniu_SIG_nring_out_if_nring_out_if_valid),
		.npu_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(npu_ss3_tniu_node_top_wrap_npu_ss3_tniu_node_top_wrap_top_timeout_val_porting_npu_ss3_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	peri_ss_iniu_node_top_wrap u_peri_ss_iniu (
		.clk(peri_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(peri_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(peri_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(peri_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(peri_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss3_tniu_TO_u_peri_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_peri_ss_iniu_TO_u_npu_ss3_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(peri_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(peri_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(peri_ss_iniu_node_top_wrap_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_peri_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	gpu_ss0_iniu_node_top_wrap u_gpu_ss0_iniu (
		.clk(gpu_ss0_iniu_node_top_wrap_clk_porting),
		.rst_n(gpu_ss0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(gpu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(gpu_ss0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_peri_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_gpu_ss0_iniu_TO_u_peri_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(gpu_ss0_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(gpu_ss0_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(gpu_ss0_iniu_node_top_wrap_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_gpu_ss0_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	camera_ss_iniu_node_top_wrap u_camera_ss_iniu (
		.clk(camera_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(camera_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(camera_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(camera_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_gpu_ss0_iniu_TO_u_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_camera_ss_iniu_TO_u_gpu_ss0_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(camera_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(camera_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(camera_ss_iniu_node_top_wrap_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_camera_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	ufs_ss_iniu_node_top_wrap u_ufs_ss_iniu (
		.clk(ufs_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(ufs_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ufs_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ufs_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_camera_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ufs_ss_iniu_TO_u_camera_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(ufs_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(ufs_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(ufs_ss_iniu_node_top_wrap_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_ufs_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	pcie_eth_ss_iniu_node_top_wrap u_pcie_eth_ss_iniu (
		.clk(pcie_eth_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(pcie_eth_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(pcie_eth_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(pcie_eth_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ufs_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_pcie_eth_ss_iniu_TO_u_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(pcie_eth_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(pcie_eth_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(pcie_eth_ss_iniu_node_top_wrap_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_pcie_eth_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	mcu_ss_iniu_node_top_wrap u_mcu_ss_iniu (
		.clk(mcu_ss_iniu_node_top_wrap_clk_porting),
		.rst_n(mcu_ss_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mcu_ss_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(mcu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(mcu_ss_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_pcie_eth_ss_iniu_TO_u_mcu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_mcu_ss_iniu_TO_u_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(mcu_ss_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(mcu_ss_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(mcu_ss_iniu_node_top_wrap_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_mcu_ss_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	mcu_ss_tniu_node_top_wrap u_mcu_ss_tniu (
		.clk(mcu_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(mcu_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(mcu_ss_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(mcu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(mcu_ss_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_mcu_ss_iniu_TO_u_mcu_ss_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_mcu_ss_tniu_TO_u_mcu_ss_iniu_SIG_nring_out_if_nring_out_if_valid),
		.mcu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(mcu_ss_tniu_node_top_wrap_mcu_ss_tniu_node_top_wrap_top_timeout_val_porting_mcu_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	npu_ss4_iniu_node_top_wrap u_npu_ss4_iniu (
		.clk(npu_ss4_iniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss4_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss4_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(npu_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(npu_ss4_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_mcu_ss_tniu_TO_u_npu_ss4_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss4_iniu_TO_u_mcu_ss_tniu_SIG_nring_out_if_nring_out_if_valid),
		.afifo_sb_err_afifo_sb_err(npu_ss4_iniu_node_top_wrap_afifo_sb_err_porting_afifo_sb_err_afifo_sb_err),
		.afifo_db_err_afifo_db_err(npu_ss4_iniu_node_top_wrap_afifo_db_err_porting_afifo_db_err_afifo_db_err),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid(npu_ss4_iniu_node_top_wrap_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_npu_ss4_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid));
	npu_ss4_tniu_node_top_wrap u_npu_ss4_tniu (
		.clk(npu_ss4_tniu_node_top_wrap_clk_porting),
		.rst_n(npu_ss4_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(npu_ss4_tniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(npu_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(npu_ss4_tniu_node_top_wrap_lp_async_porting_lp_async_s_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss4_iniu_TO_u_npu_ss4_tniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_npu_ss4_tniu_TO_u_npu_ss4_iniu_SIG_nring_out_if_nring_out_if_valid),
		.npu_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(npu_ss4_tniu_node_top_wrap_npu_ss4_tniu_node_top_wrap_top_timeout_val_porting_npu_ss4_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));
	ddr0_iniu_node_top_wrap u_ddr0_iniu (
		.clk(ddr0_iniu_node_top_wrap_clk_porting),
		.rst_n(ddr0_iniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr0_iniu_node_top_wrap_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr0_iniu_node_top_wrap_lp_async_porting_lp_async_m_async_master_hub_tx_req),
		.pring_in_if_pring_in_if_last(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_pring_out_if_pring_out_if_valid),
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
		.nring_out_if_nring_out_if_last(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_npu_ss4_tniu_TO_u_ddr0_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ddr0_iniu_TO_u_npu_ss4_tniu_SIG_nring_out_if_nring_out_if_valid),
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
		.pring_out_if_pring_out_if_last(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(u_ring_sink_station_TO_u_ddr5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(u_ddr5_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_valid),
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
	lwnoc_intr_ring_sp_wrap u_ring_sp (
		.clk(u_ring_sink_station_clk_porting),
		.pring_in_if_valid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_valid),
		.pring_in_if_ready(u_ring_sp_TO_u_ring_sink_station_SIG_pring_in_if_ready),
		.pring_in_if_payload(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_srcid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_tgtid(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_qos(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_last(u_ring_sink_station_TO_u_ring_sp_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_valid(ring_sp_pring_out_if_porting_pring_out_if_valid),
		.pring_out_if_ready(ring_sp_pring_out_if_porting_pring_out_if_ready),
		.pring_out_if_payload(ring_sp_pring_out_if_porting_pring_out_if_payload),
		.pring_out_if_srcid(ring_sp_pring_out_if_porting_pring_out_if_srcid),
		.pring_out_if_tgtid(ring_sp_pring_out_if_porting_pring_out_if_tgtid),
		.pring_out_if_qos(ring_sp_pring_out_if_porting_pring_out_if_qos),
		.pring_out_if_last(ring_sp_pring_out_if_porting_pring_out_if_last),
		.nring_in_if_valid(ring_sp_nring_in_if_porting_nring_in_if_valid),
		.nring_in_if_ready(ring_sp_nring_in_if_porting_nring_in_if_ready),
		.nring_in_if_payload(ring_sp_nring_in_if_porting_nring_in_if_payload),
		.nring_in_if_srcid(ring_sp_nring_in_if_porting_nring_in_if_srcid),
		.nring_in_if_tgtid(ring_sp_nring_in_if_porting_nring_in_if_tgtid),
		.nring_in_if_qos(ring_sp_nring_in_if_porting_nring_in_if_qos),
		.nring_in_if_last(ring_sp_nring_in_if_porting_nring_in_if_last),
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
		.pring_in_if_pring_in_if_last(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(u_ring_sink_station_TO_u_ddr5_iniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(u_ddr5_iniu_TO_u_ring_sink_station_SIG_pring_out_if_pring_out_if_valid),
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
		.nring_out_if_nring_out_if_last(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(u_ddr5_iniu_TO_u_ring_sink_station_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(u_ring_sink_station_TO_u_ddr5_iniu_SIG_nring_out_if_nring_out_if_valid));

endmodule
//[UHDL]Content End [md5:5609b2cbe8c5040bd12c8ce5a682128a]


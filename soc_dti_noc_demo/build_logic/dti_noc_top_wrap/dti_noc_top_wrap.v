//[UHDL]Content Start [md5:b7a252ad089e3a1d9a04d865845bad91]
module dti_noc_top_wrap (
	input          npu_ss0_top_wrap_clk_noc_porting                                                                                                    ,
	input          npu_ss0_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  npu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  npu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         npu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         npu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          npu_ss3_top_wrap_clk_noc_porting                                                                                                    ,
	input          npu_ss3_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  npu_ss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  npu_ss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         npu_ss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         npu_ss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          npu_ss4_top_wrap_clk_noc_porting                                                                                                    ,
	input          npu_ss4_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  npu_ss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  npu_ss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         npu_ss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         npu_ss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          npu_ss2_top_wrap_clk_noc_porting                                                                                                    ,
	input          npu_ss2_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  npu_ss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  npu_ss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         npu_ss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         npu_ss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          npu_ss1_top_wrap_clk_noc_porting                                                                                                    ,
	input          npu_ss1_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  npu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  npu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         npu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         npu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          peri_ss_top_wrap_clk_noc_porting                                                                                                    ,
	input          peri_ss_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  peri_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  peri_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         peri_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         peri_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          ufs_ss_top_wrap_clk_noc_porting                                                                                                     ,
	input          ufs_ss_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  ufs_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  ufs_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         ufs_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         ufs_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          pcie_eth_ss_top_wrap_clk_noc_porting                                                                                                ,
	input          pcie_eth_ss_top_wrap_rst_noc_n_porting                                                                                              ,
	input  [112:0] pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                     ,
	output [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                   ,
	output [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                    ,
	input  [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                   ,
	output [112:0] pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                     ,
	input  [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                   ,
	input  [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                    ,
	output [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                   ,
	output [12:0]  pcie_eth_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                      ,
	input  [12:0]  pcie_eth_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                      ,
	output         pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                             ,
	output         pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                             ,
	input          gpu_ss0_top_wrap_clk_noc_porting                                                                                                    ,
	input          gpu_ss0_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  gpu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  gpu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         gpu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         gpu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          dspss0_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss0_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          dspss1_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss1_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          dspss2_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss2_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          dspss3_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss3_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          dspss4_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss4_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          dspss5_top_wrap_clk_noc_porting                                                                                                     ,
	input          dspss5_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] dspss5_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  dspss5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  dspss5_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         dspss5_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         dspss5_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          camera_ss_top_wrap_clk_noc_porting                                                                                                  ,
	input          camera_ss_top_wrap_rst_noc_n_porting                                                                                                ,
	input  [112:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                       ,
	output [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                     ,
	output [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                      ,
	input  [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                     ,
	output [112:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                       ,
	input  [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                     ,
	input  [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                      ,
	output [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                     ,
	output [12:0]  camera_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                        ,
	input  [12:0]  camera_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                        ,
	output         camera_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                               ,
	output         camera_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                               ,
	input          mipi_ss_top_wrap_clk_noc_porting                                                                                                    ,
	input          mipi_ss_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  mipi_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  mipi_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         mipi_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         mipi_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          gpu_ss1_top_wrap_clk_noc_porting                                                                                                    ,
	input          gpu_ss1_top_wrap_rst_noc_n_porting                                                                                                  ,
	input  [112:0] gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,
	output [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,
	output [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,
	input  [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,
	output [112:0] gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,
	input  [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,
	input  [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,
	output [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,
	output [12:0]  gpu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,
	input  [12:0]  gpu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,
	output         gpu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,
	output         gpu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,
	input          usb_dp_ss_top_wrap_clk_noc_porting                                                                                                  ,
	input          usb_dp_ss_top_wrap_rst_noc_n_porting                                                                                                ,
	input  [112:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                       ,
	output [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                     ,
	output [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                      ,
	input  [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                     ,
	output [112:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                       ,
	input  [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                     ,
	input  [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                      ,
	output [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                     ,
	output [12:0]  usb_dp_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                        ,
	input  [12:0]  usb_dp_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                        ,
	output         usb_dp_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                               ,
	output         usb_dp_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                               ,
	input          display_ss_top_wrap_clk_noc_porting                                                                                                 ,
	input          display_ss_top_wrap_rst_noc_n_porting                                                                                               ,
	input  [112:0] display_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                      ,
	output [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                    ,
	output [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                     ,
	input  [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                    ,
	output [112:0] display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                      ,
	input  [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                    ,
	input  [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                     ,
	output [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                    ,
	output [12:0]  display_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                       ,
	input  [12:0]  display_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                       ,
	output         display_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                              ,
	output         display_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                              ,
	input          vpu_ss_top_wrap_clk_noc_porting                                                                                                     ,
	input          vpu_ss_top_wrap_rst_noc_n_porting                                                                                                   ,
	input  [112:0] vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,
	output [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,
	output [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,
	input  [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,
	output [112:0] vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,
	input  [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,
	input  [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,
	output [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,
	output [12:0]  vpu_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,
	input  [12:0]  vpu_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,
	output         vpu_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,
	output         vpu_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,
	input          cpu_ss_tniu0_top_wrap_clk_noc_porting                                                                                               ,
	input          cpu_ss_tniu0_top_wrap_rst_noc_n_porting                                                                                             ,
	output [112:0] cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                    ,
	input  [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                  ,
	input  [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                   ,
	output [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                  ,
	input  [112:0] cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                    ,
	output [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                  ,
	output [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                   ,
	input  [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                  ,
	output [12:0]  cpu_ss_tniu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                     ,
	input  [12:0]  cpu_ss_tniu0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                     ,
	output         cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,
	output         cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err,
	input          cpu_ss_tniu1_top_wrap_clk_noc_porting                                                                                               ,
	input          cpu_ss_tniu1_top_wrap_rst_noc_n_porting                                                                                             ,
	output [112:0] cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                    ,
	input  [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                  ,
	input  [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                   ,
	output [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                  ,
	input  [112:0] cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                    ,
	output [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                  ,
	output [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                   ,
	input  [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                  ,
	output [12:0]  cpu_ss_tniu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                     ,
	input  [12:0]  cpu_ss_tniu1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                     ,
	output         cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,
	output         cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err,
	input          u_bottom_merge0_clk_noc_porting                                                                                                     ,
	input          u_bottom_merge0_rst_noc_n_porting                                                                                                   );

	//Wire define for this module.

	//Wire define for sub module.
	wire        u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_ready                ;
	wire        u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_threshold            ;
	wire        u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_last                 ;
	wire [89:0] u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_payload              ;
	wire        u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_qos                  ;
	wire [5:0]  u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_srcid                ;
	wire [5:0]  u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_tgtid                ;
	wire        u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_valid                ;
	wire        u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_ready            ;
	wire        u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_threshold        ;
	wire        u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_last             ;
	wire [89:0] u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_payload          ;
	wire        u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_qos              ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_srcid            ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_tgtid            ;
	wire        u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_valid            ;
	wire        u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_ready            ;
	wire        u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_threshold        ;
	wire        u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_last             ;
	wire [89:0] u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_payload          ;
	wire        u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_qos              ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_srcid            ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_tgtid            ;
	wire        u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_valid            ;
	wire        u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_ready            ;
	wire        u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_threshold        ;
	wire        u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_last             ;
	wire [89:0] u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_payload          ;
	wire        u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_qos              ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_srcid            ;
	wire [5:0]  u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_tgtid            ;
	wire        u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_valid            ;
	wire        u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_ready                ;
	wire        u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_threshold            ;
	wire        u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_last                 ;
	wire [89:0] u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_payload              ;
	wire        u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_qos                  ;
	wire [5:0]  u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_srcid                ;
	wire [5:0]  u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_tgtid                ;
	wire        u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_valid                ;
	wire        u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_ready                ;
	wire        u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_threshold            ;
	wire        u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_last                 ;
	wire [89:0] u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_payload              ;
	wire        u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_qos                  ;
	wire [5:0]  u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_srcid                ;
	wire [5:0]  u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_tgtid                ;
	wire        u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_valid                ;
	wire        u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_ready             ;
	wire        u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_threshold         ;
	wire        u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_last              ;
	wire [89:0] u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_payload           ;
	wire        u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_qos               ;
	wire [5:0]  u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_srcid             ;
	wire [5:0]  u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_tgtid             ;
	wire        u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_valid             ;
	wire        u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_ready        ;
	wire        u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_threshold    ;
	wire        u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_last         ;
	wire [89:0] u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_payload      ;
	wire        u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_qos          ;
	wire [5:0]  u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_srcid        ;
	wire [5:0]  u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_tgtid        ;
	wire        u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_valid        ;
	wire        u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_ready            ;
	wire        u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_threshold        ;
	wire        u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_last             ;
	wire [89:0] u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_payload          ;
	wire        u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_qos              ;
	wire [5:0]  u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_srcid            ;
	wire [5:0]  u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_tgtid            ;
	wire        u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_valid            ;
	wire        u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_valid                ;
	wire        u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_valid                ;
	wire        u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_valid                ;
	wire        u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_valid                ;
	wire        u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_valid                ;
	wire        u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_ready                ;
	wire        u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_threshold            ;
	wire        u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_last                 ;
	wire [89:0] u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_payload              ;
	wire        u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_qos                  ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_srcid                ;
	wire [5:0]  u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_tgtid                ;
	wire        u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_valid                ;
	wire        u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_ready              ;
	wire        u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_threshold          ;
	wire        u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_last               ;
	wire [89:0] u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_payload            ;
	wire        u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_qos                ;
	wire [5:0]  u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_srcid              ;
	wire [5:0]  u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_tgtid              ;
	wire        u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_valid              ;
	wire        u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_ready                ;
	wire        u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_threshold            ;
	wire        u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_last                 ;
	wire [89:0] u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_payload              ;
	wire        u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_qos                  ;
	wire [5:0]  u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_srcid                ;
	wire [5:0]  u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_tgtid                ;
	wire        u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_valid                ;
	wire        u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_ready                ;
	wire        u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_threshold            ;
	wire        u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_last                 ;
	wire [89:0] u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_payload              ;
	wire        u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_qos                  ;
	wire [5:0]  u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_srcid                ;
	wire [5:0]  u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_tgtid                ;
	wire        u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_valid                ;
	wire        u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_ready              ;
	wire        u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_threshold          ;
	wire        u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_last               ;
	wire [89:0] u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_payload            ;
	wire        u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_qos                ;
	wire [5:0]  u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_srcid              ;
	wire [5:0]  u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_tgtid              ;
	wire        u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_valid              ;
	wire        u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_ready             ;
	wire        u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_threshold         ;
	wire        u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_last              ;
	wire [89:0] u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_payload           ;
	wire        u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_qos               ;
	wire [5:0]  u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_srcid             ;
	wire [5:0]  u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_tgtid             ;
	wire        u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_valid             ;
	wire        u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_ready                 ;
	wire        u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_threshold             ;
	wire        u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_last                  ;
	wire [89:0] u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_payload               ;
	wire        u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_qos                   ;
	wire [5:0]  u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_srcid                 ;
	wire [5:0]  u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_tgtid                 ;
	wire        u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_valid                 ;
	wire        u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid          ;
	wire [89:0] u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload        ;
	wire        u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last           ;
	wire [5:0]  u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid          ;
	wire [5:0]  u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid          ;
	wire        u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos            ;
	wire        u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid          ;
	wire [89:0] u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload        ;
	wire        u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last           ;
	wire [5:0]  u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid          ;
	wire [5:0]  u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid          ;
	wire        u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos            ;
	wire        u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid          ;
	wire [89:0] u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload        ;
	wire        u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last           ;
	wire [5:0]  u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid          ;
	wire [5:0]  u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid          ;
	wire        u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos            ;
	wire        u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold      ;
	wire        u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready          ;
	wire        u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold      ;
	wire        u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready          ;
	wire        u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold      ;
	wire        u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready          ;
	wire        u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_ready                   ;
	wire        u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_threshold               ;
	wire        u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_valid                   ;
	wire [89:0] u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_payload                 ;
	wire [5:0]  u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_srcid                   ;
	wire [5:0]  u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_tgtid                   ;
	wire        u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_qos                     ;
	wire        u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_last                    ;
	wire        u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid           ;
	wire [89:0] u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload         ;
	wire        u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last            ;
	wire [5:0]  u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid           ;
	wire [5:0]  u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid           ;
	wire        u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos             ;
	wire        u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid      ;
	wire [89:0] u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload    ;
	wire        u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last       ;
	wire [5:0]  u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid      ;
	wire [5:0]  u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid      ;
	wire        u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos        ;
	wire        u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid          ;
	wire [89:0] u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload        ;
	wire        u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last           ;
	wire [5:0]  u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid          ;
	wire [5:0]  u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid          ;
	wire        u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos            ;
	wire        u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold       ;
	wire        u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready           ;
	wire        u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold  ;
	wire        u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready      ;
	wire        u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold      ;
	wire        u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready          ;
	wire        u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_ready                   ;
	wire        u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_threshold               ;
	wire        u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_valid                   ;
	wire [89:0] u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_payload                 ;
	wire [5:0]  u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_srcid                   ;
	wire [5:0]  u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_tgtid                   ;
	wire        u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_qos                     ;
	wire        u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_last                    ;
	wire        u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload            ;
	wire        u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid              ;
	wire        u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos                ;
	wire        u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_ready                      ;
	wire        u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_threshold                  ;
	wire        u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_valid                      ;
	wire [89:0] u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_payload                    ;
	wire [5:0]  u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_srcid                      ;
	wire [5:0]  u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_tgtid                      ;
	wire        u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_qos                        ;
	wire        u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_last                       ;
	wire        u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid            ;
	wire [89:0] u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload          ;
	wire        u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last             ;
	wire [5:0]  u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid            ;
	wire [5:0]  u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid            ;
	wire        u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos              ;
	wire        u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload            ;
	wire        u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid              ;
	wire        u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos                ;
	wire        u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload            ;
	wire        u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid              ;
	wire        u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos                ;
	wire        u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid            ;
	wire [89:0] u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload          ;
	wire        u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last             ;
	wire [5:0]  u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid            ;
	wire [5:0]  u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid            ;
	wire        u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos              ;
	wire        u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid           ;
	wire [89:0] u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload         ;
	wire        u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last            ;
	wire [5:0]  u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid           ;
	wire [5:0]  u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid           ;
	wire        u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos             ;
	wire        u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid               ;
	wire [89:0] u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload             ;
	wire        u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last                ;
	wire [5:0]  u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid               ;
	wire [5:0]  u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid               ;
	wire        u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos                 ;
	wire        u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold        ;
	wire        u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready            ;
	wire        u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold        ;
	wire        u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready            ;
	wire        u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold       ;
	wire        u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready           ;
	wire        u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold           ;
	wire        u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready               ;
	wire        u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_ready                       ;
	wire        u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_threshold                   ;
	wire        u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_valid                       ;
	wire [89:0] u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_payload                     ;
	wire [5:0]  u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_srcid                       ;
	wire [5:0]  u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_tgtid                       ;
	wire        u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_qos                         ;
	wire        u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_last                        ;
	wire        u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_valid              ;
	wire [89:0] u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_payload            ;
	wire        u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_last               ;
	wire [5:0]  u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_srcid              ;
	wire [5:0]  u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_tgtid              ;
	wire        u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_qos                ;
	wire        u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_valid                    ;
	wire [89:0] u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_payload                  ;
	wire        u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_last                     ;
	wire [5:0]  u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid                    ;
	wire [5:0]  u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid                    ;
	wire        u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_qos                      ;
	wire        u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_valid                       ;
	wire [89:0] u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_payload                     ;
	wire        u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_last                        ;
	wire [5:0]  u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid                       ;
	wire [5:0]  u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid                       ;
	wire        u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_qos                         ;
	wire        u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_valid                        ;
	wire [89:0] u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_payload                      ;
	wire        u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_last                         ;
	wire [5:0]  u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid                        ;
	wire [5:0]  u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid                        ;
	wire        u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_qos                          ;
	wire        u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_threshold          ;
	wire        u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_ready              ;
	wire        u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold                ;
	wire        u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready                    ;
	wire        u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold                   ;
	wire        u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready                       ;
	wire        u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold                    ;
	wire        u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready                        ;
	wire        u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_ready    ;
	wire        u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_threshold;
	wire        u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_valid         ;
	wire [89:0] u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_payload       ;
	wire [5:0]  u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_srcid         ;
	wire [5:0]  u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_tgtid         ;
	wire        u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_qos           ;
	wire        u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_last          ;
	wire        u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_valid              ;
	wire [89:0] u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_payload            ;
	wire        u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_last               ;
	wire [5:0]  u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid              ;
	wire [5:0]  u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid              ;
	wire        u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_qos                ;
	wire        u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_valid                    ;
	wire [89:0] u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_payload                  ;
	wire        u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_last                     ;
	wire [5:0]  u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_srcid                    ;
	wire [5:0]  u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_tgtid                    ;
	wire        u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_qos                      ;
	wire        u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_valid              ;
	wire [89:0] u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_payload            ;
	wire        u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_last               ;
	wire [5:0]  u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid              ;
	wire [5:0]  u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid              ;
	wire        u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_qos                ;
	wire        u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold          ;
	wire        u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready              ;
	wire        u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_threshold                ;
	wire        u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_ready                    ;
	wire        u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold          ;
	wire        u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready              ;
	wire        u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_ready    ;
	wire        u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_threshold;
	wire        u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_valid         ;
	wire [89:0] u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_payload       ;
	wire [5:0]  u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_srcid         ;
	wire [5:0]  u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_tgtid         ;
	wire        u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_qos           ;
	wire        u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_last          ;
	wire        u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_last             ;
	wire [89:0] u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_payload          ;
	wire        u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_qos              ;
	wire [5:0]  u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_srcid            ;
	wire [5:0]  u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_tgtid            ;
	wire        u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_valid            ;
	wire        u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_ready            ;
	wire        u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_threshold        ;
	wire        u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_last             ;
	wire [89:0] u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_payload          ;
	wire        u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_qos              ;
	wire [5:0]  u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_srcid            ;
	wire [5:0]  u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_tgtid            ;
	wire        u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_valid            ;
	wire        u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_ready            ;
	wire        u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_threshold        ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	npu_ss0_top_wrap u_npu_ss0_top_wrap (
		.clk_noc(npu_ss0_top_wrap_clk_noc_porting),
		.rst_noc_n(npu_ss0_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(npu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(npu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_last),
		.top_req_req_payload(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_payload),
		.top_req_req_qos(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_qos),
		.top_req_req_ready(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(npu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(npu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	npu_ss3_top_wrap u_npu_ss3_top_wrap (
		.clk_noc(npu_ss3_top_wrap_clk_noc_porting),
		.rst_noc_n(npu_ss3_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(npu_ss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(npu_ss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.top_req_req_payload(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.top_req_req_qos(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(npu_ss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(npu_ss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	npu_ss4_top_wrap u_npu_ss4_top_wrap (
		.clk_noc(npu_ss4_top_wrap_clk_noc_porting),
		.rst_noc_n(npu_ss4_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(npu_ss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(npu_ss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.top_req_req_payload(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.top_req_req_qos(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(npu_ss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(npu_ss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	npu_ss2_top_wrap u_npu_ss2_top_wrap (
		.clk_noc(npu_ss2_top_wrap_clk_noc_porting),
		.rst_noc_n(npu_ss2_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(npu_ss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(npu_ss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.top_req_req_payload(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.top_req_req_qos(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(npu_ss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(npu_ss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	npu_ss1_top_wrap u_npu_ss1_top_wrap (
		.clk_noc(npu_ss1_top_wrap_clk_noc_porting),
		.rst_noc_n(npu_ss1_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(npu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(npu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_last),
		.top_req_req_payload(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_payload),
		.top_req_req_qos(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_qos),
		.top_req_req_ready(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(npu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(npu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	peri_ss_top_wrap u_peri_ss_top_wrap (
		.clk_noc(peri_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(peri_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(peri_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(peri_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(peri_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(peri_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	ufs_ss_top_wrap u_ufs_ss_top_wrap (
		.clk_noc(ufs_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(ufs_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(ufs_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(ufs_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(ufs_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(ufs_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	pcie_eth_ss_top_wrap u_pcie_eth_ss_top_wrap (
		.clk_noc(pcie_eth_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(pcie_eth_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(pcie_eth_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(pcie_eth_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	gpu_ss0_top_wrap u_gpu_ss0_top_wrap (
		.clk_noc(gpu_ss0_top_wrap_clk_noc_porting),
		.rst_noc_n(gpu_ss0_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(gpu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(gpu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss0_top_wrap u_dspss0_top_wrap (
		.clk_noc(dspss0_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss0_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss1_top_wrap u_dspss1_top_wrap (
		.clk_noc(dspss1_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss1_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss2_top_wrap u_dspss2_top_wrap (
		.clk_noc(dspss2_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss2_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss3_top_wrap u_dspss3_top_wrap (
		.clk_noc(dspss3_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss3_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss4_top_wrap u_dspss4_top_wrap (
		.clk_noc(dspss4_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss4_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dspss5_top_wrap u_dspss5_top_wrap (
		.clk_noc(dspss5_top_wrap_clk_noc_porting),
		.rst_noc_n(dspss5_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(dspss5_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dspss5_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dspss5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dspss5_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_ready),
		.top_req_req_srcid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_threshold),
		.top_req_req_valid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_last),
		.top_rsp_rsp_payload(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_payload),
		.top_rsp_rsp_qos(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_qos),
		.top_rsp_rsp_ready(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_srcid),
		.top_rsp_rsp_tgtid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_tgtid),
		.top_rsp_rsp_threshold(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(dspss5_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(dspss5_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	camera_ss_top_wrap u_camera_ss_top_wrap (
		.clk_noc(camera_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(camera_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(camera_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(camera_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(camera_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(camera_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	mipi_ss_top_wrap u_mipi_ss_top_wrap (
		.clk_noc(mipi_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(mipi_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(mipi_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(mipi_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(mipi_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(mipi_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	gpu_ss1_top_wrap u_gpu_ss1_top_wrap (
		.clk_noc(gpu_ss1_top_wrap_clk_noc_porting),
		.rst_noc_n(gpu_ss1_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(gpu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(gpu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	usb_dp_ss_top_wrap u_usb_dp_ss_top_wrap (
		.clk_noc(usb_dp_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(usb_dp_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(usb_dp_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(usb_dp_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(usb_dp_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(usb_dp_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	display_ss_top_wrap u_display_ss_top_wrap (
		.clk_noc(display_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(display_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(display_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(display_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(display_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(display_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	vpu_ss_top_wrap u_vpu_ss_top_wrap (
		.clk_noc(vpu_ss_top_wrap_clk_noc_porting),
		.rst_noc_n(vpu_ss_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(vpu_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(vpu_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.top_req_req_payload(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.top_req_req_qos(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.top_req_req_ready(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_ready),
		.top_req_req_srcid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_threshold),
		.top_req_req_valid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_last),
		.top_rsp_rsp_payload(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_payload),
		.top_rsp_rsp_qos(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_qos),
		.top_rsp_rsp_ready(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_srcid),
		.top_rsp_rsp_tgtid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_tgtid),
		.top_rsp_rsp_threshold(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(vpu_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(vpu_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));
	dti_sw0_dti_noc_switch_3to1_wrap u_bottom_merge1 (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.iniu0_req_payload(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.iniu0_req_last(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.iniu0_req_srcid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.iniu1_req_payload(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.iniu1_req_last(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.iniu1_req_srcid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.iniu1_req_qos(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.iniu1_req_threshold(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_valid),
		.iniu2_req_payload(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_payload),
		.iniu2_req_last(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_last),
		.iniu2_req_srcid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_tgtid),
		.iniu2_req_qos(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_req_req_qos),
		.iniu2_req_threshold(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_req_ready),
		.iniu0_rsp_valid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_bottom_merge1_TO_u_npu_ss3_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_npu_ss3_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_bottom_merge1_TO_u_npu_ss4_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(u_npu_ss4_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_bottom_merge1_TO_u_npu_ss2_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(u_npu_ss2_top_wrap_TO_u_bottom_merge1_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_valid),
		.tniu_req_ready(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_ready),
		.tniu_req_payload(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_payload),
		.tniu_req_srcid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_qos),
		.tniu_req_last(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_last),
		.tniu_req_threshold(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_threshold),
		.tniu_rsp_valid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_srcid),
		.tniu_rsp_tgtid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_tgtid),
		.tniu_rsp_qos(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_qos),
		.tniu_rsp_last(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_last),
		.tniu_rsp_threshold(u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_threshold));
	dti_sw1_dti_noc_switch_3to1_wrap u_bottom_merge0 (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.iniu0_req_payload(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.iniu0_req_last(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.iniu0_req_srcid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.iniu1_req_payload(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.iniu1_req_last(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.iniu1_req_srcid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.iniu1_req_qos(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.iniu1_req_threshold(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_valid),
		.iniu2_req_payload(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_payload),
		.iniu2_req_last(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_last),
		.iniu2_req_srcid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_tgtid),
		.iniu2_req_qos(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_req_req_qos),
		.iniu2_req_threshold(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_req_ready),
		.iniu0_rsp_valid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_bottom_merge0_TO_u_ufs_ss_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_ufs_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_bottom_merge0_TO_u_pcie_eth_ss_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(u_pcie_eth_ss_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_bottom_merge0_TO_u_gpu_ss0_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(u_gpu_ss0_top_wrap_TO_u_bottom_merge0_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.tniu_req_ready(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_ready),
		.tniu_req_payload(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.tniu_req_srcid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.tniu_req_last(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.tniu_req_threshold(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_threshold),
		.tniu_rsp_valid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_srcid),
		.tniu_rsp_tgtid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_tgtid),
		.tniu_rsp_qos(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_qos),
		.tniu_rsp_last(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_last),
		.tniu_rsp_threshold(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold));
	dti_sw2_dti_noc_switch_6to1_wrap u_dsp_merge0 (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu0_req_payload(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu0_req_last(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu0_req_srcid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu1_req_payload(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu1_req_last(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu1_req_srcid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu1_req_qos(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu1_req_threshold(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu2_req_payload(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu2_req_last(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu2_req_srcid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu2_req_qos(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu2_req_threshold(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_req_ready),
		.iniu3_req_valid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu3_req_payload(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu3_req_last(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu3_req_srcid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu3_req_qos(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu3_req_threshold(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_req_ready(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_req_ready),
		.iniu4_req_valid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu4_req_payload(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu4_req_last(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu4_req_srcid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu4_req_qos(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu4_req_threshold(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_req_ready(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_req_ready),
		.iniu5_req_valid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_valid),
		.iniu5_req_payload(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_payload),
		.iniu5_req_last(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_last),
		.iniu5_req_srcid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_srcid),
		.iniu5_req_tgtid(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_tgtid),
		.iniu5_req_qos(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_req_req_qos),
		.iniu5_req_threshold(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_threshold),
		.iniu5_req_ready(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_req_ready),
		.iniu0_rsp_valid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_dsp_merge0_TO_u_dspss0_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_dspss0_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_dsp_merge0_TO_u_dspss1_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(u_dspss1_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_dsp_merge0_TO_u_dspss2_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(u_dspss2_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_valid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(u_dsp_merge0_TO_u_dspss3_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(u_dspss3_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_valid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(u_dsp_merge0_TO_u_dspss4_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(u_dspss4_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.iniu5_rsp_valid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_valid),
		.iniu5_rsp_payload(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_payload),
		.iniu5_rsp_last(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_last),
		.iniu5_rsp_srcid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(u_dsp_merge0_TO_u_dspss5_top_wrap_SIG_iniu5_rsp_qos),
		.iniu5_rsp_threshold(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_threshold),
		.iniu5_rsp_ready(u_dspss5_top_wrap_TO_u_dsp_merge0_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.tniu_req_ready(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_ready),
		.tniu_req_payload(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.tniu_req_srcid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.tniu_req_last(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.tniu_req_threshold(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_threshold),
		.tniu_rsp_valid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_valid),
		.tniu_rsp_ready(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_payload),
		.tniu_rsp_srcid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_srcid),
		.tniu_rsp_tgtid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_tgtid),
		.tniu_rsp_qos(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_qos),
		.tniu_rsp_last(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_last),
		.tniu_rsp_threshold(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold));
	dti_sw3_dti_noc_switch_6to1_wrap u_tr_merge0 (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu0_req_payload(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu0_req_last(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu0_req_srcid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu1_req_payload(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu1_req_last(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu1_req_srcid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu1_req_qos(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu1_req_threshold(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu2_req_payload(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu2_req_last(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu2_req_srcid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu2_req_qos(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu2_req_threshold(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_req_ready),
		.iniu3_req_valid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu3_req_payload(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu3_req_last(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu3_req_srcid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu3_req_qos(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu3_req_threshold(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_req_ready(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_req_ready),
		.iniu4_req_valid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu4_req_payload(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu4_req_last(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu4_req_srcid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu4_req_qos(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu4_req_threshold(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_req_ready(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_req_ready),
		.iniu5_req_valid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_valid),
		.iniu5_req_payload(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_payload),
		.iniu5_req_last(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_last),
		.iniu5_req_srcid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_srcid),
		.iniu5_req_tgtid(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_tgtid),
		.iniu5_req_qos(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_req_req_qos),
		.iniu5_req_threshold(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_threshold),
		.iniu5_req_ready(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_req_ready),
		.iniu0_rsp_valid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_tr_merge0_TO_u_camera_ss_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_camera_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_tr_merge0_TO_u_mipi_ss_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(u_mipi_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_tr_merge0_TO_u_gpu_ss1_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(u_gpu_ss1_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_valid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(u_tr_merge0_TO_u_usb_dp_ss_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(u_usb_dp_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_valid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(u_tr_merge0_TO_u_display_ss_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(u_display_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.iniu5_rsp_valid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_valid),
		.iniu5_rsp_payload(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_payload),
		.iniu5_rsp_last(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_last),
		.iniu5_rsp_srcid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(u_tr_merge0_TO_u_vpu_ss_top_wrap_SIG_iniu5_rsp_qos),
		.iniu5_rsp_threshold(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_threshold),
		.iniu5_rsp_ready(u_vpu_ss_top_wrap_TO_u_tr_merge0_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.tniu_req_ready(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_ready),
		.tniu_req_payload(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.tniu_req_srcid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.tniu_req_last(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.tniu_req_threshold(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_threshold),
		.tniu_rsp_valid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_valid),
		.tniu_rsp_ready(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_payload),
		.tniu_rsp_srcid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_srcid),
		.tniu_rsp_tgtid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_tgtid),
		.tniu_rsp_qos(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_qos),
		.tniu_rsp_last(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_last),
		.tniu_rsp_threshold(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold));
	dti_sw4_dti_noc_switch_4to1_wrap u_tl_merge0 (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_valid),
		.iniu0_req_payload(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_payload),
		.iniu0_req_last(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_last),
		.iniu0_req_srcid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.iniu1_req_payload(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.iniu1_req_last(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.iniu1_req_srcid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.iniu1_req_tgtid(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.iniu1_req_qos(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.iniu1_req_threshold(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.iniu2_req_payload(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.iniu2_req_last(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.iniu2_req_srcid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.iniu2_req_tgtid(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.iniu2_req_qos(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.iniu2_req_threshold(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_req_ready),
		.iniu3_req_valid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_valid),
		.iniu3_req_payload(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_payload),
		.iniu3_req_last(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_last),
		.iniu3_req_srcid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_srcid),
		.iniu3_req_tgtid(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_tgtid),
		.iniu3_req_qos(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_req_qos),
		.iniu3_req_threshold(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_threshold),
		.iniu3_req_ready(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_req_ready),
		.iniu0_rsp_valid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_tl_merge0_TO_u_peri_ss_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_peri_ss_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_tl_merge0_TO_u_bottom_merge0_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold),
		.iniu1_rsp_ready(u_bottom_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.iniu2_rsp_valid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_tl_merge0_TO_u_dsp_merge0_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold),
		.iniu2_rsp_ready(u_dsp_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.iniu3_rsp_valid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(u_tl_merge0_TO_u_tr_merge0_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_threshold),
		.iniu3_rsp_ready(u_tr_merge0_TO_u_tl_merge0_SIG_tniu_rsp_ready),
		.tniu_req_valid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_valid),
		.tniu_req_ready(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_ready),
		.tniu_req_payload(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_payload),
		.tniu_req_srcid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_qos),
		.tniu_req_last(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_last),
		.tniu_req_threshold(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_threshold),
		.tniu_rsp_valid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_valid),
		.tniu_rsp_ready(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_payload),
		.tniu_rsp_srcid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_qos),
		.tniu_rsp_last(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_last),
		.tniu_rsp_threshold(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_threshold));
	dti_sw5_dti_noc_switch_3to1_wrap u_top_spine (
		.clk(u_bottom_merge0_clk_noc_porting),
		.rst_n(u_bottom_merge0_rst_noc_n_porting),
		.iniu0_req_valid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_valid),
		.iniu0_req_payload(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_payload),
		.iniu0_req_last(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_last),
		.iniu0_req_srcid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid),
		.iniu0_req_qos(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_req_req_qos),
		.iniu0_req_threshold(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_valid),
		.iniu1_req_payload(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_payload),
		.iniu1_req_last(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_last),
		.iniu1_req_srcid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_srcid),
		.iniu1_req_tgtid(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_tgtid),
		.iniu1_req_qos(u_bottom_merge1_TO_u_top_spine_SIG_tniu_req_qos),
		.iniu1_req_threshold(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_threshold),
		.iniu1_req_ready(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_req_ready),
		.iniu2_req_valid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_valid),
		.iniu2_req_payload(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_payload),
		.iniu2_req_last(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_last),
		.iniu2_req_srcid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_tgtid),
		.iniu2_req_qos(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_req_req_qos),
		.iniu2_req_threshold(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_req_ready),
		.iniu0_rsp_valid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(u_top_spine_TO_u_npu_ss0_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(u_npu_ss0_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(u_top_spine_TO_u_bottom_merge1_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_threshold),
		.iniu1_rsp_ready(u_bottom_merge1_TO_u_top_spine_SIG_tniu_rsp_ready),
		.iniu2_rsp_valid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(u_top_spine_TO_u_npu_ss1_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(u_npu_ss1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_valid),
		.tniu_req_ready(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_ready),
		.tniu_req_payload(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_payload),
		.tniu_req_srcid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_srcid),
		.tniu_req_tgtid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_tgtid),
		.tniu_req_qos(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_qos),
		.tniu_req_last(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_last),
		.tniu_req_threshold(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_threshold),
		.tniu_rsp_valid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_valid),
		.tniu_rsp_ready(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_payload),
		.tniu_rsp_srcid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_qos),
		.tniu_rsp_last(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_last),
		.tniu_rsp_threshold(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_threshold));
	cpu_ss_tniu0_top_wrap u_cpu_ss_tniu0_top_wrap (
		.clk_noc(cpu_ss_tniu0_top_wrap_clk_noc_porting),
		.rst_noc_n(cpu_ss_tniu0_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(cpu_ss_tniu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(cpu_ss_tniu0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_data_req_last(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_last),
		.top_req_data_req_payload(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_payload),
		.top_req_data_req_qos(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_qos),
		.top_req_data_req_ready(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_ready),
		.top_req_data_req_srcid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_srcid),
		.top_req_data_req_tgtid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_tgtid),
		.top_req_data_req_threshold(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_req_data_req_threshold),
		.top_req_data_req_valid(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_req_valid),
		.top_rsp_rsp_last(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_last),
		.top_rsp_rsp_payload(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_ready),
		.top_rsp_rsp_srcid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(u_tl_merge0_TO_u_cpu_ss_tniu0_top_wrap_SIG_tniu_rsp_threshold),
		.top_rsp_rsp_valid(u_cpu_ss_tniu0_top_wrap_TO_u_tl_merge0_SIG_top_rsp_rsp_valid),
		.cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err(cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err),
		.cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err(cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err));
	cpu_ss_tniu1_top_wrap u_cpu_ss_tniu1_top_wrap (
		.clk_noc(cpu_ss_tniu1_top_wrap_clk_noc_porting),
		.rst_noc_n(cpu_ss_tniu1_top_wrap_rst_noc_n_porting),
		.async_fifo_req_pld_sync(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(cpu_ss_tniu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(cpu_ss_tniu1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_data_req_last(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_last),
		.top_req_data_req_payload(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_payload),
		.top_req_data_req_qos(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_qos),
		.top_req_data_req_ready(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_ready),
		.top_req_data_req_srcid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_srcid),
		.top_req_data_req_tgtid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_tgtid),
		.top_req_data_req_threshold(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_req_data_req_threshold),
		.top_req_data_req_valid(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_req_valid),
		.top_rsp_rsp_last(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_last),
		.top_rsp_rsp_payload(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_ready),
		.top_rsp_rsp_srcid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(u_top_spine_TO_u_cpu_ss_tniu1_top_wrap_SIG_tniu_rsp_threshold),
		.top_rsp_rsp_valid(u_cpu_ss_tniu1_top_wrap_TO_u_top_spine_SIG_top_rsp_rsp_valid),
		.cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err(cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err),
		.cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err(cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err));

endmodule
//[UHDL]Content End [md5:b7a252ad089e3a1d9a04d865845bad91]


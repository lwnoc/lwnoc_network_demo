// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_dti_noc_demo/build_logic/dti_noc_top_wrap/dti_noc_top_wrap.v
// Source top module: dti_noc_top_wrap
// Boundary note: DTI NoC top_wrap boundary generated in build_logic.
module dti_noc_top_wrap_stub (
    input  logic [0:0]   npu_ss0_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   npu_ss0_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  npu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  npu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   npu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   npu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   npu_ss3_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   npu_ss3_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  npu_ss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  npu_ss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   npu_ss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   npu_ss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   npu_ss4_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   npu_ss4_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  npu_ss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  npu_ss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   npu_ss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   npu_ss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   npu_ss2_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   npu_ss2_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  npu_ss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  npu_ss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   npu_ss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   npu_ss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   npu_ss1_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   npu_ss1_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  npu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  npu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   npu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   npu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   peri_ss_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   peri_ss_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  peri_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  peri_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   peri_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   peri_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   ufs_ss_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   ufs_ss_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  ufs_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  ufs_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   ufs_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   ufs_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   pcie_eth_ss_top_wrap_clk_noc_porting                                                                                                ,  // clock input
    input  logic [0:0]   pcie_eth_ss_top_wrap_rst_noc_n_porting                                                                                              ,  // active-low reset
    input  logic [112:0] pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                     ,  // async FIFO payload sync
    output logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                   ,  // async FIFO read pointer (async)
    output logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                    ,  // async FIFO read pointer (sync)
    input  logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                   ,  // async FIFO write pointer
    output logic [112:0] pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                     ,  // async FIFO payload sync
    input  logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                   ,  // async FIFO read pointer (async)
    input  logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                    ,  // async FIFO read pointer (sync)
    output logic [15:0]  pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                   ,  // async FIFO write pointer
    output logic [12:0]  pcie_eth_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                      ,  // low-power interface
    input  logic [12:0]  pcie_eth_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                      ,  // low-power interface
    output logic [0:0]   pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                             ,  // FUSA/ECC error flag
    output logic [0:0]   pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                             ,  // FUSA/ECC error flag
    input  logic [0:0]   gpu_ss0_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   gpu_ss0_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  gpu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  gpu_ss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   gpu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   gpu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss0_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss0_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss1_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss1_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss2_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss2_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss3_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss3_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss4_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss4_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   dspss5_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   dspss5_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] dspss5_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  dspss5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  dspss5_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   dspss5_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   dspss5_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   camera_ss_top_wrap_clk_noc_porting                                                                                                  ,  // clock input
    input  logic [0:0]   camera_ss_top_wrap_rst_noc_n_porting                                                                                                ,  // active-low reset
    input  logic [112:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                       ,  // async FIFO payload sync
    output logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                     ,  // async FIFO read pointer (async)
    output logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                      ,  // async FIFO read pointer (sync)
    input  logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                     ,  // async FIFO write pointer
    output logic [112:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                       ,  // async FIFO payload sync
    input  logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                     ,  // async FIFO read pointer (async)
    input  logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                      ,  // async FIFO read pointer (sync)
    output logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                     ,  // async FIFO write pointer
    output logic [12:0]  camera_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                        ,  // low-power interface
    input  logic [12:0]  camera_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                        ,  // low-power interface
    output logic [0:0]   camera_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                               ,  // FUSA/ECC error flag
    output logic [0:0]   camera_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                               ,  // FUSA/ECC error flag
    input  logic [0:0]   mipi_ss_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   mipi_ss_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  mipi_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  mipi_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   mipi_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   mipi_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   gpu_ss1_top_wrap_clk_noc_porting                                                                                                    ,  // clock input
    input  logic [0:0]   gpu_ss1_top_wrap_rst_noc_n_porting                                                                                                  ,  // active-low reset
    input  logic [112:0] gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                         ,  // async FIFO payload sync
    output logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                       ,  // async FIFO read pointer (async)
    output logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    input  logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [112:0] gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                         ,  // async FIFO payload sync
    input  logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                       ,  // async FIFO read pointer (async)
    input  logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                        ,  // async FIFO read pointer (sync)
    output logic [15:0]  gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                       ,  // async FIFO write pointer
    output logic [12:0]  gpu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                          ,  // low-power interface
    input  logic [12:0]  gpu_ss1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                          ,  // low-power interface
    output logic [0:0]   gpu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                 ,  // FUSA/ECC error flag
    output logic [0:0]   gpu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                 ,  // FUSA/ECC error flag
    input  logic [0:0]   usb_dp_ss_top_wrap_clk_noc_porting                                                                                                  ,  // clock input
    input  logic [0:0]   usb_dp_ss_top_wrap_rst_noc_n_porting                                                                                                ,  // active-low reset
    input  logic [112:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                       ,  // async FIFO payload sync
    output logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                     ,  // async FIFO read pointer (async)
    output logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                      ,  // async FIFO read pointer (sync)
    input  logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                     ,  // async FIFO write pointer
    output logic [112:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                       ,  // async FIFO payload sync
    input  logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                     ,  // async FIFO read pointer (async)
    input  logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                      ,  // async FIFO read pointer (sync)
    output logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                     ,  // async FIFO write pointer
    output logic [12:0]  usb_dp_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                        ,  // low-power interface
    input  logic [12:0]  usb_dp_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                        ,  // low-power interface
    output logic [0:0]   usb_dp_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                               ,  // FUSA/ECC error flag
    output logic [0:0]   usb_dp_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                               ,  // FUSA/ECC error flag
    input  logic [0:0]   display_ss_top_wrap_clk_noc_porting                                                                                                 ,  // clock input
    input  logic [0:0]   display_ss_top_wrap_rst_noc_n_porting                                                                                               ,  // active-low reset
    input  logic [112:0] display_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                      ,  // async FIFO payload sync
    output logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                    ,  // async FIFO read pointer (async)
    output logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                     ,  // async FIFO read pointer (sync)
    input  logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                    ,  // async FIFO write pointer
    output logic [112:0] display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                      ,  // async FIFO payload sync
    input  logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                    ,  // async FIFO read pointer (async)
    input  logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                     ,  // async FIFO read pointer (sync)
    output logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                    ,  // async FIFO write pointer
    output logic [12:0]  display_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                       ,  // low-power interface
    input  logic [12:0]  display_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                       ,  // low-power interface
    output logic [0:0]   display_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                              ,  // FUSA/ECC error flag
    output logic [0:0]   display_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                              ,  // FUSA/ECC error flag
    input  logic [0:0]   vpu_ss_top_wrap_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   vpu_ss_top_wrap_rst_noc_n_porting                                                                                                   ,  // active-low reset
    input  logic [112:0] vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                          ,  // async FIFO payload sync
    output logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                        ,  // async FIFO read pointer (async)
    output logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    input  logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [112:0] vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                          ,  // async FIFO payload sync
    input  logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                        ,  // async FIFO read pointer (async)
    input  logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                         ,  // async FIFO read pointer (sync)
    output logic [15:0]  vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                        ,  // async FIFO write pointer
    output logic [12:0]  vpu_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                           ,  // low-power interface
    input  logic [12:0]  vpu_ss_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                           ,  // low-power interface
    output logic [0:0]   vpu_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                                  ,  // FUSA/ECC error flag
    output logic [0:0]   vpu_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                                  ,  // FUSA/ECC error flag
    input  logic [0:0]   cpu_ss_tniu0_top_wrap_clk_noc_porting                                                                                               ,  // clock input
    input  logic [0:0]   cpu_ss_tniu0_top_wrap_rst_noc_n_porting                                                                                             ,  // active-low reset
    output logic [112:0] cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                    ,  // async FIFO payload sync
    input  logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                  ,  // async FIFO read pointer (async)
    input  logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                   ,  // async FIFO read pointer (sync)
    output logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                  ,  // async FIFO write pointer
    input  logic [112:0] cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                    ,  // async FIFO payload sync
    output logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                  ,  // async FIFO read pointer (async)
    output logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                   ,  // async FIFO read pointer (sync)
    input  logic [9:0]   cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                  ,  // async FIFO write pointer
    output logic [12:0]  cpu_ss_tniu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                     ,  // low-power interface
    input  logic [12:0]  cpu_ss_tniu0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                     ,  // low-power interface
    output logic [0:0]   cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,  // FUSA/ECC error flag
    output logic [0:0]   cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err,  // FUSA/ECC error flag
    input  logic [0:0]   cpu_ss_tniu1_top_wrap_clk_noc_porting                                                                                               ,  // clock input
    input  logic [0:0]   cpu_ss_tniu1_top_wrap_rst_noc_n_porting                                                                                             ,  // active-low reset
    output logic [112:0] cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync                                                                    ,  // async FIFO payload sync
    input  logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async                                                                  ,  // async FIFO read pointer (async)
    input  logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync                                                                   ,  // async FIFO read pointer (sync)
    output logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async                                                                  ,  // async FIFO write pointer
    input  logic [112:0] cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync                                                                    ,  // async FIFO payload sync
    output logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async                                                                  ,  // async FIFO read pointer (async)
    output logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync                                                                   ,  // async FIFO read pointer (sync)
    input  logic [9:0]   cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async                                                                  ,  // async FIFO write pointer
    output logic [12:0]  cpu_ss_tniu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req                                                                     ,  // low-power interface
    input  logic [12:0]  cpu_ss_tniu1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req                                                                     ,  // low-power interface
    output logic [0:0]   cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,  // FUSA/ECC error flag
    output logic [0:0]   cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err,  // FUSA/ECC error flag
    input  logic [0:0]   u_bottom_merge0_clk_noc_porting                                                                                                     ,  // clock input
    input  logic [0:0]   u_bottom_merge0_rst_noc_n_porting                                                                                                     // active-low reset
);

    // Review-only stub behavior: tie every output low.
    assign npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign npu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign npu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign npu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign npu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign npu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign npu_ss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign npu_ss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign npu_ss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign npu_ss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign npu_ss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign npu_ss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign npu_ss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign npu_ss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign npu_ss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign npu_ss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign npu_ss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign npu_ss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign npu_ss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign npu_ss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign npu_ss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign npu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign npu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign npu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign npu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign npu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign peri_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign peri_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign peri_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign ufs_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign ufs_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign ufs_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign ufs_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign ufs_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign pcie_eth_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign pcie_eth_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign gpu_ss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign gpu_ss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign gpu_ss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss0_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss0_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss2_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss2_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss3_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss3_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss4_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss4_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign dspss5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign dspss5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign dspss5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign dspss5_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign dspss5_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign camera_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign camera_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign camera_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign mipi_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign mipi_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign mipi_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign gpu_ss1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign gpu_ss1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign gpu_ss1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign gpu_ss1_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign gpu_ss1_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign usb_dp_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign usb_dp_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign usb_dp_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign display_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign display_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign display_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_async = '0;
    assign vpu_ss_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync = '0;
    assign vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync = '0;
    assign vpu_ss_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async = '0;
    assign vpu_ss_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign vpu_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err = '0;
    assign vpu_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err = '0;
    assign cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync = '0;
    assign cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async = '0;
    assign cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async = '0;
    assign cpu_ss_tniu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync = '0;
    assign cpu_ss_tniu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err = '0;
    assign cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err = '0;
    assign cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync = '0;
    assign cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async = '0;
    assign cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async = '0;
    assign cpu_ss_tniu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync = '0;
    assign cpu_ss_tniu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req = '0;
    assign cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err = '0;
    assign cpu_ss_tniu1_top_wrap_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu1_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err = '0;

endmodule

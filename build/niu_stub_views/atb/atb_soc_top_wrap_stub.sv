// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_atb_noc/build_logic/atb_soc_top_wrap/atb_soc_top_wrap.v
// Source top module: atb_soc_top_wrap
// Boundary note: ATB SoC top_wrap boundary generated in build_logic.
module atb_soc_top_wrap_stub (
    output logic [0:0]   dsp_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   dsp_ss1_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss1_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss1_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss1_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss1_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss1_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss1_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss1_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss1_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   dsp_ss2_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss2_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss2_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss2_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss2_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss2_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss2_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss2_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss2_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   dsp_ss3_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss3_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss3_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss3_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss3_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss3_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss3_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss3_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss3_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   dsp_ss4_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss4_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss4_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss4_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss4_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss4_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss4_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss4_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss4_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   dsp_ss5_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   dsp_ss5_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  dsp_ss5_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  dsp_ss5_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] dsp_ss5_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  dsp_ss5_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  dsp_ss5_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  dsp_ss5_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   dsp_ss5_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   camera_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level       ,  // ATB synchronization request level
    output logic [0:0]   camera_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level ,  // flush request level
    input  logic [12:0]  camera_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req        ,  // AFIFO low-power request channel
    output logic [12:0]  camera_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req        ,  // AFIFO low-power request channel
    input  logic [151:0] camera_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                  ,  // async FIFO payload sync
    output logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                ,  // async FIFO read pointer (async)
    output logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                 ,  // async FIFO read pointer (sync)
    input  logic [15:0]  camera_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                ,  // async FIFO write pointer
    input  logic [12:0]  camera_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                           ,  // NoC low-power request channel
    output logic [12:0]  camera_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                           ,  // NoC low-power request channel
    input  logic [9:0]   camera_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val             ,  // timeout value
    output logic [0:0]   mipi_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   mipi_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  mipi_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  mipi_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] mipi_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  mipi_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  mipi_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  mipi_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   mipi_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   gpu1_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   gpu1_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  gpu1_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  gpu1_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] gpu1_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  gpu1_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  gpu1_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  gpu1_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   gpu1_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   usb_dp_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level       ,  // ATB synchronization request level
    output logic [0:0]   usb_dp_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level ,  // flush request level
    input  logic [12:0]  usb_dp_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req        ,  // AFIFO low-power request channel
    output logic [12:0]  usb_dp_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req        ,  // AFIFO low-power request channel
    input  logic [151:0] usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                  ,  // async FIFO payload sync
    output logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                ,  // async FIFO read pointer (async)
    output logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                 ,  // async FIFO read pointer (sync)
    input  logic [15:0]  usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                ,  // async FIFO write pointer
    input  logic [12:0]  usb_dp_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                           ,  // NoC low-power request channel
    output logic [12:0]  usb_dp_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                           ,  // NoC low-power request channel
    input  logic [9:0]   usb_dp_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val             ,  // timeout value
    output logic [0:0]   display_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level      ,  // ATB synchronization request level
    output logic [0:0]   display_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level,  // flush request level
    input  logic [12:0]  display_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req       ,  // AFIFO low-power request channel
    output logic [12:0]  display_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req       ,  // AFIFO low-power request channel
    input  logic [151:0] display_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                 ,  // async FIFO payload sync
    output logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async               ,  // async FIFO read pointer (async)
    output logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                ,  // async FIFO read pointer (sync)
    input  logic [15:0]  display_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async               ,  // async FIFO write pointer
    input  logic [12:0]  display_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                          ,  // NoC low-power request channel
    output logic [12:0]  display_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                          ,  // NoC low-power request channel
    input  logic [9:0]   display_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val            ,  // timeout value
    output logic [0:0]   aon_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,  // ATB synchronization request level
    output logic [0:0]   aon_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,  // flush request level
    input  logic [12:0]  aon_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,  // AFIFO low-power request channel
    output logic [12:0]  aon_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,  // AFIFO low-power request channel
    input  logic [151:0] aon_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,  // async FIFO payload sync
    output logic [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,  // async FIFO read pointer (async)
    output logic [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,  // async FIFO read pointer (sync)
    input  logic [15:0]  aon_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,  // async FIFO write pointer
    input  logic [12:0]  aon_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,  // NoC low-power request channel
    output logic [12:0]  aon_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,  // NoC low-power request channel
    input  logic [9:0]   aon_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,  // timeout value
    output logic [0:0]   gpu_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    output logic [0:0]   gpu_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level   ,  // flush request level
    input  logic [12:0]  gpu_ss0_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  gpu_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req          ,  // AFIFO low-power request channel
    input  logic [151:0] gpu_ss0_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    output logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    output logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    input  logic [15:0]  gpu_ss0_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [12:0]  gpu_ss0_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                             ,  // NoC low-power request channel
    output logic [12:0]  gpu_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                             ,  // NoC low-power request channel
    input  logic [9:0]   gpu_ss0_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    output logic [0:0]   cpu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,  // ATB synchronization request level
    output logic [0:0]   cpu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,  // flush request level
    input  logic [12:0]  cpu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,  // AFIFO low-power request channel
    output logic [12:0]  cpu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,  // AFIFO low-power request channel
    input  logic [151:0] cpu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,  // async FIFO payload sync
    output logic [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,  // async FIFO read pointer (async)
    output logic [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,  // async FIFO read pointer (sync)
    input  logic [15:0]  cpu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,  // async FIFO write pointer
    input  logic [12:0]  cpu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,  // NoC low-power request channel
    output logic [12:0]  cpu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,  // NoC low-power request channel
    input  logic [9:0]   cpu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,  // timeout value
    output logic [0:0]   mcu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level          ,  // ATB synchronization request level
    output logic [0:0]   mcu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level    ,  // flush request level
    input  logic [12:0]  mcu_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_mst_rx_req           ,  // AFIFO low-power request channel
    output logic [12:0]  mcu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req           ,  // AFIFO low-power request channel
    input  logic [151:0] mcu_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                     ,  // async FIFO payload sync
    output logic [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                   ,  // async FIFO read pointer (async)
    output logic [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                    ,  // async FIFO read pointer (sync)
    input  logic [15:0]  mcu_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                   ,  // async FIFO write pointer
    input  logic [12:0]  mcu_ss_top_wrap_lp_rx_porting_lp_rx_lw_rx_req                              ,  // NoC low-power request channel
    output logic [12:0]  mcu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req                              ,  // NoC low-power request channel
    input  logic [9:0]   mcu_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val                ,  // timeout value
    input  logic [0:0]   peri_ss_top_wrap_flush_req_porting_flush_req_flush_req                     ,  // flush request
    output logic [151:0] peri_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync                    ,  // async FIFO payload sync
    input  logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async                  ,  // async FIFO read pointer (async)
    input  logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync                   ,  // async FIFO read pointer (sync)
    output logic [15:0]  peri_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async                  ,  // async FIFO write pointer
    input  logic [0:0]   peri_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level         ,  // ATB synchronization request level
    input  logic [12:0]  peri_ss_top_wrap_lp_lw_rx_porting_lp_lw_rx_lw_rx_req                       ,  // NoC low-power request channel
    output logic [12:0]  peri_ss_top_wrap_lp_lw_tx_porting_lp_lw_tx_lw_tx_req                       ,  // NoC low-power request channel
    input  logic [12:0]  peri_ss_top_wrap_lp_afifo_rx_porting_lp_afifo_rx_afifo_slv_rx_req          ,  // AFIFO low-power request channel
    output logic [12:0]  peri_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_slv_tx_req          ,  // AFIFO low-power request channel
    input  logic [9:0]   peri_ss_top_wrap_timeout_val_porting_timeout_val_timeout_val               ,  // timeout value
    input  logic [0:0]   u_aon_ss_clk_noc_porting                                                   ,  // clock input
    input  logic [0:0]   u_aon_ss_rst_noc_n_porting                                                   // active-low reset
);

    // Review-only stub behavior: tie every output low.
    assign dsp_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign dsp_ss1_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss1_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss1_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss1_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss1_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign dsp_ss2_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss2_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss2_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss2_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss2_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign dsp_ss3_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss3_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss3_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss3_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss3_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign dsp_ss4_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss4_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss4_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss4_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss4_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign dsp_ss5_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign dsp_ss5_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign dsp_ss5_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign dsp_ss5_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign dsp_ss5_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign camera_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign camera_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign camera_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign camera_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign camera_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign mipi_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign mipi_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign mipi_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign mipi_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign mipi_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign gpu1_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign gpu1_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign gpu1_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign gpu1_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign gpu1_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign usb_dp_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign usb_dp_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign usb_dp_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign usb_dp_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign usb_dp_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign display_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign display_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign display_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign display_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign display_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign aon_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign aon_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign aon_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign aon_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign aon_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign gpu_ss0_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign gpu_ss0_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign gpu_ss0_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign gpu_ss0_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign gpu_ss0_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign cpu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign cpu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign cpu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign cpu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign cpu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign mcu_ss_top_wrap_syncreq_level_porting_syncreq_level_syncreq_level = '0;
    assign mcu_ss_top_wrap_flush_req_level_porting_flush_req_level_flush_req_level = '0;
    assign mcu_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_mst_tx_req = '0;
    assign mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_async = '0;
    assign mcu_ss_top_wrap_async_fifo_porting_async_fifo_rptr_sync = '0;
    assign mcu_ss_top_wrap_lp_tx_porting_lp_tx_lw_tx_req = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_pld_sync = '0;
    assign peri_ss_top_wrap_async_fifo_porting_async_fifo_wptr_async = '0;
    assign peri_ss_top_wrap_lp_lw_tx_porting_lp_lw_tx_lw_tx_req = '0;
    assign peri_ss_top_wrap_lp_afifo_tx_porting_lp_afifo_tx_afifo_slv_tx_req = '0;

endmodule

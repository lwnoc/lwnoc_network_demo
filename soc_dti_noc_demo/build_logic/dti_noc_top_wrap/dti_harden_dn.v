//[UHDL]Content Start [md5:bbf6186fb729808565c4d1e5b0dd5540]
module dti_harden_dn
	import lwnoc_lp_struct_package::*;
	(
	input                                                 clk_dn_func                                                   ,
	input                                                 rst_dn_func_n                                                 ,
	output                                                sw0_tniu_req_porting_tniu_req_last                            ,
	output [89:0]                                         sw0_tniu_req_porting_tniu_req_payload                         ,
	output                                                sw0_tniu_req_porting_tniu_req_qos                             ,
	input                                                 sw0_tniu_req_porting_tniu_req_ready                           ,
	output [5:0]                                          sw0_tniu_req_porting_tniu_req_srcid                           ,
	output [5:0]                                          sw0_tniu_req_porting_tniu_req_tgtid                           ,
	input                                                 sw0_tniu_req_porting_tniu_req_threshold                       ,
	output                                                sw0_tniu_req_porting_tniu_req_valid                           ,
	input                                                 sw0_tniu_rsp_porting_tniu_rsp_last                            ,
	input  [89:0]                                         sw0_tniu_rsp_porting_tniu_rsp_payload                         ,
	input                                                 sw0_tniu_rsp_porting_tniu_rsp_qos                             ,
	output                                                sw0_tniu_rsp_porting_tniu_rsp_ready                           ,
	input  [5:0]                                          sw0_tniu_rsp_porting_tniu_rsp_srcid                           ,
	input  [5:0]                                          sw0_tniu_rsp_porting_tniu_rsp_tgtid                           ,
	output                                                sw0_tniu_rsp_porting_tniu_rsp_threshold                       ,
	input                                                 sw0_tniu_rsp_porting_tniu_rsp_valid                           ,
	output                                                sw1_tniu_req_porting_tniu_req_last                            ,
	output [89:0]                                         sw1_tniu_req_porting_tniu_req_payload                         ,
	output                                                sw1_tniu_req_porting_tniu_req_qos                             ,
	input                                                 sw1_tniu_req_porting_tniu_req_ready                           ,
	output [5:0]                                          sw1_tniu_req_porting_tniu_req_srcid                           ,
	output [5:0]                                          sw1_tniu_req_porting_tniu_req_tgtid                           ,
	input                                                 sw1_tniu_req_porting_tniu_req_threshold                       ,
	output                                                sw1_tniu_req_porting_tniu_req_valid                           ,
	input                                                 sw1_tniu_rsp_porting_tniu_rsp_last                            ,
	input  [89:0]                                         sw1_tniu_rsp_porting_tniu_rsp_payload                         ,
	input                                                 sw1_tniu_rsp_porting_tniu_rsp_qos                             ,
	output                                                sw1_tniu_rsp_porting_tniu_rsp_ready                           ,
	input  [5:0]                                          sw1_tniu_rsp_porting_tniu_rsp_srcid                           ,
	input  [5:0]                                          sw1_tniu_rsp_porting_tniu_rsp_tgtid                           ,
	output                                                sw1_tniu_rsp_porting_tniu_rsp_threshold                       ,
	input                                                 sw1_tniu_rsp_porting_tniu_rsp_valid                           ,
	input                                                 sw2_tniu_rsp_porting_tniu_rsp_last                            ,
	input  [89:0]                                         sw2_tniu_rsp_porting_tniu_rsp_payload                         ,
	input                                                 sw2_tniu_rsp_porting_tniu_rsp_qos                             ,
	output                                                sw2_tniu_rsp_porting_tniu_rsp_ready                           ,
	input  [5:0]                                          sw2_tniu_rsp_porting_tniu_rsp_srcid                           ,
	input  [5:0]                                          sw2_tniu_rsp_porting_tniu_rsp_tgtid                           ,
	output                                                sw2_tniu_rsp_porting_tniu_rsp_threshold                       ,
	input                                                 sw2_tniu_rsp_porting_tniu_rsp_valid                           ,
	output                                                dti_buffer_ctrl_porting_almost_empty                          ,
	output                                                dti_buffer_ctrl_porting_almost_full                           ,
	input                                                 dti_buffer_ctrl_porting_clear                                 ,
	output                                                dti_buffer_ctrl_porting_empty                                 ,
	output                                                dti_buffer_ctrl_porting_full                                  ,
	output                                                dti_buffer_ctrl_porting_idle                                  ,
	input                                                 dti_buffer_ctrl_porting_stall                                 ,
	input  [104:0]                                        dsp0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp5_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dsp5_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        cpu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync       ,
	output [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async     ,
	output [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync      ,
	input  [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async     ,
	output [104:0]                                        cpu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync       ,
	input  [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async     ,
	input  [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync      ,
	output [15:0]                                         cpu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async     ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t cpu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req        ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t cpu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req        ,
	input  [104:0]                                        pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_pld_sync  ,
	output [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_rptr_async,
	output [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync ,
	input  [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_wptr_async,
	output [104:0]                                        pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync  ,
	input  [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async,
	input  [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync ,
	output [15:0]                                         pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t pcie_eth_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req   ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t pcie_eth_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req   ,
	input  [104:0]                                        usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_pld_sync   ,
	output [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_rptr_async ,
	output [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync  ,
	input  [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_wptr_async ,
	output [104:0]                                        usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync   ,
	input  [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async ,
	input  [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync  ,
	output [15:0]                                         usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t usb_ufs_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req    ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t usb_ufs_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req    ,
	input  [104:0]                                        camera_top_wrap_async_fifo_porting_async_fifo_req_pld_sync    ,
	output [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_req_rptr_async  ,
	output [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync   ,
	input  [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_req_wptr_async  ,
	output [104:0]                                        camera_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync    ,
	input  [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async  ,
	input  [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync   ,
	output [15:0]                                         camera_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async  ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t camera_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req     ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t camera_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req     ,
	input  [104:0]                                        mipi_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        mipi_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         mipi_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t mipi_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t mipi_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        gpu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t gpu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t gpu0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        gpu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t gpu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t gpu1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dp_top_wrap_async_fifo_porting_async_fifo_req_pld_sync        ,
	output [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_req_rptr_async      ,
	output [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync       ,
	input  [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_req_wptr_async      ,
	output [104:0]                                        dp_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync        ,
	input  [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async      ,
	input  [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync       ,
	output [15:0]                                         dp_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async      ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dp_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req         ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t dp_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req         ,
	input  [104:0]                                        display_top_wrap_async_fifo_porting_async_fifo_req_pld_sync   ,
	output [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_req_rptr_async ,
	output [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync  ,
	input  [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_req_wptr_async ,
	output [104:0]                                        display_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync   ,
	input  [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async ,
	input  [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync  ,
	output [15:0]                                         display_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async ,
	output lwnoc_lp_struct_package::lwnoc_lp_req_signal_t display_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req    ,
	input  lwnoc_lp_struct_package::lwnoc_lp_req_signal_t display_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req    ,
	output [104:0]                                        dti_req_rsp_async_bridge_slv_sync_porting_pld_sync            ,
	input  [15:0]                                         dti_req_rsp_async_bridge_slv_sync_porting_rptr_async          ,
	input  [15:0]                                         dti_req_rsp_async_bridge_slv_sync_porting_rptr_sync           ,
	output [15:0]                                         dti_req_rsp_async_bridge_slv_sync_porting_wptr_async          );

	//Wire define for this module.

	//Wire define for sub module.
	wire        dsp0_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp0_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp0_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp0_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp0_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp0_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp1_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp1_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp1_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp1_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp1_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp1_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp2_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp2_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp2_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp2_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp2_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp2_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp3_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp3_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp3_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp3_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp3_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp3_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp4_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp4_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp4_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp4_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp4_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp4_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp5_top_wrap_TO_sw0_SIG_top_req_req_valid            ;
	wire [89:0] dsp5_top_wrap_TO_sw0_SIG_top_req_req_payload          ;
	wire        dsp5_top_wrap_TO_sw0_SIG_top_req_req_last             ;
	wire [5:0]  dsp5_top_wrap_TO_sw0_SIG_top_req_req_srcid            ;
	wire [5:0]  dsp5_top_wrap_TO_sw0_SIG_top_req_req_tgtid            ;
	wire        dsp5_top_wrap_TO_sw0_SIG_top_req_req_qos              ;
	wire        dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold        ;
	wire        dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready            ;
	wire        cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid        ;
	wire [89:0] cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload      ;
	wire        cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_last         ;
	wire [5:0]  cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid        ;
	wire [5:0]  cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid        ;
	wire        cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos          ;
	wire        pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid       ;
	wire [89:0] pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload     ;
	wire        pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_last        ;
	wire [5:0]  pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid       ;
	wire [5:0]  pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid       ;
	wire        pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos         ;
	wire        ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid        ;
	wire [89:0] ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload      ;
	wire        ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_last         ;
	wire [5:0]  ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid        ;
	wire [5:0]  ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid        ;
	wire        ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos          ;
	wire        camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid     ;
	wire [89:0] camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload   ;
	wire        camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_last      ;
	wire [5:0]  camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid     ;
	wire [5:0]  camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid     ;
	wire        camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos       ;
	wire        mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid       ;
	wire [89:0] mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload     ;
	wire        mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_last        ;
	wire [5:0]  mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid       ;
	wire [5:0]  mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid       ;
	wire        mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos         ;
	wire        cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold    ;
	wire        cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready        ;
	wire        pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold   ;
	wire        pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready       ;
	wire        ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold    ;
	wire        ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready        ;
	wire        camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold ;
	wire        camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready     ;
	wire        mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold   ;
	wire        mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready       ;
	wire        gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid       ;
	wire [89:0] gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload     ;
	wire        gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_last        ;
	wire [5:0]  gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid       ;
	wire [5:0]  gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid       ;
	wire        gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos         ;
	wire        gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid       ;
	wire [89:0] gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload     ;
	wire        gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_last        ;
	wire [5:0]  gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid       ;
	wire [5:0]  gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid       ;
	wire        gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos         ;
	wire        dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid         ;
	wire [89:0] dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload       ;
	wire        dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_last          ;
	wire [5:0]  dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid         ;
	wire [5:0]  dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid         ;
	wire        dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos           ;
	wire        display_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid    ;
	wire [89:0] display_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload  ;
	wire        display_iniu_top_wrap_TO_sw2_SIG_top_req_req_last     ;
	wire [5:0]  display_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid    ;
	wire [5:0]  display_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid    ;
	wire        display_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos      ;
	wire        gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold   ;
	wire        gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready       ;
	wire        gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold   ;
	wire        gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready       ;
	wire        dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold     ;
	wire        dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready         ;
	wire        display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold;
	wire        display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready    ;
	wire        dti_buffer_TO_sw2_SIG_write_req_ready                 ;
	wire        dti_buffer_TO_sw2_SIG_write_req_threshold             ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_valid                  ;
	wire [89:0] sw2_TO_dti_buffer_SIG_tniu_req_payload                ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_last                   ;
	wire [5:0]  sw2_TO_dti_buffer_SIG_tniu_req_srcid                  ;
	wire [5:0]  sw2_TO_dti_buffer_SIG_tniu_req_tgtid                  ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_qos                    ;
	wire        async_bridge_slv_TO_dti_buffer_SIG_s_ready            ;
	wire        async_bridge_slv_TO_dti_buffer_SIG_s_threshold        ;
	wire        sw0_TO_dsp0_top_wrap_SIG_iniu0_req_ready              ;
	wire        sw0_TO_dsp0_top_wrap_SIG_iniu0_req_threshold          ;
	wire        sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_last               ;
	wire [89:0] sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_payload            ;
	wire        sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_tgtid              ;
	wire        sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_valid              ;
	wire        sw0_TO_dsp1_top_wrap_SIG_iniu1_req_ready              ;
	wire        sw0_TO_dsp1_top_wrap_SIG_iniu1_req_threshold          ;
	wire        sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_last               ;
	wire [89:0] sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_payload            ;
	wire        sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_tgtid              ;
	wire        sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_valid              ;
	wire        sw0_TO_dsp2_top_wrap_SIG_iniu2_req_ready              ;
	wire        sw0_TO_dsp2_top_wrap_SIG_iniu2_req_threshold          ;
	wire        sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_last               ;
	wire [89:0] sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_payload            ;
	wire        sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_tgtid              ;
	wire        sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_valid              ;
	wire        sw0_TO_dsp3_top_wrap_SIG_iniu3_req_ready              ;
	wire        sw0_TO_dsp3_top_wrap_SIG_iniu3_req_threshold          ;
	wire        sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_last               ;
	wire [89:0] sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_payload            ;
	wire        sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_tgtid              ;
	wire        sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_valid              ;
	wire        sw0_TO_dsp4_top_wrap_SIG_iniu4_req_ready              ;
	wire        sw0_TO_dsp4_top_wrap_SIG_iniu4_req_threshold          ;
	wire        sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_last               ;
	wire [89:0] sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_payload            ;
	wire        sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_tgtid              ;
	wire        sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_valid              ;
	wire        sw0_TO_dsp5_top_wrap_SIG_iniu5_req_ready              ;
	wire        sw0_TO_dsp5_top_wrap_SIG_iniu5_req_threshold          ;
	wire        sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_last               ;
	wire [89:0] sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_payload            ;
	wire        sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_qos                ;
	wire [5:0]  sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_srcid              ;
	wire [5:0]  sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_tgtid              ;
	wire        sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_valid              ;
	wire        sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_ready          ;
	wire        sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_threshold      ;
	wire        sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_last           ;
	wire [89:0] sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_payload        ;
	wire        sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_qos            ;
	wire [5:0]  sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_srcid          ;
	wire [5:0]  sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_tgtid          ;
	wire        sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_valid          ;
	wire        sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_ready         ;
	wire        sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_threshold     ;
	wire        sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_last          ;
	wire [89:0] sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_payload       ;
	wire        sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_qos           ;
	wire [5:0]  sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_srcid         ;
	wire [5:0]  sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_tgtid         ;
	wire        sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_valid         ;
	wire        sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_ready          ;
	wire        sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_threshold      ;
	wire        sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_last           ;
	wire [89:0] sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_payload        ;
	wire        sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_qos            ;
	wire [5:0]  sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_srcid          ;
	wire [5:0]  sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_tgtid          ;
	wire        sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_valid          ;
	wire        sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_ready       ;
	wire        sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_threshold   ;
	wire        sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_last        ;
	wire [89:0] sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_payload     ;
	wire        sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_qos         ;
	wire [5:0]  sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_srcid       ;
	wire [5:0]  sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_tgtid       ;
	wire        sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_valid       ;
	wire        sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_ready         ;
	wire        sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_threshold     ;
	wire        sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_last          ;
	wire [89:0] sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_payload       ;
	wire        sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_qos           ;
	wire [5:0]  sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_srcid         ;
	wire [5:0]  sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_tgtid         ;
	wire        sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_valid         ;
	wire        sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_ready         ;
	wire        sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_threshold     ;
	wire        sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_last          ;
	wire [89:0] sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_payload       ;
	wire        sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_qos           ;
	wire [5:0]  sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_srcid         ;
	wire [5:0]  sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_tgtid         ;
	wire        sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_valid         ;
	wire        sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_ready         ;
	wire        sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_threshold     ;
	wire        sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_last          ;
	wire [89:0] sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_payload       ;
	wire        sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_qos           ;
	wire [5:0]  sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_srcid         ;
	wire [5:0]  sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_tgtid         ;
	wire        sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_valid         ;
	wire        sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_ready           ;
	wire        sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_threshold       ;
	wire        sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_last            ;
	wire [89:0] sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_payload         ;
	wire        sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_qos             ;
	wire [5:0]  sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_srcid           ;
	wire [5:0]  sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_tgtid           ;
	wire        sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_valid           ;
	wire        sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_ready      ;
	wire        sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_threshold  ;
	wire        sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_last       ;
	wire [89:0] sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_payload    ;
	wire        sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_qos        ;
	wire [5:0]  sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_srcid      ;
	wire [5:0]  sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_tgtid      ;
	wire        sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_valid      ;
	wire        dti_buffer_TO_async_bridge_slv_SIG_read_resp_valid    ;
	wire [89:0] dti_buffer_TO_async_bridge_slv_SIG_read_resp_payload  ;
	wire        dti_buffer_TO_async_bridge_slv_SIG_read_resp_last     ;
	wire [5:0]  dti_buffer_TO_async_bridge_slv_SIG_read_resp_srcid    ;
	wire [5:0]  dti_buffer_TO_async_bridge_slv_SIG_read_resp_tgtid    ;
	wire        dti_buffer_TO_async_bridge_slv_SIG_read_resp_qos      ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_sw0_dti_noc_switch_6to1_wrap sw0 (
		.clk(clk_dn_func),
		.rst_n(rst_dn_func_n),
		.iniu0_req_valid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu0_req_payload(dsp0_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu0_req_last(dsp0_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu0_req_srcid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu0_req_qos(dsp0_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu0_req_threshold(sw0_TO_dsp0_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw0_TO_dsp0_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu1_req_payload(dsp1_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu1_req_last(dsp1_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu1_req_srcid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu1_req_qos(dsp1_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu1_req_threshold(sw0_TO_dsp1_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw0_TO_dsp1_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu2_req_payload(dsp2_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu2_req_last(dsp2_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu2_req_srcid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu2_req_qos(dsp2_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu2_req_threshold(sw0_TO_dsp2_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw0_TO_dsp2_top_wrap_SIG_iniu2_req_ready),
		.iniu3_req_valid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu3_req_payload(dsp3_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu3_req_last(dsp3_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu3_req_srcid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu3_req_qos(dsp3_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu3_req_threshold(sw0_TO_dsp3_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw0_TO_dsp3_top_wrap_SIG_iniu3_req_ready),
		.iniu4_req_valid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu4_req_payload(dsp4_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu4_req_last(dsp4_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu4_req_srcid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu4_req_qos(dsp4_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu4_req_threshold(sw0_TO_dsp4_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_req_ready(sw0_TO_dsp4_top_wrap_SIG_iniu4_req_ready),
		.iniu5_req_valid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.iniu5_req_payload(dsp5_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.iniu5_req_last(dsp5_top_wrap_TO_sw0_SIG_top_req_req_last),
		.iniu5_req_srcid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.iniu5_req_tgtid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.iniu5_req_qos(dsp5_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.iniu5_req_threshold(sw0_TO_dsp5_top_wrap_SIG_iniu5_req_threshold),
		.iniu5_req_ready(sw0_TO_dsp5_top_wrap_SIG_iniu5_req_ready),
		.iniu0_rsp_valid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_valid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.iniu5_rsp_valid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_valid),
		.iniu5_rsp_payload(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_payload),
		.iniu5_rsp_last(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_last),
		.iniu5_rsp_srcid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_qos),
		.iniu5_rsp_threshold(dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.iniu5_rsp_ready(dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(sw0_tniu_req_porting_tniu_req_valid),
		.tniu_req_ready(sw0_tniu_req_porting_tniu_req_ready),
		.tniu_req_payload(sw0_tniu_req_porting_tniu_req_payload),
		.tniu_req_srcid(sw0_tniu_req_porting_tniu_req_srcid),
		.tniu_req_tgtid(sw0_tniu_req_porting_tniu_req_tgtid),
		.tniu_req_qos(sw0_tniu_req_porting_tniu_req_qos),
		.tniu_req_last(sw0_tniu_req_porting_tniu_req_last),
		.tniu_req_threshold(sw0_tniu_req_porting_tniu_req_threshold),
		.tniu_rsp_valid(sw0_tniu_rsp_porting_tniu_rsp_valid),
		.tniu_rsp_ready(sw0_tniu_rsp_porting_tniu_rsp_ready),
		.tniu_rsp_payload(sw0_tniu_rsp_porting_tniu_rsp_payload),
		.tniu_rsp_srcid(sw0_tniu_rsp_porting_tniu_rsp_srcid),
		.tniu_rsp_tgtid(sw0_tniu_rsp_porting_tniu_rsp_tgtid),
		.tniu_rsp_qos(sw0_tniu_rsp_porting_tniu_rsp_qos),
		.tniu_rsp_last(sw0_tniu_rsp_porting_tniu_rsp_last),
		.tniu_rsp_threshold(sw0_tniu_rsp_porting_tniu_rsp_threshold));
	dti_sw1_dti_noc_switch_5to1_wrap sw1 (
		.clk(clk_dn_func),
		.rst_n(rst_dn_func_n),
		.iniu0_req_valid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.iniu0_req_payload(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.iniu0_req_last(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.iniu0_req_srcid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.iniu0_req_qos(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.iniu0_req_threshold(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.iniu1_req_payload(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.iniu1_req_last(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.iniu1_req_srcid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.iniu1_req_qos(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.iniu1_req_threshold(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.iniu2_req_payload(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.iniu2_req_last(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.iniu2_req_srcid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.iniu2_req_qos(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.iniu2_req_threshold(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_ready),
		.iniu3_req_valid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.iniu3_req_payload(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.iniu3_req_last(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.iniu3_req_srcid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.iniu3_req_qos(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.iniu3_req_threshold(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_ready),
		.iniu4_req_valid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.iniu4_req_payload(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.iniu4_req_last(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.iniu4_req_srcid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.iniu4_req_qos(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.iniu4_req_threshold(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_req_ready(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_ready),
		.iniu0_rsp_valid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_valid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(sw1_tniu_req_porting_tniu_req_valid),
		.tniu_req_ready(sw1_tniu_req_porting_tniu_req_ready),
		.tniu_req_payload(sw1_tniu_req_porting_tniu_req_payload),
		.tniu_req_srcid(sw1_tniu_req_porting_tniu_req_srcid),
		.tniu_req_tgtid(sw1_tniu_req_porting_tniu_req_tgtid),
		.tniu_req_qos(sw1_tniu_req_porting_tniu_req_qos),
		.tniu_req_last(sw1_tniu_req_porting_tniu_req_last),
		.tniu_req_threshold(sw1_tniu_req_porting_tniu_req_threshold),
		.tniu_rsp_valid(sw1_tniu_rsp_porting_tniu_rsp_valid),
		.tniu_rsp_ready(sw1_tniu_rsp_porting_tniu_rsp_ready),
		.tniu_rsp_payload(sw1_tniu_rsp_porting_tniu_rsp_payload),
		.tniu_rsp_srcid(sw1_tniu_rsp_porting_tniu_rsp_srcid),
		.tniu_rsp_tgtid(sw1_tniu_rsp_porting_tniu_rsp_tgtid),
		.tniu_rsp_qos(sw1_tniu_rsp_porting_tniu_rsp_qos),
		.tniu_rsp_last(sw1_tniu_rsp_porting_tniu_rsp_last),
		.tniu_rsp_threshold(sw1_tniu_rsp_porting_tniu_rsp_threshold));
	dti_sw2_dti_noc_switch_4to1_wrap sw2 (
		.clk(clk_dn_func),
		.rst_n(rst_dn_func_n),
		.iniu0_req_valid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.iniu0_req_payload(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.iniu0_req_last(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.iniu0_req_srcid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.iniu0_req_qos(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.iniu0_req_threshold(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_ready),
		.iniu1_req_valid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.iniu1_req_payload(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.iniu1_req_last(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.iniu1_req_srcid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.iniu1_req_qos(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.iniu1_req_threshold(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_ready),
		.iniu2_req_valid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.iniu2_req_payload(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.iniu2_req_last(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.iniu2_req_srcid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.iniu2_req_qos(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.iniu2_req_threshold(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_ready),
		.iniu3_req_valid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.iniu3_req_payload(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.iniu3_req_last(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.iniu3_req_srcid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.iniu3_req_qos(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.iniu3_req_threshold(sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_ready),
		.iniu0_rsp_valid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.tniu_req_valid(sw2_TO_dti_buffer_SIG_tniu_req_valid),
		.tniu_req_ready(dti_buffer_TO_sw2_SIG_write_req_ready),
		.tniu_req_payload(sw2_TO_dti_buffer_SIG_tniu_req_payload),
		.tniu_req_srcid(sw2_TO_dti_buffer_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw2_TO_dti_buffer_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw2_TO_dti_buffer_SIG_tniu_req_qos),
		.tniu_req_last(sw2_TO_dti_buffer_SIG_tniu_req_last),
		.tniu_req_threshold(dti_buffer_TO_sw2_SIG_write_req_threshold),
		.tniu_rsp_valid(sw2_tniu_rsp_porting_tniu_rsp_valid),
		.tniu_rsp_ready(sw2_tniu_rsp_porting_tniu_rsp_ready),
		.tniu_rsp_payload(sw2_tniu_rsp_porting_tniu_rsp_payload),
		.tniu_rsp_srcid(sw2_tniu_rsp_porting_tniu_rsp_srcid),
		.tniu_rsp_tgtid(sw2_tniu_rsp_porting_tniu_rsp_tgtid),
		.tniu_rsp_qos(sw2_tniu_rsp_porting_tniu_rsp_qos),
		.tniu_rsp_last(sw2_tniu_rsp_porting_tniu_rsp_last),
		.tniu_rsp_threshold(sw2_tniu_rsp_porting_tniu_rsp_threshold));
	dti_link_buf dti_buffer (
		.clk(clk_dn_func),
		.rst_n(rst_dn_func_n),
		.stall(dti_buffer_ctrl_porting_stall),
		.clear(dti_buffer_ctrl_porting_clear),
		.idle(dti_buffer_ctrl_porting_idle),
		.write_req_valid(sw2_TO_dti_buffer_SIG_tniu_req_valid),
		.write_req_payload(sw2_TO_dti_buffer_SIG_tniu_req_payload),
		.write_req_last(sw2_TO_dti_buffer_SIG_tniu_req_last),
		.write_req_srcid(sw2_TO_dti_buffer_SIG_tniu_req_srcid),
		.write_req_tgtid(sw2_TO_dti_buffer_SIG_tniu_req_tgtid),
		.write_req_qos(sw2_TO_dti_buffer_SIG_tniu_req_qos),
		.write_req_ready(dti_buffer_TO_sw2_SIG_write_req_ready),
		.write_req_threshold(dti_buffer_TO_sw2_SIG_write_req_threshold),
		.read_resp_valid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_valid),
		.read_resp_payload(dti_buffer_TO_async_bridge_slv_SIG_read_resp_payload),
		.read_resp_last(dti_buffer_TO_async_bridge_slv_SIG_read_resp_last),
		.read_resp_srcid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_srcid),
		.read_resp_tgtid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_tgtid),
		.read_resp_qos(dti_buffer_TO_async_bridge_slv_SIG_read_resp_qos),
		.read_resp_ready(async_bridge_slv_TO_dti_buffer_SIG_s_ready),
		.read_resp_threshold(async_bridge_slv_TO_dti_buffer_SIG_s_threshold),
		.almost_full(dti_buffer_ctrl_porting_almost_full),
		.almost_empty(dti_buffer_ctrl_porting_almost_empty),
		.empty(dti_buffer_ctrl_porting_empty),
		.full(dti_buffer_ctrl_porting_full));
	dsp0_top_wrap dsp0_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp0_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp0_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp0_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp0_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp0_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(dsp0_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp0_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp0_top_wrap_SIG_iniu0_rsp_valid));
	dsp1_top_wrap dsp1_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp1_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp1_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp1_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp1_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp1_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(dsp1_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp1_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp1_top_wrap_SIG_iniu1_rsp_valid));
	dsp2_top_wrap dsp2_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp2_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp2_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp2_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp2_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp2_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp2_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp2_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp2_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp2_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp2_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp2_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp2_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(dsp2_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp2_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp2_top_wrap_SIG_iniu2_rsp_valid));
	dsp3_top_wrap dsp3_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp3_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp3_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp3_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp3_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp3_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp3_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp3_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp3_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp3_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp3_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp3_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp3_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(dsp3_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp3_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp3_top_wrap_SIG_iniu3_rsp_valid));
	dsp4_top_wrap dsp4_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp4_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp4_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp4_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp4_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp4_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp4_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp4_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp4_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp4_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp4_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp4_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp4_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(dsp4_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp4_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp4_top_wrap_SIG_iniu4_rsp_valid));
	dsp5_top_wrap dsp5_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dsp5_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp5_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp5_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp5_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp5_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp5_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp5_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp5_top_wrap_TO_sw0_SIG_top_req_req_last),
		.top_req_req_payload(dsp5_top_wrap_TO_sw0_SIG_top_req_req_payload),
		.top_req_req_qos(dsp5_top_wrap_TO_sw0_SIG_top_req_req_qos),
		.top_req_req_ready(sw0_TO_dsp5_top_wrap_SIG_iniu5_req_ready),
		.top_req_req_srcid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw0_TO_dsp5_top_wrap_SIG_iniu5_req_threshold),
		.top_req_req_valid(dsp5_top_wrap_TO_sw0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_last),
		.top_rsp_rsp_payload(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_payload),
		.top_rsp_rsp_qos(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_qos),
		.top_rsp_rsp_ready(dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_srcid),
		.top_rsp_rsp_tgtid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp5_top_wrap_TO_sw0_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw0_TO_dsp5_top_wrap_SIG_iniu5_rsp_valid));
	cpu_top_wrap cpu_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(cpu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(cpu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(cpu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(cpu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(cpu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(cpu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(cpu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(cpu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(cpu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(cpu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.top_req_req_payload(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.top_req_req_qos(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.top_req_req_ready(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(cpu_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(cpu_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw1_TO_cpu_iniu_top_wrap_SIG_iniu0_rsp_valid));
	pcie_eth_top_wrap pcie_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(pcie_eth_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(pcie_eth_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(pcie_eth_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(pcie_eth_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.top_req_req_payload(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.top_req_req_qos(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.top_req_req_ready(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(pcie_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(pcie_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw1_TO_pcie_iniu_top_wrap_SIG_iniu1_rsp_valid));
	usb_ufs_top_wrap ufs_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(usb_ufs_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(usb_ufs_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(usb_ufs_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(usb_ufs_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.top_req_req_payload(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.top_req_req_qos(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.top_req_req_ready(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(ufs_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(ufs_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw1_TO_ufs_iniu_top_wrap_SIG_iniu2_rsp_valid));
	camera_top_wrap camera_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(camera_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(camera_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(camera_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(camera_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(camera_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(camera_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(camera_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(camera_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(camera_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(camera_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.top_req_req_payload(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.top_req_req_qos(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.top_req_req_ready(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(camera_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(camera_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw1_TO_camera_iniu_top_wrap_SIG_iniu3_rsp_valid));
	mipi_top_wrap mipi_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(mipi_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(mipi_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(mipi_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(mipi_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(mipi_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(mipi_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(mipi_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(mipi_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(mipi_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(mipi_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_last),
		.top_req_req_payload(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_payload),
		.top_req_req_qos(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_qos),
		.top_req_req_ready(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_srcid),
		.top_req_req_tgtid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(mipi_iniu_top_wrap_TO_sw1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(mipi_iniu_top_wrap_TO_sw1_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw1_TO_mipi_iniu_top_wrap_SIG_iniu4_rsp_valid));
	gpu0_top_wrap gpu0_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(gpu0_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu0_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu0_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu0_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu0_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu0_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.top_req_req_payload(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.top_req_req_qos(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.top_req_req_ready(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.top_req_req_tgtid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(gpu0_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(gpu0_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw2_TO_gpu0_iniu_top_wrap_SIG_iniu0_rsp_valid));
	gpu1_top_wrap gpu1_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(gpu1_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(gpu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(gpu1_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(gpu1_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(gpu1_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(gpu1_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(gpu1_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.top_req_req_payload(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.top_req_req_qos(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.top_req_req_ready(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.top_req_req_tgtid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(gpu1_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(gpu1_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw2_TO_gpu1_iniu_top_wrap_SIG_iniu1_rsp_valid));
	dp_top_wrap dp_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(dp_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dp_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dp_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dp_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dp_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dp_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dp_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dp_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dp_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dp_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.top_req_req_payload(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.top_req_req_qos(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.top_req_req_ready(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(dp_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(dp_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw2_TO_dp_iniu_top_wrap_SIG_iniu2_rsp_valid));
	display_top_wrap display_iniu_top_wrap (
		.clk_top(clk_dn_func),
		.rst_top_n(rst_dn_func_n),
		.async_fifo_req_pld_sync(display_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(display_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(display_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(display_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(display_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(display_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(display_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(display_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(display_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(display_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_last),
		.top_req_req_payload(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_payload),
		.top_req_req_qos(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_qos),
		.top_req_req_ready(sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_srcid),
		.top_req_req_tgtid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw2_TO_display_iniu_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(display_iniu_top_wrap_TO_sw2_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(display_iniu_top_wrap_TO_sw2_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw2_TO_display_iniu_top_wrap_SIG_iniu3_rsp_valid));
	dti_async_bridge_slv async_bridge_slv (
		.clk(clk_dn_func),
		.rst_n(rst_dn_func_n),
		.stall(),
		.clear(),
		.full_zero(),
		.s_valid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_valid),
		.s_ready(async_bridge_slv_TO_dti_buffer_SIG_s_ready),
		.s_payload(dti_buffer_TO_async_bridge_slv_SIG_read_resp_payload),
		.s_last(dti_buffer_TO_async_bridge_slv_SIG_read_resp_last),
		.s_srcid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_srcid),
		.s_tgtid(dti_buffer_TO_async_bridge_slv_SIG_read_resp_tgtid),
		.s_qos(dti_buffer_TO_async_bridge_slv_SIG_read_resp_qos),
		.s_threshold(async_bridge_slv_TO_dti_buffer_SIG_s_threshold),
		.almost_full(),
		.wptr_async(dti_req_rsp_async_bridge_slv_sync_porting_wptr_async),
		.rptr_async(dti_req_rsp_async_bridge_slv_sync_porting_rptr_async),
		.rptr_sync(dti_req_rsp_async_bridge_slv_sync_porting_rptr_sync),
		.pld_sync(dti_req_rsp_async_bridge_slv_sync_porting_pld_sync));

endmodule
//[UHDL]Content End [md5:bbf6186fb729808565c4d1e5b0dd5540]


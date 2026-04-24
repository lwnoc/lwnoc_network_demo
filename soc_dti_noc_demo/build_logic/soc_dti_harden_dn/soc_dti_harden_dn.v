//[UHDL]Content Start [md5:7f572346e50378e532c8b70cfbd37c33]
module soc_dti_harden_dn
	(
	input                                                 clk_noc_dn                                                            ,
	input                                                 rst_noc_dn_n                                                          ,
	input                                                 link_req_iniu1_req_last                                               ,
	input  [89:0]                                         link_req_iniu1_req_payload                                            ,
	input                                                 link_req_iniu1_req_qos                                                ,
	output                                                link_req_iniu1_req_ready                                              ,
	input  [5:0]                                          link_req_iniu1_req_srcid                                              ,
	input  [5:0]                                          link_req_iniu1_req_tgtid                                              ,
	output                                                link_req_iniu1_req_threshold                                          ,
	input                                                 link_req_iniu1_req_valid                                              ,
	output                                                link_rsp_iniu1_rsp_last                                               ,
	output [89:0]                                         link_rsp_iniu1_rsp_payload                                            ,
	output                                                link_rsp_iniu1_rsp_qos                                                ,
	input                                                 link_rsp_iniu1_rsp_ready                                              ,
	output [5:0]                                          link_rsp_iniu1_rsp_srcid                                              ,
	output [5:0]                                          link_rsp_iniu1_rsp_tgtid                                              ,
	input                                                 link_rsp_iniu1_rsp_threshold                                          ,
	output                                                link_rsp_iniu1_rsp_valid                                              ,
	output [104:0]                                        sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	input  [104:0]                                        sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	output [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	input  [9:0]                                          sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] sys_tcu_tniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] sys_tcu_tniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss0_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss0_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss1_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss1_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss2_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss2_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss3_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss3_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss4_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss4_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] dsp_ss5_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] dsp_ss5_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       ,
	input  [104:0]                                        vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync       ,
	output [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async     ,
	output [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync      ,
	input  [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async     ,
	output [104:0]                                        vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync       ,
	input  [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async     ,
	input  [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync      ,
	output [15:0]                                         vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async     ,
	output logic [9-1:0] vpu_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req        ,
	input logic [9-1:0] vpu_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req        ,
	input  [104:0]                                        pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync  ,
	output [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async,
	output [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync ,
	input  [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async,
	output [104:0]                                        pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync  ,
	input  [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async,
	input  [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync ,
	output [15:0]                                         pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async,
	output logic [9-1:0] pcie_eth_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req   ,
	input logic [9-1:0] pcie_eth_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req   ,
	input  [104:0]                                        ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync       ,
	output [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async     ,
	output [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync      ,
	input  [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async     ,
	output [104:0]                                        ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync       ,
	input  [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async     ,
	input  [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync      ,
	output [15:0]                                         ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async     ,
	output logic [9-1:0] ufs_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req        ,
	input logic [9-1:0] ufs_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req        ,
	input  [104:0]                                        camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync    ,
	output [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async  ,
	output [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync   ,
	input  [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async  ,
	output [104:0]                                        camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync    ,
	input  [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async  ,
	input  [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync   ,
	output [15:0]                                         camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async  ,
	output logic [9-1:0] camera_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req     ,
	input logic [9-1:0] camera_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req     ,
	input  [104:0]                                        mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync      ,
	output [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async    ,
	output [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync     ,
	input  [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async    ,
	output [104:0]                                        mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync      ,
	input  [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async    ,
	input  [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync     ,
	output [15:0]                                         mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async    ,
	output logic [9-1:0] mipi_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req       ,
	input logic [9-1:0] mipi_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req       );

	//Wire define for this module.

	//Wire define for sub module.
	wire        dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid       ;
	wire [89:0] dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload     ;
	wire [5:0]  dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid       ;
	wire [5:0]  dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid       ;
	wire        dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos         ;
	wire        dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last        ;
	wire        dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready       ;
	wire        dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold   ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_req_ready                       ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_req_threshold                   ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_valid                       ;
	wire [89:0] sw_root_TO_sw_dsp6_SIG_iniu0_rsp_payload                     ;
	wire [5:0]  sw_root_TO_sw_dsp6_SIG_iniu0_rsp_srcid                       ;
	wire [5:0]  sw_root_TO_sw_dsp6_SIG_iniu0_rsp_tgtid                       ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_qos                         ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_last                        ;
	wire        vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid         ;
	wire [89:0] vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload       ;
	wire [5:0]  vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid         ;
	wire [5:0]  vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid         ;
	wire        vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos           ;
	wire        vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last          ;
	wire        vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready         ;
	wire        vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold     ;
	wire        pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid    ;
	wire [89:0] pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload  ;
	wire [5:0]  pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid    ;
	wire [5:0]  pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid    ;
	wire        pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos      ;
	wire        pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last     ;
	wire        pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready    ;
	wire        pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold;
	wire        ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid         ;
	wire [89:0] ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload       ;
	wire [5:0]  ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid         ;
	wire [5:0]  ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid         ;
	wire        ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos           ;
	wire        ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last          ;
	wire        ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready         ;
	wire        ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold     ;
	wire        camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid      ;
	wire [89:0] camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload    ;
	wire [5:0]  camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid      ;
	wire [5:0]  camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid      ;
	wire        camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos        ;
	wire        camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last       ;
	wire        camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready      ;
	wire        camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold  ;
	wire        mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid        ;
	wire [89:0] mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload      ;
	wire [5:0]  mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid        ;
	wire [5:0]  mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid        ;
	wire        mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos          ;
	wire        mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last         ;
	wire        mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready        ;
	wire        mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold    ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_req_ready                       ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_req_threshold                   ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_valid                       ;
	wire [89:0] sw_right_TO_sw_io5_SIG_iniu0_rsp_payload                     ;
	wire [5:0]  sw_right_TO_sw_io5_SIG_iniu0_rsp_srcid                       ;
	wire [5:0]  sw_right_TO_sw_io5_SIG_iniu0_rsp_tgtid                       ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_qos                         ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_last                        ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_valid                        ;
	wire [89:0] sw_io5_TO_sw_right_SIG_tniu_req_payload                      ;
	wire [5:0]  sw_io5_TO_sw_right_SIG_tniu_req_srcid                        ;
	wire [5:0]  sw_io5_TO_sw_right_SIG_tniu_req_tgtid                        ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_qos                          ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_last                         ;
	wire        sw_io5_TO_sw_right_SIG_tniu_rsp_ready                        ;
	wire        sw_io5_TO_sw_right_SIG_tniu_rsp_threshold                    ;
	wire        sw_root_TO_sw_right_SIG_iniu1_req_ready                      ;
	wire        sw_root_TO_sw_right_SIG_iniu1_req_threshold                  ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_valid                      ;
	wire [89:0] sw_root_TO_sw_right_SIG_iniu1_rsp_payload                    ;
	wire [5:0]  sw_root_TO_sw_right_SIG_iniu1_rsp_srcid                      ;
	wire [5:0]  sw_root_TO_sw_right_SIG_iniu1_rsp_tgtid                      ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_qos                        ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_last                       ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_valid                        ;
	wire [89:0] sw_dsp6_TO_sw_root_SIG_tniu_req_payload                      ;
	wire [5:0]  sw_dsp6_TO_sw_root_SIG_tniu_req_srcid                        ;
	wire [5:0]  sw_dsp6_TO_sw_root_SIG_tniu_req_tgtid                        ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_qos                          ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_last                         ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_rsp_ready                        ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_rsp_threshold                    ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_valid                       ;
	wire [89:0] sw_right_TO_sw_root_SIG_tniu_req_payload                     ;
	wire [5:0]  sw_right_TO_sw_root_SIG_tniu_req_srcid                       ;
	wire [5:0]  sw_right_TO_sw_root_SIG_tniu_req_tgtid                       ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_qos                         ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_last                        ;
	wire        sw_right_TO_sw_root_SIG_tniu_rsp_ready                       ;
	wire        sw_right_TO_sw_root_SIG_tniu_rsp_threshold                   ;
	wire        sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_ready       ;
	wire        sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_threshold   ;
	wire        sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_valid       ;
	wire [89:0] sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_payload     ;
	wire [5:0]  sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_srcid       ;
	wire [5:0]  sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_tgtid       ;
	wire        sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_qos         ;
	wire        sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_last        ;
	wire        sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_last           ;
	wire [89:0] sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_payload        ;
	wire        sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_qos            ;
	wire [5:0]  sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_srcid          ;
	wire [5:0]  sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_tgtid          ;
	wire        sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_valid          ;
	wire        sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_ready          ;
	wire        sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold      ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid         ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid         ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_valid         ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_valid         ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_valid         ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_ready         ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_threshold     ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_last          ;
	wire [89:0] sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_payload       ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_qos           ;
	wire [5:0]  sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_srcid         ;
	wire [5:0]  sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_tgtid         ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_valid         ;
	wire        sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_ready           ;
	wire        sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_threshold       ;
	wire        sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_last            ;
	wire [89:0] sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_payload         ;
	wire        sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_qos             ;
	wire [5:0]  sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_srcid           ;
	wire [5:0]  sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_tgtid           ;
	wire        sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_valid           ;
	wire        sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_ready      ;
	wire        sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_threshold  ;
	wire        sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_last       ;
	wire [89:0] sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_payload    ;
	wire        sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_qos        ;
	wire [5:0]  sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_srcid      ;
	wire [5:0]  sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_tgtid      ;
	wire        sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_valid      ;
	wire        sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_ready           ;
	wire        sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_threshold       ;
	wire        sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_last            ;
	wire [89:0] sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_payload         ;
	wire        sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_qos             ;
	wire [5:0]  sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid           ;
	wire [5:0]  sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid           ;
	wire        sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_valid           ;
	wire        sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_ready        ;
	wire        sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_threshold    ;
	wire        sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_last         ;
	wire [89:0] sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_payload      ;
	wire        sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_qos          ;
	wire [5:0]  sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid        ;
	wire [5:0]  sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid        ;
	wire        sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_valid        ;
	wire        sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_ready          ;
	wire        sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_threshold      ;
	wire        sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_last           ;
	wire [89:0] sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_payload        ;
	wire        sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_qos            ;
	wire [5:0]  sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_srcid          ;
	wire [5:0]  sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_tgtid          ;
	wire        sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_valid          ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	soc_dti_sw_dsp6_dti_switch_6i1o_wrap sw_dsp6 (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.iniu0_req_valid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu0_req_ready(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_ready),
		.iniu0_req_payload(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu0_req_srcid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu0_req_qos(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu0_req_last(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu0_req_threshold(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.iniu1_req_valid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_ready),
		.iniu1_req_payload(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu1_req_srcid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu1_req_qos(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu1_req_last(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu1_req_threshold(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.iniu2_req_valid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu2_req_ready(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_ready),
		.iniu2_req_payload(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu2_req_srcid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu2_req_qos(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu2_req_last(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu2_req_threshold(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.iniu3_req_valid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu3_req_ready(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_ready),
		.iniu3_req_payload(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu3_req_srcid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu3_req_qos(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu3_req_last(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu3_req_threshold(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.iniu4_req_valid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu4_req_ready(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_ready),
		.iniu4_req_payload(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu4_req_srcid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu4_req_qos(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu4_req_last(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu4_req_threshold(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_rsp_valid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_ready(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_payload(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_srcid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_last(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_threshold(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.iniu5_req_valid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.iniu5_req_ready(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_ready),
		.iniu5_req_payload(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.iniu5_req_srcid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.iniu5_req_tgtid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.iniu5_req_qos(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.iniu5_req_last(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.iniu5_req_threshold(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_threshold),
		.iniu5_rsp_valid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_valid),
		.iniu5_rsp_ready(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.iniu5_rsp_payload(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_payload),
		.iniu5_rsp_srcid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_qos),
		.iniu5_rsp_last(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_last),
		.iniu5_rsp_threshold(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.tniu_req_valid(sw_dsp6_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_dsp6_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_dsp6_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_dsp6_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_dsp6_TO_sw_root_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_dsp6_TO_sw_root_SIG_tniu_req_qos),
		.tniu_req_last(sw_dsp6_TO_sw_root_SIG_tniu_req_last),
		.tniu_req_threshold(sw_root_TO_sw_dsp6_SIG_iniu0_req_threshold),
		.tniu_rsp_valid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_dsp6_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_srcid),
		.tniu_rsp_tgtid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_tgtid),
		.tniu_rsp_qos(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_qos),
		.tniu_rsp_last(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_last),
		.tniu_rsp_threshold(sw_dsp6_TO_sw_root_SIG_tniu_rsp_threshold));
	soc_dti_sw_io5_dti_switch_5i1o_wrap sw_io5 (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.iniu0_req_valid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.iniu0_req_ready(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_ready),
		.iniu0_req_payload(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.iniu0_req_srcid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.iniu0_req_tgtid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.iniu0_req_qos(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.iniu0_req_last(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.iniu0_req_threshold(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.iniu1_req_valid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_ready),
		.iniu1_req_payload(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.iniu1_req_srcid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.iniu1_req_tgtid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.iniu1_req_qos(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.iniu1_req_last(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.iniu1_req_threshold(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.iniu2_req_valid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.iniu2_req_ready(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_ready),
		.iniu2_req_payload(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.iniu2_req_srcid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.iniu2_req_tgtid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.iniu2_req_qos(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.iniu2_req_last(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.iniu2_req_threshold(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.iniu3_req_valid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.iniu3_req_ready(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_ready),
		.iniu3_req_payload(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.iniu3_req_srcid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.iniu3_req_tgtid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.iniu3_req_qos(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.iniu3_req_last(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.iniu3_req_threshold(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.iniu4_req_valid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.iniu4_req_ready(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_ready),
		.iniu4_req_payload(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.iniu4_req_srcid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.iniu4_req_tgtid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.iniu4_req_qos(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.iniu4_req_last(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.iniu4_req_threshold(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_threshold),
		.iniu4_rsp_valid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_valid),
		.iniu4_rsp_ready(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.iniu4_rsp_payload(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.iniu4_rsp_srcid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.iniu4_rsp_last(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_last),
		.iniu4_rsp_threshold(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.tniu_req_valid(sw_io5_TO_sw_right_SIG_tniu_req_valid),
		.tniu_req_ready(sw_right_TO_sw_io5_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_io5_TO_sw_right_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_io5_TO_sw_right_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_io5_TO_sw_right_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_io5_TO_sw_right_SIG_tniu_req_qos),
		.tniu_req_last(sw_io5_TO_sw_right_SIG_tniu_req_last),
		.tniu_req_threshold(sw_right_TO_sw_io5_SIG_iniu0_req_threshold),
		.tniu_rsp_valid(sw_right_TO_sw_io5_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_io5_TO_sw_right_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_right_TO_sw_io5_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_right_TO_sw_io5_SIG_iniu0_rsp_srcid),
		.tniu_rsp_tgtid(sw_right_TO_sw_io5_SIG_iniu0_rsp_tgtid),
		.tniu_rsp_qos(sw_right_TO_sw_io5_SIG_iniu0_rsp_qos),
		.tniu_rsp_last(sw_right_TO_sw_io5_SIG_iniu0_rsp_last),
		.tniu_rsp_threshold(sw_io5_TO_sw_right_SIG_tniu_rsp_threshold));
	soc_dti_sw_right_dti_switch_2i1o_wrap sw_right (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.iniu0_req_valid(sw_io5_TO_sw_right_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_right_TO_sw_io5_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_io5_TO_sw_right_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_io5_TO_sw_right_SIG_tniu_req_srcid),
		.iniu0_req_tgtid(sw_io5_TO_sw_right_SIG_tniu_req_tgtid),
		.iniu0_req_qos(sw_io5_TO_sw_right_SIG_tniu_req_qos),
		.iniu0_req_last(sw_io5_TO_sw_right_SIG_tniu_req_last),
		.iniu0_req_threshold(sw_right_TO_sw_io5_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_right_TO_sw_io5_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_io5_TO_sw_right_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_right_TO_sw_io5_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_right_TO_sw_io5_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_right_TO_sw_io5_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_right_TO_sw_io5_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_right_TO_sw_io5_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(sw_io5_TO_sw_right_SIG_tniu_rsp_threshold),
		.iniu1_req_valid(link_req_iniu1_req_valid),
		.iniu1_req_ready(link_req_iniu1_req_ready),
		.iniu1_req_payload(link_req_iniu1_req_payload),
		.iniu1_req_srcid(link_req_iniu1_req_srcid),
		.iniu1_req_tgtid(link_req_iniu1_req_tgtid),
		.iniu1_req_qos(link_req_iniu1_req_qos),
		.iniu1_req_last(link_req_iniu1_req_last),
		.iniu1_req_threshold(link_req_iniu1_req_threshold),
		.iniu1_rsp_valid(link_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(link_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(link_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(link_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(link_rsp_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(link_rsp_iniu1_rsp_qos),
		.iniu1_rsp_last(link_rsp_iniu1_rsp_last),
		.iniu1_rsp_threshold(link_rsp_iniu1_rsp_threshold),
		.tniu_req_valid(sw_right_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_right_SIG_iniu1_req_ready),
		.tniu_req_payload(sw_right_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_right_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_right_TO_sw_root_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_right_TO_sw_root_SIG_tniu_req_qos),
		.tniu_req_last(sw_right_TO_sw_root_SIG_tniu_req_last),
		.tniu_req_threshold(sw_root_TO_sw_right_SIG_iniu1_req_threshold),
		.tniu_rsp_valid(sw_root_TO_sw_right_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(sw_right_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_right_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_right_SIG_iniu1_rsp_srcid),
		.tniu_rsp_tgtid(sw_root_TO_sw_right_SIG_iniu1_rsp_tgtid),
		.tniu_rsp_qos(sw_root_TO_sw_right_SIG_iniu1_rsp_qos),
		.tniu_rsp_last(sw_root_TO_sw_right_SIG_iniu1_rsp_last),
		.tniu_rsp_threshold(sw_right_TO_sw_root_SIG_tniu_rsp_threshold));
	soc_dti_sw_root_dti_switch_2i1o_wrap sw_root (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.iniu0_req_valid(sw_dsp6_TO_sw_root_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_root_TO_sw_dsp6_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_dsp6_TO_sw_root_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_dsp6_TO_sw_root_SIG_tniu_req_srcid),
		.iniu0_req_tgtid(sw_dsp6_TO_sw_root_SIG_tniu_req_tgtid),
		.iniu0_req_qos(sw_dsp6_TO_sw_root_SIG_tniu_req_qos),
		.iniu0_req_last(sw_dsp6_TO_sw_root_SIG_tniu_req_last),
		.iniu0_req_threshold(sw_root_TO_sw_dsp6_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_dsp6_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_root_TO_sw_dsp6_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(sw_dsp6_TO_sw_root_SIG_tniu_rsp_threshold),
		.iniu1_req_valid(sw_right_TO_sw_root_SIG_tniu_req_valid),
		.iniu1_req_ready(sw_root_TO_sw_right_SIG_iniu1_req_ready),
		.iniu1_req_payload(sw_right_TO_sw_root_SIG_tniu_req_payload),
		.iniu1_req_srcid(sw_right_TO_sw_root_SIG_tniu_req_srcid),
		.iniu1_req_tgtid(sw_right_TO_sw_root_SIG_tniu_req_tgtid),
		.iniu1_req_qos(sw_right_TO_sw_root_SIG_tniu_req_qos),
		.iniu1_req_last(sw_right_TO_sw_root_SIG_tniu_req_last),
		.iniu1_req_threshold(sw_root_TO_sw_right_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_root_TO_sw_right_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(sw_right_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu1_rsp_payload(sw_root_TO_sw_right_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_root_TO_sw_right_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_root_TO_sw_right_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_root_TO_sw_right_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_root_TO_sw_right_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(sw_right_TO_sw_root_SIG_tniu_rsp_threshold),
		.tniu_req_valid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_valid),
		.tniu_req_ready(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_ready),
		.tniu_req_payload(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_qos),
		.tniu_req_last(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_last),
		.tniu_req_threshold(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_threshold),
		.tniu_rsp_valid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_valid),
		.tniu_rsp_ready(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_payload),
		.tniu_rsp_srcid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_qos),
		.tniu_rsp_last(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_last),
		.tniu_rsp_threshold(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold));
	sys_tcu_tniu_top_wrap sys_tcu_tniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(sys_tcu_tniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(sys_tcu_tniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(sys_tcu_tniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_last),
		.top_req_req_payload(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_payload),
		.top_req_req_qos(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_qos),
		.top_req_req_ready(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_ready),
		.top_req_req_srcid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_srcid),
		.top_req_req_tgtid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_tgtid),
		.top_req_req_threshold(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_req_req_threshold),
		.top_req_req_valid(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_req_valid),
		.top_rsp_rsp_last(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_last),
		.top_rsp_rsp_payload(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_ready),
		.top_rsp_rsp_srcid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(sw_root_TO_sys_tcu_tniu_top_wrap_SIG_tniu_rsp_threshold),
		.top_rsp_rsp_valid(sys_tcu_tniu_top_wrap_TO_sw_root_SIG_top_rsp_rsp_valid));
	dsp_ss0_iniu_top_wrap dsp_ss0_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss0_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss0_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss0_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss0_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss0_iniu_top_wrap_SIG_iniu0_rsp_valid));
	dsp_ss1_iniu_top_wrap dsp_ss1_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss1_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss1_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss1_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss1_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss1_iniu_top_wrap_SIG_iniu1_rsp_valid));
	dsp_ss2_iniu_top_wrap dsp_ss2_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss2_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss2_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss2_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss2_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss2_iniu_top_wrap_SIG_iniu2_rsp_valid));
	dsp_ss3_iniu_top_wrap dsp_ss3_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss3_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss3_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss3_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss3_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss3_iniu_top_wrap_SIG_iniu3_rsp_valid));
	dsp_ss4_iniu_top_wrap dsp_ss4_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss4_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss4_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss4_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss4_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss4_iniu_top_wrap_SIG_iniu4_rsp_valid));
	dsp_ss5_iniu_top_wrap dsp_ss5_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(dsp_ss5_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(dsp_ss5_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(dsp_ss5_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_last),
		.top_req_req_payload(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_payload),
		.top_req_req_qos(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_qos),
		.top_req_req_ready(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_ready),
		.top_req_req_srcid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_srcid),
		.top_req_req_tgtid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_req_threshold),
		.top_req_req_valid(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_last),
		.top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_payload),
		.top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_qos),
		.top_rsp_rsp_ready(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_tgtid),
		.top_rsp_rsp_threshold(dsp_ss5_iniu_top_wrap_TO_sw_dsp6_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss5_iniu_top_wrap_SIG_iniu5_rsp_valid));
	vpu_ss_iniu_top_wrap vpu_ss_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(vpu_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(vpu_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(vpu_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.top_req_req_payload(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.top_req_req_qos(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.top_req_req_ready(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_ready),
		.top_req_req_srcid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.top_req_req_tgtid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_req_threshold),
		.top_req_req_valid(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_qos(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_qos),
		.top_rsp_rsp_ready(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_tgtid),
		.top_rsp_rsp_threshold(vpu_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_io5_TO_vpu_ss_iniu_top_wrap_SIG_iniu0_rsp_valid));
	pcie_eth_ss_iniu_top_wrap pcie_eth_ss_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(pcie_eth_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(pcie_eth_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(pcie_eth_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.top_req_req_payload(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.top_req_req_qos(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.top_req_req_ready(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_ready),
		.top_req_req_srcid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.top_req_req_tgtid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_req_threshold),
		.top_req_req_valid(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_qos(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_qos),
		.top_rsp_rsp_ready(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_tgtid),
		.top_rsp_rsp_threshold(pcie_eth_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_io5_TO_pcie_eth_ss_iniu_top_wrap_SIG_iniu1_rsp_valid));
	ufs_ss_iniu_top_wrap ufs_ss_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(ufs_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(ufs_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(ufs_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.top_req_req_payload(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.top_req_req_qos(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.top_req_req_ready(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_ready),
		.top_req_req_srcid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.top_req_req_tgtid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_req_threshold),
		.top_req_req_valid(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_qos(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_qos),
		.top_rsp_rsp_ready(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_tgtid),
		.top_rsp_rsp_threshold(ufs_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_io5_TO_ufs_ss_iniu_top_wrap_SIG_iniu2_rsp_valid));
	camera_ss_iniu_top_wrap camera_ss_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(camera_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(camera_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(camera_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.top_req_req_payload(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.top_req_req_qos(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.top_req_req_ready(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_ready),
		.top_req_req_srcid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.top_req_req_tgtid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_req_threshold),
		.top_req_req_valid(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_qos(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_qos),
		.top_rsp_rsp_ready(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_tgtid),
		.top_rsp_rsp_threshold(camera_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_io5_TO_camera_ss_iniu_top_wrap_SIG_iniu3_rsp_valid));
	mipi_ss_iniu_top_wrap mipi_ss_iniu_top_wrap (
		.clk_top(clk_noc_dn),
		.rst_top_n(rst_noc_dn_n),
		.async_fifo_req_pld_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(mipi_ss_iniu_top_wrap_async_fifo_porting_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(mipi_ss_iniu_top_wrap_lp_top_tx_porting_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(mipi_ss_iniu_top_wrap_lp_top_rx_porting_lp_top_rx_lp_hub_rx_req),
		.top_req_req_last(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_last),
		.top_req_req_payload(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_payload),
		.top_req_req_qos(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_qos),
		.top_req_req_ready(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_ready),
		.top_req_req_srcid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_srcid),
		.top_req_req_tgtid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_tgtid),
		.top_req_req_threshold(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_req_threshold),
		.top_req_req_valid(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_last),
		.top_rsp_rsp_payload(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_payload),
		.top_rsp_rsp_qos(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_qos),
		.top_rsp_rsp_ready(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_srcid),
		.top_rsp_rsp_tgtid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_tgtid),
		.top_rsp_rsp_threshold(mipi_ss_iniu_top_wrap_TO_sw_io5_SIG_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(sw_io5_TO_mipi_ss_iniu_top_wrap_SIG_iniu4_rsp_valid));

endmodule
//[UHDL]Content End [md5:7f572346e50378e532c8b70cfbd37c33]


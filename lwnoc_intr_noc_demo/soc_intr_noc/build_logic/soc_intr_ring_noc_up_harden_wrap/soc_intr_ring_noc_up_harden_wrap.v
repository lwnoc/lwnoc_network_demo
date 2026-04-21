//[UHDL]Content Start [md5:be06a0d13d8188d195fda518a12fef78]
module soc_intr_ring_noc_up_harden_wrap (
	input         clk_up_func                                                                 ,
	input         rst_up_func_n                                                               ,
	output        pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_last                 ,
	output [39:0] pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_payload              ,
	output [3:0]  pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_qos                  ,
	input         pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_ready                ,
	output [7:0]  pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_srcid                ,
	output [7:0]  pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_tgtid                ,
	output        pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_valid                ,
	input         pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_last                   ,
	input  [39:0] pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_payload                ,
	input  [3:0]  pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_qos                    ,
	output        pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_ready                  ,
	input  [7:0]  pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_srcid                  ,
	input  [7:0]  pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_tgtid                  ,
	input         pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_valid                  ,
	output        nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_last                 ,
	output [39:0] nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_payload              ,
	output [3:0]  nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_qos                  ,
	input         nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_ready                ,
	output [7:0]  nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_srcid                ,
	output [7:0]  nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_tgtid                ,
	output        nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_valid                ,
	input         nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_last                   ,
	input  [39:0] nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_payload                ,
	input  [3:0]  nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_qos                    ,
	output        nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_ready                  ,
	input  [7:0]  nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_srcid                  ,
	input  [7:0]  nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_tgtid                  ,
	input         nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_valid                  ,
	input  [61:0] cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                 ,
	output [15:0] cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async               ,
	output [15:0] cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                ,
	input  [15:0] cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async               ,
	output [8:0]  cpu_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req    ,
	input  [8:0]  cpu_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req    ,
	output [61:0] cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync                 ,
	input  [9:0]  cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async               ,
	input  [9:0]  cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                ,
	output [9:0]  cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async               ,
	input  [9:0]  cpu_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val            ,
	input  [8:0]  cpu_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req    ,
	output [8:0]  cpu_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req    ,
	input  [61:0] audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync               ,
	output [15:0] audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async             ,
	output [15:0] audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync              ,
	input  [15:0] audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async             ,
	output [8:0]  audio_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req  ,
	input  [8:0]  audio_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req  ,
	output [61:0] peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync                ,
	input  [9:0]  peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async              ,
	input  [9:0]  peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync               ,
	output [9:0]  peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async              ,
	input  [9:0]  peri_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val           ,
	input  [8:0]  peri_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req   ,
	output [8:0]  peri_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req   ,
	input  [61:0] gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                ,
	output [15:0] gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async              ,
	output [15:0] gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync               ,
	input  [15:0] gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async              ,
	output [8:0]  gpu_ss1_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req   ,
	input  [8:0]  gpu_ss1_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req   ,
	output [61:0] gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync                ,
	input  [9:0]  gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async              ,
	input  [9:0]  gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync               ,
	output [9:0]  gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async              ,
	input  [9:0]  gpu_ss0_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val           ,
	input  [8:0]  gpu_ss0_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req   ,
	output [8:0]  gpu_ss0_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req   ,
	output [61:0] display_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync             ,
	input  [9:0]  display_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async           ,
	input  [9:0]  display_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync            ,
	output [9:0]  display_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async           ,
	input  [9:0]  display_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val        ,
	input  [8:0]  display_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req,
	output [8:0]  display_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req,
	input  [61:0] dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                  ,
	output [15:0] dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                ,
	output [15:0] dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                 ,
	input  [15:0] dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                ,
	output [8:0]  dp_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req     ,
	input  [8:0]  dp_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req     ,
	input  [61:0] ddr6_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                   ,
	output [15:0] ddr6_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                 ,
	output [15:0] ddr6_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                  ,
	input  [15:0] ddr6_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                 ,
	output [8:0]  ddr6_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req      ,
	input  [8:0]  ddr6_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req      ,
	input  [61:0] ddr7_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                   ,
	output [15:0] ddr7_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                 ,
	output [15:0] ddr7_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                  ,
	input  [15:0] ddr7_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                 ,
	output [8:0]  ddr7_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req      ,
	input  [8:0]  ddr7_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req      ,
	input  [61:0] ddr8_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                   ,
	output [15:0] ddr8_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                 ,
	output [15:0] ddr8_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                  ,
	input  [15:0] ddr8_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                 ,
	output [8:0]  ddr8_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req      ,
	input  [8:0]  ddr8_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req      ,
	input  [61:0] ddr9_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                   ,
	output [15:0] ddr9_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                 ,
	output [15:0] ddr9_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                  ,
	input  [15:0] ddr9_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                 ,
	output [8:0]  ddr9_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req      ,
	input  [8:0]  ddr9_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req      ,
	input  [61:0] ddr10_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync                  ,
	output [15:0] ddr10_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async                ,
	output [15:0] ddr10_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                 ,
	input  [15:0] ddr10_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async                ,
	output [8:0]  ddr10_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req     ,
	input  [8:0]  ddr10_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req     ,
	output [61:0] ddr11_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync                  ,
	input  [9:0]  ddr11_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async                ,
	input  [9:0]  ddr11_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync                 ,
	output [9:0]  ddr11_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async                ,
	input  [9:0]  ddr11_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val             ,
	input  [8:0]  ddr11_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req     ,
	output [8:0]  ddr11_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req     );

	//Wire define for this module.

	//Wire define for sub module.
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready          ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last        ;
	wire [39:0] cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload     ;
	wire [3:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos         ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid       ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid       ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid       ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last        ;
	wire [39:0] cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload     ;
	wire [3:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos         ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid       ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid       ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid       ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready        ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last      ;
	wire [39:0] audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid     ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid     ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready          ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last      ;
	wire [39:0] cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid     ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid     ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready       ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last     ;
	wire [39:0] peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid    ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid    ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready        ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last     ;
	wire [39:0] audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid    ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid    ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready        ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last      ;
	wire [39:0] gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid     ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid     ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready       ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last      ;
	wire [39:0] peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid     ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid     ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready        ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last      ;
	wire [39:0] gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload   ;
	wire [3:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos       ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid     ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid     ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid     ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready        ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last      ;
	wire [39:0] gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid     ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid     ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready     ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last   ;
	wire [39:0] display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload;
	wire [3:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos    ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid  ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid  ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid  ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready        ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last   ;
	wire [39:0] gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload;
	wire [3:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid  ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid  ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready       ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_last     ;
	wire [39:0] dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid    ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid    ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready     ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last     ;
	wire [39:0] display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload  ;
	wire [3:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos      ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid    ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid    ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid    ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready             ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last           ;
	wire [39:0] ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid          ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid          ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready       ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last           ;
	wire [39:0] dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid          ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid          ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready              ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last            ;
	wire [39:0] ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid           ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid           ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready             ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire [39:0] ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready              ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last            ;
	wire [39:0] ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid           ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid           ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire [39:0] ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready              ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last            ;
	wire [39:0] ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid           ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid           ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire [39:0] ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready             ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last           ;
	wire [39:0] ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid          ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid          ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_last           ;
	wire [39:0] ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid          ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid          ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready            ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last          ;
	wire [39:0] ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid         ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid         ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready             ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last          ;
	wire [39:0] ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid         ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid         ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready            ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_iniu_noc_side cpu_ss_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
		.pring_in_if_pring_in_if_pring_in_if_last(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(pring_in_from_dn_pring_in_if_pring_in_if_pring_in_if_valid),
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
		.nring_out_if_nring_out_if_nring_out_if_last(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(nring_out_to_dn_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(cpu_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(cpu_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	cpu_ss_tniu_noc_side cpu_ss_tniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(cpu_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(cpu_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(cpu_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(cpu_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	audio_ss_iniu_noc_side audio_ss_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(audio_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(audio_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(audio_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	peri_ss_tniu_noc_side peri_ss_tniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(peri_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(peri_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(peri_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(peri_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	gpu_ss1_iniu_noc_side gpu_ss1_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss1_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(gpu_ss1_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(gpu_ss1_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	gpu_ss0_tniu_noc_side gpu_ss0_tniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(gpu_ss0_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(gpu_ss0_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(gpu_ss0_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(gpu_ss0_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	display_ss_tniu_noc_side display_ss_tniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(display_ss_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(display_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(display_ss_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(display_ss_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(display_ss_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(display_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(display_ss_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req));
	dp_ss_iniu_noc_side dp_ss_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(dp_ss_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(dp_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(dp_ss_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr6_iniu_noc_side ddr6_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(ddr6_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr6_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr6_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr6_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr6_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr6_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr7_iniu_noc_side ddr7_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(ddr7_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr7_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr7_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr7_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr7_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr7_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr8_iniu_noc_side ddr8_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(ddr8_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr8_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr8_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr8_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr8_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr8_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr9_iniu_noc_side ddr9_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(ddr9_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr9_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr9_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr9_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr9_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr9_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr10_iniu_noc_side ddr10_iniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
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
		.async_fifo_pld_sync(ddr10_iniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr10_iniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr10_iniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr10_iniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(ddr10_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(ddr10_iniu_noc_side_lp_async_porting_lp_async_m_async_master_hub_tx_req));
	ddr11_tniu_noc_side ddr11_tniu (
		.clk_top_func(clk_up_func),
		.rst_top_func_n(rst_up_func_n),
		.pring_in_if_pring_in_if_pring_in_if_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(pring_out_to_dn_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(nring_in_from_dn_nring_in_if_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(ddr11_tniu_noc_side_async_fifo_porting_async_fifo_pld_sync),
		.async_fifo_rptr_async(ddr11_tniu_noc_side_async_fifo_porting_async_fifo_rptr_async),
		.async_fifo_rptr_sync(ddr11_tniu_noc_side_async_fifo_porting_async_fifo_rptr_sync),
		.async_fifo_wptr_async(ddr11_tniu_noc_side_async_fifo_porting_async_fifo_wptr_async),
		.timeout_val_timeout_val(ddr11_tniu_noc_side_timeout_val_porting_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(ddr11_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(ddr11_tniu_noc_side_lp_async_porting_lp_async_s_async_master_hub_tx_req));

endmodule
//[UHDL]Content End [md5:be06a0d13d8188d195fda518a12fef78]


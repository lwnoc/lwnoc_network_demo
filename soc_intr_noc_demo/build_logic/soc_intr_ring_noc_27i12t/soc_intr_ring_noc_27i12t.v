//[UHDL]Content Start [md5:3293c391f5a75137458fd9aa7b2757d9]
module soc_intr_ring_noc_27i12t (
	input           clk_noc_a                                                                                                                    ,
	input           rst_noc_a_n                                                                                                                  ,
	input           clk_noc_b                                                                                                                    ,
	input           rst_noc_b_n                                                                                                                  ,
	input           cpu_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           cpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] cpu_ss_iniu_cpu_ss_iniu_sys_v_interrupt_porting_cpu_ss_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    cpu_ss_iniu_cpu_ss_iniu_sys_iniu_src_id_porting_cpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_addr                                                   ,
	input           cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_rdata                                                  ,
	output          cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_ready                                                  ,
	input           cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_sel                                                    ,
	output          cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_wdata                                                  ,
	input           cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    cpu_ss_iniu_cpu_ss_iniu_sys_timeout_val_porting_cpu_ss_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   cpu_ss_iniu_cpu_ss_iniu_sys_lp_hub_porting_cpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   cpu_ss_iniu_cpu_ss_iniu_sys_lp_hub_porting_cpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           cpu_ss_tniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           cpu_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [9:0]    cpu_ss_tniu_cpu_ss_tniu_top_timeout_val_porting_cpu_ss_tniu_top_timeout_val_porting_timeout_val                              ,
	input  [12:0]   cpu_ss_tniu_cpu_ss_tniu_top_lp_hub_porting_cpu_ss_tniu_top_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   cpu_ss_tniu_cpu_ss_tniu_top_lp_hub_porting_cpu_ss_tniu_top_lp_hub_porting_lp_hub_tx_req                                      ,
	input  [7:0]    cpu_ss_tniu_cpu_ss_tniu_sys_tniu_tgt_id_porting_cpu_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                              ,
	output [4095:0] cpu_ss_tniu_cpu_ss_tniu_sys_v_interrupt_porting_cpu_ss_tniu_sys_v_interrupt_porting_v_interrupt                              ,
	output [127:0]  cpu_ss_tniu_cpu_ss_tniu_sys_v_merge_interrupt_porting_cpu_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt            ,
	input  [31:0]   cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_addr                                                   ,
	input           cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_rdata                                                  ,
	output          cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_ready                                                  ,
	input           cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_sel                                                    ,
	output          cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_wdata                                                  ,
	input           cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    cpu_ss_tniu_cpu_ss_tniu_sys_timeout_val_porting_cpu_ss_tniu_sys_timeout_val_porting_timeout_val                              ,
	input           audio_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           audio_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [4095:0] audio_ss_iniu_audio_ss_iniu_sys_v_interrupt_porting_audio_ss_iniu_sys_v_interrupt_porting_v_interrupt                        ,
	input  [7:0]    audio_ss_iniu_audio_ss_iniu_sys_iniu_src_id_porting_audio_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                        ,
	input  [31:0]   audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_addr                                             ,
	input           audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_rdata                                            ,
	output          audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_ready                                            ,
	input           audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_sel                                              ,
	output          audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_wdata                                            ,
	input           audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    audio_ss_iniu_audio_ss_iniu_sys_timeout_val_porting_audio_ss_iniu_sys_timeout_val_porting_timeout_val                        ,
	input  [12:0]   audio_ss_iniu_audio_ss_iniu_sys_lp_hub_porting_audio_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   audio_ss_iniu_audio_ss_iniu_sys_lp_hub_porting_audio_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                ,
	input           peri_ss_tniu_clk_sys_porting_clk_sys_clk                                                                                     ,
	input           peri_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                               ,
	input  [9:0]    peri_ss_tniu_peri_ss_tniu_top_timeout_val_porting_peri_ss_tniu_top_timeout_val_porting_timeout_val                           ,
	input  [12:0]   peri_ss_tniu_peri_ss_tniu_top_lp_hub_porting_peri_ss_tniu_top_lp_hub_porting_lp_hub_rx_req                                   ,
	output [12:0]   peri_ss_tniu_peri_ss_tniu_top_lp_hub_porting_peri_ss_tniu_top_lp_hub_porting_lp_hub_tx_req                                   ,
	input  [7:0]    peri_ss_tniu_peri_ss_tniu_sys_tniu_tgt_id_porting_peri_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                           ,
	output [4095:0] peri_ss_tniu_peri_ss_tniu_sys_v_interrupt_porting_peri_ss_tniu_sys_v_interrupt_porting_v_interrupt                           ,
	output [127:0]  peri_ss_tniu_peri_ss_tniu_sys_v_merge_interrupt_porting_peri_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt         ,
	input  [31:0]   peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_addr                                                ,
	input           peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_enable                                              ,
	output [31:0]   peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_rdata                                               ,
	output          peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_ready                                               ,
	input           peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_sel                                                 ,
	output          peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_slverr                                              ,
	input  [31:0]   peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_wdata                                               ,
	input           peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_write                                               ,
	input  [9:0]    peri_ss_tniu_peri_ss_tniu_sys_timeout_val_porting_peri_ss_tniu_sys_timeout_val_porting_timeout_val                           ,
	input           gpu_ss1_iniu_clk_sys_porting_clk_sys_clk                                                                                     ,
	input           gpu_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                               ,
	input  [4095:0] gpu_ss1_iniu_gpu_ss1_iniu_sys_v_interrupt_porting_gpu_ss1_iniu_sys_v_interrupt_porting_v_interrupt                           ,
	input  [7:0]    gpu_ss1_iniu_gpu_ss1_iniu_sys_iniu_src_id_porting_gpu_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id                           ,
	input  [31:0]   gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_addr                                                ,
	input           gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_enable                                              ,
	output [31:0]   gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_rdata                                               ,
	output          gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_ready                                               ,
	input           gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_sel                                                 ,
	output          gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_slverr                                              ,
	input  [31:0]   gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_wdata                                               ,
	input           gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_write                                               ,
	input  [9:0]    gpu_ss1_iniu_gpu_ss1_iniu_sys_timeout_val_porting_gpu_ss1_iniu_sys_timeout_val_porting_timeout_val                           ,
	input  [12:0]   gpu_ss1_iniu_gpu_ss1_iniu_sys_lp_hub_porting_gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req                                   ,
	output [12:0]   gpu_ss1_iniu_gpu_ss1_iniu_sys_lp_hub_porting_gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req                                   ,
	input           gpu_ss0_tniu_clk_sys_porting_clk_sys_clk                                                                                     ,
	input           gpu_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                               ,
	input  [9:0]    gpu_ss0_tniu_gpu_ss0_tniu_top_timeout_val_porting_gpu_ss0_tniu_top_timeout_val_porting_timeout_val                           ,
	input  [12:0]   gpu_ss0_tniu_gpu_ss0_tniu_top_lp_hub_porting_gpu_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req                                   ,
	output [12:0]   gpu_ss0_tniu_gpu_ss0_tniu_top_lp_hub_porting_gpu_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req                                   ,
	input  [7:0]    gpu_ss0_tniu_gpu_ss0_tniu_sys_tniu_tgt_id_porting_gpu_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                           ,
	output [4095:0] gpu_ss0_tniu_gpu_ss0_tniu_sys_v_interrupt_porting_gpu_ss0_tniu_sys_v_interrupt_porting_v_interrupt                           ,
	output [127:0]  gpu_ss0_tniu_gpu_ss0_tniu_sys_v_merge_interrupt_porting_gpu_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt         ,
	input  [31:0]   gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_addr                                                ,
	input           gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_enable                                              ,
	output [31:0]   gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_rdata                                               ,
	output          gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_ready                                               ,
	input           gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_sel                                                 ,
	output          gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_slverr                                              ,
	input  [31:0]   gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_wdata                                               ,
	input           gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_write                                               ,
	input  [9:0]    gpu_ss0_tniu_gpu_ss0_tniu_sys_timeout_val_porting_gpu_ss0_tniu_sys_timeout_val_porting_timeout_val                           ,
	input           display_ss_tniu_clk_sys_porting_clk_sys_clk                                                                                  ,
	input           display_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                            ,
	input  [9:0]    display_ss_tniu_display_ss_tniu_top_timeout_val_porting_display_ss_tniu_top_timeout_val_porting_timeout_val                  ,
	input  [12:0]   display_ss_tniu_display_ss_tniu_top_lp_hub_porting_display_ss_tniu_top_lp_hub_porting_lp_hub_rx_req                          ,
	output [12:0]   display_ss_tniu_display_ss_tniu_top_lp_hub_porting_display_ss_tniu_top_lp_hub_porting_lp_hub_tx_req                          ,
	input  [7:0]    display_ss_tniu_display_ss_tniu_sys_tniu_tgt_id_porting_display_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                  ,
	output [4095:0] display_ss_tniu_display_ss_tniu_sys_v_interrupt_porting_display_ss_tniu_sys_v_interrupt_porting_v_interrupt                  ,
	output [127:0]  display_ss_tniu_display_ss_tniu_sys_v_merge_interrupt_porting_display_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt,
	input  [31:0]   display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_addr                                       ,
	input           display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_enable                                     ,
	output [31:0]   display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_rdata                                      ,
	output          display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_ready                                      ,
	input           display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_sel                                        ,
	output          display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_slverr                                     ,
	input  [31:0]   display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_wdata                                      ,
	input           display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_write                                      ,
	input  [9:0]    display_ss_tniu_display_ss_tniu_sys_timeout_val_porting_display_ss_tniu_sys_timeout_val_porting_timeout_val                  ,
	input           dp_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                       ,
	input           dp_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                 ,
	input  [4095:0] dp_ss_iniu_dp_ss_iniu_sys_v_interrupt_porting_dp_ss_iniu_sys_v_interrupt_porting_v_interrupt                                 ,
	input  [7:0]    dp_ss_iniu_dp_ss_iniu_sys_iniu_src_id_porting_dp_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                                 ,
	input  [31:0]   dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_addr                                                      ,
	input           dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_enable                                                    ,
	output [31:0]   dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_rdata                                                     ,
	output          dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_ready                                                     ,
	input           dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_sel                                                       ,
	output          dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_slverr                                                    ,
	input  [31:0]   dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_wdata                                                     ,
	input           dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_write                                                     ,
	input  [9:0]    dp_ss_iniu_dp_ss_iniu_sys_timeout_val_porting_dp_ss_iniu_sys_timeout_val_porting_timeout_val                                 ,
	input  [12:0]   dp_ss_iniu_dp_ss_iniu_sys_lp_hub_porting_dp_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                         ,
	output [12:0]   dp_ss_iniu_dp_ss_iniu_sys_lp_hub_porting_dp_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                         ,
	input           ddr6_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr6_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr6_iniu_ddr6_iniu_sys_v_interrupt_porting_ddr6_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr6_iniu_ddr6_iniu_sys_iniu_src_id_porting_ddr6_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr6_iniu_ddr6_iniu_sys_timeout_val_porting_ddr6_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr6_iniu_ddr6_iniu_sys_lp_hub_porting_ddr6_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr6_iniu_ddr6_iniu_sys_lp_hub_porting_ddr6_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr7_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr7_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr7_iniu_ddr7_iniu_sys_v_interrupt_porting_ddr7_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr7_iniu_ddr7_iniu_sys_iniu_src_id_porting_ddr7_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr7_iniu_ddr7_iniu_sys_timeout_val_porting_ddr7_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr7_iniu_ddr7_iniu_sys_lp_hub_porting_ddr7_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr7_iniu_ddr7_iniu_sys_lp_hub_porting_ddr7_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr8_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr8_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr8_iniu_ddr8_iniu_sys_v_interrupt_porting_ddr8_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr8_iniu_ddr8_iniu_sys_iniu_src_id_porting_ddr8_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr8_iniu_ddr8_iniu_sys_timeout_val_porting_ddr8_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr8_iniu_ddr8_iniu_sys_lp_hub_porting_ddr8_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr8_iniu_ddr8_iniu_sys_lp_hub_porting_ddr8_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr9_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr9_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr9_iniu_ddr9_iniu_sys_v_interrupt_porting_ddr9_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr9_iniu_ddr9_iniu_sys_iniu_src_id_porting_ddr9_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr9_iniu_ddr9_iniu_sys_timeout_val_porting_ddr9_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr9_iniu_ddr9_iniu_sys_lp_hub_porting_ddr9_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr9_iniu_ddr9_iniu_sys_lp_hub_porting_ddr9_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr10_iniu_clk_sys_porting_clk_sys_clk                                                                                       ,
	input           ddr10_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                 ,
	input  [4095:0] ddr10_iniu_ddr10_iniu_sys_v_interrupt_porting_ddr10_iniu_sys_v_interrupt_porting_v_interrupt                                 ,
	input  [7:0]    ddr10_iniu_ddr10_iniu_sys_iniu_src_id_porting_ddr10_iniu_sys_iniu_src_id_porting_iniu_src_id                                 ,
	input  [31:0]   ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_addr                                                      ,
	input           ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_enable                                                    ,
	output [31:0]   ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_rdata                                                     ,
	output          ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_ready                                                     ,
	input           ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_sel                                                       ,
	output          ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_slverr                                                    ,
	input  [31:0]   ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_wdata                                                     ,
	input           ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_write                                                     ,
	input  [9:0]    ddr10_iniu_ddr10_iniu_sys_timeout_val_porting_ddr10_iniu_sys_timeout_val_porting_timeout_val                                 ,
	input  [12:0]   ddr10_iniu_ddr10_iniu_sys_lp_hub_porting_ddr10_iniu_sys_lp_hub_porting_lp_hub_rx_req                                         ,
	output [12:0]   ddr10_iniu_ddr10_iniu_sys_lp_hub_porting_ddr10_iniu_sys_lp_hub_porting_lp_hub_tx_req                                         ,
	input           ddr11_tniu_clk_sys_porting_clk_sys_clk                                                                                       ,
	input           ddr11_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                 ,
	input  [9:0]    ddr11_tniu_ddr11_tniu_top_timeout_val_porting_ddr11_tniu_top_timeout_val_porting_timeout_val                                 ,
	input  [12:0]   ddr11_tniu_ddr11_tniu_top_lp_hub_porting_ddr11_tniu_top_lp_hub_porting_lp_hub_rx_req                                         ,
	output [12:0]   ddr11_tniu_ddr11_tniu_top_lp_hub_porting_ddr11_tniu_top_lp_hub_porting_lp_hub_tx_req                                         ,
	input  [7:0]    ddr11_tniu_ddr11_tniu_sys_tniu_tgt_id_porting_ddr11_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                                 ,
	output [4095:0] ddr11_tniu_ddr11_tniu_sys_v_interrupt_porting_ddr11_tniu_sys_v_interrupt_porting_v_interrupt                                 ,
	output [127:0]  ddr11_tniu_ddr11_tniu_sys_v_merge_interrupt_porting_ddr11_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt               ,
	input  [31:0]   ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_addr                                                      ,
	input           ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_enable                                                    ,
	output [31:0]   ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_rdata                                                     ,
	output          ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_ready                                                     ,
	input           ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_sel                                                       ,
	output          ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_slverr                                                    ,
	input  [31:0]   ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_wdata                                                     ,
	input           ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_write                                                     ,
	input  [9:0]    ddr11_tniu_ddr11_tniu_sys_timeout_val_porting_ddr11_tniu_sys_timeout_val_porting_timeout_val                                 ,
	input           mipi_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                     ,
	input           mipi_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                               ,
	input  [4095:0] mipi_ss_iniu_mipi_ss_iniu_sys_v_interrupt_porting_mipi_ss_iniu_sys_v_interrupt_porting_v_interrupt                           ,
	input  [7:0]    mipi_ss_iniu_mipi_ss_iniu_sys_iniu_src_id_porting_mipi_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                           ,
	input  [31:0]   mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_addr                                                ,
	input           mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_enable                                              ,
	output [31:0]   mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_rdata                                               ,
	output          mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_ready                                               ,
	input           mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_sel                                                 ,
	output          mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_slverr                                              ,
	input  [31:0]   mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_wdata                                               ,
	input           mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_write                                               ,
	input  [9:0]    mipi_ss_iniu_mipi_ss_iniu_sys_timeout_val_porting_mipi_ss_iniu_sys_timeout_val_porting_timeout_val                           ,
	input  [12:0]   mipi_ss_iniu_mipi_ss_iniu_sys_lp_hub_porting_mipi_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                   ,
	output [12:0]   mipi_ss_iniu_mipi_ss_iniu_sys_lp_hub_porting_mipi_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                   ,
	input           ufs_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           ufs_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] ufs_ss_iniu_ufs_ss_iniu_sys_v_interrupt_porting_ufs_ss_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    ufs_ss_iniu_ufs_ss_iniu_sys_iniu_src_id_porting_ufs_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_addr                                                   ,
	input           ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_rdata                                                  ,
	output          ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_ready                                                  ,
	input           ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_sel                                                    ,
	output          ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_wdata                                                  ,
	input           ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    ufs_ss_iniu_ufs_ss_iniu_sys_timeout_val_porting_ufs_ss_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   ufs_ss_iniu_ufs_ss_iniu_sys_lp_hub_porting_ufs_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   ufs_ss_iniu_ufs_ss_iniu_sys_lp_hub_porting_ufs_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           camera_ss_tniu_clk_sys_porting_clk_sys_clk                                                                                   ,
	input           camera_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                             ,
	input  [9:0]    camera_ss_tniu_camera_ss_tniu_top_timeout_val_porting_camera_ss_tniu_top_timeout_val_porting_timeout_val                     ,
	input  [12:0]   camera_ss_tniu_camera_ss_tniu_top_lp_hub_porting_camera_ss_tniu_top_lp_hub_porting_lp_hub_rx_req                             ,
	output [12:0]   camera_ss_tniu_camera_ss_tniu_top_lp_hub_porting_camera_ss_tniu_top_lp_hub_porting_lp_hub_tx_req                             ,
	input  [7:0]    camera_ss_tniu_camera_ss_tniu_sys_tniu_tgt_id_porting_camera_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                     ,
	output [4095:0] camera_ss_tniu_camera_ss_tniu_sys_v_interrupt_porting_camera_ss_tniu_sys_v_interrupt_porting_v_interrupt                     ,
	output [127:0]  camera_ss_tniu_camera_ss_tniu_sys_v_merge_interrupt_porting_camera_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt   ,
	input  [31:0]   camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_addr                                          ,
	input           camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_enable                                        ,
	output [31:0]   camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_rdata                                         ,
	output          camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_ready                                         ,
	input           camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_sel                                           ,
	output          camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_slverr                                        ,
	input  [31:0]   camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_wdata                                         ,
	input           camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_write                                         ,
	input  [9:0]    camera_ss_tniu_camera_ss_tniu_sys_timeout_val_porting_camera_ss_tniu_sys_timeout_val_porting_timeout_val                     ,
	input           camera_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                   ,
	input           camera_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                             ,
	input  [4095:0] camera_ss_iniu_camera_ss_iniu_sys_v_interrupt_porting_camera_ss_iniu_sys_v_interrupt_porting_v_interrupt                     ,
	input  [7:0]    camera_ss_iniu_camera_ss_iniu_sys_iniu_src_id_porting_camera_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                     ,
	input  [31:0]   camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_addr                                          ,
	input           camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_enable                                        ,
	output [31:0]   camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_rdata                                         ,
	output          camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_ready                                         ,
	input           camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_sel                                           ,
	output          camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_slverr                                        ,
	input  [31:0]   camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_wdata                                         ,
	input           camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_write                                         ,
	input  [9:0]    camera_ss_iniu_camera_ss_iniu_sys_timeout_val_porting_camera_ss_iniu_sys_timeout_val_porting_timeout_val                     ,
	input  [12:0]   camera_ss_iniu_camera_ss_iniu_sys_lp_hub_porting_camera_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                             ,
	output [12:0]   camera_ss_iniu_camera_ss_iniu_sys_lp_hub_porting_camera_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                             ,
	input           vpu_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           vpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] vpu_ss_iniu_vpu_ss_iniu_sys_v_interrupt_porting_vpu_ss_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    vpu_ss_iniu_vpu_ss_iniu_sys_iniu_src_id_porting_vpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_addr                                                   ,
	input           vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_rdata                                                  ,
	output          vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_ready                                                  ,
	input           vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_sel                                                    ,
	output          vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_wdata                                                  ,
	input           vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    vpu_ss_iniu_vpu_ss_iniu_sys_timeout_val_porting_vpu_ss_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   vpu_ss_iniu_vpu_ss_iniu_sys_lp_hub_porting_vpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   vpu_ss_iniu_vpu_ss_iniu_sys_lp_hub_porting_vpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           pcie_eth_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                 ,
	input           pcie_eth_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                           ,
	input  [4095:0] pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_v_interrupt_porting_pcie_eth_ss_iniu_sys_v_interrupt_porting_v_interrupt               ,
	input  [7:0]    pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_iniu_src_id_porting_pcie_eth_ss_iniu_sys_iniu_src_id_porting_iniu_src_id               ,
	input  [31:0]   pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_addr                                    ,
	input           pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_enable                                  ,
	output [31:0]   pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_rdata                                   ,
	output          pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_ready                                   ,
	input           pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_sel                                     ,
	output          pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_slverr                                  ,
	input  [31:0]   pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_wdata                                   ,
	input           pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_write                                   ,
	input  [9:0]    pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_timeout_val_porting_pcie_eth_ss_iniu_sys_timeout_val_porting_timeout_val               ,
	input  [12:0]   pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_lp_hub_porting_pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                       ,
	output [12:0]   pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_lp_hub_porting_pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                       ,
	input           debug_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           debug_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [4095:0] debug_ss_iniu_debug_ss_iniu_sys_v_interrupt_porting_debug_ss_iniu_sys_v_interrupt_porting_v_interrupt                        ,
	input  [7:0]    debug_ss_iniu_debug_ss_iniu_sys_iniu_src_id_porting_debug_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                        ,
	input  [31:0]   debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_addr                                             ,
	input           debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_rdata                                            ,
	output          debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_ready                                            ,
	input           debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_sel                                              ,
	output          debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_wdata                                            ,
	input           debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    debug_ss_iniu_debug_ss_iniu_sys_timeout_val_porting_debug_ss_iniu_sys_timeout_val_porting_timeout_val                        ,
	input  [12:0]   debug_ss_iniu_debug_ss_iniu_sys_lp_hub_porting_debug_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   debug_ss_iniu_debug_ss_iniu_sys_lp_hub_porting_debug_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                ,
	input           aon_ss_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           aon_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] aon_ss_iniu_aon_ss_iniu_sys_v_interrupt_porting_aon_ss_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    aon_ss_iniu_aon_ss_iniu_sys_iniu_src_id_porting_aon_ss_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_addr                                                   ,
	input           aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_rdata                                                  ,
	output          aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_ready                                                  ,
	input           aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_sel                                                    ,
	output          aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_wdata                                                  ,
	input           aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    aon_ss_iniu_aon_ss_iniu_sys_timeout_val_porting_aon_ss_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   aon_ss_iniu_aon_ss_iniu_sys_lp_hub_porting_aon_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   aon_ss_iniu_aon_ss_iniu_sys_lp_hub_porting_aon_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           aon_ss_tniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           aon_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [9:0]    aon_ss_tniu_aon_ss_tniu_top_timeout_val_porting_aon_ss_tniu_top_timeout_val_porting_timeout_val                              ,
	input  [12:0]   aon_ss_tniu_aon_ss_tniu_top_lp_hub_porting_aon_ss_tniu_top_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   aon_ss_tniu_aon_ss_tniu_top_lp_hub_porting_aon_ss_tniu_top_lp_hub_porting_lp_hub_tx_req                                      ,
	input  [7:0]    aon_ss_tniu_aon_ss_tniu_sys_tniu_tgt_id_porting_aon_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                              ,
	output [4095:0] aon_ss_tniu_aon_ss_tniu_sys_v_interrupt_porting_aon_ss_tniu_sys_v_interrupt_porting_v_interrupt                              ,
	output [127:0]  aon_ss_tniu_aon_ss_tniu_sys_v_merge_interrupt_porting_aon_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt            ,
	input  [31:0]   aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_addr                                                   ,
	input           aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_rdata                                                  ,
	output          aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_ready                                                  ,
	input           aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_sel                                                    ,
	output          aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_wdata                                                  ,
	input           aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    aon_ss_tniu_aon_ss_tniu_sys_timeout_val_porting_aon_ss_tniu_sys_timeout_val_porting_timeout_val                              ,
	input           ucie_ss1_iniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           ucie_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [4095:0] ucie_ss1_iniu_ucie_ss1_iniu_sys_v_interrupt_porting_ucie_ss1_iniu_sys_v_interrupt_porting_v_interrupt                        ,
	input  [7:0]    ucie_ss1_iniu_ucie_ss1_iniu_sys_iniu_src_id_porting_ucie_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id                        ,
	input  [31:0]   ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_addr                                             ,
	input           ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_rdata                                            ,
	output          ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_ready                                            ,
	input           ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_sel                                              ,
	output          ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_wdata                                            ,
	input           ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    ucie_ss1_iniu_ucie_ss1_iniu_sys_timeout_val_porting_ucie_ss1_iniu_sys_timeout_val_porting_timeout_val                        ,
	input  [12:0]   ucie_ss1_iniu_ucie_ss1_iniu_sys_lp_hub_porting_ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   ucie_ss1_iniu_ucie_ss1_iniu_sys_lp_hub_porting_ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req                                ,
	input           ucie_ss1_tniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           ucie_ss1_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [9:0]    ucie_ss1_tniu_ucie_ss1_tniu_top_timeout_val_porting_ucie_ss1_tniu_top_timeout_val_porting_timeout_val                        ,
	input  [12:0]   ucie_ss1_tniu_ucie_ss1_tniu_top_lp_hub_porting_ucie_ss1_tniu_top_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   ucie_ss1_tniu_ucie_ss1_tniu_top_lp_hub_porting_ucie_ss1_tniu_top_lp_hub_porting_lp_hub_tx_req                                ,
	input  [7:0]    ucie_ss1_tniu_ucie_ss1_tniu_sys_tniu_tgt_id_porting_ucie_ss1_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                        ,
	output [4095:0] ucie_ss1_tniu_ucie_ss1_tniu_sys_v_interrupt_porting_ucie_ss1_tniu_sys_v_interrupt_porting_v_interrupt                        ,
	output [127:0]  ucie_ss1_tniu_ucie_ss1_tniu_sys_v_merge_interrupt_porting_ucie_ss1_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt      ,
	input  [31:0]   ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_addr                                             ,
	input           ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_rdata                                            ,
	output          ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_ready                                            ,
	input           ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_sel                                              ,
	output          ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_wdata                                            ,
	input           ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    ucie_ss1_tniu_ucie_ss1_tniu_sys_timeout_val_porting_ucie_ss1_tniu_sys_timeout_val_porting_timeout_val                        ,
	input           dspss5_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss5_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] dspss5_iniu_dspss5_iniu_sys_v_interrupt_porting_dspss5_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    dspss5_iniu_dspss5_iniu_sys_iniu_src_id_porting_dspss5_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_addr                                                   ,
	input           dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_ready                                                  ,
	input           dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_sel                                                    ,
	output          dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss5_iniu_dspss5_iniu_sys_timeout_val_porting_dspss5_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss5_iniu_dspss5_iniu_sys_lp_hub_porting_dspss5_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss5_iniu_dspss5_iniu_sys_lp_hub_porting_dspss5_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           dspss4_tniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss4_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [9:0]    dspss4_tniu_dspss4_tniu_top_timeout_val_porting_dspss4_tniu_top_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss4_tniu_dspss4_tniu_top_lp_hub_porting_dspss4_tniu_top_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss4_tniu_dspss4_tniu_top_lp_hub_porting_dspss4_tniu_top_lp_hub_porting_lp_hub_tx_req                                      ,
	input  [7:0]    dspss4_tniu_dspss4_tniu_sys_tniu_tgt_id_porting_dspss4_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                              ,
	output [4095:0] dspss4_tniu_dspss4_tniu_sys_v_interrupt_porting_dspss4_tniu_sys_v_interrupt_porting_v_interrupt                              ,
	output [127:0]  dspss4_tniu_dspss4_tniu_sys_v_merge_interrupt_porting_dspss4_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt            ,
	input  [31:0]   dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_addr                                                   ,
	input           dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_ready                                                  ,
	input           dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_sel                                                    ,
	output          dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss4_tniu_dspss4_tniu_sys_timeout_val_porting_dspss4_tniu_sys_timeout_val_porting_timeout_val                              ,
	input           dspss3_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss3_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] dspss3_iniu_dspss3_iniu_sys_v_interrupt_porting_dspss3_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    dspss3_iniu_dspss3_iniu_sys_iniu_src_id_porting_dspss3_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_addr                                                   ,
	input           dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_ready                                                  ,
	input           dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_sel                                                    ,
	output          dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss3_iniu_dspss3_iniu_sys_timeout_val_porting_dspss3_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss3_iniu_dspss3_iniu_sys_lp_hub_porting_dspss3_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss3_iniu_dspss3_iniu_sys_lp_hub_porting_dspss3_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           dspss2_tniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss2_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [9:0]    dspss2_tniu_dspss2_tniu_top_timeout_val_porting_dspss2_tniu_top_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss2_tniu_dspss2_tniu_top_lp_hub_porting_dspss2_tniu_top_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss2_tniu_dspss2_tniu_top_lp_hub_porting_dspss2_tniu_top_lp_hub_porting_lp_hub_tx_req                                      ,
	input  [7:0]    dspss2_tniu_dspss2_tniu_sys_tniu_tgt_id_porting_dspss2_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                              ,
	output [4095:0] dspss2_tniu_dspss2_tniu_sys_v_interrupt_porting_dspss2_tniu_sys_v_interrupt_porting_v_interrupt                              ,
	output [127:0]  dspss2_tniu_dspss2_tniu_sys_v_merge_interrupt_porting_dspss2_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt            ,
	input  [31:0]   dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_addr                                                   ,
	input           dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_ready                                                  ,
	input           dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_sel                                                    ,
	output          dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss2_tniu_dspss2_tniu_sys_timeout_val_porting_dspss2_tniu_sys_timeout_val_porting_timeout_val                              ,
	input           dspss1_iniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [4095:0] dspss1_iniu_dspss1_iniu_sys_v_interrupt_porting_dspss1_iniu_sys_v_interrupt_porting_v_interrupt                              ,
	input  [7:0]    dspss1_iniu_dspss1_iniu_sys_iniu_src_id_porting_dspss1_iniu_sys_iniu_src_id_porting_iniu_src_id                              ,
	input  [31:0]   dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_addr                                                   ,
	input           dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_ready                                                  ,
	input           dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_sel                                                    ,
	output          dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss1_iniu_dspss1_iniu_sys_timeout_val_porting_dspss1_iniu_sys_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss1_iniu_dspss1_iniu_sys_lp_hub_porting_dspss1_iniu_sys_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss1_iniu_dspss1_iniu_sys_lp_hub_porting_dspss1_iniu_sys_lp_hub_porting_lp_hub_tx_req                                      ,
	input           dspss0_tniu_clk_sys_porting_clk_sys_clk                                                                                      ,
	input           dspss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                ,
	input  [9:0]    dspss0_tniu_dspss0_tniu_top_timeout_val_porting_dspss0_tniu_top_timeout_val_porting_timeout_val                              ,
	input  [12:0]   dspss0_tniu_dspss0_tniu_top_lp_hub_porting_dspss0_tniu_top_lp_hub_porting_lp_hub_rx_req                                      ,
	output [12:0]   dspss0_tniu_dspss0_tniu_top_lp_hub_porting_dspss0_tniu_top_lp_hub_porting_lp_hub_tx_req                                      ,
	input  [7:0]    dspss0_tniu_dspss0_tniu_sys_tniu_tgt_id_porting_dspss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                              ,
	output [4095:0] dspss0_tniu_dspss0_tniu_sys_v_interrupt_porting_dspss0_tniu_sys_v_interrupt_porting_v_interrupt                              ,
	output [127:0]  dspss0_tniu_dspss0_tniu_sys_v_merge_interrupt_porting_dspss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt            ,
	input  [31:0]   dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_addr                                                   ,
	input           dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_enable                                                 ,
	output [31:0]   dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_rdata                                                  ,
	output          dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_ready                                                  ,
	input           dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_sel                                                    ,
	output          dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_slverr                                                 ,
	input  [31:0]   dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_wdata                                                  ,
	input           dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_write                                                  ,
	input  [9:0]    dspss0_tniu_dspss0_tniu_sys_timeout_val_porting_dspss0_tniu_sys_timeout_val_porting_timeout_val                              ,
	input           ddr0_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr0_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr0_iniu_ddr0_iniu_sys_v_interrupt_porting_ddr0_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr0_iniu_ddr0_iniu_sys_iniu_src_id_porting_ddr0_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr0_iniu_ddr0_iniu_sys_timeout_val_porting_ddr0_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr0_iniu_ddr0_iniu_sys_lp_hub_porting_ddr0_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr0_iniu_ddr0_iniu_sys_lp_hub_porting_ddr0_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr1_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr1_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr1_iniu_ddr1_iniu_sys_v_interrupt_porting_ddr1_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr1_iniu_ddr1_iniu_sys_iniu_src_id_porting_ddr1_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr1_iniu_ddr1_iniu_sys_timeout_val_porting_ddr1_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr1_iniu_ddr1_iniu_sys_lp_hub_porting_ddr1_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr1_iniu_ddr1_iniu_sys_lp_hub_porting_ddr1_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr2_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr2_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr2_iniu_ddr2_iniu_sys_v_interrupt_porting_ddr2_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr2_iniu_ddr2_iniu_sys_iniu_src_id_porting_ddr2_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr2_iniu_ddr2_iniu_sys_timeout_val_porting_ddr2_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr2_iniu_ddr2_iniu_sys_lp_hub_porting_ddr2_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr2_iniu_ddr2_iniu_sys_lp_hub_porting_ddr2_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr3_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr3_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr3_iniu_ddr3_iniu_sys_v_interrupt_porting_ddr3_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr3_iniu_ddr3_iniu_sys_iniu_src_id_porting_ddr3_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr3_iniu_ddr3_iniu_sys_timeout_val_porting_ddr3_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr3_iniu_ddr3_iniu_sys_lp_hub_porting_ddr3_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr3_iniu_ddr3_iniu_sys_lp_hub_porting_ddr3_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr4_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr4_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr4_iniu_ddr4_iniu_sys_v_interrupt_porting_ddr4_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr4_iniu_ddr4_iniu_sys_iniu_src_id_porting_ddr4_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr4_iniu_ddr4_iniu_sys_timeout_val_porting_ddr4_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr4_iniu_ddr4_iniu_sys_lp_hub_porting_ddr4_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr4_iniu_ddr4_iniu_sys_lp_hub_porting_ddr4_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ddr5_iniu_clk_sys_porting_clk_sys_clk                                                                                        ,
	input           ddr5_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                                  ,
	input  [4095:0] ddr5_iniu_ddr5_iniu_sys_v_interrupt_porting_ddr5_iniu_sys_v_interrupt_porting_v_interrupt                                    ,
	input  [7:0]    ddr5_iniu_ddr5_iniu_sys_iniu_src_id_porting_ddr5_iniu_sys_iniu_src_id_porting_iniu_src_id                                    ,
	input  [31:0]   ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_addr                                                         ,
	input           ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_enable                                                       ,
	output [31:0]   ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_rdata                                                        ,
	output          ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_ready                                                        ,
	input           ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_sel                                                          ,
	output          ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_slverr                                                       ,
	input  [31:0]   ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_wdata                                                        ,
	input           ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_write                                                        ,
	input  [9:0]    ddr5_iniu_ddr5_iniu_sys_timeout_val_porting_ddr5_iniu_sys_timeout_val_porting_timeout_val                                    ,
	input  [12:0]   ddr5_iniu_ddr5_iniu_sys_lp_hub_porting_ddr5_iniu_sys_lp_hub_porting_lp_hub_rx_req                                            ,
	output [12:0]   ddr5_iniu_ddr5_iniu_sys_lp_hub_porting_ddr5_iniu_sys_lp_hub_porting_lp_hub_tx_req                                            ,
	input           ucie_ss0_iniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           ucie_ss0_iniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [4095:0] ucie_ss0_iniu_ucie_ss0_iniu_sys_v_interrupt_porting_ucie_ss0_iniu_sys_v_interrupt_porting_v_interrupt                        ,
	input  [7:0]    ucie_ss0_iniu_ucie_ss0_iniu_sys_iniu_src_id_porting_ucie_ss0_iniu_sys_iniu_src_id_porting_iniu_src_id                        ,
	input  [31:0]   ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_addr                                             ,
	input           ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_rdata                                            ,
	output          ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_ready                                            ,
	input           ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_sel                                              ,
	output          ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_wdata                                            ,
	input           ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    ucie_ss0_iniu_ucie_ss0_iniu_sys_timeout_val_porting_ucie_ss0_iniu_sys_timeout_val_porting_timeout_val                        ,
	input  [12:0]   ucie_ss0_iniu_ucie_ss0_iniu_sys_lp_hub_porting_ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   ucie_ss0_iniu_ucie_ss0_iniu_sys_lp_hub_porting_ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_tx_req                                ,
	input           ucie_ss0_tniu_clk_sys_porting_clk_sys_clk                                                                                    ,
	input           ucie_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n                                                                              ,
	input  [9:0]    ucie_ss0_tniu_ucie_ss0_tniu_top_timeout_val_porting_ucie_ss0_tniu_top_timeout_val_porting_timeout_val                        ,
	input  [12:0]   ucie_ss0_tniu_ucie_ss0_tniu_top_lp_hub_porting_ucie_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req                                ,
	output [12:0]   ucie_ss0_tniu_ucie_ss0_tniu_top_lp_hub_porting_ucie_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req                                ,
	input  [7:0]    ucie_ss0_tniu_ucie_ss0_tniu_sys_tniu_tgt_id_porting_ucie_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id                        ,
	output [4095:0] ucie_ss0_tniu_ucie_ss0_tniu_sys_v_interrupt_porting_ucie_ss0_tniu_sys_v_interrupt_porting_v_interrupt                        ,
	output [127:0]  ucie_ss0_tniu_ucie_ss0_tniu_sys_v_merge_interrupt_porting_ucie_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt      ,
	input  [31:0]   ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_addr                                             ,
	input           ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_enable                                           ,
	output [31:0]   ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_rdata                                            ,
	output          ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_ready                                            ,
	input           ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_sel                                              ,
	output          ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_slverr                                           ,
	input  [31:0]   ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_wdata                                            ,
	input           ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_write                                            ,
	input  [9:0]    ucie_ss0_tniu_ucie_ss0_tniu_sys_timeout_val_porting_ucie_ss0_tniu_sys_timeout_val_porting_timeout_val                        );

	//Wire define for this module.

	//Wire define for sub module.
	wire        ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready     ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_last        ;
	wire [39:0] peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload     ;
	wire [3:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos         ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid       ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid       ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid       ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_last        ;
	wire [39:0] audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload     ;
	wire [3:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos         ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid       ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid       ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid       ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready    ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready   ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last      ;
	wire [39:0] display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload   ;
	wire [3:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos       ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid     ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid     ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid     ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_last      ;
	wire [39:0] gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload   ;
	wire [3:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos       ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid     ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid     ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid     ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready     ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_last        ;
	wire [39:0] dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload     ;
	wire [3:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos         ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid       ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid       ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid       ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready  ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_last        ;
	wire [39:0] display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload     ;
	wire [3:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos         ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid       ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid       ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid       ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready           ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_last              ;
	wire [39:0] ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload           ;
	wire [3:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos               ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid             ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid             ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid             ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready    ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_last              ;
	wire [39:0] dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_payload           ;
	wire [3:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_qos               ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_srcid             ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_tgtid             ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_valid             ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready          ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready           ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_last              ;
	wire [39:0] ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_payload           ;
	wire [3:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_qos               ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_srcid             ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_tgtid             ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_valid             ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_last              ;
	wire [39:0] ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_payload           ;
	wire [3:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_qos               ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_srcid             ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_tgtid             ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_valid             ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready          ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_last             ;
	wire [39:0] ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_payload          ;
	wire [3:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_qos              ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_srcid            ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_tgtid            ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_valid            ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready          ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_last             ;
	wire [39:0] ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_payload          ;
	wire [3:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_qos              ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_srcid            ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_tgtid            ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_valid            ;
	wire        mipi_ss_iniu_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready         ;
	wire        ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready       ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_last          ;
	wire [39:0] ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload       ;
	wire [3:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos           ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid         ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid         ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid         ;
	wire        ddr11_tniu_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_last          ;
	wire [39:0] mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload       ;
	wire [3:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos           ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid         ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid         ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid         ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready     ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_last        ;
	wire [39:0] camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload     ;
	wire [3:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos         ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid       ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid       ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid       ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready      ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_last        ;
	wire [39:0] ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload     ;
	wire [3:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos         ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid       ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid       ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid       ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready  ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_last     ;
	wire [39:0] camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload  ;
	wire [3:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos      ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid    ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid    ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid    ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready    ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_last     ;
	wire [39:0] camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload  ;
	wire [3:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos      ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid    ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid    ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid    ;
	wire        vpu_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready     ;
	wire        vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_last        ;
	wire [39:0] vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload     ;
	wire [3:0]  vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos         ;
	wire [7:0]  vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid       ;
	wire [7:0]  vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid       ;
	wire        vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid       ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready ;
	wire        camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last        ;
	wire [39:0] camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload     ;
	wire [3:0]  camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos         ;
	wire [7:0]  camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid       ;
	wire [7:0]  camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid       ;
	wire        camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid       ;
	wire        pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready   ;
	wire        pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last      ;
	wire [39:0] pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload   ;
	wire [3:0]  pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos       ;
	wire [7:0]  pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid     ;
	wire [7:0]  pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid     ;
	wire        pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid     ;
	wire        camera_ss_iniu_TO_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready    ;
	wire        vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_last      ;
	wire [39:0] vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload   ;
	wire [3:0]  vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos       ;
	wire [7:0]  vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid     ;
	wire [7:0]  vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid     ;
	wire        vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid     ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready  ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready    ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last       ;
	wire [39:0] ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload    ;
	wire [3:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos        ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid      ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid      ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid      ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_last       ;
	wire [39:0] ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_payload    ;
	wire [3:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_qos        ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_srcid      ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_tgtid      ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_valid      ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready   ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_last         ;
	wire [39:0] ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_payload      ;
	wire [3:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_qos          ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_srcid        ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid        ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_valid        ;
	wire        dspss4_tniu_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready     ;
	wire        dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        dspss5_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready          ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_last             ;
	wire [39:0] ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_payload          ;
	wire [3:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_qos              ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid            ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid            ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_valid            ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_last             ;
	wire [39:0] dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_payload          ;
	wire [3:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_qos              ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_srcid            ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid            ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_valid            ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready         ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready            ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_last               ;
	wire [39:0] ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_payload            ;
	wire [3:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_qos                ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_srcid              ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_tgtid              ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_valid              ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_last               ;
	wire [39:0] ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_payload            ;
	wire [3:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_qos                ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_srcid              ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid              ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_valid              ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready        ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_last           ;
	wire [39:0] ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_payload        ;
	wire [3:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_qos            ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_srcid          ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid          ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_valid          ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready           ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_last           ;
	wire [39:0] ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_payload        ;
	wire [3:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_qos            ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_srcid          ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid          ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_valid          ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready    ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_last       ;
	wire [39:0] ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_payload    ;
	wire [3:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_qos        ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_srcid      ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid      ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_valid      ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready       ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last       ;
	wire [39:0] ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload    ;
	wire [3:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos        ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid      ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid      ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid      ;
	wire        cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready      ;
	wire        cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last         ;
	wire [39:0] cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload      ;
	wire [3:0]  cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos          ;
	wire [7:0]  cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid        ;
	wire [7:0]  cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid        ;
	wire        cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid        ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready   ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_iniu cpu_ss_iniu (
		.clk_sys_clk(cpu_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(cpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.cpu_ss_iniu_sys_v_interrupt_porting_v_interrupt(cpu_ss_iniu_cpu_ss_iniu_sys_v_interrupt_porting_cpu_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.cpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(cpu_ss_iniu_cpu_ss_iniu_sys_iniu_src_id_porting_cpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.cpu_ss_iniu_sys_apb_porting_p_addr(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_addr),
		.cpu_ss_iniu_sys_apb_porting_p_enable(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_enable),
		.cpu_ss_iniu_sys_apb_porting_p_rdata(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_rdata),
		.cpu_ss_iniu_sys_apb_porting_p_ready(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_ready),
		.cpu_ss_iniu_sys_apb_porting_p_sel(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_sel),
		.cpu_ss_iniu_sys_apb_porting_p_slverr(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_slverr),
		.cpu_ss_iniu_sys_apb_porting_p_wdata(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_wdata),
		.cpu_ss_iniu_sys_apb_porting_p_write(cpu_ss_iniu_cpu_ss_iniu_sys_apb_porting_cpu_ss_iniu_sys_apb_porting_p_write),
		.cpu_ss_iniu_sys_timeout_val_porting_timeout_val(cpu_ss_iniu_cpu_ss_iniu_sys_timeout_val_porting_cpu_ss_iniu_sys_timeout_val_porting_timeout_val),
		.cpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(cpu_ss_iniu_cpu_ss_iniu_sys_lp_hub_porting_cpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.cpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(cpu_ss_iniu_cpu_ss_iniu_sys_lp_hub_porting_cpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	cpu_ss_tniu cpu_ss_tniu (
		.clk_sys_clk(cpu_ss_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(cpu_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.cpu_ss_tniu_top_timeout_val_porting_timeout_val(cpu_ss_tniu_cpu_ss_tniu_top_timeout_val_porting_cpu_ss_tniu_top_timeout_val_porting_timeout_val),
		.cpu_ss_tniu_top_lp_hub_porting_lp_hub_rx_req(cpu_ss_tniu_cpu_ss_tniu_top_lp_hub_porting_cpu_ss_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.cpu_ss_tniu_top_lp_hub_porting_lp_hub_tx_req(cpu_ss_tniu_cpu_ss_tniu_top_lp_hub_porting_cpu_ss_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.cpu_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(cpu_ss_tniu_cpu_ss_tniu_sys_tniu_tgt_id_porting_cpu_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.cpu_ss_tniu_sys_v_interrupt_porting_v_interrupt(cpu_ss_tniu_cpu_ss_tniu_sys_v_interrupt_porting_cpu_ss_tniu_sys_v_interrupt_porting_v_interrupt),
		.cpu_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(cpu_ss_tniu_cpu_ss_tniu_sys_v_merge_interrupt_porting_cpu_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.cpu_ss_tniu_sys_apb_porting_p_addr(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_addr),
		.cpu_ss_tniu_sys_apb_porting_p_enable(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_enable),
		.cpu_ss_tniu_sys_apb_porting_p_rdata(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_rdata),
		.cpu_ss_tniu_sys_apb_porting_p_ready(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_ready),
		.cpu_ss_tniu_sys_apb_porting_p_sel(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_sel),
		.cpu_ss_tniu_sys_apb_porting_p_slverr(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_slverr),
		.cpu_ss_tniu_sys_apb_porting_p_wdata(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_wdata),
		.cpu_ss_tniu_sys_apb_porting_p_write(cpu_ss_tniu_cpu_ss_tniu_sys_apb_porting_cpu_ss_tniu_sys_apb_porting_p_write),
		.cpu_ss_tniu_sys_timeout_val_porting_timeout_val(cpu_ss_tniu_cpu_ss_tniu_sys_timeout_val_porting_cpu_ss_tniu_sys_timeout_val_porting_timeout_val));
	audio_ss_iniu audio_ss_iniu (
		.clk_sys_clk(audio_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(audio_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.audio_ss_iniu_sys_v_interrupt_porting_v_interrupt(audio_ss_iniu_audio_ss_iniu_sys_v_interrupt_porting_audio_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.audio_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(audio_ss_iniu_audio_ss_iniu_sys_iniu_src_id_porting_audio_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.audio_ss_iniu_sys_apb_porting_p_addr(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_addr),
		.audio_ss_iniu_sys_apb_porting_p_enable(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_enable),
		.audio_ss_iniu_sys_apb_porting_p_rdata(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_rdata),
		.audio_ss_iniu_sys_apb_porting_p_ready(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_ready),
		.audio_ss_iniu_sys_apb_porting_p_sel(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_sel),
		.audio_ss_iniu_sys_apb_porting_p_slverr(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_slverr),
		.audio_ss_iniu_sys_apb_porting_p_wdata(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_wdata),
		.audio_ss_iniu_sys_apb_porting_p_write(audio_ss_iniu_audio_ss_iniu_sys_apb_porting_audio_ss_iniu_sys_apb_porting_p_write),
		.audio_ss_iniu_sys_timeout_val_porting_timeout_val(audio_ss_iniu_audio_ss_iniu_sys_timeout_val_porting_audio_ss_iniu_sys_timeout_val_porting_timeout_val),
		.audio_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(audio_ss_iniu_audio_ss_iniu_sys_lp_hub_porting_audio_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.audio_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(audio_ss_iniu_audio_ss_iniu_sys_lp_hub_porting_audio_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	peri_ss_tniu peri_ss_tniu (
		.clk_sys_clk(peri_ss_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(peri_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.peri_ss_tniu_top_timeout_val_porting_timeout_val(peri_ss_tniu_peri_ss_tniu_top_timeout_val_porting_peri_ss_tniu_top_timeout_val_porting_timeout_val),
		.peri_ss_tniu_top_lp_hub_porting_lp_hub_rx_req(peri_ss_tniu_peri_ss_tniu_top_lp_hub_porting_peri_ss_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.peri_ss_tniu_top_lp_hub_porting_lp_hub_tx_req(peri_ss_tniu_peri_ss_tniu_top_lp_hub_porting_peri_ss_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.peri_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(peri_ss_tniu_peri_ss_tniu_sys_tniu_tgt_id_porting_peri_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.peri_ss_tniu_sys_v_interrupt_porting_v_interrupt(peri_ss_tniu_peri_ss_tniu_sys_v_interrupt_porting_peri_ss_tniu_sys_v_interrupt_porting_v_interrupt),
		.peri_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(peri_ss_tniu_peri_ss_tniu_sys_v_merge_interrupt_porting_peri_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.peri_ss_tniu_sys_apb_porting_p_addr(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_addr),
		.peri_ss_tniu_sys_apb_porting_p_enable(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_enable),
		.peri_ss_tniu_sys_apb_porting_p_rdata(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_rdata),
		.peri_ss_tniu_sys_apb_porting_p_ready(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_ready),
		.peri_ss_tniu_sys_apb_porting_p_sel(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_sel),
		.peri_ss_tniu_sys_apb_porting_p_slverr(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_slverr),
		.peri_ss_tniu_sys_apb_porting_p_wdata(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_wdata),
		.peri_ss_tniu_sys_apb_porting_p_write(peri_ss_tniu_peri_ss_tniu_sys_apb_porting_peri_ss_tniu_sys_apb_porting_p_write),
		.peri_ss_tniu_sys_timeout_val_porting_timeout_val(peri_ss_tniu_peri_ss_tniu_sys_timeout_val_porting_peri_ss_tniu_sys_timeout_val_porting_timeout_val));
	gpu_ss1_iniu gpu_ss1_iniu (
		.clk_sys_clk(gpu_ss1_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(gpu_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.gpu_ss1_iniu_sys_v_interrupt_porting_v_interrupt(gpu_ss1_iniu_gpu_ss1_iniu_sys_v_interrupt_porting_gpu_ss1_iniu_sys_v_interrupt_porting_v_interrupt),
		.gpu_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id(gpu_ss1_iniu_gpu_ss1_iniu_sys_iniu_src_id_porting_gpu_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.gpu_ss1_iniu_sys_apb_porting_p_addr(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_addr),
		.gpu_ss1_iniu_sys_apb_porting_p_enable(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_enable),
		.gpu_ss1_iniu_sys_apb_porting_p_rdata(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_rdata),
		.gpu_ss1_iniu_sys_apb_porting_p_ready(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_ready),
		.gpu_ss1_iniu_sys_apb_porting_p_sel(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_sel),
		.gpu_ss1_iniu_sys_apb_porting_p_slverr(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_slverr),
		.gpu_ss1_iniu_sys_apb_porting_p_wdata(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_wdata),
		.gpu_ss1_iniu_sys_apb_porting_p_write(gpu_ss1_iniu_gpu_ss1_iniu_sys_apb_porting_gpu_ss1_iniu_sys_apb_porting_p_write),
		.gpu_ss1_iniu_sys_timeout_val_porting_timeout_val(gpu_ss1_iniu_gpu_ss1_iniu_sys_timeout_val_porting_gpu_ss1_iniu_sys_timeout_val_porting_timeout_val),
		.gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req(gpu_ss1_iniu_gpu_ss1_iniu_sys_lp_hub_porting_gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req(gpu_ss1_iniu_gpu_ss1_iniu_sys_lp_hub_porting_gpu_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	gpu_ss0_tniu gpu_ss0_tniu (
		.clk_sys_clk(gpu_ss0_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(gpu_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.gpu_ss0_tniu_top_timeout_val_porting_timeout_val(gpu_ss0_tniu_gpu_ss0_tniu_top_timeout_val_porting_gpu_ss0_tniu_top_timeout_val_porting_timeout_val),
		.gpu_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req(gpu_ss0_tniu_gpu_ss0_tniu_top_lp_hub_porting_gpu_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.gpu_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req(gpu_ss0_tniu_gpu_ss0_tniu_top_lp_hub_porting_gpu_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.gpu_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(gpu_ss0_tniu_gpu_ss0_tniu_sys_tniu_tgt_id_porting_gpu_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.gpu_ss0_tniu_sys_v_interrupt_porting_v_interrupt(gpu_ss0_tniu_gpu_ss0_tniu_sys_v_interrupt_porting_gpu_ss0_tniu_sys_v_interrupt_porting_v_interrupt),
		.gpu_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(gpu_ss0_tniu_gpu_ss0_tniu_sys_v_merge_interrupt_porting_gpu_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.gpu_ss0_tniu_sys_apb_porting_p_addr(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_addr),
		.gpu_ss0_tniu_sys_apb_porting_p_enable(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_enable),
		.gpu_ss0_tniu_sys_apb_porting_p_rdata(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_rdata),
		.gpu_ss0_tniu_sys_apb_porting_p_ready(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_ready),
		.gpu_ss0_tniu_sys_apb_porting_p_sel(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_sel),
		.gpu_ss0_tniu_sys_apb_porting_p_slverr(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_slverr),
		.gpu_ss0_tniu_sys_apb_porting_p_wdata(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_wdata),
		.gpu_ss0_tniu_sys_apb_porting_p_write(gpu_ss0_tniu_gpu_ss0_tniu_sys_apb_porting_gpu_ss0_tniu_sys_apb_porting_p_write),
		.gpu_ss0_tniu_sys_timeout_val_porting_timeout_val(gpu_ss0_tniu_gpu_ss0_tniu_sys_timeout_val_porting_gpu_ss0_tniu_sys_timeout_val_porting_timeout_val));
	display_ss_tniu display_ss_tniu (
		.clk_sys_clk(display_ss_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(display_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.display_ss_tniu_top_timeout_val_porting_timeout_val(display_ss_tniu_display_ss_tniu_top_timeout_val_porting_display_ss_tniu_top_timeout_val_porting_timeout_val),
		.display_ss_tniu_top_lp_hub_porting_lp_hub_rx_req(display_ss_tniu_display_ss_tniu_top_lp_hub_porting_display_ss_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.display_ss_tniu_top_lp_hub_porting_lp_hub_tx_req(display_ss_tniu_display_ss_tniu_top_lp_hub_porting_display_ss_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.display_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(display_ss_tniu_display_ss_tniu_sys_tniu_tgt_id_porting_display_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.display_ss_tniu_sys_v_interrupt_porting_v_interrupt(display_ss_tniu_display_ss_tniu_sys_v_interrupt_porting_display_ss_tniu_sys_v_interrupt_porting_v_interrupt),
		.display_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(display_ss_tniu_display_ss_tniu_sys_v_merge_interrupt_porting_display_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.display_ss_tniu_sys_apb_porting_p_addr(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_addr),
		.display_ss_tniu_sys_apb_porting_p_enable(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_enable),
		.display_ss_tniu_sys_apb_porting_p_rdata(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_rdata),
		.display_ss_tniu_sys_apb_porting_p_ready(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_ready),
		.display_ss_tniu_sys_apb_porting_p_sel(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_sel),
		.display_ss_tniu_sys_apb_porting_p_slverr(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_slverr),
		.display_ss_tniu_sys_apb_porting_p_wdata(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_wdata),
		.display_ss_tniu_sys_apb_porting_p_write(display_ss_tniu_display_ss_tniu_sys_apb_porting_display_ss_tniu_sys_apb_porting_p_write),
		.display_ss_tniu_sys_timeout_val_porting_timeout_val(display_ss_tniu_display_ss_tniu_sys_timeout_val_porting_display_ss_tniu_sys_timeout_val_porting_timeout_val));
	dp_ss_iniu dp_ss_iniu (
		.clk_sys_clk(dp_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dp_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dp_ss_iniu_sys_v_interrupt_porting_v_interrupt(dp_ss_iniu_dp_ss_iniu_sys_v_interrupt_porting_dp_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.dp_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(dp_ss_iniu_dp_ss_iniu_sys_iniu_src_id_porting_dp_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.dp_ss_iniu_sys_apb_porting_p_addr(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_addr),
		.dp_ss_iniu_sys_apb_porting_p_enable(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_enable),
		.dp_ss_iniu_sys_apb_porting_p_rdata(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_rdata),
		.dp_ss_iniu_sys_apb_porting_p_ready(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_ready),
		.dp_ss_iniu_sys_apb_porting_p_sel(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_sel),
		.dp_ss_iniu_sys_apb_porting_p_slverr(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_slverr),
		.dp_ss_iniu_sys_apb_porting_p_wdata(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_wdata),
		.dp_ss_iniu_sys_apb_porting_p_write(dp_ss_iniu_dp_ss_iniu_sys_apb_porting_dp_ss_iniu_sys_apb_porting_p_write),
		.dp_ss_iniu_sys_timeout_val_porting_timeout_val(dp_ss_iniu_dp_ss_iniu_sys_timeout_val_porting_dp_ss_iniu_sys_timeout_val_porting_timeout_val),
		.dp_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(dp_ss_iniu_dp_ss_iniu_sys_lp_hub_porting_dp_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.dp_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(dp_ss_iniu_dp_ss_iniu_sys_lp_hub_porting_dp_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr6_iniu ddr6_iniu (
		.clk_sys_clk(ddr6_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr6_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr6_iniu_sys_v_interrupt_porting_v_interrupt(ddr6_iniu_ddr6_iniu_sys_v_interrupt_porting_ddr6_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr6_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr6_iniu_ddr6_iniu_sys_iniu_src_id_porting_ddr6_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr6_iniu_sys_apb_porting_p_addr(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_addr),
		.ddr6_iniu_sys_apb_porting_p_enable(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_enable),
		.ddr6_iniu_sys_apb_porting_p_rdata(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_rdata),
		.ddr6_iniu_sys_apb_porting_p_ready(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_ready),
		.ddr6_iniu_sys_apb_porting_p_sel(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_sel),
		.ddr6_iniu_sys_apb_porting_p_slverr(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_slverr),
		.ddr6_iniu_sys_apb_porting_p_wdata(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_wdata),
		.ddr6_iniu_sys_apb_porting_p_write(ddr6_iniu_ddr6_iniu_sys_apb_porting_ddr6_iniu_sys_apb_porting_p_write),
		.ddr6_iniu_sys_timeout_val_porting_timeout_val(ddr6_iniu_ddr6_iniu_sys_timeout_val_porting_ddr6_iniu_sys_timeout_val_porting_timeout_val),
		.ddr6_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr6_iniu_ddr6_iniu_sys_lp_hub_porting_ddr6_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr6_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr6_iniu_ddr6_iniu_sys_lp_hub_porting_ddr6_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr7_iniu ddr7_iniu (
		.clk_sys_clk(ddr7_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr7_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr7_iniu_sys_v_interrupt_porting_v_interrupt(ddr7_iniu_ddr7_iniu_sys_v_interrupt_porting_ddr7_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr7_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr7_iniu_ddr7_iniu_sys_iniu_src_id_porting_ddr7_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr7_iniu_sys_apb_porting_p_addr(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_addr),
		.ddr7_iniu_sys_apb_porting_p_enable(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_enable),
		.ddr7_iniu_sys_apb_porting_p_rdata(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_rdata),
		.ddr7_iniu_sys_apb_porting_p_ready(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_ready),
		.ddr7_iniu_sys_apb_porting_p_sel(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_sel),
		.ddr7_iniu_sys_apb_porting_p_slverr(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_slverr),
		.ddr7_iniu_sys_apb_porting_p_wdata(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_wdata),
		.ddr7_iniu_sys_apb_porting_p_write(ddr7_iniu_ddr7_iniu_sys_apb_porting_ddr7_iniu_sys_apb_porting_p_write),
		.ddr7_iniu_sys_timeout_val_porting_timeout_val(ddr7_iniu_ddr7_iniu_sys_timeout_val_porting_ddr7_iniu_sys_timeout_val_porting_timeout_val),
		.ddr7_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr7_iniu_ddr7_iniu_sys_lp_hub_porting_ddr7_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr7_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr7_iniu_ddr7_iniu_sys_lp_hub_porting_ddr7_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr8_iniu ddr8_iniu (
		.clk_sys_clk(ddr8_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr8_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr8_iniu_sys_v_interrupt_porting_v_interrupt(ddr8_iniu_ddr8_iniu_sys_v_interrupt_porting_ddr8_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr8_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr8_iniu_ddr8_iniu_sys_iniu_src_id_porting_ddr8_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr8_iniu_sys_apb_porting_p_addr(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_addr),
		.ddr8_iniu_sys_apb_porting_p_enable(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_enable),
		.ddr8_iniu_sys_apb_porting_p_rdata(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_rdata),
		.ddr8_iniu_sys_apb_porting_p_ready(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_ready),
		.ddr8_iniu_sys_apb_porting_p_sel(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_sel),
		.ddr8_iniu_sys_apb_porting_p_slverr(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_slverr),
		.ddr8_iniu_sys_apb_porting_p_wdata(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_wdata),
		.ddr8_iniu_sys_apb_porting_p_write(ddr8_iniu_ddr8_iniu_sys_apb_porting_ddr8_iniu_sys_apb_porting_p_write),
		.ddr8_iniu_sys_timeout_val_porting_timeout_val(ddr8_iniu_ddr8_iniu_sys_timeout_val_porting_ddr8_iniu_sys_timeout_val_porting_timeout_val),
		.ddr8_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr8_iniu_ddr8_iniu_sys_lp_hub_porting_ddr8_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr8_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr8_iniu_ddr8_iniu_sys_lp_hub_porting_ddr8_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr9_iniu ddr9_iniu (
		.clk_sys_clk(ddr9_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr9_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr9_iniu_sys_v_interrupt_porting_v_interrupt(ddr9_iniu_ddr9_iniu_sys_v_interrupt_porting_ddr9_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr9_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr9_iniu_ddr9_iniu_sys_iniu_src_id_porting_ddr9_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr9_iniu_sys_apb_porting_p_addr(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_addr),
		.ddr9_iniu_sys_apb_porting_p_enable(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_enable),
		.ddr9_iniu_sys_apb_porting_p_rdata(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_rdata),
		.ddr9_iniu_sys_apb_porting_p_ready(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_ready),
		.ddr9_iniu_sys_apb_porting_p_sel(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_sel),
		.ddr9_iniu_sys_apb_porting_p_slverr(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_slverr),
		.ddr9_iniu_sys_apb_porting_p_wdata(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_wdata),
		.ddr9_iniu_sys_apb_porting_p_write(ddr9_iniu_ddr9_iniu_sys_apb_porting_ddr9_iniu_sys_apb_porting_p_write),
		.ddr9_iniu_sys_timeout_val_porting_timeout_val(ddr9_iniu_ddr9_iniu_sys_timeout_val_porting_ddr9_iniu_sys_timeout_val_porting_timeout_val),
		.ddr9_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr9_iniu_ddr9_iniu_sys_lp_hub_porting_ddr9_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr9_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr9_iniu_ddr9_iniu_sys_lp_hub_porting_ddr9_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr10_iniu ddr10_iniu (
		.clk_sys_clk(ddr10_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr10_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr10_iniu_sys_v_interrupt_porting_v_interrupt(ddr10_iniu_ddr10_iniu_sys_v_interrupt_porting_ddr10_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr10_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr10_iniu_ddr10_iniu_sys_iniu_src_id_porting_ddr10_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr10_iniu_sys_apb_porting_p_addr(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_addr),
		.ddr10_iniu_sys_apb_porting_p_enable(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_enable),
		.ddr10_iniu_sys_apb_porting_p_rdata(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_rdata),
		.ddr10_iniu_sys_apb_porting_p_ready(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_ready),
		.ddr10_iniu_sys_apb_porting_p_sel(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_sel),
		.ddr10_iniu_sys_apb_porting_p_slverr(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_slverr),
		.ddr10_iniu_sys_apb_porting_p_wdata(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_wdata),
		.ddr10_iniu_sys_apb_porting_p_write(ddr10_iniu_ddr10_iniu_sys_apb_porting_ddr10_iniu_sys_apb_porting_p_write),
		.ddr10_iniu_sys_timeout_val_porting_timeout_val(ddr10_iniu_ddr10_iniu_sys_timeout_val_porting_ddr10_iniu_sys_timeout_val_porting_timeout_val),
		.ddr10_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr10_iniu_ddr10_iniu_sys_lp_hub_porting_ddr10_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr10_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr10_iniu_ddr10_iniu_sys_lp_hub_porting_ddr10_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr11_tniu ddr11_tniu (
		.clk_sys_clk(ddr11_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr11_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_a),
		.rst_noc_n(rst_noc_a_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(mipi_ss_iniu_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr11_tniu_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr11_tniu_top_timeout_val_porting_timeout_val(ddr11_tniu_ddr11_tniu_top_timeout_val_porting_ddr11_tniu_top_timeout_val_porting_timeout_val),
		.ddr11_tniu_top_lp_hub_porting_lp_hub_rx_req(ddr11_tniu_ddr11_tniu_top_lp_hub_porting_ddr11_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.ddr11_tniu_top_lp_hub_porting_lp_hub_tx_req(ddr11_tniu_ddr11_tniu_top_lp_hub_porting_ddr11_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.ddr11_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(ddr11_tniu_ddr11_tniu_sys_tniu_tgt_id_porting_ddr11_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.ddr11_tniu_sys_v_interrupt_porting_v_interrupt(ddr11_tniu_ddr11_tniu_sys_v_interrupt_porting_ddr11_tniu_sys_v_interrupt_porting_v_interrupt),
		.ddr11_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(ddr11_tniu_ddr11_tniu_sys_v_merge_interrupt_porting_ddr11_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.ddr11_tniu_sys_apb_porting_p_addr(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_addr),
		.ddr11_tniu_sys_apb_porting_p_enable(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_enable),
		.ddr11_tniu_sys_apb_porting_p_rdata(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_rdata),
		.ddr11_tniu_sys_apb_porting_p_ready(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_ready),
		.ddr11_tniu_sys_apb_porting_p_sel(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_sel),
		.ddr11_tniu_sys_apb_porting_p_slverr(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_slverr),
		.ddr11_tniu_sys_apb_porting_p_wdata(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_wdata),
		.ddr11_tniu_sys_apb_porting_p_write(ddr11_tniu_ddr11_tniu_sys_apb_porting_ddr11_tniu_sys_apb_porting_p_write),
		.ddr11_tniu_sys_timeout_val_porting_timeout_val(ddr11_tniu_ddr11_tniu_sys_timeout_val_porting_ddr11_tniu_sys_timeout_val_porting_timeout_val));
	mipi_ss_iniu mipi_ss_iniu (
		.clk_sys_clk(mipi_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(mipi_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(mipi_ss_iniu_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr11_tniu_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr11_tniu_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(mipi_ss_iniu_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.mipi_ss_iniu_sys_v_interrupt_porting_v_interrupt(mipi_ss_iniu_mipi_ss_iniu_sys_v_interrupt_porting_mipi_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.mipi_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(mipi_ss_iniu_mipi_ss_iniu_sys_iniu_src_id_porting_mipi_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.mipi_ss_iniu_sys_apb_porting_p_addr(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_addr),
		.mipi_ss_iniu_sys_apb_porting_p_enable(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_enable),
		.mipi_ss_iniu_sys_apb_porting_p_rdata(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_rdata),
		.mipi_ss_iniu_sys_apb_porting_p_ready(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_ready),
		.mipi_ss_iniu_sys_apb_porting_p_sel(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_sel),
		.mipi_ss_iniu_sys_apb_porting_p_slverr(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_slverr),
		.mipi_ss_iniu_sys_apb_porting_p_wdata(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_wdata),
		.mipi_ss_iniu_sys_apb_porting_p_write(mipi_ss_iniu_mipi_ss_iniu_sys_apb_porting_mipi_ss_iniu_sys_apb_porting_p_write),
		.mipi_ss_iniu_sys_timeout_val_porting_timeout_val(mipi_ss_iniu_mipi_ss_iniu_sys_timeout_val_porting_mipi_ss_iniu_sys_timeout_val_porting_timeout_val),
		.mipi_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(mipi_ss_iniu_mipi_ss_iniu_sys_lp_hub_porting_mipi_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.mipi_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(mipi_ss_iniu_mipi_ss_iniu_sys_lp_hub_porting_mipi_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ufs_ss_iniu ufs_ss_iniu (
		.clk_sys_clk(ufs_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ufs_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ufs_ss_iniu_sys_v_interrupt_porting_v_interrupt(ufs_ss_iniu_ufs_ss_iniu_sys_v_interrupt_porting_ufs_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.ufs_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(ufs_ss_iniu_ufs_ss_iniu_sys_iniu_src_id_porting_ufs_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ufs_ss_iniu_sys_apb_porting_p_addr(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_addr),
		.ufs_ss_iniu_sys_apb_porting_p_enable(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_enable),
		.ufs_ss_iniu_sys_apb_porting_p_rdata(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_rdata),
		.ufs_ss_iniu_sys_apb_porting_p_ready(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_ready),
		.ufs_ss_iniu_sys_apb_porting_p_sel(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_sel),
		.ufs_ss_iniu_sys_apb_porting_p_slverr(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_slverr),
		.ufs_ss_iniu_sys_apb_porting_p_wdata(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_wdata),
		.ufs_ss_iniu_sys_apb_porting_p_write(ufs_ss_iniu_ufs_ss_iniu_sys_apb_porting_ufs_ss_iniu_sys_apb_porting_p_write),
		.ufs_ss_iniu_sys_timeout_val_porting_timeout_val(ufs_ss_iniu_ufs_ss_iniu_sys_timeout_val_porting_ufs_ss_iniu_sys_timeout_val_porting_timeout_val),
		.ufs_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(ufs_ss_iniu_ufs_ss_iniu_sys_lp_hub_porting_ufs_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ufs_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(ufs_ss_iniu_ufs_ss_iniu_sys_lp_hub_porting_ufs_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	camera_ss_tniu camera_ss_tniu (
		.clk_sys_clk(camera_ss_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(camera_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.camera_ss_tniu_top_timeout_val_porting_timeout_val(camera_ss_tniu_camera_ss_tniu_top_timeout_val_porting_camera_ss_tniu_top_timeout_val_porting_timeout_val),
		.camera_ss_tniu_top_lp_hub_porting_lp_hub_rx_req(camera_ss_tniu_camera_ss_tniu_top_lp_hub_porting_camera_ss_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.camera_ss_tniu_top_lp_hub_porting_lp_hub_tx_req(camera_ss_tniu_camera_ss_tniu_top_lp_hub_porting_camera_ss_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.camera_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(camera_ss_tniu_camera_ss_tniu_sys_tniu_tgt_id_porting_camera_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.camera_ss_tniu_sys_v_interrupt_porting_v_interrupt(camera_ss_tniu_camera_ss_tniu_sys_v_interrupt_porting_camera_ss_tniu_sys_v_interrupt_porting_v_interrupt),
		.camera_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(camera_ss_tniu_camera_ss_tniu_sys_v_merge_interrupt_porting_camera_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.camera_ss_tniu_sys_apb_porting_p_addr(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_addr),
		.camera_ss_tniu_sys_apb_porting_p_enable(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_enable),
		.camera_ss_tniu_sys_apb_porting_p_rdata(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_rdata),
		.camera_ss_tniu_sys_apb_porting_p_ready(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_ready),
		.camera_ss_tniu_sys_apb_porting_p_sel(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_sel),
		.camera_ss_tniu_sys_apb_porting_p_slverr(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_slverr),
		.camera_ss_tniu_sys_apb_porting_p_wdata(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_wdata),
		.camera_ss_tniu_sys_apb_porting_p_write(camera_ss_tniu_camera_ss_tniu_sys_apb_porting_camera_ss_tniu_sys_apb_porting_p_write),
		.camera_ss_tniu_sys_timeout_val_porting_timeout_val(camera_ss_tniu_camera_ss_tniu_sys_timeout_val_porting_camera_ss_tniu_sys_timeout_val_porting_timeout_val));
	camera_ss_iniu camera_ss_iniu (
		.clk_sys_clk(camera_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(camera_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(vpu_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(camera_ss_iniu_TO_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.camera_ss_iniu_sys_v_interrupt_porting_v_interrupt(camera_ss_iniu_camera_ss_iniu_sys_v_interrupt_porting_camera_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.camera_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(camera_ss_iniu_camera_ss_iniu_sys_iniu_src_id_porting_camera_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.camera_ss_iniu_sys_apb_porting_p_addr(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_addr),
		.camera_ss_iniu_sys_apb_porting_p_enable(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_enable),
		.camera_ss_iniu_sys_apb_porting_p_rdata(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_rdata),
		.camera_ss_iniu_sys_apb_porting_p_ready(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_ready),
		.camera_ss_iniu_sys_apb_porting_p_sel(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_sel),
		.camera_ss_iniu_sys_apb_porting_p_slverr(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_slverr),
		.camera_ss_iniu_sys_apb_porting_p_wdata(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_wdata),
		.camera_ss_iniu_sys_apb_porting_p_write(camera_ss_iniu_camera_ss_iniu_sys_apb_porting_camera_ss_iniu_sys_apb_porting_p_write),
		.camera_ss_iniu_sys_timeout_val_porting_timeout_val(camera_ss_iniu_camera_ss_iniu_sys_timeout_val_porting_camera_ss_iniu_sys_timeout_val_porting_timeout_val),
		.camera_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(camera_ss_iniu_camera_ss_iniu_sys_lp_hub_porting_camera_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.camera_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(camera_ss_iniu_camera_ss_iniu_sys_lp_hub_porting_camera_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	vpu_ss_iniu vpu_ss_iniu (
		.clk_sys_clk(vpu_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(vpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(vpu_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(camera_ss_iniu_TO_vpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(camera_ss_iniu_TO_vpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(vpu_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.vpu_ss_iniu_sys_v_interrupt_porting_v_interrupt(vpu_ss_iniu_vpu_ss_iniu_sys_v_interrupt_porting_vpu_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.vpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(vpu_ss_iniu_vpu_ss_iniu_sys_iniu_src_id_porting_vpu_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.vpu_ss_iniu_sys_apb_porting_p_addr(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_addr),
		.vpu_ss_iniu_sys_apb_porting_p_enable(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_enable),
		.vpu_ss_iniu_sys_apb_porting_p_rdata(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_rdata),
		.vpu_ss_iniu_sys_apb_porting_p_ready(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_ready),
		.vpu_ss_iniu_sys_apb_porting_p_sel(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_sel),
		.vpu_ss_iniu_sys_apb_porting_p_slverr(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_slverr),
		.vpu_ss_iniu_sys_apb_porting_p_wdata(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_wdata),
		.vpu_ss_iniu_sys_apb_porting_p_write(vpu_ss_iniu_vpu_ss_iniu_sys_apb_porting_vpu_ss_iniu_sys_apb_porting_p_write),
		.vpu_ss_iniu_sys_timeout_val_porting_timeout_val(vpu_ss_iniu_vpu_ss_iniu_sys_timeout_val_porting_vpu_ss_iniu_sys_timeout_val_porting_timeout_val),
		.vpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(vpu_ss_iniu_vpu_ss_iniu_sys_lp_hub_porting_vpu_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.vpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(vpu_ss_iniu_vpu_ss_iniu_sys_lp_hub_porting_vpu_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	pcie_eth_ss_iniu pcie_eth_ss_iniu (
		.clk_sys_clk(pcie_eth_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(pcie_eth_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(vpu_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(pcie_eth_ss_iniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.pcie_eth_ss_iniu_sys_v_interrupt_porting_v_interrupt(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_v_interrupt_porting_pcie_eth_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.pcie_eth_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_iniu_src_id_porting_pcie_eth_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.pcie_eth_ss_iniu_sys_apb_porting_p_addr(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_addr),
		.pcie_eth_ss_iniu_sys_apb_porting_p_enable(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_enable),
		.pcie_eth_ss_iniu_sys_apb_porting_p_rdata(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_rdata),
		.pcie_eth_ss_iniu_sys_apb_porting_p_ready(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_ready),
		.pcie_eth_ss_iniu_sys_apb_porting_p_sel(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_sel),
		.pcie_eth_ss_iniu_sys_apb_porting_p_slverr(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_slverr),
		.pcie_eth_ss_iniu_sys_apb_porting_p_wdata(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_wdata),
		.pcie_eth_ss_iniu_sys_apb_porting_p_write(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_apb_porting_pcie_eth_ss_iniu_sys_apb_porting_p_write),
		.pcie_eth_ss_iniu_sys_timeout_val_porting_timeout_val(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_timeout_val_porting_pcie_eth_ss_iniu_sys_timeout_val_porting_timeout_val),
		.pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_lp_hub_porting_pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(pcie_eth_ss_iniu_pcie_eth_ss_iniu_sys_lp_hub_porting_pcie_eth_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	debug_ss_iniu debug_ss_iniu (
		.clk_sys_clk(debug_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(debug_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.debug_ss_iniu_sys_v_interrupt_porting_v_interrupt(debug_ss_iniu_debug_ss_iniu_sys_v_interrupt_porting_debug_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.debug_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(debug_ss_iniu_debug_ss_iniu_sys_iniu_src_id_porting_debug_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.debug_ss_iniu_sys_apb_porting_p_addr(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_addr),
		.debug_ss_iniu_sys_apb_porting_p_enable(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_enable),
		.debug_ss_iniu_sys_apb_porting_p_rdata(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_rdata),
		.debug_ss_iniu_sys_apb_porting_p_ready(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_ready),
		.debug_ss_iniu_sys_apb_porting_p_sel(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_sel),
		.debug_ss_iniu_sys_apb_porting_p_slverr(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_slverr),
		.debug_ss_iniu_sys_apb_porting_p_wdata(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_wdata),
		.debug_ss_iniu_sys_apb_porting_p_write(debug_ss_iniu_debug_ss_iniu_sys_apb_porting_debug_ss_iniu_sys_apb_porting_p_write),
		.debug_ss_iniu_sys_timeout_val_porting_timeout_val(debug_ss_iniu_debug_ss_iniu_sys_timeout_val_porting_debug_ss_iniu_sys_timeout_val_porting_timeout_val),
		.debug_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(debug_ss_iniu_debug_ss_iniu_sys_lp_hub_porting_debug_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.debug_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(debug_ss_iniu_debug_ss_iniu_sys_lp_hub_porting_debug_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	aon_ss_iniu aon_ss_iniu (
		.clk_sys_clk(aon_ss_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(aon_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.aon_ss_iniu_sys_v_interrupt_porting_v_interrupt(aon_ss_iniu_aon_ss_iniu_sys_v_interrupt_porting_aon_ss_iniu_sys_v_interrupt_porting_v_interrupt),
		.aon_ss_iniu_sys_iniu_src_id_porting_iniu_src_id(aon_ss_iniu_aon_ss_iniu_sys_iniu_src_id_porting_aon_ss_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.aon_ss_iniu_sys_apb_porting_p_addr(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_addr),
		.aon_ss_iniu_sys_apb_porting_p_enable(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_enable),
		.aon_ss_iniu_sys_apb_porting_p_rdata(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_rdata),
		.aon_ss_iniu_sys_apb_porting_p_ready(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_ready),
		.aon_ss_iniu_sys_apb_porting_p_sel(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_sel),
		.aon_ss_iniu_sys_apb_porting_p_slverr(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_slverr),
		.aon_ss_iniu_sys_apb_porting_p_wdata(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_wdata),
		.aon_ss_iniu_sys_apb_porting_p_write(aon_ss_iniu_aon_ss_iniu_sys_apb_porting_aon_ss_iniu_sys_apb_porting_p_write),
		.aon_ss_iniu_sys_timeout_val_porting_timeout_val(aon_ss_iniu_aon_ss_iniu_sys_timeout_val_porting_aon_ss_iniu_sys_timeout_val_porting_timeout_val),
		.aon_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req(aon_ss_iniu_aon_ss_iniu_sys_lp_hub_porting_aon_ss_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.aon_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req(aon_ss_iniu_aon_ss_iniu_sys_lp_hub_porting_aon_ss_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	aon_ss_tniu aon_ss_tniu (
		.clk_sys_clk(aon_ss_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(aon_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.aon_ss_tniu_top_timeout_val_porting_timeout_val(aon_ss_tniu_aon_ss_tniu_top_timeout_val_porting_aon_ss_tniu_top_timeout_val_porting_timeout_val),
		.aon_ss_tniu_top_lp_hub_porting_lp_hub_rx_req(aon_ss_tniu_aon_ss_tniu_top_lp_hub_porting_aon_ss_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.aon_ss_tniu_top_lp_hub_porting_lp_hub_tx_req(aon_ss_tniu_aon_ss_tniu_top_lp_hub_porting_aon_ss_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.aon_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(aon_ss_tniu_aon_ss_tniu_sys_tniu_tgt_id_porting_aon_ss_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.aon_ss_tniu_sys_v_interrupt_porting_v_interrupt(aon_ss_tniu_aon_ss_tniu_sys_v_interrupt_porting_aon_ss_tniu_sys_v_interrupt_porting_v_interrupt),
		.aon_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(aon_ss_tniu_aon_ss_tniu_sys_v_merge_interrupt_porting_aon_ss_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.aon_ss_tniu_sys_apb_porting_p_addr(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_addr),
		.aon_ss_tniu_sys_apb_porting_p_enable(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_enable),
		.aon_ss_tniu_sys_apb_porting_p_rdata(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_rdata),
		.aon_ss_tniu_sys_apb_porting_p_ready(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_ready),
		.aon_ss_tniu_sys_apb_porting_p_sel(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_sel),
		.aon_ss_tniu_sys_apb_porting_p_slverr(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_slverr),
		.aon_ss_tniu_sys_apb_porting_p_wdata(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_wdata),
		.aon_ss_tniu_sys_apb_porting_p_write(aon_ss_tniu_aon_ss_tniu_sys_apb_porting_aon_ss_tniu_sys_apb_porting_p_write),
		.aon_ss_tniu_sys_timeout_val_porting_timeout_val(aon_ss_tniu_aon_ss_tniu_sys_timeout_val_porting_aon_ss_tniu_sys_timeout_val_porting_timeout_val));
	ucie_ss1_iniu ucie_ss1_iniu (
		.clk_sys_clk(ucie_ss1_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ucie_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ucie_ss1_iniu_sys_v_interrupt_porting_v_interrupt(ucie_ss1_iniu_ucie_ss1_iniu_sys_v_interrupt_porting_ucie_ss1_iniu_sys_v_interrupt_porting_v_interrupt),
		.ucie_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id(ucie_ss1_iniu_ucie_ss1_iniu_sys_iniu_src_id_porting_ucie_ss1_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ucie_ss1_iniu_sys_apb_porting_p_addr(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_addr),
		.ucie_ss1_iniu_sys_apb_porting_p_enable(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_enable),
		.ucie_ss1_iniu_sys_apb_porting_p_rdata(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_rdata),
		.ucie_ss1_iniu_sys_apb_porting_p_ready(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_ready),
		.ucie_ss1_iniu_sys_apb_porting_p_sel(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_sel),
		.ucie_ss1_iniu_sys_apb_porting_p_slverr(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_slverr),
		.ucie_ss1_iniu_sys_apb_porting_p_wdata(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_wdata),
		.ucie_ss1_iniu_sys_apb_porting_p_write(ucie_ss1_iniu_ucie_ss1_iniu_sys_apb_porting_ucie_ss1_iniu_sys_apb_porting_p_write),
		.ucie_ss1_iniu_sys_timeout_val_porting_timeout_val(ucie_ss1_iniu_ucie_ss1_iniu_sys_timeout_val_porting_ucie_ss1_iniu_sys_timeout_val_porting_timeout_val),
		.ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req(ucie_ss1_iniu_ucie_ss1_iniu_sys_lp_hub_porting_ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req(ucie_ss1_iniu_ucie_ss1_iniu_sys_lp_hub_porting_ucie_ss1_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ucie_ss1_tniu ucie_ss1_tniu (
		.clk_sys_clk(ucie_ss1_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ucie_ss1_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ucie_ss1_tniu_top_timeout_val_porting_timeout_val(ucie_ss1_tniu_ucie_ss1_tniu_top_timeout_val_porting_ucie_ss1_tniu_top_timeout_val_porting_timeout_val),
		.ucie_ss1_tniu_top_lp_hub_porting_lp_hub_rx_req(ucie_ss1_tniu_ucie_ss1_tniu_top_lp_hub_porting_ucie_ss1_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.ucie_ss1_tniu_top_lp_hub_porting_lp_hub_tx_req(ucie_ss1_tniu_ucie_ss1_tniu_top_lp_hub_porting_ucie_ss1_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.ucie_ss1_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(ucie_ss1_tniu_ucie_ss1_tniu_sys_tniu_tgt_id_porting_ucie_ss1_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.ucie_ss1_tniu_sys_v_interrupt_porting_v_interrupt(ucie_ss1_tniu_ucie_ss1_tniu_sys_v_interrupt_porting_ucie_ss1_tniu_sys_v_interrupt_porting_v_interrupt),
		.ucie_ss1_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(ucie_ss1_tniu_ucie_ss1_tniu_sys_v_merge_interrupt_porting_ucie_ss1_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.ucie_ss1_tniu_sys_apb_porting_p_addr(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_addr),
		.ucie_ss1_tniu_sys_apb_porting_p_enable(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_enable),
		.ucie_ss1_tniu_sys_apb_porting_p_rdata(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_rdata),
		.ucie_ss1_tniu_sys_apb_porting_p_ready(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_ready),
		.ucie_ss1_tniu_sys_apb_porting_p_sel(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_sel),
		.ucie_ss1_tniu_sys_apb_porting_p_slverr(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_slverr),
		.ucie_ss1_tniu_sys_apb_porting_p_wdata(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_wdata),
		.ucie_ss1_tniu_sys_apb_porting_p_write(ucie_ss1_tniu_ucie_ss1_tniu_sys_apb_porting_ucie_ss1_tniu_sys_apb_porting_p_write),
		.ucie_ss1_tniu_sys_timeout_val_porting_timeout_val(ucie_ss1_tniu_ucie_ss1_tniu_sys_timeout_val_porting_ucie_ss1_tniu_sys_timeout_val_porting_timeout_val));
	dspss5_iniu dspss5_iniu (
		.clk_sys_clk(dspss5_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss5_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss4_tniu_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss5_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss5_iniu_sys_v_interrupt_porting_v_interrupt(dspss5_iniu_dspss5_iniu_sys_v_interrupt_porting_dspss5_iniu_sys_v_interrupt_porting_v_interrupt),
		.dspss5_iniu_sys_iniu_src_id_porting_iniu_src_id(dspss5_iniu_dspss5_iniu_sys_iniu_src_id_porting_dspss5_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.dspss5_iniu_sys_apb_porting_p_addr(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_addr),
		.dspss5_iniu_sys_apb_porting_p_enable(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_enable),
		.dspss5_iniu_sys_apb_porting_p_rdata(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_rdata),
		.dspss5_iniu_sys_apb_porting_p_ready(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_ready),
		.dspss5_iniu_sys_apb_porting_p_sel(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_sel),
		.dspss5_iniu_sys_apb_porting_p_slverr(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_slverr),
		.dspss5_iniu_sys_apb_porting_p_wdata(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_wdata),
		.dspss5_iniu_sys_apb_porting_p_write(dspss5_iniu_dspss5_iniu_sys_apb_porting_dspss5_iniu_sys_apb_porting_p_write),
		.dspss5_iniu_sys_timeout_val_porting_timeout_val(dspss5_iniu_dspss5_iniu_sys_timeout_val_porting_dspss5_iniu_sys_timeout_val_porting_timeout_val),
		.dspss5_iniu_sys_lp_hub_porting_lp_hub_rx_req(dspss5_iniu_dspss5_iniu_sys_lp_hub_porting_dspss5_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.dspss5_iniu_sys_lp_hub_porting_lp_hub_tx_req(dspss5_iniu_dspss5_iniu_sys_lp_hub_porting_dspss5_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	dspss4_tniu dspss4_tniu (
		.clk_sys_clk(dspss4_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss4_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss4_tniu_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss5_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss5_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss4_tniu_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss4_tniu_top_timeout_val_porting_timeout_val(dspss4_tniu_dspss4_tniu_top_timeout_val_porting_dspss4_tniu_top_timeout_val_porting_timeout_val),
		.dspss4_tniu_top_lp_hub_porting_lp_hub_rx_req(dspss4_tniu_dspss4_tniu_top_lp_hub_porting_dspss4_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.dspss4_tniu_top_lp_hub_porting_lp_hub_tx_req(dspss4_tniu_dspss4_tniu_top_lp_hub_porting_dspss4_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.dspss4_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(dspss4_tniu_dspss4_tniu_sys_tniu_tgt_id_porting_dspss4_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.dspss4_tniu_sys_v_interrupt_porting_v_interrupt(dspss4_tniu_dspss4_tniu_sys_v_interrupt_porting_dspss4_tniu_sys_v_interrupt_porting_v_interrupt),
		.dspss4_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(dspss4_tniu_dspss4_tniu_sys_v_merge_interrupt_porting_dspss4_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.dspss4_tniu_sys_apb_porting_p_addr(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_addr),
		.dspss4_tniu_sys_apb_porting_p_enable(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_enable),
		.dspss4_tniu_sys_apb_porting_p_rdata(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_rdata),
		.dspss4_tniu_sys_apb_porting_p_ready(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_ready),
		.dspss4_tniu_sys_apb_porting_p_sel(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_sel),
		.dspss4_tniu_sys_apb_porting_p_slverr(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_slverr),
		.dspss4_tniu_sys_apb_porting_p_wdata(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_wdata),
		.dspss4_tniu_sys_apb_porting_p_write(dspss4_tniu_dspss4_tniu_sys_apb_porting_dspss4_tniu_sys_apb_porting_p_write),
		.dspss4_tniu_sys_timeout_val_porting_timeout_val(dspss4_tniu_dspss4_tniu_sys_timeout_val_porting_dspss4_tniu_sys_timeout_val_porting_timeout_val));
	dspss3_iniu dspss3_iniu (
		.clk_sys_clk(dspss3_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss3_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss3_iniu_sys_v_interrupt_porting_v_interrupt(dspss3_iniu_dspss3_iniu_sys_v_interrupt_porting_dspss3_iniu_sys_v_interrupt_porting_v_interrupt),
		.dspss3_iniu_sys_iniu_src_id_porting_iniu_src_id(dspss3_iniu_dspss3_iniu_sys_iniu_src_id_porting_dspss3_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.dspss3_iniu_sys_apb_porting_p_addr(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_addr),
		.dspss3_iniu_sys_apb_porting_p_enable(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_enable),
		.dspss3_iniu_sys_apb_porting_p_rdata(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_rdata),
		.dspss3_iniu_sys_apb_porting_p_ready(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_ready),
		.dspss3_iniu_sys_apb_porting_p_sel(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_sel),
		.dspss3_iniu_sys_apb_porting_p_slverr(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_slverr),
		.dspss3_iniu_sys_apb_porting_p_wdata(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_wdata),
		.dspss3_iniu_sys_apb_porting_p_write(dspss3_iniu_dspss3_iniu_sys_apb_porting_dspss3_iniu_sys_apb_porting_p_write),
		.dspss3_iniu_sys_timeout_val_porting_timeout_val(dspss3_iniu_dspss3_iniu_sys_timeout_val_porting_dspss3_iniu_sys_timeout_val_porting_timeout_val),
		.dspss3_iniu_sys_lp_hub_porting_lp_hub_rx_req(dspss3_iniu_dspss3_iniu_sys_lp_hub_porting_dspss3_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.dspss3_iniu_sys_lp_hub_porting_lp_hub_tx_req(dspss3_iniu_dspss3_iniu_sys_lp_hub_porting_dspss3_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	dspss2_tniu dspss2_tniu (
		.clk_sys_clk(dspss2_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss2_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss2_tniu_top_timeout_val_porting_timeout_val(dspss2_tniu_dspss2_tniu_top_timeout_val_porting_dspss2_tniu_top_timeout_val_porting_timeout_val),
		.dspss2_tniu_top_lp_hub_porting_lp_hub_rx_req(dspss2_tniu_dspss2_tniu_top_lp_hub_porting_dspss2_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.dspss2_tniu_top_lp_hub_porting_lp_hub_tx_req(dspss2_tniu_dspss2_tniu_top_lp_hub_porting_dspss2_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.dspss2_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(dspss2_tniu_dspss2_tniu_sys_tniu_tgt_id_porting_dspss2_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.dspss2_tniu_sys_v_interrupt_porting_v_interrupt(dspss2_tniu_dspss2_tniu_sys_v_interrupt_porting_dspss2_tniu_sys_v_interrupt_porting_v_interrupt),
		.dspss2_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(dspss2_tniu_dspss2_tniu_sys_v_merge_interrupt_porting_dspss2_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.dspss2_tniu_sys_apb_porting_p_addr(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_addr),
		.dspss2_tniu_sys_apb_porting_p_enable(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_enable),
		.dspss2_tniu_sys_apb_porting_p_rdata(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_rdata),
		.dspss2_tniu_sys_apb_porting_p_ready(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_ready),
		.dspss2_tniu_sys_apb_porting_p_sel(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_sel),
		.dspss2_tniu_sys_apb_porting_p_slverr(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_slverr),
		.dspss2_tniu_sys_apb_porting_p_wdata(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_wdata),
		.dspss2_tniu_sys_apb_porting_p_write(dspss2_tniu_dspss2_tniu_sys_apb_porting_dspss2_tniu_sys_apb_porting_p_write),
		.dspss2_tniu_sys_timeout_val_porting_timeout_val(dspss2_tniu_dspss2_tniu_sys_timeout_val_porting_dspss2_tniu_sys_timeout_val_porting_timeout_val));
	dspss1_iniu dspss1_iniu (
		.clk_sys_clk(dspss1_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss1_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss1_iniu_sys_v_interrupt_porting_v_interrupt(dspss1_iniu_dspss1_iniu_sys_v_interrupt_porting_dspss1_iniu_sys_v_interrupt_porting_v_interrupt),
		.dspss1_iniu_sys_iniu_src_id_porting_iniu_src_id(dspss1_iniu_dspss1_iniu_sys_iniu_src_id_porting_dspss1_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.dspss1_iniu_sys_apb_porting_p_addr(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_addr),
		.dspss1_iniu_sys_apb_porting_p_enable(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_enable),
		.dspss1_iniu_sys_apb_porting_p_rdata(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_rdata),
		.dspss1_iniu_sys_apb_porting_p_ready(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_ready),
		.dspss1_iniu_sys_apb_porting_p_sel(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_sel),
		.dspss1_iniu_sys_apb_porting_p_slverr(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_slverr),
		.dspss1_iniu_sys_apb_porting_p_wdata(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_wdata),
		.dspss1_iniu_sys_apb_porting_p_write(dspss1_iniu_dspss1_iniu_sys_apb_porting_dspss1_iniu_sys_apb_porting_p_write),
		.dspss1_iniu_sys_timeout_val_porting_timeout_val(dspss1_iniu_dspss1_iniu_sys_timeout_val_porting_dspss1_iniu_sys_timeout_val_porting_timeout_val),
		.dspss1_iniu_sys_lp_hub_porting_lp_hub_rx_req(dspss1_iniu_dspss1_iniu_sys_lp_hub_porting_dspss1_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.dspss1_iniu_sys_lp_hub_porting_lp_hub_tx_req(dspss1_iniu_dspss1_iniu_sys_lp_hub_porting_dspss1_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	dspss0_tniu dspss0_tniu (
		.clk_sys_clk(dspss0_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dspss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.dspss0_tniu_top_timeout_val_porting_timeout_val(dspss0_tniu_dspss0_tniu_top_timeout_val_porting_dspss0_tniu_top_timeout_val_porting_timeout_val),
		.dspss0_tniu_top_lp_hub_porting_lp_hub_rx_req(dspss0_tniu_dspss0_tniu_top_lp_hub_porting_dspss0_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.dspss0_tniu_top_lp_hub_porting_lp_hub_tx_req(dspss0_tniu_dspss0_tniu_top_lp_hub_porting_dspss0_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.dspss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(dspss0_tniu_dspss0_tniu_sys_tniu_tgt_id_porting_dspss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.dspss0_tniu_sys_v_interrupt_porting_v_interrupt(dspss0_tniu_dspss0_tniu_sys_v_interrupt_porting_dspss0_tniu_sys_v_interrupt_porting_v_interrupt),
		.dspss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(dspss0_tniu_dspss0_tniu_sys_v_merge_interrupt_porting_dspss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.dspss0_tniu_sys_apb_porting_p_addr(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_addr),
		.dspss0_tniu_sys_apb_porting_p_enable(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_enable),
		.dspss0_tniu_sys_apb_porting_p_rdata(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_rdata),
		.dspss0_tniu_sys_apb_porting_p_ready(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_ready),
		.dspss0_tniu_sys_apb_porting_p_sel(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_sel),
		.dspss0_tniu_sys_apb_porting_p_slverr(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_slverr),
		.dspss0_tniu_sys_apb_porting_p_wdata(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_wdata),
		.dspss0_tniu_sys_apb_porting_p_write(dspss0_tniu_dspss0_tniu_sys_apb_porting_dspss0_tniu_sys_apb_porting_p_write),
		.dspss0_tniu_sys_timeout_val_porting_timeout_val(dspss0_tniu_dspss0_tniu_sys_timeout_val_porting_dspss0_tniu_sys_timeout_val_porting_timeout_val));
	ddr0_iniu ddr0_iniu (
		.clk_sys_clk(ddr0_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr0_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr0_iniu_sys_v_interrupt_porting_v_interrupt(ddr0_iniu_ddr0_iniu_sys_v_interrupt_porting_ddr0_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr0_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr0_iniu_ddr0_iniu_sys_iniu_src_id_porting_ddr0_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr0_iniu_sys_apb_porting_p_addr(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_addr),
		.ddr0_iniu_sys_apb_porting_p_enable(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_enable),
		.ddr0_iniu_sys_apb_porting_p_rdata(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_rdata),
		.ddr0_iniu_sys_apb_porting_p_ready(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_ready),
		.ddr0_iniu_sys_apb_porting_p_sel(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_sel),
		.ddr0_iniu_sys_apb_porting_p_slverr(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_slverr),
		.ddr0_iniu_sys_apb_porting_p_wdata(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_wdata),
		.ddr0_iniu_sys_apb_porting_p_write(ddr0_iniu_ddr0_iniu_sys_apb_porting_ddr0_iniu_sys_apb_porting_p_write),
		.ddr0_iniu_sys_timeout_val_porting_timeout_val(ddr0_iniu_ddr0_iniu_sys_timeout_val_porting_ddr0_iniu_sys_timeout_val_porting_timeout_val),
		.ddr0_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr0_iniu_ddr0_iniu_sys_lp_hub_porting_ddr0_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr0_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr0_iniu_ddr0_iniu_sys_lp_hub_porting_ddr0_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr1_iniu ddr1_iniu (
		.clk_sys_clk(ddr1_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr1_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr1_iniu_sys_v_interrupt_porting_v_interrupt(ddr1_iniu_ddr1_iniu_sys_v_interrupt_porting_ddr1_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr1_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr1_iniu_ddr1_iniu_sys_iniu_src_id_porting_ddr1_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr1_iniu_sys_apb_porting_p_addr(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_addr),
		.ddr1_iniu_sys_apb_porting_p_enable(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_enable),
		.ddr1_iniu_sys_apb_porting_p_rdata(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_rdata),
		.ddr1_iniu_sys_apb_porting_p_ready(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_ready),
		.ddr1_iniu_sys_apb_porting_p_sel(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_sel),
		.ddr1_iniu_sys_apb_porting_p_slverr(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_slverr),
		.ddr1_iniu_sys_apb_porting_p_wdata(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_wdata),
		.ddr1_iniu_sys_apb_porting_p_write(ddr1_iniu_ddr1_iniu_sys_apb_porting_ddr1_iniu_sys_apb_porting_p_write),
		.ddr1_iniu_sys_timeout_val_porting_timeout_val(ddr1_iniu_ddr1_iniu_sys_timeout_val_porting_ddr1_iniu_sys_timeout_val_porting_timeout_val),
		.ddr1_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr1_iniu_ddr1_iniu_sys_lp_hub_porting_ddr1_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr1_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr1_iniu_ddr1_iniu_sys_lp_hub_porting_ddr1_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr2_iniu ddr2_iniu (
		.clk_sys_clk(ddr2_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr2_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr2_iniu_sys_v_interrupt_porting_v_interrupt(ddr2_iniu_ddr2_iniu_sys_v_interrupt_porting_ddr2_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr2_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr2_iniu_ddr2_iniu_sys_iniu_src_id_porting_ddr2_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr2_iniu_sys_apb_porting_p_addr(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_addr),
		.ddr2_iniu_sys_apb_porting_p_enable(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_enable),
		.ddr2_iniu_sys_apb_porting_p_rdata(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_rdata),
		.ddr2_iniu_sys_apb_porting_p_ready(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_ready),
		.ddr2_iniu_sys_apb_porting_p_sel(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_sel),
		.ddr2_iniu_sys_apb_porting_p_slverr(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_slverr),
		.ddr2_iniu_sys_apb_porting_p_wdata(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_wdata),
		.ddr2_iniu_sys_apb_porting_p_write(ddr2_iniu_ddr2_iniu_sys_apb_porting_ddr2_iniu_sys_apb_porting_p_write),
		.ddr2_iniu_sys_timeout_val_porting_timeout_val(ddr2_iniu_ddr2_iniu_sys_timeout_val_porting_ddr2_iniu_sys_timeout_val_porting_timeout_val),
		.ddr2_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr2_iniu_ddr2_iniu_sys_lp_hub_porting_ddr2_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr2_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr2_iniu_ddr2_iniu_sys_lp_hub_porting_ddr2_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr3_iniu ddr3_iniu (
		.clk_sys_clk(ddr3_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr3_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr3_iniu_sys_v_interrupt_porting_v_interrupt(ddr3_iniu_ddr3_iniu_sys_v_interrupt_porting_ddr3_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr3_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr3_iniu_ddr3_iniu_sys_iniu_src_id_porting_ddr3_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr3_iniu_sys_apb_porting_p_addr(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_addr),
		.ddr3_iniu_sys_apb_porting_p_enable(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_enable),
		.ddr3_iniu_sys_apb_porting_p_rdata(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_rdata),
		.ddr3_iniu_sys_apb_porting_p_ready(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_ready),
		.ddr3_iniu_sys_apb_porting_p_sel(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_sel),
		.ddr3_iniu_sys_apb_porting_p_slverr(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_slverr),
		.ddr3_iniu_sys_apb_porting_p_wdata(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_wdata),
		.ddr3_iniu_sys_apb_porting_p_write(ddr3_iniu_ddr3_iniu_sys_apb_porting_ddr3_iniu_sys_apb_porting_p_write),
		.ddr3_iniu_sys_timeout_val_porting_timeout_val(ddr3_iniu_ddr3_iniu_sys_timeout_val_porting_ddr3_iniu_sys_timeout_val_porting_timeout_val),
		.ddr3_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr3_iniu_ddr3_iniu_sys_lp_hub_porting_ddr3_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr3_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr3_iniu_ddr3_iniu_sys_lp_hub_porting_ddr3_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr4_iniu ddr4_iniu (
		.clk_sys_clk(ddr4_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr4_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr4_iniu_sys_v_interrupt_porting_v_interrupt(ddr4_iniu_ddr4_iniu_sys_v_interrupt_porting_ddr4_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr4_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr4_iniu_ddr4_iniu_sys_iniu_src_id_porting_ddr4_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr4_iniu_sys_apb_porting_p_addr(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_addr),
		.ddr4_iniu_sys_apb_porting_p_enable(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_enable),
		.ddr4_iniu_sys_apb_porting_p_rdata(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_rdata),
		.ddr4_iniu_sys_apb_porting_p_ready(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_ready),
		.ddr4_iniu_sys_apb_porting_p_sel(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_sel),
		.ddr4_iniu_sys_apb_porting_p_slverr(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_slverr),
		.ddr4_iniu_sys_apb_porting_p_wdata(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_wdata),
		.ddr4_iniu_sys_apb_porting_p_write(ddr4_iniu_ddr4_iniu_sys_apb_porting_ddr4_iniu_sys_apb_porting_p_write),
		.ddr4_iniu_sys_timeout_val_porting_timeout_val(ddr4_iniu_ddr4_iniu_sys_timeout_val_porting_ddr4_iniu_sys_timeout_val_porting_timeout_val),
		.ddr4_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr4_iniu_ddr4_iniu_sys_lp_hub_porting_ddr4_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr4_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr4_iniu_ddr4_iniu_sys_lp_hub_porting_ddr4_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ddr5_iniu ddr5_iniu (
		.clk_sys_clk(ddr5_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ddr5_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ddr5_iniu_sys_v_interrupt_porting_v_interrupt(ddr5_iniu_ddr5_iniu_sys_v_interrupt_porting_ddr5_iniu_sys_v_interrupt_porting_v_interrupt),
		.ddr5_iniu_sys_iniu_src_id_porting_iniu_src_id(ddr5_iniu_ddr5_iniu_sys_iniu_src_id_porting_ddr5_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ddr5_iniu_sys_apb_porting_p_addr(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_addr),
		.ddr5_iniu_sys_apb_porting_p_enable(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_enable),
		.ddr5_iniu_sys_apb_porting_p_rdata(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_rdata),
		.ddr5_iniu_sys_apb_porting_p_ready(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_ready),
		.ddr5_iniu_sys_apb_porting_p_sel(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_sel),
		.ddr5_iniu_sys_apb_porting_p_slverr(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_slverr),
		.ddr5_iniu_sys_apb_porting_p_wdata(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_wdata),
		.ddr5_iniu_sys_apb_porting_p_write(ddr5_iniu_ddr5_iniu_sys_apb_porting_ddr5_iniu_sys_apb_porting_p_write),
		.ddr5_iniu_sys_timeout_val_porting_timeout_val(ddr5_iniu_ddr5_iniu_sys_timeout_val_porting_ddr5_iniu_sys_timeout_val_porting_timeout_val),
		.ddr5_iniu_sys_lp_hub_porting_lp_hub_rx_req(ddr5_iniu_ddr5_iniu_sys_lp_hub_porting_ddr5_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ddr5_iniu_sys_lp_hub_porting_lp_hub_tx_req(ddr5_iniu_ddr5_iniu_sys_lp_hub_porting_ddr5_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ucie_ss0_iniu ucie_ss0_iniu (
		.clk_sys_clk(ucie_ss0_iniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ucie_ss0_iniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ucie_ss0_iniu_sys_v_interrupt_porting_v_interrupt(ucie_ss0_iniu_ucie_ss0_iniu_sys_v_interrupt_porting_ucie_ss0_iniu_sys_v_interrupt_porting_v_interrupt),
		.ucie_ss0_iniu_sys_iniu_src_id_porting_iniu_src_id(ucie_ss0_iniu_ucie_ss0_iniu_sys_iniu_src_id_porting_ucie_ss0_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.ucie_ss0_iniu_sys_apb_porting_p_addr(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_addr),
		.ucie_ss0_iniu_sys_apb_porting_p_enable(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_enable),
		.ucie_ss0_iniu_sys_apb_porting_p_rdata(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_rdata),
		.ucie_ss0_iniu_sys_apb_porting_p_ready(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_ready),
		.ucie_ss0_iniu_sys_apb_porting_p_sel(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_sel),
		.ucie_ss0_iniu_sys_apb_porting_p_slverr(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_slverr),
		.ucie_ss0_iniu_sys_apb_porting_p_wdata(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_wdata),
		.ucie_ss0_iniu_sys_apb_porting_p_write(ucie_ss0_iniu_ucie_ss0_iniu_sys_apb_porting_ucie_ss0_iniu_sys_apb_porting_p_write),
		.ucie_ss0_iniu_sys_timeout_val_porting_timeout_val(ucie_ss0_iniu_ucie_ss0_iniu_sys_timeout_val_porting_ucie_ss0_iniu_sys_timeout_val_porting_timeout_val),
		.ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_rx_req(ucie_ss0_iniu_ucie_ss0_iniu_sys_lp_hub_porting_ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_rx_req),
		.ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_tx_req(ucie_ss0_iniu_ucie_ss0_iniu_sys_lp_hub_porting_ucie_ss0_iniu_sys_lp_hub_porting_lp_hub_tx_req));
	ucie_ss0_tniu ucie_ss0_tniu (
		.clk_sys_clk(ucie_ss0_tniu_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(ucie_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(clk_noc_b),
		.rst_noc_n(rst_noc_b_n),
		.pring_in_if_pring_in_if_cw_in_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(ucie_ss0_tniu_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(cpu_ss_iniu_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_m_valid),
		.ucie_ss0_tniu_top_timeout_val_porting_timeout_val(ucie_ss0_tniu_ucie_ss0_tniu_top_timeout_val_porting_ucie_ss0_tniu_top_timeout_val_porting_timeout_val),
		.ucie_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req(ucie_ss0_tniu_ucie_ss0_tniu_top_lp_hub_porting_ucie_ss0_tniu_top_lp_hub_porting_lp_hub_rx_req),
		.ucie_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req(ucie_ss0_tniu_ucie_ss0_tniu_top_lp_hub_porting_ucie_ss0_tniu_top_lp_hub_porting_lp_hub_tx_req),
		.ucie_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id(ucie_ss0_tniu_ucie_ss0_tniu_sys_tniu_tgt_id_porting_ucie_ss0_tniu_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.ucie_ss0_tniu_sys_v_interrupt_porting_v_interrupt(ucie_ss0_tniu_ucie_ss0_tniu_sys_v_interrupt_porting_ucie_ss0_tniu_sys_v_interrupt_porting_v_interrupt),
		.ucie_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt(ucie_ss0_tniu_ucie_ss0_tniu_sys_v_merge_interrupt_porting_ucie_ss0_tniu_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.ucie_ss0_tniu_sys_apb_porting_p_addr(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_addr),
		.ucie_ss0_tniu_sys_apb_porting_p_enable(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_enable),
		.ucie_ss0_tniu_sys_apb_porting_p_rdata(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_rdata),
		.ucie_ss0_tniu_sys_apb_porting_p_ready(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_ready),
		.ucie_ss0_tniu_sys_apb_porting_p_sel(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_sel),
		.ucie_ss0_tniu_sys_apb_porting_p_slverr(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_slverr),
		.ucie_ss0_tniu_sys_apb_porting_p_wdata(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_wdata),
		.ucie_ss0_tniu_sys_apb_porting_p_write(ucie_ss0_tniu_ucie_ss0_tniu_sys_apb_porting_ucie_ss0_tniu_sys_apb_porting_p_write),
		.ucie_ss0_tniu_sys_timeout_val_porting_timeout_val(ucie_ss0_tniu_ucie_ss0_tniu_sys_timeout_val_porting_ucie_ss0_tniu_sys_timeout_val_porting_timeout_val));

endmodule
//[UHDL]Content End [md5:3293c391f5a75137458fd9aa7b2757d9]


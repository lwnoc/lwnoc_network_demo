//[UHDL]Content Start [md5:d29f7d5e8175dc1a2e270c9a15281b57]
module soc_intr_noc_wrap (
	input           clk_noc_up                                                                                                                    ,
	input           rst_noc_up_n                                                                                                                  ,
	input           clk_noc_dn                                                                                                                    ,
	input           rst_noc_dn_n                                                                                                                  ,
	input           cpu_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           cpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] cpu_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    cpu_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   cpu_ss_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           cpu_ss_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   cpu_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          cpu_ss_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           cpu_ss_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          cpu_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   cpu_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           cpu_ss_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    cpu_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          cpu_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           cpu_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           cpu_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           cpu_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [7:0]    cpu_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                           ,
	output [4095:0] cpu_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	output [127:0]  cpu_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                   ,
	input  [31:0]   cpu_ss_tniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           cpu_ss_tniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   cpu_ss_tniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          cpu_ss_tniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           cpu_ss_tniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          cpu_ss_tniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   cpu_ss_tniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           cpu_ss_tniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    cpu_ss_tniu_timeout_val_porting                                                                                               ,
	output          cpu_ss_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           cpu_ss_tniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           audio_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           audio_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [4095:0] audio_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	input  [7:0]    audio_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                         ,
	input  [31:0]   audio_ss_iniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           audio_ss_iniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   audio_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          audio_ss_iniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           audio_ss_iniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          audio_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   audio_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           audio_ss_iniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    audio_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                         ,
	output          audio_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    audio_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          audio_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           audio_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    audio_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                       ,
	input           peri_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                         ,
	input           peri_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                 ,
	input  [7:0]    peri_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                          ,
	output [4095:0] peri_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                          ,
	output [127:0]  peri_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                  ,
	input  [31:0]   peri_ss_tniu_apb_porting_apb_apb_p_addr                                                                                       ,
	input           peri_ss_tniu_apb_porting_apb_apb_p_enable                                                                                     ,
	output [31:0]   peri_ss_tniu_apb_porting_apb_apb_p_rdata                                                                                      ,
	output          peri_ss_tniu_apb_porting_apb_apb_p_ready                                                                                      ,
	input           peri_ss_tniu_apb_porting_apb_apb_p_sel                                                                                        ,
	output          peri_ss_tniu_apb_porting_apb_apb_p_slverr                                                                                     ,
	input  [31:0]   peri_ss_tniu_apb_porting_apb_apb_p_wdata                                                                                      ,
	input           peri_ss_tniu_apb_porting_apb_apb_p_write                                                                                      ,
	input  [9:0]    peri_ss_tniu_timeout_val_porting                                                                                              ,
	output          peri_ss_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                       ,
	output [1:0]    peri_ss_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                       ,
	output          peri_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                         ,
	input           peri_ss_tniu_pchannel_porting_pchannel_pchannel_preq                                                                          ,
	input  [1:0]    peri_ss_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                        ,
	input           gpu_ss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                         ,
	input           gpu_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                 ,
	input  [4095:0] gpu_ss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                          ,
	input  [7:0]    gpu_ss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                          ,
	input  [31:0]   gpu_ss1_iniu_apb_porting_apb_apb_p_addr                                                                                       ,
	input           gpu_ss1_iniu_apb_porting_apb_apb_p_enable                                                                                     ,
	output [31:0]   gpu_ss1_iniu_apb_porting_apb_apb_p_rdata                                                                                      ,
	output          gpu_ss1_iniu_apb_porting_apb_apb_p_ready                                                                                      ,
	input           gpu_ss1_iniu_apb_porting_apb_apb_p_sel                                                                                        ,
	output          gpu_ss1_iniu_apb_porting_apb_apb_p_slverr                                                                                     ,
	input  [31:0]   gpu_ss1_iniu_apb_porting_apb_apb_p_wdata                                                                                      ,
	input           gpu_ss1_iniu_apb_porting_apb_apb_p_write                                                                                      ,
	input  [9:0]    gpu_ss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                          ,
	output          gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                       ,
	output [1:0]    gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                       ,
	output          gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                         ,
	input           gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_preq                                                                          ,
	input  [1:0]    gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                        ,
	input           gpu_ss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                         ,
	input           gpu_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                 ,
	input  [7:0]    gpu_ss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                          ,
	output [4095:0] gpu_ss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                          ,
	output [127:0]  gpu_ss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                  ,
	input  [31:0]   gpu_ss0_tniu_apb_porting_apb_apb_p_addr                                                                                       ,
	input           gpu_ss0_tniu_apb_porting_apb_apb_p_enable                                                                                     ,
	output [31:0]   gpu_ss0_tniu_apb_porting_apb_apb_p_rdata                                                                                      ,
	output          gpu_ss0_tniu_apb_porting_apb_apb_p_ready                                                                                      ,
	input           gpu_ss0_tniu_apb_porting_apb_apb_p_sel                                                                                        ,
	output          gpu_ss0_tniu_apb_porting_apb_apb_p_slverr                                                                                     ,
	input  [31:0]   gpu_ss0_tniu_apb_porting_apb_apb_p_wdata                                                                                      ,
	input           gpu_ss0_tniu_apb_porting_apb_apb_p_write                                                                                      ,
	input  [9:0]    gpu_ss0_tniu_timeout_val_porting                                                                                              ,
	output          gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                       ,
	output [1:0]    gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                       ,
	output          gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                         ,
	input           gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_preq                                                                          ,
	input  [1:0]    gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                        ,
	input           display_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                      ,
	input           display_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                              ,
	input  [7:0]    display_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                       ,
	output [4095:0] display_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                       ,
	output [127:0]  display_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                               ,
	input  [31:0]   display_ss_tniu_apb_porting_apb_apb_p_addr                                                                                    ,
	input           display_ss_tniu_apb_porting_apb_apb_p_enable                                                                                  ,
	output [31:0]   display_ss_tniu_apb_porting_apb_apb_p_rdata                                                                                   ,
	output          display_ss_tniu_apb_porting_apb_apb_p_ready                                                                                   ,
	input           display_ss_tniu_apb_porting_apb_apb_p_sel                                                                                     ,
	output          display_ss_tniu_apb_porting_apb_apb_p_slverr                                                                                  ,
	input  [31:0]   display_ss_tniu_apb_porting_apb_apb_p_wdata                                                                                   ,
	input           display_ss_tniu_apb_porting_apb_apb_p_write                                                                                   ,
	input  [9:0]    display_ss_tniu_timeout_val_porting                                                                                           ,
	output          display_ss_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                    ,
	output [1:0]    display_ss_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                    ,
	output          display_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                      ,
	input           display_ss_tniu_pchannel_porting_pchannel_pchannel_preq                                                                       ,
	input  [1:0]    display_ss_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                     ,
	input           dp_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                           ,
	input           dp_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                   ,
	input  [4095:0] dp_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                            ,
	input  [7:0]    dp_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                            ,
	input  [31:0]   dp_ss_iniu_apb_porting_apb_apb_p_addr                                                                                         ,
	input           dp_ss_iniu_apb_porting_apb_apb_p_enable                                                                                       ,
	output [31:0]   dp_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                        ,
	output          dp_ss_iniu_apb_porting_apb_apb_p_ready                                                                                        ,
	input           dp_ss_iniu_apb_porting_apb_apb_p_sel                                                                                          ,
	output          dp_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                       ,
	input  [31:0]   dp_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                        ,
	input           dp_ss_iniu_apb_porting_apb_apb_p_write                                                                                        ,
	input  [9:0]    dp_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                            ,
	output          dp_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                         ,
	output [1:0]    dp_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                         ,
	output          dp_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                           ,
	input           dp_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                            ,
	input  [1:0]    dp_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                          ,
	input           ddr6_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr6_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr6_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr6_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr6_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr6_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr6_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr6_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr6_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr6_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr6_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr6_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr6_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr6_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr6_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr6_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr6_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr6_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr7_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr7_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr7_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr7_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr7_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr7_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr7_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr7_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr7_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr7_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr7_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr7_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr7_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr7_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr7_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr7_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr7_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr7_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr8_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr8_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr8_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr8_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr8_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr8_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr8_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr8_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr8_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr8_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr8_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr8_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr8_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr8_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr8_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr8_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr8_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr8_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr9_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr9_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr9_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr9_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr9_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr9_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr9_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr9_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr9_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr9_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr9_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr9_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr9_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr9_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr9_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr9_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr9_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr9_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr10_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                           ,
	input           ddr10_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                   ,
	input  [4095:0] ddr10_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                            ,
	input  [7:0]    ddr10_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                            ,
	input  [31:0]   ddr10_iniu_apb_porting_apb_apb_p_addr                                                                                         ,
	input           ddr10_iniu_apb_porting_apb_apb_p_enable                                                                                       ,
	output [31:0]   ddr10_iniu_apb_porting_apb_apb_p_rdata                                                                                        ,
	output          ddr10_iniu_apb_porting_apb_apb_p_ready                                                                                        ,
	input           ddr10_iniu_apb_porting_apb_apb_p_sel                                                                                          ,
	output          ddr10_iniu_apb_porting_apb_apb_p_slverr                                                                                       ,
	input  [31:0]   ddr10_iniu_apb_porting_apb_apb_p_wdata                                                                                        ,
	input           ddr10_iniu_apb_porting_apb_apb_p_write                                                                                        ,
	input  [9:0]    ddr10_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                            ,
	output          ddr10_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                         ,
	output [1:0]    ddr10_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                         ,
	output          ddr10_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                           ,
	input           ddr10_iniu_pchannel_porting_pchannel_pchannel_preq                                                                            ,
	input  [1:0]    ddr10_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                          ,
	input           ddr11_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                           ,
	input           ddr11_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                   ,
	input  [7:0]    ddr11_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                            ,
	output [4095:0] ddr11_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                            ,
	output [127:0]  ddr11_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                    ,
	input  [31:0]   ddr11_tniu_apb_porting_apb_apb_p_addr                                                                                         ,
	input           ddr11_tniu_apb_porting_apb_apb_p_enable                                                                                       ,
	output [31:0]   ddr11_tniu_apb_porting_apb_apb_p_rdata                                                                                        ,
	output          ddr11_tniu_apb_porting_apb_apb_p_ready                                                                                        ,
	input           ddr11_tniu_apb_porting_apb_apb_p_sel                                                                                          ,
	output          ddr11_tniu_apb_porting_apb_apb_p_slverr                                                                                       ,
	input  [31:0]   ddr11_tniu_apb_porting_apb_apb_p_wdata                                                                                        ,
	input           ddr11_tniu_apb_porting_apb_apb_p_write                                                                                        ,
	input  [9:0]    ddr11_tniu_timeout_val_porting                                                                                                ,
	output          ddr11_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                         ,
	output [1:0]    ddr11_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                         ,
	output          ddr11_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                           ,
	input           ddr11_tniu_pchannel_porting_pchannel_pchannel_preq                                                                            ,
	input  [1:0]    ddr11_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                          ,
	input           mipi_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                         ,
	input           mipi_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                 ,
	input  [4095:0] mipi_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                          ,
	input  [7:0]    mipi_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                          ,
	input  [31:0]   mipi_ss_iniu_apb_porting_apb_apb_p_addr                                                                                       ,
	input           mipi_ss_iniu_apb_porting_apb_apb_p_enable                                                                                     ,
	output [31:0]   mipi_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                      ,
	output          mipi_ss_iniu_apb_porting_apb_apb_p_ready                                                                                      ,
	input           mipi_ss_iniu_apb_porting_apb_apb_p_sel                                                                                        ,
	output          mipi_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                     ,
	input  [31:0]   mipi_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                      ,
	input           mipi_ss_iniu_apb_porting_apb_apb_p_write                                                                                      ,
	input  [9:0]    mipi_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                          ,
	output          mipi_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                       ,
	output [1:0]    mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                       ,
	output          mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                         ,
	input           mipi_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                          ,
	input  [1:0]    mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                        ,
	input           ufs_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           ufs_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] ufs_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    ufs_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   ufs_ss_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           ufs_ss_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   ufs_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          ufs_ss_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           ufs_ss_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          ufs_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   ufs_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           ufs_ss_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    ufs_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          ufs_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           ufs_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           camera_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                       ,
	input           camera_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                               ,
	input  [7:0]    camera_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                        ,
	output [4095:0] camera_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                        ,
	output [127:0]  camera_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                ,
	input  [31:0]   camera_ss_tniu_apb_porting_apb_apb_p_addr                                                                                     ,
	input           camera_ss_tniu_apb_porting_apb_apb_p_enable                                                                                   ,
	output [31:0]   camera_ss_tniu_apb_porting_apb_apb_p_rdata                                                                                    ,
	output          camera_ss_tniu_apb_porting_apb_apb_p_ready                                                                                    ,
	input           camera_ss_tniu_apb_porting_apb_apb_p_sel                                                                                      ,
	output          camera_ss_tniu_apb_porting_apb_apb_p_slverr                                                                                   ,
	input  [31:0]   camera_ss_tniu_apb_porting_apb_apb_p_wdata                                                                                    ,
	input           camera_ss_tniu_apb_porting_apb_apb_p_write                                                                                    ,
	input  [9:0]    camera_ss_tniu_timeout_val_porting                                                                                            ,
	output          camera_ss_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                     ,
	output [1:0]    camera_ss_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                     ,
	output          camera_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                       ,
	input           camera_ss_tniu_pchannel_porting_pchannel_pchannel_preq                                                                        ,
	input  [1:0]    camera_ss_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                      ,
	input           camera_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                       ,
	input           camera_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                               ,
	input  [4095:0] camera_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                        ,
	input  [7:0]    camera_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                        ,
	input  [31:0]   camera_ss_iniu_apb_porting_apb_apb_p_addr                                                                                     ,
	input           camera_ss_iniu_apb_porting_apb_apb_p_enable                                                                                   ,
	output [31:0]   camera_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                    ,
	output          camera_ss_iniu_apb_porting_apb_apb_p_ready                                                                                    ,
	input           camera_ss_iniu_apb_porting_apb_apb_p_sel                                                                                      ,
	output          camera_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                   ,
	input  [31:0]   camera_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                    ,
	input           camera_ss_iniu_apb_porting_apb_apb_p_write                                                                                    ,
	input  [9:0]    camera_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                        ,
	output          camera_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                     ,
	output [1:0]    camera_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                     ,
	output          camera_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                       ,
	input           camera_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                        ,
	input  [1:0]    camera_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                      ,
	input           pcie_eth_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                     ,
	input           pcie_eth_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                             ,
	input  [4095:0] pcie_eth_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                      ,
	input  [7:0]    pcie_eth_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                      ,
	input  [31:0]   pcie_eth_ss_iniu_apb_porting_apb_apb_p_addr                                                                                   ,
	input           pcie_eth_ss_iniu_apb_porting_apb_apb_p_enable                                                                                 ,
	output [31:0]   pcie_eth_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                  ,
	output          pcie_eth_ss_iniu_apb_porting_apb_apb_p_ready                                                                                  ,
	input           pcie_eth_ss_iniu_apb_porting_apb_apb_p_sel                                                                                    ,
	output          pcie_eth_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                 ,
	input  [31:0]   pcie_eth_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                  ,
	input           pcie_eth_ss_iniu_apb_porting_apb_apb_p_write                                                                                  ,
	input  [9:0]    pcie_eth_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                      ,
	output          pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                   ,
	output [1:0]    pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                   ,
	output          pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                     ,
	input           pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                      ,
	input  [1:0]    pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                    ,
	input           debug_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           debug_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [4095:0] debug_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	input  [7:0]    debug_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                         ,
	input  [31:0]   debug_ss_iniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           debug_ss_iniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   debug_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          debug_ss_iniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           debug_ss_iniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          debug_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   debug_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           debug_ss_iniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    debug_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                         ,
	output          debug_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    debug_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          debug_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           debug_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    debug_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                       ,
	input           aon_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           aon_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] aon_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    aon_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   aon_ss_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           aon_ss_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   aon_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          aon_ss_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           aon_ss_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          aon_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   aon_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           aon_ss_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    aon_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          aon_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    aon_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          aon_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           aon_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    aon_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           aon_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           aon_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [7:0]    aon_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                           ,
	output [4095:0] aon_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	output [127:0]  aon_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                   ,
	input  [31:0]   aon_ss_tniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           aon_ss_tniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   aon_ss_tniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          aon_ss_tniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           aon_ss_tniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          aon_ss_tniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   aon_ss_tniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           aon_ss_tniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    aon_ss_tniu_timeout_val_porting                                                                                               ,
	output          aon_ss_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    aon_ss_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          aon_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           aon_ss_tniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    aon_ss_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           ucie_ss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           ucie_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [4095:0] ucie_ss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	input  [7:0]    ucie_ss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                         ,
	input  [31:0]   ucie_ss1_iniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           ucie_ss1_iniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   ucie_ss1_iniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          ucie_ss1_iniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           ucie_ss1_iniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          ucie_ss1_iniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   ucie_ss1_iniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           ucie_ss1_iniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    ucie_ss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                         ,
	output          ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                       ,
	input           ucie_ss1_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           ucie_ss1_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [7:0]    ucie_ss1_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                         ,
	output [4095:0] ucie_ss1_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	output [127:0]  ucie_ss1_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                 ,
	input  [31:0]   ucie_ss1_tniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           ucie_ss1_tniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   ucie_ss1_tniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          ucie_ss1_tniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           ucie_ss1_tniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          ucie_ss1_tniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   ucie_ss1_tniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           ucie_ss1_tniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    ucie_ss1_tniu_timeout_val_porting                                                                                             ,
	output          ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                       ,
	input           dspss5_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss5_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] dspss5_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    dspss5_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   dspss5_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss5_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss5_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss5_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss5_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss5_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss5_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss5_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss5_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          dspss5_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss5_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss5_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss5_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss5_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last   ,
	input  [39:0]   default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload,
	input  [3:0]    default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos    ,
	output          default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready  ,
	input  [7:0]    default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid  ,
	input  [7:0]    default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid  ,
	input           default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid  ,
	input           vpu_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           vpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] vpu_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    vpu_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   vpu_ss_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           vpu_ss_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   vpu_ss_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          vpu_ss_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           vpu_ss_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          vpu_ss_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   vpu_ss_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           vpu_ss_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    vpu_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          vpu_ss_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           vpu_ss_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           dspss4_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss4_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [7:0]    dspss4_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                           ,
	output [4095:0] dspss4_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	output [127:0]  dspss4_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                   ,
	input  [31:0]   dspss4_tniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss4_tniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss4_tniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss4_tniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss4_tniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss4_tniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss4_tniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss4_tniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss4_tniu_timeout_val_porting                                                                                               ,
	output          dspss4_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss4_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss4_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss4_tniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss4_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           dspss3_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss3_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] dspss3_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    dspss3_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   dspss3_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss3_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss3_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss3_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss3_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss3_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss3_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss3_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss3_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          dspss3_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss3_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss3_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss3_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss3_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           dspss2_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss2_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [7:0]    dspss2_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                           ,
	output [4095:0] dspss2_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	output [127:0]  dspss2_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                   ,
	input  [31:0]   dspss2_tniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss2_tniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss2_tniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss2_tniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss2_tniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss2_tniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss2_tniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss2_tniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss2_tniu_timeout_val_porting                                                                                               ,
	output          dspss2_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss2_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss2_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss2_tniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss2_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           dspss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [4095:0] dspss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	input  [7:0]    dspss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                           ,
	input  [31:0]   dspss1_iniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss1_iniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss1_iniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss1_iniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss1_iniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss1_iniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss1_iniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss1_iniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                           ,
	output          dspss1_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss1_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss1_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss1_iniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss1_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           dspss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                          ,
	input           dspss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                  ,
	input  [7:0]    dspss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                           ,
	output [4095:0] dspss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                           ,
	output [127:0]  dspss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                   ,
	input  [31:0]   dspss0_tniu_apb_porting_apb_apb_p_addr                                                                                        ,
	input           dspss0_tniu_apb_porting_apb_apb_p_enable                                                                                      ,
	output [31:0]   dspss0_tniu_apb_porting_apb_apb_p_rdata                                                                                       ,
	output          dspss0_tniu_apb_porting_apb_apb_p_ready                                                                                       ,
	input           dspss0_tniu_apb_porting_apb_apb_p_sel                                                                                         ,
	output          dspss0_tniu_apb_porting_apb_apb_p_slverr                                                                                      ,
	input  [31:0]   dspss0_tniu_apb_porting_apb_apb_p_wdata                                                                                       ,
	input           dspss0_tniu_apb_porting_apb_apb_p_write                                                                                       ,
	input  [9:0]    dspss0_tniu_timeout_val_porting                                                                                               ,
	output          dspss0_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                        ,
	output [1:0]    dspss0_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                        ,
	output          dspss0_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                          ,
	input           dspss0_tniu_pchannel_porting_pchannel_pchannel_preq                                                                           ,
	input  [1:0]    dspss0_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                         ,
	input           ddr0_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr0_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr0_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr0_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr0_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr0_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr0_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr0_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr0_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr0_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr0_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr0_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr0_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr0_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr0_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr0_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr0_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr0_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr1_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr1_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr1_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr1_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr1_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr1_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr1_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr1_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr1_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr1_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr1_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr1_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr1_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr2_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr2_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr2_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr2_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr2_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr2_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr2_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr2_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr2_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr2_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr2_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr2_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr2_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr2_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr2_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr2_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr2_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr2_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr3_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr3_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr3_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr3_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr3_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr3_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr3_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr3_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr3_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr3_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr3_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr3_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr3_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr3_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr3_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr3_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr3_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr3_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr4_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr4_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr4_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr4_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr4_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr4_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr4_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr4_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr4_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr4_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr4_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr4_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr4_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr4_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr4_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr4_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr4_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr4_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ddr5_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                            ,
	input           ddr5_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                    ,
	input  [4095:0] ddr5_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                             ,
	input  [7:0]    ddr5_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                             ,
	input  [31:0]   ddr5_iniu_apb_porting_apb_apb_p_addr                                                                                          ,
	input           ddr5_iniu_apb_porting_apb_apb_p_enable                                                                                        ,
	output [31:0]   ddr5_iniu_apb_porting_apb_apb_p_rdata                                                                                         ,
	output          ddr5_iniu_apb_porting_apb_apb_p_ready                                                                                         ,
	input           ddr5_iniu_apb_porting_apb_apb_p_sel                                                                                           ,
	output          ddr5_iniu_apb_porting_apb_apb_p_slverr                                                                                        ,
	input  [31:0]   ddr5_iniu_apb_porting_apb_apb_p_wdata                                                                                         ,
	input           ddr5_iniu_apb_porting_apb_apb_p_write                                                                                         ,
	input  [9:0]    ddr5_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                             ,
	output          ddr5_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                          ,
	output [1:0]    ddr5_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                          ,
	output          ddr5_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                            ,
	input           ddr5_iniu_pchannel_porting_pchannel_pchannel_preq                                                                             ,
	input  [1:0]    ddr5_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                           ,
	input           ucie_ss0_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           ucie_ss0_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [4095:0] ucie_ss0_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	input  [7:0]    ucie_ss0_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id                                                         ,
	input  [31:0]   ucie_ss0_iniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           ucie_ss0_iniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   ucie_ss0_iniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          ucie_ss0_iniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           ucie_ss0_iniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          ucie_ss0_iniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   ucie_ss0_iniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           ucie_ss0_iniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    ucie_ss0_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val                                                         ,
	output          ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pstate                                                                       ,
	input           ucie_ss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk                                                                        ,
	input           ucie_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n                                                                ,
	input  [7:0]    ucie_ss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                                                         ,
	output [4095:0] ucie_ss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt                                                         ,
	output [127:0]  ucie_ss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt                                 ,
	input  [31:0]   ucie_ss0_tniu_apb_porting_apb_apb_p_addr                                                                                      ,
	input           ucie_ss0_tniu_apb_porting_apb_apb_p_enable                                                                                    ,
	output [31:0]   ucie_ss0_tniu_apb_porting_apb_apb_p_rdata                                                                                     ,
	output          ucie_ss0_tniu_apb_porting_apb_apb_p_ready                                                                                     ,
	input           ucie_ss0_tniu_apb_porting_apb_apb_p_sel                                                                                       ,
	output          ucie_ss0_tniu_apb_porting_apb_apb_p_slverr                                                                                    ,
	input  [31:0]   ucie_ss0_tniu_apb_porting_apb_apb_p_wdata                                                                                     ,
	input           ucie_ss0_tniu_apb_porting_apb_apb_p_write                                                                                     ,
	input  [9:0]    ucie_ss0_tniu_timeout_val_porting                                                                                             ,
	output          ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_paccept                                                                      ,
	output [1:0]    ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pactive                                                                      ,
	output          ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pdeny                                                                        ,
	input           ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_preq                                                                         ,
	input  [1:0]    ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pstate                                                                       );

	//Wire define for this module.

	//Wire define for sub module.
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last                               ;
	wire [39:0] ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload                            ;
	wire [3:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos                                ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid                              ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid                              ;
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid                              ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready                                ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready               ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last            ;
	wire [39:0] display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload         ;
	wire [3:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos             ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid           ;
	wire [7:0]  display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid           ;
	wire        display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid           ;
	wire        gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last            ;
	wire [39:0] gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload         ;
	wire [3:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos             ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid           ;
	wire [7:0]  gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid           ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid           ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready               ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                    ;
	wire [39:0] ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                 ;
	wire [3:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                     ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                   ;
	wire [7:0]  ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                   ;
	wire        ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                   ;
	wire        display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                    ;
	wire [39:0] dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                 ;
	wire [3:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                     ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                   ;
	wire [7:0]  dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                   ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                   ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                       ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                    ;
	wire [39:0] ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                 ;
	wire [3:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                     ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                   ;
	wire [7:0]  ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                   ;
	wire        ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                   ;
	wire        ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                    ;
	wire [39:0] ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                 ;
	wire [3:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                     ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                   ;
	wire [7:0]  ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                   ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                   ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                      ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire [39:0] ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [3:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire        ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire        ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                       ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                   ;
	wire [39:0] ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                ;
	wire [3:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                    ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                  ;
	wire [7:0]  ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                  ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                  ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready                                 ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last                                ;
	wire [39:0] ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload                             ;
	wire [3:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos                                 ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid                               ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid                               ;
	wire        ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid                               ;
	wire        ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                      ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last      ;
	wire [39:0] ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload   ;
	wire [3:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos       ;
	wire [7:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid     ;
	wire [7:0]  ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid     ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid     ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready       ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last    ;
	wire [39:0] mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload ;
	wire [3:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos     ;
	wire [7:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid   ;
	wire [7:0]  mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid   ;
	wire        mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid   ;
	wire        ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready         ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last                              ;
	wire [39:0] ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload                           ;
	wire [3:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos                               ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid                             ;
	wire [7:0]  ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid                             ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid                             ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                   ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                ;
	wire [39:0] ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload             ;
	wire [3:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                 ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid               ;
	wire [7:0]  ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid               ;
	wire        ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid               ;
	wire        ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready                               ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                ;
	wire [39:0] mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload             ;
	wire [3:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                 ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid               ;
	wire [7:0]  mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid               ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid               ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                 ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last              ;
	wire [39:0] camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload           ;
	wire [3:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos               ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid             ;
	wire [7:0]  camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid             ;
	wire        camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid             ;
	wire        mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                   ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last              ;
	wire [39:0] ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload           ;
	wire [3:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos               ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid             ;
	wire [7:0]  ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid             ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid             ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready              ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last           ;
	wire [39:0] camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload        ;
	wire [3:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos            ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid          ;
	wire [7:0]  camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid          ;
	wire        camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid          ;
	wire        ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                 ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last           ;
	wire [39:0] camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload        ;
	wire [3:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos            ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid          ;
	wire [7:0]  camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid          ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid          ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready            ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last         ;
	wire [39:0] pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload      ;
	wire [3:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos          ;
	wire [7:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid        ;
	wire [7:0]  pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid        ;
	wire        pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid        ;
	wire        camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready              ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last         ;
	wire [39:0] camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload      ;
	wire [3:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos          ;
	wire [7:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid        ;
	wire [7:0]  camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid        ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid        ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready             ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last          ;
	wire [39:0] debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload       ;
	wire [3:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos           ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid         ;
	wire [7:0]  debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid         ;
	wire        debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid         ;
	wire        camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready            ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last          ;
	wire [39:0] pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid         ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid         ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready             ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last             ;
	wire [39:0] ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid            ;
	wire        ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid            ;
	wire        aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last             ;
	wire [39:0] ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid            ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid            ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                  ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last               ;
	wire [39:0] dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload            ;
	wire [3:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid              ;
	wire [7:0]  dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid              ;
	wire        dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid              ;
	wire        ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last               ;
	wire [39:0] ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload            ;
	wire [3:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid              ;
	wire [7:0]  ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid              ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid              ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready                         ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last                       ;
	wire [39:0] default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload                    ;
	wire [3:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos                        ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid                      ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid                      ;
	wire        default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid                      ;
	wire        ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                  ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last          ;
	wire [39:0] dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload       ;
	wire [3:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos           ;
	wire [7:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid         ;
	wire [7:0]  dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid         ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid         ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready                                                   ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last                                                   ;
	wire [39:0] dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload                                                ;
	wire [3:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos                                                    ;
	wire [7:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid                                                  ;
	wire [7:0]  dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid                                                  ;
	wire        dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid                                                  ;
	wire        dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready             ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid                        ;
	wire [39:0] default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload                      ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid                        ;
	wire [7:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid                        ;
	wire [3:0]  default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos                          ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last                         ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                      ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire [39:0] vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [7:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire [3:0]  vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire        vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire        default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready                           ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last                                                          ;
	wire [39:0] dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload                                                       ;
	wire [3:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos                                                           ;
	wire [7:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid                                                         ;
	wire [7:0]  dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid                                                         ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid                                                         ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready                                                          ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                      ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                   ;
	wire [39:0] ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                ;
	wire [3:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                    ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                  ;
	wire [7:0]  ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                  ;
	wire        ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                  ;
	wire        dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                   ;
	wire [39:0] dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                ;
	wire [3:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                    ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                  ;
	wire [7:0]  dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                  ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                  ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                      ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                        ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                     ;
	wire [39:0] ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                  ;
	wire [3:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                      ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                    ;
	wire [7:0]  ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                    ;
	wire        ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                    ;
	wire        ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                     ;
	wire [39:0] ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                  ;
	wire [3:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                      ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                    ;
	wire [7:0]  ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                    ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                    ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                    ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                 ;
	wire [39:0] ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload              ;
	wire [3:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                  ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                ;
	wire [7:0]  ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                ;
	wire        ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                ;
	wire        ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                        ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                 ;
	wire [39:0] ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload              ;
	wire [3:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                  ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                ;
	wire [7:0]  ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last             ;
	wire [39:0] ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload          ;
	wire [3:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos              ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid            ;
	wire [7:0]  ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid            ;
	wire        ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid            ;
	wire        ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                    ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last             ;
	wire [39:0] ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload          ;
	wire [3:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos              ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid            ;
	wire [7:0]  ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid            ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid            ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready                              ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last                             ;
	wire [39:0] ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload                          ;
	wire [3:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos                              ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid                            ;
	wire [7:0]  ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid                            ;
	wire        ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid                            ;
	wire        ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last   ;
	wire [39:0] ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload;
	wire [3:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos    ;
	wire [7:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid  ;
	wire [7:0]  ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid  ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid  ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready        ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last     ;
	wire [39:0] cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload  ;
	wire [3:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos      ;
	wire [7:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid    ;
	wire [7:0]  cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid    ;
	wire        cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid    ;
	wire        ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready      ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_iniu cpu_ss_iniu (
		.clk_sys_clk_sys_func_clk(cpu_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(cpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(cpu_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(cpu_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(cpu_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(cpu_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(cpu_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(cpu_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(cpu_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(cpu_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(cpu_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(cpu_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(cpu_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(cpu_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(cpu_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(cpu_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	cpu_ss_tniu cpu_ss_tniu (
		.clk_sys_clk_sys_func_clk(cpu_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(cpu_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(cpu_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(cpu_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(cpu_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(cpu_ss_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(cpu_ss_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(cpu_ss_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(cpu_ss_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(cpu_ss_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(cpu_ss_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(cpu_ss_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(cpu_ss_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(cpu_ss_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(cpu_ss_iniu_TO_cpu_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(cpu_ss_tniu_TO_cpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(cpu_ss_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(cpu_ss_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(cpu_ss_tniu_pchannel_porting_pchannel_pchannel_pstate));
	audio_ss_iniu audio_ss_iniu (
		.clk_sys_clk_sys_func_clk(audio_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(audio_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(audio_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(audio_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(audio_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(audio_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(audio_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(audio_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(audio_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(audio_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(audio_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(audio_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(audio_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(audio_ss_iniu_TO_cpu_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(cpu_ss_tniu_TO_audio_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(cpu_ss_tniu_TO_audio_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(audio_ss_iniu_TO_cpu_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(audio_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(audio_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(audio_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(audio_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(audio_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	peri_ss_tniu peri_ss_tniu (
		.clk_sys_clk_sys_func_clk(peri_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(peri_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(peri_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(peri_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(peri_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(peri_ss_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(peri_ss_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(peri_ss_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(peri_ss_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(peri_ss_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(peri_ss_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(peri_ss_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(peri_ss_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(peri_ss_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(peri_ss_tniu_TO_audio_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(audio_ss_iniu_TO_peri_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(audio_ss_iniu_TO_peri_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(peri_ss_tniu_TO_audio_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(peri_ss_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(peri_ss_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(peri_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(peri_ss_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(peri_ss_tniu_pchannel_porting_pchannel_pchannel_pstate));
	gpu_ss1_iniu gpu_ss1_iniu (
		.clk_sys_clk_sys_func_clk(gpu_ss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(gpu_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(gpu_ss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(gpu_ss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(gpu_ss1_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(gpu_ss1_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(gpu_ss1_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(gpu_ss1_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(gpu_ss1_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(gpu_ss1_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(gpu_ss1_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(gpu_ss1_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(gpu_ss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(peri_ss_tniu_TO_gpu_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(gpu_ss1_iniu_TO_peri_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(gpu_ss1_iniu_pchannel_porting_pchannel_pchannel_pstate));
	gpu_ss0_tniu gpu_ss0_tniu (
		.clk_sys_clk_sys_func_clk(gpu_ss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(gpu_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(gpu_ss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(gpu_ss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(gpu_ss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(gpu_ss0_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(gpu_ss0_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(gpu_ss0_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(gpu_ss0_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(gpu_ss0_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(gpu_ss0_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(gpu_ss0_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(gpu_ss0_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(gpu_ss0_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(gpu_ss1_iniu_TO_gpu_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(gpu_ss0_tniu_TO_gpu_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(gpu_ss0_tniu_pchannel_porting_pchannel_pchannel_pstate));
	display_ss_tniu display_ss_tniu (
		.clk_sys_clk_sys_func_clk(display_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(display_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(display_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(display_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(display_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(display_ss_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(display_ss_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(display_ss_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(display_ss_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(display_ss_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(display_ss_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(display_ss_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(display_ss_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(display_ss_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(display_ss_tniu_TO_gpu_ss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(gpu_ss0_tniu_TO_display_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(gpu_ss0_tniu_TO_display_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(display_ss_tniu_TO_gpu_ss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(display_ss_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(display_ss_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(display_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(display_ss_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(display_ss_tniu_pchannel_porting_pchannel_pchannel_pstate));
	dp_ss_iniu dp_ss_iniu (
		.clk_sys_clk_sys_func_clk(dp_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dp_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(dp_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(dp_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(dp_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dp_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dp_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dp_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dp_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dp_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dp_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dp_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(dp_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dp_ss_iniu_TO_display_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(display_ss_tniu_TO_dp_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(display_ss_tniu_TO_dp_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dp_ss_iniu_TO_display_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dp_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dp_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dp_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dp_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dp_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr6_iniu ddr6_iniu (
		.clk_sys_clk_sys_func_clk(ddr6_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr6_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr6_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr6_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr6_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr6_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr6_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr6_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr6_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr6_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr6_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr6_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr6_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr6_iniu_TO_dp_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dp_ss_iniu_TO_ddr6_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dp_ss_iniu_TO_ddr6_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr6_iniu_TO_dp_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr6_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr6_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr6_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr6_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr6_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr7_iniu ddr7_iniu (
		.clk_sys_clk_sys_func_clk(ddr7_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr7_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr7_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr7_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr7_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr7_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr7_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr7_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr7_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr7_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr7_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr7_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr7_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr7_iniu_TO_ddr6_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr6_iniu_TO_ddr7_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr6_iniu_TO_ddr7_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr7_iniu_TO_ddr6_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr7_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr7_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr7_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr7_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr7_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr8_iniu ddr8_iniu (
		.clk_sys_clk_sys_func_clk(ddr8_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr8_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr8_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr8_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr8_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr8_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr8_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr8_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr8_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr8_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr8_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr8_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr8_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr8_iniu_TO_ddr7_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr7_iniu_TO_ddr8_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr7_iniu_TO_ddr8_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr8_iniu_TO_ddr7_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr8_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr8_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr8_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr8_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr8_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr9_iniu ddr9_iniu (
		.clk_sys_clk_sys_func_clk(ddr9_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr9_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr9_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr9_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr9_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr9_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr9_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr9_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr9_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr9_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr9_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr9_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr9_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr9_iniu_TO_ddr8_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr8_iniu_TO_ddr9_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr8_iniu_TO_ddr9_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr9_iniu_TO_ddr8_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr9_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr9_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr9_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr9_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr9_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr10_iniu ddr10_iniu (
		.clk_sys_clk_sys_func_clk(ddr10_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr10_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr10_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr10_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr10_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr10_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr10_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr10_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr10_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr10_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr10_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr10_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr10_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr10_iniu_TO_ddr9_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr9_iniu_TO_ddr10_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr9_iniu_TO_ddr10_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr10_iniu_TO_ddr9_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr10_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr10_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr10_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr10_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr10_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr11_tniu ddr11_tniu (
		.clk_sys_clk_sys_func_clk(ddr11_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr11_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_up),
		.rst_noc_n(rst_noc_up_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(ddr11_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(ddr11_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(ddr11_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(ddr11_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr11_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr11_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr11_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr11_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr11_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr11_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr11_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(ddr11_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr11_tniu_TO_ddr10_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr10_iniu_TO_ddr11_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr10_iniu_TO_ddr11_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr11_tniu_TO_ddr10_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr11_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr11_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr11_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr11_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr11_tniu_pchannel_porting_pchannel_pchannel_pstate));
	ring_async_cut_up_to_dn ring_async_cut_up_to_dn (
		.clk_src_clk_slv(clk_noc_up),
		.rst_src_n_rst_slv_n(rst_noc_up_n),
		.clk_dst_clk_mst(clk_noc_dn),
		.rst_dst_n_rst_mst_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_last(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(ddr11_tniu_TO_ring_async_cut_up_to_dn_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(ring_async_cut_up_to_dn_TO_ddr11_tniu_SIG_nring_out_if_nring_out_if_valid));
	mipi_ss_iniu mipi_ss_iniu (
		.clk_sys_clk_sys_func_clk(mipi_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(mipi_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(mipi_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(mipi_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(mipi_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(mipi_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(mipi_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(mipi_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(mipi_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(mipi_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(mipi_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(mipi_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(mipi_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ring_async_cut_up_to_dn_TO_mipi_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(mipi_ss_iniu_TO_ring_async_cut_up_to_dn_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(mipi_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(mipi_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(mipi_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ufs_ss_iniu ufs_ss_iniu (
		.clk_sys_clk_sys_func_clk(ufs_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ufs_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ufs_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ufs_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ufs_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ufs_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ufs_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ufs_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ufs_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ufs_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ufs_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ufs_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ufs_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(mipi_ss_iniu_TO_ufs_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ufs_ss_iniu_TO_mipi_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ufs_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ufs_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ufs_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	camera_ss_tniu camera_ss_tniu (
		.clk_sys_clk_sys_func_clk(camera_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(camera_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(camera_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(camera_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(camera_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(camera_ss_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(camera_ss_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(camera_ss_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(camera_ss_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(camera_ss_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(camera_ss_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(camera_ss_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(camera_ss_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(camera_ss_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(camera_ss_tniu_TO_ufs_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ufs_ss_iniu_TO_camera_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ufs_ss_iniu_TO_camera_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(camera_ss_tniu_TO_ufs_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(camera_ss_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(camera_ss_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(camera_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(camera_ss_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(camera_ss_tniu_pchannel_porting_pchannel_pchannel_pstate));
	camera_ss_iniu camera_ss_iniu (
		.clk_sys_clk_sys_func_clk(camera_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(camera_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(camera_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(camera_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(camera_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(camera_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(camera_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(camera_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(camera_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(camera_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(camera_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(camera_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(camera_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(camera_ss_iniu_TO_camera_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(camera_ss_tniu_TO_camera_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(camera_ss_tniu_TO_camera_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(camera_ss_iniu_TO_camera_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(camera_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(camera_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(camera_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(camera_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(camera_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	pcie_eth_ss_iniu pcie_eth_ss_iniu (
		.clk_sys_clk_sys_func_clk(pcie_eth_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(pcie_eth_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(pcie_eth_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(pcie_eth_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(pcie_eth_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(pcie_eth_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(pcie_eth_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(pcie_eth_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(pcie_eth_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(pcie_eth_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(pcie_eth_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(pcie_eth_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(pcie_eth_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(camera_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(pcie_eth_ss_iniu_TO_camera_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(pcie_eth_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	debug_ss_iniu debug_ss_iniu (
		.clk_sys_clk_sys_func_clk(debug_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(debug_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(debug_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(debug_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(debug_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(debug_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(debug_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(debug_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(debug_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(debug_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(debug_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(debug_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(debug_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(pcie_eth_ss_iniu_TO_debug_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(debug_ss_iniu_TO_pcie_eth_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(debug_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(debug_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(debug_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(debug_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(debug_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	aon_ss_iniu aon_ss_iniu (
		.clk_sys_clk_sys_func_clk(aon_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(aon_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(aon_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(aon_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(aon_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(aon_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(aon_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(aon_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(aon_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(aon_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(aon_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(aon_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(aon_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(aon_ss_iniu_TO_debug_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(debug_ss_iniu_TO_aon_ss_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(debug_ss_iniu_TO_aon_ss_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(aon_ss_iniu_TO_debug_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(aon_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(aon_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(aon_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(aon_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(aon_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	aon_ss_tniu aon_ss_tniu (
		.clk_sys_clk_sys_func_clk(aon_ss_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(aon_ss_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(aon_ss_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(aon_ss_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(aon_ss_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(aon_ss_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(aon_ss_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(aon_ss_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(aon_ss_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(aon_ss_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(aon_ss_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(aon_ss_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(aon_ss_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(aon_ss_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(aon_ss_tniu_TO_aon_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(aon_ss_iniu_TO_aon_ss_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(aon_ss_iniu_TO_aon_ss_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(aon_ss_tniu_TO_aon_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(aon_ss_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(aon_ss_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(aon_ss_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(aon_ss_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(aon_ss_tniu_pchannel_porting_pchannel_pchannel_pstate));
	ucie_ss1_iniu ucie_ss1_iniu (
		.clk_sys_clk_sys_func_clk(ucie_ss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ucie_ss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ucie_ss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ucie_ss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ucie_ss1_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ucie_ss1_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ucie_ss1_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ucie_ss1_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ucie_ss1_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ucie_ss1_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ucie_ss1_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ucie_ss1_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ucie_ss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(aon_ss_tniu_TO_ucie_ss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss1_iniu_TO_aon_ss_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ucie_ss1_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ucie_ss1_tniu ucie_ss1_tniu (
		.clk_sys_clk_sys_func_clk(ucie_ss1_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ucie_ss1_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(ucie_ss1_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(ucie_ss1_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(ucie_ss1_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(ucie_ss1_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ucie_ss1_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ucie_ss1_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ucie_ss1_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ucie_ss1_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ucie_ss1_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ucie_ss1_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ucie_ss1_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(ucie_ss1_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss1_iniu_TO_ucie_ss1_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss1_tniu_TO_ucie_ss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ucie_ss1_tniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss5_iniu dspss5_iniu (
		.clk_sys_clk_sys_func_clk(dspss5_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss5_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(dspss5_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(dspss5_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(dspss5_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss5_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss5_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss5_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss5_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss5_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss5_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss5_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(dspss5_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss5_iniu_TO_ucie_ss1_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss1_tniu_TO_dspss5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss1_tniu_TO_dspss5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss5_iniu_TO_ucie_ss1_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss5_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss5_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss5_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss5_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss5_iniu_pchannel_porting_pchannel_pchannel_pstate));
	default_tgtid_sink default_tgtid_sink (
		.clk(clk_noc_dn),
		.rst_n(rst_noc_dn_n),
		.pring_in_if_pring_in_if_pring_in_if_last(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(default_tgtid_sink_TO_dspss5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(dspss5_iniu_TO_default_tgtid_sink_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(dspss5_iniu_TO_default_tgtid_sink_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(default_tgtid_sink_TO_dspss5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_valid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_last),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_payload),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_qos),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_ready),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_srcid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_tgtid),
		.default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid(default_tgtid_sink_default_tgtid_sink_ring_local_tx_porting_default_tgtid_sink_ring_local_tx_porting_local_tx_local_tx_valid));
	lwnoc_intr_ring_sp_wrap #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.THRESHOLD_EN(1'b1),
		.SINGLE_THR_WIDTH(32'd1),
		.NODE_NUM(32'd39))
	dspss5_sp (
		.clk(clk_noc_dn),
		.pring_in_if_valid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_in_if_ready(dspss5_sp_TO_default_tgtid_sink_SIG_pring_in_if_ready),
		.pring_in_if_payload(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_srcid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_tgtid(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_qos(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_last(default_tgtid_sink_TO_dspss5_sp_SIG_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_valid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_ready(vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_payload(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_out_if_srcid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_out_if_tgtid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_out_if_qos(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_out_if_last(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last),
		.nring_in_if_valid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_in_if_ready(dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_in_if_payload(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_srcid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_tgtid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_qos(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_last(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_valid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_valid),
		.nring_out_if_ready(default_tgtid_sink_TO_dspss5_sp_SIG_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_payload(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_payload),
		.nring_out_if_srcid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_srcid),
		.nring_out_if_tgtid(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_tgtid),
		.nring_out_if_qos(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_qos),
		.nring_out_if_last(dspss5_sp_TO_default_tgtid_sink_SIG_nring_out_if_last));
	vpu_ss_iniu vpu_ss_iniu (
		.clk_sys_clk_sys_func_clk(vpu_ss_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(vpu_ss_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(vpu_ss_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(vpu_ss_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(vpu_ss_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(vpu_ss_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(vpu_ss_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(vpu_ss_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(vpu_ss_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(vpu_ss_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(vpu_ss_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(vpu_ss_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(vpu_ss_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(vpu_ss_iniu_TO_dspss5_sp_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss5_sp_TO_vpu_ss_iniu_SIG_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss5_sp_TO_vpu_ss_iniu_SIG_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(vpu_ss_iniu_TO_dspss5_sp_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(vpu_ss_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(vpu_ss_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(vpu_ss_iniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss4_tniu dspss4_tniu (
		.clk_sys_clk_sys_func_clk(dspss4_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss4_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(dspss4_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(dspss4_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(dspss4_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(dspss4_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss4_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss4_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss4_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss4_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss4_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss4_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss4_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(dspss4_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss4_tniu_TO_vpu_ss_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(vpu_ss_iniu_TO_dspss4_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(vpu_ss_iniu_TO_dspss4_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss4_tniu_TO_vpu_ss_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss4_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss4_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss4_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss4_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss4_tniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss3_iniu dspss3_iniu (
		.clk_sys_clk_sys_func_clk(dspss3_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss3_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(dspss3_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(dspss3_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(dspss3_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss3_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss3_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss3_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss3_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss3_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss3_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss3_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(dspss3_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss3_iniu_TO_dspss4_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss4_tniu_TO_dspss3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss4_tniu_TO_dspss3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss3_iniu_TO_dspss4_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss3_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss3_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss3_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss3_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss3_iniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss2_tniu dspss2_tniu (
		.clk_sys_clk_sys_func_clk(dspss2_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss2_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(dspss2_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(dspss2_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(dspss2_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(dspss2_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss2_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss2_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss2_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss2_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss2_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss2_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss2_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(dspss2_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss2_tniu_TO_dspss3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss3_iniu_TO_dspss2_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss3_iniu_TO_dspss2_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss2_tniu_TO_dspss3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss2_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss2_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss2_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss2_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss2_tniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss1_iniu dspss1_iniu (
		.clk_sys_clk_sys_func_clk(dspss1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(dspss1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(dspss1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(dspss1_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss1_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss1_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss1_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss1_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss1_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss1_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss1_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(dspss1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss1_iniu_TO_dspss2_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss2_tniu_TO_dspss1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss2_tniu_TO_dspss1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss1_iniu_TO_dspss2_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss1_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss1_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss1_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss1_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss1_iniu_pchannel_porting_pchannel_pchannel_pstate));
	dspss0_tniu dspss0_tniu (
		.clk_sys_clk_sys_func_clk(dspss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(dspss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(dspss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(dspss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(dspss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(dspss0_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(dspss0_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(dspss0_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(dspss0_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(dspss0_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(dspss0_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(dspss0_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(dspss0_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(dspss0_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(dspss0_tniu_TO_dspss1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss1_iniu_TO_dspss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss1_iniu_TO_dspss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(dspss0_tniu_TO_dspss1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(dspss0_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(dspss0_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(dspss0_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(dspss0_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(dspss0_tniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr0_iniu ddr0_iniu (
		.clk_sys_clk_sys_func_clk(ddr0_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr0_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr0_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr0_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr0_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr0_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr0_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr0_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr0_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr0_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr0_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr0_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr0_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr0_iniu_TO_dspss0_tniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(dspss0_tniu_TO_ddr0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(dspss0_tniu_TO_ddr0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr0_iniu_TO_dspss0_tniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr0_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr0_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr0_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr0_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr0_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr1_iniu ddr1_iniu (
		.clk_sys_clk_sys_func_clk(ddr1_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr1_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr1_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr1_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr1_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr1_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr1_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr1_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr1_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr1_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr1_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr1_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr1_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr1_iniu_TO_ddr0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr0_iniu_TO_ddr1_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr0_iniu_TO_ddr1_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr1_iniu_TO_ddr0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr1_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr1_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr1_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr1_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr1_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr2_iniu ddr2_iniu (
		.clk_sys_clk_sys_func_clk(ddr2_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr2_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr2_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr2_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr2_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr2_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr2_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr2_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr2_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr2_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr2_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr2_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr2_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr2_iniu_TO_ddr1_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr1_iniu_TO_ddr2_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr1_iniu_TO_ddr2_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr2_iniu_TO_ddr1_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr2_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr2_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr2_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr2_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr2_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr3_iniu ddr3_iniu (
		.clk_sys_clk_sys_func_clk(ddr3_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr3_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr3_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr3_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr3_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr3_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr3_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr3_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr3_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr3_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr3_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr3_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr3_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr3_iniu_TO_ddr2_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr2_iniu_TO_ddr3_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr2_iniu_TO_ddr3_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr3_iniu_TO_ddr2_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr3_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr3_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr3_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr3_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr3_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr4_iniu ddr4_iniu (
		.clk_sys_clk_sys_func_clk(ddr4_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr4_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr4_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr4_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr4_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr4_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr4_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr4_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr4_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr4_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr4_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr4_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr4_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr4_iniu_TO_ddr3_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr3_iniu_TO_ddr4_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr3_iniu_TO_ddr4_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr4_iniu_TO_ddr3_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr4_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr4_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr4_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr4_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr4_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ddr5_iniu ddr5_iniu (
		.clk_sys_clk_sys_func_clk(ddr5_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ddr5_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ddr5_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ddr5_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ddr5_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ddr5_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ddr5_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ddr5_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ddr5_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ddr5_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ddr5_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ddr5_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ddr5_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ddr5_iniu_TO_ddr4_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr4_iniu_TO_ddr5_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr4_iniu_TO_ddr5_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ddr5_iniu_TO_ddr4_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ddr5_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ddr5_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ddr5_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ddr5_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ddr5_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ucie_ss0_iniu ucie_ss0_iniu (
		.clk_sys_clk_sys_func_clk(ucie_ss0_iniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ucie_ss0_iniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.v_interrupt_v_interrupt_v_interrupt(ucie_ss0_iniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id_iniu_src_id(ucie_ss0_iniu_iniu_src_id_porting_iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_apb_p_addr(ucie_ss0_iniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ucie_ss0_iniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ucie_ss0_iniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ucie_ss0_iniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ucie_ss0_iniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ucie_ss0_iniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ucie_ss0_iniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ucie_ss0_iniu_apb_porting_apb_apb_p_write),
		.timeout_val_timeout_val_timeout_val(ucie_ss0_iniu_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss0_iniu_TO_ddr5_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ddr5_iniu_TO_ucie_ss0_iniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ddr5_iniu_TO_ucie_ss0_iniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss0_iniu_TO_ddr5_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ucie_ss0_iniu_pchannel_porting_pchannel_pchannel_pstate));
	ucie_ss0_tniu ucie_ss0_tniu (
		.clk_sys_clk_sys_func_clk(ucie_ss0_tniu_clk_sys_porting_clk_sys_clk_sys_func_clk),
		.rst_sys_n_rst_sys_func_n_rst_n(ucie_ss0_tniu_rst_sys_n_porting_rst_sys_n_rst_sys_func_n_rst_n),
		.clk_noc(clk_noc_dn),
		.rst_noc_n(rst_noc_dn_n),
		.tniu_tgt_id_tniu_tgt_id_tniu_tgt_id(ucie_ss0_tniu_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt_v_interrupt(ucie_ss0_tniu_v_interrupt_porting_v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt_v_merge_interrupt(ucie_ss0_tniu_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_apb_p_addr(ucie_ss0_tniu_apb_porting_apb_apb_p_addr),
		.apb_apb_p_enable(ucie_ss0_tniu_apb_porting_apb_apb_p_enable),
		.apb_apb_p_rdata(ucie_ss0_tniu_apb_porting_apb_apb_p_rdata),
		.apb_apb_p_ready(ucie_ss0_tniu_apb_porting_apb_apb_p_ready),
		.apb_apb_p_sel(ucie_ss0_tniu_apb_porting_apb_apb_p_sel),
		.apb_apb_p_slverr(ucie_ss0_tniu_apb_porting_apb_apb_p_slverr),
		.apb_apb_p_wdata(ucie_ss0_tniu_apb_porting_apb_apb_p_wdata),
		.apb_apb_p_write(ucie_ss0_tniu_apb_porting_apb_apb_p_write),
		.timeout_val(ucie_ss0_tniu_timeout_val_porting),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_last(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_last(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_last(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_last(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready(ucie_ss0_iniu_TO_ucie_ss0_tniu_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid(ucie_ss0_tniu_TO_ucie_ss0_iniu_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.pchannel_pchannel_paccept(ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_paccept),
		.pchannel_pchannel_pactive(ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pactive),
		.pchannel_pchannel_pdeny(ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pdeny),
		.pchannel_pchannel_preq(ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_preq),
		.pchannel_pchannel_pstate(ucie_ss0_tniu_pchannel_porting_pchannel_pchannel_pstate));
	ring_async_cut_dn_to_up ring_async_cut_dn_to_up (
		.clk_src_clk_slv(clk_noc_dn),
		.rst_src_n_rst_slv_n(rst_noc_dn_n),
		.clk_dst_clk_mst(clk_noc_up),
		.rst_dst_n_rst_mst_n(rst_noc_up_n),
		.pring_in_if_pring_in_if_last(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_in_if_pring_in_if_payload(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_in_if_pring_in_if_qos(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_in_if_pring_in_if_ready(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_in_if_pring_in_if_tgtid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_in_if_pring_in_if_valid(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.pring_out_if_pring_out_if_last(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_out_if_pring_out_if_srcid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_in_if_nring_in_if_payload(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_in_if_nring_in_if_qos(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_in_if_nring_in_if_ready(ring_async_cut_dn_to_up_TO_cpu_ss_iniu_SIG_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_in_if_nring_in_if_tgtid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_in_if_nring_in_if_valid(cpu_ss_iniu_TO_ring_async_cut_dn_to_up_SIG_nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.nring_out_if_nring_out_if_last(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(ucie_ss0_tniu_TO_ring_async_cut_dn_to_up_SIG_nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_out_if_nring_out_if_srcid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(ring_async_cut_dn_to_up_TO_ucie_ss0_tniu_SIG_nring_out_if_nring_out_if_valid));

endmodule
//[UHDL]Content End [md5:d29f7d5e8175dc1a2e270c9a15281b57]


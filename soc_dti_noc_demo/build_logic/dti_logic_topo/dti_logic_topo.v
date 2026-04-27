//[UHDL]Content Start [md5:ef1fcfd22b9d76072bed681c63d85a81]
module dti_logic_topo
	import lwnoc_lp_define_package::*;
	(
	input                                                   clk_noc                                                                  ,
	input                                                   rst_noc_n                                                                ,
	input                                                   clk_noc_up                                                               ,
	input                                                   rst_noc_up_n                                                             ,
	output                                                  dti_buffer_ctrl_porting_almost_empty                                     ,
	output                                                  dti_buffer_ctrl_porting_almost_full                                      ,
	input                                                   dti_buffer_ctrl_porting_clear                                            ,
	output                                                  dti_buffer_ctrl_porting_empty                                            ,
	output                                                  dti_buffer_ctrl_porting_full                                             ,
	output                                                  dti_buffer_ctrl_porting_idle                                             ,
	input                                                   dti_buffer_ctrl_porting_stall                                            ,
	input                                                   dsp0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dsp1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dsp2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dsp3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dsp4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dsp5_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   dsp5_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   dsp5_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  dsp5_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            dsp5_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   cpu_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   cpu_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   cpu_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  cpu_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            cpu_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   pcie_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   pcie_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   pcie_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  pcie_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            pcie_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   ufs_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   ufs_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   ufs_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  ufs_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            ufs_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   camera_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                     ,
	input                                                   camera_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n             ,
	input  [79:0]                                           camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata               ,
	input  [9:0]                                            camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep               ,
	input                                                   camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast               ,
	output                                                  camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tready              ,
	input  [5:0]                                            camera_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                ,
	input                                                   camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid              ,
	output [79:0]                                           camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata               ,
	output [9:0]                                            camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep               ,
	output                                                  camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast               ,
	input                                                   camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready              ,
	output [5:0]                                            camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                ,
	output                                                  camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid              ,
	input                                                   camera_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup ,
	output                                                  camera_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup ,
	input  [9:0]                                            camera_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val ,
	output                                                  camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept        ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive        ,
	output                                                  camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny          ,
	input                                                   camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq           ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate         ,
	input                                                   mipi_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   mipi_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   mipi_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  mipi_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            mipi_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   gpu0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   gpu0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   gpu0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  gpu0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            gpu0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   gpu1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                       ,
	input                                                   gpu1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n               ,
	input  [79:0]                                           gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                 ,
	input  [9:0]                                            gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                 ,
	input                                                   gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                 ,
	output                                                  gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                ,
	input  [5:0]                                            gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                  ,
	input                                                   gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                ,
	output [79:0]                                           gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                 ,
	output [9:0]                                            gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                 ,
	output                                                  gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                 ,
	input                                                   gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                ,
	output [5:0]                                            gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                  ,
	output                                                  gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                ,
	input                                                   gpu1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup   ,
	output                                                  gpu1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup   ,
	input  [9:0]                                            gpu1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val   ,
	output                                                  gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept          ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive          ,
	output                                                  gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny            ,
	input                                                   gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq             ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate           ,
	input                                                   dp_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                         ,
	input                                                   dp_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                 ,
	input  [79:0]                                           dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                   ,
	input  [9:0]                                            dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                   ,
	input                                                   dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                   ,
	output                                                  dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                  ,
	input  [5:0]                                            dp_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                    ,
	input                                                   dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                  ,
	output [79:0]                                           dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                   ,
	output [9:0]                                            dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                   ,
	output                                                  dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                   ,
	input                                                   dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                  ,
	output [5:0]                                            dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                    ,
	output                                                  dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                  ,
	input                                                   dp_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup     ,
	output                                                  dp_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup     ,
	input  [9:0]                                            dp_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val     ,
	output                                                  dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept            ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive            ,
	output                                                  dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny              ,
	input                                                   dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq               ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate             ,
	input                                                   display_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                    ,
	input                                                   display_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n            ,
	input  [79:0]                                           display_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata              ,
	input  [9:0]                                            display_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep              ,
	input                                                   display_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast              ,
	output                                                  display_iniu_node_dti_req_porting_dti_req_dti_req_req_tready             ,
	input  [5:0]                                            display_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid               ,
	input                                                   display_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid             ,
	output [79:0]                                           display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata              ,
	output [9:0]                                            display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep              ,
	output                                                  display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast              ,
	input                                                   display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready             ,
	output [5:0]                                            display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid               ,
	output                                                  display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid             ,
	input                                                   display_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup,
	output                                                  display_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup,
	input  [9:0]                                            display_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val,
	output                                                  display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept       ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive       ,
	output                                                  display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny         ,
	input                                                   display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq          ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate        ,
	input                                                   tcu_tniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	output [79:0]                                           tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	output [9:0]                                            tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	output                                                  tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	input                                                   tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	output [5:0]                                            tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	output                                                  tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	input  [79:0]                                           tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	input  [9:0]                                            tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	input                                                   tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	output                                                  tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	input  [5:0]                                            tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	input                                                   tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	output                                                  tcu_tniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	input                                                   tcu_tniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	output                                                  tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output lwnoc_lp_define_package::lwnoc_pchannel_active_t tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input  lwnoc_lp_define_package::lwnoc_pchannel_state_t  tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            );

	//Wire define for this module.

	//Wire define for sub module.
	wire        dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_valid             ;
	wire [89:0] dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_payload           ;
	wire        dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_last              ;
	wire [5:0]  dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid             ;
	wire        dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_qos               ;
	wire        dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        sw3_TO_sw0_SIG_iniu0_req_ready                             ;
	wire        sw3_TO_sw0_SIG_iniu0_req_threshold                         ;
	wire        sw3_TO_sw0_SIG_iniu0_rsp_valid                             ;
	wire [89:0] sw3_TO_sw0_SIG_iniu0_rsp_payload                           ;
	wire [5:0]  sw3_TO_sw0_SIG_iniu0_rsp_srcid                             ;
	wire [5:0]  sw3_TO_sw0_SIG_iniu0_rsp_tgtid                             ;
	wire        sw3_TO_sw0_SIG_iniu0_rsp_qos                               ;
	wire        sw3_TO_sw0_SIG_iniu0_rsp_last                              ;
	wire        cpu_iniu_TO_sw1_SIG_top_req_top_req_req_valid              ;
	wire [89:0] cpu_iniu_TO_sw1_SIG_top_req_top_req_req_payload            ;
	wire        cpu_iniu_TO_sw1_SIG_top_req_top_req_req_last               ;
	wire [5:0]  cpu_iniu_TO_sw1_SIG_top_req_top_req_req_srcid              ;
	wire [5:0]  cpu_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid              ;
	wire        cpu_iniu_TO_sw1_SIG_top_req_top_req_req_qos                ;
	wire        pcie_iniu_TO_sw1_SIG_top_req_top_req_req_valid             ;
	wire [89:0] pcie_iniu_TO_sw1_SIG_top_req_top_req_req_payload           ;
	wire        pcie_iniu_TO_sw1_SIG_top_req_top_req_req_last              ;
	wire [5:0]  pcie_iniu_TO_sw1_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  pcie_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid             ;
	wire        pcie_iniu_TO_sw1_SIG_top_req_top_req_req_qos               ;
	wire        ufs_iniu_TO_sw1_SIG_top_req_top_req_req_valid              ;
	wire [89:0] ufs_iniu_TO_sw1_SIG_top_req_top_req_req_payload            ;
	wire        ufs_iniu_TO_sw1_SIG_top_req_top_req_req_last               ;
	wire [5:0]  ufs_iniu_TO_sw1_SIG_top_req_top_req_req_srcid              ;
	wire [5:0]  ufs_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid              ;
	wire        ufs_iniu_TO_sw1_SIG_top_req_top_req_req_qos                ;
	wire        camera_iniu_TO_sw1_SIG_top_req_top_req_req_valid           ;
	wire [89:0] camera_iniu_TO_sw1_SIG_top_req_top_req_req_payload         ;
	wire        camera_iniu_TO_sw1_SIG_top_req_top_req_req_last            ;
	wire [5:0]  camera_iniu_TO_sw1_SIG_top_req_top_req_req_srcid           ;
	wire [5:0]  camera_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid           ;
	wire        camera_iniu_TO_sw1_SIG_top_req_top_req_req_qos             ;
	wire        mipi_iniu_TO_sw1_SIG_top_req_top_req_req_valid             ;
	wire [89:0] mipi_iniu_TO_sw1_SIG_top_req_top_req_req_payload           ;
	wire        mipi_iniu_TO_sw1_SIG_top_req_top_req_req_last              ;
	wire [5:0]  mipi_iniu_TO_sw1_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  mipi_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid             ;
	wire        mipi_iniu_TO_sw1_SIG_top_req_top_req_req_qos               ;
	wire        cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold          ;
	wire        cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready              ;
	wire        pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold          ;
	wire        ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready              ;
	wire        camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold       ;
	wire        camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready           ;
	wire        mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        sw3_TO_sw1_SIG_iniu1_req_ready                             ;
	wire        sw3_TO_sw1_SIG_iniu1_req_threshold                         ;
	wire        sw3_TO_sw1_SIG_iniu1_rsp_valid                             ;
	wire [89:0] sw3_TO_sw1_SIG_iniu1_rsp_payload                           ;
	wire [5:0]  sw3_TO_sw1_SIG_iniu1_rsp_srcid                             ;
	wire [5:0]  sw3_TO_sw1_SIG_iniu1_rsp_tgtid                             ;
	wire        sw3_TO_sw1_SIG_iniu1_rsp_qos                               ;
	wire        sw3_TO_sw1_SIG_iniu1_rsp_last                              ;
	wire        gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_valid             ;
	wire [89:0] gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_payload           ;
	wire        gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_last              ;
	wire [5:0]  gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid             ;
	wire        gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_qos               ;
	wire        gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_valid             ;
	wire [89:0] gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_payload           ;
	wire        gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_last              ;
	wire [5:0]  gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_srcid             ;
	wire [5:0]  gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid             ;
	wire        gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_qos               ;
	wire        dp_iniu_TO_sw2_SIG_top_req_top_req_req_valid               ;
	wire [89:0] dp_iniu_TO_sw2_SIG_top_req_top_req_req_payload             ;
	wire        dp_iniu_TO_sw2_SIG_top_req_top_req_req_last                ;
	wire [5:0]  dp_iniu_TO_sw2_SIG_top_req_top_req_req_srcid               ;
	wire [5:0]  dp_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid               ;
	wire        dp_iniu_TO_sw2_SIG_top_req_top_req_req_qos                 ;
	wire        display_iniu_TO_sw2_SIG_top_req_top_req_req_valid          ;
	wire [89:0] display_iniu_TO_sw2_SIG_top_req_top_req_req_payload        ;
	wire        display_iniu_TO_sw2_SIG_top_req_top_req_req_last           ;
	wire [5:0]  display_iniu_TO_sw2_SIG_top_req_top_req_req_srcid          ;
	wire [5:0]  display_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid          ;
	wire        display_iniu_TO_sw2_SIG_top_req_top_req_req_qos            ;
	wire        gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold         ;
	wire        gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready             ;
	wire        dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold           ;
	wire        dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready               ;
	wire        display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold      ;
	wire        display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready          ;
	wire        dti_buffer_TO_sw2_SIG_write_req_ready                      ;
	wire        dti_buffer_TO_sw2_SIG_write_req_threshold                  ;
	wire        sw3_TO_sw2_SIG_iniu2_rsp_valid                             ;
	wire [89:0] sw3_TO_sw2_SIG_iniu2_rsp_payload                           ;
	wire [5:0]  sw3_TO_sw2_SIG_iniu2_rsp_srcid                             ;
	wire [5:0]  sw3_TO_sw2_SIG_iniu2_rsp_tgtid                             ;
	wire        sw3_TO_sw2_SIG_iniu2_rsp_qos                               ;
	wire        sw3_TO_sw2_SIG_iniu2_rsp_last                              ;
	wire        sw0_TO_sw3_SIG_tniu_req_valid                              ;
	wire [89:0] sw0_TO_sw3_SIG_tniu_req_payload                            ;
	wire        sw0_TO_sw3_SIG_tniu_req_last                               ;
	wire [5:0]  sw0_TO_sw3_SIG_tniu_req_srcid                              ;
	wire [5:0]  sw0_TO_sw3_SIG_tniu_req_tgtid                              ;
	wire        sw0_TO_sw3_SIG_tniu_req_qos                                ;
	wire        sw1_TO_sw3_SIG_tniu_req_valid                              ;
	wire [89:0] sw1_TO_sw3_SIG_tniu_req_payload                            ;
	wire        sw1_TO_sw3_SIG_tniu_req_last                               ;
	wire [5:0]  sw1_TO_sw3_SIG_tniu_req_srcid                              ;
	wire [5:0]  sw1_TO_sw3_SIG_tniu_req_tgtid                              ;
	wire        sw1_TO_sw3_SIG_tniu_req_qos                                ;
	wire        async_bridge_TO_sw3_SIG_m_chan_m_valid                     ;
	wire [89:0] async_bridge_TO_sw3_SIG_m_chan_m_payload                   ;
	wire        async_bridge_TO_sw3_SIG_m_chan_m_last                      ;
	wire [5:0]  async_bridge_TO_sw3_SIG_m_chan_m_srcid                     ;
	wire [5:0]  async_bridge_TO_sw3_SIG_m_chan_m_tgtid                     ;
	wire        async_bridge_TO_sw3_SIG_m_chan_m_qos                       ;
	wire        sw0_TO_sw3_SIG_tniu_rsp_threshold                          ;
	wire        sw0_TO_sw3_SIG_tniu_rsp_ready                              ;
	wire        sw1_TO_sw3_SIG_tniu_rsp_threshold                          ;
	wire        sw1_TO_sw3_SIG_tniu_rsp_ready                              ;
	wire        sw2_TO_sw3_SIG_tniu_rsp_threshold                          ;
	wire        sw2_TO_sw3_SIG_tniu_rsp_ready                              ;
	wire        tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_ready    ;
	wire        tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_threshold;
	wire        tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_valid              ;
	wire [89:0] tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_payload            ;
	wire [5:0]  tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_srcid              ;
	wire [5:0]  tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_tgtid              ;
	wire        tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_qos                ;
	wire        tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_last               ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_valid                       ;
	wire [89:0] sw2_TO_dti_buffer_SIG_tniu_req_payload                     ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_last                        ;
	wire [5:0]  sw2_TO_dti_buffer_SIG_tniu_req_srcid                       ;
	wire [5:0]  sw2_TO_dti_buffer_SIG_tniu_req_tgtid                       ;
	wire        sw2_TO_dti_buffer_SIG_tniu_req_qos                         ;
	wire        async_bridge_TO_dti_buffer_SIG_s_chan_s_ready              ;
	wire        async_bridge_TO_dti_buffer_SIG_s_chan_s_threshold          ;
	wire        dti_buffer_TO_async_bridge_SIG_read_resp_last              ;
	wire [89:0] dti_buffer_TO_async_bridge_SIG_read_resp_payload           ;
	wire        dti_buffer_TO_async_bridge_SIG_read_resp_qos               ;
	wire [5:0]  dti_buffer_TO_async_bridge_SIG_read_resp_srcid             ;
	wire [5:0]  dti_buffer_TO_async_bridge_SIG_read_resp_tgtid             ;
	wire        dti_buffer_TO_async_bridge_SIG_read_resp_valid             ;
	wire        sw3_TO_async_bridge_SIG_iniu2_req_ready                    ;
	wire        sw3_TO_async_bridge_SIG_iniu2_req_threshold                ;
	wire        sw0_TO_dsp0_iniu_SIG_iniu0_req_ready                       ;
	wire        sw0_TO_dsp0_iniu_SIG_iniu0_req_threshold                   ;
	wire        sw0_TO_dsp0_iniu_SIG_iniu0_rsp_last                        ;
	wire [89:0] sw0_TO_dsp0_iniu_SIG_iniu0_rsp_payload                     ;
	wire        sw0_TO_dsp0_iniu_SIG_iniu0_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp0_iniu_SIG_iniu0_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp0_iniu_SIG_iniu0_rsp_tgtid                       ;
	wire        sw0_TO_dsp0_iniu_SIG_iniu0_rsp_valid                       ;
	wire        sw0_TO_dsp1_iniu_SIG_iniu1_req_ready                       ;
	wire        sw0_TO_dsp1_iniu_SIG_iniu1_req_threshold                   ;
	wire        sw0_TO_dsp1_iniu_SIG_iniu1_rsp_last                        ;
	wire [89:0] sw0_TO_dsp1_iniu_SIG_iniu1_rsp_payload                     ;
	wire        sw0_TO_dsp1_iniu_SIG_iniu1_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp1_iniu_SIG_iniu1_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp1_iniu_SIG_iniu1_rsp_tgtid                       ;
	wire        sw0_TO_dsp1_iniu_SIG_iniu1_rsp_valid                       ;
	wire        sw0_TO_dsp2_iniu_SIG_iniu2_req_ready                       ;
	wire        sw0_TO_dsp2_iniu_SIG_iniu2_req_threshold                   ;
	wire        sw0_TO_dsp2_iniu_SIG_iniu2_rsp_last                        ;
	wire [89:0] sw0_TO_dsp2_iniu_SIG_iniu2_rsp_payload                     ;
	wire        sw0_TO_dsp2_iniu_SIG_iniu2_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp2_iniu_SIG_iniu2_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp2_iniu_SIG_iniu2_rsp_tgtid                       ;
	wire        sw0_TO_dsp2_iniu_SIG_iniu2_rsp_valid                       ;
	wire        sw0_TO_dsp3_iniu_SIG_iniu3_req_ready                       ;
	wire        sw0_TO_dsp3_iniu_SIG_iniu3_req_threshold                   ;
	wire        sw0_TO_dsp3_iniu_SIG_iniu3_rsp_last                        ;
	wire [89:0] sw0_TO_dsp3_iniu_SIG_iniu3_rsp_payload                     ;
	wire        sw0_TO_dsp3_iniu_SIG_iniu3_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp3_iniu_SIG_iniu3_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp3_iniu_SIG_iniu3_rsp_tgtid                       ;
	wire        sw0_TO_dsp3_iniu_SIG_iniu3_rsp_valid                       ;
	wire        sw0_TO_dsp4_iniu_SIG_iniu4_req_ready                       ;
	wire        sw0_TO_dsp4_iniu_SIG_iniu4_req_threshold                   ;
	wire        sw0_TO_dsp4_iniu_SIG_iniu4_rsp_last                        ;
	wire [89:0] sw0_TO_dsp4_iniu_SIG_iniu4_rsp_payload                     ;
	wire        sw0_TO_dsp4_iniu_SIG_iniu4_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp4_iniu_SIG_iniu4_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp4_iniu_SIG_iniu4_rsp_tgtid                       ;
	wire        sw0_TO_dsp4_iniu_SIG_iniu4_rsp_valid                       ;
	wire        sw0_TO_dsp5_iniu_SIG_iniu5_req_ready                       ;
	wire        sw0_TO_dsp5_iniu_SIG_iniu5_req_threshold                   ;
	wire        sw0_TO_dsp5_iniu_SIG_iniu5_rsp_last                        ;
	wire [89:0] sw0_TO_dsp5_iniu_SIG_iniu5_rsp_payload                     ;
	wire        sw0_TO_dsp5_iniu_SIG_iniu5_rsp_qos                         ;
	wire [5:0]  sw0_TO_dsp5_iniu_SIG_iniu5_rsp_srcid                       ;
	wire [5:0]  sw0_TO_dsp5_iniu_SIG_iniu5_rsp_tgtid                       ;
	wire        sw0_TO_dsp5_iniu_SIG_iniu5_rsp_valid                       ;
	wire        sw1_TO_cpu_iniu_SIG_iniu0_req_ready                        ;
	wire        sw1_TO_cpu_iniu_SIG_iniu0_req_threshold                    ;
	wire        sw1_TO_cpu_iniu_SIG_iniu0_rsp_last                         ;
	wire [89:0] sw1_TO_cpu_iniu_SIG_iniu0_rsp_payload                      ;
	wire        sw1_TO_cpu_iniu_SIG_iniu0_rsp_qos                          ;
	wire [5:0]  sw1_TO_cpu_iniu_SIG_iniu0_rsp_srcid                        ;
	wire [5:0]  sw1_TO_cpu_iniu_SIG_iniu0_rsp_tgtid                        ;
	wire        sw1_TO_cpu_iniu_SIG_iniu0_rsp_valid                        ;
	wire        sw1_TO_pcie_iniu_SIG_iniu1_req_ready                       ;
	wire        sw1_TO_pcie_iniu_SIG_iniu1_req_threshold                   ;
	wire        sw1_TO_pcie_iniu_SIG_iniu1_rsp_last                        ;
	wire [89:0] sw1_TO_pcie_iniu_SIG_iniu1_rsp_payload                     ;
	wire        sw1_TO_pcie_iniu_SIG_iniu1_rsp_qos                         ;
	wire [5:0]  sw1_TO_pcie_iniu_SIG_iniu1_rsp_srcid                       ;
	wire [5:0]  sw1_TO_pcie_iniu_SIG_iniu1_rsp_tgtid                       ;
	wire        sw1_TO_pcie_iniu_SIG_iniu1_rsp_valid                       ;
	wire        sw1_TO_ufs_iniu_SIG_iniu2_req_ready                        ;
	wire        sw1_TO_ufs_iniu_SIG_iniu2_req_threshold                    ;
	wire        sw1_TO_ufs_iniu_SIG_iniu2_rsp_last                         ;
	wire [89:0] sw1_TO_ufs_iniu_SIG_iniu2_rsp_payload                      ;
	wire        sw1_TO_ufs_iniu_SIG_iniu2_rsp_qos                          ;
	wire [5:0]  sw1_TO_ufs_iniu_SIG_iniu2_rsp_srcid                        ;
	wire [5:0]  sw1_TO_ufs_iniu_SIG_iniu2_rsp_tgtid                        ;
	wire        sw1_TO_ufs_iniu_SIG_iniu2_rsp_valid                        ;
	wire        sw1_TO_camera_iniu_SIG_iniu3_req_ready                     ;
	wire        sw1_TO_camera_iniu_SIG_iniu3_req_threshold                 ;
	wire        sw1_TO_camera_iniu_SIG_iniu3_rsp_last                      ;
	wire [89:0] sw1_TO_camera_iniu_SIG_iniu3_rsp_payload                   ;
	wire        sw1_TO_camera_iniu_SIG_iniu3_rsp_qos                       ;
	wire [5:0]  sw1_TO_camera_iniu_SIG_iniu3_rsp_srcid                     ;
	wire [5:0]  sw1_TO_camera_iniu_SIG_iniu3_rsp_tgtid                     ;
	wire        sw1_TO_camera_iniu_SIG_iniu3_rsp_valid                     ;
	wire        sw1_TO_mipi_iniu_SIG_iniu4_req_ready                       ;
	wire        sw1_TO_mipi_iniu_SIG_iniu4_req_threshold                   ;
	wire        sw1_TO_mipi_iniu_SIG_iniu4_rsp_last                        ;
	wire [89:0] sw1_TO_mipi_iniu_SIG_iniu4_rsp_payload                     ;
	wire        sw1_TO_mipi_iniu_SIG_iniu4_rsp_qos                         ;
	wire [5:0]  sw1_TO_mipi_iniu_SIG_iniu4_rsp_srcid                       ;
	wire [5:0]  sw1_TO_mipi_iniu_SIG_iniu4_rsp_tgtid                       ;
	wire        sw1_TO_mipi_iniu_SIG_iniu4_rsp_valid                       ;
	wire        sw2_TO_gpu0_iniu_SIG_iniu0_req_ready                       ;
	wire        sw2_TO_gpu0_iniu_SIG_iniu0_req_threshold                   ;
	wire        sw2_TO_gpu0_iniu_SIG_iniu0_rsp_last                        ;
	wire [89:0] sw2_TO_gpu0_iniu_SIG_iniu0_rsp_payload                     ;
	wire        sw2_TO_gpu0_iniu_SIG_iniu0_rsp_qos                         ;
	wire [5:0]  sw2_TO_gpu0_iniu_SIG_iniu0_rsp_srcid                       ;
	wire [5:0]  sw2_TO_gpu0_iniu_SIG_iniu0_rsp_tgtid                       ;
	wire        sw2_TO_gpu0_iniu_SIG_iniu0_rsp_valid                       ;
	wire        sw2_TO_gpu1_iniu_SIG_iniu1_req_ready                       ;
	wire        sw2_TO_gpu1_iniu_SIG_iniu1_req_threshold                   ;
	wire        sw2_TO_gpu1_iniu_SIG_iniu1_rsp_last                        ;
	wire [89:0] sw2_TO_gpu1_iniu_SIG_iniu1_rsp_payload                     ;
	wire        sw2_TO_gpu1_iniu_SIG_iniu1_rsp_qos                         ;
	wire [5:0]  sw2_TO_gpu1_iniu_SIG_iniu1_rsp_srcid                       ;
	wire [5:0]  sw2_TO_gpu1_iniu_SIG_iniu1_rsp_tgtid                       ;
	wire        sw2_TO_gpu1_iniu_SIG_iniu1_rsp_valid                       ;
	wire        sw2_TO_dp_iniu_SIG_iniu2_req_ready                         ;
	wire        sw2_TO_dp_iniu_SIG_iniu2_req_threshold                     ;
	wire        sw2_TO_dp_iniu_SIG_iniu2_rsp_last                          ;
	wire [89:0] sw2_TO_dp_iniu_SIG_iniu2_rsp_payload                       ;
	wire        sw2_TO_dp_iniu_SIG_iniu2_rsp_qos                           ;
	wire [5:0]  sw2_TO_dp_iniu_SIG_iniu2_rsp_srcid                         ;
	wire [5:0]  sw2_TO_dp_iniu_SIG_iniu2_rsp_tgtid                         ;
	wire        sw2_TO_dp_iniu_SIG_iniu2_rsp_valid                         ;
	wire        sw2_TO_display_iniu_SIG_iniu3_req_ready                    ;
	wire        sw2_TO_display_iniu_SIG_iniu3_req_threshold                ;
	wire        sw2_TO_display_iniu_SIG_iniu3_rsp_last                     ;
	wire [89:0] sw2_TO_display_iniu_SIG_iniu3_rsp_payload                  ;
	wire        sw2_TO_display_iniu_SIG_iniu3_rsp_qos                      ;
	wire [5:0]  sw2_TO_display_iniu_SIG_iniu3_rsp_srcid                    ;
	wire [5:0]  sw2_TO_display_iniu_SIG_iniu3_rsp_tgtid                    ;
	wire        sw2_TO_display_iniu_SIG_iniu3_rsp_valid                    ;
	wire        sw3_TO_tcu_tniu_SIG_tniu_req_last                          ;
	wire [89:0] sw3_TO_tcu_tniu_SIG_tniu_req_payload                       ;
	wire        sw3_TO_tcu_tniu_SIG_tniu_req_qos                           ;
	wire [5:0]  sw3_TO_tcu_tniu_SIG_tniu_req_srcid                         ;
	wire [5:0]  sw3_TO_tcu_tniu_SIG_tniu_req_tgtid                         ;
	wire        sw3_TO_tcu_tniu_SIG_tniu_req_valid                         ;
	wire        sw3_TO_tcu_tniu_SIG_tniu_rsp_ready                         ;
	wire        sw3_TO_tcu_tniu_SIG_tniu_rsp_threshold                     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_sw0_dti_noc_switch_6to1_wrap sw0 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu0_req_payload(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu0_req_last(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu0_req_srcid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu0_req_threshold(sw0_TO_dsp0_iniu_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw0_TO_dsp0_iniu_SIG_iniu0_req_ready),
		.iniu1_req_valid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu1_req_payload(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu1_req_last(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu1_req_srcid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu1_req_threshold(sw0_TO_dsp1_iniu_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw0_TO_dsp1_iniu_SIG_iniu1_req_ready),
		.iniu2_req_valid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu2_req_payload(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu2_req_last(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu2_req_srcid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu2_req_threshold(sw0_TO_dsp2_iniu_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw0_TO_dsp2_iniu_SIG_iniu2_req_ready),
		.iniu3_req_valid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu3_req_payload(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu3_req_last(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu3_req_srcid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu3_req_threshold(sw0_TO_dsp3_iniu_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw0_TO_dsp3_iniu_SIG_iniu3_req_ready),
		.iniu4_req_valid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu4_req_payload(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu4_req_last(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu4_req_srcid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu4_req_tgtid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu4_req_qos(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu4_req_threshold(sw0_TO_dsp4_iniu_SIG_iniu4_req_threshold),
		.iniu4_req_ready(sw0_TO_dsp4_iniu_SIG_iniu4_req_ready),
		.iniu5_req_valid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.iniu5_req_payload(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.iniu5_req_last(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.iniu5_req_srcid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.iniu5_req_tgtid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.iniu5_req_qos(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.iniu5_req_threshold(sw0_TO_dsp5_iniu_SIG_iniu5_req_threshold),
		.iniu5_req_ready(sw0_TO_dsp5_iniu_SIG_iniu5_req_ready),
		.iniu0_rsp_valid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu4_rsp_valid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu5_rsp_valid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_valid),
		.iniu5_rsp_payload(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_payload),
		.iniu5_rsp_last(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_last),
		.iniu5_rsp_srcid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_qos),
		.iniu5_rsp_threshold(dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu5_rsp_ready(dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.tniu_req_valid(sw0_TO_sw3_SIG_tniu_req_valid),
		.tniu_req_ready(sw3_TO_sw0_SIG_iniu0_req_ready),
		.tniu_req_payload(sw0_TO_sw3_SIG_tniu_req_payload),
		.tniu_req_srcid(sw0_TO_sw3_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw0_TO_sw3_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw0_TO_sw3_SIG_tniu_req_qos),
		.tniu_req_last(sw0_TO_sw3_SIG_tniu_req_last),
		.tniu_req_threshold(sw3_TO_sw0_SIG_iniu0_req_threshold),
		.tniu_rsp_valid(sw3_TO_sw0_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw0_TO_sw3_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw3_TO_sw0_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw3_TO_sw0_SIG_iniu0_rsp_srcid),
		.tniu_rsp_tgtid(sw3_TO_sw0_SIG_iniu0_rsp_tgtid),
		.tniu_rsp_qos(sw3_TO_sw0_SIG_iniu0_rsp_qos),
		.tniu_rsp_last(sw3_TO_sw0_SIG_iniu0_rsp_last),
		.tniu_rsp_threshold(sw0_TO_sw3_SIG_tniu_rsp_threshold));
	dti_sw1_dti_noc_switch_5to1_wrap sw1 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.iniu0_req_payload(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.iniu0_req_last(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.iniu0_req_srcid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.iniu0_req_threshold(sw1_TO_cpu_iniu_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw1_TO_cpu_iniu_SIG_iniu0_req_ready),
		.iniu1_req_valid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.iniu1_req_payload(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.iniu1_req_last(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.iniu1_req_srcid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.iniu1_req_threshold(sw1_TO_pcie_iniu_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw1_TO_pcie_iniu_SIG_iniu1_req_ready),
		.iniu2_req_valid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.iniu2_req_payload(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.iniu2_req_last(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.iniu2_req_srcid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.iniu2_req_threshold(sw1_TO_ufs_iniu_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw1_TO_ufs_iniu_SIG_iniu2_req_ready),
		.iniu3_req_valid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.iniu3_req_payload(camera_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.iniu3_req_last(camera_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.iniu3_req_srcid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(camera_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.iniu3_req_threshold(sw1_TO_camera_iniu_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw1_TO_camera_iniu_SIG_iniu3_req_ready),
		.iniu4_req_valid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.iniu4_req_payload(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.iniu4_req_last(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.iniu4_req_srcid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.iniu4_req_tgtid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.iniu4_req_qos(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.iniu4_req_threshold(sw1_TO_mipi_iniu_SIG_iniu4_req_threshold),
		.iniu4_req_ready(sw1_TO_mipi_iniu_SIG_iniu4_req_ready),
		.iniu0_rsp_valid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw1_TO_cpu_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw1_TO_cpu_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw1_TO_cpu_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw1_TO_pcie_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw1_TO_pcie_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw1_TO_pcie_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw1_TO_ufs_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw1_TO_ufs_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw1_TO_ufs_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw1_TO_camera_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw1_TO_camera_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw1_TO_camera_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw1_TO_camera_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw1_TO_camera_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw1_TO_camera_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu4_rsp_valid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_valid),
		.iniu4_rsp_payload(sw1_TO_mipi_iniu_SIG_iniu4_rsp_payload),
		.iniu4_rsp_last(sw1_TO_mipi_iniu_SIG_iniu4_rsp_last),
		.iniu4_rsp_srcid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw1_TO_mipi_iniu_SIG_iniu4_rsp_qos),
		.iniu4_rsp_threshold(mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu4_rsp_ready(mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.tniu_req_valid(sw1_TO_sw3_SIG_tniu_req_valid),
		.tniu_req_ready(sw3_TO_sw1_SIG_iniu1_req_ready),
		.tniu_req_payload(sw1_TO_sw3_SIG_tniu_req_payload),
		.tniu_req_srcid(sw1_TO_sw3_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw1_TO_sw3_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw1_TO_sw3_SIG_tniu_req_qos),
		.tniu_req_last(sw1_TO_sw3_SIG_tniu_req_last),
		.tniu_req_threshold(sw3_TO_sw1_SIG_iniu1_req_threshold),
		.tniu_rsp_valid(sw3_TO_sw1_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(sw1_TO_sw3_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw3_TO_sw1_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(sw3_TO_sw1_SIG_iniu1_rsp_srcid),
		.tniu_rsp_tgtid(sw3_TO_sw1_SIG_iniu1_rsp_tgtid),
		.tniu_rsp_qos(sw3_TO_sw1_SIG_iniu1_rsp_qos),
		.tniu_rsp_last(sw3_TO_sw1_SIG_iniu1_rsp_last),
		.tniu_rsp_threshold(sw1_TO_sw3_SIG_tniu_rsp_threshold));
	dti_sw2_dti_noc_switch_4to1_wrap sw2 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.iniu0_req_payload(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.iniu0_req_last(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.iniu0_req_srcid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.iniu0_req_threshold(sw2_TO_gpu0_iniu_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw2_TO_gpu0_iniu_SIG_iniu0_req_ready),
		.iniu1_req_valid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.iniu1_req_payload(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.iniu1_req_last(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.iniu1_req_srcid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.iniu1_req_threshold(sw2_TO_gpu1_iniu_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw2_TO_gpu1_iniu_SIG_iniu1_req_ready),
		.iniu2_req_valid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.iniu2_req_payload(dp_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.iniu2_req_last(dp_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.iniu2_req_srcid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(dp_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.iniu2_req_threshold(sw2_TO_dp_iniu_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw2_TO_dp_iniu_SIG_iniu2_req_ready),
		.iniu3_req_valid(display_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.iniu3_req_payload(display_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.iniu3_req_last(display_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.iniu3_req_srcid(display_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(display_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(display_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.iniu3_req_threshold(sw2_TO_display_iniu_SIG_iniu3_req_threshold),
		.iniu3_req_ready(sw2_TO_display_iniu_SIG_iniu3_req_ready),
		.iniu0_rsp_valid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu0_rsp_ready(gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_valid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_rsp_ready(gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_valid(sw2_TO_dp_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw2_TO_dp_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw2_TO_dp_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw2_TO_dp_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw2_TO_dp_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw2_TO_dp_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_rsp_ready(dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_valid(sw2_TO_display_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_payload(sw2_TO_display_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_last(sw2_TO_display_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_srcid(sw2_TO_display_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw2_TO_display_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw2_TO_display_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_threshold(display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_rsp_ready(display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.tniu_req_valid(sw2_TO_dti_buffer_SIG_tniu_req_valid),
		.tniu_req_ready(dti_buffer_TO_sw2_SIG_write_req_ready),
		.tniu_req_payload(sw2_TO_dti_buffer_SIG_tniu_req_payload),
		.tniu_req_srcid(sw2_TO_dti_buffer_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw2_TO_dti_buffer_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw2_TO_dti_buffer_SIG_tniu_req_qos),
		.tniu_req_last(sw2_TO_dti_buffer_SIG_tniu_req_last),
		.tniu_req_threshold(dti_buffer_TO_sw2_SIG_write_req_threshold),
		.tniu_rsp_valid(sw3_TO_sw2_SIG_iniu2_rsp_valid),
		.tniu_rsp_ready(sw2_TO_sw3_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw3_TO_sw2_SIG_iniu2_rsp_payload),
		.tniu_rsp_srcid(sw3_TO_sw2_SIG_iniu2_rsp_srcid),
		.tniu_rsp_tgtid(sw3_TO_sw2_SIG_iniu2_rsp_tgtid),
		.tniu_rsp_qos(sw3_TO_sw2_SIG_iniu2_rsp_qos),
		.tniu_rsp_last(sw3_TO_sw2_SIG_iniu2_rsp_last),
		.tniu_rsp_threshold(sw2_TO_sw3_SIG_tniu_rsp_threshold));
	dti_sw3_dti_noc_switch_3to1_wrap sw3 (
		.clk(clk_noc_up),
		.rst_n(rst_noc_up_n),
		.iniu0_req_valid(sw0_TO_sw3_SIG_tniu_req_valid),
		.iniu0_req_payload(sw0_TO_sw3_SIG_tniu_req_payload),
		.iniu0_req_last(sw0_TO_sw3_SIG_tniu_req_last),
		.iniu0_req_srcid(sw0_TO_sw3_SIG_tniu_req_srcid),
		.iniu0_req_tgtid(sw0_TO_sw3_SIG_tniu_req_tgtid),
		.iniu0_req_qos(sw0_TO_sw3_SIG_tniu_req_qos),
		.iniu0_req_threshold(sw3_TO_sw0_SIG_iniu0_req_threshold),
		.iniu0_req_ready(sw3_TO_sw0_SIG_iniu0_req_ready),
		.iniu1_req_valid(sw1_TO_sw3_SIG_tniu_req_valid),
		.iniu1_req_payload(sw1_TO_sw3_SIG_tniu_req_payload),
		.iniu1_req_last(sw1_TO_sw3_SIG_tniu_req_last),
		.iniu1_req_srcid(sw1_TO_sw3_SIG_tniu_req_srcid),
		.iniu1_req_tgtid(sw1_TO_sw3_SIG_tniu_req_tgtid),
		.iniu1_req_qos(sw1_TO_sw3_SIG_tniu_req_qos),
		.iniu1_req_threshold(sw3_TO_sw1_SIG_iniu1_req_threshold),
		.iniu1_req_ready(sw3_TO_sw1_SIG_iniu1_req_ready),
		.iniu2_req_valid(async_bridge_TO_sw3_SIG_m_chan_m_valid),
		.iniu2_req_payload(async_bridge_TO_sw3_SIG_m_chan_m_payload),
		.iniu2_req_last(async_bridge_TO_sw3_SIG_m_chan_m_last),
		.iniu2_req_srcid(async_bridge_TO_sw3_SIG_m_chan_m_srcid),
		.iniu2_req_tgtid(async_bridge_TO_sw3_SIG_m_chan_m_tgtid),
		.iniu2_req_qos(async_bridge_TO_sw3_SIG_m_chan_m_qos),
		.iniu2_req_threshold(sw3_TO_async_bridge_SIG_iniu2_req_threshold),
		.iniu2_req_ready(sw3_TO_async_bridge_SIG_iniu2_req_ready),
		.iniu0_rsp_valid(sw3_TO_sw0_SIG_iniu0_rsp_valid),
		.iniu0_rsp_payload(sw3_TO_sw0_SIG_iniu0_rsp_payload),
		.iniu0_rsp_last(sw3_TO_sw0_SIG_iniu0_rsp_last),
		.iniu0_rsp_srcid(sw3_TO_sw0_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw3_TO_sw0_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw3_TO_sw0_SIG_iniu0_rsp_qos),
		.iniu0_rsp_threshold(sw0_TO_sw3_SIG_tniu_rsp_threshold),
		.iniu0_rsp_ready(sw0_TO_sw3_SIG_tniu_rsp_ready),
		.iniu1_rsp_valid(sw3_TO_sw1_SIG_iniu1_rsp_valid),
		.iniu1_rsp_payload(sw3_TO_sw1_SIG_iniu1_rsp_payload),
		.iniu1_rsp_last(sw3_TO_sw1_SIG_iniu1_rsp_last),
		.iniu1_rsp_srcid(sw3_TO_sw1_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw3_TO_sw1_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw3_TO_sw1_SIG_iniu1_rsp_qos),
		.iniu1_rsp_threshold(sw1_TO_sw3_SIG_tniu_rsp_threshold),
		.iniu1_rsp_ready(sw1_TO_sw3_SIG_tniu_rsp_ready),
		.iniu2_rsp_valid(sw3_TO_sw2_SIG_iniu2_rsp_valid),
		.iniu2_rsp_payload(sw3_TO_sw2_SIG_iniu2_rsp_payload),
		.iniu2_rsp_last(sw3_TO_sw2_SIG_iniu2_rsp_last),
		.iniu2_rsp_srcid(sw3_TO_sw2_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw3_TO_sw2_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw3_TO_sw2_SIG_iniu2_rsp_qos),
		.iniu2_rsp_threshold(sw2_TO_sw3_SIG_tniu_rsp_threshold),
		.iniu2_rsp_ready(sw2_TO_sw3_SIG_tniu_rsp_ready),
		.tniu_req_valid(sw3_TO_tcu_tniu_SIG_tniu_req_valid),
		.tniu_req_ready(tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_ready),
		.tniu_req_payload(sw3_TO_tcu_tniu_SIG_tniu_req_payload),
		.tniu_req_srcid(sw3_TO_tcu_tniu_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw3_TO_tcu_tniu_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw3_TO_tcu_tniu_SIG_tniu_req_qos),
		.tniu_req_last(sw3_TO_tcu_tniu_SIG_tniu_req_last),
		.tniu_req_threshold(tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_threshold),
		.tniu_rsp_valid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_valid),
		.tniu_rsp_ready(sw3_TO_tcu_tniu_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_payload),
		.tniu_rsp_srcid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_qos),
		.tniu_rsp_last(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_last),
		.tniu_rsp_threshold(sw3_TO_tcu_tniu_SIG_tniu_rsp_threshold));
	dti_link_buf dti_buffer (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
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
		.read_resp_valid(dti_buffer_TO_async_bridge_SIG_read_resp_valid),
		.read_resp_payload(dti_buffer_TO_async_bridge_SIG_read_resp_payload),
		.read_resp_last(dti_buffer_TO_async_bridge_SIG_read_resp_last),
		.read_resp_srcid(dti_buffer_TO_async_bridge_SIG_read_resp_srcid),
		.read_resp_tgtid(dti_buffer_TO_async_bridge_SIG_read_resp_tgtid),
		.read_resp_qos(dti_buffer_TO_async_bridge_SIG_read_resp_qos),
		.read_resp_ready(async_bridge_TO_dti_buffer_SIG_s_chan_s_ready),
		.read_resp_threshold(async_bridge_TO_dti_buffer_SIG_s_chan_s_threshold),
		.almost_full(dti_buffer_ctrl_porting_almost_full),
		.almost_empty(dti_buffer_ctrl_porting_almost_empty),
		.empty(dti_buffer_ctrl_porting_empty),
		.full(dti_buffer_ctrl_porting_full));
	dti_req_rsp_async_bridge async_bridge (
		.clk_src_clk(clk_noc),
		.rst_src_n_rst_n(rst_noc_n),
		.clk_dst_clk(clk_noc_up),
		.rst_dst_n_rst_n(rst_noc_up_n),
		.s_chan_s_last(dti_buffer_TO_async_bridge_SIG_read_resp_last),
		.s_chan_s_payload(dti_buffer_TO_async_bridge_SIG_read_resp_payload),
		.s_chan_s_qos(dti_buffer_TO_async_bridge_SIG_read_resp_qos),
		.s_chan_s_ready(async_bridge_TO_dti_buffer_SIG_s_chan_s_ready),
		.s_chan_s_srcid(dti_buffer_TO_async_bridge_SIG_read_resp_srcid),
		.s_chan_s_tgtid(dti_buffer_TO_async_bridge_SIG_read_resp_tgtid),
		.s_chan_s_threshold(async_bridge_TO_dti_buffer_SIG_s_chan_s_threshold),
		.s_chan_s_valid(dti_buffer_TO_async_bridge_SIG_read_resp_valid),
		.m_chan_m_last(async_bridge_TO_sw3_SIG_m_chan_m_last),
		.m_chan_m_payload(async_bridge_TO_sw3_SIG_m_chan_m_payload),
		.m_chan_m_qos(async_bridge_TO_sw3_SIG_m_chan_m_qos),
		.m_chan_m_ready(sw3_TO_async_bridge_SIG_iniu2_req_ready),
		.m_chan_m_srcid(async_bridge_TO_sw3_SIG_m_chan_m_srcid),
		.m_chan_m_tgtid(async_bridge_TO_sw3_SIG_m_chan_m_tgtid),
		.m_chan_m_threshold(sw3_TO_async_bridge_SIG_iniu2_req_threshold),
		.m_chan_m_valid(async_bridge_TO_sw3_SIG_m_chan_m_valid));
	dsp0_iniu_node dsp0_iniu (
		.clk_sys_clk_sys_clk(dsp0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp0_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp0_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(dsp0_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp0_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp0_iniu_SIG_iniu0_rsp_valid));
	dsp1_iniu_node dsp1_iniu (
		.clk_sys_clk_sys_clk(dsp1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp1_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp1_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(dsp1_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp1_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp1_iniu_SIG_iniu1_rsp_valid));
	dsp2_iniu_node dsp2_iniu (
		.clk_sys_clk_sys_clk(dsp2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp2_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp2_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(dsp2_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp2_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp2_iniu_SIG_iniu2_rsp_valid));
	dsp3_iniu_node dsp3_iniu (
		.clk_sys_clk_sys_clk(dsp3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp3_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp3_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(dsp3_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp3_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp3_iniu_SIG_iniu3_rsp_valid));
	dsp4_iniu_node dsp4_iniu (
		.clk_sys_clk_sys_clk(dsp4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp4_iniu_SIG_iniu4_req_ready),
		.top_req_top_req_req_srcid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp4_iniu_SIG_iniu4_req_threshold),
		.top_req_top_req_req_valid(dsp4_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp4_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp4_iniu_SIG_iniu4_rsp_valid));
	dsp5_iniu_node dsp5_iniu (
		.clk_sys_clk_sys_clk(dsp5_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp5_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp5_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp5_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp5_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp5_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw0_TO_dsp5_iniu_SIG_iniu5_req_ready),
		.top_req_top_req_req_srcid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw0_TO_dsp5_iniu_SIG_iniu5_req_threshold),
		.top_req_top_req_req_valid(dsp5_iniu_TO_sw0_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp5_iniu_TO_sw0_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw0_TO_dsp5_iniu_SIG_iniu5_rsp_valid));
	cpu_iniu_node cpu_iniu (
		.clk_sys_clk_sys_clk(cpu_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(cpu_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(cpu_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(cpu_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(cpu_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(cpu_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(cpu_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(cpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw1_TO_cpu_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw1_TO_cpu_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(cpu_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw1_TO_cpu_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw1_TO_cpu_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw1_TO_cpu_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(cpu_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw1_TO_cpu_iniu_SIG_iniu0_rsp_valid));
	pcie_iniu_node pcie_iniu (
		.clk_sys_clk_sys_clk(pcie_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(pcie_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(pcie_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(pcie_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(pcie_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(pcie_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(pcie_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(pcie_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw1_TO_pcie_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw1_TO_pcie_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(pcie_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw1_TO_pcie_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw1_TO_pcie_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw1_TO_pcie_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(pcie_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw1_TO_pcie_iniu_SIG_iniu1_rsp_valid));
	ufs_iniu_node ufs_iniu (
		.clk_sys_clk_sys_clk(ufs_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(ufs_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(ufs_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(ufs_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(ufs_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(ufs_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(ufs_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw1_TO_ufs_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw1_TO_ufs_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(ufs_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw1_TO_ufs_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw1_TO_ufs_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw1_TO_ufs_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(ufs_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw1_TO_ufs_iniu_SIG_iniu2_rsp_valid));
	camera_iniu_node camera_iniu (
		.clk_sys_clk_sys_clk(camera_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(camera_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(camera_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(camera_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(camera_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(camera_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(camera_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(camera_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(camera_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(camera_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw1_TO_camera_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw1_TO_camera_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(camera_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw1_TO_camera_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw1_TO_camera_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw1_TO_camera_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw1_TO_camera_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw1_TO_camera_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(camera_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw1_TO_camera_iniu_SIG_iniu3_rsp_valid));
	mipi_iniu_node mipi_iniu (
		.clk_sys_clk_sys_clk(mipi_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(mipi_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(mipi_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(mipi_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(mipi_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(mipi_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(mipi_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(mipi_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw1_TO_mipi_iniu_SIG_iniu4_req_ready),
		.top_req_top_req_req_srcid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw1_TO_mipi_iniu_SIG_iniu4_req_threshold),
		.top_req_top_req_req_valid(mipi_iniu_TO_sw1_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw1_TO_mipi_iniu_SIG_iniu4_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw1_TO_mipi_iniu_SIG_iniu4_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw1_TO_mipi_iniu_SIG_iniu4_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(mipi_iniu_TO_sw1_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw1_TO_mipi_iniu_SIG_iniu4_rsp_valid));
	gpu0_iniu_node gpu0_iniu (
		.clk_sys_clk_sys_clk(gpu0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(gpu0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(gpu0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(gpu0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(gpu0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(gpu0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(gpu0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(gpu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw2_TO_gpu0_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw2_TO_gpu0_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(gpu0_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(gpu0_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw2_TO_gpu0_iniu_SIG_iniu0_rsp_valid));
	gpu1_iniu_node gpu1_iniu (
		.clk_sys_clk_sys_clk(gpu1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(gpu1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(gpu1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(gpu1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(gpu1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(gpu1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(gpu1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(gpu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw2_TO_gpu1_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw2_TO_gpu1_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(gpu1_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(gpu1_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw2_TO_gpu1_iniu_SIG_iniu1_rsp_valid));
	dp_iniu_node dp_iniu (
		.clk_sys_clk_sys_clk(dp_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dp_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dp_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dp_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dp_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dp_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dp_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dp_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dp_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dp_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dp_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw2_TO_dp_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw2_TO_dp_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(dp_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw2_TO_dp_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw2_TO_dp_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw2_TO_dp_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw2_TO_dp_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw2_TO_dp_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dp_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw2_TO_dp_iniu_SIG_iniu2_rsp_valid));
	display_iniu_node display_iniu (
		.clk_sys_clk_sys_clk(display_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(display_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(display_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(display_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(display_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(display_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(display_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(display_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(display_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(display_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(display_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(display_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(display_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(display_iniu_TO_sw2_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(display_iniu_TO_sw2_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(display_iniu_TO_sw2_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw2_TO_display_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(display_iniu_TO_sw2_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(display_iniu_TO_sw2_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw2_TO_display_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(display_iniu_TO_sw2_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw2_TO_display_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw2_TO_display_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw2_TO_display_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw2_TO_display_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw2_TO_display_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(display_iniu_TO_sw2_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw2_TO_display_iniu_SIG_iniu3_rsp_valid));
	tcu_tniu_node tcu_tniu (
		.clk_sys_clk_sys_clk(tcu_tniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc_up),
		.rst_top_n(rst_noc_up_n),
		.dti_req_dti_req_req_tdata(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(tcu_tniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(tcu_tniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.pchnl_ctrl_pchnl_ctrl_paccept(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_data_top_req_data_req_last(sw3_TO_tcu_tniu_SIG_tniu_req_last),
		.top_req_data_top_req_data_req_payload(sw3_TO_tcu_tniu_SIG_tniu_req_payload),
		.top_req_data_top_req_data_req_qos(sw3_TO_tcu_tniu_SIG_tniu_req_qos),
		.top_req_data_top_req_data_req_ready(tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_ready),
		.top_req_data_top_req_data_req_srcid(sw3_TO_tcu_tniu_SIG_tniu_req_srcid),
		.top_req_data_top_req_data_req_tgtid(sw3_TO_tcu_tniu_SIG_tniu_req_tgtid),
		.top_req_data_top_req_data_req_threshold(tcu_tniu_TO_sw3_SIG_top_req_data_top_req_data_req_threshold),
		.top_req_data_top_req_data_req_valid(sw3_TO_tcu_tniu_SIG_tniu_req_valid),
		.top_rsp_top_rsp_rsp_last(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_last),
		.top_rsp_top_rsp_rsp_payload(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(sw3_TO_tcu_tniu_SIG_tniu_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(sw3_TO_tcu_tniu_SIG_tniu_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(tcu_tniu_TO_sw3_SIG_top_rsp_top_rsp_rsp_valid));

endmodule
//[UHDL]Content End [md5:ef1fcfd22b9d76072bed681c63d85a81]


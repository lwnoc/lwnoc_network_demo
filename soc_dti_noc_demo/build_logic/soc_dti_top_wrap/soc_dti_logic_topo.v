//[UHDL]Content Start [md5:94a052acf116cf49c3d900c3079806dd]
module soc_dti_logic_topo
	(
	input                                                   clk_noc                                                                      ,
	input                                                   rst_noc_n                                                                    ,
	input                                                   sys_tcu_tniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   sys_tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	output [79:0]                                           sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	output [9:0]                                            sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	output                                                  sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	input                                                   sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	output [5:0]                                            sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	output                                                  sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	input  [79:0]                                           sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	input  [9:0]                                            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	input                                                   sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	output                                                  sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	input  [5:0]                                            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	input                                                   sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	output                                                  sys_tcu_tniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	input                                                   sys_tcu_tniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	output                                                  sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dsp_ss5_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   dsp_ss5_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   dsp_ss5_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  dsp_ss5_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            dsp_ss5_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   vpu_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                         ,
	input                                                   vpu_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                 ,
	input  [79:0]                                           vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                   ,
	input  [9:0]                                            vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                   ,
	input                                                   vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                   ,
	output                                                  vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                  ,
	input  [5:0]                                            vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                    ,
	input                                                   vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                  ,
	output [79:0]                                           vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                   ,
	output [9:0]                                            vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                   ,
	output                                                  vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                   ,
	input                                                   vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                  ,
	output [5:0]                                            vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                    ,
	output                                                  vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                  ,
	input                                                   vpu_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup     ,
	output                                                  vpu_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup     ,
	input  [9:0]                                            vpu_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val     ,
	output                                                  vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept            ,
	output logic [2-1:0] vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive            ,
	output                                                  vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny              ,
	input                                                   vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq               ,
	input logic [2-1:0]  vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate             ,
	input                                                   pcie_rtg_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                    ,
	input                                                   pcie_rtg_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n            ,
	input  [79:0]                                           pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata              ,
	input  [9:0]                                            pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep              ,
	input                                                   pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast              ,
	output                                                  pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready             ,
	input  [5:0]                                            pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid               ,
	input                                                   pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid             ,
	output [79:0]                                           pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata              ,
	output [9:0]                                            pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep              ,
	output                                                  pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast              ,
	input                                                   pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready             ,
	output [5:0]                                            pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid               ,
	output                                                  pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid             ,
	input                                                   pcie_rtg_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup,
	output                                                  pcie_rtg_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup,
	input  [9:0]                                            pcie_rtg_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val,
	output                                                  pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept       ,
	output logic [2-1:0] pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive       ,
	output                                                  pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny         ,
	input                                                   pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq          ,
	input logic [2-1:0]  pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate        ,
	input                                                   ufs_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                         ,
	input                                                   ufs_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                 ,
	input  [79:0]                                           ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                   ,
	input  [9:0]                                            ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                   ,
	input                                                   ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                   ,
	output                                                  ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                  ,
	input  [5:0]                                            ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                    ,
	input                                                   ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                  ,
	output [79:0]                                           ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                   ,
	output [9:0]                                            ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                   ,
	output                                                  ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                   ,
	input                                                   ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                  ,
	output [5:0]                                            ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                    ,
	output                                                  ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                  ,
	input                                                   ufs_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup     ,
	output                                                  ufs_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup     ,
	input  [9:0]                                            ufs_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val     ,
	output                                                  ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept            ,
	output logic [2-1:0] ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive            ,
	output                                                  ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny              ,
	input                                                   ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq               ,
	input logic [2-1:0]  ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate             ,
	input                                                   camera_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                      ,
	input                                                   camera_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n              ,
	input  [79:0]                                           camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                ,
	input  [9:0]                                            camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                ,
	input                                                   camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                ,
	output                                                  camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready               ,
	input  [5:0]                                            camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                 ,
	input                                                   camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid               ,
	output [79:0]                                           camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                ,
	output [9:0]                                            camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                ,
	output                                                  camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                ,
	input                                                   camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready               ,
	output [5:0]                                            camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                 ,
	output                                                  camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid               ,
	input                                                   camera_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup  ,
	output                                                  camera_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup  ,
	input  [9:0]                                            camera_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val  ,
	output                                                  camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept         ,
	output logic [2-1:0] camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive         ,
	output                                                  camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny           ,
	input                                                   camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq            ,
	input logic [2-1:0]  camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate          ,
	input                                                   mipi_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   mipi_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   mipi_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  mipi_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            mipi_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   gpu_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   gpu_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   gpu_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  gpu_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            gpu_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   gpu_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                        ,
	input                                                   gpu_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                ,
	input  [79:0]                                           gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                  ,
	input  [9:0]                                            gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                  ,
	input                                                   gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                  ,
	output                                                  gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                 ,
	input  [5:0]                                            gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                   ,
	input                                                   gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                 ,
	output [79:0]                                           gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                  ,
	output [9:0]                                            gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                  ,
	output                                                  gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                  ,
	input                                                   gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                 ,
	output [5:0]                                            gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                   ,
	output                                                  gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                 ,
	input                                                   gpu_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup    ,
	output                                                  gpu_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup    ,
	input  [9:0]                                            gpu_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val    ,
	output                                                  gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept           ,
	output logic [2-1:0] gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive           ,
	output                                                  gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny             ,
	input                                                   gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq              ,
	input logic [2-1:0]  gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate            ,
	input                                                   dp_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                          ,
	input                                                   dp_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n                  ,
	input  [79:0]                                           dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata                    ,
	input  [9:0]                                            dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep                    ,
	input                                                   dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast                    ,
	output                                                  dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready                   ,
	input  [5:0]                                            dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                     ,
	input                                                   dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid                   ,
	output [79:0]                                           dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata                    ,
	output [9:0]                                            dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep                    ,
	output                                                  dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast                    ,
	input                                                   dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready                   ,
	output [5:0]                                            dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                     ,
	output                                                  dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid                   ,
	input                                                   dp_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup      ,
	output                                                  dp_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup      ,
	input  [9:0]                                            dp_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val      ,
	output                                                  dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept             ,
	output logic [2-1:0] dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive             ,
	output                                                  dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny               ,
	input                                                   dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq                ,
	input logic [2-1:0]  dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate              ,
	input                                                   display_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk                     ,
	input                                                   display_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n             ,
	input  [79:0]                                           display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata               ,
	input  [9:0]                                            display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep               ,
	input                                                   display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast               ,
	output                                                  display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready              ,
	input  [5:0]                                            display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid                ,
	input                                                   display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid              ,
	output [79:0]                                           display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata               ,
	output [9:0]                                            display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep               ,
	output                                                  display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast               ,
	input                                                   display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready              ,
	output [5:0]                                            display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid                ,
	output                                                  display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid              ,
	input                                                   display_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup ,
	output                                                  display_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup ,
	input  [9:0]                                            display_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val ,
	output                                                  display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept        ,
	output logic [2-1:0] display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive        ,
	output                                                  display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny          ,
	input                                                   display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq           ,
	input logic [2-1:0]  display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate         );

	//Wire define for this module.

	//Wire define for sub module.
	wire        dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid       ;
	wire [89:0] dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid       ;
	wire        dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos         ;
	wire        dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last        ;
	wire        dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_req_ready                      ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_req_threshold                  ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_valid                      ;
	wire [89:0] sw_root_TO_sw_dsp6_SIG_iniu0_rsp_payload                    ;
	wire [5:0]  sw_root_TO_sw_dsp6_SIG_iniu0_rsp_srcid                      ;
	wire [5:0]  sw_root_TO_sw_dsp6_SIG_iniu0_rsp_tgtid                      ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_qos                        ;
	wire        sw_root_TO_sw_dsp6_SIG_iniu0_rsp_last                       ;
	wire        vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid         ;
	wire [89:0] vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload       ;
	wire [5:0]  vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid         ;
	wire [5:0]  vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid         ;
	wire        vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos           ;
	wire        vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last          ;
	wire        vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready         ;
	wire        vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold     ;
	wire        pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid    ;
	wire [89:0] pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload  ;
	wire [5:0]  pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid    ;
	wire [5:0]  pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid    ;
	wire        pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos      ;
	wire        pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last     ;
	wire        pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready    ;
	wire        pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold;
	wire        ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid         ;
	wire [89:0] ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload       ;
	wire [5:0]  ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid         ;
	wire [5:0]  ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid         ;
	wire        ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos           ;
	wire        ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last          ;
	wire        ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready         ;
	wire        ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold     ;
	wire        camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid      ;
	wire [89:0] camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload    ;
	wire [5:0]  camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid      ;
	wire [5:0]  camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid      ;
	wire        camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos        ;
	wire        camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last       ;
	wire        camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready      ;
	wire        camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold  ;
	wire        mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid        ;
	wire [89:0] mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload      ;
	wire [5:0]  mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid        ;
	wire [5:0]  mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid        ;
	wire        mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos          ;
	wire        mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last         ;
	wire        mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready        ;
	wire        mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold    ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_req_ready                      ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_req_threshold                  ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_valid                      ;
	wire [89:0] sw_right_TO_sw_io5_SIG_iniu0_rsp_payload                    ;
	wire [5:0]  sw_right_TO_sw_io5_SIG_iniu0_rsp_srcid                      ;
	wire [5:0]  sw_right_TO_sw_io5_SIG_iniu0_rsp_tgtid                      ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_qos                        ;
	wire        sw_right_TO_sw_io5_SIG_iniu0_rsp_last                       ;
	wire        gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid       ;
	wire [89:0] gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid       ;
	wire        gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos         ;
	wire        gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last        ;
	wire        gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid       ;
	wire [89:0] gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload     ;
	wire [5:0]  gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid       ;
	wire [5:0]  gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid       ;
	wire        gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos         ;
	wire        gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last        ;
	wire        gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready       ;
	wire        gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold   ;
	wire        dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid         ;
	wire [89:0] dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload       ;
	wire [5:0]  dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid         ;
	wire [5:0]  dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid         ;
	wire        dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos           ;
	wire        dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last          ;
	wire        dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready         ;
	wire        dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold     ;
	wire        display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid    ;
	wire [89:0] display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload  ;
	wire [5:0]  display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid    ;
	wire [5:0]  display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid    ;
	wire        display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos      ;
	wire        display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last     ;
	wire        display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready    ;
	wire        display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold;
	wire        sw_right_TO_sw_gpu4_SIG_iniu1_req_ready                     ;
	wire        sw_right_TO_sw_gpu4_SIG_iniu1_req_threshold                 ;
	wire        sw_right_TO_sw_gpu4_SIG_iniu1_rsp_valid                     ;
	wire [89:0] sw_right_TO_sw_gpu4_SIG_iniu1_rsp_payload                   ;
	wire [5:0]  sw_right_TO_sw_gpu4_SIG_iniu1_rsp_srcid                     ;
	wire [5:0]  sw_right_TO_sw_gpu4_SIG_iniu1_rsp_tgtid                     ;
	wire        sw_right_TO_sw_gpu4_SIG_iniu1_rsp_qos                       ;
	wire        sw_right_TO_sw_gpu4_SIG_iniu1_rsp_last                      ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_valid                       ;
	wire [89:0] sw_io5_TO_sw_right_SIG_tniu_req_payload                     ;
	wire [5:0]  sw_io5_TO_sw_right_SIG_tniu_req_srcid                       ;
	wire [5:0]  sw_io5_TO_sw_right_SIG_tniu_req_tgtid                       ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_qos                         ;
	wire        sw_io5_TO_sw_right_SIG_tniu_req_last                        ;
	wire        sw_io5_TO_sw_right_SIG_tniu_rsp_ready                       ;
	wire        sw_io5_TO_sw_right_SIG_tniu_rsp_threshold                   ;
	wire        sw_gpu4_TO_sw_right_SIG_tniu_req_valid                      ;
	wire [89:0] sw_gpu4_TO_sw_right_SIG_tniu_req_payload                    ;
	wire [5:0]  sw_gpu4_TO_sw_right_SIG_tniu_req_srcid                      ;
	wire [5:0]  sw_gpu4_TO_sw_right_SIG_tniu_req_tgtid                      ;
	wire        sw_gpu4_TO_sw_right_SIG_tniu_req_qos                        ;
	wire        sw_gpu4_TO_sw_right_SIG_tniu_req_last                       ;
	wire        sw_gpu4_TO_sw_right_SIG_tniu_rsp_ready                      ;
	wire        sw_gpu4_TO_sw_right_SIG_tniu_rsp_threshold                  ;
	wire        sw_root_TO_sw_right_SIG_iniu1_req_ready                     ;
	wire        sw_root_TO_sw_right_SIG_iniu1_req_threshold                 ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_valid                     ;
	wire [89:0] sw_root_TO_sw_right_SIG_iniu1_rsp_payload                   ;
	wire [5:0]  sw_root_TO_sw_right_SIG_iniu1_rsp_srcid                     ;
	wire [5:0]  sw_root_TO_sw_right_SIG_iniu1_rsp_tgtid                     ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_qos                       ;
	wire        sw_root_TO_sw_right_SIG_iniu1_rsp_last                      ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_valid                       ;
	wire [89:0] sw_dsp6_TO_sw_root_SIG_tniu_req_payload                     ;
	wire [5:0]  sw_dsp6_TO_sw_root_SIG_tniu_req_srcid                       ;
	wire [5:0]  sw_dsp6_TO_sw_root_SIG_tniu_req_tgtid                       ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_qos                         ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_req_last                        ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_rsp_ready                       ;
	wire        sw_dsp6_TO_sw_root_SIG_tniu_rsp_threshold                   ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_valid                      ;
	wire [89:0] sw_right_TO_sw_root_SIG_tniu_req_payload                    ;
	wire [5:0]  sw_right_TO_sw_root_SIG_tniu_req_srcid                      ;
	wire [5:0]  sw_right_TO_sw_root_SIG_tniu_req_tgtid                      ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_qos                        ;
	wire        sw_right_TO_sw_root_SIG_tniu_req_last                       ;
	wire        sw_right_TO_sw_root_SIG_tniu_rsp_ready                      ;
	wire        sw_right_TO_sw_root_SIG_tniu_rsp_threshold                  ;
	wire        sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_ready       ;
	wire        sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_threshold   ;
	wire        sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_valid       ;
	wire [89:0] sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_payload     ;
	wire [5:0]  sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_srcid       ;
	wire [5:0]  sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_tgtid       ;
	wire        sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_qos         ;
	wire        sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_last        ;
	wire        sw_root_TO_sys_tcu_tniu_SIG_tniu_req_last                   ;
	wire [89:0] sw_root_TO_sys_tcu_tniu_SIG_tniu_req_payload                ;
	wire        sw_root_TO_sys_tcu_tniu_SIG_tniu_req_qos                    ;
	wire [5:0]  sw_root_TO_sys_tcu_tniu_SIG_tniu_req_srcid                  ;
	wire [5:0]  sw_root_TO_sys_tcu_tniu_SIG_tniu_req_tgtid                  ;
	wire        sw_root_TO_sys_tcu_tniu_SIG_tniu_req_valid                  ;
	wire        sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_ready                  ;
	wire        sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_threshold              ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_valid                 ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_valid                 ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_valid                 ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_valid                 ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_valid                 ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_ready                 ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_threshold             ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_last                  ;
	wire [89:0] sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_payload               ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_qos                   ;
	wire [5:0]  sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_srcid                 ;
	wire [5:0]  sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_tgtid                 ;
	wire        sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_valid                 ;
	wire        sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_ready                   ;
	wire        sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_threshold               ;
	wire        sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_last                    ;
	wire [89:0] sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_payload                 ;
	wire        sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_qos                     ;
	wire [5:0]  sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_srcid                   ;
	wire [5:0]  sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_tgtid                   ;
	wire        sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_valid                   ;
	wire        sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_ready              ;
	wire        sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_threshold          ;
	wire        sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_last               ;
	wire [89:0] sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_payload            ;
	wire        sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_qos                ;
	wire [5:0]  sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_srcid              ;
	wire [5:0]  sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_tgtid              ;
	wire        sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_valid              ;
	wire        sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_ready                   ;
	wire        sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_threshold               ;
	wire        sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_last                    ;
	wire [89:0] sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_payload                 ;
	wire        sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_qos                     ;
	wire [5:0]  sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_srcid                   ;
	wire [5:0]  sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_tgtid                   ;
	wire        sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_valid                   ;
	wire        sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_ready                ;
	wire        sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_threshold            ;
	wire        sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_last                 ;
	wire [89:0] sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_payload              ;
	wire        sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_qos                  ;
	wire [5:0]  sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_srcid                ;
	wire [5:0]  sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_tgtid                ;
	wire        sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_valid                ;
	wire        sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_ready                  ;
	wire        sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_threshold              ;
	wire        sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_last                   ;
	wire [89:0] sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_payload                ;
	wire        sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_qos                    ;
	wire [5:0]  sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_srcid                  ;
	wire [5:0]  sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_tgtid                  ;
	wire        sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_valid                  ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_ready                 ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_threshold             ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_last                  ;
	wire [89:0] sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_payload               ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_qos                   ;
	wire [5:0]  sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_srcid                 ;
	wire [5:0]  sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_tgtid                 ;
	wire        sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_valid                 ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_ready                 ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_threshold             ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_last                  ;
	wire [89:0] sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_payload               ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_qos                   ;
	wire [5:0]  sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_srcid                 ;
	wire [5:0]  sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_tgtid                 ;
	wire        sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_valid                 ;
	wire        sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_ready                   ;
	wire        sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_threshold               ;
	wire        sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_last                    ;
	wire [89:0] sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_payload                 ;
	wire        sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_qos                     ;
	wire [5:0]  sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_srcid                   ;
	wire [5:0]  sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_tgtid                   ;
	wire        sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_valid                   ;
	wire        sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_ready              ;
	wire        sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_threshold          ;
	wire        sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_last               ;
	wire [89:0] sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_payload            ;
	wire        sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_qos                ;
	wire [5:0]  sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_srcid              ;
	wire [5:0]  sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_tgtid              ;
	wire        sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_valid              ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	soc_dti_sw_dsp6_dti_switch_6i1o_wrap sw_dsp6 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu0_req_ready(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_ready),
		.iniu0_req_payload(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu0_req_srcid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu0_req_last(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu0_req_threshold(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_req_valid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu1_req_ready(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu1_req_srcid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu1_req_last(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu1_req_threshold(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_req_valid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu2_req_ready(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_ready),
		.iniu2_req_payload(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu2_req_srcid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu2_req_last(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu2_req_threshold(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_req_valid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu3_req_ready(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_ready),
		.iniu3_req_payload(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu3_req_srcid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu3_req_last(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu3_req_threshold(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu4_req_valid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu4_req_ready(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_ready),
		.iniu4_req_payload(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu4_req_srcid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu4_req_tgtid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu4_req_qos(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu4_req_last(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu4_req_threshold(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_threshold),
		.iniu4_rsp_valid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_valid),
		.iniu4_rsp_ready(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu4_rsp_payload(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_payload),
		.iniu4_rsp_srcid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_qos),
		.iniu4_rsp_last(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_last),
		.iniu4_rsp_threshold(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu5_req_valid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.iniu5_req_ready(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_ready),
		.iniu5_req_payload(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.iniu5_req_srcid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.iniu5_req_tgtid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.iniu5_req_qos(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.iniu5_req_last(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.iniu5_req_threshold(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_threshold),
		.iniu5_rsp_valid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_valid),
		.iniu5_rsp_ready(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu5_rsp_payload(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_payload),
		.iniu5_rsp_srcid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_srcid),
		.iniu5_rsp_tgtid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_tgtid),
		.iniu5_rsp_qos(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_qos),
		.iniu5_rsp_last(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_last),
		.iniu5_rsp_threshold(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
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
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.iniu0_req_ready(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_ready),
		.iniu0_req_payload(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.iniu0_req_srcid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.iniu0_req_last(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.iniu0_req_threshold(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_req_valid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.iniu1_req_ready(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.iniu1_req_srcid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.iniu1_req_last(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.iniu1_req_threshold(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_req_valid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.iniu2_req_ready(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_ready),
		.iniu2_req_payload(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.iniu2_req_srcid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.iniu2_req_last(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.iniu2_req_threshold(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_req_valid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.iniu3_req_ready(sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_ready),
		.iniu3_req_payload(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.iniu3_req_srcid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.iniu3_req_last(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.iniu3_req_threshold(sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu4_req_valid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.iniu4_req_ready(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_ready),
		.iniu4_req_payload(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.iniu4_req_srcid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.iniu4_req_tgtid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.iniu4_req_qos(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.iniu4_req_last(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.iniu4_req_threshold(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_threshold),
		.iniu4_rsp_valid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_valid),
		.iniu4_rsp_ready(mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu4_rsp_payload(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_payload),
		.iniu4_rsp_srcid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_srcid),
		.iniu4_rsp_tgtid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_tgtid),
		.iniu4_rsp_qos(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_qos),
		.iniu4_rsp_last(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_last),
		.iniu4_rsp_threshold(mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
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
	soc_dti_sw_gpu4_dti_switch_4i1o_wrap sw_gpu4 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.iniu0_req_ready(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_ready),
		.iniu0_req_payload(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.iniu0_req_srcid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.iniu0_req_tgtid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.iniu0_req_qos(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.iniu0_req_last(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.iniu0_req_threshold(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_threshold),
		.iniu0_rsp_valid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_tgtid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_tgtid),
		.iniu0_rsp_qos(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_qos),
		.iniu0_rsp_last(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_last),
		.iniu0_rsp_threshold(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu1_req_valid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.iniu1_req_ready(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.iniu1_req_srcid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.iniu1_req_tgtid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.iniu1_req_qos(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.iniu1_req_last(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.iniu1_req_threshold(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu2_req_valid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.iniu2_req_ready(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_ready),
		.iniu2_req_payload(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.iniu2_req_srcid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.iniu2_req_tgtid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.iniu2_req_qos(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.iniu2_req_last(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.iniu2_req_threshold(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_threshold),
		.iniu2_rsp_valid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_tgtid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_tgtid),
		.iniu2_rsp_qos(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_qos),
		.iniu2_rsp_last(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_last),
		.iniu2_rsp_threshold(dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.iniu3_req_valid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.iniu3_req_ready(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_ready),
		.iniu3_req_payload(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.iniu3_req_srcid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.iniu3_req_tgtid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.iniu3_req_qos(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.iniu3_req_last(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.iniu3_req_threshold(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_threshold),
		.iniu3_rsp_valid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_tgtid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_tgtid),
		.iniu3_rsp_qos(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_qos),
		.iniu3_rsp_last(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_last),
		.iniu3_rsp_threshold(display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.tniu_req_valid(sw_gpu4_TO_sw_right_SIG_tniu_req_valid),
		.tniu_req_ready(sw_right_TO_sw_gpu4_SIG_iniu1_req_ready),
		.tniu_req_payload(sw_gpu4_TO_sw_right_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_gpu4_TO_sw_right_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_gpu4_TO_sw_right_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_gpu4_TO_sw_right_SIG_tniu_req_qos),
		.tniu_req_last(sw_gpu4_TO_sw_right_SIG_tniu_req_last),
		.tniu_req_threshold(sw_right_TO_sw_gpu4_SIG_iniu1_req_threshold),
		.tniu_rsp_valid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(sw_gpu4_TO_sw_right_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_srcid),
		.tniu_rsp_tgtid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_tgtid),
		.tniu_rsp_qos(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_qos),
		.tniu_rsp_last(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_last),
		.tniu_rsp_threshold(sw_gpu4_TO_sw_right_SIG_tniu_rsp_threshold));
	soc_dti_sw_right_dti_switch_2i1o_wrap sw_right (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
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
		.iniu1_req_valid(sw_gpu4_TO_sw_right_SIG_tniu_req_valid),
		.iniu1_req_ready(sw_right_TO_sw_gpu4_SIG_iniu1_req_ready),
		.iniu1_req_payload(sw_gpu4_TO_sw_right_SIG_tniu_req_payload),
		.iniu1_req_srcid(sw_gpu4_TO_sw_right_SIG_tniu_req_srcid),
		.iniu1_req_tgtid(sw_gpu4_TO_sw_right_SIG_tniu_req_tgtid),
		.iniu1_req_qos(sw_gpu4_TO_sw_right_SIG_tniu_req_qos),
		.iniu1_req_last(sw_gpu4_TO_sw_right_SIG_tniu_req_last),
		.iniu1_req_threshold(sw_right_TO_sw_gpu4_SIG_iniu1_req_threshold),
		.iniu1_rsp_valid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(sw_gpu4_TO_sw_right_SIG_tniu_rsp_ready),
		.iniu1_rsp_payload(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_tgtid(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_tgtid),
		.iniu1_rsp_qos(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_qos),
		.iniu1_rsp_last(sw_right_TO_sw_gpu4_SIG_iniu1_rsp_last),
		.iniu1_rsp_threshold(sw_gpu4_TO_sw_right_SIG_tniu_rsp_threshold),
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
		.clk(clk_noc),
		.rst_n(rst_noc_n),
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
		.tniu_req_valid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_valid),
		.tniu_req_ready(sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_ready),
		.tniu_req_payload(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_srcid),
		.tniu_req_tgtid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_tgtid),
		.tniu_req_qos(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_qos),
		.tniu_req_last(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_last),
		.tniu_req_threshold(sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_threshold),
		.tniu_rsp_valid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_valid),
		.tniu_rsp_ready(sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_payload),
		.tniu_rsp_srcid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_srcid),
		.tniu_rsp_tgtid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_tgtid),
		.tniu_rsp_qos(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_qos),
		.tniu_rsp_last(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_last),
		.tniu_rsp_threshold(sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_threshold));
	sys_tcu_tniu_node sys_tcu_tniu (
		.clk_sys_clk_sys_clk(sys_tcu_tniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(sys_tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(sys_tcu_tniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(sys_tcu_tniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(sys_tcu_tniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.pchnl_ctrl_pchnl_ctrl_paccept(sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_last),
		.top_req_top_req_req_payload(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_payload),
		.top_req_top_req_req_qos(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_qos),
		.top_req_top_req_req_ready(sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_ready),
		.top_req_top_req_req_srcid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_srcid),
		.top_req_top_req_req_tgtid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_tgtid),
		.top_req_top_req_req_threshold(sys_tcu_tniu_TO_sw_root_SIG_top_req_top_req_req_threshold),
		.top_req_top_req_req_valid(sw_root_TO_sys_tcu_tniu_SIG_tniu_req_valid),
		.top_rsp_top_rsp_rsp_last(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(sw_root_TO_sys_tcu_tniu_SIG_tniu_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sys_tcu_tniu_TO_sw_root_SIG_top_rsp_top_rsp_rsp_valid));
	dsp_ss0_iniu_node dsp_ss0_iniu (
		.clk_sys_clk_sys_clk(dsp_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss0_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss0_iniu_SIG_iniu0_rsp_valid));
	dsp_ss1_iniu_node dsp_ss1_iniu (
		.clk_sys_clk_sys_clk(dsp_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss1_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss1_iniu_SIG_iniu1_rsp_valid));
	dsp_ss2_iniu_node dsp_ss2_iniu (
		.clk_sys_clk_sys_clk(dsp_ss2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss2_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss2_iniu_SIG_iniu2_rsp_valid));
	dsp_ss3_iniu_node dsp_ss3_iniu (
		.clk_sys_clk_sys_clk(dsp_ss3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss3_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss3_iniu_SIG_iniu3_rsp_valid));
	dsp_ss4_iniu_node dsp_ss4_iniu (
		.clk_sys_clk_sys_clk(dsp_ss4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_ready),
		.top_req_top_req_req_srcid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_req_threshold),
		.top_req_top_req_req_valid(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss4_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss4_iniu_SIG_iniu4_rsp_valid));
	dsp_ss5_iniu_node dsp_ss5_iniu (
		.clk_sys_clk_sys_clk(dsp_ss5_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dsp_ss5_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dsp_ss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dsp_ss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dsp_ss5_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dsp_ss5_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dsp_ss5_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dsp_ss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_ready),
		.top_req_top_req_req_srcid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_req_threshold),
		.top_req_top_req_req_valid(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dsp_ss5_iniu_TO_sw_dsp6_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_dsp6_TO_dsp_ss5_iniu_SIG_iniu5_rsp_valid));
	vpu_ss_iniu_node vpu_ss_iniu (
		.clk_sys_clk_sys_clk(vpu_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(vpu_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(vpu_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(vpu_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(vpu_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(vpu_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(vpu_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_io5_TO_vpu_ss_iniu_SIG_iniu0_rsp_valid));
	pcie_rtg_ss_iniu_node pcie_rtg_ss_iniu (
		.clk_sys_clk_sys_clk(pcie_rtg_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(pcie_rtg_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(pcie_rtg_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(pcie_rtg_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(pcie_rtg_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(pcie_rtg_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(pcie_rtg_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(pcie_rtg_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(pcie_rtg_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_io5_TO_pcie_rtg_ss_iniu_SIG_iniu1_rsp_valid));
	ufs_ss_iniu_node ufs_ss_iniu (
		.clk_sys_clk_sys_clk(ufs_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(ufs_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(ufs_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(ufs_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(ufs_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(ufs_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(ufs_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_io5_TO_ufs_ss_iniu_SIG_iniu2_rsp_valid));
	camera_ss_iniu_node camera_ss_iniu (
		.clk_sys_clk_sys_clk(camera_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(camera_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(camera_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(camera_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(camera_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_io5_TO_camera_ss_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(camera_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(camera_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_io5_TO_camera_ss_iniu_SIG_iniu3_rsp_valid));
	mipi_ss_iniu_node mipi_ss_iniu (
		.clk_sys_clk_sys_clk(mipi_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(mipi_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(mipi_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(mipi_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(mipi_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_ready),
		.top_req_top_req_req_srcid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_req_threshold),
		.top_req_top_req_req_valid(mipi_ss_iniu_TO_sw_io5_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(mipi_ss_iniu_TO_sw_io5_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_io5_TO_mipi_ss_iniu_SIG_iniu4_rsp_valid));
	gpu_ss0_iniu_node gpu_ss0_iniu (
		.clk_sys_clk_sys_clk(gpu_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(gpu_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(gpu_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(gpu_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(gpu_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_ready),
		.top_req_top_req_req_srcid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_req_threshold),
		.top_req_top_req_req_valid(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(gpu_ss0_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_gpu4_TO_gpu_ss0_iniu_SIG_iniu0_rsp_valid));
	gpu_ss1_iniu_node gpu_ss1_iniu (
		.clk_sys_clk_sys_clk(gpu_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(gpu_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(gpu_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(gpu_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(gpu_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_ready),
		.top_req_top_req_req_srcid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_req_threshold),
		.top_req_top_req_req_valid(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(gpu_ss1_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_gpu4_TO_gpu_ss1_iniu_SIG_iniu1_rsp_valid));
	dp_ss_iniu_node dp_ss_iniu (
		.clk_sys_clk_sys_clk(dp_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(dp_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(dp_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(dp_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(dp_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_ready),
		.top_req_top_req_req_srcid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_req_threshold),
		.top_req_top_req_req_valid(dp_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(dp_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_gpu4_TO_dp_ss_iniu_SIG_iniu2_rsp_valid));
	display_ss_iniu_node display_ss_iniu (
		.clk_sys_clk_sys_clk(display_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk),
		.rst_sys_n_rst_sys_n_rst_n(display_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_dti_req_req_tdata(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata),
		.dti_req_dti_req_req_tkeep(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep),
		.dti_req_dti_req_req_tlast(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast),
		.dti_req_dti_req_req_tready(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready),
		.dti_req_dti_req_req_ttid(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid),
		.dti_req_dti_req_req_tvalid(display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid),
		.dti_rsp_dti_rsp_rsp_tdata(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_dti_rsp_rsp_tkeep(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_dti_rsp_rsp_tlast(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_dti_rsp_rsp_tready(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_dti_rsp_rsp_ttid(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_dti_rsp_rsp_tvalid(display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup_req_twakeup(display_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup_rsp_twakeup(display_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.timeout_val_timeout_val_timeout_val(display_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_pchnl_ctrl_paccept(display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pchnl_ctrl_pactive(display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pchnl_ctrl_pdeny(display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_pchnl_ctrl_preq(display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pchnl_ctrl_pstate(display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate),
		.top_req_top_req_req_last(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_last),
		.top_req_top_req_req_payload(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_payload),
		.top_req_top_req_req_qos(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_qos),
		.top_req_top_req_req_ready(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_ready),
		.top_req_top_req_req_srcid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_srcid),
		.top_req_top_req_req_tgtid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_tgtid),
		.top_req_top_req_req_threshold(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_req_threshold),
		.top_req_top_req_req_valid(display_ss_iniu_TO_sw_gpu4_SIG_top_req_top_req_req_valid),
		.top_rsp_top_rsp_rsp_last(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_last),
		.top_rsp_top_rsp_rsp_payload(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_top_rsp_rsp_qos(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_qos),
		.top_rsp_top_rsp_rsp_ready(display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_ready),
		.top_rsp_top_rsp_rsp_srcid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_top_rsp_rsp_tgtid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_tgtid),
		.top_rsp_top_rsp_rsp_threshold(display_ss_iniu_TO_sw_gpu4_SIG_top_rsp_top_rsp_rsp_threshold),
		.top_rsp_top_rsp_rsp_valid(sw_gpu4_TO_display_ss_iniu_SIG_iniu3_rsp_valid));

endmodule
//[UHDL]Content End [md5:94a052acf116cf49c3d900c3079806dd]


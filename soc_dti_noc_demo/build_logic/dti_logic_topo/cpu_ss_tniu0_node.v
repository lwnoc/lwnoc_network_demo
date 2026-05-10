//[UHDL]Content Start [md5:a3cbc67099b411bfc80509a1e2b617f8]
module cpu_ss_tniu0_node (
	input         clk_sys_clk_sys_clk                                                                                                                 ,
	input         rst_sys_n_rst_sys_n_rst_n                                                                                                           ,
	input         clk_noc                                                                                                                             ,
	input         rst_noc_n                                                                                                                           ,
	output [79:0] dti_req_dti_req_req_tdata                                                                                                           ,
	output [9:0]  dti_req_dti_req_req_tkeep                                                                                                           ,
	output        dti_req_dti_req_req_tlast                                                                                                           ,
	input         dti_req_dti_req_req_tready                                                                                                          ,
	output [5:0]  dti_req_dti_req_req_ttid                                                                                                            ,
	output        dti_req_dti_req_req_tvalid                                                                                                          ,
	input  [79:0] dti_rsp_dti_rsp_rsp_tdata                                                                                                           ,
	input  [9:0]  dti_rsp_dti_rsp_rsp_tkeep                                                                                                           ,
	input         dti_rsp_dti_rsp_rsp_tlast                                                                                                           ,
	output        dti_rsp_dti_rsp_rsp_tready                                                                                                          ,
	input  [5:0]  dti_rsp_dti_rsp_rsp_ttid                                                                                                            ,
	input         dti_rsp_dti_rsp_rsp_tvalid                                                                                                          ,
	output        req_twakeup_req_twakeup_req_twakeup                                                                                                 ,
	input         rsp_twakeup_rsp_twakeup_rsp_twakeup                                                                                                 ,
	output        pchnl_ctrl_pchnl_ctrl_paccept                                                                                                       ,
	output [1:0]  pchnl_ctrl_pchnl_ctrl_pactive                                                                                                       ,
	output        pchnl_ctrl_pchnl_ctrl_pdeny                                                                                                         ,
	input         pchnl_ctrl_pchnl_ctrl_preq                                                                                                          ,
	input  [1:0]  pchnl_ctrl_pchnl_ctrl_pstate                                                                                                        ,
	input         top_req_data_top_req_data_req_last                                                                                                  ,
	input  [89:0] top_req_data_top_req_data_req_payload                                                                                               ,
	input         top_req_data_top_req_data_req_qos                                                                                                   ,
	output        top_req_data_top_req_data_req_ready                                                                                                 ,
	input  [5:0]  top_req_data_top_req_data_req_srcid                                                                                                 ,
	input  [5:0]  top_req_data_top_req_data_req_tgtid                                                                                                 ,
	output        top_req_data_top_req_data_req_threshold                                                                                             ,
	input         top_req_data_top_req_data_req_valid                                                                                                 ,
	output        top_rsp_top_rsp_rsp_last                                                                                                            ,
	output [89:0] top_rsp_top_rsp_rsp_payload                                                                                                         ,
	output        top_rsp_top_rsp_rsp_qos                                                                                                             ,
	input         top_rsp_top_rsp_rsp_ready                                                                                                           ,
	output [5:0]  top_rsp_top_rsp_rsp_srcid                                                                                                           ,
	output [5:0]  top_rsp_top_rsp_rsp_tgtid                                                                                                           ,
	input         top_rsp_top_rsp_rsp_threshold                                                                                                       ,
	output        top_rsp_top_rsp_rsp_valid                                                                                                           ,
	output        cpu_ss_tniu0_sys_wrap_cpu_ss_tniu0_sys_side_req_afifo_sb_err_porting_cpu_ss_tniu0_sys_side_req_afifo_sb_err_porting_req_afifo_sb_err,
	output        cpu_ss_tniu0_sys_wrap_cpu_ss_tniu0_sys_side_req_afifo_db_err_porting_cpu_ss_tniu0_sys_side_req_afifo_db_err_porting_req_afifo_db_err,
	output        cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,
	output        cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err);

	//Wire define for this module.

	//Wire define for sub module.
	wire [112:0] top_wrap_TO_sys_wrap_SIG_async_fifo_req_pld_sync  ;
	wire [9:0]   top_wrap_TO_sys_wrap_SIG_async_fifo_req_wptr_async;
	wire [9:0]   top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_async;
	wire [9:0]   top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_sync ;
	wire [12:0]  top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req  ;
	wire [9:0]   sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_async;
	wire [9:0]   sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_sync ;
	wire [112:0] sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_pld_sync  ;
	wire [9:0]   sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_wptr_async;
	wire [12:0]  sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req  ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	cpu_ss_tniu0_sys_wrap sys_wrap (
		.clk_sys_clk(clk_sys_clk_sys_clk),
		.rst_sys_n_rst_n(rst_sys_n_rst_sys_n_rst_n),
		.dti_req_req_tdata(dti_req_dti_req_req_tdata),
		.dti_req_req_tkeep(dti_req_dti_req_req_tkeep),
		.dti_req_req_tlast(dti_req_dti_req_req_tlast),
		.dti_req_req_tready(dti_req_dti_req_req_tready),
		.dti_req_req_ttid(dti_req_dti_req_req_ttid),
		.dti_req_req_tvalid(dti_req_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(dti_rsp_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(dti_rsp_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(dti_rsp_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(dti_rsp_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(dti_rsp_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(dti_rsp_dti_rsp_rsp_tvalid),
		.req_twakeup_req_twakeup(req_twakeup_req_twakeup_req_twakeup),
		.rsp_twakeup_rsp_twakeup(rsp_twakeup_rsp_twakeup_rsp_twakeup),
		.pchnl_ctrl_paccept(pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(pchnl_ctrl_pchnl_ctrl_pstate),
		.async_fifo_req_pld_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.cpu_ss_tniu0_sys_side_req_afifo_sb_err_porting_req_afifo_sb_err(cpu_ss_tniu0_sys_wrap_cpu_ss_tniu0_sys_side_req_afifo_sb_err_porting_cpu_ss_tniu0_sys_side_req_afifo_sb_err_porting_req_afifo_sb_err),
		.cpu_ss_tniu0_sys_side_req_afifo_db_err_porting_req_afifo_db_err(cpu_ss_tniu0_sys_wrap_cpu_ss_tniu0_sys_side_req_afifo_db_err_porting_cpu_ss_tniu0_sys_side_req_afifo_db_err_porting_req_afifo_db_err));
	cpu_ss_tniu0_top_wrap top_wrap (
		.clk_noc(clk_noc),
		.rst_noc_n(rst_noc_n),
		.async_fifo_req_pld_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.top_req_data_req_last(top_req_data_top_req_data_req_last),
		.top_req_data_req_payload(top_req_data_top_req_data_req_payload),
		.top_req_data_req_qos(top_req_data_top_req_data_req_qos),
		.top_req_data_req_ready(top_req_data_top_req_data_req_ready),
		.top_req_data_req_srcid(top_req_data_top_req_data_req_srcid),
		.top_req_data_req_tgtid(top_req_data_top_req_data_req_tgtid),
		.top_req_data_req_threshold(top_req_data_top_req_data_req_threshold),
		.top_req_data_req_valid(top_req_data_top_req_data_req_valid),
		.top_rsp_rsp_last(top_rsp_top_rsp_rsp_last),
		.top_rsp_rsp_payload(top_rsp_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(top_rsp_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(top_rsp_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(top_rsp_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(top_rsp_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(top_rsp_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(top_rsp_top_rsp_rsp_valid),
		.cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err(cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err),
		.cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err(cpu_ss_tniu0_top_wrap_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_cpu_ss_tniu0_top_side_rsp_afifo_db_err_porting_rsp_afifo_db_err));

endmodule
//[UHDL]Content End [md5:a3cbc67099b411bfc80509a1e2b617f8]


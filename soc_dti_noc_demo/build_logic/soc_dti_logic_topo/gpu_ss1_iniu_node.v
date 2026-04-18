//[UHDL]Content Start [md5:9f9d1dba2c7dab18619e8506a512029d]
module gpu_ss1_iniu_node
	import lwnoc_lp_define_package::*;
	import lwnoc_lp_struct_package::*;
	(
	input                                                   clk_sys_clk            ,
	input                                                   rst_sys_n_rst_n        ,
	input                                                   clk_top                ,
	input                                                   rst_top_n              ,
	input  [79:0]                                           dti_req_req_tdata      ,
	input  [9:0]                                            dti_req_req_tkeep      ,
	input                                                   dti_req_req_tlast      ,
	output                                                  dti_req_req_tready     ,
	input  [5:0]                                            dti_req_req_ttid       ,
	input                                                   dti_req_req_tvalid     ,
	output [79:0]                                           dti_rsp_rsp_tdata      ,
	output [9:0]                                            dti_rsp_rsp_tkeep      ,
	output                                                  dti_rsp_rsp_tlast      ,
	input                                                   dti_rsp_rsp_tready     ,
	output [5:0]                                            dti_rsp_rsp_ttid       ,
	output                                                  dti_rsp_rsp_tvalid     ,
	input  [9:0]                                            timeout_val_timeout_val,
	output                                                  pchnl_ctrl_paccept     ,
	output logic [$bits(lwnoc_lp_define_package::lwnoc_pchannel_active_t)-1:0] pchnl_ctrl_pactive     ,
	output                                                  pchnl_ctrl_pdeny       ,
	input                                                   pchnl_ctrl_preq        ,
	input logic [$bits(lwnoc_lp_define_package::lwnoc_pchannel_state_t)-1:0]  pchnl_ctrl_pstate      ,
	output                                                  top_req_req_last       ,
	output [89:0]                                           top_req_req_payload    ,
	input                                                   top_req_req_ready      ,
	output [5:0]                                            top_req_req_srcid      ,
	output                                                  top_req_req_valid      ,
	input                                                   top_rsp_rsp_last       ,
	input  [89:0]                                           top_rsp_rsp_payload    ,
	output                                                  top_rsp_rsp_ready      ,
	input  [5:0]                                            top_rsp_rsp_srcid      ,
	input                                                   top_rsp_rsp_valid      );

	//Wire define for this module.

	//Flattened LP boundary typedef bridge.
	lwnoc_lp_define_package::lwnoc_pchannel_active_t pchnl_ctrl_pactive__typed;
	lwnoc_lp_define_package::lwnoc_pchannel_state_t pchnl_ctrl_pstate__typed;

	assign pchnl_ctrl_pactive = pchnl_ctrl_pactive__typed;
	assign pchnl_ctrl_pstate__typed = lwnoc_lp_define_package::lwnoc_pchannel_state_t'(pchnl_ctrl_pstate);

	//Wire define for sub module.
	wire                                           [15:0]  top_side_TO_sys_side_SIG_req_rptr_async     ;
	wire                                           [15:0]  top_side_TO_sys_side_SIG_req_rptr_sync      ;
	wire                                           [15:0]  top_side_TO_sys_side_SIG_rsp_wptr_async     ;
	wire                                           [104:0] top_side_TO_sys_side_SIG_rsp_pld_sync       ;
	lwnoc_lp_struct_package::lwnoc_lp_req_signal_t         top_side_TO_sys_side_SIG_lp_hub_tx_req      ;
	wire                                           [5:0]   top_ext_tieoff_TO_top_side_SIG_rsp_tgtid    ;
	wire                                                   top_ext_tieoff_TO_top_side_SIG_rsp_qos      ;
	wire                                                   top_ext_tieoff_TO_top_side_SIG_req_threshold;
	wire                                           [15:0]  sys_side_TO_top_side_SIG_req_wptr_async     ;
	wire                                           [104:0] sys_side_TO_top_side_SIG_req_pld_sync       ;
	wire                                           [15:0]  sys_side_TO_top_side_SIG_rsp_rptr_async     ;
	wire                                           [15:0]  sys_side_TO_top_side_SIG_rsp_rptr_sync      ;
	lwnoc_lp_struct_package::lwnoc_lp_req_signal_t         sys_side_TO_top_side_SIG_lp_hub_tx_req      ;
	wire                                                   top_side_TO_top_ext_tieoff_SIG_req_qos      ;
	wire                                           [5:0]   top_side_TO_top_ext_tieoff_SIG_req_tgtid    ;
	wire                                                   top_side_TO_top_ext_tieoff_SIG_rsp_threshold;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	gpu_ss1_dti_pr_iniu_async_sys_side #(
		.TBU_NUM(32'd1),
		.TRANSACTION_MAX_NUM(32'd8),
		.ASYNC_FIFO_DEPTH(32'd16),
		.TIME_OUT_WIDTH(32'd10))
	sys_side (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.req_tvalid(dti_req_req_tvalid),
		.req_tdata(dti_req_req_tdata),
		.req_tkeep(dti_req_req_tkeep),
		.req_tlast(dti_req_req_tlast),
		.req_ttid(dti_req_req_ttid),
		.req_tready(dti_req_req_tready),
		.rsp_tvalid(dti_rsp_rsp_tvalid),
		.rsp_tdata(dti_rsp_rsp_tdata),
		.rsp_tkeep(dti_rsp_rsp_tkeep),
		.rsp_tlast(dti_rsp_rsp_tlast),
		.rsp_ttid(dti_rsp_rsp_ttid),
		.rsp_tready(dti_rsp_rsp_tready),
		.req_twakeup(),
		.rsp_twakeup(),
		.req_wptr_async(sys_side_TO_top_side_SIG_req_wptr_async),
		.req_rptr_async(top_side_TO_sys_side_SIG_req_rptr_async),
		.req_rptr_sync(top_side_TO_sys_side_SIG_req_rptr_sync),
		.req_pld_sync(sys_side_TO_top_side_SIG_req_pld_sync),
		.rsp_wptr_async(top_side_TO_sys_side_SIG_rsp_wptr_async),
		.rsp_rptr_async(sys_side_TO_top_side_SIG_rsp_rptr_async),
		.rsp_rptr_sync(sys_side_TO_top_side_SIG_rsp_rptr_sync),
		.rsp_pld_sync(top_side_TO_sys_side_SIG_rsp_pld_sync),
		.timeout_val(timeout_val_timeout_val),
		.preq(pchnl_ctrl_preq),
		.pstate(pchnl_ctrl_pstate__typed),
		.pactive(pchnl_ctrl_pactive__typed),
		.paccept(pchnl_ctrl_paccept),
		.pdeny(pchnl_ctrl_pdeny),
		.lp_hub_rx_req(top_side_TO_sys_side_SIG_lp_hub_tx_req),
		.lp_hub_tx_req(sys_side_TO_top_side_SIG_lp_hub_tx_req));
	dti_iniu_top_dti_pr_iniu_async_top_side top_side (
		.clk(clk_top),
		.rst_n(rst_top_n),
		.rsp_valid(top_rsp_rsp_valid),
		.rsp_payload(top_rsp_rsp_payload),
		.rsp_last(top_rsp_rsp_last),
		.rsp_srcid(top_rsp_rsp_srcid),
		.rsp_tgtid(top_ext_tieoff_TO_top_side_SIG_rsp_tgtid),
		.rsp_qos(top_ext_tieoff_TO_top_side_SIG_rsp_qos),
		.rsp_threshold(top_side_TO_top_ext_tieoff_SIG_rsp_threshold),
		.rsp_ready(top_rsp_rsp_ready),
		.req_valid(top_req_req_valid),
		.req_payload(top_req_req_payload),
		.req_last(top_req_req_last),
		.req_srcid(top_req_req_srcid),
		.req_tgtid(top_side_TO_top_ext_tieoff_SIG_req_tgtid),
		.req_qos(top_side_TO_top_ext_tieoff_SIG_req_qos),
		.req_threshold(top_ext_tieoff_TO_top_side_SIG_req_threshold),
		.req_ready(top_req_req_ready),
		.req_wptr_async(sys_side_TO_top_side_SIG_req_wptr_async),
		.req_rptr_async(top_side_TO_sys_side_SIG_req_rptr_async),
		.req_rptr_sync(top_side_TO_sys_side_SIG_req_rptr_sync),
		.req_pld_sync(sys_side_TO_top_side_SIG_req_pld_sync),
		.rsp_wptr_async(top_side_TO_sys_side_SIG_rsp_wptr_async),
		.rsp_rptr_async(sys_side_TO_top_side_SIG_rsp_rptr_async),
		.rsp_rptr_sync(sys_side_TO_top_side_SIG_rsp_rptr_sync),
		.rsp_pld_sync(top_side_TO_sys_side_SIG_rsp_pld_sync),
		.lp_hub_rx_req(sys_side_TO_top_side_SIG_lp_hub_tx_req),
		.lp_hub_tx_req(top_side_TO_sys_side_SIG_lp_hub_tx_req));
	DtiIniuTopExtTieoffComponent top_ext_tieoff (
		.req_qos(top_side_TO_top_ext_tieoff_SIG_req_qos),
		.req_threshold(top_ext_tieoff_TO_top_side_SIG_req_threshold),
		.req_tgtid(top_side_TO_top_ext_tieoff_SIG_req_tgtid),
		.rsp_qos(top_ext_tieoff_TO_top_side_SIG_rsp_qos),
		.rsp_threshold(top_side_TO_top_ext_tieoff_SIG_rsp_threshold),
		.rsp_tgtid(top_ext_tieoff_TO_top_side_SIG_rsp_tgtid));

endmodule
//[UHDL]Content End [md5:9f9d1dba2c7dab18619e8506a512029d]


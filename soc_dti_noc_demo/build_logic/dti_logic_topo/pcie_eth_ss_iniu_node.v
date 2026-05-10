//[UHDL]Content Start [md5:0289536c9505a467548dc358aeb0a40f]
module pcie_eth_ss_iniu_node (
	input         clk_sys_clk_sys_clk                                                                                                              ,
	input         rst_sys_n_rst_sys_n_rst_n                                                                                                        ,
	input         clk_noc                                                                                                                          ,
	input         rst_noc_n                                                                                                                        ,
	input  [79:0] dti_req_dti_req_req_tdata                                                                                                        ,
	input  [9:0]  dti_req_dti_req_req_tkeep                                                                                                        ,
	input         dti_req_dti_req_req_tlast                                                                                                        ,
	output        dti_req_dti_req_req_tready                                                                                                       ,
	input  [5:0]  dti_req_dti_req_req_ttid                                                                                                         ,
	input         dti_req_dti_req_req_tvalid                                                                                                       ,
	output [79:0] dti_rsp_dti_rsp_rsp_tdata                                                                                                        ,
	output [9:0]  dti_rsp_dti_rsp_rsp_tkeep                                                                                                        ,
	output        dti_rsp_dti_rsp_rsp_tlast                                                                                                        ,
	input         dti_rsp_dti_rsp_rsp_tready                                                                                                       ,
	output [5:0]  dti_rsp_dti_rsp_rsp_ttid                                                                                                         ,
	output        dti_rsp_dti_rsp_rsp_tvalid                                                                                                       ,
	input         req_twakeup_req_twakeup_req_twakeup                                                                                              ,
	output        rsp_twakeup_rsp_twakeup_rsp_twakeup                                                                                              ,
	input  [9:0]  timeout_val_timeout_val_timeout_val                                                                                              ,
	output        pchnl_ctrl_pchnl_ctrl_paccept                                                                                                    ,
	output [1:0]  pchnl_ctrl_pchnl_ctrl_pactive                                                                                                    ,
	output        pchnl_ctrl_pchnl_ctrl_pdeny                                                                                                      ,
	input         pchnl_ctrl_pchnl_ctrl_preq                                                                                                       ,
	input  [1:0]  pchnl_ctrl_pchnl_ctrl_pstate                                                                                                     ,
	output        top_req_top_req_req_last                                                                                                         ,
	output [89:0] top_req_top_req_req_payload                                                                                                      ,
	output        top_req_top_req_req_qos                                                                                                          ,
	input         top_req_top_req_req_ready                                                                                                        ,
	output [5:0]  top_req_top_req_req_srcid                                                                                                        ,
	output [5:0]  top_req_top_req_req_tgtid                                                                                                        ,
	input         top_req_top_req_req_threshold                                                                                                    ,
	output        top_req_top_req_req_valid                                                                                                        ,
	input         top_rsp_top_rsp_rsp_last                                                                                                         ,
	input  [89:0] top_rsp_top_rsp_rsp_payload                                                                                                      ,
	input         top_rsp_top_rsp_rsp_qos                                                                                                          ,
	output        top_rsp_top_rsp_rsp_ready                                                                                                        ,
	input  [5:0]  top_rsp_top_rsp_rsp_srcid                                                                                                        ,
	input  [5:0]  top_rsp_top_rsp_rsp_tgtid                                                                                                        ,
	output        top_rsp_top_rsp_rsp_threshold                                                                                                    ,
	input         top_rsp_top_rsp_rsp_valid                                                                                                        ,
	output        pcie_eth_ss_sys_wrap_pcie_eth_ss_sys_side_rsp_afifo_sb_err_porting_pcie_eth_ss_sys_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err,
	output        pcie_eth_ss_sys_wrap_pcie_eth_ss_sys_side_rsp_afifo_db_err_porting_pcie_eth_ss_sys_side_rsp_afifo_db_err_porting_rsp_afifo_db_err,
	output        pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err                                                          ,
	output        pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err                                                          );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0]  top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_async;
	wire [15:0]  top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_sync ;
	wire [112:0] top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_pld_sync  ;
	wire [15:0]  top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_wptr_async;
	wire [12:0]  top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req  ;
	wire [112:0] sys_wrap_TO_top_wrap_SIG_async_fifo_req_pld_sync  ;
	wire [15:0]  sys_wrap_TO_top_wrap_SIG_async_fifo_req_wptr_async;
	wire [15:0]  sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_async;
	wire [15:0]  sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_sync ;
	wire [12:0]  sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req  ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	pcie_eth_ss_sys_wrap sys_wrap (
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
		.timeout_val_timeout_val(timeout_val_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(pchnl_ctrl_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(pchnl_ctrl_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(pchnl_ctrl_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(pchnl_ctrl_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(pchnl_ctrl_pchnl_ctrl_pstate),
		.async_fifo_req_pld_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.pcie_eth_ss_sys_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err(pcie_eth_ss_sys_wrap_pcie_eth_ss_sys_side_rsp_afifo_sb_err_porting_pcie_eth_ss_sys_side_rsp_afifo_sb_err_porting_rsp_afifo_sb_err),
		.pcie_eth_ss_sys_side_rsp_afifo_db_err_porting_rsp_afifo_db_err(pcie_eth_ss_sys_wrap_pcie_eth_ss_sys_side_rsp_afifo_db_err_porting_pcie_eth_ss_sys_side_rsp_afifo_db_err_porting_rsp_afifo_db_err));
	pcie_eth_ss_top_wrap top_wrap (
		.clk_noc(clk_noc),
		.rst_noc_n(rst_noc_n),
		.async_fifo_req_pld_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_req_pld_sync),
		.async_fifo_req_rptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_async),
		.async_fifo_req_rptr_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_req_rptr_sync),
		.async_fifo_req_wptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_req_wptr_async),
		.async_fifo_rsp_pld_sync(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_pld_sync),
		.async_fifo_rsp_rptr_async(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_async),
		.async_fifo_rsp_rptr_sync(sys_wrap_TO_top_wrap_SIG_async_fifo_rsp_rptr_sync),
		.async_fifo_rsp_wptr_async(top_wrap_TO_sys_wrap_SIG_async_fifo_rsp_wptr_async),
		.lp_top_tx_lp_hub_tx_req(top_wrap_TO_sys_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.lp_top_rx_lp_hub_rx_req(sys_wrap_TO_top_wrap_SIG_lp_top_tx_lp_hub_tx_req),
		.top_req_req_last(top_req_top_req_req_last),
		.top_req_req_payload(top_req_top_req_req_payload),
		.top_req_req_qos(top_req_top_req_req_qos),
		.top_req_req_ready(top_req_top_req_req_ready),
		.top_req_req_srcid(top_req_top_req_req_srcid),
		.top_req_req_tgtid(top_req_top_req_req_tgtid),
		.top_req_req_threshold(top_req_top_req_req_threshold),
		.top_req_req_valid(top_req_top_req_req_valid),
		.top_rsp_rsp_last(top_rsp_top_rsp_rsp_last),
		.top_rsp_rsp_payload(top_rsp_top_rsp_rsp_payload),
		.top_rsp_rsp_qos(top_rsp_top_rsp_rsp_qos),
		.top_rsp_rsp_ready(top_rsp_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(top_rsp_top_rsp_rsp_srcid),
		.top_rsp_rsp_tgtid(top_rsp_top_rsp_rsp_tgtid),
		.top_rsp_rsp_threshold(top_rsp_top_rsp_rsp_threshold),
		.top_rsp_rsp_valid(top_rsp_top_rsp_rsp_valid),
		.afifo_sb_err_req_afifo_sb_err(pcie_eth_ss_top_wrap_afifo_sb_err_porting_afifo_sb_err_req_afifo_sb_err),
		.afifo_db_err_req_afifo_db_err(pcie_eth_ss_top_wrap_afifo_db_err_porting_afifo_db_err_req_afifo_db_err));

endmodule
//[UHDL]Content End [md5:0289536c9505a467548dc358aeb0a40f]


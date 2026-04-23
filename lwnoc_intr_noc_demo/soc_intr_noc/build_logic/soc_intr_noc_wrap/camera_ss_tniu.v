//[UHDL]Content Start [md5:e3ccce914a73599749abe6aaa0e93f34]
module camera_ss_tniu (
	input           clk_sys_clk_sys_func_clk                                   ,
	input           rst_sys_n_rst_sys_func_n_rst_n                             ,
	input           clk_noc                                                    ,
	input           rst_noc_n                                                  ,
	input  [7:0]    tniu_tgt_id_tniu_tgt_id_tniu_tgt_id                        ,
	output [4095:0] v_interrupt_v_interrupt_v_interrupt                        ,
	output [127:0]  v_merge_interrupt_v_merge_interrupt_v_merge_interrupt      ,
	input  [31:0]   apb_apb_p_addr                                             ,
	input           apb_apb_p_enable                                           ,
	output [31:0]   apb_apb_p_rdata                                            ,
	output          apb_apb_p_ready                                            ,
	input           apb_apb_p_sel                                              ,
	output          apb_apb_p_slverr                                           ,
	input  [31:0]   apb_apb_p_wdata                                            ,
	input           apb_apb_p_write                                            ,
	input  [9:0]    timeout_val                                                ,
	input           pring_in_if_pring_in_if_pring_in_if_pring_in_if_last       ,
	input  [39:0]   pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload    ,
	input  [3:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos        ,
	output          pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready      ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid      ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid      ,
	input           pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid      ,
	output          pring_out_if_pring_out_if_pring_out_if_pring_out_if_last   ,
	output [39:0]   pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload,
	output [3:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos    ,
	input           pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready  ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid  ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid  ,
	output          pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid  ,
	input           nring_in_if_nring_in_if_nring_in_if_nring_in_if_last       ,
	input  [39:0]   nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload    ,
	input  [3:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos        ,
	output          nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready      ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid      ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid      ,
	input           nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid      ,
	output          nring_out_if_nring_out_if_nring_out_if_nring_out_if_last   ,
	output [39:0]   nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload,
	output [3:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos    ,
	input           nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready  ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid  ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid  ,
	output          nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid  ,
	output          pchannel_pchannel_paccept                                  ,
	output [1:0]    pchannel_pchannel_pactive                                  ,
	output          pchannel_pchannel_pdeny                                    ,
	input           pchannel_pchannel_preq                                     ,
	input  [1:0]    pchannel_pchannel_pstate                                   );

	//Wire define for this module.

	//Wire define for sub module.
	wire [61:0] tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_pld_sync               ;
	wire [9:0]  tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_wptr_async             ;
	wire [8:0]  tniu_top_wrap_TO_tniu_sys_wrap_SIG_lp_async_s_async_master_hub_tx_req;
	wire [9:0]  tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_async             ;
	wire [9:0]  tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_sync              ;
	wire [8:0]  tniu_sys_wrap_TO_tniu_top_wrap_SIG_lp_async_m_async_master_hub_rx_req;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	camera_ss_tniu_sys_wrap tniu_sys_wrap (
		.clk_sys_func_clk(clk_sys_clk_sys_func_clk),
		.rst_sys_func_n_rst_n(rst_sys_n_rst_sys_func_n_rst_n),
		.tniu_tgt_id_tniu_tgt_id(tniu_tgt_id_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt(v_interrupt_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt(v_merge_interrupt_v_merge_interrupt_v_merge_interrupt),
		.apb_p_addr(apb_apb_p_addr),
		.apb_p_enable(apb_apb_p_enable),
		.apb_p_rdata(apb_apb_p_rdata),
		.apb_p_ready(apb_apb_p_ready),
		.apb_p_sel(apb_apb_p_sel),
		.apb_p_slverr(apb_apb_p_slverr),
		.apb_p_wdata(apb_apb_p_wdata),
		.apb_p_write(apb_apb_p_write),
		.async_fifo_pld_sync(tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_async),
		.async_fifo_rptr_sync(tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_sync),
		.async_fifo_wptr_async(tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_wptr_async),
		.timeout_val(timeout_val),
		.lp_async_m_async_master_hub_rx_req(tniu_sys_wrap_TO_tniu_top_wrap_SIG_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(tniu_top_wrap_TO_tniu_sys_wrap_SIG_lp_async_s_async_master_hub_tx_req),
		.pchannel_paccept(pchannel_pchannel_paccept),
		.pchannel_pactive(pchannel_pchannel_pactive),
		.pchannel_pdeny(pchannel_pchannel_pdeny),
		.pchannel_preq(pchannel_pchannel_preq),
		.pchannel_pstate(pchannel_pchannel_pstate));
	camera_ss_tniu_top_wrap tniu_top_wrap (
		.clk_top_func(clk_noc),
		.rst_top_func_n(rst_noc_n),
		.pring_in_if_pring_in_if_pring_in_if_last(pring_in_if_pring_in_if_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_pring_in_if_payload(pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_pring_in_if_qos(pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_pring_in_if_ready(pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_pring_in_if_srcid(pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_pring_in_if_tgtid(pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_pring_in_if_valid(pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid),
		.pring_out_if_pring_out_if_pring_out_if_last(pring_out_if_pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_pring_out_if_payload(pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_pring_out_if_qos(pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_pring_out_if_ready(pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_pring_out_if_srcid(pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_pring_out_if_tgtid(pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_pring_out_if_valid(pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_nring_in_if_last(nring_in_if_nring_in_if_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_nring_in_if_payload(nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_nring_in_if_qos(nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_nring_in_if_ready(nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_nring_in_if_srcid(nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_nring_in_if_tgtid(nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_nring_in_if_valid(nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_nring_out_if_last(nring_out_if_nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_nring_out_if_payload(nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_nring_out_if_qos(nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_nring_out_if_ready(nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_nring_out_if_srcid(nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_nring_out_if_tgtid(nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_nring_out_if_valid(nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid),
		.async_fifo_pld_sync(tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_async),
		.async_fifo_rptr_sync(tniu_sys_wrap_TO_tniu_top_wrap_SIG_async_fifo_rptr_sync),
		.async_fifo_wptr_async(tniu_top_wrap_TO_tniu_sys_wrap_SIG_async_fifo_wptr_async),
		.timeout_val_timeout_val(timeout_val),
		.lp_async_s_async_master_hub_rx_req(tniu_sys_wrap_TO_tniu_top_wrap_SIG_lp_async_m_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(tniu_top_wrap_TO_tniu_sys_wrap_SIG_lp_async_s_async_master_hub_tx_req));

endmodule
//[UHDL]Content End [md5:e3ccce914a73599749abe6aaa0e93f34]


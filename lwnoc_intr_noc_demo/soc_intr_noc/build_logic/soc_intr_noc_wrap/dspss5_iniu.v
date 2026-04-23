//[UHDL]Content Start [md5:433ce02867246709b2c683e27db466bb]
module dspss5_iniu (
	input           clk_sys_clk_sys_func_clk                                   ,
	input           rst_sys_n_rst_sys_func_n_rst_n                             ,
	input           clk_noc                                                    ,
	input           rst_noc_n                                                  ,
	input  [4095:0] v_interrupt_v_interrupt_v_interrupt                        ,
	input  [7:0]    iniu_src_id_iniu_src_id_iniu_src_id                        ,
	input  [31:0]   apb_apb_p_addr                                             ,
	input           apb_apb_p_enable                                           ,
	output [31:0]   apb_apb_p_rdata                                            ,
	output          apb_apb_p_ready                                            ,
	input           apb_apb_p_sel                                              ,
	output          apb_apb_p_slverr                                           ,
	input  [31:0]   apb_apb_p_wdata                                            ,
	input           apb_apb_p_write                                            ,
	input  [9:0]    timeout_val_timeout_val_timeout_val                        ,
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
	wire [15:0] iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_async             ;
	wire [15:0] iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_sync              ;
	wire [8:0]  iniu_top_wrap_TO_iniu_sys_wrap_SIG_lp_async_m_async_master_hub_rx_req;
	wire [61:0] iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_pld_sync               ;
	wire [15:0] iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_wptr_async             ;
	wire [8:0]  iniu_sys_wrap_TO_iniu_top_wrap_SIG_lp_async_s_async_master_hub_tx_req;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dspss_iniu_sys_wrap iniu_sys_wrap (
		.clk_sys_func_clk(clk_sys_clk_sys_func_clk),
		.rst_sys_func_n_rst_n(rst_sys_n_rst_sys_func_n_rst_n),
		.v_interrupt_v_interrupt(v_interrupt_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id(iniu_src_id_iniu_src_id_iniu_src_id),
		.apb_p_addr(apb_apb_p_addr),
		.apb_p_enable(apb_apb_p_enable),
		.apb_p_rdata(apb_apb_p_rdata),
		.apb_p_ready(apb_apb_p_ready),
		.apb_p_sel(apb_apb_p_sel),
		.apb_p_slverr(apb_apb_p_slverr),
		.apb_p_wdata(apb_apb_p_wdata),
		.apb_p_write(apb_apb_p_write),
		.async_fifo_pld_sync(iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_async),
		.async_fifo_rptr_sync(iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_sync),
		.async_fifo_wptr_async(iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_wptr_async),
		.timeout_val_timeout_val(timeout_val_timeout_val_timeout_val),
		.lp_async_s_async_master_hub_rx_req(iniu_top_wrap_TO_iniu_sys_wrap_SIG_lp_async_m_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(iniu_sys_wrap_TO_iniu_top_wrap_SIG_lp_async_s_async_master_hub_tx_req),
		.pchannel_paccept(pchannel_pchannel_paccept),
		.pchannel_pactive(pchannel_pchannel_pactive),
		.pchannel_pdeny(pchannel_pchannel_pdeny),
		.pchannel_preq(pchannel_pchannel_preq),
		.pchannel_pstate(pchannel_pchannel_pstate));
	dspss5_iniu_top_wrap iniu_top_wrap (
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
		.async_fifo_pld_sync(iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_async),
		.async_fifo_rptr_sync(iniu_top_wrap_TO_iniu_sys_wrap_SIG_async_fifo_rptr_sync),
		.async_fifo_wptr_async(iniu_sys_wrap_TO_iniu_top_wrap_SIG_async_fifo_wptr_async),
		.lp_async_m_async_master_hub_rx_req(iniu_top_wrap_TO_iniu_sys_wrap_SIG_lp_async_m_async_master_hub_rx_req),
		.lp_async_m_async_master_hub_tx_req(iniu_sys_wrap_TO_iniu_top_wrap_SIG_lp_async_s_async_master_hub_tx_req));

endmodule
//[UHDL]Content End [md5:433ce02867246709b2c683e27db466bb]


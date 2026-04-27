//[UHDL]Content Start [md5:a9de295b2ec576808bd09d4ee86dd40b]
module camera_ss_tniu_node (
	input           clk_sys_clk                                                                                                                                       ,
	input           rst_sys_n_rst_n                                                                                                                                   ,
	input           pring_in_if_pring_in_if_pring_in_if_pring_in_if_last                                                                                              ,
	input  [39:0]   pring_in_if_pring_in_if_pring_in_if_pring_in_if_payload                                                                                           ,
	input  [3:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_qos                                                                                               ,
	output          pring_in_if_pring_in_if_pring_in_if_pring_in_if_ready                                                                                             ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_srcid                                                                                             ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_pring_in_if_tgtid                                                                                             ,
	input           pring_in_if_pring_in_if_pring_in_if_pring_in_if_valid                                                                                             ,
	output          pring_out_if_pring_out_if_pring_out_if_pring_out_if_last                                                                                          ,
	output [39:0]   pring_out_if_pring_out_if_pring_out_if_pring_out_if_payload                                                                                       ,
	output [3:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_qos                                                                                           ,
	input           pring_out_if_pring_out_if_pring_out_if_pring_out_if_ready                                                                                         ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_srcid                                                                                         ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_pring_out_if_tgtid                                                                                         ,
	output          pring_out_if_pring_out_if_pring_out_if_pring_out_if_valid                                                                                         ,
	input           nring_in_if_nring_in_if_nring_in_if_nring_in_if_last                                                                                              ,
	input  [39:0]   nring_in_if_nring_in_if_nring_in_if_nring_in_if_payload                                                                                           ,
	input  [3:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_qos                                                                                               ,
	output          nring_in_if_nring_in_if_nring_in_if_nring_in_if_ready                                                                                             ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_srcid                                                                                             ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_nring_in_if_tgtid                                                                                             ,
	input           nring_in_if_nring_in_if_nring_in_if_nring_in_if_valid                                                                                             ,
	output          nring_out_if_nring_out_if_nring_out_if_nring_out_if_last                                                                                          ,
	output [39:0]   nring_out_if_nring_out_if_nring_out_if_nring_out_if_payload                                                                                       ,
	output [3:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_qos                                                                                           ,
	input           nring_out_if_nring_out_if_nring_out_if_nring_out_if_ready                                                                                         ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_srcid                                                                                         ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_nring_out_if_tgtid                                                                                         ,
	output          nring_out_if_nring_out_if_nring_out_if_nring_out_if_valid                                                                                         ,
	output          pchannel_paccept                                                                                                                                  ,
	output [1:0]    pchannel_pactive                                                                                                                                  ,
	output          pchannel_pdeny                                                                                                                                    ,
	input           pchannel_preq                                                                                                                                     ,
	input  [1:0]    pchannel_pstate                                                                                                                                   ,
	input  [7:0]    camera_ss_tniu_node_sys_tniu_tgt_id_porting_tniu_tgt_id                                                                                           ,
	output [4095:0] camera_ss_tniu_node_sys_v_interrupt_porting_v_interrupt                                                                                           ,
	output [127:0]  camera_ss_tniu_node_sys_v_merge_interrupt_porting_v_merge_interrupt                                                                               ,
	input  [31:0]   camera_ss_tniu_node_sys_apb_porting_p_addr                                                                                                        ,
	input           camera_ss_tniu_node_sys_apb_porting_p_enable                                                                                                      ,
	output [31:0]   camera_ss_tniu_node_sys_apb_porting_p_rdata                                                                                                       ,
	output          camera_ss_tniu_node_sys_apb_porting_p_ready                                                                                                       ,
	input           camera_ss_tniu_node_sys_apb_porting_p_sel                                                                                                         ,
	output          camera_ss_tniu_node_sys_apb_porting_p_slverr                                                                                                      ,
	input  [31:0]   camera_ss_tniu_node_sys_apb_porting_p_wdata                                                                                                       ,
	input           camera_ss_tniu_node_sys_apb_porting_p_write                                                                                                       ,
	input  [9:0]    camera_ss_tniu_node_sys_timeout_val_porting_timeout_val                                                                                           ,
	input           camera_ss_tniu_node_top_wrap_clk_porting                                                                                                          ,
	input           camera_ss_tniu_node_top_wrap_rst_n_porting                                                                                                        ,
	input  [9:0]    camera_ss_tniu_node_top_wrap_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val);

	//Wire define for this module.

	//Wire define for sub module.
	wire [9:0]  tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_wptr_async             ;
	wire [61:0] tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_pld_sync               ;
	wire [12:0] tniu_top_wrap_TO_tniu_sys_SIG_lp_async_s_async_master_hub_tx_req;
	wire [9:0]  tniu_sys_TO_tniu_top_wrap_SIG_rptr_async                        ;
	wire [9:0]  tniu_sys_TO_tniu_top_wrap_SIG_rptr_sync                         ;
	wire [12:0] tniu_sys_TO_tniu_top_wrap_SIG_m_async_master_hub_rx_req         ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	camera_ss_tniu_interrupt_tniu_async_sys_side tniu_sys (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.tniu_tgt_id(camera_ss_tniu_node_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.v_interrupt(camera_ss_tniu_node_sys_v_interrupt_porting_v_interrupt),
		.v_merge_interrupt(camera_ss_tniu_node_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.p_addr(camera_ss_tniu_node_sys_apb_porting_p_addr),
		.p_sel(camera_ss_tniu_node_sys_apb_porting_p_sel),
		.p_enable(camera_ss_tniu_node_sys_apb_porting_p_enable),
		.p_write(camera_ss_tniu_node_sys_apb_porting_p_write),
		.p_wdata(camera_ss_tniu_node_sys_apb_porting_p_wdata),
		.p_ready(camera_ss_tniu_node_sys_apb_porting_p_ready),
		.p_rdata(camera_ss_tniu_node_sys_apb_porting_p_rdata),
		.p_slverr(camera_ss_tniu_node_sys_apb_porting_p_slverr),
		.wptr_async(tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_wptr_async),
		.rptr_async(tniu_sys_TO_tniu_top_wrap_SIG_rptr_async),
		.rptr_sync(tniu_sys_TO_tniu_top_wrap_SIG_rptr_sync),
		.pld_sync(tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_pld_sync),
		.timeout_val(camera_ss_tniu_node_sys_timeout_val_porting_timeout_val),
		.m_async_master_hub_rx_req(tniu_sys_TO_tniu_top_wrap_SIG_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(tniu_top_wrap_TO_tniu_sys_SIG_lp_async_s_async_master_hub_tx_req),
		.preq(pchannel_preq),
		.pstate(pchannel_pstate),
		.pactive(pchannel_pactive),
		.paccept(pchannel_paccept),
		.pdeny(pchannel_pdeny));
	camera_ss_tniu_node_top_wrap tniu_top_wrap (
		.clk(camera_ss_tniu_node_top_wrap_clk_porting),
		.rst_n(camera_ss_tniu_node_top_wrap_rst_n_porting),
		.async_fifo_pld_sync(tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_pld_sync),
		.async_fifo_rptr_async(tniu_sys_TO_tniu_top_wrap_SIG_rptr_async),
		.async_fifo_rptr_sync(tniu_sys_TO_tniu_top_wrap_SIG_rptr_sync),
		.async_fifo_wptr_async(tniu_top_wrap_TO_tniu_sys_SIG_async_fifo_wptr_async),
		.lp_async_s_async_master_hub_rx_req(tniu_sys_TO_tniu_top_wrap_SIG_m_async_master_hub_rx_req),
		.lp_async_s_async_master_hub_tx_req(tniu_top_wrap_TO_tniu_sys_SIG_lp_async_s_async_master_hub_tx_req),
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
		.camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val(camera_ss_tniu_node_top_wrap_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_camera_ss_tniu_node_top_wrap_top_timeout_val_porting_timeout_val));

endmodule
//[UHDL]Content End [md5:a9de295b2ec576808bd09d4ee86dd40b]


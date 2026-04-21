//[UHDL]Content Start [md5:17609db8fa724326d443672799a5eab7]
module ddr7_iniu (
	input           clk_sys_clk                                   ,
	input           rst_sys_n_rst_n                               ,
	input           clk_noc                                       ,
	input           rst_noc_n                                     ,
	input           pring_in_if_pring_in_if_pring_in_if_last      ,
	input  [39:0]   pring_in_if_pring_in_if_pring_in_if_payload   ,
	input  [3:0]    pring_in_if_pring_in_if_pring_in_if_qos       ,
	output          pring_in_if_pring_in_if_pring_in_if_ready     ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_srcid     ,
	input  [7:0]    pring_in_if_pring_in_if_pring_in_if_tgtid     ,
	input           pring_in_if_pring_in_if_pring_in_if_valid     ,
	output          pring_out_if_pring_out_if_pring_out_if_last   ,
	output [39:0]   pring_out_if_pring_out_if_pring_out_if_payload,
	output [3:0]    pring_out_if_pring_out_if_pring_out_if_qos    ,
	input           pring_out_if_pring_out_if_pring_out_if_ready  ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_srcid  ,
	output [7:0]    pring_out_if_pring_out_if_pring_out_if_tgtid  ,
	output          pring_out_if_pring_out_if_pring_out_if_valid  ,
	input           nring_in_if_nring_in_if_nring_in_if_last      ,
	input  [39:0]   nring_in_if_nring_in_if_nring_in_if_payload   ,
	input  [3:0]    nring_in_if_nring_in_if_nring_in_if_qos       ,
	output          nring_in_if_nring_in_if_nring_in_if_ready     ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_srcid     ,
	input  [7:0]    nring_in_if_nring_in_if_nring_in_if_tgtid     ,
	input           nring_in_if_nring_in_if_nring_in_if_valid     ,
	output          nring_out_if_nring_out_if_nring_out_if_last   ,
	output [39:0]   nring_out_if_nring_out_if_nring_out_if_payload,
	output [3:0]    nring_out_if_nring_out_if_nring_out_if_qos    ,
	input           nring_out_if_nring_out_if_nring_out_if_ready  ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_srcid  ,
	output [7:0]    nring_out_if_nring_out_if_nring_out_if_tgtid  ,
	output          nring_out_if_nring_out_if_nring_out_if_valid  ,
	output          pchannel_paccept                              ,
	output [1:0]    pchannel_pactive                              ,
	output          pchannel_pdeny                                ,
	input           pchannel_preq                                 ,
	input  [1:0]    pchannel_pstate                               ,
	input  [4095:0] ddr7_iniu_sys_v_interrupt_porting_v_interrupt ,
	input  [7:0]    ddr7_iniu_sys_iniu_src_id_porting_iniu_src_id ,
	input  [31:0]   ddr7_iniu_sys_apb_porting_p_addr              ,
	input           ddr7_iniu_sys_apb_porting_p_enable            ,
	output [31:0]   ddr7_iniu_sys_apb_porting_p_rdata             ,
	output          ddr7_iniu_sys_apb_porting_p_ready             ,
	input           ddr7_iniu_sys_apb_porting_p_sel               ,
	output          ddr7_iniu_sys_apb_porting_p_slverr            ,
	input  [31:0]   ddr7_iniu_sys_apb_porting_p_wdata             ,
	input           ddr7_iniu_sys_apb_porting_p_write             ,
	input  [9:0]    ddr7_iniu_sys_timeout_val_porting_timeout_val );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0] iniu_top_TO_iniu_sys_SIG_rptr_async                 ;
	wire [15:0] iniu_top_TO_iniu_sys_SIG_rptr_sync                  ;
	wire [12:0] iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req  ;
	wire [15:0] iniu_sys_TO_iniu_top_SIG_wptr_async                 ;
	wire [61:0] iniu_sys_TO_iniu_top_SIG_pld_sync                   ;
	wire [12:0] iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req  ;
	wire        ring_wrap_TO_iniu_top_SIG_local_tx_local_tx_ready   ;
	wire        iniu_top_TO_ring_wrap_SIG_req_last                  ;
	wire [39:0] iniu_top_TO_ring_wrap_SIG_req_payload               ;
	wire [3:0]  iniu_top_TO_ring_wrap_SIG_req_qos                   ;
	wire [7:0]  iniu_top_TO_ring_wrap_SIG_req_srcid                 ;
	wire [7:0]  iniu_top_TO_ring_wrap_SIG_req_tgtid                 ;
	wire        iniu_top_TO_ring_wrap_SIG_req_valid                 ;
	wire        ring_sink_TO_ring_wrap_SIG_rx_ready                 ;
	wire        ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_valid  ;
	wire [39:0] ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_payload;
	wire [7:0]  ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_srcid  ;
	wire [7:0]  ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_tgtid  ;
	wire [3:0]  ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_qos    ;
	wire        ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_last   ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	ddr7_iniu_interrupt_iniu_aync_sys_side iniu_sys (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.v_interrupt(ddr7_iniu_sys_v_interrupt_porting_v_interrupt),
		.iniu_src_id(ddr7_iniu_sys_iniu_src_id_porting_iniu_src_id),
		.p_addr(ddr7_iniu_sys_apb_porting_p_addr),
		.p_sel(ddr7_iniu_sys_apb_porting_p_sel),
		.p_enable(ddr7_iniu_sys_apb_porting_p_enable),
		.p_write(ddr7_iniu_sys_apb_porting_p_write),
		.p_wdata(ddr7_iniu_sys_apb_porting_p_wdata),
		.p_ready(ddr7_iniu_sys_apb_porting_p_ready),
		.p_rdata(ddr7_iniu_sys_apb_porting_p_rdata),
		.p_slverr(ddr7_iniu_sys_apb_porting_p_slverr),
		.wptr_async(iniu_sys_TO_iniu_top_SIG_wptr_async),
		.rptr_async(iniu_top_TO_iniu_sys_SIG_rptr_async),
		.rptr_sync(iniu_top_TO_iniu_sys_SIG_rptr_sync),
		.pld_sync(iniu_sys_TO_iniu_top_SIG_pld_sync),
		.timeout_val(ddr7_iniu_sys_timeout_val_porting_timeout_val),
		.s_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),
		.preq(pchannel_preq),
		.pstate(pchannel_pstate),
		.pactive(pchannel_pactive),
		.paccept(pchannel_paccept),
		.pdeny(pchannel_pdeny));
	interrupt_iniu_aync_top_side iniu_top (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.wptr_async(iniu_sys_TO_iniu_top_SIG_wptr_async),
		.rptr_async(iniu_top_TO_iniu_sys_SIG_rptr_async),
		.rptr_sync(iniu_top_TO_iniu_sys_SIG_rptr_sync),
		.pld_sync(iniu_sys_TO_iniu_top_SIG_pld_sync),
		.m_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),
		.req_valid(iniu_top_TO_ring_wrap_SIG_req_valid),
		.req_ready(ring_wrap_TO_iniu_top_SIG_local_tx_local_tx_ready),
		.req_payload(iniu_top_TO_ring_wrap_SIG_req_payload),
		.req_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),
		.req_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),
		.req_qos(iniu_top_TO_ring_wrap_SIG_req_qos),
		.req_last(iniu_top_TO_ring_wrap_SIG_req_last),
		.req_threshold(1'b0));
	ddr7_iniu_ring ring_wrap (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.pring_in_if_pring_in_if_last(pring_in_if_pring_in_if_pring_in_if_last),
		.pring_in_if_pring_in_if_payload(pring_in_if_pring_in_if_pring_in_if_payload),
		.pring_in_if_pring_in_if_qos(pring_in_if_pring_in_if_pring_in_if_qos),
		.pring_in_if_pring_in_if_ready(pring_in_if_pring_in_if_pring_in_if_ready),
		.pring_in_if_pring_in_if_srcid(pring_in_if_pring_in_if_pring_in_if_srcid),
		.pring_in_if_pring_in_if_tgtid(pring_in_if_pring_in_if_pring_in_if_tgtid),
		.pring_in_if_pring_in_if_valid(pring_in_if_pring_in_if_pring_in_if_valid),
		.pring_out_if_pring_out_if_last(pring_out_if_pring_out_if_pring_out_if_last),
		.pring_out_if_pring_out_if_payload(pring_out_if_pring_out_if_pring_out_if_payload),
		.pring_out_if_pring_out_if_qos(pring_out_if_pring_out_if_pring_out_if_qos),
		.pring_out_if_pring_out_if_ready(pring_out_if_pring_out_if_pring_out_if_ready),
		.pring_out_if_pring_out_if_srcid(pring_out_if_pring_out_if_pring_out_if_srcid),
		.pring_out_if_pring_out_if_tgtid(pring_out_if_pring_out_if_pring_out_if_tgtid),
		.pring_out_if_pring_out_if_valid(pring_out_if_pring_out_if_pring_out_if_valid),
		.nring_in_if_nring_in_if_last(nring_in_if_nring_in_if_nring_in_if_last),
		.nring_in_if_nring_in_if_payload(nring_in_if_nring_in_if_nring_in_if_payload),
		.nring_in_if_nring_in_if_qos(nring_in_if_nring_in_if_nring_in_if_qos),
		.nring_in_if_nring_in_if_ready(nring_in_if_nring_in_if_nring_in_if_ready),
		.nring_in_if_nring_in_if_srcid(nring_in_if_nring_in_if_nring_in_if_srcid),
		.nring_in_if_nring_in_if_tgtid(nring_in_if_nring_in_if_nring_in_if_tgtid),
		.nring_in_if_nring_in_if_valid(nring_in_if_nring_in_if_nring_in_if_valid),
		.nring_out_if_nring_out_if_last(nring_out_if_nring_out_if_nring_out_if_last),
		.nring_out_if_nring_out_if_payload(nring_out_if_nring_out_if_nring_out_if_payload),
		.nring_out_if_nring_out_if_qos(nring_out_if_nring_out_if_nring_out_if_qos),
		.nring_out_if_nring_out_if_ready(nring_out_if_nring_out_if_nring_out_if_ready),
		.nring_out_if_nring_out_if_srcid(nring_out_if_nring_out_if_nring_out_if_srcid),
		.nring_out_if_nring_out_if_tgtid(nring_out_if_nring_out_if_nring_out_if_tgtid),
		.nring_out_if_nring_out_if_valid(nring_out_if_nring_out_if_nring_out_if_valid),
		.local_tx_local_tx_last(iniu_top_TO_ring_wrap_SIG_req_last),
		.local_tx_local_tx_payload(iniu_top_TO_ring_wrap_SIG_req_payload),
		.local_tx_local_tx_qos(iniu_top_TO_ring_wrap_SIG_req_qos),
		.local_tx_local_tx_ready(ring_wrap_TO_iniu_top_SIG_local_tx_local_tx_ready),
		.local_tx_local_tx_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),
		.local_tx_local_tx_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),
		.local_tx_local_tx_valid(iniu_top_TO_ring_wrap_SIG_req_valid),
		.local_rx_local_rx_last(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_last),
		.local_rx_local_rx_payload(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_payload),
		.local_rx_local_rx_qos(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_qos),
		.local_rx_local_rx_ready(ring_sink_TO_ring_wrap_SIG_rx_ready),
		.local_rx_local_rx_srcid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_srcid),
		.local_rx_local_rx_tgtid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_tgtid),
		.local_rx_local_rx_valid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_valid));
	lwnoc_intr_default_tgtid_sink ring_sink (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.rx_valid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_valid),
		.rx_ready(ring_sink_TO_ring_wrap_SIG_rx_ready),
		.rx_payload(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_payload),
		.rx_srcid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_srcid),
		.rx_tgtid(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_tgtid),
		.rx_qos(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_qos),
		.rx_last(ring_wrap_TO_ring_sink_SIG_local_rx_local_rx_last),
		.absorb_pulse(),
		.invalid_tgtid_pulse(),
		.invalid_tgtid_sticky());

endmodule
//[UHDL]Content End [md5:17609db8fa724326d443672799a5eab7]


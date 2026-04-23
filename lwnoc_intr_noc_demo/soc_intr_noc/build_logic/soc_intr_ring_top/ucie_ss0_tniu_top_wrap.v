//[UHDL]Content Start [md5:2bfd147b7c8032ea51dbb71c68f7bcf6]
module ucie_ss0_tniu_top_wrap (
	input         clk_top_func                                  ,
	input         rst_top_func_n                                ,
	input         pring_in_if_pring_in_if_pring_in_if_last      ,
	input  [39:0] pring_in_if_pring_in_if_pring_in_if_payload   ,
	input  [3:0]  pring_in_if_pring_in_if_pring_in_if_qos       ,
	output        pring_in_if_pring_in_if_pring_in_if_ready     ,
	input  [7:0]  pring_in_if_pring_in_if_pring_in_if_srcid     ,
	input  [7:0]  pring_in_if_pring_in_if_pring_in_if_tgtid     ,
	input         pring_in_if_pring_in_if_pring_in_if_valid     ,
	output        pring_out_if_pring_out_if_pring_out_if_last   ,
	output [39:0] pring_out_if_pring_out_if_pring_out_if_payload,
	output [3:0]  pring_out_if_pring_out_if_pring_out_if_qos    ,
	input         pring_out_if_pring_out_if_pring_out_if_ready  ,
	output [7:0]  pring_out_if_pring_out_if_pring_out_if_srcid  ,
	output [7:0]  pring_out_if_pring_out_if_pring_out_if_tgtid  ,
	output        pring_out_if_pring_out_if_pring_out_if_valid  ,
	input         nring_in_if_nring_in_if_nring_in_if_last      ,
	input  [39:0] nring_in_if_nring_in_if_nring_in_if_payload   ,
	input  [3:0]  nring_in_if_nring_in_if_nring_in_if_qos       ,
	output        nring_in_if_nring_in_if_nring_in_if_ready     ,
	input  [7:0]  nring_in_if_nring_in_if_nring_in_if_srcid     ,
	input  [7:0]  nring_in_if_nring_in_if_nring_in_if_tgtid     ,
	input         nring_in_if_nring_in_if_nring_in_if_valid     ,
	output        nring_out_if_nring_out_if_nring_out_if_last   ,
	output [39:0] nring_out_if_nring_out_if_nring_out_if_payload,
	output [3:0]  nring_out_if_nring_out_if_nring_out_if_qos    ,
	input         nring_out_if_nring_out_if_nring_out_if_ready  ,
	output [7:0]  nring_out_if_nring_out_if_nring_out_if_srcid  ,
	output [7:0]  nring_out_if_nring_out_if_nring_out_if_tgtid  ,
	output        nring_out_if_nring_out_if_nring_out_if_valid  ,
	output [61:0] async_fifo_pld_sync                           ,
	input  [9:0]  async_fifo_rptr_async                         ,
	input  [9:0]  async_fifo_rptr_sync                          ,
	output [9:0]  async_fifo_wptr_async                         ,
	input  [9:0]  timeout_val_timeout_val                       ,
	input  [8:0]  lp_async_s_async_master_hub_rx_req            ,
	output [8:0]  lp_async_s_async_master_hub_tx_req            );

	//Wire define for this module.

	//Wire define for sub module.
	wire        ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_valid  ;
	wire [39:0] ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_payload;
	wire [7:0]  ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_srcid  ;
	wire [7:0]  ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_tgtid  ;
	wire [3:0]  ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_qos    ;
	wire        ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_last   ;
	wire        ring_zero_TO_ring_wrap_SIG_merge_tx_last           ;
	wire [39:0] ring_zero_TO_ring_wrap_SIG_merge_tx_payload        ;
	wire [3:0]  ring_zero_TO_ring_wrap_SIG_merge_tx_qos            ;
	wire [7:0]  ring_zero_TO_ring_wrap_SIG_merge_tx_srcid          ;
	wire [7:0]  ring_zero_TO_ring_wrap_SIG_merge_tx_tgtid          ;
	wire        ring_zero_TO_ring_wrap_SIG_merge_tx_valid          ;
	wire        tniu_top_TO_ring_wrap_SIG_req_ready                ;
	wire        ring_wrap_TO_ring_zero_SIG_local_tx_local_tx_ready ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	interrupt_tniu_async_top_side tniu_top (
		.clk(clk_top_func),
		.rst_n(rst_top_func_n),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.timeout_val(timeout_val_timeout_val),
		.s_async_master_hub_rx_req(lp_async_s_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(lp_async_s_async_master_hub_tx_req),
		.req_valid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_valid),
		.req_ready(tniu_top_TO_ring_wrap_SIG_req_ready),
		.req_payload(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_payload),
		.req_srcid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_srcid),
		.req_tgtid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_tgtid),
		.req_qos(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_qos),
		.req_last(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_last),
		.req_threshold());
	ucie_ss0_tniu_top_wrap_ring ring_wrap (
		.clk(clk_top_func),
		.rst_n(rst_top_func_n),
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
		.local_tx_local_tx_last(ring_zero_TO_ring_wrap_SIG_merge_tx_last),
		.local_tx_local_tx_payload(ring_zero_TO_ring_wrap_SIG_merge_tx_payload),
		.local_tx_local_tx_qos(ring_zero_TO_ring_wrap_SIG_merge_tx_qos),
		.local_tx_local_tx_ready(ring_wrap_TO_ring_zero_SIG_local_tx_local_tx_ready),
		.local_tx_local_tx_srcid(ring_zero_TO_ring_wrap_SIG_merge_tx_srcid),
		.local_tx_local_tx_tgtid(ring_zero_TO_ring_wrap_SIG_merge_tx_tgtid),
		.local_tx_local_tx_valid(ring_zero_TO_ring_wrap_SIG_merge_tx_valid),
		.local_rx_local_rx_last(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_last),
		.local_rx_local_rx_payload(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_payload),
		.local_rx_local_rx_qos(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_qos),
		.local_rx_local_rx_ready(tniu_top_TO_ring_wrap_SIG_req_ready),
		.local_rx_local_rx_srcid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_srcid),
		.local_rx_local_rx_tgtid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_tgtid),
		.local_rx_local_rx_valid(ring_wrap_TO_tniu_top_SIG_local_rx_local_rx_valid));
	lwnoc_intr_dummy_endpoint #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.NODE_NUM(32'd39),
		.DUMMY_EN(1'b1),
		.SINK_EN(1'b1),
		.DUMMY_SRCID(8'd0),
		.DUMMY_TGTID(8'd0),
		.DUMMY_QOS(4'b0),
		.DUMMY_PLD(40'h0))
	ring_zero (
		.clk(clk_top_func),
		.rst_n(rst_top_func_n),
		.real_tx_valid(),
		.real_tx_ready(),
		.real_tx_payload(),
		.real_tx_srcid(),
		.real_tx_tgtid(),
		.real_tx_qos(),
		.real_tx_last(),
		.dummy_req_valid(),
		.dummy_req_ready(),
		.merge_tx_valid(ring_zero_TO_ring_wrap_SIG_merge_tx_valid),
		.merge_tx_ready(ring_wrap_TO_ring_zero_SIG_local_tx_local_tx_ready),
		.merge_tx_payload(ring_zero_TO_ring_wrap_SIG_merge_tx_payload),
		.merge_tx_srcid(ring_zero_TO_ring_wrap_SIG_merge_tx_srcid),
		.merge_tx_tgtid(ring_zero_TO_ring_wrap_SIG_merge_tx_tgtid),
		.merge_tx_qos(ring_zero_TO_ring_wrap_SIG_merge_tx_qos),
		.merge_tx_last(ring_zero_TO_ring_wrap_SIG_merge_tx_last),
		.sink_rx_valid(),
		.sink_rx_ready(),
		.sink_rx_payload(),
		.sink_rx_srcid(),
		.sink_rx_tgtid(),
		.sink_rx_qos(),
		.sink_rx_last(),
		.sink_absorb_pulse(),
		.sink_drop_invalid_pulse(),
		.sink_drop_invalid_sticky());

endmodule
//[UHDL]Content End [md5:2bfd147b7c8032ea51dbb71c68f7bcf6]


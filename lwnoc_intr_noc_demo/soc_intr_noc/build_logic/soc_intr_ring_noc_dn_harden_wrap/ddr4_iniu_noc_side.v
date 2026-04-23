//[UHDL]Content Start [md5:abd5495a623a2498a8a6f30a217256d0]
module ddr4_iniu_noc_side (
	input         clk_top_func                                                ,
	input         rst_top_func_n                                              ,
	input  [4:0]  node_id                                                     ,
	input         pring_in_if_pring_in_if_pring_in_if_last                    ,
	input  [39:0] pring_in_if_pring_in_if_pring_in_if_payload                 ,
	input  [3:0]  pring_in_if_pring_in_if_pring_in_if_qos                     ,
	output        pring_in_if_pring_in_if_pring_in_if_ready                   ,
	input  [7:0]  pring_in_if_pring_in_if_pring_in_if_srcid                   ,
	input  [7:0]  pring_in_if_pring_in_if_pring_in_if_tgtid                   ,
	input         pring_in_if_pring_in_if_pring_in_if_valid                   ,
	output        pring_out_if_pring_out_if_pring_out_if_last                 ,
	output [39:0] pring_out_if_pring_out_if_pring_out_if_payload              ,
	output [3:0]  pring_out_if_pring_out_if_pring_out_if_qos                  ,
	input         pring_out_if_pring_out_if_pring_out_if_ready                ,
	output [7:0]  pring_out_if_pring_out_if_pring_out_if_srcid                ,
	output [7:0]  pring_out_if_pring_out_if_pring_out_if_tgtid                ,
	output        pring_out_if_pring_out_if_pring_out_if_valid                ,
	input         nring_in_if_nring_in_if_nring_in_if_last                    ,
	input  [39:0] nring_in_if_nring_in_if_nring_in_if_payload                 ,
	input  [3:0]  nring_in_if_nring_in_if_nring_in_if_qos                     ,
	output        nring_in_if_nring_in_if_nring_in_if_ready                   ,
	input  [7:0]  nring_in_if_nring_in_if_nring_in_if_srcid                   ,
	input  [7:0]  nring_in_if_nring_in_if_nring_in_if_tgtid                   ,
	input         nring_in_if_nring_in_if_nring_in_if_valid                   ,
	output        nring_out_if_nring_out_if_nring_out_if_last                 ,
	output [39:0] nring_out_if_nring_out_if_nring_out_if_payload              ,
	output [3:0]  nring_out_if_nring_out_if_nring_out_if_qos                  ,
	input         nring_out_if_nring_out_if_nring_out_if_ready                ,
	output [7:0]  nring_out_if_nring_out_if_nring_out_if_srcid                ,
	output [7:0]  nring_out_if_nring_out_if_nring_out_if_tgtid                ,
	output        nring_out_if_nring_out_if_nring_out_if_valid                ,
	input  [61:0] async_fifo_pld_sync                                         ,
	output [15:0] async_fifo_rptr_async                                       ,
	output [15:0] async_fifo_rptr_sync                                        ,
	input  [15:0] async_fifo_wptr_async                                       ,
	output [8:0]  lp_async_m_async_master_hub_rx_req                          ,
	input  [8:0]  lp_async_m_async_master_hub_tx_req                          ,
	input  [4:0]  ddr4_iniu_xbar_lut_xbar_ch0_tgt_id_porting_xbar_ch0_tgt_id  ,
	output        ddr4_iniu_xbar_lut_xbar_ch0_sel_bit_porting_xbar_ch0_sel_bit);

	//Wire define for this module.

	//Wire define for sub module.
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
	soc_intr_xbar_routing_lut_w5_c1 xbar_routing_lut (
		.src_id(node_id),
		.xbar_ch0_tgt_id(ddr4_iniu_xbar_lut_xbar_ch0_tgt_id_porting_xbar_ch0_tgt_id),
		.xbar_ch0_sel_bit(ddr4_iniu_xbar_lut_xbar_ch0_sel_bit_porting_xbar_ch0_sel_bit));
	interrupt_iniu_async_top_side iniu_top (
		.clk(clk_top_func),
		.rst_n(rst_top_func_n),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.m_async_master_hub_rx_req(lp_async_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(lp_async_m_async_master_hub_tx_req),
		.req_valid(iniu_top_TO_ring_wrap_SIG_req_valid),
		.req_ready(ring_wrap_TO_iniu_top_SIG_local_tx_local_tx_ready),
		.req_payload(iniu_top_TO_ring_wrap_SIG_req_payload),
		.req_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),
		.req_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),
		.req_qos(iniu_top_TO_ring_wrap_SIG_req_qos),
		.req_last(iniu_top_TO_ring_wrap_SIG_req_last),
		.req_threshold());
	ddr4_iniu_noc_side_ring ring_wrap (
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
	lwnoc_intr_default_tgtid_sink #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.NODE_NUM(32'd39),
		.SINK_EN(1'b1))
	ring_sink (
		.clk(clk_top_func),
		.rst_n(rst_top_func_n),
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
//[UHDL]Content End [md5:abd5495a623a2498a8a6f30a217256d0]


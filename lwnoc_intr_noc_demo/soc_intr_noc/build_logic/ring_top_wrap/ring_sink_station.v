//[UHDL]Content Start [md5:5f34f77edc3bc2cd9920cdc93af32a7b]
module ring_sink_station (
	input         clk                              ,
	input         rst_n                            ,
	input         pring_in_if_pring_in_if_last     ,
	input  [39:0] pring_in_if_pring_in_if_payload  ,
	input  [3:0]  pring_in_if_pring_in_if_qos      ,
	output        pring_in_if_pring_in_if_ready    ,
	input  [7:0]  pring_in_if_pring_in_if_srcid    ,
	input  [7:0]  pring_in_if_pring_in_if_tgtid    ,
	input         pring_in_if_pring_in_if_valid    ,
	output        pring_out_if_pring_out_if_last   ,
	output [39:0] pring_out_if_pring_out_if_payload,
	output [3:0]  pring_out_if_pring_out_if_qos    ,
	input         pring_out_if_pring_out_if_ready  ,
	output [7:0]  pring_out_if_pring_out_if_srcid  ,
	output [7:0]  pring_out_if_pring_out_if_tgtid  ,
	output        pring_out_if_pring_out_if_valid  ,
	input         nring_in_if_nring_in_if_last     ,
	input  [39:0] nring_in_if_nring_in_if_payload  ,
	input  [3:0]  nring_in_if_nring_in_if_qos      ,
	output        nring_in_if_nring_in_if_ready    ,
	input  [7:0]  nring_in_if_nring_in_if_srcid    ,
	input  [7:0]  nring_in_if_nring_in_if_tgtid    ,
	input         nring_in_if_nring_in_if_valid    ,
	output        nring_out_if_nring_out_if_last   ,
	output [39:0] nring_out_if_nring_out_if_payload,
	output [3:0]  nring_out_if_nring_out_if_qos    ,
	input         nring_out_if_nring_out_if_ready  ,
	output [7:0]  nring_out_if_nring_out_if_srcid  ,
	output [7:0]  nring_out_if_nring_out_if_tgtid  ,
	output        nring_out_if_nring_out_if_valid  );

	//Wire define for this module.

	//Wire define for sub module.
	wire        ring_sink_TO_endpoint_wrap_SIG_rx_ready        ;
	wire        endpoint_wrap_TO_ring_sink_SIG_local_rx_valid  ;
	wire [39:0] endpoint_wrap_TO_ring_sink_SIG_local_rx_payload;
	wire [7:0]  endpoint_wrap_TO_ring_sink_SIG_local_rx_srcid  ;
	wire [7:0]  endpoint_wrap_TO_ring_sink_SIG_local_rx_tgtid  ;
	wire [3:0]  endpoint_wrap_TO_ring_sink_SIG_local_rx_qos    ;
	wire        endpoint_wrap_TO_ring_sink_SIG_local_rx_last   ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	lwnoc_intr_tniu_endpoint_wrap #(
		.RING_ID(32'd39),
		.NODE_NUM(32'd40),
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.SINGLE_THR_WIDTH(32'd1))
	endpoint_wrap (
		.clk(clk),
		.rst_n(rst_n),
		.pring_in_if_valid(pring_in_if_pring_in_if_valid),
		.pring_in_if_ready(pring_in_if_pring_in_if_ready),
		.pring_in_if_payload(pring_in_if_pring_in_if_payload),
		.pring_in_if_srcid(pring_in_if_pring_in_if_srcid),
		.pring_in_if_tgtid(pring_in_if_pring_in_if_tgtid),
		.pring_in_if_qos(pring_in_if_pring_in_if_qos),
		.pring_in_if_last(pring_in_if_pring_in_if_last),
		.pring_out_if_valid(pring_out_if_pring_out_if_valid),
		.pring_out_if_ready(pring_out_if_pring_out_if_ready),
		.pring_out_if_payload(pring_out_if_pring_out_if_payload),
		.pring_out_if_srcid(pring_out_if_pring_out_if_srcid),
		.pring_out_if_tgtid(pring_out_if_pring_out_if_tgtid),
		.pring_out_if_qos(pring_out_if_pring_out_if_qos),
		.pring_out_if_last(pring_out_if_pring_out_if_last),
		.nring_in_if_valid(nring_in_if_nring_in_if_valid),
		.nring_in_if_ready(nring_in_if_nring_in_if_ready),
		.nring_in_if_payload(nring_in_if_nring_in_if_payload),
		.nring_in_if_srcid(nring_in_if_nring_in_if_srcid),
		.nring_in_if_tgtid(nring_in_if_nring_in_if_tgtid),
		.nring_in_if_qos(nring_in_if_nring_in_if_qos),
		.nring_in_if_last(nring_in_if_nring_in_if_last),
		.nring_out_if_valid(nring_out_if_nring_out_if_valid),
		.nring_out_if_ready(nring_out_if_nring_out_if_ready),
		.nring_out_if_payload(nring_out_if_nring_out_if_payload),
		.nring_out_if_srcid(nring_out_if_nring_out_if_srcid),
		.nring_out_if_tgtid(nring_out_if_nring_out_if_tgtid),
		.nring_out_if_qos(nring_out_if_nring_out_if_qos),
		.nring_out_if_last(nring_out_if_nring_out_if_last),
		.local_rx_valid(endpoint_wrap_TO_ring_sink_SIG_local_rx_valid),
		.local_rx_ready(ring_sink_TO_endpoint_wrap_SIG_rx_ready),
		.local_rx_payload(endpoint_wrap_TO_ring_sink_SIG_local_rx_payload),
		.local_rx_srcid(endpoint_wrap_TO_ring_sink_SIG_local_rx_srcid),
		.local_rx_tgtid(endpoint_wrap_TO_ring_sink_SIG_local_rx_tgtid),
		.local_rx_qos(endpoint_wrap_TO_ring_sink_SIG_local_rx_qos),
		.local_rx_last(endpoint_wrap_TO_ring_sink_SIG_local_rx_last));
	lwnoc_intr_default_tgtid_sink ring_sink (
		.clk(clk),
		.rst_n(rst_n),
		.rx_valid(endpoint_wrap_TO_ring_sink_SIG_local_rx_valid),
		.rx_ready(ring_sink_TO_endpoint_wrap_SIG_rx_ready),
		.rx_payload(endpoint_wrap_TO_ring_sink_SIG_local_rx_payload),
		.rx_srcid(endpoint_wrap_TO_ring_sink_SIG_local_rx_srcid),
		.rx_tgtid(endpoint_wrap_TO_ring_sink_SIG_local_rx_tgtid),
		.rx_qos(endpoint_wrap_TO_ring_sink_SIG_local_rx_qos),
		.rx_last(endpoint_wrap_TO_ring_sink_SIG_local_rx_last),
		.absorb_pulse(),
		.invalid_tgtid_pulse(),
		.invalid_tgtid_sticky());

endmodule
//[UHDL]Content End [md5:5f34f77edc3bc2cd9920cdc93af32a7b]


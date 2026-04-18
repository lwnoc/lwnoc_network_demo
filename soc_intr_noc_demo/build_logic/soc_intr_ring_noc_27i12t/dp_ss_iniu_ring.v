//[UHDL]Content Start [md5:cf7a5cc56b985ef38ac34bec51410dc3]
module dp_ss_iniu_ring (
	input         clk                       ,
	input         rst_n                     ,
	input         pring_in_if_cw_in_last    ,
	input  [39:0] pring_in_if_cw_in_payload ,
	input  [3:0]  pring_in_if_cw_in_qos     ,
	output        pring_in_if_cw_in_ready   ,
	input  [7:0]  pring_in_if_cw_in_srcid   ,
	input  [7:0]  pring_in_if_cw_in_tgtid   ,
	input         pring_in_if_cw_in_valid   ,
	output        pring_out_if_m_last       ,
	output [39:0] pring_out_if_m_payload    ,
	output [3:0]  pring_out_if_m_qos        ,
	input         pring_out_if_m_ready      ,
	output [7:0]  pring_out_if_m_srcid      ,
	output [7:0]  pring_out_if_m_tgtid      ,
	output        pring_out_if_m_valid      ,
	input         nring_in_if_ccw_in_last   ,
	input  [39:0] nring_in_if_ccw_in_payload,
	input  [3:0]  nring_in_if_ccw_in_qos    ,
	output        nring_in_if_ccw_in_ready  ,
	input  [7:0]  nring_in_if_ccw_in_srcid  ,
	input  [7:0]  nring_in_if_ccw_in_tgtid  ,
	input         nring_in_if_ccw_in_valid  ,
	output        nring_out_if_m_last       ,
	output [39:0] nring_out_if_m_payload    ,
	output [3:0]  nring_out_if_m_qos        ,
	input         nring_out_if_m_ready      ,
	output [7:0]  nring_out_if_m_srcid      ,
	output [7:0]  nring_out_if_m_tgtid      ,
	output        nring_out_if_m_valid      ,
	input         local_tx_local_tx_last    ,
	input  [39:0] local_tx_local_tx_payload ,
	input  [3:0]  local_tx_local_tx_qos     ,
	output        local_tx_local_tx_ready   ,
	input  [7:0]  local_tx_local_tx_srcid   ,
	input  [7:0]  local_tx_local_tx_tgtid   ,
	input         local_tx_local_tx_valid   ,
	output        local_rx_local_rx_last    ,
	output [39:0] local_rx_local_rx_payload ,
	output [3:0]  local_rx_local_rx_qos     ,
	input         local_rx_local_rx_ready   ,
	output [7:0]  local_rx_local_rx_srcid   ,
	output [7:0]  local_rx_local_rx_tgtid   ,
	output        local_rx_local_rx_valid   );

	//Wire define for this module.

	//Wire define for sub module.
	wire        link_cw_TO_ring_sta_SIG_s_ready         ;
	wire        link_ccw_TO_ring_sta_SIG_s_ready        ;
	wire        ring_sta_TO_link_cw_SIG_cw_out_valid    ;
	wire [39:0] ring_sta_TO_link_cw_SIG_cw_out_payload  ;
	wire [7:0]  ring_sta_TO_link_cw_SIG_cw_out_srcid    ;
	wire [7:0]  ring_sta_TO_link_cw_SIG_cw_out_tgtid    ;
	wire [3:0]  ring_sta_TO_link_cw_SIG_cw_out_qos      ;
	wire        ring_sta_TO_link_cw_SIG_cw_out_last     ;
	wire        ring_sta_TO_link_ccw_SIG_ccw_out_valid  ;
	wire [39:0] ring_sta_TO_link_ccw_SIG_ccw_out_payload;
	wire [7:0]  ring_sta_TO_link_ccw_SIG_ccw_out_srcid  ;
	wire [7:0]  ring_sta_TO_link_ccw_SIG_ccw_out_tgtid  ;
	wire [3:0]  ring_sta_TO_link_ccw_SIG_ccw_out_qos    ;
	wire        ring_sta_TO_link_ccw_SIG_ccw_out_last   ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	intr_ring_station_interrupt_req_ring_station #(
		.NODE_ID(32'd7),
		.NODE_COUNT(32'd39),
		.HAS_INIU(1'b1),
		.HAS_TNIU(1'b0),
		.PAYLOAD_WIDTH(32'd40),
		.SRCID_WIDTH(32'd8),
		.TGTID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4))
	ring_sta (
		.local_tx_valid(local_tx_local_tx_valid),
		.local_tx_ready(local_tx_local_tx_ready),
		.local_tx_payload(local_tx_local_tx_payload),
		.local_tx_srcid(local_tx_local_tx_srcid),
		.local_tx_tgtid(local_tx_local_tx_tgtid),
		.local_tx_qos(local_tx_local_tx_qos),
		.local_tx_last(local_tx_local_tx_last),
		.local_rx_valid(local_rx_local_rx_valid),
		.local_rx_ready(local_rx_local_rx_ready),
		.local_rx_payload(local_rx_local_rx_payload),
		.local_rx_srcid(local_rx_local_rx_srcid),
		.local_rx_tgtid(local_rx_local_rx_tgtid),
		.local_rx_qos(local_rx_local_rx_qos),
		.local_rx_last(local_rx_local_rx_last),
		.cw_in_valid(pring_in_if_cw_in_valid),
		.cw_in_ready(pring_in_if_cw_in_ready),
		.cw_in_payload(pring_in_if_cw_in_payload),
		.cw_in_srcid(pring_in_if_cw_in_srcid),
		.cw_in_tgtid(pring_in_if_cw_in_tgtid),
		.cw_in_qos(pring_in_if_cw_in_qos),
		.cw_in_last(pring_in_if_cw_in_last),
		.cw_out_valid(ring_sta_TO_link_cw_SIG_cw_out_valid),
		.cw_out_ready(link_cw_TO_ring_sta_SIG_s_ready),
		.cw_out_payload(ring_sta_TO_link_cw_SIG_cw_out_payload),
		.cw_out_srcid(ring_sta_TO_link_cw_SIG_cw_out_srcid),
		.cw_out_tgtid(ring_sta_TO_link_cw_SIG_cw_out_tgtid),
		.cw_out_qos(ring_sta_TO_link_cw_SIG_cw_out_qos),
		.cw_out_last(ring_sta_TO_link_cw_SIG_cw_out_last),
		.ccw_in_valid(nring_in_if_ccw_in_valid),
		.ccw_in_ready(nring_in_if_ccw_in_ready),
		.ccw_in_payload(nring_in_if_ccw_in_payload),
		.ccw_in_srcid(nring_in_if_ccw_in_srcid),
		.ccw_in_tgtid(nring_in_if_ccw_in_tgtid),
		.ccw_in_qos(nring_in_if_ccw_in_qos),
		.ccw_in_last(nring_in_if_ccw_in_last),
		.ccw_out_valid(ring_sta_TO_link_ccw_SIG_ccw_out_valid),
		.ccw_out_ready(link_ccw_TO_ring_sta_SIG_s_ready),
		.ccw_out_payload(ring_sta_TO_link_ccw_SIG_ccw_out_payload),
		.ccw_out_srcid(ring_sta_TO_link_ccw_SIG_ccw_out_srcid),
		.ccw_out_tgtid(ring_sta_TO_link_ccw_SIG_ccw_out_tgtid),
		.ccw_out_qos(ring_sta_TO_link_ccw_SIG_ccw_out_qos),
		.ccw_out_last(ring_sta_TO_link_ccw_SIG_ccw_out_last));
	intr_ring_link_interrupt_req_ring_link link_cw (
		.clk(clk),
		.rst_n(rst_n),
		.s_valid(ring_sta_TO_link_cw_SIG_cw_out_valid),
		.s_ready(link_cw_TO_ring_sta_SIG_s_ready),
		.s_payload(ring_sta_TO_link_cw_SIG_cw_out_payload),
		.s_srcid(ring_sta_TO_link_cw_SIG_cw_out_srcid),
		.s_tgtid(ring_sta_TO_link_cw_SIG_cw_out_tgtid),
		.s_qos(ring_sta_TO_link_cw_SIG_cw_out_qos),
		.s_last(ring_sta_TO_link_cw_SIG_cw_out_last),
		.m_valid(pring_out_if_m_valid),
		.m_ready(pring_out_if_m_ready),
		.m_payload(pring_out_if_m_payload),
		.m_srcid(pring_out_if_m_srcid),
		.m_tgtid(pring_out_if_m_tgtid),
		.m_qos(pring_out_if_m_qos),
		.m_last(pring_out_if_m_last));
	intr_ring_link_interrupt_req_ring_link link_ccw (
		.clk(clk),
		.rst_n(rst_n),
		.s_valid(ring_sta_TO_link_ccw_SIG_ccw_out_valid),
		.s_ready(link_ccw_TO_ring_sta_SIG_s_ready),
		.s_payload(ring_sta_TO_link_ccw_SIG_ccw_out_payload),
		.s_srcid(ring_sta_TO_link_ccw_SIG_ccw_out_srcid),
		.s_tgtid(ring_sta_TO_link_ccw_SIG_ccw_out_tgtid),
		.s_qos(ring_sta_TO_link_ccw_SIG_ccw_out_qos),
		.s_last(ring_sta_TO_link_ccw_SIG_ccw_out_last),
		.m_valid(nring_out_if_m_valid),
		.m_ready(nring_out_if_m_ready),
		.m_payload(nring_out_if_m_payload),
		.m_srcid(nring_out_if_m_srcid),
		.m_tgtid(nring_out_if_m_tgtid),
		.m_qos(nring_out_if_m_qos),
		.m_last(nring_out_if_m_last));

endmodule
//[UHDL]Content End [md5:cf7a5cc56b985ef38ac34bec51410dc3]


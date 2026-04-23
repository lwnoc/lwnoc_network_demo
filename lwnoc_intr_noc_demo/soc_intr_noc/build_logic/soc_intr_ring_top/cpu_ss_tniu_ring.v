//[UHDL]Content Start [md5:29a06000992d39f1e8ec9cd561b3a096]
module cpu_ss_tniu_ring (
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
	output        nring_out_if_nring_out_if_valid  ,
	input         local_tx_local_tx_last           ,
	input  [39:0] local_tx_local_tx_payload        ,
	input  [3:0]  local_tx_local_tx_qos            ,
	output        local_tx_local_tx_ready          ,
	input  [7:0]  local_tx_local_tx_srcid          ,
	input  [7:0]  local_tx_local_tx_tgtid          ,
	input         local_tx_local_tx_valid          ,
	output        local_rx_local_rx_last           ,
	output [39:0] local_rx_local_rx_payload        ,
	output [3:0]  local_rx_local_rx_qos            ,
	input         local_rx_local_rx_ready          ,
	output [7:0]  local_rx_local_rx_srcid          ,
	output [7:0]  local_rx_local_rx_tgtid          ,
	output        local_rx_local_rx_valid          );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	intr_ring_buf_wrap #(
		.RING_ID(32'd1),
		.NODE_NUM(32'd39),
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.SINGLE_THR_WIDTH(32'd1),
		.HAS_INIU(1'b1),
		.HAS_TNIU(1'b1))
	ring_buf (
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
		.local_rx_last(local_rx_local_rx_last));

endmodule
//[UHDL]Content End [md5:29a06000992d39f1e8ec9cd561b3a096]


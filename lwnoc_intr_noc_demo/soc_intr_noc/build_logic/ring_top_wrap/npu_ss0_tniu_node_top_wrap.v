//[UHDL]Content Start [md5:ccf4de9fc7319f823211811d5c161b1f]
module npu_ss0_tniu_node_top_wrap (
	input         clk                                                           ,
	input         rst_n                                                         ,
	output [69:0] async_fifo_pld_sync                                           ,
	input  [15:0] async_fifo_rptr_async                                         ,
	input  [15:0] async_fifo_rptr_sync                                          ,
	output [15:0] async_fifo_wptr_async                                         ,
	input  [12:0] lp_async_s_async_master_hub_rx_req                            ,
	output [12:0] lp_async_s_async_master_hub_tx_req                            ,
	input         pring_in_if_pring_in_if_last                                  ,
	input  [39:0] pring_in_if_pring_in_if_payload                               ,
	input  [3:0]  pring_in_if_pring_in_if_qos                                   ,
	output        pring_in_if_pring_in_if_ready                                 ,
	input  [7:0]  pring_in_if_pring_in_if_srcid                                 ,
	input  [7:0]  pring_in_if_pring_in_if_tgtid                                 ,
	input         pring_in_if_pring_in_if_valid                                 ,
	output        pring_out_if_pring_out_if_last                                ,
	output [39:0] pring_out_if_pring_out_if_payload                             ,
	output [3:0]  pring_out_if_pring_out_if_qos                                 ,
	input         pring_out_if_pring_out_if_ready                               ,
	output [7:0]  pring_out_if_pring_out_if_srcid                               ,
	output [7:0]  pring_out_if_pring_out_if_tgtid                               ,
	output        pring_out_if_pring_out_if_valid                               ,
	input         nring_in_if_nring_in_if_last                                  ,
	input  [39:0] nring_in_if_nring_in_if_payload                               ,
	input  [3:0]  nring_in_if_nring_in_if_qos                                   ,
	output        nring_in_if_nring_in_if_ready                                 ,
	input  [7:0]  nring_in_if_nring_in_if_srcid                                 ,
	input  [7:0]  nring_in_if_nring_in_if_tgtid                                 ,
	input         nring_in_if_nring_in_if_valid                                 ,
	output        nring_out_if_nring_out_if_last                                ,
	output [39:0] nring_out_if_nring_out_if_payload                             ,
	output [3:0]  nring_out_if_nring_out_if_qos                                 ,
	input         nring_out_if_nring_out_if_ready                               ,
	output [7:0]  nring_out_if_nring_out_if_srcid                               ,
	output [7:0]  nring_out_if_nring_out_if_tgtid                               ,
	output        nring_out_if_nring_out_if_valid                               ,
	input  [9:0]  npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val);

	//Wire define for this module.
	wire [7:0] node_id;

	//Wire define for sub module.
	wire        endpoint_wrap_TO_tniu_top_SIG_local_rx_valid  ;
	wire [39:0] endpoint_wrap_TO_tniu_top_SIG_local_rx_payload;
	wire [7:0]  endpoint_wrap_TO_tniu_top_SIG_local_rx_srcid  ;
	wire [7:0]  endpoint_wrap_TO_tniu_top_SIG_local_rx_tgtid  ;
	wire [3:0]  endpoint_wrap_TO_tniu_top_SIG_local_rx_qos    ;
	wire        endpoint_wrap_TO_tniu_top_SIG_local_rx_last   ;
	wire        tniu_top_TO_endpoint_wrap_SIG_req_ready       ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	SocIntrNodeIdGen_node_id_value_3_node_id_width_8 node_id_gen_top (
		.node_id(node_id));
	intr_tniu_top_interrupt_tniu_async_top_side tniu_top (
		.clk(clk),
		.rst_n(rst_n),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.timeout_val(npu_ss0_tniu_node_top_wrap_top_timeout_val_porting_timeout_val),
		.s_async_master_hub_rx_req(lp_async_s_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(lp_async_s_async_master_hub_tx_req),
		.req_valid(endpoint_wrap_TO_tniu_top_SIG_local_rx_valid),
		.req_ready(tniu_top_TO_endpoint_wrap_SIG_req_ready),
		.req_payload(endpoint_wrap_TO_tniu_top_SIG_local_rx_payload),
		.req_srcid(endpoint_wrap_TO_tniu_top_SIG_local_rx_srcid),
		.req_tgtid(endpoint_wrap_TO_tniu_top_SIG_local_rx_tgtid),
		.req_qos(endpoint_wrap_TO_tniu_top_SIG_local_rx_qos),
		.req_last(endpoint_wrap_TO_tniu_top_SIG_local_rx_last),
		.req_threshold());
	lwnoc_intr_tniu_endpoint_wrap #(
		.RING_ID(32'd3),
		.NODE_NUM(32'd51),
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
		.local_rx_valid(endpoint_wrap_TO_tniu_top_SIG_local_rx_valid),
		.local_rx_ready(tniu_top_TO_endpoint_wrap_SIG_req_ready),
		.local_rx_payload(endpoint_wrap_TO_tniu_top_SIG_local_rx_payload),
		.local_rx_srcid(endpoint_wrap_TO_tniu_top_SIG_local_rx_srcid),
		.local_rx_tgtid(endpoint_wrap_TO_tniu_top_SIG_local_rx_tgtid),
		.local_rx_qos(endpoint_wrap_TO_tniu_top_SIG_local_rx_qos),
		.local_rx_last(endpoint_wrap_TO_tniu_top_SIG_local_rx_last));

endmodule
//[UHDL]Content End [md5:ccf4de9fc7319f823211811d5c161b1f]


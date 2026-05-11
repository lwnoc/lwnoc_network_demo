//[UHDL]Content Start [md5:f7fa25d44fda25e3b945702fb65844da]
module npu_ss3_iniu_node_top_wrap (
	input         clk                                                                  ,
	input         rst_n                                                                ,
	input  [69:0] async_fifo_pld_sync                                                  ,
	output [15:0] async_fifo_rptr_async                                                ,
	output [15:0] async_fifo_rptr_sync                                                 ,
	input  [15:0] async_fifo_wptr_async                                                ,
	output [12:0] lp_async_m_async_master_hub_rx_req                                   ,
	input  [12:0] lp_async_m_async_master_hub_tx_req                                   ,
	input         pring_in_if_pring_in_if_last                                         ,
	input  [39:0] pring_in_if_pring_in_if_payload                                      ,
	input  [3:0]  pring_in_if_pring_in_if_qos                                          ,
	output        pring_in_if_pring_in_if_ready                                        ,
	input  [7:0]  pring_in_if_pring_in_if_srcid                                        ,
	input  [7:0]  pring_in_if_pring_in_if_tgtid                                        ,
	input         pring_in_if_pring_in_if_valid                                        ,
	output        pring_out_if_pring_out_if_last                                       ,
	output [39:0] pring_out_if_pring_out_if_payload                                    ,
	output [3:0]  pring_out_if_pring_out_if_qos                                        ,
	input         pring_out_if_pring_out_if_ready                                      ,
	output [7:0]  pring_out_if_pring_out_if_srcid                                      ,
	output [7:0]  pring_out_if_pring_out_if_tgtid                                      ,
	output        pring_out_if_pring_out_if_valid                                      ,
	input         nring_in_if_nring_in_if_last                                         ,
	input  [39:0] nring_in_if_nring_in_if_payload                                      ,
	input  [3:0]  nring_in_if_nring_in_if_qos                                          ,
	output        nring_in_if_nring_in_if_ready                                        ,
	input  [7:0]  nring_in_if_nring_in_if_srcid                                        ,
	input  [7:0]  nring_in_if_nring_in_if_tgtid                                        ,
	input         nring_in_if_nring_in_if_valid                                        ,
	output        nring_out_if_nring_out_if_last                                       ,
	output [39:0] nring_out_if_nring_out_if_payload                                    ,
	output [3:0]  nring_out_if_nring_out_if_qos                                        ,
	input         nring_out_if_nring_out_if_ready                                      ,
	output [7:0]  nring_out_if_nring_out_if_srcid                                      ,
	output [7:0]  nring_out_if_nring_out_if_tgtid                                      ,
	output        nring_out_if_nring_out_if_valid                                      ,
	output        afifo_sb_err_afifo_sb_err                                            ,
	output        afifo_db_err_afifo_db_err                                            ,
	output        npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last   ,
	output [39:0] npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload,
	output [3:0]  npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos    ,
	input         npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready  ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid  ,
	output [7:0]  npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid  ,
	output        npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid  );

	//Wire define for this module.
	wire [7:0] node_id;

	//Wire define for sub module.
	wire [7:0]  node_id_gen_top_node_id                               ;
	wire [7:0]  xbar_routing_lut_src_id                               ;
	wire [7:0]  endpoint_wrap_TO_xbar_routing_lut_SIG_xbar_req_tgt_id ;
	wire        endpoint_wrap_TO_iniu_top_SIG_local_tx_ready          ;
	wire        iniu_top_TO_endpoint_wrap_SIG_req_valid               ;
	wire [39:0] iniu_top_TO_endpoint_wrap_SIG_req_payload             ;
	wire [7:0]  iniu_top_TO_endpoint_wrap_SIG_req_srcid               ;
	wire [7:0]  iniu_top_TO_endpoint_wrap_SIG_req_tgtid               ;
	wire [3:0]  iniu_top_TO_endpoint_wrap_SIG_req_qos                 ;
	wire        iniu_top_TO_endpoint_wrap_SIG_req_last                ;
	wire        xbar_routing_lut_TO_endpoint_wrap_SIG_xbar_ch0_sel_bit;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign node_id = node_id_gen_top_node_id;
	

	//Wire this module connect to sub module.
	assign xbar_routing_lut_src_id = node_id;
	

	//module inst.
	SocIntrNodeIdGen_node_id_value_34_node_id_width_8 node_id_gen_top (
		.node_id(node_id_gen_top_node_id));
	soc_intr_xbar_routing_lut_w8_c1 xbar_routing_lut (
		.src_id(xbar_routing_lut_src_id),
		.xbar_ch0_tgt_id(endpoint_wrap_TO_xbar_routing_lut_SIG_xbar_req_tgt_id),
		.xbar_ch0_sel_bit(xbar_routing_lut_TO_endpoint_wrap_SIG_xbar_ch0_sel_bit));
	intr_iniu_top_interrupt_iniu_async_top_side iniu_top (
		.clk(clk),
		.rst_n(rst_n),
		.wptr_async(async_fifo_wptr_async),
		.rptr_async(async_fifo_rptr_async),
		.rptr_sync(async_fifo_rptr_sync),
		.pld_sync(async_fifo_pld_sync),
		.afifo_sb_err(afifo_sb_err_afifo_sb_err),
		.afifo_db_err(afifo_db_err_afifo_db_err),
		.m_async_master_hub_rx_req(lp_async_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(lp_async_m_async_master_hub_tx_req),
		.req_valid(iniu_top_TO_endpoint_wrap_SIG_req_valid),
		.req_ready(endpoint_wrap_TO_iniu_top_SIG_local_tx_ready),
		.req_payload(iniu_top_TO_endpoint_wrap_SIG_req_payload),
		.req_srcid(iniu_top_TO_endpoint_wrap_SIG_req_srcid),
		.req_tgtid(iniu_top_TO_endpoint_wrap_SIG_req_tgtid),
		.req_qos(iniu_top_TO_endpoint_wrap_SIG_req_qos),
		.req_last(iniu_top_TO_endpoint_wrap_SIG_req_last),
		.req_threshold());
	lwnoc_intr_iniu_endpoint_wrap #(
		.RING_ID(32'd34),
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
		.local_tx_valid(iniu_top_TO_endpoint_wrap_SIG_req_valid),
		.local_tx_ready(endpoint_wrap_TO_iniu_top_SIG_local_tx_ready),
		.local_tx_payload(iniu_top_TO_endpoint_wrap_SIG_req_payload),
		.local_tx_srcid(iniu_top_TO_endpoint_wrap_SIG_req_srcid),
		.local_tx_tgtid(iniu_top_TO_endpoint_wrap_SIG_req_tgtid),
		.local_tx_qos(iniu_top_TO_endpoint_wrap_SIG_req_qos),
		.local_tx_last(iniu_top_TO_endpoint_wrap_SIG_req_last),
		.local_rx_valid(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_valid),
		.local_rx_ready(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_ready),
		.local_rx_payload(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_payload),
		.local_rx_srcid(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_srcid),
		.local_rx_tgtid(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_tgtid),
		.local_rx_qos(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_qos),
		.local_rx_last(npu_ss3_iniu_node_top_wrap_endpoint_local_rx_porting_local_rx_last),
		.xbar_req_tgt_id(endpoint_wrap_TO_xbar_routing_lut_SIG_xbar_req_tgt_id),
		.xbar_req_sel_bit(xbar_routing_lut_TO_endpoint_wrap_SIG_xbar_ch0_sel_bit));

endmodule
//[UHDL]Content End [md5:f7fa25d44fda25e3b945702fb65844da]


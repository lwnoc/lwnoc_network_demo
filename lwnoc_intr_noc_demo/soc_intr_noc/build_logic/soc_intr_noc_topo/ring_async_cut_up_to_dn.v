//[UHDL]Content Start [md5:a2353e105c1d1316d052c88a4864195e]
module ring_async_cut_up_to_dn (
	input         clk_src_clk_slv                  ,
	input         rst_src_n_rst_slv_n              ,
	input         clk_dst_clk_mst                  ,
	input         rst_dst_n_rst_mst_n              ,
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
	wire [7:0]  mst_side_TO_slv_side_SIG_pring_rptr_async;
	wire [7:0]  mst_side_TO_slv_side_SIG_pring_rptr_sync ;
	wire [1:0]  mst_side_TO_slv_side_SIG_pring_vc_buf_rdy;
	wire [7:0]  mst_side_TO_slv_side_SIG_nring_wptr_async;
	wire [62:0] mst_side_TO_slv_side_SIG_nring_pld_sync  ;
	wire [7:0]  slv_side_TO_mst_side_SIG_pring_wptr_async;
	wire [62:0] slv_side_TO_mst_side_SIG_pring_pld_sync  ;
	wire [7:0]  slv_side_TO_mst_side_SIG_nring_rptr_async;
	wire [7:0]  slv_side_TO_mst_side_SIG_nring_rptr_sync ;
	wire [1:0]  slv_side_TO_mst_side_SIG_nring_vc_buf_rdy;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	lwnoc_intr_ring_async_bridge_wrap_slv #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.THRESHOLD_EN(1'b1),
		.SINGLE_THR_WIDTH(32'd1),
		.NODE_NUM(32'd39),
		.SYNC_LEVEL(32'd3),
		.AFIFO_DEP(32'd8))
	slv_side (
		.clk_slv(clk_src_clk_slv),
		.rst_slv_n(rst_src_n_rst_slv_n),
		.pring_in_if_valid(pring_in_if_pring_in_if_valid),
		.pring_in_if_ready(pring_in_if_pring_in_if_ready),
		.pring_in_if_payload(pring_in_if_pring_in_if_payload),
		.pring_in_if_srcid(pring_in_if_pring_in_if_srcid),
		.pring_in_if_tgtid(pring_in_if_pring_in_if_tgtid),
		.pring_in_if_qos(pring_in_if_pring_in_if_qos),
		.pring_in_if_last(pring_in_if_pring_in_if_last),
		.nring_out_if_valid(nring_out_if_nring_out_if_valid),
		.nring_out_if_ready(nring_out_if_nring_out_if_ready),
		.nring_out_if_payload(nring_out_if_nring_out_if_payload),
		.nring_out_if_srcid(nring_out_if_nring_out_if_srcid),
		.nring_out_if_tgtid(nring_out_if_nring_out_if_tgtid),
		.nring_out_if_qos(nring_out_if_nring_out_if_qos),
		.nring_out_if_last(nring_out_if_nring_out_if_last),
		.pring_wptr_async(slv_side_TO_mst_side_SIG_pring_wptr_async),
		.pring_rptr_async(mst_side_TO_slv_side_SIG_pring_rptr_async),
		.pring_rptr_sync(mst_side_TO_slv_side_SIG_pring_rptr_sync),
		.pring_pld_sync(slv_side_TO_mst_side_SIG_pring_pld_sync),
		.pring_vc_buf_rdy(mst_side_TO_slv_side_SIG_pring_vc_buf_rdy),
		.nring_wptr_async(mst_side_TO_slv_side_SIG_nring_wptr_async),
		.nring_rptr_async(slv_side_TO_mst_side_SIG_nring_rptr_async),
		.nring_rptr_sync(slv_side_TO_mst_side_SIG_nring_rptr_sync),
		.nring_pld_sync(mst_side_TO_slv_side_SIG_nring_pld_sync),
		.nring_vc_buf_rdy(slv_side_TO_mst_side_SIG_nring_vc_buf_rdy));
	lwnoc_intr_ring_async_bridge_wrap_mst #(
		.PLD_WIDTH(32'd40),
		.ID_WIDTH(32'd8),
		.QOS_WIDTH(32'd4),
		.THRESHOLD_EN(1'b1),
		.SINGLE_THR_WIDTH(32'd1),
		.NODE_NUM(32'd39),
		.SYNC_LEVEL(32'd3),
		.AFIFO_DEP(32'd8))
	mst_side (
		.clk_mst(clk_dst_clk_mst),
		.rst_mst_n(rst_dst_n_rst_mst_n),
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
		.pring_wptr_async(slv_side_TO_mst_side_SIG_pring_wptr_async),
		.pring_rptr_async(mst_side_TO_slv_side_SIG_pring_rptr_async),
		.pring_rptr_sync(mst_side_TO_slv_side_SIG_pring_rptr_sync),
		.pring_pld_sync(slv_side_TO_mst_side_SIG_pring_pld_sync),
		.pring_vc_buf_rdy(mst_side_TO_slv_side_SIG_pring_vc_buf_rdy),
		.nring_wptr_async(mst_side_TO_slv_side_SIG_nring_wptr_async),
		.nring_rptr_async(slv_side_TO_mst_side_SIG_nring_rptr_async),
		.nring_rptr_sync(slv_side_TO_mst_side_SIG_nring_rptr_sync),
		.nring_pld_sync(mst_side_TO_slv_side_SIG_nring_pld_sync),
		.nring_vc_buf_rdy(slv_side_TO_mst_side_SIG_nring_vc_buf_rdy));

endmodule
//[UHDL]Content End [md5:a2353e105c1d1316d052c88a4864195e]


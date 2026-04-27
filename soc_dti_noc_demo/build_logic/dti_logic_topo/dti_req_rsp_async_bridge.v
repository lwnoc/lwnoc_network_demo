//[UHDL]Content Start [md5:ec932a4467d3051eb5e684e1dca95341]
module dti_req_rsp_async_bridge (
	input         clk_src_clk       ,
	input         rst_src_n_rst_n   ,
	input         clk_dst_clk       ,
	input         rst_dst_n_rst_n   ,
	input         s_chan_s_last     ,
	input  [89:0] s_chan_s_payload  ,
	input         s_chan_s_qos      ,
	output        s_chan_s_ready    ,
	input  [5:0]  s_chan_s_srcid    ,
	input  [5:0]  s_chan_s_tgtid    ,
	output        s_chan_s_threshold,
	input         s_chan_s_valid    ,
	output        m_chan_m_last     ,
	output [89:0] m_chan_m_payload  ,
	output        m_chan_m_qos      ,
	input         m_chan_m_ready    ,
	output [5:0]  m_chan_m_srcid    ,
	output [5:0]  m_chan_m_tgtid    ,
	input         m_chan_m_threshold,
	output        m_chan_m_valid    );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0]  mst_side_TO_slv_side_SIG_rptr_async;
	wire [15:0]  mst_side_TO_slv_side_SIG_rptr_sync ;
	wire [15:0]  slv_side_TO_mst_side_SIG_wptr_async;
	wire [104:0] slv_side_TO_mst_side_SIG_pld_sync  ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_async_bridge_slv slv_side (
		.clk(clk_src_clk),
		.rst_n(rst_src_n_rst_n),
		.stall(),
		.clear(),
		.full_zero(),
		.s_valid(s_chan_s_valid),
		.s_ready(s_chan_s_ready),
		.s_payload(s_chan_s_payload),
		.s_last(s_chan_s_last),
		.s_srcid(s_chan_s_srcid),
		.s_tgtid(s_chan_s_tgtid),
		.s_qos(s_chan_s_qos),
		.s_threshold(s_chan_s_threshold),
		.almost_full(),
		.wptr_async(slv_side_TO_mst_side_SIG_wptr_async),
		.rptr_async(mst_side_TO_slv_side_SIG_rptr_async),
		.rptr_sync(mst_side_TO_slv_side_SIG_rptr_sync),
		.pld_sync(slv_side_TO_mst_side_SIG_pld_sync));
	dti_async_bridge_mst mst_side (
		.clk(clk_dst_clk),
		.rst_n(rst_dst_n_rst_n),
		.stall(),
		.clear(),
		.full_zero(),
		.idle(),
		.m_valid(m_chan_m_valid),
		.m_payload(m_chan_m_payload),
		.m_last(m_chan_m_last),
		.m_srcid(m_chan_m_srcid),
		.m_tgtid(m_chan_m_tgtid),
		.m_qos(m_chan_m_qos),
		.m_ready(m_chan_m_ready),
		.m_threshold(m_chan_m_threshold),
		.almost_empty(),
		.wptr_async(slv_side_TO_mst_side_SIG_wptr_async),
		.rptr_async(mst_side_TO_slv_side_SIG_rptr_async),
		.rptr_sync(mst_side_TO_slv_side_SIG_rptr_sync),
		.pld_sync(slv_side_TO_mst_side_SIG_pld_sync));

endmodule
//[UHDL]Content End [md5:ec932a4467d3051eb5e684e1dca95341]


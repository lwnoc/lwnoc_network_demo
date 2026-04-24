//[UHDL]Content Start [md5:cb1f58f745631e740fcd890069c06911]
module async_bridge (
	input         clk_src                                        ,
	input         rst_src_n                                      ,
	input         clk_dst                                        ,
	input         rst_dst_n                                      ,
	input         async_bridge_slv_node_s_chan_porting_s_afready ,
	output        async_bridge_slv_node_s_chan_porting_s_afvalid ,
	input  [2:0]  async_bridge_slv_node_s_chan_porting_s_atbytes ,
	input  [63:0] async_bridge_slv_node_s_chan_porting_s_atdata  ,
	input  [6:0]  async_bridge_slv_node_s_chan_porting_s_atid    ,
	output        async_bridge_slv_node_s_chan_porting_s_atready ,
	input         async_bridge_slv_node_s_chan_porting_s_atvalid ,
	input         async_bridge_slv_node_s_chan_porting_s_atwakeup,
	output        async_bridge_slv_node_s_chan_porting_s_syncreq ,
	output        async_bridge_mst_node_m_chan_porting_m_afready ,
	input         async_bridge_mst_node_m_chan_porting_m_afvalid ,
	output [2:0]  async_bridge_mst_node_m_chan_porting_m_atbytes ,
	output [63:0] async_bridge_mst_node_m_chan_porting_m_atdata  ,
	output [6:0]  async_bridge_mst_node_m_chan_porting_m_atid    ,
	input         async_bridge_mst_node_m_chan_porting_m_atready ,
	output        async_bridge_mst_node_m_chan_porting_m_atvalid ,
	output        async_bridge_mst_node_m_chan_porting_m_atwakeup,
	input         async_bridge_mst_node_m_chan_porting_m_syncreq );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	atb_async_bridge_top slv_side (
		.clk_atb_s(clk_dst),
		.rstn_atb_s(rst_dst_n),
		.s_atvalid(async_bridge_slv_node_s_chan_porting_s_atvalid),
		.s_atready(async_bridge_slv_node_s_chan_porting_s_atready),
		.s_atbytes(async_bridge_slv_node_s_chan_porting_s_atbytes),
		.s_atdata(async_bridge_slv_node_s_chan_porting_s_atdata),
		.s_atid(async_bridge_slv_node_s_chan_porting_s_atid),
		.s_afvalid(async_bridge_slv_node_s_chan_porting_s_afvalid),
		.s_afready(async_bridge_slv_node_s_chan_porting_s_afready),
		.s_syncreq(async_bridge_slv_node_s_chan_porting_s_syncreq),
		.s_atwakeup(async_bridge_slv_node_s_chan_porting_s_atwakeup),
		.slv_full_zero(),
		.clk_atb_m(),
		.rstn_atb_m(),
		.m_atvalid(),
		.m_atready(),
		.m_atbytes(),
		.m_atdata(),
		.m_atid(),
		.m_afvalid(),
		.m_afready(),
		.m_syncreq(),
		.m_atwakeup(),
		.mst_full_zero(),
		.mst_read_idle());
	atb_async_bridge_top mst_side (
		.clk_atb_s(),
		.rstn_atb_s(),
		.s_atvalid(),
		.s_atready(),
		.s_atbytes(),
		.s_atdata(),
		.s_atid(),
		.s_afvalid(),
		.s_afready(),
		.s_syncreq(),
		.s_atwakeup(),
		.slv_full_zero(),
		.clk_atb_m(clk_dst),
		.rstn_atb_m(rst_dst_n),
		.m_atvalid(async_bridge_mst_node_m_chan_porting_m_atvalid),
		.m_atready(async_bridge_mst_node_m_chan_porting_m_atready),
		.m_atbytes(async_bridge_mst_node_m_chan_porting_m_atbytes),
		.m_atdata(async_bridge_mst_node_m_chan_porting_m_atdata),
		.m_atid(async_bridge_mst_node_m_chan_porting_m_atid),
		.m_afvalid(async_bridge_mst_node_m_chan_porting_m_afvalid),
		.m_afready(async_bridge_mst_node_m_chan_porting_m_afready),
		.m_syncreq(async_bridge_mst_node_m_chan_porting_m_syncreq),
		.m_atwakeup(async_bridge_mst_node_m_chan_porting_m_atwakeup),
		.mst_full_zero(),
		.mst_read_idle());

endmodule
//[UHDL]Content End [md5:cb1f58f745631e740fcd890069c06911]


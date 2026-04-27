//[UHDL]Content Start [md5:8935850aede6aac1cb4a65d53b83868c]
module async_bridge (
	input         async_bridge_slv_node_slv_clk_porting_clk_atb_s                      ,
	input         async_bridge_slv_node_slv_rst_n_porting_rstn_atb_s                   ,
	input         async_bridge_slv_node_s_chan_porting_s_afready                       ,
	output        async_bridge_slv_node_s_chan_porting_s_afvalid                       ,
	input  [2:0]  async_bridge_slv_node_s_chan_porting_s_atbytes                       ,
	input  [63:0] async_bridge_slv_node_s_chan_porting_s_atdata                        ,
	input  [6:0]  async_bridge_slv_node_s_chan_porting_s_atid                          ,
	output        async_bridge_slv_node_s_chan_porting_s_atready                       ,
	input         async_bridge_slv_node_s_chan_porting_s_atvalid                       ,
	input         async_bridge_slv_node_s_chan_porting_s_atwakeup                      ,
	output        async_bridge_slv_node_s_chan_porting_s_syncreq                       ,
	output        async_bridge_slv_node_afifo_slv_full_zero_porting_afifo_slv_full_zero,
	input         async_bridge_slv_node_flush_req_porting_flush_req                    ,
	input         async_bridge_mst_node_mst_clk_porting_clk_atb_m                      ,
	input         async_bridge_mst_node_mst_rst_n_porting_rstn_atb_m                   ,
	output        async_bridge_mst_node_m_chan_porting_m_afready                       ,
	input         async_bridge_mst_node_m_chan_porting_m_afvalid                       ,
	output [2:0]  async_bridge_mst_node_m_chan_porting_m_atbytes                       ,
	output [63:0] async_bridge_mst_node_m_chan_porting_m_atdata                        ,
	output [6:0]  async_bridge_mst_node_m_chan_porting_m_atid                          ,
	input         async_bridge_mst_node_m_chan_porting_m_atready                       ,
	output        async_bridge_mst_node_m_chan_porting_m_atvalid                       ,
	output        async_bridge_mst_node_m_chan_porting_m_atwakeup                      ,
	input         async_bridge_mst_node_m_chan_porting_m_syncreq                       ,
	output        async_bridge_mst_node_afifo_mst_full_zero_porting_afifo_mst_full_zero,
	output        async_bridge_mst_node_afifo_mst_read_idle_porting_afifo_mst_read_idle,
	output        async_bridge_mst_node_flush_req_level_porting_flush_req_level        );

	//Wire define for this module.

	//Wire define for sub module.
	wire        mst_side_TO_slv_side_SIG_syncreq_level;
	wire [15:0] mst_side_TO_slv_side_SIG_rptr_async   ;
	wire [15:0] mst_side_TO_slv_side_SIG_rptr_sync    ;
	wire [15:0] slv_side_TO_mst_side_SIG_wptr_async   ;
	wire [77:0] slv_side_TO_mst_side_SIG_pld_sync     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	network_atb_slv slv_side (
		.clk_atb_s(async_bridge_slv_node_slv_clk_porting_clk_atb_s),
		.rstn_atb_s(async_bridge_slv_node_slv_rst_n_porting_rstn_atb_s),
		.s_atvalid(async_bridge_slv_node_s_chan_porting_s_atvalid),
		.s_atready(async_bridge_slv_node_s_chan_porting_s_atready),
		.s_atbytes(async_bridge_slv_node_s_chan_porting_s_atbytes),
		.s_atdata(async_bridge_slv_node_s_chan_porting_s_atdata),
		.s_atid(async_bridge_slv_node_s_chan_porting_s_atid),
		.s_afvalid(async_bridge_slv_node_s_chan_porting_s_afvalid),
		.s_afready(async_bridge_slv_node_s_chan_porting_s_afready),
		.s_syncreq(async_bridge_slv_node_s_chan_porting_s_syncreq),
		.s_atwakeup(async_bridge_slv_node_s_chan_porting_s_atwakeup),
		.flush_req(async_bridge_slv_node_flush_req_porting_flush_req),
		.syncreq_level(mst_side_TO_slv_side_SIG_syncreq_level),
		.afifo_slv_full_zero(async_bridge_slv_node_afifo_slv_full_zero_porting_afifo_slv_full_zero),
		.wptr_async(slv_side_TO_mst_side_SIG_wptr_async),
		.rptr_async(mst_side_TO_slv_side_SIG_rptr_async),
		.rptr_sync(mst_side_TO_slv_side_SIG_rptr_sync),
		.pld_sync(slv_side_TO_mst_side_SIG_pld_sync));
	network_atb_mst mst_side (
		.clk_atb_m(async_bridge_mst_node_mst_clk_porting_clk_atb_m),
		.rstn_atb_m(async_bridge_mst_node_mst_rst_n_porting_rstn_atb_m),
		.m_atvalid(async_bridge_mst_node_m_chan_porting_m_atvalid),
		.m_atready(async_bridge_mst_node_m_chan_porting_m_atready),
		.m_atbytes(async_bridge_mst_node_m_chan_porting_m_atbytes),
		.m_atdata(async_bridge_mst_node_m_chan_porting_m_atdata),
		.m_atid(async_bridge_mst_node_m_chan_porting_m_atid),
		.m_afvalid(async_bridge_mst_node_m_chan_porting_m_afvalid),
		.m_afready(async_bridge_mst_node_m_chan_porting_m_afready),
		.m_syncreq(async_bridge_mst_node_m_chan_porting_m_syncreq),
		.m_atwakeup(async_bridge_mst_node_m_chan_porting_m_atwakeup),
		.syncreq_level(mst_side_TO_slv_side_SIG_syncreq_level),
		.flush_req_level(async_bridge_mst_node_flush_req_level_porting_flush_req_level),
		.afifo_mst_full_zero(async_bridge_mst_node_afifo_mst_full_zero_porting_afifo_mst_full_zero),
		.afifo_mst_read_idle(async_bridge_mst_node_afifo_mst_read_idle_porting_afifo_mst_read_idle),
		.wptr_async(slv_side_TO_mst_side_SIG_wptr_async),
		.rptr_async(mst_side_TO_slv_side_SIG_rptr_async),
		.rptr_sync(mst_side_TO_slv_side_SIG_rptr_sync),
		.pld_sync(slv_side_TO_mst_side_SIG_pld_sync));

endmodule
//[UHDL]Content End [md5:8935850aede6aac1cb4a65d53b83868c]


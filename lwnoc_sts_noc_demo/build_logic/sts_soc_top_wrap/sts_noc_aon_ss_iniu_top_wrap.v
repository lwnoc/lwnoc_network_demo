//[UHDL]Content Start [md5:6e02d9fc7270606cb458ab13b7fc47de]
module sts_noc_aon_ss_iniu_top_wrap (
	input          clk_dst_clk_dst                                  ,
	input          rst_n_dst_rst_n_dst                              ,
	input  [131:0] async_fifo_req_pld_sync                          ,
	output [15:0]  async_fifo_req_rptr_async                        ,
	output [15:0]  async_fifo_req_rptr_sync                         ,
	input  [15:0]  async_fifo_req_wptr_async                        ,
	output [76:0]  async_fifo_rsp_pld_sync                          ,
	input  [15:0]  async_fifo_rsp_rptr_async                        ,
	input  [15:0]  async_fifo_rsp_rptr_sync                         ,
	output [15:0]  async_fifo_rsp_wptr_async                        ,
	output [120:0] req_req_s_pld                                    ,
	input          req_req_s_rdy                                    ,
	output         req_req_s_vld                                    ,
	input  [66:0]  rsp_rsp_m_pld                                    ,
	output         rsp_rsp_m_rdy                                    ,
	input          rsp_rsp_m_vld                                    ,
	input  [47:0]  cti_channel_in_ctm_channel_in                    ,
	output [47:0]  cti_channel_out_ctm_channel_out                  ,
	input  [7:0]   sys_side_cti_trigin_sys_side_cti_trigin          ,
	output [7:0]   sys_side_cti_trigin_ack_sys_side_cti_trigin_ack  ,
	output [7:0]   sys_side_cti_trigout_sys_side_cti_trigout        ,
	input  [7:0]   sys_side_cti_trigout_ack_sys_side_cti_trigout_ack,
	input  [31:0]  sys_side_ctm_trigin_sys_side_ctm_trigin          ,
	output [31:0]  sys_side_ctm_trigin_ack_sys_side_ctm_trigin_ack  ,
	output [31:0]  sys_side_ctm_trigout_sys_side_ctm_trigout        ,
	input  [31:0]  sys_side_ctm_trigout_ack_sys_side_ctm_trigout_ack,
	input  [63:0]  dbg_timestamp_in_dbg_timestamp_in                ,
	output [63:0]  dbg_timestamp_out_dbg_timestamp_out              ,
	input  [31:0]  dbg_data_in_dbg_data_in                          ,
	output [31:0]  dbg_data_out_dbg_data_out                        ,
	input  [7:0]   reserved_bits_in_reserved_bits_in                ,
	output [7:0]   reserved_bits_out_reserved_bits_out              ,
	input  [11:0]  cti_apb_cti_apb_paddr                            ,
	input          cti_apb_cti_apb_penable                          ,
	output [31:0]  cti_apb_cti_apb_prdata                           ,
	output         cti_apb_cti_apb_pready                           ,
	input          cti_apb_cti_apb_psel                             ,
	output         cti_apb_cti_apb_pslverr                          ,
	input  [31:0]  cti_apb_cti_apb_pwdata                           ,
	input          cti_apb_cti_apb_pwrite                           ,
	output         req_afifo_sb_err_req_afifo_sb_err                ,
	output         req_afifo_db_err_req_afifo_db_err                );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	sts_noc_aon_ss_iniu_sts_iniu_noc noc_side (
		.clk_dst(clk_dst_clk_dst),
		.rst_n_dst(rst_n_dst_rst_n_dst),
		.req_wptr_async(async_fifo_req_wptr_async),
		.req_rptr_async(async_fifo_req_rptr_async),
		.req_rptr_sync(async_fifo_req_rptr_sync),
		.req_pld_sync(async_fifo_req_pld_sync),
		.rsp_wptr_async(async_fifo_rsp_wptr_async),
		.rsp_rptr_async(async_fifo_rsp_rptr_async),
		.rsp_rptr_sync(async_fifo_rsp_rptr_sync),
		.rsp_pld_sync(async_fifo_rsp_pld_sync),
		.req_s_vld(req_req_s_vld),
		.req_s_rdy(req_req_s_rdy),
		.req_s_pld(req_req_s_pld),
		.rsp_m_vld(rsp_rsp_m_vld),
		.rsp_m_rdy(rsp_rsp_m_rdy),
		.rsp_m_pld(rsp_rsp_m_pld),
		.dbg_data_in(dbg_data_in_dbg_data_in),
		.dbg_data_out(dbg_data_out_dbg_data_out),
		.sys_side_cti_trigin(sys_side_cti_trigin_sys_side_cti_trigin),
		.sys_side_cti_trigin_ack(sys_side_cti_trigin_ack_sys_side_cti_trigin_ack),
		.sys_side_cti_trigout(sys_side_cti_trigout_sys_side_cti_trigout),
		.sys_side_cti_trigout_ack(sys_side_cti_trigout_ack_sys_side_cti_trigout_ack),
		.ctm_channel_in(cti_channel_in_ctm_channel_in),
		.ctm_channel_out(cti_channel_out_ctm_channel_out),
		.sys_side_ctm_trigin(sys_side_ctm_trigin_sys_side_ctm_trigin),
		.sys_side_ctm_trigin_ack(sys_side_ctm_trigin_ack_sys_side_ctm_trigin_ack),
		.sys_side_ctm_trigout(sys_side_ctm_trigout_sys_side_ctm_trigout),
		.sys_side_ctm_trigout_ack(sys_side_ctm_trigout_ack_sys_side_ctm_trigout_ack),
		.cti_apb_psel(cti_apb_cti_apb_psel),
		.cti_apb_penable(cti_apb_cti_apb_penable),
		.cti_apb_paddr(cti_apb_cti_apb_paddr),
		.cti_apb_pwrite(cti_apb_cti_apb_pwrite),
		.cti_apb_pwdata(cti_apb_cti_apb_pwdata),
		.cti_apb_prdata(cti_apb_cti_apb_prdata),
		.cti_apb_pready(cti_apb_cti_apb_pready),
		.cti_apb_pslverr(cti_apb_cti_apb_pslverr),
		.dbg_timestamp_in(dbg_timestamp_in_dbg_timestamp_in),
		.dbg_timestamp_out(dbg_timestamp_out_dbg_timestamp_out),
		.reserved_bits_in(reserved_bits_in_reserved_bits_in),
		.reserved_bits_out(reserved_bits_out_reserved_bits_out),
		.req_afifo_sb_err(req_afifo_sb_err_req_afifo_sb_err),
		.req_afifo_db_err(req_afifo_db_err_req_afifo_db_err));

endmodule
//[UHDL]Content End [md5:6e02d9fc7270606cb458ab13b7fc47de]


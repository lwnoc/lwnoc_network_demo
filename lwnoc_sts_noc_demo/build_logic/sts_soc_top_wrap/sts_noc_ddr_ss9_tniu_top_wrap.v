//[UHDL]Content Start [md5:134b80272412f23f9865702ab5c6c411]
module sts_noc_ddr_ss9_tniu_top_wrap (
	input          clk_src_clk_src                                  ,
	input          rstn_src_rstn_src                                ,
	output [131:0] async_fifo_req_pld_sync                          ,
	input  [15:0]  async_fifo_req_rptr_async                        ,
	input  [15:0]  async_fifo_req_rptr_sync                         ,
	output [15:0]  async_fifo_req_wptr_async                        ,
	input  [76:0]  async_fifo_rsp_pld_sync                          ,
	output [15:0]  async_fifo_rsp_rptr_async                        ,
	output [15:0]  async_fifo_rsp_rptr_sync                         ,
	input  [15:0]  async_fifo_rsp_wptr_async                        ,
	input  [120:0] req_in_req_pld                                   ,
	output         req_in_req_rdy                                   ,
	input          req_in_req_vld                                   ,
	output [66:0]  rsp_out_rsp_pld                                  ,
	input          rsp_out_rsp_rdy                                  ,
	output         rsp_out_rsp_vld                                  ,
	input  [31:0]  dbg_data_in_dbg_data_in                          ,
	output [31:0]  dbg_data_out_dbg_data_out                        ,
	input  [63:0]  dbg_timestamp_in_dbg_timestamp_in                ,
	output [63:0]  dbg_timestamp_out_dbg_timestamp_out              ,
	input  [7:0]   reserved_bits_in_reserved_bits_in                ,
	output [7:0]   reserved_bits_out_reserved_bits_out              ,
	input  [47:0]  ctm_channel_in_ctm_channel_in                    ,
	output [47:0]  ctm_channel_out_ctm_channel_out                  ,
	input  [7:0]   sys_side_cti_trigin_sys_side_cti_trigin          ,
	output [7:0]   sys_side_cti_trigin_ack_sys_side_cti_trigin_ack  ,
	output [7:0]   sys_side_cti_trigout_sys_side_cti_trigout        ,
	input  [7:0]   sys_side_cti_trigout_ack_sys_side_cti_trigout_ack,
	input  [31:0]  sys_side_ctm_trigin_sys_side_ctm_trigin          ,
	output [31:0]  sys_side_ctm_trigin_ack_sys_side_ctm_trigin_ack  ,
	output [31:0]  sys_side_ctm_trigout_sys_side_ctm_trigout        ,
	input  [31:0]  sys_side_ctm_trigout_ack_sys_side_ctm_trigout_ack,
	output [31:0]  timing_bus1_timing_bus1                          ,
	output [31:0]  timing_bus2_timing_bus2                          ,
	output [31:0]  timing_bus3_timing_bus3                          ,
	output [31:0]  dbg_en_dbg_en                                    ,
	output [9:0]   hw_dbg_sel_hw_dbg_sel                            ,
	output         tniu_regbank_parity_err_tniu_regbank_parity_err  ,
	output         rsp_afifo_sb_err_rsp_afifo_sb_err                ,
	output         rsp_afifo_db_err_rsp_afifo_db_err                );

	//Wire define for this module.

	//Wire define for sub module.
	wire [31:0] apb_idle_target_TO_noc_side_SIG_apb_prdata ;
	wire        apb_idle_target_TO_noc_side_SIG_apb_pready ;
	wire        apb_idle_target_TO_noc_side_SIG_apb_pslverr;
	wire [31:0] noc_side_TO_apb_idle_target_SIG_paddr      ;
	wire        noc_side_TO_apb_idle_target_SIG_penable    ;
	wire [2:0]  noc_side_TO_apb_idle_target_SIG_pprot      ;
	wire        noc_side_TO_apb_idle_target_SIG_psel       ;
	wire [3:0]  noc_side_TO_apb_idle_target_SIG_pstrb      ;
	wire [31:0] noc_side_TO_apb_idle_target_SIG_pwdata     ;
	wire        noc_side_TO_apb_idle_target_SIG_pwrite     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	sts_noc_ddr_ss9_tniu_sts_tniu_noc noc_side (
		.clk_src(clk_src_clk_src),
		.rstn_src(rstn_src_rstn_src),
		.in_req_vld(req_in_req_vld),
		.in_req_rdy(req_in_req_rdy),
		.in_req_pld(req_in_req_pld),
		.out_rsp_vld(rsp_out_rsp_vld),
		.out_rsp_rdy(rsp_out_rsp_rdy),
		.out_rsp_pld(rsp_out_rsp_pld),
		.req_wptr_async(async_fifo_req_wptr_async),
		.req_rptr_async(async_fifo_req_rptr_async),
		.req_rptr_sync(async_fifo_req_rptr_sync),
		.req_pld_sync(async_fifo_req_pld_sync),
		.rsp_wptr_async(async_fifo_rsp_wptr_async),
		.rsp_rptr_async(async_fifo_rsp_rptr_async),
		.rsp_rptr_sync(async_fifo_rsp_rptr_sync),
		.rsp_pld_sync(async_fifo_rsp_pld_sync),
		.psel(noc_side_TO_apb_idle_target_SIG_psel),
		.penable(noc_side_TO_apb_idle_target_SIG_penable),
		.paddr(noc_side_TO_apb_idle_target_SIG_paddr),
		.pwrite(noc_side_TO_apb_idle_target_SIG_pwrite),
		.pwdata(noc_side_TO_apb_idle_target_SIG_pwdata),
		.prdata(apb_idle_target_TO_noc_side_SIG_apb_prdata),
		.pready(apb_idle_target_TO_noc_side_SIG_apb_pready),
		.pstrb(noc_side_TO_apb_idle_target_SIG_pstrb),
		.pprot(noc_side_TO_apb_idle_target_SIG_pprot),
		.pslverr(apb_idle_target_TO_noc_side_SIG_apb_pslverr),
		.dbg_data_in(dbg_data_in_dbg_data_in),
		.dbg_data_out(dbg_data_out_dbg_data_out),
		.dbg_timestamp_in(dbg_timestamp_in_dbg_timestamp_in),
		.dbg_timestamp_out(dbg_timestamp_out_dbg_timestamp_out),
		.reserved_bits_in(reserved_bits_in_reserved_bits_in),
		.reserved_bits_out(reserved_bits_out_reserved_bits_out),
		.sys_side_cti_trigin(sys_side_cti_trigin_sys_side_cti_trigin),
		.sys_side_cti_trigin_ack(sys_side_cti_trigin_ack_sys_side_cti_trigin_ack),
		.sys_side_cti_trigout(sys_side_cti_trigout_sys_side_cti_trigout),
		.sys_side_cti_trigout_ack(sys_side_cti_trigout_ack_sys_side_cti_trigout_ack),
		.ctm_channel_in(ctm_channel_in_ctm_channel_in),
		.ctm_channel_out(ctm_channel_out_ctm_channel_out),
		.sys_side_ctm_trigin(sys_side_ctm_trigin_sys_side_ctm_trigin),
		.sys_side_ctm_trigin_ack(sys_side_ctm_trigin_ack_sys_side_ctm_trigin_ack),
		.sys_side_ctm_trigout(sys_side_ctm_trigout_sys_side_ctm_trigout),
		.sys_side_ctm_trigout_ack(sys_side_ctm_trigout_ack_sys_side_ctm_trigout_ack),
		.timing_bus1(timing_bus1_timing_bus1),
		.timing_bus2(timing_bus2_timing_bus2),
		.timing_bus3(timing_bus3_timing_bus3),
		.dbg_en(dbg_en_dbg_en),
		.hw_dbg_sel(hw_dbg_sel_hw_dbg_sel),
		.tniu_regbank_parity_err(tniu_regbank_parity_err_tniu_regbank_parity_err),
		.rsp_afifo_sb_err(rsp_afifo_sb_err_rsp_afifo_sb_err),
		.rsp_afifo_db_err(rsp_afifo_db_err_rsp_afifo_db_err));
	sts_noc_apb_idle_target apb_idle_target (
		.apb_paddr(noc_side_TO_apb_idle_target_SIG_paddr),
		.apb_penable(noc_side_TO_apb_idle_target_SIG_penable),
		.apb_pprot(noc_side_TO_apb_idle_target_SIG_pprot),
		.apb_prdata(apb_idle_target_TO_noc_side_SIG_apb_prdata),
		.apb_pready(apb_idle_target_TO_noc_side_SIG_apb_pready),
		.apb_psel(noc_side_TO_apb_idle_target_SIG_psel),
		.apb_pslverr(apb_idle_target_TO_noc_side_SIG_apb_pslverr),
		.apb_pstrb(noc_side_TO_apb_idle_target_SIG_pstrb),
		.apb_pwdata(noc_side_TO_apb_idle_target_SIG_pwdata),
		.apb_pwrite(noc_side_TO_apb_idle_target_SIG_pwrite));

endmodule
//[UHDL]Content End [md5:134b80272412f23f9865702ab5c6c411]


//[UHDL]Content Start [md5:68d493a769b64312b2dd39c0436c4463]
module sts_noc_ddrss1_tniu (
	input          clk_src                                                ,
	input          rstn_src                                               ,
	input          clk_dst                                                ,
	input          rstn_dst                                               ,
	input          clk_dbg_timer                                          ,
	input          rstn_dbg_timer                                         ,
	input  [120:0] top_req_in_req_pld                                     ,
	output         top_req_in_req_rdy                                     ,
	input          top_req_in_req_vld                                     ,
	output [66:0]  top_rsp_out_rsp_pld                                    ,
	input          top_rsp_out_rsp_rdy                                    ,
	output         top_rsp_out_rsp_vld                                    ,
	output [31:0]  sys_apb_m_paddr                                        ,
	output         sys_apb_m_penable                                      ,
	output [2:0]   sys_apb_m_pprot                                        ,
	input  [31:0]  sys_apb_m_prdata                                       ,
	input          sys_apb_m_pready                                       ,
	output         sys_apb_m_psel                                         ,
	input          sys_apb_m_pslverr                                      ,
	output [3:0]   sys_apb_m_pstrb                                        ,
	output [31:0]  sys_apb_m_pwdata                                       ,
	output         sys_apb_m_pwrite                                       ,
	output [319:0] v_tniu_sys_reg_v_tniu_sys_reg                          ,
	input  [47:0]  noc_ctm_channel_in_ctm_channel_in                      ,
	output [47:0]  noc_ctm_channel_out_ctm_channel_out                    ,
	input  [7:0]   sys_cti_trigin_sys_cti_trigin                          ,
	output [7:0]   sys_cti_trigin_ack_sys_cti_trigin_ack                  ,
	output [7:0]   sys_cti_trigout_sys_cti_trigout                        ,
	input  [7:0]   sys_cti_trigout_ack_sys_cti_trigout_ack                ,
	input  [31:0]  sys_ctm_trigin_sys_ctm_trigin                          ,
	output [31:0]  sys_ctm_trigin_ack_sys_ctm_trigin_ack                  ,
	output [31:0]  sys_ctm_trigout_sys_ctm_trigout                        ,
	input  [31:0]  sys_ctm_trigout_ack_sys_ctm_trigout_ack                ,
	input  [31:0]  dbg_data_in_dbg_data_in                                ,
	output [63:0]  dbg_timestamp_out_dbg_timestamp_out                    ,
	output [31:0]  noc_dbg_data_out_dbg_data_out                          ,
	input  [63:0]  noc_dbg_timestamp_in_dbg_timestamp_in                  ,
	input  [7:0]   noc_reserved_bits_in_reserved_bits_in                  ,
	output [7:0]   reserved_bits_out_reserved_bits_out                    ,
	output         safety_sts_tniu_req_afifo_db_err                       ,
	output         safety_sts_tniu_req_afifo_sb_err                       ,
	output [31:0]  timing_bus1_timing_bus1                                ,
	output [31:0]  timing_bus2_timing_bus2                                ,
	output [31:0]  timing_bus3_timing_bus3                                ,
	output [31:0]  dbg_en_dbg_en                                          ,
	output [9:0]   hw_dbg_sel_out_hw_dbg_sel_out                          ,
	output         tniu_sys_regbank_parity_err_tniu_sys_regbank_parity_err,
	output         tniu_regbank_parity_err_tniu_regbank_parity_err        ,
	output         rsp_afifo_sb_err_rsp_afifo_sb_err                      ,
	output         rsp_afifo_db_err_rsp_afifo_db_err                      );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0]  noc_side_TO_sys_side_SIG_req_wptr_async         ;
	wire [130:0] noc_side_TO_sys_side_SIG_req_pld_sync           ;
	wire [15:0]  noc_side_TO_sys_side_SIG_rsp_rptr_async         ;
	wire [15:0]  noc_side_TO_sys_side_SIG_rsp_rptr_sync          ;
	wire [7:0]   noc_side_TO_sys_side_SIG_sys_side_cti_trigin_ack;
	wire [7:0]   noc_side_TO_sys_side_SIG_sys_side_cti_trigout   ;
	wire [31:0]  noc_side_TO_sys_side_SIG_sys_side_ctm_trigin_ack;
	wire [31:0]  noc_side_TO_sys_side_SIG_sys_side_ctm_trigout   ;
	wire [63:0]  noc_side_TO_sys_side_SIG_dbg_timestamp_out      ;
	wire [7:0]   noc_side_TO_sys_side_SIG_reserved_bits_out      ;
	wire [9:0]   noc_side_TO_sys_side_SIG_hw_dbg_sel             ;
	wire [15:0]  sys_side_TO_noc_side_SIG_req_rptr_async         ;
	wire [15:0]  sys_side_TO_noc_side_SIG_req_rptr_sync          ;
	wire [15:0]  sys_side_TO_noc_side_SIG_rsp_wptr_async         ;
	wire [75:0]  sys_side_TO_noc_side_SIG_rsp_pld_sync           ;
	wire [31:0]  apb_idle_target_TO_noc_side_SIG_apb_prdata      ;
	wire         apb_idle_target_TO_noc_side_SIG_apb_pready      ;
	wire         apb_idle_target_TO_noc_side_SIG_apb_pslverr     ;
	wire [31:0]  sys_side_TO_noc_side_SIG_dbg_data_out           ;
	wire [7:0]   sys_side_TO_noc_side_SIG_noc_cti_trigin         ;
	wire [7:0]   sys_side_TO_noc_side_SIG_noc_cti_trigout_ack    ;
	wire [31:0]  sys_side_TO_noc_side_SIG_noc_ctm_trigin         ;
	wire [31:0]  sys_side_TO_noc_side_SIG_noc_ctm_trigout_ack    ;
	wire [31:0]  noc_side_TO_apb_idle_target_SIG_paddr           ;
	wire         noc_side_TO_apb_idle_target_SIG_penable         ;
	wire [2:0]   noc_side_TO_apb_idle_target_SIG_pprot           ;
	wire         noc_side_TO_apb_idle_target_SIG_psel            ;
	wire [3:0]   noc_side_TO_apb_idle_target_SIG_pstrb           ;
	wire [31:0]  noc_side_TO_apb_idle_target_SIG_pwdata          ;
	wire         noc_side_TO_apb_idle_target_SIG_pwrite          ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	sts_noc_ddr_ss_tniu_sts_tniu_sys sys_side (
		.clk_dst(clk_dst),
		.clk_dbg_timer(clk_dbg_timer),
		.rstn_dst(rstn_dst),
		.rstn_dbg_timer(rstn_dbg_timer),
		.req_wptr_async(noc_side_TO_sys_side_SIG_req_wptr_async),
		.req_rptr_async(sys_side_TO_noc_side_SIG_req_rptr_async),
		.req_rptr_sync(sys_side_TO_noc_side_SIG_req_rptr_sync),
		.req_pld_sync(noc_side_TO_sys_side_SIG_req_pld_sync),
		.rsp_wptr_async(sys_side_TO_noc_side_SIG_rsp_wptr_async),
		.rsp_rptr_async(noc_side_TO_sys_side_SIG_rsp_rptr_async),
		.rsp_rptr_sync(noc_side_TO_sys_side_SIG_rsp_rptr_sync),
		.rsp_pld_sync(sys_side_TO_noc_side_SIG_rsp_pld_sync),
		.m_psel(sys_apb_m_psel),
		.m_paddr(sys_apb_m_paddr),
		.m_pready(sys_apb_m_pready),
		.m_prdata(sys_apb_m_prdata),
		.m_pslverr(sys_apb_m_pslverr),
		.m_pprot(sys_apb_m_pprot),
		.m_penable(sys_apb_m_penable),
		.m_pwrite(sys_apb_m_pwrite),
		.m_pwdata(sys_apb_m_pwdata),
		.m_pstrb(sys_apb_m_pstrb),
		.v_tniu_sys_reg(v_tniu_sys_reg_v_tniu_sys_reg),
		.sys_cti_trigin(sys_cti_trigin_sys_cti_trigin),
		.sys_cti_trigin_ack(sys_cti_trigin_ack_sys_cti_trigin_ack),
		.noc_cti_trigin(sys_side_TO_noc_side_SIG_noc_cti_trigin),
		.noc_cti_trigin_ack(noc_side_TO_sys_side_SIG_sys_side_cti_trigin_ack),
		.noc_cti_trigout(noc_side_TO_sys_side_SIG_sys_side_cti_trigout),
		.noc_cti_trigout_ack(sys_side_TO_noc_side_SIG_noc_cti_trigout_ack),
		.sys_cti_trigout(sys_cti_trigout_sys_cti_trigout),
		.sys_cti_trigout_ack(sys_cti_trigout_ack_sys_cti_trigout_ack),
		.sys_ctm_trigin(sys_ctm_trigin_sys_ctm_trigin),
		.sys_ctm_trigin_ack(sys_ctm_trigin_ack_sys_ctm_trigin_ack),
		.noc_ctm_trigin(sys_side_TO_noc_side_SIG_noc_ctm_trigin),
		.noc_ctm_trigin_ack(noc_side_TO_sys_side_SIG_sys_side_ctm_trigin_ack),
		.noc_ctm_trigout(noc_side_TO_sys_side_SIG_sys_side_ctm_trigout),
		.noc_ctm_trigout_ack(sys_side_TO_noc_side_SIG_noc_ctm_trigout_ack),
		.sys_ctm_trigout(sys_ctm_trigout_sys_ctm_trigout),
		.sys_ctm_trigout_ack(sys_ctm_trigout_ack_sys_ctm_trigout_ack),
		.dbg_data_in(dbg_data_in_dbg_data_in),
		.dbg_data_out(sys_side_TO_noc_side_SIG_dbg_data_out),
		.dbg_timestamp_in(noc_side_TO_sys_side_SIG_dbg_timestamp_out),
		.dbg_timestamp_out(dbg_timestamp_out_dbg_timestamp_out),
		.reserved_bits_in(noc_side_TO_sys_side_SIG_reserved_bits_out),
		.reserved_bits_out(reserved_bits_out_reserved_bits_out),
		.tniu_sys_regbank_parity_err(tniu_sys_regbank_parity_err_tniu_sys_regbank_parity_err),
		.sts_tniu_req_afifo_sb_err(safety_sts_tniu_req_afifo_sb_err),
		.sts_tniu_req_afifo_db_err(safety_sts_tniu_req_afifo_db_err),
		.hw_dbg_sel_in(noc_side_TO_sys_side_SIG_hw_dbg_sel),
		.hw_dbg_sel_out(hw_dbg_sel_out_hw_dbg_sel_out));
	sts_noc_ddr_ss1_tniu_sts_tniu_noc noc_side (
		.clk_src(clk_src),
		.rstn_src(rstn_src),
		.in_req_vld(top_req_in_req_vld),
		.in_req_rdy(top_req_in_req_rdy),
		.in_req_pld(top_req_in_req_pld),
		.out_rsp_vld(top_rsp_out_rsp_vld),
		.out_rsp_rdy(top_rsp_out_rsp_rdy),
		.out_rsp_pld(top_rsp_out_rsp_pld),
		.req_wptr_async(noc_side_TO_sys_side_SIG_req_wptr_async),
		.req_rptr_async(sys_side_TO_noc_side_SIG_req_rptr_async),
		.req_rptr_sync(sys_side_TO_noc_side_SIG_req_rptr_sync),
		.req_pld_sync(noc_side_TO_sys_side_SIG_req_pld_sync),
		.rsp_wptr_async(sys_side_TO_noc_side_SIG_rsp_wptr_async),
		.rsp_rptr_async(noc_side_TO_sys_side_SIG_rsp_rptr_async),
		.rsp_rptr_sync(noc_side_TO_sys_side_SIG_rsp_rptr_sync),
		.rsp_pld_sync(sys_side_TO_noc_side_SIG_rsp_pld_sync),
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
		.dbg_data_in(sys_side_TO_noc_side_SIG_dbg_data_out),
		.dbg_data_out(noc_dbg_data_out_dbg_data_out),
		.dbg_timestamp_in(noc_dbg_timestamp_in_dbg_timestamp_in),
		.dbg_timestamp_out(noc_side_TO_sys_side_SIG_dbg_timestamp_out),
		.reserved_bits_in(noc_reserved_bits_in_reserved_bits_in),
		.reserved_bits_out(noc_side_TO_sys_side_SIG_reserved_bits_out),
		.sys_side_cti_trigin(sys_side_TO_noc_side_SIG_noc_cti_trigin),
		.sys_side_cti_trigin_ack(noc_side_TO_sys_side_SIG_sys_side_cti_trigin_ack),
		.sys_side_cti_trigout(noc_side_TO_sys_side_SIG_sys_side_cti_trigout),
		.sys_side_cti_trigout_ack(sys_side_TO_noc_side_SIG_noc_cti_trigout_ack),
		.ctm_channel_in(noc_ctm_channel_in_ctm_channel_in),
		.ctm_channel_out(noc_ctm_channel_out_ctm_channel_out),
		.sys_side_ctm_trigin(sys_side_TO_noc_side_SIG_noc_ctm_trigin),
		.sys_side_ctm_trigin_ack(noc_side_TO_sys_side_SIG_sys_side_ctm_trigin_ack),
		.sys_side_ctm_trigout(noc_side_TO_sys_side_SIG_sys_side_ctm_trigout),
		.sys_side_ctm_trigout_ack(sys_side_TO_noc_side_SIG_noc_ctm_trigout_ack),
		.timing_bus1(timing_bus1_timing_bus1),
		.timing_bus2(timing_bus2_timing_bus2),
		.timing_bus3(timing_bus3_timing_bus3),
		.dbg_en(dbg_en_dbg_en),
		.hw_dbg_sel(noc_side_TO_sys_side_SIG_hw_dbg_sel),
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
//[UHDL]Content End [md5:68d493a769b64312b2dd39c0436c4463]

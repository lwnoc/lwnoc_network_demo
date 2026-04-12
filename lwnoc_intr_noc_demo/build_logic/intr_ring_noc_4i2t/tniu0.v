//[UHDL]Content Start [md5:3f372aae8c2eadf26bb9c2fdbb6cf158]
module tniu0 (
	input           clk_sys_clk                                          ,
	input           rst_sys_n_rst_n                                      ,
	input           clk_noc                                              ,
	input           rst_noc_n                                            ,
	input           pring_in_if_pring_in_if_cw_in_last                   ,
	input  [39:0]   pring_in_if_pring_in_if_cw_in_payload                ,
	input  [3:0]    pring_in_if_pring_in_if_cw_in_qos                    ,
	output          pring_in_if_pring_in_if_cw_in_ready                  ,
	input  [7:0]    pring_in_if_pring_in_if_cw_in_srcid                  ,
	input  [7:0]    pring_in_if_pring_in_if_cw_in_tgtid                  ,
	input           pring_in_if_pring_in_if_cw_in_valid                  ,
	output          pring_out_if_pring_out_if_m_last                     ,
	output [39:0]   pring_out_if_pring_out_if_m_payload                  ,
	output [3:0]    pring_out_if_pring_out_if_m_qos                      ,
	input           pring_out_if_pring_out_if_m_ready                    ,
	output [7:0]    pring_out_if_pring_out_if_m_srcid                    ,
	output [7:0]    pring_out_if_pring_out_if_m_tgtid                    ,
	output          pring_out_if_pring_out_if_m_valid                    ,
	input           nring_in_if_nring_in_if_ccw_in_last                  ,
	input  [39:0]   nring_in_if_nring_in_if_ccw_in_payload               ,
	input  [3:0]    nring_in_if_nring_in_if_ccw_in_qos                   ,
	output          nring_in_if_nring_in_if_ccw_in_ready                 ,
	input  [7:0]    nring_in_if_nring_in_if_ccw_in_srcid                 ,
	input  [7:0]    nring_in_if_nring_in_if_ccw_in_tgtid                 ,
	input           nring_in_if_nring_in_if_ccw_in_valid                 ,
	output          nring_out_if_nring_out_if_m_last                     ,
	output [39:0]   nring_out_if_nring_out_if_m_payload                  ,
	output [3:0]    nring_out_if_nring_out_if_m_qos                      ,
	input           nring_out_if_nring_out_if_m_ready                    ,
	output [7:0]    nring_out_if_nring_out_if_m_srcid                    ,
	output [7:0]    nring_out_if_nring_out_if_m_tgtid                    ,
	output          nring_out_if_nring_out_if_m_valid                    ,
	input  [9:0]    tniu0_top_timeout_val_porting_timeout_val            ,
	input  [8:0]           tniu0_top_lp_hub_porting_lp_hub_rx_req               ,
	output [8:0]          tniu0_top_lp_hub_porting_lp_hub_tx_req               ,
	input  [7:0]    tniu0_sys_tniu_tgt_id_porting_tniu_tgt_id            ,
	output [4095:0] tniu0_sys_v_interrupt_porting_v_interrupt            ,
	output [127:0]  tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt,
	input  [31:0]   tniu0_sys_apb_porting_p_addr                         ,
	input           tniu0_sys_apb_porting_p_enable                       ,
	output [31:0]   tniu0_sys_apb_porting_p_rdata                        ,
	output          tniu0_sys_apb_porting_p_ready                        ,
	input           tniu0_sys_apb_porting_p_sel                          ,
	output          tniu0_sys_apb_porting_p_slverr                       ,
	input  [31:0]   tniu0_sys_apb_porting_p_wdata                        ,
	input           tniu0_sys_apb_porting_p_write                        ,
	input  [9:0]    tniu0_sys_timeout_val_porting_timeout_val            ,
	input           tniu0_ring_local_tx_porting_local_tx_local_tx_last   ,
	input  [39:0]   tniu0_ring_local_tx_porting_local_tx_local_tx_payload,
	input  [3:0]    tniu0_ring_local_tx_porting_local_tx_local_tx_qos    ,
	output          tniu0_ring_local_tx_porting_local_tx_local_tx_ready  ,
	input  [7:0]    tniu0_ring_local_tx_porting_local_tx_local_tx_srcid  ,
	input  [7:0]    tniu0_ring_local_tx_porting_local_tx_local_tx_tgtid  ,
	input           tniu0_ring_local_tx_porting_local_tx_local_tx_valid  );

	//Wire define for this module.

	//Wire define for sub module.
	wire [9:0]  tniu_sys_TO_tniu_top_SIG_rptr_async               ;
	wire [9:0]  tniu_sys_TO_tniu_top_SIG_rptr_sync                ;
	wire [8:0] tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req  ;
	wire [8:0] tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req  ;
	wire [9:0]  tniu_top_TO_tniu_sys_SIG_wptr_async               ;
	wire [61:0] tniu_top_TO_tniu_sys_SIG_pld_sync                 ;
	wire [8:0] tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req  ;
	wire [8:0] tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req  ;

	wire        ring_wrap_TO_tniu_top_SIG_req_valid     ;
	wire [39:0] ring_wrap_TO_tniu_top_SIG_req_payload   ;
	wire [7:0]  ring_wrap_TO_tniu_top_SIG_req_srcid     ;
	wire [7:0]  ring_wrap_TO_tniu_top_SIG_req_tgtid     ;
	wire [3:0]  ring_wrap_TO_tniu_top_SIG_req_qos       ;
	wire        ring_wrap_TO_tniu_top_SIG_req_last      ;
	wire        tniu_top_TO_ring_wrap_SIG_req_ready     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	intr_tniu_top_interrupt_tniu_aync_top_side tniu_top (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.wptr_async(tniu_top_TO_tniu_sys_SIG_wptr_async),
		.rptr_async(tniu_sys_TO_tniu_top_SIG_rptr_async),
		.rptr_sync(tniu_sys_TO_tniu_top_SIG_rptr_sync),
		.pld_sync(tniu_top_TO_tniu_sys_SIG_pld_sync),
		.timeout_val(tniu0_top_timeout_val_porting_timeout_val),
		.lp_hub_rx_req(tniu0_top_lp_hub_porting_lp_hub_rx_req),
		.lp_hub_tx_req(tniu0_top_lp_hub_porting_lp_hub_tx_req),
		.s_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),
		.s_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req),
		.s_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),
		.req_valid(ring_wrap_TO_tniu_top_SIG_req_valid),
		.req_ready(tniu_top_TO_ring_wrap_SIG_req_ready),
		.req_payload(ring_wrap_TO_tniu_top_SIG_req_payload),
		.req_srcid(ring_wrap_TO_tniu_top_SIG_req_srcid),
		.req_tgtid(ring_wrap_TO_tniu_top_SIG_req_tgtid),
		.req_qos(ring_wrap_TO_tniu_top_SIG_req_qos),
		.req_last(ring_wrap_TO_tniu_top_SIG_req_last),
		.req_threshold());
	intr_tniu_sys_interrupt_tniu_aync_sys_side tniu_sys (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.tniu_tgt_id(tniu0_sys_tniu_tgt_id_porting_tniu_tgt_id),
		.v_interrupt(tniu0_sys_v_interrupt_porting_v_interrupt),
		.v_merge_interrupt(tniu0_sys_v_merge_interrupt_porting_v_merge_interrupt),
		.p_addr(tniu0_sys_apb_porting_p_addr),
		.p_sel(tniu0_sys_apb_porting_p_sel),
		.p_enable(tniu0_sys_apb_porting_p_enable),
		.p_write(tniu0_sys_apb_porting_p_write),
		.p_wdata(tniu0_sys_apb_porting_p_wdata),
		.p_ready(tniu0_sys_apb_porting_p_ready),
		.p_rdata(tniu0_sys_apb_porting_p_rdata),
		.p_slverr(tniu0_sys_apb_porting_p_slverr),
		.wptr_async(tniu_top_TO_tniu_sys_SIG_wptr_async),
		.rptr_async(tniu_sys_TO_tniu_top_SIG_rptr_async),
		.rptr_sync(tniu_sys_TO_tniu_top_SIG_rptr_sync),
		.pld_sync(tniu_top_TO_tniu_sys_SIG_pld_sync),
		.timeout_val(tniu0_sys_timeout_val_porting_timeout_val),
		.m_async_master_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_async_master_hub_tx_req),
		.m_niu_lp_hub_rx_req(tniu_sys_TO_tniu_top_SIG_m_niu_lp_hub_rx_req),
		.m_niu_lp_hub_tx_req(tniu_top_TO_tniu_sys_SIG_s_niu_lp_hub_tx_req));
	tniu0_ring ring_wrap (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.pring_in_if_cw_in_last(pring_in_if_pring_in_if_cw_in_last),
		.pring_in_if_cw_in_payload(pring_in_if_pring_in_if_cw_in_payload),
		.pring_in_if_cw_in_qos(pring_in_if_pring_in_if_cw_in_qos),
		.pring_in_if_cw_in_ready(pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_cw_in_srcid(pring_in_if_pring_in_if_cw_in_srcid),
		.pring_in_if_cw_in_tgtid(pring_in_if_pring_in_if_cw_in_tgtid),
		.pring_in_if_cw_in_valid(pring_in_if_pring_in_if_cw_in_valid),
		.pring_out_if_m_last(pring_out_if_pring_out_if_m_last),
		.pring_out_if_m_payload(pring_out_if_pring_out_if_m_payload),
		.pring_out_if_m_qos(pring_out_if_pring_out_if_m_qos),
		.pring_out_if_m_ready(pring_out_if_pring_out_if_m_ready),
		.pring_out_if_m_srcid(pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_m_tgtid(pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_m_valid(pring_out_if_pring_out_if_m_valid),
		.nring_in_if_ccw_in_last(nring_in_if_nring_in_if_ccw_in_last),
		.nring_in_if_ccw_in_payload(nring_in_if_nring_in_if_ccw_in_payload),
		.nring_in_if_ccw_in_qos(nring_in_if_nring_in_if_ccw_in_qos),
		.nring_in_if_ccw_in_ready(nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_ccw_in_srcid(nring_in_if_nring_in_if_ccw_in_srcid),
		.nring_in_if_ccw_in_tgtid(nring_in_if_nring_in_if_ccw_in_tgtid),
		.nring_in_if_ccw_in_valid(nring_in_if_nring_in_if_ccw_in_valid),
		.nring_out_if_m_last(nring_out_if_nring_out_if_m_last),
		.nring_out_if_m_payload(nring_out_if_nring_out_if_m_payload),
		.nring_out_if_m_qos(nring_out_if_nring_out_if_m_qos),
		.nring_out_if_m_ready(nring_out_if_nring_out_if_m_ready),
		.nring_out_if_m_srcid(nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_m_tgtid(nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_m_valid(nring_out_if_nring_out_if_m_valid),
		.local_tx_local_tx_last(tniu0_ring_local_tx_porting_local_tx_local_tx_last),
		.local_tx_local_tx_payload(tniu0_ring_local_tx_porting_local_tx_local_tx_payload),
		.local_tx_local_tx_qos(tniu0_ring_local_tx_porting_local_tx_local_tx_qos),
		.local_tx_local_tx_ready(tniu0_ring_local_tx_porting_local_tx_local_tx_ready),
		.local_tx_local_tx_srcid(tniu0_ring_local_tx_porting_local_tx_local_tx_srcid),
		.local_tx_local_tx_tgtid(tniu0_ring_local_tx_porting_local_tx_local_tx_tgtid),
		.local_tx_local_tx_valid(tniu0_ring_local_tx_porting_local_tx_local_tx_valid),
		.local_rx_local_rx_last(ring_wrap_TO_tniu_top_SIG_req_last),
		.local_rx_local_rx_payload(ring_wrap_TO_tniu_top_SIG_req_payload),
		.local_rx_local_rx_qos(ring_wrap_TO_tniu_top_SIG_req_qos),
		.local_rx_local_rx_ready(tniu_top_TO_ring_wrap_SIG_req_ready),
		.local_rx_local_rx_srcid(ring_wrap_TO_tniu_top_SIG_req_srcid),
		.local_rx_local_rx_tgtid(ring_wrap_TO_tniu_top_SIG_req_tgtid),
		.local_rx_local_rx_valid(ring_wrap_TO_tniu_top_SIG_req_valid));

endmodule
//[UHDL]Content End [md5:3f372aae8c2eadf26bb9c2fdbb6cf158]


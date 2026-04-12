//[UHDL]Content Start [md5:1760e9baef3a313a30ccf0d65c8f2abd]
module iniu2 (
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
	input  [4095:0] iniu2_sys_v_interrupt_porting_v_interrupt            ,
	input  [7:0]    iniu2_sys_iniu_src_id_porting_iniu_src_id            ,
	input  [31:0]   iniu2_sys_apb_porting_p_addr                         ,
	input           iniu2_sys_apb_porting_p_enable                       ,
	output [31:0]   iniu2_sys_apb_porting_p_rdata                        ,
	output          iniu2_sys_apb_porting_p_ready                        ,
	input           iniu2_sys_apb_porting_p_sel                          ,
	output          iniu2_sys_apb_porting_p_slverr                       ,
	input  [31:0]   iniu2_sys_apb_porting_p_wdata                        ,
	input           iniu2_sys_apb_porting_p_write                        ,
	input  [9:0]    iniu2_sys_timeout_val_porting_timeout_val            ,
	input  [8:0]           iniu2_sys_lp_hub_porting_lp_hub_rx_req               ,
	output [8:0]          iniu2_sys_lp_hub_porting_lp_hub_tx_req               ,
	output          iniu2_ring_local_rx_porting_local_rx_local_rx_last   ,
	output [39:0]   iniu2_ring_local_rx_porting_local_rx_local_rx_payload,
	output [3:0]    iniu2_ring_local_rx_porting_local_rx_local_rx_qos    ,
	input           iniu2_ring_local_rx_porting_local_rx_local_rx_ready  ,
	output [7:0]    iniu2_ring_local_rx_porting_local_rx_local_rx_srcid  ,
	output [7:0]    iniu2_ring_local_rx_porting_local_rx_local_rx_tgtid  ,
	output          iniu2_ring_local_rx_porting_local_rx_local_rx_valid  );

	//Wire define for this module.

	//Wire define for sub module.
	wire [15:0] iniu_top_TO_iniu_sys_SIG_rptr_async               ;
	wire [15:0] iniu_top_TO_iniu_sys_SIG_rptr_sync                ;
	wire [8:0] iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req  ;
	wire [15:0] iniu_sys_TO_iniu_top_SIG_wptr_async               ;
	wire [61:0] iniu_sys_TO_iniu_top_SIG_pld_sync                 ;
	wire [8:0] iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req  ;

	wire        iniu_top_TO_ring_wrap_SIG_req_valid     ;
	wire [39:0] iniu_top_TO_ring_wrap_SIG_req_payload   ;
	wire [7:0]  iniu_top_TO_ring_wrap_SIG_req_srcid     ;
	wire [7:0]  iniu_top_TO_ring_wrap_SIG_req_tgtid     ;
	wire [3:0]  iniu_top_TO_ring_wrap_SIG_req_qos       ;
	wire        iniu_top_TO_ring_wrap_SIG_req_last      ;
	wire        ring_wrap_TO_iniu_top_SIG_req_ready     ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	intr_iniu_sys_interrupt_iniu_aync_sys_side iniu_sys (
		.clk(clk_sys_clk),
		.rst_n(rst_sys_n_rst_n),
		.v_interrupt(iniu2_sys_v_interrupt_porting_v_interrupt),
		.iniu_src_id(iniu2_sys_iniu_src_id_porting_iniu_src_id),
		.p_addr(iniu2_sys_apb_porting_p_addr),
		.p_sel(iniu2_sys_apb_porting_p_sel),
		.p_enable(iniu2_sys_apb_porting_p_enable),
		.p_write(iniu2_sys_apb_porting_p_write),
		.p_wdata(iniu2_sys_apb_porting_p_wdata),
		.p_ready(iniu2_sys_apb_porting_p_ready),
		.p_rdata(iniu2_sys_apb_porting_p_rdata),
		.p_slverr(iniu2_sys_apb_porting_p_slverr),
		.wptr_async(iniu_sys_TO_iniu_top_SIG_wptr_async),
		.rptr_async(iniu_top_TO_iniu_sys_SIG_rptr_async),
		.rptr_sync(iniu_top_TO_iniu_sys_SIG_rptr_sync),
		.pld_sync(iniu_sys_TO_iniu_top_SIG_pld_sync),
		.timeout_val(iniu2_sys_timeout_val_porting_timeout_val),
		.s_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),
		.s_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),
		.lp_hub_rx_req(iniu2_sys_lp_hub_porting_lp_hub_rx_req),
		.lp_hub_tx_req(iniu2_sys_lp_hub_porting_lp_hub_tx_req));
	intr_iniu_top_interrupt_iniu_aync_top_side iniu_top (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.wptr_async(iniu_sys_TO_iniu_top_SIG_wptr_async),
		.rptr_async(iniu_top_TO_iniu_sys_SIG_rptr_async),
		.rptr_sync(iniu_top_TO_iniu_sys_SIG_rptr_sync),
		.pld_sync(iniu_sys_TO_iniu_top_SIG_pld_sync),
		.m_async_master_hub_rx_req(iniu_top_TO_iniu_sys_SIG_m_async_master_hub_rx_req),
		.m_async_master_hub_tx_req(iniu_sys_TO_iniu_top_SIG_s_async_master_hub_tx_req),
		.req_valid(iniu_top_TO_ring_wrap_SIG_req_valid),
		.req_ready(ring_wrap_TO_iniu_top_SIG_req_ready),
		.req_payload(iniu_top_TO_ring_wrap_SIG_req_payload),
		.req_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),
		.req_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),
		.req_qos(iniu_top_TO_ring_wrap_SIG_req_qos),
		.req_last(iniu_top_TO_ring_wrap_SIG_req_last),
		.req_threshold());
	iniu2_ring ring_wrap (
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
		.local_tx_local_tx_last(iniu_top_TO_ring_wrap_SIG_req_last),
		.local_tx_local_tx_payload(iniu_top_TO_ring_wrap_SIG_req_payload),
		.local_tx_local_tx_qos(iniu_top_TO_ring_wrap_SIG_req_qos),
		.local_tx_local_tx_ready(ring_wrap_TO_iniu_top_SIG_req_ready),
		.local_tx_local_tx_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),
		.local_tx_local_tx_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),
		.local_tx_local_tx_valid(iniu_top_TO_ring_wrap_SIG_req_valid),
		.local_rx_local_rx_last(iniu2_ring_local_rx_porting_local_rx_local_rx_last),
		.local_rx_local_rx_payload(iniu2_ring_local_rx_porting_local_rx_local_rx_payload),
		.local_rx_local_rx_qos(iniu2_ring_local_rx_porting_local_rx_local_rx_qos),
		.local_rx_local_rx_ready(iniu2_ring_local_rx_porting_local_rx_local_rx_ready),
		.local_rx_local_rx_srcid(iniu2_ring_local_rx_porting_local_rx_local_rx_srcid),
		.local_rx_local_rx_tgtid(iniu2_ring_local_rx_porting_local_rx_local_rx_tgtid),
		.local_rx_local_rx_valid(iniu2_ring_local_rx_porting_local_rx_local_rx_valid));

endmodule
//[UHDL]Content End [md5:1760e9baef3a313a30ccf0d65c8f2abd]


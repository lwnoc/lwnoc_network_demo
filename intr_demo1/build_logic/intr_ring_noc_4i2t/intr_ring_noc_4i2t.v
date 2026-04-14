//[UHDL]Content Start [md5:2c5253d5f246a4bb126106f8ed145bfb]
module intr_ring_noc_4i2t (
	input           iniu0_clk_sys_porting_clk_sys_clk                                  ,
	input           iniu0_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           iniu0_clk_noc_porting                                              ,
	input           iniu0_rst_noc_n_porting                                            ,
	input  [4095:0] iniu0_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	input  [7:0]    iniu0_iniu_src_id_porting_iniu_src_id_iniu_src_id                  ,
	input  [31:0]   iniu0_apb_porting_apb_p_addr                                       ,
	input           iniu0_apb_porting_apb_p_enable                                     ,
	output [31:0]   iniu0_apb_porting_apb_p_rdata                                      ,
	output          iniu0_apb_porting_apb_p_ready                                      ,
	input           iniu0_apb_porting_apb_p_sel                                        ,
	output          iniu0_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   iniu0_apb_porting_apb_p_wdata                                      ,
	input           iniu0_apb_porting_apb_p_write                                      ,
	input  [9:0]    iniu0_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    iniu0_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    iniu0_lp_hub_porting_lp_hub_lp_hub_tx_req                          ,
	input           iniu1_clk_sys_porting_clk_sys_clk                                  ,
	input           iniu1_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           iniu1_clk_noc_porting                                              ,
	input           iniu1_rst_noc_n_porting                                            ,
	input  [4095:0] iniu1_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	input  [7:0]    iniu1_iniu_src_id_porting_iniu_src_id_iniu_src_id                  ,
	input  [31:0]   iniu1_apb_porting_apb_p_addr                                       ,
	input           iniu1_apb_porting_apb_p_enable                                     ,
	output [31:0]   iniu1_apb_porting_apb_p_rdata                                      ,
	output          iniu1_apb_porting_apb_p_ready                                      ,
	input           iniu1_apb_porting_apb_p_sel                                        ,
	output          iniu1_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   iniu1_apb_porting_apb_p_wdata                                      ,
	input           iniu1_apb_porting_apb_p_write                                      ,
	input  [9:0]    iniu1_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    iniu1_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    iniu1_lp_hub_porting_lp_hub_lp_hub_tx_req                          ,
	input           iniu2_clk_sys_porting_clk_sys_clk                                  ,
	input           iniu2_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           iniu2_clk_noc_porting                                              ,
	input           iniu2_rst_noc_n_porting                                            ,
	input  [4095:0] iniu2_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	input  [7:0]    iniu2_iniu_src_id_porting_iniu_src_id_iniu_src_id                  ,
	input  [31:0]   iniu2_apb_porting_apb_p_addr                                       ,
	input           iniu2_apb_porting_apb_p_enable                                     ,
	output [31:0]   iniu2_apb_porting_apb_p_rdata                                      ,
	output          iniu2_apb_porting_apb_p_ready                                      ,
	input           iniu2_apb_porting_apb_p_sel                                        ,
	output          iniu2_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   iniu2_apb_porting_apb_p_wdata                                      ,
	input           iniu2_apb_porting_apb_p_write                                      ,
	input  [9:0]    iniu2_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    iniu2_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    iniu2_lp_hub_porting_lp_hub_lp_hub_tx_req                          ,
	input           iniu3_clk_sys_porting_clk_sys_clk                                  ,
	input           iniu3_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           iniu3_clk_noc_porting                                              ,
	input           iniu3_rst_noc_n_porting                                            ,
	input  [4095:0] iniu3_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	input  [7:0]    iniu3_iniu_src_id_porting_iniu_src_id_iniu_src_id                  ,
	input  [31:0]   iniu3_apb_porting_apb_p_addr                                       ,
	input           iniu3_apb_porting_apb_p_enable                                     ,
	output [31:0]   iniu3_apb_porting_apb_p_rdata                                      ,
	output          iniu3_apb_porting_apb_p_ready                                      ,
	input           iniu3_apb_porting_apb_p_sel                                        ,
	output          iniu3_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   iniu3_apb_porting_apb_p_wdata                                      ,
	input           iniu3_apb_porting_apb_p_write                                      ,
	input  [9:0]    iniu3_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    iniu3_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    iniu3_lp_hub_porting_lp_hub_lp_hub_tx_req                          ,
	input           tniu0_clk_sys_porting_clk_sys_clk                                  ,
	input           tniu0_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           tniu0_clk_noc_porting                                              ,
	input           tniu0_rst_noc_n_porting                                            ,
	input  [7:0]    tniu0_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id                  ,
	output [4095:0] tniu0_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	output [127:0]  tniu0_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt,
	input  [31:0]   tniu0_apb_porting_apb_p_addr                                       ,
	input           tniu0_apb_porting_apb_p_enable                                     ,
	output [31:0]   tniu0_apb_porting_apb_p_rdata                                      ,
	output          tniu0_apb_porting_apb_p_ready                                      ,
	input           tniu0_apb_porting_apb_p_sel                                        ,
	output          tniu0_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   tniu0_apb_porting_apb_p_wdata                                      ,
	input           tniu0_apb_porting_apb_p_write                                      ,
	input  [9:0]    tniu0_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    tniu0_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    tniu0_lp_hub_porting_lp_hub_lp_hub_tx_req                          ,
	input           tniu1_clk_sys_porting_clk_sys_clk                                  ,
	input           tniu1_rst_sys_n_porting_rst_sys_n_rst_n                            ,
	input           tniu1_clk_noc_porting                                              ,
	input           tniu1_rst_noc_n_porting                                            ,
	input  [7:0]    tniu1_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id                  ,
	output [4095:0] tniu1_v_interrupt_porting_v_interrupt_v_interrupt                  ,
	output [127:0]  tniu1_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt,
	input  [31:0]   tniu1_apb_porting_apb_p_addr                                       ,
	input           tniu1_apb_porting_apb_p_enable                                     ,
	output [31:0]   tniu1_apb_porting_apb_p_rdata                                      ,
	output          tniu1_apb_porting_apb_p_ready                                      ,
	input           tniu1_apb_porting_apb_p_sel                                        ,
	output          tniu1_apb_porting_apb_p_slverr                                     ,
	input  [31:0]   tniu1_apb_porting_apb_p_wdata                                      ,
	input           tniu1_apb_porting_apb_p_write                                      ,
	input  [9:0]    tniu1_timeout_val_porting_timeout_val_timeout_val                  ,
	input  [8:0]    tniu1_lp_hub_porting_lp_hub_lp_hub_rx_req                          ,
	output [8:0]    tniu1_lp_hub_porting_lp_hub_lp_hub_tx_req                          );

	//Wire define for this module.

	//Wire define for sub module.
	wire        tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        iniu1_TO_iniu0_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        tniu1_TO_iniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        iniu2_TO_iniu1_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        iniu0_TO_iniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        iniu3_TO_iniu2_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        iniu1_TO_iniu2_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        tniu0_TO_iniu3_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        iniu2_TO_iniu3_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        tniu1_TO_tniu0_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        iniu3_TO_tniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready;
	wire        tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_last    ;
	wire [39:0] tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_payload ;
	wire [3:0]  tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_qos     ;
	wire [7:0]  tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_srcid   ;
	wire [7:0]  tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_tgtid   ;
	wire        tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_valid   ;
	wire        iniu0_TO_tniu1_SIG_pring_in_if_pring_in_if_cw_in_ready ;
	wire        iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_last    ;
	wire [39:0] iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_payload ;
	wire [3:0]  iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_qos     ;
	wire [7:0]  iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_srcid   ;
	wire [7:0]  iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_tgtid   ;
	wire        iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_valid   ;
	wire        tniu0_TO_tniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	iniu0 iniu0 (
		.clk_sys_clk(iniu0_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(iniu0_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(iniu0_clk_noc_porting),
		.rst_noc_n(iniu0_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(iniu0_TO_tniu1_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(iniu1_TO_iniu0_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(iniu0_TO_iniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(tniu1_TO_iniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_valid),
		.v_interrupt_v_interrupt(iniu0_v_interrupt_porting_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id(iniu0_iniu_src_id_porting_iniu_src_id_iniu_src_id),
		.apb_p_addr(iniu0_apb_porting_apb_p_addr),
		.apb_p_enable(iniu0_apb_porting_apb_p_enable),
		.apb_p_rdata(iniu0_apb_porting_apb_p_rdata),
		.apb_p_ready(iniu0_apb_porting_apb_p_ready),
		.apb_p_sel(iniu0_apb_porting_apb_p_sel),
		.apb_p_slverr(iniu0_apb_porting_apb_p_slverr),
		.apb_p_wdata(iniu0_apb_porting_apb_p_wdata),
		.apb_p_write(iniu0_apb_porting_apb_p_write),
		.timeout_val_timeout_val(iniu0_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(iniu0_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(iniu0_lp_hub_porting_lp_hub_lp_hub_tx_req));
	iniu1 iniu1 (
		.clk_sys_clk(iniu1_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(iniu1_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(iniu1_clk_noc_porting),
		.rst_noc_n(iniu1_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(iniu1_TO_iniu0_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(iniu0_TO_iniu1_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(iniu2_TO_iniu1_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(iniu1_TO_iniu2_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(iniu0_TO_iniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(iniu1_TO_iniu0_SIG_nring_out_if_nring_out_if_m_valid),
		.v_interrupt_v_interrupt(iniu1_v_interrupt_porting_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id(iniu1_iniu_src_id_porting_iniu_src_id_iniu_src_id),
		.apb_p_addr(iniu1_apb_porting_apb_p_addr),
		.apb_p_enable(iniu1_apb_porting_apb_p_enable),
		.apb_p_rdata(iniu1_apb_porting_apb_p_rdata),
		.apb_p_ready(iniu1_apb_porting_apb_p_ready),
		.apb_p_sel(iniu1_apb_porting_apb_p_sel),
		.apb_p_slverr(iniu1_apb_porting_apb_p_slverr),
		.apb_p_wdata(iniu1_apb_porting_apb_p_wdata),
		.apb_p_write(iniu1_apb_porting_apb_p_write),
		.timeout_val_timeout_val(iniu1_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(iniu1_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(iniu1_lp_hub_porting_lp_hub_lp_hub_tx_req));
	iniu2 iniu2 (
		.clk_sys_clk(iniu2_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(iniu2_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(iniu2_clk_noc_porting),
		.rst_noc_n(iniu2_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(iniu2_TO_iniu1_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(iniu1_TO_iniu2_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(iniu3_TO_iniu2_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(iniu2_TO_iniu3_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(iniu1_TO_iniu2_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(iniu2_TO_iniu1_SIG_nring_out_if_nring_out_if_m_valid),
		.v_interrupt_v_interrupt(iniu2_v_interrupt_porting_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id(iniu2_iniu_src_id_porting_iniu_src_id_iniu_src_id),
		.apb_p_addr(iniu2_apb_porting_apb_p_addr),
		.apb_p_enable(iniu2_apb_porting_apb_p_enable),
		.apb_p_rdata(iniu2_apb_porting_apb_p_rdata),
		.apb_p_ready(iniu2_apb_porting_apb_p_ready),
		.apb_p_sel(iniu2_apb_porting_apb_p_sel),
		.apb_p_slverr(iniu2_apb_porting_apb_p_slverr),
		.apb_p_wdata(iniu2_apb_porting_apb_p_wdata),
		.apb_p_write(iniu2_apb_porting_apb_p_write),
		.timeout_val_timeout_val(iniu2_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(iniu2_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(iniu2_lp_hub_porting_lp_hub_lp_hub_tx_req));
	iniu3 iniu3 (
		.clk_sys_clk(iniu3_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(iniu3_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(iniu3_clk_noc_porting),
		.rst_noc_n(iniu3_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(iniu3_TO_iniu2_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(iniu2_TO_iniu3_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(tniu0_TO_iniu3_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(iniu3_TO_tniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(iniu2_TO_iniu3_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(iniu3_TO_iniu2_SIG_nring_out_if_nring_out_if_m_valid),
		.v_interrupt_v_interrupt(iniu3_v_interrupt_porting_v_interrupt_v_interrupt),
		.iniu_src_id_iniu_src_id(iniu3_iniu_src_id_porting_iniu_src_id_iniu_src_id),
		.apb_p_addr(iniu3_apb_porting_apb_p_addr),
		.apb_p_enable(iniu3_apb_porting_apb_p_enable),
		.apb_p_rdata(iniu3_apb_porting_apb_p_rdata),
		.apb_p_ready(iniu3_apb_porting_apb_p_ready),
		.apb_p_sel(iniu3_apb_porting_apb_p_sel),
		.apb_p_slverr(iniu3_apb_porting_apb_p_slverr),
		.apb_p_wdata(iniu3_apb_porting_apb_p_wdata),
		.apb_p_write(iniu3_apb_porting_apb_p_write),
		.timeout_val_timeout_val(iniu3_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(iniu3_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(iniu3_lp_hub_porting_lp_hub_lp_hub_tx_req));
	tniu0 tniu0 (
		.clk_sys_clk(tniu0_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(tniu0_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(tniu0_clk_noc_porting),
		.rst_noc_n(tniu0_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(tniu0_TO_iniu3_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(iniu3_TO_tniu0_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(tniu1_TO_tniu0_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(tniu0_TO_tniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(iniu3_TO_tniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(tniu0_TO_iniu3_SIG_nring_out_if_nring_out_if_m_valid),
		.tniu_tgt_id_tniu_tgt_id(tniu0_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt(tniu0_v_interrupt_porting_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt(tniu0_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt),
		.apb_p_addr(tniu0_apb_porting_apb_p_addr),
		.apb_p_enable(tniu0_apb_porting_apb_p_enable),
		.apb_p_rdata(tniu0_apb_porting_apb_p_rdata),
		.apb_p_ready(tniu0_apb_porting_apb_p_ready),
		.apb_p_sel(tniu0_apb_porting_apb_p_sel),
		.apb_p_slverr(tniu0_apb_porting_apb_p_slverr),
		.apb_p_wdata(tniu0_apb_porting_apb_p_wdata),
		.apb_p_write(tniu0_apb_porting_apb_p_write),
		.timeout_val_timeout_val(tniu0_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(tniu0_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(tniu0_lp_hub_porting_lp_hub_lp_hub_tx_req));
	tniu1 tniu1 (
		.clk_sys_clk(tniu1_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(tniu1_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_noc(tniu1_clk_noc_porting),
		.rst_noc_n(tniu1_rst_noc_n_porting),
		.pring_in_if_pring_in_if_cw_in_last(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_last),
		.pring_in_if_pring_in_if_cw_in_payload(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_in_if_pring_in_if_cw_in_qos(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_in_if_pring_in_if_cw_in_ready(tniu1_TO_tniu0_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_in_if_pring_in_if_cw_in_srcid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_in_if_pring_in_if_cw_in_tgtid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_in_if_pring_in_if_cw_in_valid(tniu0_TO_tniu1_SIG_pring_out_if_pring_out_if_m_valid),
		.pring_out_if_pring_out_if_m_last(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_last),
		.pring_out_if_pring_out_if_m_payload(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_payload),
		.pring_out_if_pring_out_if_m_qos(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_qos),
		.pring_out_if_pring_out_if_m_ready(iniu0_TO_tniu1_SIG_pring_in_if_pring_in_if_cw_in_ready),
		.pring_out_if_pring_out_if_m_srcid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_srcid),
		.pring_out_if_pring_out_if_m_tgtid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_tgtid),
		.pring_out_if_pring_out_if_m_valid(tniu1_TO_iniu0_SIG_pring_out_if_pring_out_if_m_valid),
		.nring_in_if_nring_in_if_ccw_in_last(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_last),
		.nring_in_if_nring_in_if_ccw_in_payload(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_in_if_nring_in_if_ccw_in_qos(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_in_if_nring_in_if_ccw_in_ready(tniu1_TO_iniu0_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_in_if_nring_in_if_ccw_in_srcid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_in_if_nring_in_if_ccw_in_tgtid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_in_if_nring_in_if_ccw_in_valid(iniu0_TO_tniu1_SIG_nring_out_if_nring_out_if_m_valid),
		.nring_out_if_nring_out_if_m_last(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_last),
		.nring_out_if_nring_out_if_m_payload(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_payload),
		.nring_out_if_nring_out_if_m_qos(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_qos),
		.nring_out_if_nring_out_if_m_ready(tniu0_TO_tniu1_SIG_nring_in_if_nring_in_if_ccw_in_ready),
		.nring_out_if_nring_out_if_m_srcid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_srcid),
		.nring_out_if_nring_out_if_m_tgtid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_tgtid),
		.nring_out_if_nring_out_if_m_valid(tniu1_TO_tniu0_SIG_nring_out_if_nring_out_if_m_valid),
		.tniu_tgt_id_tniu_tgt_id(tniu1_tniu_tgt_id_porting_tniu_tgt_id_tniu_tgt_id),
		.v_interrupt_v_interrupt(tniu1_v_interrupt_porting_v_interrupt_v_interrupt),
		.v_merge_interrupt_v_merge_interrupt(tniu1_v_merge_interrupt_porting_v_merge_interrupt_v_merge_interrupt),
		.apb_p_addr(tniu1_apb_porting_apb_p_addr),
		.apb_p_enable(tniu1_apb_porting_apb_p_enable),
		.apb_p_rdata(tniu1_apb_porting_apb_p_rdata),
		.apb_p_ready(tniu1_apb_porting_apb_p_ready),
		.apb_p_sel(tniu1_apb_porting_apb_p_sel),
		.apb_p_slverr(tniu1_apb_porting_apb_p_slverr),
		.apb_p_wdata(tniu1_apb_porting_apb_p_wdata),
		.apb_p_write(tniu1_apb_porting_apb_p_write),
		.timeout_val_timeout_val(tniu1_timeout_val_porting_timeout_val_timeout_val),
		.lp_hub_lp_hub_rx_req(tniu1_lp_hub_porting_lp_hub_lp_hub_rx_req),
		.lp_hub_lp_hub_tx_req(tniu1_lp_hub_porting_lp_hub_lp_hub_tx_req));

endmodule
//[UHDL]Content End [md5:2c5253d5f246a4bb126106f8ed145bfb]


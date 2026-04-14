//[UHDL]Content Start [md5:ba8eefee6ce434e4f5ee149ac824c876]
module dti_logic_topo (
	input         clk                           ,
	input         rst_n                         ,
	input         pcie_eth_req_iniu0_req_last   ,
	input  [89:0] pcie_eth_req_iniu0_req_payload,
	output        pcie_eth_req_iniu0_req_ready  ,
	input  [5:0]  pcie_eth_req_iniu0_req_srcid  ,
	input         pcie_eth_req_iniu0_req_valid  ,
	output        pcie_eth_rsp_iniu0_rsp_last   ,
	output [89:0] pcie_eth_rsp_iniu0_rsp_payload,
	input         pcie_eth_rsp_iniu0_rsp_ready  ,
	output [5:0]  pcie_eth_rsp_iniu0_rsp_srcid  ,
	output        pcie_eth_rsp_iniu0_rsp_valid  ,
	input         vpu_req_iniu1_req_last        ,
	input  [89:0] vpu_req_iniu1_req_payload     ,
	output        vpu_req_iniu1_req_ready       ,
	input  [5:0]  vpu_req_iniu1_req_srcid       ,
	input         vpu_req_iniu1_req_valid       ,
	output        vpu_rsp_iniu1_rsp_last        ,
	output [89:0] vpu_rsp_iniu1_rsp_payload     ,
	input         vpu_rsp_iniu1_rsp_ready       ,
	output [5:0]  vpu_rsp_iniu1_rsp_srcid       ,
	output        vpu_rsp_iniu1_rsp_valid       ,
	input         dsp2_req_iniu2_req_last       ,
	input  [89:0] dsp2_req_iniu2_req_payload    ,
	output        dsp2_req_iniu2_req_ready      ,
	input  [5:0]  dsp2_req_iniu2_req_srcid      ,
	input         dsp2_req_iniu2_req_valid      ,
	output        dsp2_rsp_iniu2_rsp_last       ,
	output [89:0] dsp2_rsp_iniu2_rsp_payload    ,
	input         dsp2_rsp_iniu2_rsp_ready      ,
	output [5:0]  dsp2_rsp_iniu2_rsp_srcid      ,
	output        dsp2_rsp_iniu2_rsp_valid      ,
	input         dsp1_req_iniu1_req_last       ,
	input  [89:0] dsp1_req_iniu1_req_payload    ,
	output        dsp1_req_iniu1_req_ready      ,
	input  [5:0]  dsp1_req_iniu1_req_srcid      ,
	input         dsp1_req_iniu1_req_valid      ,
	output        dsp1_rsp_iniu1_rsp_last       ,
	output [89:0] dsp1_rsp_iniu1_rsp_payload    ,
	input         dsp1_rsp_iniu1_rsp_ready      ,
	output [5:0]  dsp1_rsp_iniu1_rsp_srcid      ,
	output        dsp1_rsp_iniu1_rsp_valid      ,
	input         dsp0_req_iniu1_req_last       ,
	input  [89:0] dsp0_req_iniu1_req_payload    ,
	output        dsp0_req_iniu1_req_ready      ,
	input  [5:0]  dsp0_req_iniu1_req_srcid      ,
	input         dsp0_req_iniu1_req_valid      ,
	output        dsp0_rsp_iniu1_rsp_last       ,
	output [89:0] dsp0_rsp_iniu1_rsp_payload    ,
	input         dsp0_rsp_iniu1_rsp_ready      ,
	output [5:0]  dsp0_rsp_iniu1_rsp_srcid      ,
	output        dsp0_rsp_iniu1_rsp_valid      ,
	input         noc_tbu1_req_iniu1_req_last   ,
	input  [89:0] noc_tbu1_req_iniu1_req_payload,
	output        noc_tbu1_req_iniu1_req_ready  ,
	input  [5:0]  noc_tbu1_req_iniu1_req_srcid  ,
	input         noc_tbu1_req_iniu1_req_valid  ,
	output        noc_tbu1_rsp_iniu1_rsp_last   ,
	output [89:0] noc_tbu1_rsp_iniu1_rsp_payload,
	input         noc_tbu1_rsp_iniu1_rsp_ready  ,
	output [5:0]  noc_tbu1_rsp_iniu1_rsp_srcid  ,
	output        noc_tbu1_rsp_iniu1_rsp_valid  ,
	input         usb_ufs_req_iniu0_req_last    ,
	input  [89:0] usb_ufs_req_iniu0_req_payload ,
	output        usb_ufs_req_iniu0_req_ready   ,
	input  [5:0]  usb_ufs_req_iniu0_req_srcid   ,
	input         usb_ufs_req_iniu0_req_valid   ,
	output        usb_ufs_rsp_iniu0_rsp_last    ,
	output [89:0] usb_ufs_rsp_iniu0_rsp_payload ,
	input         usb_ufs_rsp_iniu0_rsp_ready   ,
	output [5:0]  usb_ufs_rsp_iniu0_rsp_srcid   ,
	output        usb_ufs_rsp_iniu0_rsp_valid   ,
	input         mipi0_req_iniu1_req_last      ,
	input  [89:0] mipi0_req_iniu1_req_payload   ,
	output        mipi0_req_iniu1_req_ready     ,
	input  [5:0]  mipi0_req_iniu1_req_srcid     ,
	input         mipi0_req_iniu1_req_valid     ,
	output        mipi0_rsp_iniu1_rsp_last      ,
	output [89:0] mipi0_rsp_iniu1_rsp_payload   ,
	input         mipi0_rsp_iniu1_rsp_ready     ,
	output [5:0]  mipi0_rsp_iniu1_rsp_srcid     ,
	output        mipi0_rsp_iniu1_rsp_valid     ,
	input         mipi1_req_iniu2_req_last      ,
	input  [89:0] mipi1_req_iniu2_req_payload   ,
	output        mipi1_req_iniu2_req_ready     ,
	input  [5:0]  mipi1_req_iniu2_req_srcid     ,
	input         mipi1_req_iniu2_req_valid     ,
	output        mipi1_rsp_iniu2_rsp_last      ,
	output [89:0] mipi1_rsp_iniu2_rsp_payload   ,
	input         mipi1_rsp_iniu2_rsp_ready     ,
	output [5:0]  mipi1_rsp_iniu2_rsp_srcid     ,
	output        mipi1_rsp_iniu2_rsp_valid     ,
	input         camera_req_iniu3_req_last     ,
	input  [89:0] camera_req_iniu3_req_payload  ,
	output        camera_req_iniu3_req_ready    ,
	input  [5:0]  camera_req_iniu3_req_srcid    ,
	input         camera_req_iniu3_req_valid    ,
	output        camera_rsp_iniu3_rsp_last     ,
	output [89:0] camera_rsp_iniu3_rsp_payload  ,
	input         camera_rsp_iniu3_rsp_ready    ,
	output [5:0]  camera_rsp_iniu3_rsp_srcid    ,
	output        camera_rsp_iniu3_rsp_valid    ,
	input         noc_tbu0_req_iniu1_req_last   ,
	input  [89:0] noc_tbu0_req_iniu1_req_payload,
	output        noc_tbu0_req_iniu1_req_ready  ,
	input  [5:0]  noc_tbu0_req_iniu1_req_srcid  ,
	input         noc_tbu0_req_iniu1_req_valid  ,
	output        noc_tbu0_rsp_iniu1_rsp_last   ,
	output [89:0] noc_tbu0_rsp_iniu1_rsp_payload,
	input         noc_tbu0_rsp_iniu1_rsp_ready  ,
	output [5:0]  noc_tbu0_rsp_iniu1_rsp_srcid  ,
	output        noc_tbu0_rsp_iniu1_rsp_valid  ,
	output        top_tcu_req_tniu_req_last     ,
	output [89:0] top_tcu_req_tniu_req_payload  ,
	input         top_tcu_req_tniu_req_ready    ,
	output [5:0]  top_tcu_req_tniu_req_srcid    ,
	output        top_tcu_req_tniu_req_valid    ,
	input         top_tcu_rsp_tniu_rsp_last     ,
	input  [89:0] top_tcu_rsp_tniu_rsp_payload  ,
	output        top_tcu_rsp_tniu_rsp_ready    ,
	input  [5:0]  top_tcu_rsp_tniu_rsp_srcid    ,
	input         top_tcu_rsp_tniu_rsp_valid    );

	//Wire define for this module.

	//Wire define for sub module.
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready      ;
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid      ;
	wire [89:0] sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload    ;
	wire [5:0]  sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid      ;
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last       ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid       ;
	wire [89:0] sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload     ;
	wire [5:0]  sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid       ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last        ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready       ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready  ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid  ;
	wire [89:0] sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload;
	wire [5:0]  sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid  ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last   ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid   ;
	wire [89:0] sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload ;
	wire [5:0]  sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid   ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last    ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready   ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready  ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid  ;
	wire [89:0] sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload;
	wire [5:0]  sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid  ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last   ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid   ;
	wire [89:0] sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload ;
	wire [5:0]  sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid   ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last    ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready   ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready       ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid       ;
	wire [89:0] sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload     ;
	wire [5:0]  sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid       ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last        ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready    ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid    ;
	wire [89:0] sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload  ;
	wire [5:0]  sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid    ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last     ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid     ;
	wire [89:0] sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload   ;
	wire [5:0]  sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid     ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_req_last      ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready     ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready      ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid      ;
	wire [89:0] sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload    ;
	wire [5:0]  sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid      ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last       ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_req_valid        ;
	wire [89:0] sw_left_noc1_TO_sw_root_SIG_tniu_req_payload      ;
	wire [5:0]  sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid        ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_req_last         ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready        ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_req_valid       ;
	wire [89:0] sw_right_noc0_TO_sw_root_SIG_tniu_req_payload     ;
	wire [5:0]  sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid       ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_req_last        ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready       ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_sw_left3_dti_switch_3i1o_wrap sw_left3 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(pcie_eth_req_iniu0_req_valid),
		.iniu0_req_ready(pcie_eth_req_iniu0_req_ready),
		.iniu0_req_payload(pcie_eth_req_iniu0_req_payload),
		.iniu0_req_srcid(pcie_eth_req_iniu0_req_srcid),
		.iniu0_req_last(pcie_eth_req_iniu0_req_last),
		.iniu0_rsp_valid(pcie_eth_rsp_iniu0_rsp_valid),
		.iniu0_rsp_ready(pcie_eth_rsp_iniu0_rsp_ready),
		.iniu0_rsp_payload(pcie_eth_rsp_iniu0_rsp_payload),
		.iniu0_rsp_srcid(pcie_eth_rsp_iniu0_rsp_srcid),
		.iniu0_rsp_last(pcie_eth_rsp_iniu0_rsp_last),
		.iniu1_req_valid(vpu_req_iniu1_req_valid),
		.iniu1_req_ready(vpu_req_iniu1_req_ready),
		.iniu1_req_payload(vpu_req_iniu1_req_payload),
		.iniu1_req_srcid(vpu_req_iniu1_req_srcid),
		.iniu1_req_last(vpu_req_iniu1_req_last),
		.iniu1_rsp_valid(vpu_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(vpu_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(vpu_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(vpu_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(vpu_rsp_iniu1_rsp_last),
		.iniu2_req_valid(dsp2_req_iniu2_req_valid),
		.iniu2_req_ready(dsp2_req_iniu2_req_ready),
		.iniu2_req_payload(dsp2_req_iniu2_req_payload),
		.iniu2_req_srcid(dsp2_req_iniu2_req_srcid),
		.iniu2_req_last(dsp2_req_iniu2_req_last),
		.iniu2_rsp_valid(dsp2_rsp_iniu2_rsp_valid),
		.iniu2_rsp_ready(dsp2_rsp_iniu2_rsp_ready),
		.iniu2_rsp_payload(dsp2_rsp_iniu2_rsp_payload),
		.iniu2_rsp_srcid(dsp2_rsp_iniu2_rsp_srcid),
		.iniu2_rsp_last(dsp2_rsp_iniu2_rsp_last),
		.tniu_req_valid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last));
	dti_sw_left_dsp1_dti_switch_2i1o_wrap sw_left_dsp1 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last),
		.iniu1_req_valid(dsp1_req_iniu1_req_valid),
		.iniu1_req_ready(dsp1_req_iniu1_req_ready),
		.iniu1_req_payload(dsp1_req_iniu1_req_payload),
		.iniu1_req_srcid(dsp1_req_iniu1_req_srcid),
		.iniu1_req_last(dsp1_req_iniu1_req_last),
		.iniu1_rsp_valid(dsp1_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp1_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(dsp1_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(dsp1_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(dsp1_rsp_iniu1_rsp_last),
		.tniu_req_valid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last));
	dti_sw_left_dsp0_dti_switch_2i1o_wrap sw_left_dsp0 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last),
		.iniu1_req_valid(dsp0_req_iniu1_req_valid),
		.iniu1_req_ready(dsp0_req_iniu1_req_ready),
		.iniu1_req_payload(dsp0_req_iniu1_req_payload),
		.iniu1_req_srcid(dsp0_req_iniu1_req_srcid),
		.iniu1_req_last(dsp0_req_iniu1_req_last),
		.iniu1_rsp_valid(dsp0_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp0_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(dsp0_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(dsp0_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(dsp0_rsp_iniu1_rsp_last),
		.tniu_req_valid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last));
	dti_sw_left_noc1_dti_switch_2i1o_wrap sw_left_noc1 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last),
		.iniu1_req_valid(noc_tbu1_req_iniu1_req_valid),
		.iniu1_req_ready(noc_tbu1_req_iniu1_req_ready),
		.iniu1_req_payload(noc_tbu1_req_iniu1_req_payload),
		.iniu1_req_srcid(noc_tbu1_req_iniu1_req_srcid),
		.iniu1_req_last(noc_tbu1_req_iniu1_req_last),
		.iniu1_rsp_valid(noc_tbu1_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(noc_tbu1_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(noc_tbu1_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(noc_tbu1_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(noc_tbu1_rsp_iniu1_rsp_last),
		.tniu_req_valid(sw_left_noc1_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_noc1_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_noc1_TO_sw_root_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last));
	dti_sw_right4_dti_switch_4i1o_wrap sw_right4 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(usb_ufs_req_iniu0_req_valid),
		.iniu0_req_ready(usb_ufs_req_iniu0_req_ready),
		.iniu0_req_payload(usb_ufs_req_iniu0_req_payload),
		.iniu0_req_srcid(usb_ufs_req_iniu0_req_srcid),
		.iniu0_req_last(usb_ufs_req_iniu0_req_last),
		.iniu0_rsp_valid(usb_ufs_rsp_iniu0_rsp_valid),
		.iniu0_rsp_ready(usb_ufs_rsp_iniu0_rsp_ready),
		.iniu0_rsp_payload(usb_ufs_rsp_iniu0_rsp_payload),
		.iniu0_rsp_srcid(usb_ufs_rsp_iniu0_rsp_srcid),
		.iniu0_rsp_last(usb_ufs_rsp_iniu0_rsp_last),
		.iniu1_req_valid(mipi0_req_iniu1_req_valid),
		.iniu1_req_ready(mipi0_req_iniu1_req_ready),
		.iniu1_req_payload(mipi0_req_iniu1_req_payload),
		.iniu1_req_srcid(mipi0_req_iniu1_req_srcid),
		.iniu1_req_last(mipi0_req_iniu1_req_last),
		.iniu1_rsp_valid(mipi0_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(mipi0_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(mipi0_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(mipi0_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(mipi0_rsp_iniu1_rsp_last),
		.iniu2_req_valid(mipi1_req_iniu2_req_valid),
		.iniu2_req_ready(mipi1_req_iniu2_req_ready),
		.iniu2_req_payload(mipi1_req_iniu2_req_payload),
		.iniu2_req_srcid(mipi1_req_iniu2_req_srcid),
		.iniu2_req_last(mipi1_req_iniu2_req_last),
		.iniu2_rsp_valid(mipi1_rsp_iniu2_rsp_valid),
		.iniu2_rsp_ready(mipi1_rsp_iniu2_rsp_ready),
		.iniu2_rsp_payload(mipi1_rsp_iniu2_rsp_payload),
		.iniu2_rsp_srcid(mipi1_rsp_iniu2_rsp_srcid),
		.iniu2_rsp_last(mipi1_rsp_iniu2_rsp_last),
		.iniu3_req_valid(camera_req_iniu3_req_valid),
		.iniu3_req_ready(camera_req_iniu3_req_ready),
		.iniu3_req_payload(camera_req_iniu3_req_payload),
		.iniu3_req_srcid(camera_req_iniu3_req_srcid),
		.iniu3_req_last(camera_req_iniu3_req_last),
		.iniu3_rsp_valid(camera_rsp_iniu3_rsp_valid),
		.iniu3_rsp_ready(camera_rsp_iniu3_rsp_ready),
		.iniu3_rsp_payload(camera_rsp_iniu3_rsp_payload),
		.iniu3_rsp_srcid(camera_rsp_iniu3_rsp_srcid),
		.iniu3_rsp_last(camera_rsp_iniu3_rsp_last),
		.tniu_req_valid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid),
		.tniu_req_ready(sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid),
		.tniu_req_last(sw_right4_TO_sw_right_noc0_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last));
	dti_sw_right_noc0_dti_switch_2i1o_wrap sw_right_noc0 (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_right4_TO_sw_right_noc0_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last),
		.iniu1_req_valid(noc_tbu0_req_iniu1_req_valid),
		.iniu1_req_ready(noc_tbu0_req_iniu1_req_ready),
		.iniu1_req_payload(noc_tbu0_req_iniu1_req_payload),
		.iniu1_req_srcid(noc_tbu0_req_iniu1_req_srcid),
		.iniu1_req_last(noc_tbu0_req_iniu1_req_last),
		.iniu1_rsp_valid(noc_tbu0_rsp_iniu1_rsp_valid),
		.iniu1_rsp_ready(noc_tbu0_rsp_iniu1_rsp_ready),
		.iniu1_rsp_payload(noc_tbu0_rsp_iniu1_rsp_payload),
		.iniu1_rsp_srcid(noc_tbu0_rsp_iniu1_rsp_srcid),
		.iniu1_rsp_last(noc_tbu0_rsp_iniu1_rsp_last),
		.tniu_req_valid(sw_right_noc0_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready),
		.tniu_req_payload(sw_right_noc0_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_last(sw_right_noc0_TO_sw_root_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid),
		.tniu_rsp_last(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last));
	dti_sw_root_dti_switch_2i1o_wrap sw_root (
		.clk(clk),
		.rst_n(rst_n),
		.iniu0_req_valid(sw_left_noc1_TO_sw_root_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_noc1_TO_sw_root_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_noc1_TO_sw_root_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last),
		.iniu1_req_valid(sw_right_noc0_TO_sw_root_SIG_tniu_req_valid),
		.iniu1_req_ready(sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready),
		.iniu1_req_payload(sw_right_noc0_TO_sw_root_SIG_tniu_req_payload),
		.iniu1_req_srcid(sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid),
		.iniu1_req_last(sw_right_noc0_TO_sw_root_SIG_tniu_req_last),
		.iniu1_rsp_valid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu1_rsp_payload(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last),
		.tniu_req_valid(top_tcu_req_tniu_req_valid),
		.tniu_req_ready(top_tcu_req_tniu_req_ready),
		.tniu_req_payload(top_tcu_req_tniu_req_payload),
		.tniu_req_srcid(top_tcu_req_tniu_req_srcid),
		.tniu_req_last(top_tcu_req_tniu_req_last),
		.tniu_rsp_valid(top_tcu_rsp_tniu_rsp_valid),
		.tniu_rsp_ready(top_tcu_rsp_tniu_rsp_ready),
		.tniu_rsp_payload(top_tcu_rsp_tniu_rsp_payload),
		.tniu_rsp_srcid(top_tcu_rsp_tniu_rsp_srcid),
		.tniu_rsp_last(top_tcu_rsp_tniu_rsp_last));

endmodule
//[UHDL]Content End [md5:ba8eefee6ce434e4f5ee149ac824c876]


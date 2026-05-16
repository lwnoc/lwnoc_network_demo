//[UHDL]Content Start [md5:a4edb2ba8843538f983325882bffa8af]
module sts_noc_apb32_to_cti_apb12 (
	input  [31:0] tniu_apb_paddr  ,
	input         tniu_apb_penable,
	input  [2:0]  tniu_apb_pprot  ,
	output [31:0] tniu_apb_prdata ,
	output        tniu_apb_pready ,
	input         tniu_apb_psel   ,
	output        tniu_apb_pslverr,
	input  [3:0]  tniu_apb_pstrb  ,
	input  [31:0] tniu_apb_pwdata ,
	input         tniu_apb_pwrite ,
	output [11:0] cti_apb_paddr   ,
	output        cti_apb_penable ,
	input  [31:0] cti_apb_prdata  ,
	input         cti_apb_pready  ,
	output        cti_apb_psel    ,
	input         cti_apb_pslverr ,
	output [31:0] cti_apb_pwdata  ,
	output        cti_apb_pwrite  );

	assign cti_apb_paddr   = tniu_apb_paddr[11:0];
	assign cti_apb_penable = tniu_apb_penable;
	assign cti_apb_psel    = tniu_apb_psel;
	assign cti_apb_pwdata  = tniu_apb_pwdata;
	assign cti_apb_pwrite  = tniu_apb_pwrite;
	assign tniu_apb_prdata = cti_apb_prdata;
	assign tniu_apb_pready = cti_apb_pready;
	assign tniu_apb_pslverr = cti_apb_pslverr;

endmodule
//[UHDL]Content End [md5:a4edb2ba8843538f983325882bffa8af]

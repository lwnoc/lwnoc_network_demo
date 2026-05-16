//[UHDL]Content Start [md5:fa373811329cf2faa3c1ba31cdd39922]
module sts_noc_apb_idle_target (
	input  [31:0] apb_paddr  ,
	input         apb_penable,
	input  [2:0]  apb_pprot  ,
	output [31:0] apb_prdata ,
	output        apb_pready ,
	input         apb_psel   ,
	output        apb_pslverr,
	input  [3:0]  apb_pstrb  ,
	input  [31:0] apb_pwdata ,
	input         apb_pwrite );

	assign apb_prdata  = 32'h0;
	assign apb_pready  = 1'b1;
	assign apb_pslverr = 1'b0;

endmodule
//[UHDL]Content End [md5:fa373811329cf2faa3c1ba31cdd39922]

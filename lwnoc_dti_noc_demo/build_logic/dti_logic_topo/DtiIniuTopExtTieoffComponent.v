//[UHDL]Content Start [md5:18120b94368d7896840212babe3c5d0f]
module DtiIniuTopExtTieoffComponent (
	input        req_qos      ,
	output       req_threshold,
	input  [5:0] req_tgtid    ,
	output       rsp_qos      ,
	input        rsp_threshold,
	output [5:0] rsp_tgtid    );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign req_threshold = (1'b1 ^ 1'b1);
	
	assign rsp_qos = (1'b1 ^ 1'b1);
	
	assign rsp_tgtid = (6'b111111 ^ 6'b111111);
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:18120b94368d7896840212babe3c5d0f]


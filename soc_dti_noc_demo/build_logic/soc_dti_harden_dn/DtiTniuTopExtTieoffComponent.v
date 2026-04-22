//[UHDL]Content Start [md5:0226b9f39701653c785cc30294dfb049]
module DtiTniuTopExtTieoffComponent (
	output       req_qos      ,
	input        req_threshold,
	output [5:0] req_tgtid    ,
	input        rsp_qos      ,
	output       rsp_threshold,
	input  [5:0] rsp_tgtid    );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign req_qos = (1'b1 ^ 1'b1);
	
	assign req_tgtid = (6'b111111 ^ 6'b111111);
	
	assign rsp_threshold = (1'b1 ^ 1'b1);
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:0226b9f39701653c785cc30294dfb049]


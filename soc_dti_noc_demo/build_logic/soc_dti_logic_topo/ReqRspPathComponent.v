//[UHDL]Content Start [md5:c828467fbee25d3c06a8092e1cab0b98]
module ReqRspPathComponent (
	input         clk          ,
	input         rst_n        ,
	input         s_req_valid  ,
	input  [89:0] s_req_payload,
	input         s_req_last   ,
	input  [5:0]  s_req_srcid  ,
	output        s_req_ready  ,
	output        m_req_valid  ,
	output [89:0] m_req_payload,
	output        m_req_last   ,
	output [5:0]  m_req_srcid  ,
	input         m_req_ready  ,
	input         s_rsp_valid  ,
	input  [89:0] s_rsp_payload,
	input         s_rsp_last   ,
	input  [5:0]  s_rsp_srcid  ,
	output        s_rsp_ready  ,
	output        m_rsp_valid  ,
	output [89:0] m_rsp_payload,
	output        m_rsp_last   ,
	output [5:0]  m_rsp_srcid  ,
	input         m_rsp_ready  );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:c828467fbee25d3c06a8092e1cab0b98]


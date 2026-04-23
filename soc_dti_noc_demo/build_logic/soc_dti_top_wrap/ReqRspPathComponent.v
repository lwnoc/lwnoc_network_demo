//[UHDL]Content Start [md5:3f97c27112a1639b738f1056644cecb6]
module ReqRspPathComponent (
	input         clk            ,
	input         rst_n          ,
	input         s_req_valid    ,
	input  [89:0] s_req_payload  ,
	input         s_req_last     ,
	input  [5:0]  s_req_srcid    ,
	input  [5:0]  s_req_tgtid    ,
	input         s_req_qos      ,
	output        s_req_threshold,
	output        s_req_ready    ,
	output        m_req_valid    ,
	output [89:0] m_req_payload  ,
	output        m_req_last     ,
	output [5:0]  m_req_srcid    ,
	output [5:0]  m_req_tgtid    ,
	output        m_req_qos      ,
	input         m_req_threshold,
	input         m_req_ready    ,
	input         s_rsp_valid    ,
	input  [89:0] s_rsp_payload  ,
	input         s_rsp_last     ,
	input  [5:0]  s_rsp_srcid    ,
	input  [5:0]  s_rsp_tgtid    ,
	input         s_rsp_qos      ,
	output        s_rsp_threshold,
	output        s_rsp_ready    ,
	output        m_rsp_valid    ,
	output [89:0] m_rsp_payload  ,
	output        m_rsp_last     ,
	output [5:0]  m_rsp_srcid    ,
	output [5:0]  m_rsp_tgtid    ,
	output        m_rsp_qos      ,
	input         m_rsp_threshold,
	input         m_rsp_ready    );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign s_req_threshold = m_req_threshold;
	
	assign s_req_ready = m_req_ready;
	
	assign m_req_valid = s_req_valid;
	
	assign m_req_payload = s_req_payload;
	
	assign m_req_last = s_req_last;
	
	assign m_req_srcid = s_req_srcid;
	
	assign m_req_tgtid = s_req_tgtid;
	
	assign m_req_qos = s_req_qos;
	
	assign s_rsp_threshold = m_rsp_threshold;
	
	assign s_rsp_ready = m_rsp_ready;
	
	assign m_rsp_valid = s_rsp_valid;
	
	assign m_rsp_payload = s_rsp_payload;
	
	assign m_rsp_last = s_rsp_last;
	
	assign m_rsp_srcid = s_rsp_srcid;
	
	assign m_rsp_tgtid = s_rsp_tgtid;
	
	assign m_rsp_qos = s_rsp_qos;
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:3f97c27112a1639b738f1056644cecb6]


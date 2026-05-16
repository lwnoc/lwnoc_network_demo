module sts_noc_vdsp_ss5_tniu_sts_tniu_noc_dec2
#(
    parameter integer unsigned WIDTH  = 32
) (
    input   logic               sel,
    input   logic               s_req_vld,
    input   logic [WIDTH-1:0]   s_req_pld,
    output  logic               s_req_rdy,

    output  logic               m_req0_vld,
    output  logic [WIDTH-1:0]   m_req0_pld,
    input   logic               m_req0_rdy,

    output  logic               m_req1_vld,
    output  logic [WIDTH-1:0]   m_req1_pld,
    input   logic               m_req1_rdy
);
    assign m_req0_vld = s_req_vld & ~sel;
    assign m_req0_pld = m_req0_vld ? s_req_pld : '0;

    assign m_req1_vld = s_req_vld & sel;
    assign m_req1_pld = m_req1_vld ? s_req_pld : '0;
    assign s_req_rdy  = sel ? m_req1_rdy : m_req0_rdy;



endmodule

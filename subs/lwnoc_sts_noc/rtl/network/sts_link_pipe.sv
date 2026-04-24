module sts_link_pipe #(
    parameter type      PLD_TYPE = logic,
    parameter integer   RS_TYPE = 0
)(
    input                       clk,
    input                       rst_n,
    input   logic               in_req_vld,
    output  logic               in_req_rdy,
    input   PLD_TYPE            in_req_pld,
    output  logic               out_req_vld,
    input   logic               out_req_rdy,
    output  PLD_TYPE            out_req_pld
);

    fcip_reg_slice #(
        .PLD_TYPE   (PLD_TYPE),
        .RS_TYPE    (RS_TYPE)
    ) u_fcip_reg_slice (
        .clk        (clk),
        .rst_n      (rst_n),
        .s_vld      (in_req_vld),
        .s_rdy      (in_req_rdy),
        .s_pld      (in_req_pld),
        .m_vld      (out_req_vld),
        .m_rdy      (out_req_rdy),
        .m_pld      (out_req_pld)
    );

endmodule
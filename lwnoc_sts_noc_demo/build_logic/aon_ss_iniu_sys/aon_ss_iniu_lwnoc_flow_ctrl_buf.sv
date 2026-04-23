module aon_ss_iniu_lwnoc_flow_ctrl_buf
#(
    parameter type PLD_TYPE = logic,
    parameter integer unsigned DEPTH = 4
) (
    input logic clk,
    input logic rst_n,

    input logic in_vld,
    input logic in_rdy,
    input PLD_TYPE in_pld,

    output logic out_vld,
    output logic out_rdy,
    output PLD_TYPE out_pld,

    output logic full_flag
);



endmodule

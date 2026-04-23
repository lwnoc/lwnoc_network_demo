module sts_demo_iniu_lwnoc_flow_ctrl_chk
#(
    parameter integer unsigned NODE_NUM = 2,
    parameter type PLD_TYPE = logic
) (
    input   logic [NODE_NUM-1:0]    flow_ctrl_busy,

    input   logic                   in_vld,
    output  logic                   in_rdy,
    input   PLD_TYPE                in_pld,

    output  logic                   out_vld,
    input   logic                   out_rdy,
    output  PLD_TYPE                out_pld
);
    logic busy_flag;
    assign busy_flag = ($unsigned(in_pld.cmn.tgt_id) < NODE_NUM) ? flow_ctrl_busy[in_pld.cmn.tgt_id] : 1'b0;
    assign out_vld = in_vld && ~busy_flag;
    assign in_rdy  = out_rdy && ~busy_flag;
    assign out_pld = in_pld;
endmodule

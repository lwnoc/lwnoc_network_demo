// Stub payload used only as the default PLD_TYPE so this module compiles
// standalone.  Real instantiations always override PLD_TYPE with the actual
// payload struct, which must contain a tgt_id field.
typedef struct packed {
    logic tgt_id;
} lwmnoc_flow_ctrl_chk_pld_stub_t;

module lwmnoc_flow_ctrl_chk #(
    parameter integer unsigned NODE_NUM = 16,
    parameter type             PLD_TYPE = lwmnoc_flow_ctrl_chk_pld_stub_t
)(
    input  logic    [NODE_NUM-1:0]    flow_ctrl_busy,

    input  logic                     in_vld,
    input  PLD_TYPE                  in_pld,
    output logic                     in_rdy,
    output logic                     out_vld,
    output PLD_TYPE                  out_pld,
    input  logic                     out_rdy
);

    assign out_vld = in_vld  && ~flow_ctrl_busy[in_pld.tgt_id];
    assign in_rdy  = out_rdy && ~flow_ctrl_busy[in_pld.tgt_id];
    assign out_pld = in_pld;

endmodule

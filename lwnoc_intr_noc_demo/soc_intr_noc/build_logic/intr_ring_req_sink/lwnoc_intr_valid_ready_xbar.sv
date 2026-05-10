module lwnoc_intr_valid_ready_xbar #(
    parameter integer unsigned PLD_WIDTH = `INTR_NETWORK_ENDPOINT_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH  = `INTR_NETWORK_ENDPOINT_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH = `INTR_NETWORK_ENDPOINT_QOS_WIDTH
)(
    input  logic                 in_valid,
    output logic                 in_ready,
    input  logic [PLD_WIDTH-1:0] in_payload,
    input  logic [ID_WIDTH-1:0]  in_srcid,
    input  logic [ID_WIDTH-1:0]  in_tgtid,
    input  logic [QOS_WIDTH-1:0] in_qos,
    input  logic                 in_last,

    output logic [ID_WIDTH-1:0]  xbar_tgt_id,
    input  logic                 xbar_sel_bit,

    output logic                 out0_valid,
    input  logic                 out0_ready,
    output logic [PLD_WIDTH-1:0] out0_payload,
    output logic [ID_WIDTH-1:0]  out0_srcid,
    output logic [ID_WIDTH-1:0]  out0_tgtid,
    output logic [QOS_WIDTH-1:0] out0_qos,
    output logic                 out0_last,

    output logic                 out1_valid,
    input  logic                 out1_ready,
    output logic [PLD_WIDTH-1:0] out1_payload,
    output logic [ID_WIDTH-1:0]  out1_srcid,
    output logic [ID_WIDTH-1:0]  out1_tgtid,
    output logic [QOS_WIDTH-1:0] out1_qos,
    output logic                 out1_last
);

    assign xbar_tgt_id = in_tgtid;

    assign out0_valid   = in_valid && !xbar_sel_bit;
    assign out0_payload = in_payload;
    assign out0_srcid   = in_srcid;
    assign out0_tgtid   = in_tgtid;
    assign out0_qos     = in_qos;
    assign out0_last    = in_last;

    assign out1_valid   = in_valid && xbar_sel_bit;
    assign out1_payload = in_payload;
    assign out1_srcid   = in_srcid;
    assign out1_tgtid   = in_tgtid;
    assign out1_qos     = in_qos;
    assign out1_last    = in_last;

    assign in_ready = xbar_sel_bit ? out1_ready : out0_ready;

endmodule

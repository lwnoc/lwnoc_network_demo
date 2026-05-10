module lwnoc_intr_default_tgtid_sink #(
    parameter integer unsigned PLD_WIDTH = `INTR_NETWORK_ENDPOINT_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH  = `INTR_NETWORK_ENDPOINT_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH = `INTR_NETWORK_ENDPOINT_QOS_WIDTH,
    parameter integer unsigned NODE_NUM  = `INTR_NETWORK_ENDPOINT_NODE_NUM,
    parameter logic            SINK_EN   = `INTR_NETWORK_SINK_EN
)(
    input  logic                 clk,
    input  logic                 rst_n,

    input  logic                 rx_valid,
    output logic                 rx_ready,
    input  logic [PLD_WIDTH-1:0] rx_payload,
    input  logic [ID_WIDTH-1:0]  rx_srcid,
    input  logic [ID_WIDTH-1:0]  rx_tgtid,
    input  logic [QOS_WIDTH-1:0] rx_qos,
    input  logic                 rx_last,

    output logic                 absorb_pulse,
    output logic                 invalid_tgtid_pulse,
    output logic                 invalid_tgtid_sticky
);

    logic invalid_tgtid;

    assign invalid_tgtid = (rx_tgtid >= ID_WIDTH'(NODE_NUM));
    assign rx_ready      = SINK_EN && invalid_tgtid;

    // Reporting logic is intentionally disabled for the simplest sink-only behavior.
    // assign absorb_pulse        = SINK_EN && rx_valid;
    // assign invalid_tgtid_pulse = SINK_EN && rx_valid && invalid_tgtid;
    // always_ff @(posedge clk or negedge rst_n) begin
    //     if(!rst_n) begin
    //         invalid_tgtid_sticky <= 1'b0;
    //     end
    //     else if(invalid_tgtid_pulse) begin
    //         invalid_tgtid_sticky <= 1'b1;
    //     end
    // end
    assign absorb_pulse        = 1'b0;
    assign invalid_tgtid_pulse = 1'b0;
    assign invalid_tgtid_sticky= 1'b0;

    // Contract check: when sink is enabled, invalid packets must be accepted.
    property p_sink_accept_invalid_when_enabled;
        @(posedge clk) disable iff(!rst_n)
        SINK_EN && rx_valid && invalid_tgtid |-> rx_ready;
    endproperty

    assert property(p_sink_accept_invalid_when_enabled)
        else $error("[lwnoc_intr_default_tgtid_sink] sink enabled but invalid packet not accepted");

    logic _unused_ok;
    assign _unused_ok = &{1'b0, rx_payload, rx_srcid, rx_qos, rx_last};

endmodule

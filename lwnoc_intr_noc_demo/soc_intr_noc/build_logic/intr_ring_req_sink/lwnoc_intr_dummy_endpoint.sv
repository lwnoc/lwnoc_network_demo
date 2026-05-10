module lwnoc_intr_dummy_endpoint #(
    parameter integer unsigned PLD_WIDTH        = `INTR_NETWORK_ENDPOINT_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH         = `INTR_NETWORK_ENDPOINT_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH        = `INTR_NETWORK_ENDPOINT_QOS_WIDTH,
    parameter integer unsigned NODE_NUM         = `INTR_NETWORK_ENDPOINT_NODE_NUM,
    parameter logic            DUMMY_EN         = `INTR_NETWORK_DUMMY_EN,
    parameter logic            SINK_EN          = `INTR_NETWORK_SINK_EN,
    parameter logic [ID_WIDTH-1:0] DUMMY_SRCID = '0,
    parameter logic [ID_WIDTH-1:0] DUMMY_TGTID = '0,
    parameter logic [QOS_WIDTH-1:0] DUMMY_QOS  = '0,
    parameter logic [PLD_WIDTH-1:0] DUMMY_PLD  = '0
)(
    input  logic                   clk,
    input  logic                   rst_n,

    input  logic                   real_tx_valid,
    output logic                   real_tx_ready,
    input  logic [PLD_WIDTH-1:0]   real_tx_payload,
    input  logic [ID_WIDTH-1:0]    real_tx_srcid,
    input  logic [ID_WIDTH-1:0]    real_tx_tgtid,
    input  logic [QOS_WIDTH-1:0]   real_tx_qos,
    input  logic                   real_tx_last,

    input  logic                   dummy_req_valid,
    output logic                   dummy_req_ready,

    output logic                   merge_tx_valid,
    input  logic                   merge_tx_ready,
    output logic [PLD_WIDTH-1:0]   merge_tx_payload,
    output logic [ID_WIDTH-1:0]    merge_tx_srcid,
    output logic [ID_WIDTH-1:0]    merge_tx_tgtid,
    output logic [QOS_WIDTH-1:0]   merge_tx_qos,
    output logic                   merge_tx_last,

    input  logic                   sink_rx_valid,
    output logic                   sink_rx_ready,
    input  logic [PLD_WIDTH-1:0]   sink_rx_payload,
    input  logic [ID_WIDTH-1:0]    sink_rx_srcid,
    input  logic [ID_WIDTH-1:0]    sink_rx_tgtid,
    input  logic [QOS_WIDTH-1:0]   sink_rx_qos,
    input  logic                   sink_rx_last,

    output logic                   sink_absorb_pulse,
    output logic                   sink_drop_invalid_pulse,
    output logic                   sink_drop_invalid_sticky
);

    logic invalid_tgtid;

    // Tieoff policy: this module is used at TNIU-side boarding point and never boards packets.
    assign merge_tx_valid   = 1'b0;
    assign merge_tx_payload = '0;
    assign merge_tx_srcid   = '0;
    assign merge_tx_tgtid   = '0;
    assign merge_tx_qos     = '0;
    assign merge_tx_last    = 1'b0;

    assign real_tx_ready    = 1'b0;
    assign dummy_req_ready  = 1'b0;

    assign invalid_tgtid = sink_rx_tgtid >= ID_WIDTH'(NODE_NUM);
    assign sink_rx_ready = SINK_EN;

    assign sink_absorb_pulse       = SINK_EN && sink_rx_valid;
    assign sink_drop_invalid_pulse = SINK_EN && sink_rx_valid && invalid_tgtid;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sink_drop_invalid_sticky <= 1'b0;
        end
        else if(sink_drop_invalid_pulse) begin
            sink_drop_invalid_sticky <= 1'b1;
        end
    end

    // Contract check: no packet source is allowed through this tieoff endpoint.
    property p_dummy_tieoff_never_source;
        @(posedge clk) disable iff(!rst_n)
        !merge_tx_valid;
    endproperty

    assert property(p_dummy_tieoff_never_source)
        else $error("[lwnoc_intr_dummy_endpoint] tieoff contract violated: merge_tx_valid must stay low");

    property p_dummy_tieoff_real_input_low;
        @(posedge clk) disable iff(!rst_n)
        !real_tx_valid;
    endproperty

    assert property(p_dummy_tieoff_real_input_low)
        else $error("[lwnoc_intr_dummy_endpoint] unexpected real_tx_valid at tieoff endpoint");

    initial begin
        if (DUMMY_TGTID >= ID_WIDTH'(NODE_NUM)) begin
            $error("[lwnoc_intr_dummy_endpoint] DUMMY_TGTID(%0d) must be less than NODE_NUM(%0d)", DUMMY_TGTID, NODE_NUM);
        end
    end

    logic _unused_ok;
    assign _unused_ok = &{1'b0, DUMMY_EN, DUMMY_SRCID, DUMMY_TGTID, DUMMY_QOS, DUMMY_PLD, dummy_req_valid,
                          merge_tx_ready, real_tx_payload, real_tx_srcid, real_tx_tgtid, real_tx_qos, real_tx_last,
                          sink_rx_payload, sink_rx_srcid, sink_rx_qos, sink_rx_last};

endmodule

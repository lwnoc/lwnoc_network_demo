module intr_ring_req_sink_intr_ring_req_sink (
    input  logic        local_rx_valid,
    output logic        local_rx_ready,
    input  logic [39:0] local_rx_payload,
    input  logic [7:0]  local_rx_srcid,
    input  logic [7:0]  local_rx_tgtid,
    input  logic [3:0]  local_rx_qos,
    input  logic        local_rx_last
);

    assign local_rx_ready = 1'b1;

endmodule

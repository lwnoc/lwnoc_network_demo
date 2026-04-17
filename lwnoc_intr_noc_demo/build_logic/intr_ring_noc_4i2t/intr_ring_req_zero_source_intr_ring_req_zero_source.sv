module intr_ring_req_zero_source_intr_ring_req_zero_source (
    output logic        local_tx_valid,
    input  logic        local_tx_ready,
    output logic [39:0] local_tx_payload,
    output logic [7:0]  local_tx_srcid,
    output logic [7:0]  local_tx_tgtid,
    output logic [3:0]  local_tx_qos,
    output logic        local_tx_last
);

    assign local_tx_valid = 1'b0;
    assign local_tx_payload = '0;
    assign local_tx_srcid = '0;
    assign local_tx_tgtid = '0;
    assign local_tx_qos = '0;
    assign local_tx_last = 1'b0;

endmodule

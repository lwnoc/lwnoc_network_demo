module lwnoc_intr_tniu_endpoint_wrap #(
    parameter integer unsigned RING_ID          = `INTR_NETWORK_ENDPOINT_RING_ID,
    parameter integer unsigned NODE_NUM         = `INTR_NETWORK_ENDPOINT_NODE_NUM,
    parameter integer unsigned PLD_WIDTH        = `INTR_NETWORK_ENDPOINT_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH         = `INTR_NETWORK_ENDPOINT_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH        = `INTR_NETWORK_ENDPOINT_QOS_WIDTH,
    parameter integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_ENDPOINT_SINGLE_THR_WIDTH
)(
    input  logic                    clk,
    input  logic                    rst_n,

    input  logic                    pring_in_if_valid,
    output logic                    pring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]    pring_in_if_payload,
    input  logic [ID_WIDTH-1:0]     pring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]     pring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]    pring_in_if_qos,
    input  logic                    pring_in_if_last,

    output logic                    pring_out_if_valid,
    input  logic                    pring_out_if_ready,
    output logic [PLD_WIDTH-1:0]    pring_out_if_payload,
    output logic [ID_WIDTH-1:0]     pring_out_if_srcid,
    output logic [ID_WIDTH-1:0]     pring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]    pring_out_if_qos,
    output logic                    pring_out_if_last,

    input  logic                    nring_in_if_valid,
    output logic                    nring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]    nring_in_if_payload,
    input  logic [ID_WIDTH-1:0]     nring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]     nring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]    nring_in_if_qos,
    input  logic                    nring_in_if_last,

    output logic                    nring_out_if_valid,
    input  logic                    nring_out_if_ready,
    output logic [PLD_WIDTH-1:0]    nring_out_if_payload,
    output logic [ID_WIDTH-1:0]     nring_out_if_srcid,
    output logic [ID_WIDTH-1:0]     nring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]    nring_out_if_qos,
    output logic                    nring_out_if_last,

    output logic                    local_rx_valid,
    input  logic                    local_rx_ready,
    output logic [PLD_WIDTH-1:0]    local_rx_payload,
    output logic [ID_WIDTH-1:0]     local_rx_srcid,
    output logic [ID_WIDTH-1:0]     local_rx_tgtid,
    output logic [QOS_WIDTH-1:0]    local_rx_qos,
    output logic                    local_rx_last
);

    logic                    pring_local_rx_valid;
    logic                    pring_local_rx_ready;
    logic [PLD_WIDTH-1:0]    pring_local_rx_payload;
    logic [ID_WIDTH-1:0]     pring_local_rx_srcid;
    logic [ID_WIDTH-1:0]     pring_local_rx_tgtid;
    logic [QOS_WIDTH-1:0]    pring_local_rx_qos;
    logic                    pring_local_rx_last;

    logic                    nring_local_rx_valid;
    logic                    nring_local_rx_ready;
    logic [PLD_WIDTH-1:0]    nring_local_rx_payload;
    logic [ID_WIDTH-1:0]     nring_local_rx_srcid;
    logic [ID_WIDTH-1:0]     nring_local_rx_tgtid;
    logic [QOS_WIDTH-1:0]    nring_local_rx_qos;
    logic                    nring_local_rx_last;

    logic                    unused_pring_local_tx_ready;
    logic                    unused_nring_local_tx_ready;

    intr_ring_buf_wrap #(
        .RING_ID          (RING_ID),
        .NODE_NUM         (NODE_NUM),
        .PLD_WIDTH        (PLD_WIDTH),
        .ID_WIDTH         (ID_WIDTH),
        .QOS_WIDTH        (QOS_WIDTH),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH)
    ) u_ring_buf_wrap (
        .clk                   (clk),
        .rst_n                 (rst_n),
        .pring_in_if_valid     (pring_in_if_valid),
        .pring_in_if_ready     (pring_in_if_ready),
        .pring_in_if_payload   (pring_in_if_payload),
        .pring_in_if_srcid     (pring_in_if_srcid),
        .pring_in_if_tgtid     (pring_in_if_tgtid),
        .pring_in_if_qos       (pring_in_if_qos),
        .pring_in_if_last      (pring_in_if_last),
        .pring_out_if_valid    (pring_out_if_valid),
        .pring_out_if_ready    (pring_out_if_ready),
        .pring_out_if_payload  (pring_out_if_payload),
        .pring_out_if_srcid    (pring_out_if_srcid),
        .pring_out_if_tgtid    (pring_out_if_tgtid),
        .pring_out_if_qos      (pring_out_if_qos),
        .pring_out_if_last     (pring_out_if_last),
        .nring_in_if_valid     (nring_in_if_valid),
        .nring_in_if_ready     (nring_in_if_ready),
        .nring_in_if_payload   (nring_in_if_payload),
        .nring_in_if_srcid     (nring_in_if_srcid),
        .nring_in_if_tgtid     (nring_in_if_tgtid),
        .nring_in_if_qos       (nring_in_if_qos),
        .nring_in_if_last      (nring_in_if_last),
        .nring_out_if_valid    (nring_out_if_valid),
        .nring_out_if_ready    (nring_out_if_ready),
        .nring_out_if_payload  (nring_out_if_payload),
        .nring_out_if_srcid    (nring_out_if_srcid),
        .nring_out_if_tgtid    (nring_out_if_tgtid),
        .nring_out_if_qos      (nring_out_if_qos),
        .nring_out_if_last     (nring_out_if_last),
        .pring_local_tx_valid  (1'b0),
        .pring_local_tx_ready  (unused_pring_local_tx_ready),
        .pring_local_tx_payload('0),
        .pring_local_tx_srcid  ('0),
        .pring_local_tx_tgtid  ('0),
        .pring_local_tx_qos    ('0),
        .pring_local_tx_last   (1'b0),
        .pring_local_rx_valid  (pring_local_rx_valid),
        .pring_local_rx_ready  (pring_local_rx_ready),
        .pring_local_rx_payload(pring_local_rx_payload),
        .pring_local_rx_srcid  (pring_local_rx_srcid),
        .pring_local_rx_tgtid  (pring_local_rx_tgtid),
        .pring_local_rx_qos    (pring_local_rx_qos),
        .pring_local_rx_last   (pring_local_rx_last),
        .nring_local_tx_valid  (1'b0),
        .nring_local_tx_ready  (unused_nring_local_tx_ready),
        .nring_local_tx_payload('0),
        .nring_local_tx_srcid  ('0),
        .nring_local_tx_tgtid  ('0),
        .nring_local_tx_qos    ('0),
        .nring_local_tx_last   (1'b0),
        .nring_local_rx_valid  (nring_local_rx_valid),
        .nring_local_rx_ready  (nring_local_rx_ready),
        .nring_local_rx_payload(nring_local_rx_payload),
        .nring_local_rx_srcid  (nring_local_rx_srcid),
        .nring_local_rx_tgtid  (nring_local_rx_tgtid),
        .nring_local_rx_qos    (nring_local_rx_qos),
        .nring_local_rx_last   (nring_local_rx_last)
    );

    assign local_rx_valid   = pring_local_rx_valid || nring_local_rx_valid;
    assign local_rx_payload = pring_local_rx_valid ? pring_local_rx_payload : nring_local_rx_payload;
    assign local_rx_srcid   = pring_local_rx_valid ? pring_local_rx_srcid : nring_local_rx_srcid;
    assign local_rx_tgtid   = pring_local_rx_valid ? pring_local_rx_tgtid : nring_local_rx_tgtid;
    assign local_rx_qos     = pring_local_rx_valid ? pring_local_rx_qos : nring_local_rx_qos;
    assign local_rx_last    = pring_local_rx_valid ? pring_local_rx_last : nring_local_rx_last;

    assign pring_local_rx_ready = local_rx_ready && pring_local_rx_valid;
    assign nring_local_rx_ready = local_rx_ready && !pring_local_rx_valid;

endmodule

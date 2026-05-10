module lwnoc_intr_ring_sp_wrap #(
    parameter integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,

    localparam integer unsigned THR_WID = SINGLE_THR_WIDTH * NODE_NUM
)(
    input  logic                 clk,

    input  logic                 pring_in_if_valid,
    output logic                 pring_in_if_ready,
    input  logic [PLD_WIDTH-1:0] pring_in_if_payload,
    input  logic [ID_WIDTH-1:0]  pring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]  pring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0] pring_in_if_qos,
    input  logic                 pring_in_if_last,

    output logic                 pring_out_if_valid,
    input  logic                 pring_out_if_ready,
    output logic [PLD_WIDTH-1:0] pring_out_if_payload,
    output logic [ID_WIDTH-1:0]  pring_out_if_srcid,
    output logic [ID_WIDTH-1:0]  pring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0] pring_out_if_qos,
    output logic                 pring_out_if_last,

    input  logic                 nring_in_if_valid,
    output logic                 nring_in_if_ready,
    input  logic [PLD_WIDTH-1:0] nring_in_if_payload,
    input  logic [ID_WIDTH-1:0]  nring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]  nring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0] nring_in_if_qos,
    input  logic                 nring_in_if_last,

    output logic                 nring_out_if_valid,
    input  logic                 nring_out_if_ready,
    output logic [PLD_WIDTH-1:0] nring_out_if_payload,
    output logic [ID_WIDTH-1:0]  nring_out_if_srcid,
    output logic [ID_WIDTH-1:0]  nring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0] nring_out_if_qos,
    output logic                 nring_out_if_last
);

    logic [THR_WID-1:0] unused_threshold_dst;
    logic [1:0]         pring_vc_rdy_src;
    logic               unused_pring_vcid;

    lwnoc_intr_ring_sp #(
        .PLD_WIDTH        (PLD_WIDTH       ),
        .ID_WIDTH         (ID_WIDTH        ),
        .QOS_WIDTH        (QOS_WIDTH       ),
        .THRESHOLD_EN     (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM        )
    ) u_ring_sp (
        .clk           (clk                         ),
        .threshold_src ('0                         ),
        .threshold_dst (unused_threshold_dst        ),
        .vld_src       (pring_in_if_valid           ),
        .payload_src   (pring_in_if_payload         ),
        .srcid_src     (pring_in_if_srcid          ),
        .tgtid_src     (pring_in_if_tgtid          ),
        .qos_src       (pring_in_if_qos            ),
        .tail_src      (pring_in_if_last           ),
        .vcid_src      (1'b0                       ),
        .vc_rdy_src    (pring_vc_rdy_src           ),
        .vld_dst       (pring_out_if_valid         ),
        .payload_dst   (pring_out_if_payload       ),
        .srcid_dst     (pring_out_if_srcid         ),
        .tgtid_dst     (pring_out_if_tgtid         ),
        .qos_dst       (pring_out_if_qos           ),
        .tail_dst      (pring_out_if_last          ),
        .vcid_dst      (unused_pring_vcid          ),
        .vc_rdy_dst    ({pring_out_if_ready, 1'b0})
    );

    assign pring_in_if_ready = pring_vc_rdy_src[0];

    assign nring_out_if_valid   = nring_in_if_valid;
    assign nring_out_if_payload = nring_in_if_payload;
    assign nring_out_if_srcid   = nring_in_if_srcid;
    assign nring_out_if_tgtid   = nring_in_if_tgtid;
    assign nring_out_if_qos     = nring_in_if_qos;
    assign nring_out_if_last    = nring_in_if_last;
    assign nring_in_if_ready    = nring_out_if_ready;

endmodule

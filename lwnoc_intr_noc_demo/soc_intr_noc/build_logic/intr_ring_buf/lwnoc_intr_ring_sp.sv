module lwnoc_intr_ring_sp #(
    parameter  integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter  integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter  integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter  bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter  integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter  integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,

    localparam integer unsigned THR_WID = SINGLE_THR_WIDTH * NODE_NUM
)(
    input   logic                       clk,
    // Threshold ports always present (feature gated inside)
    input   logic [THR_WID-1:0]        threshold_src,
    output  logic [THR_WID-1:0]        threshold_dst,

    input   logic                      vld_src ,
    input   logic [PLD_WIDTH-1:0]      payload_src ,
    input   logic [ID_WIDTH-1:0]       srcid_src,
    input   logic [ID_WIDTH-1:0]       tgtid_src,
    input   logic [QOS_WIDTH-1:0]      qos_src ,
    input   logic                      tail_src,
    input   logic                      vcid_src,
    output  logic [1:0]                vc_rdy_src ,

    output  logic                      vld_dst ,
    output  logic [PLD_WIDTH-1:0]      payload_dst ,
    output  logic [ID_WIDTH-1:0]       srcid_dst,
    output  logic [ID_WIDTH-1:0]       tgtid_dst,
    output  logic [QOS_WIDTH-1:0]      qos_dst ,
    output  logic                      tail_dst,
    output  logic                      vcid_dst ,
    input   logic [1:0]                vc_rdy_dst
);

generate
    if(THRESHOLD_EN) begin: GEN_THR_EN_CONNECT
        assign threshold_dst = threshold_src;
    end else begin: GEN_THR_EN_BYPASS
        // Disabled: drive outputs to all-zero, avoid floating
        assign threshold_dst = '0;
    end
endgenerate

assign vld_dst      = vld_src && (vcid_src == 1'b0);
assign payload_dst  = payload_src;
assign srcid_dst    = srcid_src;
assign tgtid_dst    = tgtid_src;
assign qos_dst      = qos_src;
assign tail_dst     = tail_src;
assign vcid_dst     = 1'b1;

assign vc_rdy_src[1] = 1'b1;
assign vc_rdy_src[0] = vc_rdy_dst[1];

endmodule

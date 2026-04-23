module lwnoc_ring_buf #(
    parameter  integer unsigned PLD_WIDTH        = 512,
    parameter  integer unsigned ID_WIDTH         = 4,
    parameter  integer unsigned QOS_WIDTH        = 4,
    parameter  integer unsigned BUF_DEP          = 2,
    parameter  bit              THRESHOLD_EN     = 1'b1,
    parameter  integer unsigned SINGLE_THR_WIDTH = 1,
    parameter  integer unsigned NODE_NUM         = 16,

    localparam integer unsigned THR_WID = SINGLE_THR_WIDTH * NODE_NUM
)(
    input   logic                       clk,
    input   logic                       rst_n,
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
    if(THRESHOLD_EN) begin: GEN_THRE_LOGIC
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                threshold_dst <= {THR_WID{1'b1}};
            end else begin
                threshold_dst <= threshold_src;
            end
        end
    end else begin: GEN_THR_BYPASS
        // Disabled: drive outputs to all-zero, avoid floating
        assign threshold_dst = '0;
    end
endgenerate

lwnoc_vcbuf #(
    .PLD_WIDTH   (PLD_WIDTH   ),
    .ID_WIDTH    (ID_WIDTH    ),
    .QOS_WIDTH   (QOS_WIDTH   ),
    .BUF_DEP     (BUF_DEP     ),
    .AFULL_LEVEL (1           )
) u_vcbuf (
    .clk        (clk          ),
    .rst_n      (rst_n        ),

    .vld_src    (vld_src      ),
    .pld_src    (payload_src  ),
    .srcid_src  (srcid_src    ),
    .tgtid_src  (tgtid_src    ),
    .qos_src    (qos_src      ),
    .tail_src   (tail_src     ),
    .vcid_src   (vcid_src     ),
    .vc_rdy_src (vc_rdy_src   ),

    .vld_dst    (vld_dst      ),
    .pld_dst    (payload_dst  ),
    .srcid_dst  (srcid_dst    ),
    .tgtid_dst  (tgtid_dst    ),
    .qos_dst    (qos_dst      ),
    .tail_dst   (tail_dst     ),
    .vcid_dst   (vcid_dst     ),
    .vc_rdy_dst (vc_rdy_dst   )
);


endmodule

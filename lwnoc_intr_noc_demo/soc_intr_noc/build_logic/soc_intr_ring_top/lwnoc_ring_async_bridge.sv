module lwnoc_ring_async_bridge #(
    parameter  integer unsigned PLD_WIDTH        = 512,
    parameter  integer unsigned ID_WIDTH         = 4,
    parameter  integer unsigned QOS_WIDTH        = 4,
    parameter  integer unsigned BUF_DEP          = 2,
    parameter  bit              THRESHOLD_EN     = 1'b1,
    parameter  integer unsigned SINGLE_THR_WIDTH = 1,
    parameter  integer unsigned NODE_NUM         = 16,
    parameter  integer unsigned SYNC_LEVEL       = 3,

    localparam integer unsigned THR_WID = SINGLE_THR_WIDTH * NODE_NUM
)(
    input   logic [THR_WID-1:0]        threshold_src,
    output  logic [THR_WID-1:0]        threshold_dst,
    input   logic                      clk_src,
    input   logic                      rst_src_n,
    input   logic                      vld_src,
    input   logic [PLD_WIDTH-1:0]      payload_src,
    input   logic [ID_WIDTH-1:0]       srcid_src,
    input   logic [ID_WIDTH-1:0]       tgtid_src,
    input   logic [QOS_WIDTH-1:0]      qos_src,
    input   logic                      tail_src,
    input   logic                      vcid_src,
    output  logic [1:0]                vc_rdy_src,

    input   logic                      clk_dst,
    input   logic                      rst_dst_n,
    output  logic                      vld_dst,
    output  logic [PLD_WIDTH-1:0]      payload_dst,
    output  logic [ID_WIDTH-1:0]       srcid_dst,
    output  logic [ID_WIDTH-1:0]       tgtid_dst,
    output  logic [QOS_WIDTH-1:0]      qos_dst,
    output  logic                      tail_dst,
    output  logic                      vcid_dst,
    input   logic [1:0]                vc_rdy_dst
);

    localparam integer unsigned FIFO_WID  = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 2;
    localparam integer unsigned AFIFO_WID = FIFO_WID;
    localparam integer unsigned AFIFO_DEP = 8;

    logic [AFIFO_DEP-1:0] wptr_async;
    logic [AFIFO_DEP-1:0] rptr_async;
    logic [AFIFO_DEP-1:0] rptr_sync;
    logic [AFIFO_WID:0]   pld_sync;
    logic [1:0]           vc_buf_rdy;

    lwnoc_ring_async_bridge_slv #(
        .PLD_WIDTH       (PLD_WIDTH       ),
        .ID_WIDTH        (ID_WIDTH        ),
        .QOS_WIDTH       (QOS_WIDTH       ),
        .THRESHOLD_EN    (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH(SINGLE_THR_WIDTH),
        .NODE_NUM        (NODE_NUM        ),
        .SYNC_LEVEL      (SYNC_LEVEL      ),
        .AFIFO_DEP       (AFIFO_DEP       )
    ) u_async_bridge_slv (
        .clk_src          (clk_src   ),
        .rst_src_n        (rst_src_n ),
        .vld_src          (vld_src   ),
        .payload_src      (payload_src),
        .srcid_src        (srcid_src ),
        .tgtid_src        (tgtid_src ),
        .qos_src          (qos_src   ),
        .tail_src         (tail_src  ),
        .vcid_src         (vcid_src  ),
        .vc_rdy_src       (vc_rdy_src),
        .wptr_async       (wptr_async),
        .rptr_async       (rptr_async),
        .rptr_sync        (rptr_sync ),
        .pld_sync         (pld_sync  ),
        .vc_buf_rdy_async (vc_buf_rdy)
    );

    lwnoc_ring_async_bridge_mst #(
        .PLD_WIDTH       (PLD_WIDTH       ),
        .ID_WIDTH        (ID_WIDTH        ),
        .QOS_WIDTH       (QOS_WIDTH       ),
        .THRESHOLD_EN    (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH(SINGLE_THR_WIDTH),
        .NODE_NUM        (NODE_NUM        ),
        .SYNC_LEVEL      (SYNC_LEVEL      ),
        .AFIFO_DEP       (AFIFO_DEP       )
    ) u_async_bridge_mst (
        .threshold_src (threshold_src),
        .threshold_dst (threshold_dst),
        .clk_dst       (clk_dst      ),
        .rst_dst_n     (rst_dst_n    ),
        .vld_dst       (vld_dst      ),
        .payload_dst   (payload_dst  ),
        .srcid_dst     (srcid_dst    ),
        .tgtid_dst     (tgtid_dst    ),
        .qos_dst       (qos_dst      ),
        .tail_dst      (tail_dst     ),
        .vcid_dst      (vcid_dst     ),
        .vc_rdy_dst    (vc_rdy_dst   ),
        .wptr_async    (wptr_async   ),
        .rptr_async    (rptr_async   ),
        .rptr_sync     (rptr_sync    ),
        .pld_sync      (pld_sync     ),
        .vc_buf_rdy    (vc_buf_rdy   )
    );

endmodule

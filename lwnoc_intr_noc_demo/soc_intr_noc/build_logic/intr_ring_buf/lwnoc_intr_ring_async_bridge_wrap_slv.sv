module lwnoc_intr_ring_async_bridge_wrap_slv #(
    parameter integer unsigned PLD_WIDTH        = 512,
    parameter integer unsigned ID_WIDTH         = 4,
    parameter integer unsigned QOS_WIDTH        = 4,
    parameter bit              THRESHOLD_EN     = 1'b1,
    parameter integer unsigned SINGLE_THR_WIDTH = 1,
    parameter integer unsigned NODE_NUM         = 16,
    parameter integer unsigned SYNC_LEVEL       = 3,
    parameter integer unsigned AFIFO_DEP        = 8,

    localparam integer unsigned THR_WID   = SINGLE_THR_WIDTH * NODE_NUM,
    localparam integer unsigned FIFO_WID  = PLD_WIDTH + ID_WIDTH * 2 + QOS_WIDTH + 2,
    localparam integer unsigned AFIFO_WID = FIFO_WID
)(
    input  logic                   clk_slv,
    input  logic                   rst_slv_n,

    input  logic                   pring_in_if_valid,
    output logic                   pring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]   pring_in_if_payload,
    input  logic [ID_WIDTH-1:0]    pring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]    pring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]   pring_in_if_qos,
    input  logic                   pring_in_if_last,

    output logic                   nring_out_if_valid,
    input  logic                   nring_out_if_ready,
    output logic [PLD_WIDTH-1:0]   nring_out_if_payload,
    output logic [ID_WIDTH-1:0]    nring_out_if_srcid,
    output logic [ID_WIDTH-1:0]    nring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]   nring_out_if_qos,
    output logic                   nring_out_if_last,

    output logic [AFIFO_DEP-1:0]   pring_wptr_async,
    input  logic [AFIFO_DEP-1:0]   pring_rptr_async,
    input  logic [AFIFO_DEP-1:0]   pring_rptr_sync,
    output logic [AFIFO_WID:0]     pring_pld_sync,
    input  logic [1:0]             pring_vc_buf_rdy,

    input  logic [AFIFO_DEP-1:0]   nring_wptr_async,
    output logic [AFIFO_DEP-1:0]   nring_rptr_async,
    output logic [AFIFO_DEP-1:0]   nring_rptr_sync,
    input  logic [AFIFO_WID:0]     nring_pld_sync,
    output logic [1:0]             nring_vc_buf_rdy
);

    logic [1:0]         pring_vc_rdy_src;
    logic [THR_WID-1:0] unused_nring_threshold_dst;
    logic               unused_nring_vcid;

    lwnoc_ring_async_bridge_slv #(
        .PLD_WIDTH        (PLD_WIDTH       ),
        .ID_WIDTH         (ID_WIDTH        ),
        .QOS_WIDTH        (QOS_WIDTH       ),
        .THRESHOLD_EN     (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM        ),
        .SYNC_LEVEL       (SYNC_LEVEL      ),
        .AFIFO_DEP        (AFIFO_DEP       )
    ) u_pring_slv (
        .clk_src          (clk_slv          ),
        .rst_src_n        (rst_slv_n        ),
        .vld_src          (pring_in_if_valid),
        .payload_src      (pring_in_if_payload),
        .srcid_src        (pring_in_if_srcid ),
        .tgtid_src        (pring_in_if_tgtid ),
        .qos_src          (pring_in_if_qos   ),
        .tail_src         (pring_in_if_last  ),
        .vcid_src         (1'b0              ),
        .vc_rdy_src       (pring_vc_rdy_src  ),
        .wptr_async       (pring_wptr_async  ),
        .rptr_async       (pring_rptr_async  ),
        .rptr_sync        (pring_rptr_sync   ),
        .pld_sync         (pring_pld_sync    ),
        .vc_buf_rdy_async (pring_vc_buf_rdy  )
    );

    lwnoc_ring_async_bridge_mst #(
        .PLD_WIDTH        (PLD_WIDTH       ),
        .ID_WIDTH         (ID_WIDTH        ),
        .QOS_WIDTH        (QOS_WIDTH       ),
        .THRESHOLD_EN     (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM        ),
        .SYNC_LEVEL       (SYNC_LEVEL      ),
        .AFIFO_DEP        (AFIFO_DEP       )
    ) u_nring_mst (
        .threshold_src ('0                          ),
        .threshold_dst (unused_nring_threshold_dst  ),
        .clk_dst       (clk_slv                     ),
        .rst_dst_n     (rst_slv_n                   ),
        .vld_dst       (nring_out_if_valid          ),
        .payload_dst   (nring_out_if_payload        ),
        .srcid_dst     (nring_out_if_srcid          ),
        .tgtid_dst     (nring_out_if_tgtid          ),
        .qos_dst       (nring_out_if_qos            ),
        .tail_dst      (nring_out_if_last           ),
        .vcid_dst      (unused_nring_vcid           ),
        .vc_rdy_dst    ({1'b0, nring_out_if_ready}  ),
        .wptr_async    (nring_wptr_async            ),
        .rptr_async    (nring_rptr_async            ),
        .rptr_sync     (nring_rptr_sync             ),
        .pld_sync      (nring_pld_sync              ),
        .vc_buf_rdy    (nring_vc_buf_rdy            )
    );

    assign pring_in_if_ready = pring_vc_rdy_src[0];

endmodule

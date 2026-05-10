module lwnoc_intr_ring_async_bridge_wrap_mst #(
    parameter integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,
    parameter integer unsigned SYNC_LEVEL       = `INTR_NETWORK_RING_SYNC_LEVEL,
    parameter integer unsigned AFIFO_DEP        = `INTR_NETWORK_RING_AFIFO_DEP,

    localparam integer unsigned FIFO_WID       = PLD_WIDTH + ID_WIDTH * 2 + QOS_WIDTH + 2,
    localparam integer unsigned ECC_CODE_WIDTH =
        (($clog2(FIFO_WID) + FIFO_WID + 1 <= (1 << $clog2(FIFO_WID))) ?
            $clog2(FIFO_WID) : ($clog2(FIFO_WID) + 1)),
    localparam integer unsigned ECC_OVERHEAD   = ECC_CODE_WIDTH + 1,
    localparam integer unsigned AFIFO_WID      = FIFO_WID + ECC_OVERHEAD
)(
    input  logic                   clk_mst,
    input  logic                   rst_mst_n,

    output logic                   pring_out_if_valid,
    input  logic                   pring_out_if_ready,
    output logic [PLD_WIDTH-1:0]   pring_out_if_payload,
    output logic [ID_WIDTH-1:0]    pring_out_if_srcid,
    output logic [ID_WIDTH-1:0]    pring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]   pring_out_if_qos,
    output logic                   pring_out_if_last,

    input  logic                   nring_in_if_valid,
    output logic                   nring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]   nring_in_if_payload,
    input  logic [ID_WIDTH-1:0]    nring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]    nring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]   nring_in_if_qos,
    input  logic                   nring_in_if_last,

    input  logic [AFIFO_DEP-1:0]   pring_wptr_async,
    output logic [AFIFO_DEP-1:0]   pring_rptr_async,
    output logic [AFIFO_DEP-1:0]   pring_rptr_sync,
    input  logic [AFIFO_WID:0]     pring_pld_sync,
    output logic [1:0]             pring_vc_buf_rdy,

    output logic [AFIFO_DEP-1:0]   nring_wptr_async,
    input  logic [AFIFO_DEP-1:0]   nring_rptr_async,
    input  logic [AFIFO_DEP-1:0]   nring_rptr_sync,
    output logic [AFIFO_WID:0]     nring_pld_sync,
    input  logic [1:0]             nring_vc_buf_rdy,
    output logic                   nring_sb_err,
    output logic                   nring_db_err
);

    logic unused_pring_vcid;
    logic [1:0] nring_vc_rdy_src;
    logic       pring_sb_err_w, pring_db_err_w;

    lwnoc_intr_ring_async_bridge_mst #(
        .PLD_WIDTH        (PLD_WIDTH       ),
        .ID_WIDTH         (ID_WIDTH        ),
        .QOS_WIDTH        (QOS_WIDTH       ),
        .THRESHOLD_EN     (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM        ),
        .SYNC_LEVEL       (SYNC_LEVEL      ),
        .AFIFO_DEP        (AFIFO_DEP       )
    ) u_pring_mst (
        .threshold_src ('0                          ),
        .threshold_dst (/* unused */                ),
        .clk_dst       (clk_mst                     ),
        .rst_dst_n     (rst_mst_n                   ),
        .vld_dst       (pring_out_if_valid          ),
        .payload_dst   (pring_out_if_payload        ),
        .srcid_dst     (pring_out_if_srcid          ),
        .tgtid_dst     (pring_out_if_tgtid          ),
        .qos_dst       (pring_out_if_qos            ),
        .tail_dst      (pring_out_if_last           ),
        .vcid_dst      (unused_pring_vcid           ),
        .vc_rdy_dst    ({1'b0, pring_out_if_ready}  ),
        .wptr_async    (pring_wptr_async            ),
        .rptr_async    (pring_rptr_async            ),
        .rptr_sync     (pring_rptr_sync             ),
        .pld_sync      (pring_pld_sync              ),
        .vc_buf_rdy    (pring_vc_buf_rdy            ),
        .sb_err        (pring_sb_err_w              ),
        .db_err        (pring_db_err_w              )
    );

    // pring mst ECC decode errors → wrapper outputs
    assign nring_sb_err = pring_sb_err_w;
    assign nring_db_err = pring_db_err_w;

    lwnoc_intr_ring_async_bridge_slv #(
        .PLD_WIDTH        (PLD_WIDTH       ),
        .ID_WIDTH         (ID_WIDTH        ),
        .QOS_WIDTH        (QOS_WIDTH       ),
        .THRESHOLD_EN     (THRESHOLD_EN    ),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM        ),
        .SYNC_LEVEL       (SYNC_LEVEL      ),
        .AFIFO_DEP        (AFIFO_DEP       )
    ) u_nring_slv (
        .clk_src          (clk_mst             ),
        .rst_src_n        (rst_mst_n           ),
        .vld_src          (nring_in_if_valid   ),
        .payload_src      (nring_in_if_payload ),
        .srcid_src        (nring_in_if_srcid   ),
        .tgtid_src        (nring_in_if_tgtid   ),
        .qos_src          (nring_in_if_qos     ),
        .tail_src         (nring_in_if_last    ),
        .vcid_src         (1'b0                ),
        .vc_rdy_src       (nring_vc_rdy_src    ),
        .wptr_async       (nring_wptr_async    ),
        .rptr_async       (nring_rptr_async    ),
        .rptr_sync        (nring_rptr_sync     ),
        .pld_sync         (nring_pld_sync      ),
        .vc_buf_rdy_async (nring_vc_buf_rdy    )
    );

    assign nring_in_if_ready = nring_vc_rdy_src[0];

endmodule

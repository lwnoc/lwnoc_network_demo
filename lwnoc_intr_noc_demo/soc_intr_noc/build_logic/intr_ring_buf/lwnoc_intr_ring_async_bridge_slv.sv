module lwnoc_intr_ring_async_bridge_slv #(
    parameter  integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter  integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter  integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter  bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter  integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter  integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,
    parameter  integer unsigned SYNC_LEVEL       = `INTR_NETWORK_RING_SYNC_LEVEL,
    parameter  integer unsigned AFIFO_DEP        = `INTR_NETWORK_RING_AFIFO_DEP,

    localparam integer unsigned FIFO_WID       = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 2,
    localparam integer unsigned ECC_CODE_WIDTH =
        (($clog2(FIFO_WID) + FIFO_WID + 1 <= (1 << $clog2(FIFO_WID))) ?
            $clog2(FIFO_WID) : ($clog2(FIFO_WID) + 1)),
    localparam integer unsigned ECC_OVERHEAD   = ECC_CODE_WIDTH + 1,
    localparam integer unsigned AFIFO_WID      = FIFO_WID + ECC_OVERHEAD
)(
    // src clock domain
    input   logic                       clk_src,
    input   logic                       rst_src_n,
    input   logic                       vld_src,
    input   logic [PLD_WIDTH-1:0]       payload_src,
    input   logic [ID_WIDTH-1:0]        srcid_src,
    input   logic [ID_WIDTH-1:0]        tgtid_src,
    input   logic [QOS_WIDTH-1:0]       qos_src,
    input   logic                       tail_src,
    input   logic                       vcid_src,
    output  logic [1:0]                 vc_rdy_src,

    // async FIFO cross-domain wiring
    output  logic [AFIFO_DEP-1:0]       wptr_async,
    input   logic [AFIFO_DEP-1:0]       rptr_async,
    input   logic [AFIFO_DEP-1:0]       rptr_sync,
    output  logic [AFIFO_WID:0]         pld_sync,

    // feedback from mst side (dst clock domain)
    input   logic [1:0]                 vc_buf_rdy_async
);

    logic                   afifo_almost_full;
    logic [AFIFO_WID-1:0]   afifo_wrdata;
    logic [AFIFO_WID-1:0]   afifo_wrdata_ecc;
    logic                   afifo_s_rdy;
    logic [1:0]             vc_buf_rdy_sync;

    // Sync vc buffer ready back into src domain
    lwnoc_sync_cell #(
        .INIT_VALUE (0          ),
        .WIDTH      (2          ),
        .SYNC_LEVEL (SYNC_LEVEL )
    ) u_sync_vc_rdy (
        .din   (vc_buf_rdy_async ),
        .clk   (clk_src          ),
        .rst_n (rst_src_n        ),
        .dout  (vc_buf_rdy_sync  )
    );

    // Ready when destination VC has space and async FIFO not approaching full
    assign vc_rdy_src   = vc_buf_rdy_sync & {2{~afifo_almost_full}};
    assign afifo_wrdata[FIFO_WID-1:0] = {payload_src, srcid_src, tgtid_src, qos_src, tail_src, vcid_src};

    fcip_ecc_enc #(.DATA_WIDTH(FIFO_WID)) u_bridge_ecc_enc (
        .data       (afifo_wrdata[FIFO_WID-1:0]),
        .encode_data(afifo_wrdata_ecc)
    );

    fcip_afifo_slv #(
        .FIFO_DEPTH             (AFIFO_DEP            ),
        .DATA_WIDTH             (AFIFO_WID            ),
        .AUTO_CLEAR_EN          (0                    ),
        .THRESHOLD_EN           (THRESHOLD_EN         ),
        .ALMOST_FULL_THRESHOLD  (AFIFO_DEP-2          ),
        .SYNC_STAGE             (SYNC_LEVEL           ),
        .VT_TYPE                (1                    )
    ) u_afifo_slv (
        .clk        (clk_src           ),
        .rst_n      (rst_src_n         ),
        .stall      (1'b0              ),
        .clear      (1'b0              ),
        .full_zero  (/* unused */      ),
        .s_vld      (vld_src           ),
        .s_pld      (afifo_wrdata_ecc  ),
        .s_rdy      (afifo_s_rdy       ),
        .almost_full(afifo_almost_full ),
        .wptr_async (wptr_async        ),
        .rptr_async (rptr_async        ),
        .rptr_sync  (rptr_sync         ),
        .pld_sync   (pld_sync          )
    );

endmodule

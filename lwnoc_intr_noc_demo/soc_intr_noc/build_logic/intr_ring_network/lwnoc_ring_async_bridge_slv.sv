module lwnoc_ring_async_bridge_slv #(
    parameter  integer unsigned PLD_WIDTH        = 512,
    parameter  integer unsigned ID_WIDTH         = 4,
    parameter  integer unsigned QOS_WIDTH        = 4,
    parameter  bit              THRESHOLD_EN     = 1'b1,
    parameter  integer unsigned SINGLE_THR_WIDTH = 1,
    parameter  integer unsigned NODE_NUM         = 16,
    parameter  integer unsigned SYNC_LEVEL       = 3,
    parameter  integer unsigned AFIFO_DEP        = 8,

    localparam integer unsigned FIFO_WID  = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 2,
    localparam integer unsigned AFIFO_WID = FIFO_WID
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
    assign afifo_wrdata = {payload_src, srcid_src, tgtid_src, qos_src, tail_src, vcid_src};

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
        .s_pld      (afifo_wrdata      ),
        .s_rdy      (afifo_s_rdy       ),
        .almost_full(afifo_almost_full ),
        .wptr_async (wptr_async        ),
        .rptr_async (rptr_async        ),
        .rptr_sync  (rptr_sync         ),
        .pld_sync   (pld_sync          )
    );

endmodule

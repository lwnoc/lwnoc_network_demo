module dti_async_bridge_slv #(
    parameter integer unsigned SYNC_STAGE = 3,
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned AUTO_CLEAR_EN = 1,
    parameter integer unsigned THRESHOLD_EN = 0,
    parameter integer unsigned ALMOST_FULL_THRESHOLD = FIFO_DEPTH - 2,
    parameter integer unsigned PAYLOAD_WIDTH = 64,
    parameter integer unsigned TID_WIDTH = 6,
    parameter integer unsigned VT_TYPE = 1,
    localparam integer unsigned DATA_WIDTH = PAYLOAD_WIDTH + 1 + TID_WIDTH + TID_WIDTH + 1
)(
    input   logic                       clk,
    input   logic                       rst_n,
    input   logic                       stall,
    input   logic                       clear,
    output  logic                       full_zero,
    input   logic                       s_valid,
    output  logic                       s_ready,
    input   logic [PAYLOAD_WIDTH-1:0]   s_payload,
    input   logic                       s_last,
    input   logic [TID_WIDTH-1:0]       s_srcid,
    input   logic [TID_WIDTH-1:0]       s_tgtid,
    input   logic                       s_qos,
    output  logic                       s_threshold,
    output  logic                       almost_full,
    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [DATA_WIDTH:0]        pld_sync
);

    logic [DATA_WIDTH-1:0] s_pld;

    assign s_pld = {s_payload, s_last, s_srcid, s_tgtid, s_qos};
    assign s_threshold = 1'b1;

    fcip_afifo_slv #(
        .FIFO_DEPTH             (FIFO_DEPTH),
        .DATA_WIDTH             (DATA_WIDTH),
        .AUTO_CLEAR_EN          (AUTO_CLEAR_EN),
        .THRESHOLD_EN           (THRESHOLD_EN),
        .ALMOST_FULL_THRESHOLD  (ALMOST_FULL_THRESHOLD),
        .SYNC_STAGE             (SYNC_STAGE),
        .VT_TYPE                (VT_TYPE)
    ) u_fcip_afifo_slv (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .stall                  (stall),
        .clear                  (clear),
        .full_zero              (full_zero),
        .s_vld                  (s_valid),
        .s_pld                  (s_pld),
        .s_rdy                  (s_ready),
        .almost_full            (almost_full),
        .wptr_async             (wptr_async),
        .rptr_async             (rptr_async),
        .rptr_sync              (rptr_sync),
        .pld_sync               (pld_sync)
    );

endmodule

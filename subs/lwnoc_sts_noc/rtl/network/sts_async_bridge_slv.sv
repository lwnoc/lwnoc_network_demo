module sts_async_bridge_slv #(
    parameter integer unsigned SYNC_STAGE = 3,
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned AUTO_CLEAR_EN = 1,
    parameter integer unsigned THRESHOLD_EN = 0,
    parameter integer unsigned ALMOST_FULL_THRESHOLD = FIFO_DEPTH - 2,
    parameter integer unsigned DATA_WIDTH = 32,
    parameter integer unsigned VT_TYPE = 1
)(
    input   logic                       clk,
    input   logic                       rst_n,
    input   logic                       stall,
    input   logic                       clear,
    output  logic                       full_zero,
    input   logic                       in_req_vld,
    output  logic                       in_req_rdy,
    input   logic [DATA_WIDTH-1:0]      in_req_pld,
    output  logic                       almost_full,
    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [DATA_WIDTH:0]        pld_sync
);

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
        .s_vld                  (in_req_vld),
        .s_pld                  (in_req_pld),
        .s_rdy                  (in_req_rdy),
        .almost_full            (almost_full),
        .wptr_async             (wptr_async),
        .rptr_async             (rptr_async),
        .rptr_sync              (rptr_sync),
        .pld_sync               (pld_sync)
    );

endmodule
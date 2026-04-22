module sts_async_bridge_mst #(
    parameter integer unsigned SYNC_STAGE = 3,
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned AUTO_CLEAR_EN = 1,
    parameter integer unsigned THRESHOLD_EN = 0,
    parameter integer unsigned ALMOST_EMPTY_THRESHOLD = 4,
    parameter integer unsigned DATA_WIDTH = 32,
    parameter integer unsigned VT_TYPE = 1
)(
    input   logic                       clk,
    input   logic                       rst_n,
    input   logic                       stall,
    input   logic                       clear,
    output  logic                       full_zero,
    output  logic                       idle,
    output  logic                       out_rsp_vld,
    output  logic [DATA_WIDTH-1:0]      out_rsp_pld,
    input   logic                       out_rsp_rdy,
    output  logic                       almost_empty,
    input   logic [FIFO_DEPTH-1:0]      wptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_sync,
    input   logic [DATA_WIDTH:0]        pld_sync
);

    fcip_afifo_mst #(
        .FIFO_DEPTH             (FIFO_DEPTH),
        .DATA_WIDTH             (DATA_WIDTH),
        .AUTO_CLEAR_EN          (AUTO_CLEAR_EN),
        .THRESHOLD_EN           (THRESHOLD_EN),
        .ALMOST_EMPTY_THRESHOLD (ALMOST_EMPTY_THRESHOLD),
        .SYNC_STAGE             (SYNC_STAGE),
        .VT_TYPE                (VT_TYPE)
    ) u_fcip_afifo_mst (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .stall                  (stall),
        .clear                  (clear),
        .full_zero              (full_zero),
        .idle                   (idle),
        .m_vld                  (out_rsp_vld),
        .m_pld                  (out_rsp_pld),
        .m_rdy                  (out_rsp_rdy),
        .almost_empty           (almost_empty),
        .wptr_async             (wptr_async),
        .rptr_async             (rptr_async),
        .rptr_sync              (rptr_sync),
        .pld_sync               (pld_sync)
    );

endmodule

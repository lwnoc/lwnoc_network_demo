module sts_link_buf #(
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned FIFO_WIDTH = 16,
    parameter integer unsigned ALMOST_FULL_THRESHOLD = 12,
    parameter integer unsigned ALMOST_EMPTY_THRESHOLD = 4,
    parameter integer unsigned FORWARD_EN = 1
)(
    input   logic                       clk,
    input   logic                       rst_n,
    input   logic                       stall,
    input   logic                       clear,
    output  logic                       idle,
    input   logic                       in_req_vld,
    input   logic [FIFO_WIDTH-1:0]      in_req_pld,
    output  logic                       in_req_rdy,
    output  logic                       out_req_vld,
    output  logic [FIFO_WIDTH-1:0]      out_req_pld,
    input   logic                       out_req_rdy,
    output  logic                       almost_full,
    output  logic                       almost_empty,
    output  logic                       empty,
    output  logic                       full
);

    fcip_sync_fifo_reg #(
        .FIFO_DEPTH             (FIFO_DEPTH),
        .FIFO_WIDTH             (FIFO_WIDTH),
        .ALMOST_FULL_THRESHOLD  (ALMOST_FULL_THRESHOLD),
        .ALMOST_EMPTY_THRESHOLD (ALMOST_EMPTY_THRESHOLD),
        .FORWARD_EN             (FORWARD_EN)
    ) u_fcip_sync_fifo_reg (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .stall                  (stall),
        .clear                  (clear),
        .idle                   (idle),
        .write_req_vld          (in_req_vld),
        .write_req_pld          (in_req_pld),
        .write_req_rdy          (in_req_rdy),
        .read_resp_vld          (out_req_vld),
        .read_resp_pld          (out_req_pld),
        .read_resp_rdy          (out_req_rdy),
        .almost_full            (almost_full),
        .almost_empty           (almost_empty),
        .empty                  (empty),
        .full                   (full)
    );

endmodule

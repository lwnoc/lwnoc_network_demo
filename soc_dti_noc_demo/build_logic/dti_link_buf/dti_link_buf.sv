module dti_link_buf #(
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned PAYLOAD_WIDTH = 64,
    parameter integer unsigned TID_WIDTH = 6,
    parameter integer unsigned ALMOST_FULL_THRESHOLD = 12,
    parameter integer unsigned ALMOST_EMPTY_THRESHOLD = 4,
    parameter integer unsigned FORWARD_EN = 1,
    localparam integer unsigned FIFO_WIDTH = PAYLOAD_WIDTH + 1 + TID_WIDTH + TID_WIDTH + 1
)(
    input   logic                       clk,
    input   logic                       rst_n,
    input   logic                       stall,
    input   logic                       clear,
    output  logic                       idle,
    input   logic                       write_req_valid,
    input   logic [PAYLOAD_WIDTH-1:0]   write_req_payload,
    input   logic                       write_req_last,
    input   logic [TID_WIDTH-1:0]       write_req_srcid,
    input   logic [TID_WIDTH-1:0]       write_req_tgtid,
    input   logic                       write_req_qos,
    output  logic                       write_req_ready,
    output  logic                       write_req_threshold,
    output  logic                       read_resp_valid,
    output  logic [PAYLOAD_WIDTH-1:0]   read_resp_payload,
    output  logic                       read_resp_last,
    output  logic [TID_WIDTH-1:0]       read_resp_srcid,
    output  logic [TID_WIDTH-1:0]       read_resp_tgtid,
    output  logic                       read_resp_qos,
    input   logic                       read_resp_ready,
    input   logic                       read_resp_threshold,
    output  logic                       almost_full,
    output  logic                       almost_empty,
    output  logic                       empty,
    output  logic                       full
);

    logic [FIFO_WIDTH-1:0] write_req_pld;
    logic [FIFO_WIDTH-1:0] read_resp_pld;

    assign write_req_pld = {
        write_req_payload,
        write_req_last,
        write_req_srcid,
        write_req_tgtid,
        write_req_qos
    };
    assign {
        read_resp_payload,
        read_resp_last,
        read_resp_srcid,
        read_resp_tgtid,
        read_resp_qos
    } = read_resp_pld;
    assign write_req_threshold = read_resp_threshold;

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
        .write_req_vld          (write_req_valid),
        .write_req_pld          (write_req_pld),
        .write_req_rdy          (write_req_ready),
        .read_resp_vld          (read_resp_valid),
        .read_resp_pld          (read_resp_pld),
        .read_resp_rdy          (read_resp_ready),
        .almost_full            (almost_full),
        .almost_empty           (almost_empty),
        .empty                  (empty),
        .full                   (full)
    );

endmodule

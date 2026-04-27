module dti_async_bridge_mst #(
    parameter integer unsigned SYNC_STAGE = 3,
    parameter integer unsigned FIFO_DEPTH = 16,
    parameter integer unsigned AUTO_CLEAR_EN = 1,
    parameter integer unsigned THRESHOLD_EN = 0,
    parameter integer unsigned ALMOST_EMPTY_THRESHOLD = 4,
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
    output  logic                       idle,
    output  logic                       m_valid,
    output  logic [PAYLOAD_WIDTH-1:0]   m_payload,
    output  logic                       m_last,
    output  logic [TID_WIDTH-1:0]       m_srcid,
    output  logic [TID_WIDTH-1:0]       m_tgtid,
    output  logic                       m_qos,
    input   logic                       m_ready,
    input   logic                       m_threshold,
    output  logic                       almost_empty,
    input   logic [FIFO_DEPTH-1:0]      wptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_sync,
    input   logic [DATA_WIDTH:0]        pld_sync
);

    logic [DATA_WIDTH-1:0] m_pld;

    assign {m_payload, m_last, m_srcid, m_tgtid, m_qos} = m_pld;

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
        .m_vld                  (m_valid),
        .m_pld                  (m_pld),
        .m_rdy                  (m_ready),
        .almost_empty           (almost_empty),
        .wptr_async             (wptr_async),
        .rptr_async             (rptr_async),
        .rptr_sync              (rptr_sync),
        .pld_sync               (pld_sync)
    );

    logic unused_m_threshold;
    assign unused_m_threshold = m_threshold;

endmodule

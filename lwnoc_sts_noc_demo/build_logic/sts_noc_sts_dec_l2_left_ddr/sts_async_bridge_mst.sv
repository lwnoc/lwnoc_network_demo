module sts_async_bridge_mst #(
    parameter integer unsigned SYNC_STAGE = `STS_NETWORK_ASYNC_SYNC_STAGE,
    parameter integer unsigned FIFO_DEPTH = `STS_NETWORK_ASYNC_FIFO_DEPTH,
    parameter integer unsigned AUTO_CLEAR_EN = 1,
    parameter integer unsigned THRESHOLD_EN = `STS_NETWORK_ASYNC_THRESHOLD_EN,
    parameter integer unsigned ALMOST_EMPTY_THRESHOLD = `STS_NETWORK_ASYNC_ALMOST_EMPTY_THRESHOLD,
    parameter integer unsigned DATA_WIDTH = `STS_NETWORK_ASYNC_DATA_WIDTH,
    parameter integer unsigned ERR_INT_CNT_WIDTH = `STS_NETWORK_ASYNC_ERR_INT_CNT_WIDTH,
    parameter integer unsigned VT_TYPE = `STS_NETWORK_ASYNC_VT_TYPE
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
    output  logic                       sb_err,
    output  logic                       db_err,
    input   logic [FIFO_DEPTH-1:0]      wptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_sync,
    input   logic [DATA_WIDTH:0]        pld_sync
);

    logic [32+7:0] m_pld_ecc;
    logic                   ecc_sb_raw, ecc_db_raw;
    fcip_ecc_dec #(.DATA_WIDTH(32)) u_bridge_ecc_dec (
        .encode_data(m_pld_ecc),
        .data       (out_rsp_pld),
        .sb_err     (ecc_sb_raw),
        .db_err     (ecc_db_raw)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_sb (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_sb_raw), .intr_out(sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_db (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_db_raw), .intr_out(db_err)
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
        .m_pld                  (m_pld_ecc),
        .m_rdy                  (out_rsp_rdy),
        .almost_empty           (almost_empty),
        .wptr_async             (wptr_async),
        .rptr_async             (rptr_async),
        .rptr_sync              (rptr_sync),
        .pld_sync               (pld_sync)
    );

endmodule

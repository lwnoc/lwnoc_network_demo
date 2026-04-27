module atb_async_bridge_top #(
    parameter integer unsigned FIFO_DEPTH      = 16,
    parameter integer unsigned AUTO_CLEAR_EN   = 0,
    parameter integer unsigned SYNC_STAGE      = 2,
    parameter integer unsigned ATB_DATA_WIDTH  = 64,
    parameter integer unsigned ATB_ID_WIDTH    = 7,
    parameter integer unsigned ATB_BYTES_WIDTH =
        (ATB_DATA_WIDTH == 32)  ? 2 :
        (ATB_DATA_WIDTH == 64)  ? 3 :
        (ATB_DATA_WIDTH == 128) ? 4 : $clog2(ATB_DATA_WIDTH / 8),
    parameter integer unsigned ATB_PLD_WIDTH   =
        ATB_DATA_WIDTH + ATB_ID_WIDTH + ATB_BYTES_WIDTH + 3
) (
    input   logic                       clk_atb_s,
    input   logic                       rstn_atb_s,
    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    output  logic                       s_syncreq,
    input   logic                       s_atwakeup,
    output  logic                       slv_full_zero,

    input   logic                       clk_atb_m,
    input   logic                       rstn_atb_m,
    output  logic                       m_atvalid,
    input   logic                       m_atready,
    output  logic [ATB_BYTES_WIDTH-1:0] m_atbytes,
    output  logic [ATB_DATA_WIDTH-1:0]  m_atdata,
    output  logic [ATB_ID_WIDTH-1:0]    m_atid,
    input   logic                       m_afvalid,
    output  logic                       m_afready,
    input   logic                       m_syncreq,
    output  logic                       m_atwakeup,
    output  logic                       mst_full_zero,
    output  logic                       mst_read_idle
);
    logic [FIFO_DEPTH-1:0]  wptr_async;
    logic [FIFO_DEPTH-1:0]  rptr_async;
    logic [FIFO_DEPTH-1:0]  rptr_sync;
    logic [ATB_PLD_WIDTH:0] pld_sync;
    logic                   flush_req_level;
    logic                   syncreq_level;

    network_atb_slv #(
        .FIFO_DEPTH      (FIFO_DEPTH),
        .AUTO_CLEAR_EN   (AUTO_CLEAR_EN),
        .SYNC_STAGE      (SYNC_STAGE),
        .ATB_DATA_WIDTH  (ATB_DATA_WIDTH),
        .ATB_ID_WIDTH    (ATB_ID_WIDTH),
        .ATB_BYTES_WIDTH (ATB_BYTES_WIDTH),
        .ATB_PLD_WIDTH   (ATB_PLD_WIDTH)
    ) u_network_atb_slv (
        .clk_atb_s          (clk_atb_s),
        .rstn_atb_s         (rstn_atb_s),
        .s_atvalid          (s_atvalid),
        .s_atready          (s_atready),
        .s_atbytes          (s_atbytes),
        .s_atdata           (s_atdata),
        .s_atid             (s_atid),
        .s_afvalid          (s_afvalid),
        .s_afready          (s_afready),
        .s_syncreq          (s_syncreq),
        .s_atwakeup         (s_atwakeup),
        .flush_req          (flush_req_level),
        .syncreq_level      (syncreq_level),
        .afifo_slv_full_zero(slv_full_zero),
        .wptr_async         (wptr_async),
        .rptr_async         (rptr_async),
        .rptr_sync          (rptr_sync),
        .pld_sync           (pld_sync)
    );

    network_atb_mst #(
        .FIFO_DEPTH      (FIFO_DEPTH),
        .AUTO_CLEAR_EN   (AUTO_CLEAR_EN),
        .SYNC_STAGE      (SYNC_STAGE),
        .ATB_DATA_WIDTH  (ATB_DATA_WIDTH),
        .ATB_ID_WIDTH    (ATB_ID_WIDTH),
        .ATB_BYTES_WIDTH (ATB_BYTES_WIDTH),
        .ATB_PLD_WIDTH   (ATB_PLD_WIDTH)
    ) u_network_atb_mst (
        .clk_atb_m           (clk_atb_m),
        .rstn_atb_m          (rstn_atb_m),
        .m_atvalid           (m_atvalid),
        .m_atready           (m_atready),
        .m_atbytes           (m_atbytes),
        .m_atdata            (m_atdata),
        .m_atid              (m_atid),
        .m_afvalid           (m_afvalid),
        .m_afready           (m_afready),
        .m_syncreq           (m_syncreq),
        .m_atwakeup          (m_atwakeup),
        .syncreq_level       (syncreq_level),
        .flush_req_level     (flush_req_level),
        .afifo_mst_full_zero (mst_full_zero),
        .afifo_mst_read_idle (mst_read_idle),
        .wptr_async          (wptr_async),
        .rptr_async          (rptr_async),
        .rptr_sync           (rptr_sync),
        .pld_sync            (pld_sync)
    );
endmodule

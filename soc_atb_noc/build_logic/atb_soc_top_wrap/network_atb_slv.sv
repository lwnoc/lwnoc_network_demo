module network_atb_slv #(
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
    input   logic                       flush_req,
    input   logic                       syncreq_level,
    output  logic                       afifo_slv_full_zero,
    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [ATB_PLD_WIDTH:0]     pld_sync
);
    niu_atb_slv #(
        .FIFO_DEPTH    (FIFO_DEPTH),
        .AUTO_CLEAR_EN (AUTO_CLEAR_EN),
        .SYNC_STAGE    (SYNC_STAGE)
    ) u_niu_atb_slv (
        .clk_atb_s           (clk_atb_s),
        .rstn_atb_s          (rstn_atb_s),
        .s_atvalid           (s_atvalid),
        .s_atready           (s_atready),
        .s_atbytes           (s_atbytes),
        .s_atdata            (s_atdata),
        .s_atid              (s_atid),
        .s_afvalid           (s_afvalid),
        .s_afready           (s_afready),
        .s_syncreq           (s_syncreq),
        .s_atwakeup          (s_atwakeup),
        .flush_req           (flush_req),
        .afifo_slv_stall     (1'b0),
        .afifo_slv_clear     (1'b0),
        .afifo_slv_full_zero (afifo_slv_full_zero),
        .sync_buf_stall      (1'b0),
        .sync_buf_clear      (1'b0),
        .sync_buf_idle       (),
        .wptr_async          (wptr_async),
        .rptr_async          (rptr_async),
        .rptr_sync           (rptr_sync),
        .pld_sync            (pld_sync),
        .syncreq_level       (syncreq_level)
    );
endmodule

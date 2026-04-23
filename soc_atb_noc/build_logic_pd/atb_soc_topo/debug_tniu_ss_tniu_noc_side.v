module debug_tniu_ss_tniu_noc_side #(
  parameter int DATA_W = 128
) (
  input logic clk,
  input logic rst_n,
  input logic noc_atvalid,
  output logic noc_atready,
  input logic [3:0] noc_atbytes,
  input logic [DATA_W-1:0] noc_atdata,
  input logic [6:0] noc_atid,
  output logic noc_afvalid,
  input logic noc_afready,
  output logic noc_syncreq,
  input logic noc_atwakeup,
  input logic syncreq_level,
  input logic flush_req_level,
  input logic [8:0] lp_sys_to_noc,
  output logic [8:0] lp_noc_to_sys,
  input logic [8:0] lp_afifo_sys_to_noc,
  output logic [8:0] lp_afifo_noc_to_sys,
  output logic [15:0] wptr_async,
  input logic [15:0] rptr_async,
  input logic [15:0] rptr_sync,
  output logic [142:0] pld_sync
);
// Real-subIP anchored wrapper: tniu noc-side only.
  localparam int ATB_BYTES_W = 4;
  localparam int ATB_ID_W = 7;
  localparam int ATB_PLD_W = 142;
  localparam int FIFO_DEPTH = 16;
  localparam int LP_REQ_W = 9;

  logic lwnoc_s_atready_unused;
  logic lwnoc_s_afvalid_unused;
  logic lwnoc_s_syncreq_unused;

  debug_tniu_ss_atb_tniu_noc #(.FIFO_DEPTH(FIFO_DEPTH)) u_real_tniu_noc (
    .clk_atb_s(clk),
    .rstn_atb_s(rst_n),
    .s_atvalid(noc_atvalid),
    .s_atready(lwnoc_s_atready_unused),
    .s_atbytes(noc_atbytes),
    .s_atdata(noc_atdata),
    .s_atid(noc_atid),
    .s_afvalid(lwnoc_s_afvalid_unused),
    .s_afready(noc_afready),
    .s_syncreq(lwnoc_s_syncreq_unused),
    .s_atwakeup(noc_atwakeup),
    .flush_req(flush_req_level),
    .aifo_slv_full_zero(),
    .wptr_async(wptr_async),
    .rptr_async(rptr_async),
    .rptr_sync(rptr_sync),
    .pld_sync(pld_sync),
    .syncreq_level(syncreq_level),
    .lw_rx_req(lp_sys_to_noc),
    .lw_tx_req(lp_noc_to_sys),
    .afifo_slv_rx_req(lp_afifo_sys_to_noc),
    .afifo_slv_tx_req(lp_afifo_noc_to_sys),
    .timeout_val(10'd0)
  );
endmodule

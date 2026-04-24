module mipi_ss_iniu_sys_side #(
  parameter int DATA_W = 128
) (
  input logic clk,
  input logic rst_n,
  input logic sys_atvalid,
  output logic sys_atready,
  input logic [3:0] sys_atbytes,
  input logic [DATA_W-1:0] sys_atdata,
  input logic [6:0] sys_atid,
  output logic sys_afvalid,
  input logic sys_afready,
  output logic sys_syncreq,
  input logic sys_atwakeup,
  input logic sys_preq,
  input logic [1:0] sys_pstate,
  output logic [1:0] sys_pactive,
  output logic sys_paccept,
  output logic sys_pdeny,
  input logic [9:0] timeout_val,
  output logic noc_atvalid,
  input logic noc_atready,
  output logic [3:0] noc_atbytes,
  output logic [DATA_W-1:0] noc_atdata,
  output logic [6:0] noc_atid,
  input logic noc_afvalid,
  output logic noc_afready,
  input logic noc_syncreq,
  output logic noc_atwakeup
);
// Real-subIP anchored wrapper: iniu sys-side ingress + iniu noc-side egress.
  localparam int ATB_BYTES_W = 4;
  localparam int ATB_ID_W = 7;
  localparam int ATB_PLD_W = 142;
  localparam int FIFO_DEPTH = 16;
  localparam int LP_REQ_W = 9;

  logic [FIFO_DEPTH-1:0] wptr_async;
  logic [FIFO_DEPTH-1:0] rptr_async;
  logic [FIFO_DEPTH-1:0] rptr_sync;
  logic [ATB_PLD_W:0] pld_sync;
  logic syncreq_level;
  logic flush_req_level;
  logic [LP_REQ_W-1:0] lp_sys_to_noc;
  logic [LP_REQ_W-1:0] lp_noc_to_sys;
  logic [LP_REQ_W-1:0] lp_afifo_sys_to_noc;
  logic [LP_REQ_W-1:0] lp_afifo_noc_to_sys;
  logic [ATB_BYTES_W-1:0] lwnoc_m_atbytes;
  logic [ATB_ID_W-1:0] lwnoc_m_atid;

  mipi_ss_atb_iniu_sys #(.FIFO_DEPTH(FIFO_DEPTH)) u_real_iniu_sys (
    .clk_atb_s(clk),
    .rstn_atb_s(rst_n),
    .s_atvalid(sys_atvalid),
    .s_atready(sys_atready),
    .s_atbytes(sys_atbytes),
    .s_atdata(sys_atdata),
    .s_atid(sys_atid),
    .s_afvalid(sys_afvalid),
    .s_afready(sys_afready),
    .s_syncreq(sys_syncreq),
    .s_atwakeup(sys_atwakeup),
    .flush_req(flush_req_level),
    .wptr_async(wptr_async),
    .rptr_async(rptr_async),
    .rptr_sync(rptr_sync),
    .pld_sync(pld_sync),
    .syncreq_level(syncreq_level),
    .preq(sys_preq),
    .pstate(lwnoc_lp_define_package::lwnoc_pchannel_state_t'(sys_pstate)),
    .pactive(sys_pactive),
    .paccept(sys_paccept),
    .pdeny(sys_pdeny),
    .lwnoc_rx_req(lp_noc_to_sys),
    .lwnoc_tx_req(lp_sys_to_noc),
    .afifo_slv_rx_req(lp_afifo_noc_to_sys),
    .afifo_slv_tx_req(lp_afifo_sys_to_noc),
    .timeout_val(timeout_val)
  );

  mipi_ss_atb_iniu_noc #(.FIFO_DEPTH(FIFO_DEPTH)) u_real_iniu_noc (
    .clk_atb_m(clk),
    .rstn_atb_m(rst_n),
    .m_atvalid(noc_atvalid),
    .m_atready(noc_atready),
    .m_atbytes(noc_atbytes),
    .m_atdata(noc_atdata),
    .m_atid(noc_atid),
    .m_afvalid(noc_afvalid),
    .m_afready(noc_afready),
    .m_syncreq(noc_syncreq),
    .m_atwakeup(noc_atwakeup),
    .syncreq_level(syncreq_level),
    .flush_req_level(flush_req_level),
    .afifo_mst_rx_req(lp_afifo_sys_to_noc),
    .afifo_mst_tx_req(lp_afifo_noc_to_sys),
    .wptr_async(wptr_async),
    .rptr_async(rptr_async),
    .rptr_sync(rptr_sync),
    .pld_sync(pld_sync),
    .lw_rx_req(lp_sys_to_noc),
    .lw_tx_req(lp_noc_to_sys),
    .timeout_val(timeout_val)
  );
endmodule

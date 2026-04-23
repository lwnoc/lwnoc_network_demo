// PD harden-down partition: camera/mipi INIU delivery, async bridge mst, right-side funnels, and debug TNIU.
module atb_soc_harden_dn_wrap (
  input logic clk_core,
  input logic clk_async,
  input logic rst_n,
  input logic camera_ss_atvalid,
  output logic camera_ss_atready,
  input logic [3:0] camera_ss_atbytes,
  input logic [127:0] camera_ss_atdata,
  input logic [6:0] camera_ss_atid,
  output logic camera_ss_afvalid,
  input logic camera_ss_afready,
  output logic camera_ss_syncreq,
  input logic camera_ss_atwakeup,
  input logic camera_ss_preq,
  input logic [1:0] camera_ss_pstate,
  output logic [1:0] camera_ss_pactive,
  output logic camera_ss_paccept,
  output logic camera_ss_pdeny,
  input logic mipi_ss_atvalid,
  output logic mipi_ss_atready,
  input logic [3:0] mipi_ss_atbytes,
  input logic [127:0] mipi_ss_atdata,
  input logic [6:0] mipi_ss_atid,
  output logic mipi_ss_afvalid,
  input logic mipi_ss_afready,
  output logic mipi_ss_syncreq,
  input logic mipi_ss_atwakeup,
  input logic mipi_ss_preq,
  input logic [1:0] mipi_ss_pstate,
  output logic [1:0] mipi_ss_pactive,
  output logic mipi_ss_paccept,
  output logic mipi_ss_pdeny,
  output logic debug_tniu_ss_atvalid,
  input logic debug_tniu_ss_atready,
  output logic [3:0] debug_tniu_ss_atbytes,
  output logic [127:0] debug_tniu_ss_atdata,
  output logic [6:0] debug_tniu_ss_atid,
  input logic debug_tniu_ss_afvalid,
  output logic debug_tniu_ss_afready,
  input logic debug_tniu_ss_syncreq,
  output logic debug_tniu_ss_atwakeup,
  input logic debug_tniu_ss_preq,
  input logic [1:0] debug_tniu_ss_pstate,
  output logic [1:0] debug_tniu_ss_pactive,
  output logic debug_tniu_ss_paccept,
  output logic debug_tniu_ss_pdeny,
  input logic harden_up_valid,
  input logic [127:0] harden_up_data
);

  logic w_camera_ss_sys_valid;
  logic [127:0] w_camera_ss_sys_data;
  logic w_camera_ss_noc_valid;
  logic [127:0] w_camera_ss_noc_data;
  logic w_camera_ss_noc_atvalid;
  logic w_camera_ss_noc_atready;
  logic [3:0] w_camera_ss_noc_atbytes;
  logic [127:0] w_camera_ss_noc_atdata;
  logic [6:0] w_camera_ss_noc_atid;
  logic w_camera_ss_noc_afvalid;
  logic w_camera_ss_noc_afready;
  logic w_camera_ss_noc_syncreq;
  logic w_camera_ss_noc_atwakeup;
  logic w_mipi_ss_sys_valid;
  logic [127:0] w_mipi_ss_sys_data;
  logic w_mipi_ss_noc_valid;
  logic [127:0] w_mipi_ss_noc_data;
  logic w_mipi_ss_noc_atvalid;
  logic w_mipi_ss_noc_atready;
  logic [3:0] w_mipi_ss_noc_atbytes;
  logic [127:0] w_mipi_ss_noc_atdata;
  logic [6:0] w_mipi_ss_noc_atid;
  logic w_mipi_ss_noc_afvalid;
  logic w_mipi_ss_noc_afready;
  logic w_mipi_ss_noc_syncreq;
  logic w_mipi_ss_noc_atwakeup;
  logic w_debug_tniu_ss_noc_valid;
  logic [127:0] w_debug_tniu_ss_noc_data;
  logic w_debug_tniu_ss_noc_atvalid;
  logic w_debug_tniu_ss_noc_atready;
  logic [3:0] w_debug_tniu_ss_noc_atbytes;
  logic [127:0] w_debug_tniu_ss_noc_atdata;
  logic [6:0] w_debug_tniu_ss_noc_atid;
  logic w_debug_tniu_ss_noc_afvalid;
  logic w_debug_tniu_ss_noc_afready;
  logic w_debug_tniu_ss_noc_syncreq;
  logic w_debug_tniu_ss_noc_atwakeup;
  logic w_debug_tniu_ss_sys_valid;
  logic [127:0] w_debug_tniu_ss_sys_data;
  logic w_debug_tniu_ss_syncreq_level;
  logic w_debug_tniu_ss_flush_req_level;
  logic [8:0] w_debug_tniu_ss_lp_sys_to_noc;
  logic [8:0] w_debug_tniu_ss_lp_noc_to_sys;
  logic [8:0] w_debug_tniu_ss_lp_afifo_sys_to_noc;
  logic [8:0] w_debug_tniu_ss_lp_afifo_noc_to_sys;
  logic [15:0] w_debug_tniu_ss_wptr_async;
  logic [15:0] w_debug_tniu_ss_rptr_async;
  logic [15:0] w_debug_tniu_ss_rptr_sync;
  logic [142:0] w_debug_tniu_ss_pld_sync;
  logic w_camera_funnel_valid;
  logic [127:0] w_camera_funnel_data;
  logic w_async_bridge_mst_valid;
  logic [127:0] w_async_bridge_mst_data;

  camera_ss_iniu_sys_side #(.DATA_W(128)) u_camera_ss_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(camera_ss_atvalid),
    .sys_atready(camera_ss_atready),
    .sys_atbytes(camera_ss_atbytes),
    .sys_atdata(camera_ss_atdata),
    .sys_atid(camera_ss_atid),
    .sys_afvalid(camera_ss_afvalid),
    .sys_afready(camera_ss_afready),
    .sys_syncreq(camera_ss_syncreq),
    .sys_atwakeup(camera_ss_atwakeup),
    .sys_preq(camera_ss_preq),
    .sys_pstate(camera_ss_pstate),
    .sys_pactive(camera_ss_pactive),
    .sys_paccept(camera_ss_paccept),
    .sys_pdeny(camera_ss_pdeny),
    .noc_atvalid(w_camera_ss_noc_atvalid),
    .noc_atready(w_camera_ss_noc_atready),
    .noc_atbytes(w_camera_ss_noc_atbytes),
    .noc_atdata(w_camera_ss_noc_atdata),
    .noc_atid(w_camera_ss_noc_atid),
    .noc_afvalid(w_camera_ss_noc_afvalid),
    .noc_afready(w_camera_ss_noc_afready),
    .noc_syncreq(w_camera_ss_noc_syncreq),
    .noc_atwakeup(w_camera_ss_noc_atwakeup)
  );
  assign w_camera_ss_noc_valid = w_camera_ss_noc_atvalid;
  assign w_camera_ss_noc_data = w_camera_ss_noc_atdata;
  assign w_camera_ss_noc_atready = 1'b1;
  assign w_camera_ss_noc_afvalid = 1'b0;
  assign w_camera_ss_noc_syncreq = 1'b0;

  mipi_ss_iniu_sys_side #(.DATA_W(128)) u_mipi_ss_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(mipi_ss_atvalid),
    .sys_atready(mipi_ss_atready),
    .sys_atbytes(mipi_ss_atbytes),
    .sys_atdata(mipi_ss_atdata),
    .sys_atid(mipi_ss_atid),
    .sys_afvalid(mipi_ss_afvalid),
    .sys_afready(mipi_ss_afready),
    .sys_syncreq(mipi_ss_syncreq),
    .sys_atwakeup(mipi_ss_atwakeup),
    .sys_preq(mipi_ss_preq),
    .sys_pstate(mipi_ss_pstate),
    .sys_pactive(mipi_ss_pactive),
    .sys_paccept(mipi_ss_paccept),
    .sys_pdeny(mipi_ss_pdeny),
    .noc_atvalid(w_mipi_ss_noc_atvalid),
    .noc_atready(w_mipi_ss_noc_atready),
    .noc_atbytes(w_mipi_ss_noc_atbytes),
    .noc_atdata(w_mipi_ss_noc_atdata),
    .noc_atid(w_mipi_ss_noc_atid),
    .noc_afvalid(w_mipi_ss_noc_afvalid),
    .noc_afready(w_mipi_ss_noc_afready),
    .noc_syncreq(w_mipi_ss_noc_syncreq),
    .noc_atwakeup(w_mipi_ss_noc_atwakeup)
  );
  assign w_mipi_ss_noc_valid = w_mipi_ss_noc_atvalid;
  assign w_mipi_ss_noc_data = w_mipi_ss_noc_atdata;
  assign w_mipi_ss_noc_atready = 1'b1;
  assign w_mipi_ss_noc_afvalid = 1'b0;
  assign w_mipi_ss_noc_syncreq = 1'b0;

  atb_async_bridge_mst #(.DATA_W(128)) u_async_bridge_mst (
    .clk(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .in_valid(harden_up_valid),
    .in_data(harden_up_data),
    .out_valid(w_async_bridge_mst_valid),
    .out_data(w_async_bridge_mst_data)
  );

  atb_funnel3 #(.DATA_W(128)) u_camera_funnel (
    .in0_valid(w_camera_ss_noc_valid), .in0_data(w_camera_ss_noc_data),
    .in1_valid(w_mipi_ss_noc_valid), .in1_data(w_mipi_ss_noc_data),
    .in2_valid(1'b0), .in2_data(128'b0),
    .out_valid(w_camera_funnel_valid),
    .out_data(w_camera_funnel_data)
  );

  atb_funnel3 #(.DATA_W(128)) u_right_funnel (
    .in0_valid(w_async_bridge_mst_valid), .in0_data(w_async_bridge_mst_data),
    .in1_valid(w_camera_funnel_valid), .in1_data(w_camera_funnel_data),
    .in2_valid(1'b0), .in2_data(128'b0),
    .out_valid(w_debug_tniu_ss_noc_valid),
    .out_data(w_debug_tniu_ss_noc_data)
  );

  assign w_debug_tniu_ss_noc_atvalid = w_debug_tniu_ss_noc_valid;
  assign w_debug_tniu_ss_noc_atdata = w_debug_tniu_ss_noc_data;
  assign w_debug_tniu_ss_noc_atbytes = 4'hf;
  assign w_debug_tniu_ss_noc_atid = 7'h0;
  assign w_debug_tniu_ss_noc_afready = 1'b1;
  assign w_debug_tniu_ss_noc_atwakeup = 1'b0;
  debug_tniu_ss_tniu_noc_side #(.DATA_W(128)) u_debug_tniu_ss_noc_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .noc_atvalid(w_debug_tniu_ss_noc_atvalid),
    .noc_atready(w_debug_tniu_ss_noc_atready),
    .noc_atbytes(w_debug_tniu_ss_noc_atbytes),
    .noc_atdata(w_debug_tniu_ss_noc_atdata),
    .noc_atid(w_debug_tniu_ss_noc_atid),
    .noc_afvalid(w_debug_tniu_ss_noc_afvalid),
    .noc_afready(w_debug_tniu_ss_noc_afready),
    .noc_syncreq(w_debug_tniu_ss_noc_syncreq),
    .noc_atwakeup(w_debug_tniu_ss_noc_atwakeup),
    .syncreq_level(w_debug_tniu_ss_syncreq_level),
    .flush_req_level(w_debug_tniu_ss_flush_req_level),
    .lp_sys_to_noc(w_debug_tniu_ss_lp_sys_to_noc),
    .lp_noc_to_sys(w_debug_tniu_ss_lp_noc_to_sys),
    .lp_afifo_sys_to_noc(w_debug_tniu_ss_lp_afifo_sys_to_noc),
    .lp_afifo_noc_to_sys(w_debug_tniu_ss_lp_afifo_noc_to_sys),
    .wptr_async(w_debug_tniu_ss_wptr_async),
    .rptr_async(w_debug_tniu_ss_rptr_async),
    .rptr_sync(w_debug_tniu_ss_rptr_sync),
    .pld_sync(w_debug_tniu_ss_pld_sync)
  );

  debug_tniu_ss_atb_tniu_sys #(.FIFO_DEPTH(16)) u_debug_tniu_ss_sys_side (
    .clk_atb_m(clk_core),
    .rstn_atb_m(rst_n),
    .m_atvalid(debug_tniu_ss_atvalid),
    .m_atready(debug_tniu_ss_atready),
    .m_atbytes(debug_tniu_ss_atbytes),
    .m_atdata(debug_tniu_ss_atdata),
    .m_atid(debug_tniu_ss_atid),
    .m_afvalid(debug_tniu_ss_afvalid),
    .m_afready(debug_tniu_ss_afready),
    .m_syncreq(debug_tniu_ss_syncreq),
    .m_atwakeup(debug_tniu_ss_atwakeup),
    .preq(debug_tniu_ss_preq),
    .pstate(debug_tniu_ss_pstate),
    .pactive(debug_tniu_ss_pactive),
    .paccept(debug_tniu_ss_paccept),
    .pdeny(debug_tniu_ss_pdeny),
    .syncreq_level(w_debug_tniu_ss_syncreq_level),
    .flush_req_level(w_debug_tniu_ss_flush_req_level),
    .lw_rx_req(w_debug_tniu_ss_lp_noc_to_sys),
    .lw_tx_req(w_debug_tniu_ss_lp_sys_to_noc),
    .afifo_slv_rx_req(w_debug_tniu_ss_lp_afifo_noc_to_sys),
    .afifo_slv_tx_req(w_debug_tniu_ss_lp_afifo_sys_to_noc),
    .wptr_async(w_debug_tniu_ss_wptr_async),
    .rptr_async(w_debug_tniu_ss_rptr_async),
    .rptr_sync(w_debug_tniu_ss_rptr_sync),
    .pld_sync(w_debug_tniu_ss_pld_sync),
    .timeout_val(10'd0)
  );
endmodule

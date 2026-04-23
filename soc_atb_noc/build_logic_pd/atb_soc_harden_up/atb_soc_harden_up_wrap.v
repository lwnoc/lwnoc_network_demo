// PD harden-up partition: DSP INIU delivery, left funnel, async bridge slv, and handoff into harden-down.
module atb_soc_harden_up_wrap (
  input logic clk_core,
  input logic clk_async,
  input logic rst_n,
  input logic dsp_ss0_atvalid,
  output logic dsp_ss0_atready,
  input logic [3:0] dsp_ss0_atbytes,
  input logic [127:0] dsp_ss0_atdata,
  input logic [6:0] dsp_ss0_atid,
  output logic dsp_ss0_afvalid,
  input logic dsp_ss0_afready,
  output logic dsp_ss0_syncreq,
  input logic dsp_ss0_atwakeup,
  input logic dsp_ss0_preq,
  input logic [1:0] dsp_ss0_pstate,
  output logic [1:0] dsp_ss0_pactive,
  output logic dsp_ss0_paccept,
  output logic dsp_ss0_pdeny,
  input logic dsp_ss1_atvalid,
  output logic dsp_ss1_atready,
  input logic [3:0] dsp_ss1_atbytes,
  input logic [127:0] dsp_ss1_atdata,
  input logic [6:0] dsp_ss1_atid,
  output logic dsp_ss1_afvalid,
  input logic dsp_ss1_afready,
  output logic dsp_ss1_syncreq,
  input logic dsp_ss1_atwakeup,
  input logic dsp_ss1_preq,
  input logic [1:0] dsp_ss1_pstate,
  output logic [1:0] dsp_ss1_pactive,
  output logic dsp_ss1_paccept,
  output logic dsp_ss1_pdeny,
  input logic dsp_ss2_atvalid,
  output logic dsp_ss2_atready,
  input logic [3:0] dsp_ss2_atbytes,
  input logic [127:0] dsp_ss2_atdata,
  input logic [6:0] dsp_ss2_atid,
  output logic dsp_ss2_afvalid,
  input logic dsp_ss2_afready,
  output logic dsp_ss2_syncreq,
  input logic dsp_ss2_atwakeup,
  input logic dsp_ss2_preq,
  input logic [1:0] dsp_ss2_pstate,
  output logic [1:0] dsp_ss2_pactive,
  output logic dsp_ss2_paccept,
  output logic dsp_ss2_pdeny,
  input logic dsp_ss3_atvalid,
  output logic dsp_ss3_atready,
  input logic [3:0] dsp_ss3_atbytes,
  input logic [127:0] dsp_ss3_atdata,
  input logic [6:0] dsp_ss3_atid,
  output logic dsp_ss3_afvalid,
  input logic dsp_ss3_afready,
  output logic dsp_ss3_syncreq,
  input logic dsp_ss3_atwakeup,
  input logic dsp_ss3_preq,
  input logic [1:0] dsp_ss3_pstate,
  output logic [1:0] dsp_ss3_pactive,
  output logic dsp_ss3_paccept,
  output logic dsp_ss3_pdeny,
  input logic dsp_ss4_atvalid,
  output logic dsp_ss4_atready,
  input logic [3:0] dsp_ss4_atbytes,
  input logic [127:0] dsp_ss4_atdata,
  input logic [6:0] dsp_ss4_atid,
  output logic dsp_ss4_afvalid,
  input logic dsp_ss4_afready,
  output logic dsp_ss4_syncreq,
  input logic dsp_ss4_atwakeup,
  input logic dsp_ss4_preq,
  input logic [1:0] dsp_ss4_pstate,
  output logic [1:0] dsp_ss4_pactive,
  output logic dsp_ss4_paccept,
  output logic dsp_ss4_pdeny,
  input logic dsp_ss5_atvalid,
  output logic dsp_ss5_atready,
  input logic [3:0] dsp_ss5_atbytes,
  input logic [127:0] dsp_ss5_atdata,
  input logic [6:0] dsp_ss5_atid,
  output logic dsp_ss5_afvalid,
  input logic dsp_ss5_afready,
  output logic dsp_ss5_syncreq,
  input logic dsp_ss5_atwakeup,
  input logic dsp_ss5_preq,
  input logic [1:0] dsp_ss5_pstate,
  output logic [1:0] dsp_ss5_pactive,
  output logic dsp_ss5_paccept,
  output logic dsp_ss5_pdeny,
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
  output logic debug_tniu_ss_pdeny
);

  logic w_dsp_ss0_sys_valid;
  logic [127:0] w_dsp_ss0_sys_data;
  logic w_dsp_ss0_noc_valid;
  logic [127:0] w_dsp_ss0_noc_data;
  logic w_dsp_ss0_noc_atvalid;
  logic w_dsp_ss0_noc_atready;
  logic [3:0] w_dsp_ss0_noc_atbytes;
  logic [127:0] w_dsp_ss0_noc_atdata;
  logic [6:0] w_dsp_ss0_noc_atid;
  logic w_dsp_ss0_noc_afvalid;
  logic w_dsp_ss0_noc_afready;
  logic w_dsp_ss0_noc_syncreq;
  logic w_dsp_ss0_noc_atwakeup;
  logic w_dsp_ss1_sys_valid;
  logic [127:0] w_dsp_ss1_sys_data;
  logic w_dsp_ss1_noc_valid;
  logic [127:0] w_dsp_ss1_noc_data;
  logic w_dsp_ss1_noc_atvalid;
  logic w_dsp_ss1_noc_atready;
  logic [3:0] w_dsp_ss1_noc_atbytes;
  logic [127:0] w_dsp_ss1_noc_atdata;
  logic [6:0] w_dsp_ss1_noc_atid;
  logic w_dsp_ss1_noc_afvalid;
  logic w_dsp_ss1_noc_afready;
  logic w_dsp_ss1_noc_syncreq;
  logic w_dsp_ss1_noc_atwakeup;
  logic w_dsp_ss2_sys_valid;
  logic [127:0] w_dsp_ss2_sys_data;
  logic w_dsp_ss2_noc_valid;
  logic [127:0] w_dsp_ss2_noc_data;
  logic w_dsp_ss2_noc_atvalid;
  logic w_dsp_ss2_noc_atready;
  logic [3:0] w_dsp_ss2_noc_atbytes;
  logic [127:0] w_dsp_ss2_noc_atdata;
  logic [6:0] w_dsp_ss2_noc_atid;
  logic w_dsp_ss2_noc_afvalid;
  logic w_dsp_ss2_noc_afready;
  logic w_dsp_ss2_noc_syncreq;
  logic w_dsp_ss2_noc_atwakeup;
  logic w_dsp_ss3_sys_valid;
  logic [127:0] w_dsp_ss3_sys_data;
  logic w_dsp_ss3_noc_valid;
  logic [127:0] w_dsp_ss3_noc_data;
  logic w_dsp_ss3_noc_atvalid;
  logic w_dsp_ss3_noc_atready;
  logic [3:0] w_dsp_ss3_noc_atbytes;
  logic [127:0] w_dsp_ss3_noc_atdata;
  logic [6:0] w_dsp_ss3_noc_atid;
  logic w_dsp_ss3_noc_afvalid;
  logic w_dsp_ss3_noc_afready;
  logic w_dsp_ss3_noc_syncreq;
  logic w_dsp_ss3_noc_atwakeup;
  logic w_dsp_ss4_sys_valid;
  logic [127:0] w_dsp_ss4_sys_data;
  logic w_dsp_ss4_noc_valid;
  logic [127:0] w_dsp_ss4_noc_data;
  logic w_dsp_ss4_noc_atvalid;
  logic w_dsp_ss4_noc_atready;
  logic [3:0] w_dsp_ss4_noc_atbytes;
  logic [127:0] w_dsp_ss4_noc_atdata;
  logic [6:0] w_dsp_ss4_noc_atid;
  logic w_dsp_ss4_noc_afvalid;
  logic w_dsp_ss4_noc_afready;
  logic w_dsp_ss4_noc_syncreq;
  logic w_dsp_ss4_noc_atwakeup;
  logic w_dsp_ss5_sys_valid;
  logic [127:0] w_dsp_ss5_sys_data;
  logic w_dsp_ss5_noc_valid;
  logic [127:0] w_dsp_ss5_noc_data;
  logic w_dsp_ss5_noc_atvalid;
  logic w_dsp_ss5_noc_atready;
  logic [3:0] w_dsp_ss5_noc_atbytes;
  logic [127:0] w_dsp_ss5_noc_atdata;
  logic [6:0] w_dsp_ss5_noc_atid;
  logic w_dsp_ss5_noc_afvalid;
  logic w_dsp_ss5_noc_afready;
  logic w_dsp_ss5_noc_syncreq;
  logic w_dsp_ss5_noc_atwakeup;
  logic w_left_funnel_valid;
  logic [127:0] w_left_funnel_data;
  logic w_harden_up_valid;
  logic [127:0] w_harden_up_data;

  dsp_ss0_iniu_sys_side #(.DATA_W(128)) u_dsp_ss0_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss0_atvalid),
    .sys_atready(dsp_ss0_atready),
    .sys_atbytes(dsp_ss0_atbytes),
    .sys_atdata(dsp_ss0_atdata),
    .sys_atid(dsp_ss0_atid),
    .sys_afvalid(dsp_ss0_afvalid),
    .sys_afready(dsp_ss0_afready),
    .sys_syncreq(dsp_ss0_syncreq),
    .sys_atwakeup(dsp_ss0_atwakeup),
    .sys_preq(dsp_ss0_preq),
    .sys_pstate(dsp_ss0_pstate),
    .sys_pactive(dsp_ss0_pactive),
    .sys_paccept(dsp_ss0_paccept),
    .sys_pdeny(dsp_ss0_pdeny),
    .noc_atvalid(w_dsp_ss0_noc_atvalid),
    .noc_atready(w_dsp_ss0_noc_atready),
    .noc_atbytes(w_dsp_ss0_noc_atbytes),
    .noc_atdata(w_dsp_ss0_noc_atdata),
    .noc_atid(w_dsp_ss0_noc_atid),
    .noc_afvalid(w_dsp_ss0_noc_afvalid),
    .noc_afready(w_dsp_ss0_noc_afready),
    .noc_syncreq(w_dsp_ss0_noc_syncreq),
    .noc_atwakeup(w_dsp_ss0_noc_atwakeup)
  );
  assign w_dsp_ss0_noc_valid = w_dsp_ss0_noc_atvalid;
  assign w_dsp_ss0_noc_data = w_dsp_ss0_noc_atdata;
  assign w_dsp_ss0_noc_atready = 1'b1;
  assign w_dsp_ss0_noc_afvalid = 1'b0;
  assign w_dsp_ss0_noc_syncreq = 1'b0;

  dsp_ss1_iniu_sys_side #(.DATA_W(128)) u_dsp_ss1_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss1_atvalid),
    .sys_atready(dsp_ss1_atready),
    .sys_atbytes(dsp_ss1_atbytes),
    .sys_atdata(dsp_ss1_atdata),
    .sys_atid(dsp_ss1_atid),
    .sys_afvalid(dsp_ss1_afvalid),
    .sys_afready(dsp_ss1_afready),
    .sys_syncreq(dsp_ss1_syncreq),
    .sys_atwakeup(dsp_ss1_atwakeup),
    .sys_preq(dsp_ss1_preq),
    .sys_pstate(dsp_ss1_pstate),
    .sys_pactive(dsp_ss1_pactive),
    .sys_paccept(dsp_ss1_paccept),
    .sys_pdeny(dsp_ss1_pdeny),
    .noc_atvalid(w_dsp_ss1_noc_atvalid),
    .noc_atready(w_dsp_ss1_noc_atready),
    .noc_atbytes(w_dsp_ss1_noc_atbytes),
    .noc_atdata(w_dsp_ss1_noc_atdata),
    .noc_atid(w_dsp_ss1_noc_atid),
    .noc_afvalid(w_dsp_ss1_noc_afvalid),
    .noc_afready(w_dsp_ss1_noc_afready),
    .noc_syncreq(w_dsp_ss1_noc_syncreq),
    .noc_atwakeup(w_dsp_ss1_noc_atwakeup)
  );
  assign w_dsp_ss1_noc_valid = w_dsp_ss1_noc_atvalid;
  assign w_dsp_ss1_noc_data = w_dsp_ss1_noc_atdata;
  assign w_dsp_ss1_noc_atready = 1'b1;
  assign w_dsp_ss1_noc_afvalid = 1'b0;
  assign w_dsp_ss1_noc_syncreq = 1'b0;

  dsp_ss2_iniu_sys_side #(.DATA_W(128)) u_dsp_ss2_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss2_atvalid),
    .sys_atready(dsp_ss2_atready),
    .sys_atbytes(dsp_ss2_atbytes),
    .sys_atdata(dsp_ss2_atdata),
    .sys_atid(dsp_ss2_atid),
    .sys_afvalid(dsp_ss2_afvalid),
    .sys_afready(dsp_ss2_afready),
    .sys_syncreq(dsp_ss2_syncreq),
    .sys_atwakeup(dsp_ss2_atwakeup),
    .sys_preq(dsp_ss2_preq),
    .sys_pstate(dsp_ss2_pstate),
    .sys_pactive(dsp_ss2_pactive),
    .sys_paccept(dsp_ss2_paccept),
    .sys_pdeny(dsp_ss2_pdeny),
    .noc_atvalid(w_dsp_ss2_noc_atvalid),
    .noc_atready(w_dsp_ss2_noc_atready),
    .noc_atbytes(w_dsp_ss2_noc_atbytes),
    .noc_atdata(w_dsp_ss2_noc_atdata),
    .noc_atid(w_dsp_ss2_noc_atid),
    .noc_afvalid(w_dsp_ss2_noc_afvalid),
    .noc_afready(w_dsp_ss2_noc_afready),
    .noc_syncreq(w_dsp_ss2_noc_syncreq),
    .noc_atwakeup(w_dsp_ss2_noc_atwakeup)
  );
  assign w_dsp_ss2_noc_valid = w_dsp_ss2_noc_atvalid;
  assign w_dsp_ss2_noc_data = w_dsp_ss2_noc_atdata;
  assign w_dsp_ss2_noc_atready = 1'b1;
  assign w_dsp_ss2_noc_afvalid = 1'b0;
  assign w_dsp_ss2_noc_syncreq = 1'b0;

  dsp_ss3_iniu_sys_side #(.DATA_W(128)) u_dsp_ss3_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss3_atvalid),
    .sys_atready(dsp_ss3_atready),
    .sys_atbytes(dsp_ss3_atbytes),
    .sys_atdata(dsp_ss3_atdata),
    .sys_atid(dsp_ss3_atid),
    .sys_afvalid(dsp_ss3_afvalid),
    .sys_afready(dsp_ss3_afready),
    .sys_syncreq(dsp_ss3_syncreq),
    .sys_atwakeup(dsp_ss3_atwakeup),
    .sys_preq(dsp_ss3_preq),
    .sys_pstate(dsp_ss3_pstate),
    .sys_pactive(dsp_ss3_pactive),
    .sys_paccept(dsp_ss3_paccept),
    .sys_pdeny(dsp_ss3_pdeny),
    .noc_atvalid(w_dsp_ss3_noc_atvalid),
    .noc_atready(w_dsp_ss3_noc_atready),
    .noc_atbytes(w_dsp_ss3_noc_atbytes),
    .noc_atdata(w_dsp_ss3_noc_atdata),
    .noc_atid(w_dsp_ss3_noc_atid),
    .noc_afvalid(w_dsp_ss3_noc_afvalid),
    .noc_afready(w_dsp_ss3_noc_afready),
    .noc_syncreq(w_dsp_ss3_noc_syncreq),
    .noc_atwakeup(w_dsp_ss3_noc_atwakeup)
  );
  assign w_dsp_ss3_noc_valid = w_dsp_ss3_noc_atvalid;
  assign w_dsp_ss3_noc_data = w_dsp_ss3_noc_atdata;
  assign w_dsp_ss3_noc_atready = 1'b1;
  assign w_dsp_ss3_noc_afvalid = 1'b0;
  assign w_dsp_ss3_noc_syncreq = 1'b0;

  dsp_ss4_iniu_sys_side #(.DATA_W(128)) u_dsp_ss4_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss4_atvalid),
    .sys_atready(dsp_ss4_atready),
    .sys_atbytes(dsp_ss4_atbytes),
    .sys_atdata(dsp_ss4_atdata),
    .sys_atid(dsp_ss4_atid),
    .sys_afvalid(dsp_ss4_afvalid),
    .sys_afready(dsp_ss4_afready),
    .sys_syncreq(dsp_ss4_syncreq),
    .sys_atwakeup(dsp_ss4_atwakeup),
    .sys_preq(dsp_ss4_preq),
    .sys_pstate(dsp_ss4_pstate),
    .sys_pactive(dsp_ss4_pactive),
    .sys_paccept(dsp_ss4_paccept),
    .sys_pdeny(dsp_ss4_pdeny),
    .noc_atvalid(w_dsp_ss4_noc_atvalid),
    .noc_atready(w_dsp_ss4_noc_atready),
    .noc_atbytes(w_dsp_ss4_noc_atbytes),
    .noc_atdata(w_dsp_ss4_noc_atdata),
    .noc_atid(w_dsp_ss4_noc_atid),
    .noc_afvalid(w_dsp_ss4_noc_afvalid),
    .noc_afready(w_dsp_ss4_noc_afready),
    .noc_syncreq(w_dsp_ss4_noc_syncreq),
    .noc_atwakeup(w_dsp_ss4_noc_atwakeup)
  );
  assign w_dsp_ss4_noc_valid = w_dsp_ss4_noc_atvalid;
  assign w_dsp_ss4_noc_data = w_dsp_ss4_noc_atdata;
  assign w_dsp_ss4_noc_atready = 1'b1;
  assign w_dsp_ss4_noc_afvalid = 1'b0;
  assign w_dsp_ss4_noc_syncreq = 1'b0;

  dsp_ss5_iniu_sys_side #(.DATA_W(128)) u_dsp_ss5_sys_side (
    .clk(clk_core),
    .rst_n(rst_n),
    .sys_atvalid(dsp_ss5_atvalid),
    .sys_atready(dsp_ss5_atready),
    .sys_atbytes(dsp_ss5_atbytes),
    .sys_atdata(dsp_ss5_atdata),
    .sys_atid(dsp_ss5_atid),
    .sys_afvalid(dsp_ss5_afvalid),
    .sys_afready(dsp_ss5_afready),
    .sys_syncreq(dsp_ss5_syncreq),
    .sys_atwakeup(dsp_ss5_atwakeup),
    .sys_preq(dsp_ss5_preq),
    .sys_pstate(dsp_ss5_pstate),
    .sys_pactive(dsp_ss5_pactive),
    .sys_paccept(dsp_ss5_paccept),
    .sys_pdeny(dsp_ss5_pdeny),
    .noc_atvalid(w_dsp_ss5_noc_atvalid),
    .noc_atready(w_dsp_ss5_noc_atready),
    .noc_atbytes(w_dsp_ss5_noc_atbytes),
    .noc_atdata(w_dsp_ss5_noc_atdata),
    .noc_atid(w_dsp_ss5_noc_atid),
    .noc_afvalid(w_dsp_ss5_noc_afvalid),
    .noc_afready(w_dsp_ss5_noc_afready),
    .noc_syncreq(w_dsp_ss5_noc_syncreq),
    .noc_atwakeup(w_dsp_ss5_noc_atwakeup)
  );
  assign w_dsp_ss5_noc_valid = w_dsp_ss5_noc_atvalid;
  assign w_dsp_ss5_noc_data = w_dsp_ss5_noc_atdata;
  assign w_dsp_ss5_noc_atready = 1'b1;
  assign w_dsp_ss5_noc_afvalid = 1'b0;
  assign w_dsp_ss5_noc_syncreq = 1'b0;

  atb_funnel6 #(.DATA_W(128)) u_left_funnel (
    .in0_valid(w_dsp_ss0_noc_valid), .in0_data(w_dsp_ss0_noc_data),
    .in1_valid(w_dsp_ss1_noc_valid), .in1_data(w_dsp_ss1_noc_data),
    .in2_valid(w_dsp_ss2_noc_valid), .in2_data(w_dsp_ss2_noc_data),
    .in3_valid(w_dsp_ss3_noc_valid), .in3_data(w_dsp_ss3_noc_data),
    .in4_valid(w_dsp_ss4_noc_valid), .in4_data(w_dsp_ss4_noc_data),
    .in5_valid(w_dsp_ss5_noc_valid), .in5_data(w_dsp_ss5_noc_data),
    .out_valid(w_left_funnel_valid),
    .out_data(w_left_funnel_data)
  );

  atb_async_bridge_slv #(.DATA_W(128)) u_async_bridge_slv (
    .clk(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .in_valid(w_left_funnel_valid),
    .in_data(w_left_funnel_data),
    .out_valid(w_harden_up_valid),
    .out_data(w_harden_up_data)
  );

  atb_soc_harden_dn_wrap u_atb_soc_harden_dn_wrap (
    .clk_core(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .camera_ss_atvalid(camera_ss_atvalid),
    .camera_ss_atready(camera_ss_atready),
    .camera_ss_atbytes(camera_ss_atbytes),
    .camera_ss_atdata(camera_ss_atdata),
    .camera_ss_atid(camera_ss_atid),
    .camera_ss_afvalid(camera_ss_afvalid),
    .camera_ss_afready(camera_ss_afready),
    .camera_ss_syncreq(camera_ss_syncreq),
    .camera_ss_atwakeup(camera_ss_atwakeup),
    .camera_ss_preq(camera_ss_preq),
    .camera_ss_pstate(camera_ss_pstate),
    .camera_ss_pactive(camera_ss_pactive),
    .camera_ss_paccept(camera_ss_paccept),
    .camera_ss_pdeny(camera_ss_pdeny),
    .mipi_ss_atvalid(mipi_ss_atvalid),
    .mipi_ss_atready(mipi_ss_atready),
    .mipi_ss_atbytes(mipi_ss_atbytes),
    .mipi_ss_atdata(mipi_ss_atdata),
    .mipi_ss_atid(mipi_ss_atid),
    .mipi_ss_afvalid(mipi_ss_afvalid),
    .mipi_ss_afready(mipi_ss_afready),
    .mipi_ss_syncreq(mipi_ss_syncreq),
    .mipi_ss_atwakeup(mipi_ss_atwakeup),
    .mipi_ss_preq(mipi_ss_preq),
    .mipi_ss_pstate(mipi_ss_pstate),
    .mipi_ss_pactive(mipi_ss_pactive),
    .mipi_ss_paccept(mipi_ss_paccept),
    .mipi_ss_pdeny(mipi_ss_pdeny),
    .debug_tniu_ss_atvalid(debug_tniu_ss_atvalid),
    .debug_tniu_ss_atready(debug_tniu_ss_atready),
    .debug_tniu_ss_atbytes(debug_tniu_ss_atbytes),
    .debug_tniu_ss_atdata(debug_tniu_ss_atdata),
    .debug_tniu_ss_atid(debug_tniu_ss_atid),
    .debug_tniu_ss_afvalid(debug_tniu_ss_afvalid),
    .debug_tniu_ss_afready(debug_tniu_ss_afready),
    .debug_tniu_ss_syncreq(debug_tniu_ss_syncreq),
    .debug_tniu_ss_atwakeup(debug_tniu_ss_atwakeup),
    .debug_tniu_ss_preq(debug_tniu_ss_preq),
    .debug_tniu_ss_pstate(debug_tniu_ss_pstate),
    .debug_tniu_ss_pactive(debug_tniu_ss_pactive),
    .debug_tniu_ss_paccept(debug_tniu_ss_paccept),
    .debug_tniu_ss_pdeny(debug_tniu_ss_pdeny),
    .harden_up_valid(w_harden_up_valid),
    .harden_up_data(w_harden_up_data)
  );
endmodule

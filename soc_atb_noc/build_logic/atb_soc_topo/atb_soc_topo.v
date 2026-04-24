// ATB SoC top-level publish wrapper.
module atb_soc_topo (
  input logic clk_core,
  input logic clk_async,
  input logic rst_core_n,
  input logic rst_async_n,
  input logic dsp_ss0_clk_sys,
  input logic dsp_ss0_rst_sys_n,
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
  input logic dsp_ss1_clk_sys,
  input logic dsp_ss1_rst_sys_n,
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
  input logic dsp_ss2_clk_sys,
  input logic dsp_ss2_rst_sys_n,
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
  input logic dsp_ss3_clk_sys,
  input logic dsp_ss3_rst_sys_n,
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
  input logic dsp_ss4_clk_sys,
  input logic dsp_ss4_rst_sys_n,
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
  input logic dsp_ss5_clk_sys,
  input logic dsp_ss5_rst_sys_n,
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
  input logic camera_ss_clk_sys,
  input logic camera_ss_rst_sys_n,
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
  input logic mipi_ss_clk_sys,
  input logic mipi_ss_rst_sys_n,
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
  input logic debug_tniu_ss_clk_sys,
  input logic debug_tniu_ss_rst_sys_n,
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
  input logic left_funnel_pclkendbg,
  input logic left_funnel_pseldbg,
  input logic left_funnel_penabledbg,
  input logic left_funnel_pwritedbg,
  input logic left_funnel_paddrdbg31,
  input logic [9:0] left_funnel_paddrdbg,
  input logic [31:0] left_funnel_pwdatadbg,
  output logic left_funnel_preadydbg,
  output logic left_funnel_pslverrdbg,
  output logic [31:0] left_funnel_prdatadbg,
  input logic camera_funnel_pclkendbg,
  input logic camera_funnel_pseldbg,
  input logic camera_funnel_penabledbg,
  input logic camera_funnel_pwritedbg,
  input logic camera_funnel_paddrdbg31,
  input logic [9:0] camera_funnel_paddrdbg,
  input logic [31:0] camera_funnel_pwdatadbg,
  output logic camera_funnel_preadydbg,
  output logic camera_funnel_pslverrdbg,
  output logic [31:0] camera_funnel_prdatadbg,
  input logic right_funnel_pclkendbg,
  input logic right_funnel_pseldbg,
  input logic right_funnel_penabledbg,
  input logic right_funnel_pwritedbg,
  input logic right_funnel_paddrdbg31,
  input logic [9:0] right_funnel_paddrdbg,
  input logic [31:0] right_funnel_pwdatadbg,
  output logic right_funnel_preadydbg,
  output logic right_funnel_pslverrdbg,
  output logic [31:0] right_funnel_prdatadbg,
  input  logic [9:0] timeout_val
);

  logic w_dsp_ss0_noc_atvalid;
  logic w_dsp_ss0_noc_atready;
  logic [3:0] w_dsp_ss0_noc_atbytes;
  logic [127:0] w_dsp_ss0_noc_atdata;
  logic [6:0] w_dsp_ss0_noc_atid;
  logic w_dsp_ss0_noc_afvalid;
  logic w_dsp_ss0_noc_afready;
  logic w_dsp_ss0_noc_syncreq;
  logic w_dsp_ss0_noc_atwakeup;
  logic w_dsp_ss1_noc_atvalid;
  logic w_dsp_ss1_noc_atready;
  logic [3:0] w_dsp_ss1_noc_atbytes;
  logic [127:0] w_dsp_ss1_noc_atdata;
  logic [6:0] w_dsp_ss1_noc_atid;
  logic w_dsp_ss1_noc_afvalid;
  logic w_dsp_ss1_noc_afready;
  logic w_dsp_ss1_noc_syncreq;
  logic w_dsp_ss1_noc_atwakeup;
  logic w_dsp_ss2_noc_atvalid;
  logic w_dsp_ss2_noc_atready;
  logic [3:0] w_dsp_ss2_noc_atbytes;
  logic [127:0] w_dsp_ss2_noc_atdata;
  logic [6:0] w_dsp_ss2_noc_atid;
  logic w_dsp_ss2_noc_afvalid;
  logic w_dsp_ss2_noc_afready;
  logic w_dsp_ss2_noc_syncreq;
  logic w_dsp_ss2_noc_atwakeup;
  logic w_dsp_ss3_noc_atvalid;
  logic w_dsp_ss3_noc_atready;
  logic [3:0] w_dsp_ss3_noc_atbytes;
  logic [127:0] w_dsp_ss3_noc_atdata;
  logic [6:0] w_dsp_ss3_noc_atid;
  logic w_dsp_ss3_noc_afvalid;
  logic w_dsp_ss3_noc_afready;
  logic w_dsp_ss3_noc_syncreq;
  logic w_dsp_ss3_noc_atwakeup;
  logic w_dsp_ss4_noc_atvalid;
  logic w_dsp_ss4_noc_atready;
  logic [3:0] w_dsp_ss4_noc_atbytes;
  logic [127:0] w_dsp_ss4_noc_atdata;
  logic [6:0] w_dsp_ss4_noc_atid;
  logic w_dsp_ss4_noc_afvalid;
  logic w_dsp_ss4_noc_afready;
  logic w_dsp_ss4_noc_syncreq;
  logic w_dsp_ss4_noc_atwakeup;
  logic w_dsp_ss5_noc_atvalid;
  logic w_dsp_ss5_noc_atready;
  logic [3:0] w_dsp_ss5_noc_atbytes;
  logic [127:0] w_dsp_ss5_noc_atdata;
  logic [6:0] w_dsp_ss5_noc_atid;
  logic w_dsp_ss5_noc_afvalid;
  logic w_dsp_ss5_noc_afready;
  logic w_dsp_ss5_noc_syncreq;
  logic w_dsp_ss5_noc_atwakeup;
  logic w_camera_ss_noc_atvalid;
  logic w_camera_ss_noc_atready;
  logic [3:0] w_camera_ss_noc_atbytes;
  logic [127:0] w_camera_ss_noc_atdata;
  logic [6:0] w_camera_ss_noc_atid;
  logic w_camera_ss_noc_afvalid;
  logic w_camera_ss_noc_afready;
  logic w_camera_ss_noc_syncreq;
  logic w_camera_ss_noc_atwakeup;
  logic w_mipi_ss_noc_atvalid;
  logic w_mipi_ss_noc_atready;
  logic [3:0] w_mipi_ss_noc_atbytes;
  logic [127:0] w_mipi_ss_noc_atdata;
  logic [6:0] w_mipi_ss_noc_atid;
  logic w_mipi_ss_noc_afvalid;
  logic w_mipi_ss_noc_afready;
  logic w_mipi_ss_noc_syncreq;
  logic w_mipi_ss_noc_atwakeup;
  logic w_debug_tniu_ss_noc_atvalid;
  logic w_debug_tniu_ss_noc_atready;
  logic [3:0] w_debug_tniu_ss_noc_atbytes;
  logic [127:0] w_debug_tniu_ss_noc_atdata;
  logic [6:0] w_debug_tniu_ss_noc_atid;
  logic w_debug_tniu_ss_noc_afvalid;
  logic w_debug_tniu_ss_noc_afready;
  logic w_debug_tniu_ss_noc_syncreq;
  logic w_debug_tniu_ss_noc_atwakeup;
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

  dsp_ss0_iniu_sys_side #(.DATA_W(128)) u_dsp_ss0_sys_side (
    .clk(dsp_ss0_clk_sys),
    .rst_n(dsp_ss0_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  dsp_ss1_iniu_sys_side #(.DATA_W(128)) u_dsp_ss1_sys_side (
    .clk(dsp_ss1_clk_sys),
    .rst_n(dsp_ss1_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  dsp_ss2_iniu_sys_side #(.DATA_W(128)) u_dsp_ss2_sys_side (
    .clk(dsp_ss2_clk_sys),
    .rst_n(dsp_ss2_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  dsp_ss3_iniu_sys_side #(.DATA_W(128)) u_dsp_ss3_sys_side (
    .clk(dsp_ss3_clk_sys),
    .rst_n(dsp_ss3_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  dsp_ss4_iniu_sys_side #(.DATA_W(128)) u_dsp_ss4_sys_side (
    .clk(dsp_ss4_clk_sys),
    .rst_n(dsp_ss4_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  dsp_ss5_iniu_sys_side #(.DATA_W(128)) u_dsp_ss5_sys_side (
    .clk(dsp_ss5_clk_sys),
    .rst_n(dsp_ss5_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  camera_ss_iniu_sys_side #(.DATA_W(128)) u_camera_ss_sys_side (
    .clk(camera_ss_clk_sys),
    .rst_n(camera_ss_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  mipi_ss_iniu_sys_side #(.DATA_W(128)) u_mipi_ss_sys_side (
    .clk(mipi_ss_clk_sys),
    .rst_n(mipi_ss_rst_sys_n),
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
    .timeout_val(timeout_val),
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

  debug_tniu_ss_tniu_noc_side #(.DATA_W(128)) u_debug_tniu_ss_noc_side (
    .clk(clk_async),
    .rst_n(rst_async_n),
    .noc_atvalid(w_debug_tniu_ss_noc_atvalid),
    .noc_atready(w_debug_tniu_ss_noc_atready),
    .noc_atbytes(w_debug_tniu_ss_noc_atbytes),
    .noc_atdata(w_debug_tniu_ss_noc_atdata),
    .noc_atid(w_debug_tniu_ss_noc_atid),
    .noc_afvalid(w_debug_tniu_ss_noc_afvalid),
    .noc_afready(w_debug_tniu_ss_noc_afready),
    .noc_syncreq(w_debug_tniu_ss_noc_syncreq),
    .noc_atwakeup(w_debug_tniu_ss_noc_atwakeup),
    .timeout_val(timeout_val),
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
    .clk_atb_m(debug_tniu_ss_clk_sys),
    .rstn_atb_m(debug_tniu_ss_rst_sys_n),
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
    .pstate(lwnoc_lp_define_package::lwnoc_pchannel_state_t'(debug_tniu_ss_pstate)),
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
    .timeout_val(timeout_val)
  );

  atb_network_layer u_atb_network_layer (
    .clk_core(clk_core),
    .clk_async(clk_async),
    .rst_core_n(rst_core_n),
    .rst_async_n(rst_async_n),
    .dsp_ss0_in_atvalid(w_dsp_ss0_noc_atvalid),
    .dsp_ss0_in_atbytes(w_dsp_ss0_noc_atbytes),
    .dsp_ss0_in_atdata(w_dsp_ss0_noc_atdata),
    .dsp_ss0_in_atid(w_dsp_ss0_noc_atid),
    .dsp_ss0_in_afready(w_dsp_ss0_noc_afready),
    .dsp_ss0_in_atwakeup(w_dsp_ss0_noc_atwakeup),
    .dsp_ss0_out_atready(w_dsp_ss0_noc_atready),
    .dsp_ss0_out_afvalid(w_dsp_ss0_noc_afvalid),
    .dsp_ss0_out_syncreq(w_dsp_ss0_noc_syncreq),
    .dsp_ss1_in_atvalid(w_dsp_ss1_noc_atvalid),
    .dsp_ss1_in_atbytes(w_dsp_ss1_noc_atbytes),
    .dsp_ss1_in_atdata(w_dsp_ss1_noc_atdata),
    .dsp_ss1_in_atid(w_dsp_ss1_noc_atid),
    .dsp_ss1_in_afready(w_dsp_ss1_noc_afready),
    .dsp_ss1_in_atwakeup(w_dsp_ss1_noc_atwakeup),
    .dsp_ss1_out_atready(w_dsp_ss1_noc_atready),
    .dsp_ss1_out_afvalid(w_dsp_ss1_noc_afvalid),
    .dsp_ss1_out_syncreq(w_dsp_ss1_noc_syncreq),
    .dsp_ss2_in_atvalid(w_dsp_ss2_noc_atvalid),
    .dsp_ss2_in_atbytes(w_dsp_ss2_noc_atbytes),
    .dsp_ss2_in_atdata(w_dsp_ss2_noc_atdata),
    .dsp_ss2_in_atid(w_dsp_ss2_noc_atid),
    .dsp_ss2_in_afready(w_dsp_ss2_noc_afready),
    .dsp_ss2_in_atwakeup(w_dsp_ss2_noc_atwakeup),
    .dsp_ss2_out_atready(w_dsp_ss2_noc_atready),
    .dsp_ss2_out_afvalid(w_dsp_ss2_noc_afvalid),
    .dsp_ss2_out_syncreq(w_dsp_ss2_noc_syncreq),
    .dsp_ss3_in_atvalid(w_dsp_ss3_noc_atvalid),
    .dsp_ss3_in_atbytes(w_dsp_ss3_noc_atbytes),
    .dsp_ss3_in_atdata(w_dsp_ss3_noc_atdata),
    .dsp_ss3_in_atid(w_dsp_ss3_noc_atid),
    .dsp_ss3_in_afready(w_dsp_ss3_noc_afready),
    .dsp_ss3_in_atwakeup(w_dsp_ss3_noc_atwakeup),
    .dsp_ss3_out_atready(w_dsp_ss3_noc_atready),
    .dsp_ss3_out_afvalid(w_dsp_ss3_noc_afvalid),
    .dsp_ss3_out_syncreq(w_dsp_ss3_noc_syncreq),
    .dsp_ss4_in_atvalid(w_dsp_ss4_noc_atvalid),
    .dsp_ss4_in_atbytes(w_dsp_ss4_noc_atbytes),
    .dsp_ss4_in_atdata(w_dsp_ss4_noc_atdata),
    .dsp_ss4_in_atid(w_dsp_ss4_noc_atid),
    .dsp_ss4_in_afready(w_dsp_ss4_noc_afready),
    .dsp_ss4_in_atwakeup(w_dsp_ss4_noc_atwakeup),
    .dsp_ss4_out_atready(w_dsp_ss4_noc_atready),
    .dsp_ss4_out_afvalid(w_dsp_ss4_noc_afvalid),
    .dsp_ss4_out_syncreq(w_dsp_ss4_noc_syncreq),
    .dsp_ss5_in_atvalid(w_dsp_ss5_noc_atvalid),
    .dsp_ss5_in_atbytes(w_dsp_ss5_noc_atbytes),
    .dsp_ss5_in_atdata(w_dsp_ss5_noc_atdata),
    .dsp_ss5_in_atid(w_dsp_ss5_noc_atid),
    .dsp_ss5_in_afready(w_dsp_ss5_noc_afready),
    .dsp_ss5_in_atwakeup(w_dsp_ss5_noc_atwakeup),
    .dsp_ss5_out_atready(w_dsp_ss5_noc_atready),
    .dsp_ss5_out_afvalid(w_dsp_ss5_noc_afvalid),
    .dsp_ss5_out_syncreq(w_dsp_ss5_noc_syncreq),
    .camera_ss_in_atvalid(w_camera_ss_noc_atvalid),
    .camera_ss_in_atbytes(w_camera_ss_noc_atbytes),
    .camera_ss_in_atdata(w_camera_ss_noc_atdata),
    .camera_ss_in_atid(w_camera_ss_noc_atid),
    .camera_ss_in_afready(w_camera_ss_noc_afready),
    .camera_ss_in_atwakeup(w_camera_ss_noc_atwakeup),
    .camera_ss_out_atready(w_camera_ss_noc_atready),
    .camera_ss_out_afvalid(w_camera_ss_noc_afvalid),
    .camera_ss_out_syncreq(w_camera_ss_noc_syncreq),
    .mipi_ss_in_atvalid(w_mipi_ss_noc_atvalid),
    .mipi_ss_in_atbytes(w_mipi_ss_noc_atbytes),
    .mipi_ss_in_atdata(w_mipi_ss_noc_atdata),
    .mipi_ss_in_atid(w_mipi_ss_noc_atid),
    .mipi_ss_in_afready(w_mipi_ss_noc_afready),
    .mipi_ss_in_atwakeup(w_mipi_ss_noc_atwakeup),
    .mipi_ss_out_atready(w_mipi_ss_noc_atready),
    .mipi_ss_out_afvalid(w_mipi_ss_noc_afvalid),
    .mipi_ss_out_syncreq(w_mipi_ss_noc_syncreq),
    .debug_tniu_ss_out_atvalid(w_debug_tniu_ss_noc_atvalid),
    .debug_tniu_ss_out_atbytes(w_debug_tniu_ss_noc_atbytes),
    .debug_tniu_ss_out_atdata(w_debug_tniu_ss_noc_atdata),
    .debug_tniu_ss_out_atid(w_debug_tniu_ss_noc_atid),
    .debug_tniu_ss_out_afready(w_debug_tniu_ss_noc_afready),
    .debug_tniu_ss_out_atwakeup(w_debug_tniu_ss_noc_atwakeup),
    .debug_tniu_ss_in_atready(w_debug_tniu_ss_noc_atready),
    .debug_tniu_ss_in_afvalid(w_debug_tniu_ss_noc_afvalid),
    .debug_tniu_ss_in_syncreq(w_debug_tniu_ss_noc_syncreq),
    .left_funnel_pclkendbg(left_funnel_pclkendbg),
    .left_funnel_pseldbg(left_funnel_pseldbg),
    .left_funnel_penabledbg(left_funnel_penabledbg),
    .left_funnel_pwritedbg(left_funnel_pwritedbg),
    .left_funnel_paddrdbg31(left_funnel_paddrdbg31),
    .left_funnel_paddrdbg(left_funnel_paddrdbg),
    .left_funnel_pwdatadbg(left_funnel_pwdatadbg),
    .left_funnel_preadydbg(left_funnel_preadydbg),
    .left_funnel_pslverrdbg(left_funnel_pslverrdbg),
    .left_funnel_prdatadbg(left_funnel_prdatadbg),
    .camera_funnel_pclkendbg(camera_funnel_pclkendbg),
    .camera_funnel_pseldbg(camera_funnel_pseldbg),
    .camera_funnel_penabledbg(camera_funnel_penabledbg),
    .camera_funnel_pwritedbg(camera_funnel_pwritedbg),
    .camera_funnel_paddrdbg31(camera_funnel_paddrdbg31),
    .camera_funnel_paddrdbg(camera_funnel_paddrdbg),
    .camera_funnel_pwdatadbg(camera_funnel_pwdatadbg),
    .camera_funnel_preadydbg(camera_funnel_preadydbg),
    .camera_funnel_pslverrdbg(camera_funnel_pslverrdbg),
    .camera_funnel_prdatadbg(camera_funnel_prdatadbg),
    .right_funnel_pclkendbg(right_funnel_pclkendbg),
    .right_funnel_pseldbg(right_funnel_pseldbg),
    .right_funnel_penabledbg(right_funnel_penabledbg),
    .right_funnel_pwritedbg(right_funnel_pwritedbg),
    .right_funnel_paddrdbg31(right_funnel_paddrdbg31),
    .right_funnel_paddrdbg(right_funnel_paddrdbg),
    .right_funnel_pwdatadbg(right_funnel_pwdatadbg),
    .right_funnel_preadydbg(right_funnel_preadydbg),
    .right_funnel_pslverrdbg(right_funnel_pslverrdbg),
    .right_funnel_prdatadbg(right_funnel_prdatadbg)  
  );
endmodule

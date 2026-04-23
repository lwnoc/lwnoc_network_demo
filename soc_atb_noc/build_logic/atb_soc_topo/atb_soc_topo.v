// ATB SoC top-level publish wrapper.
// Per-SS sys-side payload is separated from noc-top assembly payload.
module atb_soc_topo (
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
  logic [138:0] w_dsp_ss0_noc_payload;
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
  logic [138:0] w_dsp_ss1_noc_payload;
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
  logic [138:0] w_dsp_ss2_noc_payload;
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
  logic [138:0] w_dsp_ss3_noc_payload;
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
  logic [138:0] w_dsp_ss4_noc_payload;
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
  logic [138:0] w_dsp_ss5_noc_payload;
  logic w_dsp_ss5_noc_atvalid;
  logic w_dsp_ss5_noc_atready;
  logic [3:0] w_dsp_ss5_noc_atbytes;
  logic [127:0] w_dsp_ss5_noc_atdata;
  logic [6:0] w_dsp_ss5_noc_atid;
  logic w_dsp_ss5_noc_afvalid;
  logic w_dsp_ss5_noc_afready;
  logic w_dsp_ss5_noc_syncreq;
  logic w_dsp_ss5_noc_atwakeup;
  logic w_camera_ss_sys_valid;
  logic [127:0] w_camera_ss_sys_data;
  logic w_camera_ss_noc_valid;
  logic [127:0] w_camera_ss_noc_data;
  logic [138:0] w_camera_ss_noc_payload;
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
  logic [138:0] w_mipi_ss_noc_payload;
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
  logic [138:0] w_debug_tniu_ss_noc_payload;
  logic w_debug_tniu_ss_sys_valid;
  logic [127:0] w_debug_tniu_ss_sys_data;
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
  assign w_dsp_ss0_noc_payload = {w_dsp_ss0_noc_atbytes, w_dsp_ss0_noc_atid, w_dsp_ss0_noc_atdata};

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
  assign w_dsp_ss1_noc_payload = {w_dsp_ss1_noc_atbytes, w_dsp_ss1_noc_atid, w_dsp_ss1_noc_atdata};

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
  assign w_dsp_ss2_noc_payload = {w_dsp_ss2_noc_atbytes, w_dsp_ss2_noc_atid, w_dsp_ss2_noc_atdata};

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
  assign w_dsp_ss3_noc_payload = {w_dsp_ss3_noc_atbytes, w_dsp_ss3_noc_atid, w_dsp_ss3_noc_atdata};

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
  assign w_dsp_ss4_noc_payload = {w_dsp_ss4_noc_atbytes, w_dsp_ss4_noc_atid, w_dsp_ss4_noc_atdata};

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
  assign w_dsp_ss5_noc_payload = {w_dsp_ss5_noc_atbytes, w_dsp_ss5_noc_atid, w_dsp_ss5_noc_atdata};

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
  assign w_camera_ss_noc_payload = {w_camera_ss_noc_atbytes, w_camera_ss_noc_atid, w_camera_ss_noc_atdata};

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
  assign w_mipi_ss_noc_payload = {w_mipi_ss_noc_atbytes, w_mipi_ss_noc_atid, w_mipi_ss_noc_atdata};

  assign w_debug_tniu_ss_noc_atvalid = w_debug_tniu_ss_noc_valid;
  assign {w_debug_tniu_ss_noc_atbytes, w_debug_tniu_ss_noc_atid, w_debug_tniu_ss_noc_atdata} = w_debug_tniu_ss_noc_payload;
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

  assign w_dsp_ss0_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss0_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss0_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_dsp_ss1_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss1_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss1_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_dsp_ss2_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss2_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss2_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_dsp_ss3_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss3_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss3_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_dsp_ss4_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss4_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss4_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_dsp_ss5_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_dsp_ss5_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_dsp_ss5_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_camera_ss_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_camera_ss_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_camera_ss_noc_syncreq = w_debug_tniu_ss_noc_syncreq;
  assign w_mipi_ss_noc_atready = w_debug_tniu_ss_noc_atready;
  assign w_mipi_ss_noc_afvalid = w_debug_tniu_ss_noc_afvalid;
  assign w_mipi_ss_noc_syncreq = w_debug_tniu_ss_noc_syncreq;

  atb_network_layer u_atb_network_layer (
    .clk_core(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .dsp_ss0_in_valid(w_dsp_ss0_noc_valid),
    .dsp_ss0_in_data(w_dsp_ss0_noc_payload),
    .dsp_ss1_in_valid(w_dsp_ss1_noc_valid),
    .dsp_ss1_in_data(w_dsp_ss1_noc_payload),
    .dsp_ss2_in_valid(w_dsp_ss2_noc_valid),
    .dsp_ss2_in_data(w_dsp_ss2_noc_payload),
    .dsp_ss3_in_valid(w_dsp_ss3_noc_valid),
    .dsp_ss3_in_data(w_dsp_ss3_noc_payload),
    .dsp_ss4_in_valid(w_dsp_ss4_noc_valid),
    .dsp_ss4_in_data(w_dsp_ss4_noc_payload),
    .dsp_ss5_in_valid(w_dsp_ss5_noc_valid),
    .dsp_ss5_in_data(w_dsp_ss5_noc_payload),
    .camera_ss_in_valid(w_camera_ss_noc_valid),
    .camera_ss_in_data(w_camera_ss_noc_payload),
    .mipi_ss_in_valid(w_mipi_ss_noc_valid),
    .mipi_ss_in_data(w_mipi_ss_noc_payload),
    .debug_tniu_ss_out_valid(w_debug_tniu_ss_noc_valid),
    .debug_tniu_ss_out_data(w_debug_tniu_ss_noc_payload)
  );
endmodule

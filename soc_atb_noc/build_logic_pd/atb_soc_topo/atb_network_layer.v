// ATB network layer assembly for noc-top publication.
module atb_network_layer (
  input logic clk_core,
  input logic clk_async,
  input logic rst_core_n,
  input logic rst_async_n,
  input  logic          dsp_ss0_in_atvalid,
  input  logic [3:0]   dsp_ss0_in_atbytes,
  input  logic [127:0] dsp_ss0_in_atdata,
  input  logic [6:0]   dsp_ss0_in_atid,
  input  logic          dsp_ss0_in_afready,
  input  logic          dsp_ss0_in_atwakeup,
  output logic          dsp_ss0_out_atready,
  output logic          dsp_ss0_out_afvalid,
  output logic          dsp_ss0_out_syncreq,
  input  logic          dsp_ss1_in_atvalid,
  input  logic [3:0]   dsp_ss1_in_atbytes,
  input  logic [127:0] dsp_ss1_in_atdata,
  input  logic [6:0]   dsp_ss1_in_atid,
  input  logic          dsp_ss1_in_afready,
  input  logic          dsp_ss1_in_atwakeup,
  output logic          dsp_ss1_out_atready,
  output logic          dsp_ss1_out_afvalid,
  output logic          dsp_ss1_out_syncreq,
  input  logic          dsp_ss2_in_atvalid,
  input  logic [3:0]   dsp_ss2_in_atbytes,
  input  logic [127:0] dsp_ss2_in_atdata,
  input  logic [6:0]   dsp_ss2_in_atid,
  input  logic          dsp_ss2_in_afready,
  input  logic          dsp_ss2_in_atwakeup,
  output logic          dsp_ss2_out_atready,
  output logic          dsp_ss2_out_afvalid,
  output logic          dsp_ss2_out_syncreq,
  input  logic          dsp_ss3_in_atvalid,
  input  logic [3:0]   dsp_ss3_in_atbytes,
  input  logic [127:0] dsp_ss3_in_atdata,
  input  logic [6:0]   dsp_ss3_in_atid,
  input  logic          dsp_ss3_in_afready,
  input  logic          dsp_ss3_in_atwakeup,
  output logic          dsp_ss3_out_atready,
  output logic          dsp_ss3_out_afvalid,
  output logic          dsp_ss3_out_syncreq,
  input  logic          dsp_ss4_in_atvalid,
  input  logic [3:0]   dsp_ss4_in_atbytes,
  input  logic [127:0] dsp_ss4_in_atdata,
  input  logic [6:0]   dsp_ss4_in_atid,
  input  logic          dsp_ss4_in_afready,
  input  logic          dsp_ss4_in_atwakeup,
  output logic          dsp_ss4_out_atready,
  output logic          dsp_ss4_out_afvalid,
  output logic          dsp_ss4_out_syncreq,
  input  logic          dsp_ss5_in_atvalid,
  input  logic [3:0]   dsp_ss5_in_atbytes,
  input  logic [127:0] dsp_ss5_in_atdata,
  input  logic [6:0]   dsp_ss5_in_atid,
  input  logic          dsp_ss5_in_afready,
  input  logic          dsp_ss5_in_atwakeup,
  output logic          dsp_ss5_out_atready,
  output logic          dsp_ss5_out_afvalid,
  output logic          dsp_ss5_out_syncreq,
  input  logic          camera_ss_in_atvalid,
  input  logic [3:0]   camera_ss_in_atbytes,
  input  logic [127:0] camera_ss_in_atdata,
  input  logic [6:0]   camera_ss_in_atid,
  input  logic          camera_ss_in_afready,
  input  logic          camera_ss_in_atwakeup,
  output logic          camera_ss_out_atready,
  output logic          camera_ss_out_afvalid,
  output logic          camera_ss_out_syncreq,
  input  logic          mipi_ss_in_atvalid,
  input  logic [3:0]   mipi_ss_in_atbytes,
  input  logic [127:0] mipi_ss_in_atdata,
  input  logic [6:0]   mipi_ss_in_atid,
  input  logic          mipi_ss_in_afready,
  input  logic          mipi_ss_in_atwakeup,
  output logic          mipi_ss_out_atready,
  output logic          mipi_ss_out_afvalid,
  output logic          mipi_ss_out_syncreq,
  output logic          debug_tniu_ss_out_atvalid,
  output logic [3:0]   debug_tniu_ss_out_atbytes,
  output logic [127:0] debug_tniu_ss_out_atdata,
  output logic [6:0]   debug_tniu_ss_out_atid,
  output logic          debug_tniu_ss_out_afready,
  output logic          debug_tniu_ss_out_atwakeup,
  input  logic          debug_tniu_ss_in_atready,
  input  logic          debug_tniu_ss_in_afvalid,
  input  logic          debug_tniu_ss_in_syncreq,
  input  logic          left_funnel_pclkendbg,
  input  logic          left_funnel_pseldbg,
  input  logic          left_funnel_penabledbg,
  input  logic          left_funnel_pwritedbg,
  input  logic          left_funnel_paddrdbg31,
  input  logic [9:0]    left_funnel_paddrdbg,
  input  logic [31:0]   left_funnel_pwdatadbg,
  output logic          left_funnel_preadydbg,
  output logic          left_funnel_pslverrdbg,
  output logic [31:0]   left_funnel_prdatadbg,
  input  logic          camera_funnel_pclkendbg,
  input  logic          camera_funnel_pseldbg,
  input  logic          camera_funnel_penabledbg,
  input  logic          camera_funnel_pwritedbg,
  input  logic          camera_funnel_paddrdbg31,
  input  logic [9:0]    camera_funnel_paddrdbg,
  input  logic [31:0]   camera_funnel_pwdatadbg,
  output logic          camera_funnel_preadydbg,
  output logic          camera_funnel_pslverrdbg,
  output logic [31:0]   camera_funnel_prdatadbg,
  input  logic          right_funnel_pclkendbg,
  input  logic          right_funnel_pseldbg,
  input  logic          right_funnel_penabledbg,
  input  logic          right_funnel_pwritedbg,
  input  logic          right_funnel_paddrdbg31,
  input  logic [9:0]    right_funnel_paddrdbg,
  input  logic [31:0]   right_funnel_pwdatadbg,
  output logic          right_funnel_preadydbg,
  output logic          right_funnel_pslverrdbg,
  output logic [31:0]   right_funnel_prdatadbg  
);

  // Topology edge wires: full ATB protocol per source-to-destination connection.
  logic w_dsp_ss0_to_left_funnel_atvalid;
  logic w_dsp_ss0_to_left_funnel_atready;
  logic [3:0] w_dsp_ss0_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss0_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss0_to_left_funnel_atid;
  logic w_dsp_ss0_to_left_funnel_afvalid;
  logic w_dsp_ss0_to_left_funnel_afready;
  logic w_dsp_ss0_to_left_funnel_syncreq;
  logic w_dsp_ss0_to_left_funnel_atwakeup;
  logic w_dsp_ss1_to_left_funnel_atvalid;
  logic w_dsp_ss1_to_left_funnel_atready;
  logic [3:0] w_dsp_ss1_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss1_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss1_to_left_funnel_atid;
  logic w_dsp_ss1_to_left_funnel_afvalid;
  logic w_dsp_ss1_to_left_funnel_afready;
  logic w_dsp_ss1_to_left_funnel_syncreq;
  logic w_dsp_ss1_to_left_funnel_atwakeup;
  logic w_dsp_ss2_to_left_funnel_atvalid;
  logic w_dsp_ss2_to_left_funnel_atready;
  logic [3:0] w_dsp_ss2_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss2_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss2_to_left_funnel_atid;
  logic w_dsp_ss2_to_left_funnel_afvalid;
  logic w_dsp_ss2_to_left_funnel_afready;
  logic w_dsp_ss2_to_left_funnel_syncreq;
  logic w_dsp_ss2_to_left_funnel_atwakeup;
  logic w_dsp_ss3_to_left_funnel_atvalid;
  logic w_dsp_ss3_to_left_funnel_atready;
  logic [3:0] w_dsp_ss3_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss3_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss3_to_left_funnel_atid;
  logic w_dsp_ss3_to_left_funnel_afvalid;
  logic w_dsp_ss3_to_left_funnel_afready;
  logic w_dsp_ss3_to_left_funnel_syncreq;
  logic w_dsp_ss3_to_left_funnel_atwakeup;
  logic w_dsp_ss4_to_left_funnel_atvalid;
  logic w_dsp_ss4_to_left_funnel_atready;
  logic [3:0] w_dsp_ss4_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss4_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss4_to_left_funnel_atid;
  logic w_dsp_ss4_to_left_funnel_afvalid;
  logic w_dsp_ss4_to_left_funnel_afready;
  logic w_dsp_ss4_to_left_funnel_syncreq;
  logic w_dsp_ss4_to_left_funnel_atwakeup;
  logic w_dsp_ss5_to_left_funnel_atvalid;
  logic w_dsp_ss5_to_left_funnel_atready;
  logic [3:0] w_dsp_ss5_to_left_funnel_atbytes;
  logic [127:0] w_dsp_ss5_to_left_funnel_atdata;
  logic [6:0] w_dsp_ss5_to_left_funnel_atid;
  logic w_dsp_ss5_to_left_funnel_afvalid;
  logic w_dsp_ss5_to_left_funnel_afready;
  logic w_dsp_ss5_to_left_funnel_syncreq;
  logic w_dsp_ss5_to_left_funnel_atwakeup;
  logic w_camera_ss_to_camera_funnel_atvalid;
  logic w_camera_ss_to_camera_funnel_atready;
  logic [3:0] w_camera_ss_to_camera_funnel_atbytes;
  logic [127:0] w_camera_ss_to_camera_funnel_atdata;
  logic [6:0] w_camera_ss_to_camera_funnel_atid;
  logic w_camera_ss_to_camera_funnel_afvalid;
  logic w_camera_ss_to_camera_funnel_afready;
  logic w_camera_ss_to_camera_funnel_syncreq;
  logic w_camera_ss_to_camera_funnel_atwakeup;
  logic w_mipi_ss_to_camera_funnel_atvalid;
  logic w_mipi_ss_to_camera_funnel_atready;
  logic [3:0] w_mipi_ss_to_camera_funnel_atbytes;
  logic [127:0] w_mipi_ss_to_camera_funnel_atdata;
  logic [6:0] w_mipi_ss_to_camera_funnel_atid;
  logic w_mipi_ss_to_camera_funnel_afvalid;
  logic w_mipi_ss_to_camera_funnel_afready;
  logic w_mipi_ss_to_camera_funnel_syncreq;
  logic w_mipi_ss_to_camera_funnel_atwakeup;
  logic w_left_funnel_to_async_bridge_slv_atvalid;
  logic w_left_funnel_to_async_bridge_slv_atready;
  logic [3:0] w_left_funnel_to_async_bridge_slv_atbytes;
  logic [127:0] w_left_funnel_to_async_bridge_slv_atdata;
  logic [6:0] w_left_funnel_to_async_bridge_slv_atid;
  logic w_left_funnel_to_async_bridge_slv_afvalid;
  logic w_left_funnel_to_async_bridge_slv_afready;
  logic w_left_funnel_to_async_bridge_slv_syncreq;
  logic w_left_funnel_to_async_bridge_slv_atwakeup;
  logic w_async_bridge_slv_to_async_bridge_mst_atvalid;
  logic w_async_bridge_slv_to_async_bridge_mst_atready;
  logic [3:0] w_async_bridge_slv_to_async_bridge_mst_atbytes;
  logic [127:0] w_async_bridge_slv_to_async_bridge_mst_atdata;
  logic [6:0] w_async_bridge_slv_to_async_bridge_mst_atid;
  logic w_async_bridge_slv_to_async_bridge_mst_afvalid;
  logic w_async_bridge_slv_to_async_bridge_mst_afready;
  logic w_async_bridge_slv_to_async_bridge_mst_syncreq;
  logic w_async_bridge_slv_to_async_bridge_mst_atwakeup;
  logic w_async_bridge_mst_to_right_funnel_atvalid;
  logic w_async_bridge_mst_to_right_funnel_atready;
  logic [3:0] w_async_bridge_mst_to_right_funnel_atbytes;
  logic [127:0] w_async_bridge_mst_to_right_funnel_atdata;
  logic [6:0] w_async_bridge_mst_to_right_funnel_atid;
  logic w_async_bridge_mst_to_right_funnel_afvalid;
  logic w_async_bridge_mst_to_right_funnel_afready;
  logic w_async_bridge_mst_to_right_funnel_syncreq;
  logic w_async_bridge_mst_to_right_funnel_atwakeup;
  logic w_camera_funnel_to_right_funnel_atvalid;
  logic w_camera_funnel_to_right_funnel_atready;
  logic [3:0] w_camera_funnel_to_right_funnel_atbytes;
  logic [127:0] w_camera_funnel_to_right_funnel_atdata;
  logic [6:0] w_camera_funnel_to_right_funnel_atid;
  logic w_camera_funnel_to_right_funnel_afvalid;
  logic w_camera_funnel_to_right_funnel_afready;
  logic w_camera_funnel_to_right_funnel_syncreq;
  logic w_camera_funnel_to_right_funnel_atwakeup;
  logic w_right_funnel_to_debug_tniu_ss_atvalid;
  logic w_right_funnel_to_debug_tniu_ss_atready;
  logic [3:0] w_right_funnel_to_debug_tniu_ss_atbytes;
  logic [127:0] w_right_funnel_to_debug_tniu_ss_atdata;
  logic [6:0] w_right_funnel_to_debug_tniu_ss_atid;
  logic w_right_funnel_to_debug_tniu_ss_afvalid;
  logic w_right_funnel_to_debug_tniu_ss_afready;
  logic w_right_funnel_to_debug_tniu_ss_syncreq;
  logic w_right_funnel_to_debug_tniu_ss_atwakeup;

  assign w_dsp_ss0_to_left_funnel_atvalid = dsp_ss0_in_atvalid;
  assign w_dsp_ss0_to_left_funnel_atbytes = dsp_ss0_in_atbytes;
  assign w_dsp_ss0_to_left_funnel_atdata = dsp_ss0_in_atdata;
  assign w_dsp_ss0_to_left_funnel_atid = dsp_ss0_in_atid;
  assign w_dsp_ss0_to_left_funnel_afready = dsp_ss0_in_afready;
  assign w_dsp_ss0_to_left_funnel_atwakeup = dsp_ss0_in_atwakeup;
  assign dsp_ss0_out_atready = w_dsp_ss0_to_left_funnel_atready;
  assign dsp_ss0_out_afvalid = w_dsp_ss0_to_left_funnel_afvalid;
  assign dsp_ss0_out_syncreq = w_dsp_ss0_to_left_funnel_syncreq;
  assign w_dsp_ss1_to_left_funnel_atvalid = dsp_ss1_in_atvalid;
  assign w_dsp_ss1_to_left_funnel_atbytes = dsp_ss1_in_atbytes;
  assign w_dsp_ss1_to_left_funnel_atdata = dsp_ss1_in_atdata;
  assign w_dsp_ss1_to_left_funnel_atid = dsp_ss1_in_atid;
  assign w_dsp_ss1_to_left_funnel_afready = dsp_ss1_in_afready;
  assign w_dsp_ss1_to_left_funnel_atwakeup = dsp_ss1_in_atwakeup;
  assign dsp_ss1_out_atready = w_dsp_ss1_to_left_funnel_atready;
  assign dsp_ss1_out_afvalid = w_dsp_ss1_to_left_funnel_afvalid;
  assign dsp_ss1_out_syncreq = w_dsp_ss1_to_left_funnel_syncreq;
  assign w_dsp_ss2_to_left_funnel_atvalid = dsp_ss2_in_atvalid;
  assign w_dsp_ss2_to_left_funnel_atbytes = dsp_ss2_in_atbytes;
  assign w_dsp_ss2_to_left_funnel_atdata = dsp_ss2_in_atdata;
  assign w_dsp_ss2_to_left_funnel_atid = dsp_ss2_in_atid;
  assign w_dsp_ss2_to_left_funnel_afready = dsp_ss2_in_afready;
  assign w_dsp_ss2_to_left_funnel_atwakeup = dsp_ss2_in_atwakeup;
  assign dsp_ss2_out_atready = w_dsp_ss2_to_left_funnel_atready;
  assign dsp_ss2_out_afvalid = w_dsp_ss2_to_left_funnel_afvalid;
  assign dsp_ss2_out_syncreq = w_dsp_ss2_to_left_funnel_syncreq;
  assign w_dsp_ss3_to_left_funnel_atvalid = dsp_ss3_in_atvalid;
  assign w_dsp_ss3_to_left_funnel_atbytes = dsp_ss3_in_atbytes;
  assign w_dsp_ss3_to_left_funnel_atdata = dsp_ss3_in_atdata;
  assign w_dsp_ss3_to_left_funnel_atid = dsp_ss3_in_atid;
  assign w_dsp_ss3_to_left_funnel_afready = dsp_ss3_in_afready;
  assign w_dsp_ss3_to_left_funnel_atwakeup = dsp_ss3_in_atwakeup;
  assign dsp_ss3_out_atready = w_dsp_ss3_to_left_funnel_atready;
  assign dsp_ss3_out_afvalid = w_dsp_ss3_to_left_funnel_afvalid;
  assign dsp_ss3_out_syncreq = w_dsp_ss3_to_left_funnel_syncreq;
  assign w_dsp_ss4_to_left_funnel_atvalid = dsp_ss4_in_atvalid;
  assign w_dsp_ss4_to_left_funnel_atbytes = dsp_ss4_in_atbytes;
  assign w_dsp_ss4_to_left_funnel_atdata = dsp_ss4_in_atdata;
  assign w_dsp_ss4_to_left_funnel_atid = dsp_ss4_in_atid;
  assign w_dsp_ss4_to_left_funnel_afready = dsp_ss4_in_afready;
  assign w_dsp_ss4_to_left_funnel_atwakeup = dsp_ss4_in_atwakeup;
  assign dsp_ss4_out_atready = w_dsp_ss4_to_left_funnel_atready;
  assign dsp_ss4_out_afvalid = w_dsp_ss4_to_left_funnel_afvalid;
  assign dsp_ss4_out_syncreq = w_dsp_ss4_to_left_funnel_syncreq;
  assign w_dsp_ss5_to_left_funnel_atvalid = dsp_ss5_in_atvalid;
  assign w_dsp_ss5_to_left_funnel_atbytes = dsp_ss5_in_atbytes;
  assign w_dsp_ss5_to_left_funnel_atdata = dsp_ss5_in_atdata;
  assign w_dsp_ss5_to_left_funnel_atid = dsp_ss5_in_atid;
  assign w_dsp_ss5_to_left_funnel_afready = dsp_ss5_in_afready;
  assign w_dsp_ss5_to_left_funnel_atwakeup = dsp_ss5_in_atwakeup;
  assign dsp_ss5_out_atready = w_dsp_ss5_to_left_funnel_atready;
  assign dsp_ss5_out_afvalid = w_dsp_ss5_to_left_funnel_afvalid;
  assign dsp_ss5_out_syncreq = w_dsp_ss5_to_left_funnel_syncreq;
  assign w_camera_ss_to_camera_funnel_atvalid = camera_ss_in_atvalid;
  assign w_camera_ss_to_camera_funnel_atbytes = camera_ss_in_atbytes;
  assign w_camera_ss_to_camera_funnel_atdata = camera_ss_in_atdata;
  assign w_camera_ss_to_camera_funnel_atid = camera_ss_in_atid;
  assign w_camera_ss_to_camera_funnel_afready = camera_ss_in_afready;
  assign w_camera_ss_to_camera_funnel_atwakeup = camera_ss_in_atwakeup;
  assign camera_ss_out_atready = w_camera_ss_to_camera_funnel_atready;
  assign camera_ss_out_afvalid = w_camera_ss_to_camera_funnel_afvalid;
  assign camera_ss_out_syncreq = w_camera_ss_to_camera_funnel_syncreq;
  assign w_mipi_ss_to_camera_funnel_atvalid = mipi_ss_in_atvalid;
  assign w_mipi_ss_to_camera_funnel_atbytes = mipi_ss_in_atbytes;
  assign w_mipi_ss_to_camera_funnel_atdata = mipi_ss_in_atdata;
  assign w_mipi_ss_to_camera_funnel_atid = mipi_ss_in_atid;
  assign w_mipi_ss_to_camera_funnel_afready = mipi_ss_in_afready;
  assign w_mipi_ss_to_camera_funnel_atwakeup = mipi_ss_in_atwakeup;
  assign mipi_ss_out_atready = w_mipi_ss_to_camera_funnel_atready;
  assign mipi_ss_out_afvalid = w_mipi_ss_to_camera_funnel_afvalid;
  assign mipi_ss_out_syncreq = w_mipi_ss_to_camera_funnel_syncreq;
  assign debug_tniu_ss_out_atvalid = w_right_funnel_to_debug_tniu_ss_atvalid;
  assign debug_tniu_ss_out_atbytes = w_right_funnel_to_debug_tniu_ss_atbytes;
  assign debug_tniu_ss_out_atdata = w_right_funnel_to_debug_tniu_ss_atdata;
  assign debug_tniu_ss_out_atid = w_right_funnel_to_debug_tniu_ss_atid;
  assign debug_tniu_ss_out_afready = w_right_funnel_to_debug_tniu_ss_afready;
  assign debug_tniu_ss_out_atwakeup = w_right_funnel_to_debug_tniu_ss_atwakeup;
  assign w_right_funnel_to_debug_tniu_ss_atready = debug_tniu_ss_in_atready;
  assign w_right_funnel_to_debug_tniu_ss_afvalid = debug_tniu_ss_in_afvalid;
  assign w_right_funnel_to_debug_tniu_ss_syncreq = debug_tniu_ss_in_syncreq;

  // Generated topology instances
  // async_bridge_slv: direct upstream atb_async_bridge_top; exposes full ATB protocol.
  atb_async_bridge_top #(.ATB_DATA_WIDTH(128), .ATB_ID_WIDTH(7)) u_async_bridge_slv (
    .clk_atb_s(clk_core),
    .rstn_atb_s(rst_core_n),
    .s_atvalid(w_left_funnel_to_async_bridge_slv_atvalid),
    .s_atready(w_left_funnel_to_async_bridge_slv_atready),
    .s_atbytes(w_left_funnel_to_async_bridge_slv_atbytes),
    .s_atdata(w_left_funnel_to_async_bridge_slv_atdata),
    .s_atid(w_left_funnel_to_async_bridge_slv_atid),
    .s_afvalid(w_left_funnel_to_async_bridge_slv_afvalid),
    .s_afready(w_left_funnel_to_async_bridge_slv_afready),
    .s_syncreq(w_left_funnel_to_async_bridge_slv_syncreq),
    .s_atwakeup(w_left_funnel_to_async_bridge_slv_atwakeup),
    .slv_full_zero(),
    .clk_atb_m(clk_async),
    .rstn_atb_m(rst_async_n),
    .m_atvalid(w_async_bridge_slv_to_async_bridge_mst_atvalid),
    .m_atready(w_async_bridge_slv_to_async_bridge_mst_atready),
    .m_atbytes(w_async_bridge_slv_to_async_bridge_mst_atbytes),
    .m_atdata(w_async_bridge_slv_to_async_bridge_mst_atdata),
    .m_atid(w_async_bridge_slv_to_async_bridge_mst_atid),
    .m_afvalid(w_async_bridge_slv_to_async_bridge_mst_afvalid),
    .m_afready(w_async_bridge_slv_to_async_bridge_mst_afready),
    .m_syncreq(w_async_bridge_slv_to_async_bridge_mst_syncreq),
    .m_atwakeup(w_async_bridge_slv_to_async_bridge_mst_atwakeup),
    .mst_full_zero(),
    .mst_read_idle()
  );

  // async_bridge_mst: direct upstream atb_async_bridge_top; exposes full ATB protocol.
  atb_async_bridge_top #(.ATB_DATA_WIDTH(128), .ATB_ID_WIDTH(7)) u_async_bridge_mst (
    .clk_atb_s(clk_async),
    .rstn_atb_s(rst_async_n),
    .s_atvalid(w_async_bridge_slv_to_async_bridge_mst_atvalid),
    .s_atready(w_async_bridge_slv_to_async_bridge_mst_atready),
    .s_atbytes(w_async_bridge_slv_to_async_bridge_mst_atbytes),
    .s_atdata(w_async_bridge_slv_to_async_bridge_mst_atdata),
    .s_atid(w_async_bridge_slv_to_async_bridge_mst_atid),
    .s_afvalid(w_async_bridge_slv_to_async_bridge_mst_afvalid),
    .s_afready(w_async_bridge_slv_to_async_bridge_mst_afready),
    .s_syncreq(w_async_bridge_slv_to_async_bridge_mst_syncreq),
    .s_atwakeup(w_async_bridge_slv_to_async_bridge_mst_atwakeup),
    .slv_full_zero(),
    .clk_atb_m(clk_async),
    .rstn_atb_m(rst_async_n),
    .m_atvalid(w_async_bridge_mst_to_right_funnel_atvalid),
    .m_atready(w_async_bridge_mst_to_right_funnel_atready),
    .m_atbytes(w_async_bridge_mst_to_right_funnel_atbytes),
    .m_atdata(w_async_bridge_mst_to_right_funnel_atdata),
    .m_atid(w_async_bridge_mst_to_right_funnel_atid),
    .m_afvalid(w_async_bridge_mst_to_right_funnel_afvalid),
    .m_afready(w_async_bridge_mst_to_right_funnel_afready),
    .m_syncreq(w_async_bridge_mst_to_right_funnel_syncreq),
    .m_atwakeup(w_async_bridge_mst_to_right_funnel_atwakeup),
    .mst_full_zero(),
    .mst_read_idle()
  );

  // left_funnel: direct upstream atb_funnel; exposes full ATB protocol.
  logic [5:0] w_left_funnel_atvalids;
  logic [5:0] w_left_funnel_afreadys;
  logic [5:0][6:0] w_left_funnel_atids;
  logic [5:0][127:0] w_left_funnel_atdatas;
  logic [5:0][3:0] w_left_funnel_atbytess;
  logic [5:0] w_left_funnel_atreadys;
  logic [5:0] w_left_funnel_afvalids;
  logic [5:0] w_left_funnel_syncreqs;
  assign w_left_funnel_atvalids[0] = w_dsp_ss0_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[0] = w_dsp_ss0_to_left_funnel_afready;
  assign w_left_funnel_atids[0] = w_dsp_ss0_to_left_funnel_atid;
  assign w_left_funnel_atdatas[0] = w_dsp_ss0_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[0] = w_dsp_ss0_to_left_funnel_atbytes;
  assign w_dsp_ss0_to_left_funnel_atready = w_left_funnel_atreadys[0];
  assign w_dsp_ss0_to_left_funnel_afvalid = w_left_funnel_afvalids[0];
  assign w_dsp_ss0_to_left_funnel_syncreq = w_left_funnel_syncreqs[0];
  assign w_left_funnel_atvalids[1] = w_dsp_ss1_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[1] = w_dsp_ss1_to_left_funnel_afready;
  assign w_left_funnel_atids[1] = w_dsp_ss1_to_left_funnel_atid;
  assign w_left_funnel_atdatas[1] = w_dsp_ss1_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[1] = w_dsp_ss1_to_left_funnel_atbytes;
  assign w_dsp_ss1_to_left_funnel_atready = w_left_funnel_atreadys[1];
  assign w_dsp_ss1_to_left_funnel_afvalid = w_left_funnel_afvalids[1];
  assign w_dsp_ss1_to_left_funnel_syncreq = w_left_funnel_syncreqs[1];
  assign w_left_funnel_atvalids[2] = w_dsp_ss2_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[2] = w_dsp_ss2_to_left_funnel_afready;
  assign w_left_funnel_atids[2] = w_dsp_ss2_to_left_funnel_atid;
  assign w_left_funnel_atdatas[2] = w_dsp_ss2_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[2] = w_dsp_ss2_to_left_funnel_atbytes;
  assign w_dsp_ss2_to_left_funnel_atready = w_left_funnel_atreadys[2];
  assign w_dsp_ss2_to_left_funnel_afvalid = w_left_funnel_afvalids[2];
  assign w_dsp_ss2_to_left_funnel_syncreq = w_left_funnel_syncreqs[2];
  assign w_left_funnel_atvalids[3] = w_dsp_ss3_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[3] = w_dsp_ss3_to_left_funnel_afready;
  assign w_left_funnel_atids[3] = w_dsp_ss3_to_left_funnel_atid;
  assign w_left_funnel_atdatas[3] = w_dsp_ss3_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[3] = w_dsp_ss3_to_left_funnel_atbytes;
  assign w_dsp_ss3_to_left_funnel_atready = w_left_funnel_atreadys[3];
  assign w_dsp_ss3_to_left_funnel_afvalid = w_left_funnel_afvalids[3];
  assign w_dsp_ss3_to_left_funnel_syncreq = w_left_funnel_syncreqs[3];
  assign w_left_funnel_atvalids[4] = w_dsp_ss4_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[4] = w_dsp_ss4_to_left_funnel_afready;
  assign w_left_funnel_atids[4] = w_dsp_ss4_to_left_funnel_atid;
  assign w_left_funnel_atdatas[4] = w_dsp_ss4_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[4] = w_dsp_ss4_to_left_funnel_atbytes;
  assign w_dsp_ss4_to_left_funnel_atready = w_left_funnel_atreadys[4];
  assign w_dsp_ss4_to_left_funnel_afvalid = w_left_funnel_afvalids[4];
  assign w_dsp_ss4_to_left_funnel_syncreq = w_left_funnel_syncreqs[4];
  assign w_left_funnel_atvalids[5] = w_dsp_ss5_to_left_funnel_atvalid;
  assign w_left_funnel_afreadys[5] = w_dsp_ss5_to_left_funnel_afready;
  assign w_left_funnel_atids[5] = w_dsp_ss5_to_left_funnel_atid;
  assign w_left_funnel_atdatas[5] = w_dsp_ss5_to_left_funnel_atdata;
  assign w_left_funnel_atbytess[5] = w_dsp_ss5_to_left_funnel_atbytes;
  assign w_dsp_ss5_to_left_funnel_atready = w_left_funnel_atreadys[5];
  assign w_dsp_ss5_to_left_funnel_afvalid = w_left_funnel_afvalids[5];
  assign w_dsp_ss5_to_left_funnel_syncreq = w_left_funnel_syncreqs[5];
  atb_funnel #(.ATB_DATA_WIDTH(128), .ATB_ID_WIDTH(7), .N_ATB(6)) u_left_funnel (
    .clk(clk_core),
    .resetn(rst_core_n),
    .pclkendbg(left_funnel_pclkendbg),
    .pseldbg(left_funnel_pseldbg),
    .penabledbg(left_funnel_penabledbg),
    .pwritedbg(left_funnel_pwritedbg),
    .paddrdbg31(left_funnel_paddrdbg31),
    .paddrdbg(left_funnel_paddrdbg),
    .pwdatadbg(left_funnel_pwdatadbg),
    .atvalids(w_left_funnel_atvalids),
    .afreadys(w_left_funnel_afreadys),
    .atids(w_left_funnel_atids),
    .atdatas(w_left_funnel_atdatas),
    .atbytess(w_left_funnel_atbytess),
    .atreadym(w_left_funnel_to_async_bridge_slv_atready),
    .afvalidm(w_left_funnel_to_async_bridge_slv_afvalid),
    .syncreqm(w_left_funnel_to_async_bridge_slv_syncreq),
    .atvalidm(w_left_funnel_to_async_bridge_slv_atvalid),
    .afreadym(w_left_funnel_to_async_bridge_slv_afready),
    .atidm(w_left_funnel_to_async_bridge_slv_atid),
    .atdatam(w_left_funnel_to_async_bridge_slv_atdata),
    .atbytesm(w_left_funnel_to_async_bridge_slv_atbytes),
    .atreadys(w_left_funnel_atreadys),
    .afvalids(w_left_funnel_afvalids),
    .syncreqs(w_left_funnel_syncreqs),
    .preadydbg(left_funnel_preadydbg),
    .pslverrdbg(left_funnel_pslverrdbg),
    .prdatadbg(left_funnel_prdatadbg)
  );

  // camera_funnel: direct upstream atb_funnel; exposes full ATB protocol.
  logic [1:0] w_camera_funnel_atvalids;
  logic [1:0] w_camera_funnel_afreadys;
  logic [1:0][6:0] w_camera_funnel_atids;
  logic [1:0][127:0] w_camera_funnel_atdatas;
  logic [1:0][3:0] w_camera_funnel_atbytess;
  logic [1:0] w_camera_funnel_atreadys;
  logic [1:0] w_camera_funnel_afvalids;
  logic [1:0] w_camera_funnel_syncreqs;
  assign w_camera_funnel_atvalids[0] = w_camera_ss_to_camera_funnel_atvalid;
  assign w_camera_funnel_afreadys[0] = w_camera_ss_to_camera_funnel_afready;
  assign w_camera_funnel_atids[0] = w_camera_ss_to_camera_funnel_atid;
  assign w_camera_funnel_atdatas[0] = w_camera_ss_to_camera_funnel_atdata;
  assign w_camera_funnel_atbytess[0] = w_camera_ss_to_camera_funnel_atbytes;
  assign w_camera_ss_to_camera_funnel_atready = w_camera_funnel_atreadys[0];
  assign w_camera_ss_to_camera_funnel_afvalid = w_camera_funnel_afvalids[0];
  assign w_camera_ss_to_camera_funnel_syncreq = w_camera_funnel_syncreqs[0];
  assign w_camera_funnel_atvalids[1] = w_mipi_ss_to_camera_funnel_atvalid;
  assign w_camera_funnel_afreadys[1] = w_mipi_ss_to_camera_funnel_afready;
  assign w_camera_funnel_atids[1] = w_mipi_ss_to_camera_funnel_atid;
  assign w_camera_funnel_atdatas[1] = w_mipi_ss_to_camera_funnel_atdata;
  assign w_camera_funnel_atbytess[1] = w_mipi_ss_to_camera_funnel_atbytes;
  assign w_mipi_ss_to_camera_funnel_atready = w_camera_funnel_atreadys[1];
  assign w_mipi_ss_to_camera_funnel_afvalid = w_camera_funnel_afvalids[1];
  assign w_mipi_ss_to_camera_funnel_syncreq = w_camera_funnel_syncreqs[1];
  atb_funnel #(.ATB_DATA_WIDTH(128), .ATB_ID_WIDTH(7), .N_ATB(2)) u_camera_funnel (
    .clk(clk_async),
    .resetn(rst_async_n),
    .pclkendbg(camera_funnel_pclkendbg),
    .pseldbg(camera_funnel_pseldbg),
    .penabledbg(camera_funnel_penabledbg),
    .pwritedbg(camera_funnel_pwritedbg),
    .paddrdbg31(camera_funnel_paddrdbg31),
    .paddrdbg(camera_funnel_paddrdbg),
    .pwdatadbg(camera_funnel_pwdatadbg),
    .atvalids(w_camera_funnel_atvalids),
    .afreadys(w_camera_funnel_afreadys),
    .atids(w_camera_funnel_atids),
    .atdatas(w_camera_funnel_atdatas),
    .atbytess(w_camera_funnel_atbytess),
    .atreadym(w_camera_funnel_to_right_funnel_atready),
    .afvalidm(w_camera_funnel_to_right_funnel_afvalid),
    .syncreqm(w_camera_funnel_to_right_funnel_syncreq),
    .atvalidm(w_camera_funnel_to_right_funnel_atvalid),
    .afreadym(w_camera_funnel_to_right_funnel_afready),
    .atidm(w_camera_funnel_to_right_funnel_atid),
    .atdatam(w_camera_funnel_to_right_funnel_atdata),
    .atbytesm(w_camera_funnel_to_right_funnel_atbytes),
    .atreadys(w_camera_funnel_atreadys),
    .afvalids(w_camera_funnel_afvalids),
    .syncreqs(w_camera_funnel_syncreqs),
    .preadydbg(camera_funnel_preadydbg),
    .pslverrdbg(camera_funnel_pslverrdbg),
    .prdatadbg(camera_funnel_prdatadbg)
  );

  // right_funnel: direct upstream atb_funnel; exposes full ATB protocol.
  logic [1:0] w_right_funnel_atvalids;
  logic [1:0] w_right_funnel_afreadys;
  logic [1:0][6:0] w_right_funnel_atids;
  logic [1:0][127:0] w_right_funnel_atdatas;
  logic [1:0][3:0] w_right_funnel_atbytess;
  logic [1:0] w_right_funnel_atreadys;
  logic [1:0] w_right_funnel_afvalids;
  logic [1:0] w_right_funnel_syncreqs;
  assign w_right_funnel_atvalids[0] = w_async_bridge_mst_to_right_funnel_atvalid;
  assign w_right_funnel_afreadys[0] = w_async_bridge_mst_to_right_funnel_afready;
  assign w_right_funnel_atids[0] = w_async_bridge_mst_to_right_funnel_atid;
  assign w_right_funnel_atdatas[0] = w_async_bridge_mst_to_right_funnel_atdata;
  assign w_right_funnel_atbytess[0] = w_async_bridge_mst_to_right_funnel_atbytes;
  assign w_async_bridge_mst_to_right_funnel_atready = w_right_funnel_atreadys[0];
  assign w_async_bridge_mst_to_right_funnel_afvalid = w_right_funnel_afvalids[0];
  assign w_async_bridge_mst_to_right_funnel_syncreq = w_right_funnel_syncreqs[0];
  assign w_right_funnel_atvalids[1] = w_camera_funnel_to_right_funnel_atvalid;
  assign w_right_funnel_afreadys[1] = w_camera_funnel_to_right_funnel_afready;
  assign w_right_funnel_atids[1] = w_camera_funnel_to_right_funnel_atid;
  assign w_right_funnel_atdatas[1] = w_camera_funnel_to_right_funnel_atdata;
  assign w_right_funnel_atbytess[1] = w_camera_funnel_to_right_funnel_atbytes;
  assign w_camera_funnel_to_right_funnel_atready = w_right_funnel_atreadys[1];
  assign w_camera_funnel_to_right_funnel_afvalid = w_right_funnel_afvalids[1];
  assign w_camera_funnel_to_right_funnel_syncreq = w_right_funnel_syncreqs[1];
  atb_funnel #(.ATB_DATA_WIDTH(128), .ATB_ID_WIDTH(7), .N_ATB(2)) u_right_funnel (
    .clk(clk_async),
    .resetn(rst_async_n),
    .pclkendbg(right_funnel_pclkendbg),
    .pseldbg(right_funnel_pseldbg),
    .penabledbg(right_funnel_penabledbg),
    .pwritedbg(right_funnel_pwritedbg),
    .paddrdbg31(right_funnel_paddrdbg31),
    .paddrdbg(right_funnel_paddrdbg),
    .pwdatadbg(right_funnel_pwdatadbg),
    .atvalids(w_right_funnel_atvalids),
    .afreadys(w_right_funnel_afreadys),
    .atids(w_right_funnel_atids),
    .atdatas(w_right_funnel_atdatas),
    .atbytess(w_right_funnel_atbytess),
    .atreadym(w_right_funnel_to_debug_tniu_ss_atready),
    .afvalidm(w_right_funnel_to_debug_tniu_ss_afvalid),
    .syncreqm(w_right_funnel_to_debug_tniu_ss_syncreq),
    .atvalidm(w_right_funnel_to_debug_tniu_ss_atvalid),
    .afreadym(w_right_funnel_to_debug_tniu_ss_afready),
    .atidm(w_right_funnel_to_debug_tniu_ss_atid),
    .atdatam(w_right_funnel_to_debug_tniu_ss_atdata),
    .atbytesm(w_right_funnel_to_debug_tniu_ss_atbytes),
    .atreadys(w_right_funnel_atreadys),
    .afvalids(w_right_funnel_afvalids),
    .syncreqs(w_right_funnel_syncreqs),
    .preadydbg(right_funnel_preadydbg),
    .pslverrdbg(right_funnel_pslverrdbg),
    .prdatadbg(right_funnel_prdatadbg)
  );

endmodule

// ATB network layer assembly for noc-top publication.
module atb_network_layer (
  input logic clk_core,
  input logic clk_async,
  input logic rst_n,
  input logic dsp_ss0_in_valid,
  input logic [127:0] dsp_ss0_in_data,
  input logic dsp_ss1_in_valid,
  input logic [127:0] dsp_ss1_in_data,
  input logic dsp_ss2_in_valid,
  input logic [127:0] dsp_ss2_in_data,
  input logic dsp_ss3_in_valid,
  input logic [127:0] dsp_ss3_in_data,
  input logic dsp_ss4_in_valid,
  input logic [127:0] dsp_ss4_in_data,
  input logic dsp_ss5_in_valid,
  input logic [127:0] dsp_ss5_in_data,
  input logic camera_ss_in_valid,
  input logic [127:0] camera_ss_in_data,
  input logic mipi_ss_in_valid,
  input logic [127:0] mipi_ss_in_data,
  output logic debug_tniu_ss_out_valid,
  output logic [127:0] debug_tniu_ss_out_data
);

  // Topology edge wires
  logic w_dsp_ss0_to_left_funnel_valid;
  logic [127:0] w_dsp_ss0_to_left_funnel_data;
  logic w_dsp_ss1_to_left_funnel_valid;
  logic [127:0] w_dsp_ss1_to_left_funnel_data;
  logic w_dsp_ss2_to_left_funnel_valid;
  logic [127:0] w_dsp_ss2_to_left_funnel_data;
  logic w_dsp_ss3_to_left_funnel_valid;
  logic [127:0] w_dsp_ss3_to_left_funnel_data;
  logic w_dsp_ss4_to_left_funnel_valid;
  logic [127:0] w_dsp_ss4_to_left_funnel_data;
  logic w_dsp_ss5_to_left_funnel_valid;
  logic [127:0] w_dsp_ss5_to_left_funnel_data;
  logic w_camera_ss_to_camera_funnel_valid;
  logic [127:0] w_camera_ss_to_camera_funnel_data;
  logic w_mipi_ss_to_camera_funnel_valid;
  logic [127:0] w_mipi_ss_to_camera_funnel_data;
  logic w_left_funnel_to_async_bridge_slv_valid;
  logic [127:0] w_left_funnel_to_async_bridge_slv_data;
  logic w_async_bridge_slv_to_async_bridge_mst_valid;
  logic [127:0] w_async_bridge_slv_to_async_bridge_mst_data;
  logic w_async_bridge_mst_to_right_funnel_valid;
  logic [127:0] w_async_bridge_mst_to_right_funnel_data;
  logic w_camera_funnel_to_right_funnel_valid;
  logic [127:0] w_camera_funnel_to_right_funnel_data;
  logic w_right_funnel_to_debug_tniu_ss_valid;
  logic [127:0] w_right_funnel_to_debug_tniu_ss_data;

  assign w_dsp_ss0_to_left_funnel_valid = dsp_ss0_in_valid;
  assign w_dsp_ss0_to_left_funnel_data = dsp_ss0_in_data;
  assign w_dsp_ss1_to_left_funnel_valid = dsp_ss1_in_valid;
  assign w_dsp_ss1_to_left_funnel_data = dsp_ss1_in_data;
  assign w_dsp_ss2_to_left_funnel_valid = dsp_ss2_in_valid;
  assign w_dsp_ss2_to_left_funnel_data = dsp_ss2_in_data;
  assign w_dsp_ss3_to_left_funnel_valid = dsp_ss3_in_valid;
  assign w_dsp_ss3_to_left_funnel_data = dsp_ss3_in_data;
  assign w_dsp_ss4_to_left_funnel_valid = dsp_ss4_in_valid;
  assign w_dsp_ss4_to_left_funnel_data = dsp_ss4_in_data;
  assign w_dsp_ss5_to_left_funnel_valid = dsp_ss5_in_valid;
  assign w_dsp_ss5_to_left_funnel_data = dsp_ss5_in_data;
  assign w_camera_ss_to_camera_funnel_valid = camera_ss_in_valid;
  assign w_camera_ss_to_camera_funnel_data = camera_ss_in_data;
  assign w_mipi_ss_to_camera_funnel_valid = mipi_ss_in_valid;
  assign w_mipi_ss_to_camera_funnel_data = mipi_ss_in_data;
  assign debug_tniu_ss_out_valid = w_right_funnel_to_debug_tniu_ss_valid;
  assign debug_tniu_ss_out_data = w_right_funnel_to_debug_tniu_ss_data;

  // Generated topology instances
  // async_bridge_slv: internal topology helper; no standalone published ATB leaf directory.
  atb_async_bridge_slv #(.DATA_W(128)) u_async_bridge_slv (
    .clk(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .in_valid(w_left_funnel_to_async_bridge_slv_valid),
    .in_data(w_left_funnel_to_async_bridge_slv_data),
    .out_valid(w_async_bridge_slv_to_async_bridge_mst_valid),
    .out_data(w_async_bridge_slv_to_async_bridge_mst_data)
  );

  // async_bridge_mst: internal topology helper; no standalone published ATB leaf directory.
  atb_async_bridge_mst #(.DATA_W(128)) u_async_bridge_mst (
    .clk(clk_core),
    .clk_async(clk_async),
    .rst_n(rst_n),
    .in_valid(w_async_bridge_slv_to_async_bridge_mst_valid),
    .in_data(w_async_bridge_slv_to_async_bridge_mst_data),
    .out_valid(w_async_bridge_mst_to_right_funnel_valid),
    .out_data(w_async_bridge_mst_to_right_funnel_data)
  );

  // left_funnel: internal topology helper; no standalone published ATB leaf directory.
  atb_funnel6 #(.DATA_W(128)) u_left_funnel (
    .in0_valid(w_dsp_ss0_to_left_funnel_valid),
    .in0_data(w_dsp_ss0_to_left_funnel_data),
    .in1_valid(w_dsp_ss1_to_left_funnel_valid),
    .in1_data(w_dsp_ss1_to_left_funnel_data),
    .in2_valid(w_dsp_ss2_to_left_funnel_valid),
    .in2_data(w_dsp_ss2_to_left_funnel_data),
    .in3_valid(w_dsp_ss3_to_left_funnel_valid),
    .in3_data(w_dsp_ss3_to_left_funnel_data),
    .in4_valid(w_dsp_ss4_to_left_funnel_valid),
    .in4_data(w_dsp_ss4_to_left_funnel_data),
    .in5_valid(w_dsp_ss5_to_left_funnel_valid),
    .in5_data(w_dsp_ss5_to_left_funnel_data),
    .out_valid(w_left_funnel_to_async_bridge_slv_valid),
    .out_data(w_left_funnel_to_async_bridge_slv_data)
  );

  // camera_funnel: internal topology helper; no standalone published ATB leaf directory.
  atb_funnel3 #(.DATA_W(128)) u_camera_funnel (
    .in0_valid(w_camera_ss_to_camera_funnel_valid),
    .in0_data(w_camera_ss_to_camera_funnel_data),
    .in1_valid(w_mipi_ss_to_camera_funnel_valid),
    .in1_data(w_mipi_ss_to_camera_funnel_data),
    .in2_valid(1'b0),
    .in2_data(128'b0),
    .out_valid(w_camera_funnel_to_right_funnel_valid),
    .out_data(w_camera_funnel_to_right_funnel_data)
  );

  // right_funnel: internal topology helper; no standalone published ATB leaf directory.
  atb_funnel3 #(.DATA_W(128)) u_right_funnel (
    .in0_valid(w_async_bridge_mst_to_right_funnel_valid),
    .in0_data(w_async_bridge_mst_to_right_funnel_data),
    .in1_valid(w_camera_funnel_to_right_funnel_valid),
    .in1_data(w_camera_funnel_to_right_funnel_data),
    .in2_valid(1'b0),
    .in2_data(128'b0),
    .out_valid(w_right_funnel_to_debug_tniu_ss_valid),
    .out_data(w_right_funnel_to_debug_tniu_ss_data)
  );

endmodule

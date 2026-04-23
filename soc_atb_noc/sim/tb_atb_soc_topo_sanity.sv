`timescale 1ns/1ps

module tb_atb_soc_topo_sanity;
  logic clk_core;
  logic rst_n;

  logic         cpu_ss_valid;
  logic [127:0] cpu_ss_data;
  logic         gpu_ss0_valid;
  logic [127:0] gpu_ss0_data;

  logic         dsp_ss0_valid;
  logic [127:0] dsp_ss0_data;
  logic         dsp_ss1_valid;
  logic [127:0] dsp_ss1_data;
  logic         dsp_ss2_valid;
  logic [127:0] dsp_ss2_data;
  logic         dsp_ss3_valid;
  logic [127:0] dsp_ss3_data;
  logic         dsp_ss4_valid;
  logic [127:0] dsp_ss4_data;
  logic         dsp_ss5_valid;
  logic [127:0] dsp_ss5_data;

  logic         camera_ss_valid;
  logic [127:0] camera_ss_data;
  logic         mipi_ss_valid;
  logic [31:0]  mipi_ss_data;

  logic         debug_tniu_valid;
  logic [127:0] debug_tniu_data;

  atb_soc_topo dut (
    .clk_core(clk_core),
    .rst_n(rst_n),
    .cpu_ss_valid(cpu_ss_valid),
    .cpu_ss_data(cpu_ss_data),
    .gpu_ss0_valid(gpu_ss0_valid),
    .gpu_ss0_data(gpu_ss0_data),
    .dsp_ss0_valid(dsp_ss0_valid),
    .dsp_ss0_data(dsp_ss0_data),
    .dsp_ss1_valid(dsp_ss1_valid),
    .dsp_ss1_data(dsp_ss1_data),
    .dsp_ss2_valid(dsp_ss2_valid),
    .dsp_ss2_data(dsp_ss2_data),
    .dsp_ss3_valid(dsp_ss3_valid),
    .dsp_ss3_data(dsp_ss3_data),
    .dsp_ss4_valid(dsp_ss4_valid),
    .dsp_ss4_data(dsp_ss4_data),
    .dsp_ss5_valid(dsp_ss5_valid),
    .dsp_ss5_data(dsp_ss5_data),
    .camera_ss_valid(camera_ss_valid),
    .camera_ss_data(camera_ss_data),
    .mipi_ss_valid(mipi_ss_valid),
    .mipi_ss_data(mipi_ss_data),
    .debug_tniu_valid(debug_tniu_valid),
    .debug_tniu_data(debug_tniu_data)
  );

  always #5 clk_core = ~clk_core;

  initial begin
    clk_core = 1'b0;
    rst_n = 1'b0;
    cpu_ss_valid = 1'b0;
    cpu_ss_data = '0;
    gpu_ss0_valid = 1'b0;
    gpu_ss0_data = '0;
    dsp_ss0_valid = 1'b0;
    dsp_ss0_data = '0;
    dsp_ss1_valid = 1'b0;
    dsp_ss1_data = '0;
    dsp_ss2_valid = 1'b0;
    dsp_ss2_data = '0;
    dsp_ss3_valid = 1'b0;
    dsp_ss3_data = '0;
    dsp_ss4_valid = 1'b0;
    dsp_ss4_data = '0;
    dsp_ss5_valid = 1'b0;
    dsp_ss5_data = '0;
    camera_ss_valid = 1'b0;
    camera_ss_data = '0;
    mipi_ss_valid = 1'b0;
    mipi_ss_data = '0;

    repeat (2) @(posedge clk_core);
    rst_n = 1'b1;

    // Sanity pulse through DSP branch.
    dsp_ss0_valid = 1'b1;
    dsp_ss0_data = 128'h1234;
    @(posedge clk_core);
    dsp_ss0_valid = 1'b0;

    repeat (5) @(posedge clk_core);
    $display("tb done, debug_valid=%0d debug_data=0x%0h", debug_tniu_valid, debug_tniu_data);
    $finish;
  end
endmodule

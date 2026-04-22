module sts_soc_harden_up_wrap (
    input clk_harden_up_func,
    input rst_harden_up_func_n,

    input         up_async_rsp_vld,
    input  [63:0] up_async_rsp_pld,
    output        up_async_rsp_rdy,

    output        aon_ss_tniu_sys_rsp_vld,
    output [63:0] aon_ss_tniu_sys_rsp_pld,
    input         aon_ss_tniu_sys_rsp_rdy,

    output        audio_ss_tniu_sys_rsp_vld,
    output [63:0] audio_ss_tniu_sys_rsp_pld,
    input         audio_ss_tniu_sys_rsp_rdy,

    output        camera_ss_tniu_sys_rsp_vld,
    output [63:0] camera_ss_tniu_sys_rsp_pld,
    input         camera_ss_tniu_sys_rsp_rdy,

    output        cpu_ss_sink_tniu_sys_rsp_vld,
    output [63:0] cpu_ss_sink_tniu_sys_rsp_pld,
    input         cpu_ss_sink_tniu_sys_rsp_rdy,

    output        ddr0_tniu_sys_rsp_vld,
    output [63:0] ddr0_tniu_sys_rsp_pld,
    input         ddr0_tniu_sys_rsp_rdy,

    output        ddr1_tniu_sys_rsp_vld,
    output [63:0] ddr1_tniu_sys_rsp_pld,
    input         ddr1_tniu_sys_rsp_rdy,

    output        ddr10_tniu_sys_rsp_vld,
    output [63:0] ddr10_tniu_sys_rsp_pld,
    input         ddr10_tniu_sys_rsp_rdy,

    output        ddr11_tniu_sys_rsp_vld,
    output [63:0] ddr11_tniu_sys_rsp_pld,
    input         ddr11_tniu_sys_rsp_rdy,

    output        ddr2_tniu_sys_rsp_vld,
    output [63:0] ddr2_tniu_sys_rsp_pld,
    input         ddr2_tniu_sys_rsp_rdy,

    output        ddr3_tniu_sys_rsp_vld,
    output [63:0] ddr3_tniu_sys_rsp_pld,
    input         ddr3_tniu_sys_rsp_rdy,

    output        ddr4_tniu_sys_rsp_vld,
    output [63:0] ddr4_tniu_sys_rsp_pld,
    input         ddr4_tniu_sys_rsp_rdy,

    output        ddr5_tniu_sys_rsp_vld,
    output [63:0] ddr5_tniu_sys_rsp_pld,
    input         ddr5_tniu_sys_rsp_rdy,

    output        ddr6_tniu_sys_rsp_vld,
    output [63:0] ddr6_tniu_sys_rsp_pld,
    input         ddr6_tniu_sys_rsp_rdy,

    output        ddr7_tniu_sys_rsp_vld,
    output [63:0] ddr7_tniu_sys_rsp_pld,
    input         ddr7_tniu_sys_rsp_rdy,

    output        ddr8_tniu_sys_rsp_vld,
    output [63:0] ddr8_tniu_sys_rsp_pld,
    input         ddr8_tniu_sys_rsp_rdy,

    output        ddr9_tniu_sys_rsp_vld,
    output [63:0] ddr9_tniu_sys_rsp_pld,
    input         ddr9_tniu_sys_rsp_rdy,

    output        debug_ss_tniu_sys_rsp_vld,
    output [63:0] debug_ss_tniu_sys_rsp_pld,
    input         debug_ss_tniu_sys_rsp_rdy,

    output        display_ss_sink_tniu_sys_rsp_vld,
    output [63:0] display_ss_sink_tniu_sys_rsp_pld,
    input         display_ss_sink_tniu_sys_rsp_rdy,

    output        dp_ss_sink_tniu_sys_rsp_vld,
    output [63:0] dp_ss_sink_tniu_sys_rsp_pld,
    input         dp_ss_sink_tniu_sys_rsp_rdy,

    output        dspss0_tniu_sys_rsp_vld,
    output [63:0] dspss0_tniu_sys_rsp_pld,
    input         dspss0_tniu_sys_rsp_rdy,

    output        dspss1_tniu_sys_rsp_vld,
    output [63:0] dspss1_tniu_sys_rsp_pld,
    input         dspss1_tniu_sys_rsp_rdy,

    output        dspss2_tniu_sys_rsp_vld,
    output [63:0] dspss2_tniu_sys_rsp_pld,
    input         dspss2_tniu_sys_rsp_rdy,

    output        dspss3_tniu_sys_rsp_vld,
    output [63:0] dspss3_tniu_sys_rsp_pld,
    input         dspss3_tniu_sys_rsp_rdy,

    output        dspss4_tniu_sys_rsp_vld,
    output [63:0] dspss4_tniu_sys_rsp_pld,
    input         dspss4_tniu_sys_rsp_rdy,

    output        dspss5_tniu_sys_rsp_vld,
    output [63:0] dspss5_tniu_sys_rsp_pld,
    input         dspss5_tniu_sys_rsp_rdy,

    output        gpu_ss0_tniu_sys_rsp_vld,
    output [63:0] gpu_ss0_tniu_sys_rsp_pld,
    input         gpu_ss0_tniu_sys_rsp_rdy,

    output        gpu_ss0_sink_tniu_sys_rsp_vld,
    output [63:0] gpu_ss0_sink_tniu_sys_rsp_pld,
    input         gpu_ss0_sink_tniu_sys_rsp_rdy,

    output        gpu_ss1_tniu_sys_rsp_vld,
    output [63:0] gpu_ss1_tniu_sys_rsp_pld,
    input         gpu_ss1_tniu_sys_rsp_rdy,

    output        mipi_ss_tniu_sys_rsp_vld,
    output [63:0] mipi_ss_tniu_sys_rsp_pld,
    input         mipi_ss_tniu_sys_rsp_rdy,

    output        pcie_eth_ss_tniu_sys_rsp_vld,
    output [63:0] pcie_eth_ss_tniu_sys_rsp_pld,
    input         pcie_eth_ss_tniu_sys_rsp_rdy,

    output        peri_ss_tniu_sys_rsp_vld,
    output [63:0] peri_ss_tniu_sys_rsp_pld,
    input         peri_ss_tniu_sys_rsp_rdy,

    output        ucie_ss0_tniu_sys_rsp_vld,
    output [63:0] ucie_ss0_tniu_sys_rsp_pld,
    input         ucie_ss0_tniu_sys_rsp_rdy,

    output        ucie_ss1_tniu_sys_rsp_vld,
    output [63:0] ucie_ss1_tniu_sys_rsp_pld,
    input         ucie_ss1_tniu_sys_rsp_rdy,

    output        ufs_ss_tniu_sys_rsp_vld,
    output [63:0] ufs_ss_tniu_sys_rsp_pld,
    input         ufs_ss_tniu_sys_rsp_rdy,

    output        vpu_ss_tniu_sys_rsp_vld,
    output [63:0] vpu_ss_tniu_sys_rsp_pld,
    input         vpu_ss_tniu_sys_rsp_rdy

);

reg [31:0] up_egress_ctr;

always @(posedge clk_harden_up_func or negedge rst_harden_up_func_n) begin
    if (!rst_harden_up_func_n) begin
        up_egress_ctr <= 32'h0;
    end else if (up_async_rsp_vld && up_async_rsp_rdy) begin
        up_egress_ctr <= up_egress_ctr + 1'b1;
    end
end

assign up_async_rsp_rdy = aon_ss_tniu_sys_rsp_rdy | audio_ss_tniu_sys_rsp_rdy | camera_ss_tniu_sys_rsp_rdy | cpu_ss_sink_tniu_sys_rsp_rdy | ddr0_tniu_sys_rsp_rdy | ddr1_tniu_sys_rsp_rdy | ddr10_tniu_sys_rsp_rdy | ddr11_tniu_sys_rsp_rdy | ddr2_tniu_sys_rsp_rdy | ddr3_tniu_sys_rsp_rdy | ddr4_tniu_sys_rsp_rdy | ddr5_tniu_sys_rsp_rdy | ddr6_tniu_sys_rsp_rdy | ddr7_tniu_sys_rsp_rdy | ddr8_tniu_sys_rsp_rdy | ddr9_tniu_sys_rsp_rdy | debug_ss_tniu_sys_rsp_rdy | display_ss_sink_tniu_sys_rsp_rdy | dp_ss_sink_tniu_sys_rsp_rdy | dspss0_tniu_sys_rsp_rdy | dspss1_tniu_sys_rsp_rdy | dspss2_tniu_sys_rsp_rdy | dspss3_tniu_sys_rsp_rdy | dspss4_tniu_sys_rsp_rdy | dspss5_tniu_sys_rsp_rdy | gpu_ss0_tniu_sys_rsp_rdy | gpu_ss0_sink_tniu_sys_rsp_rdy | gpu_ss1_tniu_sys_rsp_rdy | mipi_ss_tniu_sys_rsp_rdy | pcie_eth_ss_tniu_sys_rsp_rdy | peri_ss_tniu_sys_rsp_rdy | ucie_ss0_tniu_sys_rsp_rdy | ucie_ss1_tniu_sys_rsp_rdy | ufs_ss_tniu_sys_rsp_rdy | vpu_ss_tniu_sys_rsp_rdy;
assign aon_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign aon_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign audio_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign audio_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign camera_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign camera_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign cpu_ss_sink_tniu_sys_rsp_vld = up_async_rsp_vld;
assign cpu_ss_sink_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr0_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr0_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr1_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr1_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr10_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr10_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr11_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr11_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr2_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr2_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr3_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr3_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr4_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr4_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr5_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr5_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr6_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr6_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr7_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr7_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr8_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr8_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ddr9_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ddr9_tniu_sys_rsp_pld = up_async_rsp_pld;
assign debug_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign debug_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign display_ss_sink_tniu_sys_rsp_vld = up_async_rsp_vld;
assign display_ss_sink_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dp_ss_sink_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dp_ss_sink_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss0_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss0_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss1_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss1_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss2_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss2_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss3_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss3_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss4_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss4_tniu_sys_rsp_pld = up_async_rsp_pld;
assign dspss5_tniu_sys_rsp_vld = up_async_rsp_vld;
assign dspss5_tniu_sys_rsp_pld = up_async_rsp_pld;
assign gpu_ss0_tniu_sys_rsp_vld = up_async_rsp_vld;
assign gpu_ss0_tniu_sys_rsp_pld = up_async_rsp_pld;
assign gpu_ss0_sink_tniu_sys_rsp_vld = up_async_rsp_vld;
assign gpu_ss0_sink_tniu_sys_rsp_pld = up_async_rsp_pld;
assign gpu_ss1_tniu_sys_rsp_vld = up_async_rsp_vld;
assign gpu_ss1_tniu_sys_rsp_pld = up_async_rsp_pld;
assign mipi_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign mipi_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign pcie_eth_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign pcie_eth_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign peri_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign peri_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ucie_ss0_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ucie_ss0_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ucie_ss1_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ucie_ss1_tniu_sys_rsp_pld = up_async_rsp_pld;
assign ufs_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign ufs_ss_tniu_sys_rsp_pld = up_async_rsp_pld;
assign vpu_ss_tniu_sys_rsp_vld = up_async_rsp_vld;
assign vpu_ss_tniu_sys_rsp_pld = up_async_rsp_pld;

endmodule

module sts_soc_logic_topo (
    input clk_sys,
    input rst_sys_n,
    input clk_noc,
    input rst_noc_n,
    input clk_harden_dn_func,
    input rst_harden_dn_func_n,
    input clk_harden_up_func,
    input rst_harden_up_func_n,
    input clk_dbg_timer,
    input rst_dbg_timer_n,

    input         cpu_ss_iniu_sys_req_vld,
    input  [63:0] cpu_ss_iniu_sys_req_pld,
    output        cpu_ss_iniu_sys_req_rdy,

    input         display_ss_iniu_sys_req_vld,
    input  [63:0] display_ss_iniu_sys_req_pld,
    output        display_ss_iniu_sys_req_rdy,

    input         dp_ss_iniu_sys_req_vld,
    input  [63:0] dp_ss_iniu_sys_req_pld,
    output        dp_ss_iniu_sys_req_rdy,

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

// Auto-rendered fallback wrapper with node-derived integration ports.
localparam integer STS_SOC_BRIDGE_DATA_WIDTH = 64;
localparam integer STS_SOC_BRIDGE_FIFO_DEPTH = 16;

reg  [STS_SOC_BRIDGE_DATA_WIDTH-1:0] dn_req_payload;
wire                                  dn_req_valid;
wire                                  dn_req_ready;

wire                                  up_rsp_valid;
wire [STS_SOC_BRIDGE_DATA_WIDTH-1:0] up_rsp_payload;
reg                                   up_rsp_ready;

wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_wptr;
wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_rptr;
wire [STS_SOC_BRIDGE_FIFO_DEPTH-1:0] async_rptr_sync;
wire [STS_SOC_BRIDGE_DATA_WIDTH:0]   async_pld_sync;

reg [31:0] dn_domain_req_ctr;
reg [31:0] up_domain_rsp_ctr;

always @(posedge clk_harden_dn_func or negedge rst_harden_dn_func_n) begin
    if (!rst_harden_dn_func_n) begin
        dn_domain_req_ctr <= 32'h0;
    end else if (dn_req_valid && dn_req_ready) begin
        dn_domain_req_ctr <= dn_domain_req_ctr + 1'b1;
    end
end

assign dn_req_valid = cpu_ss_iniu_sys_req_vld | display_ss_iniu_sys_req_vld | dp_ss_iniu_sys_req_vld;
assign cpu_ss_iniu_sys_req_rdy = dn_req_ready & cpu_ss_iniu_sys_req_vld;
assign display_ss_iniu_sys_req_rdy = dn_req_ready & display_ss_iniu_sys_req_vld;
assign dp_ss_iniu_sys_req_rdy = dn_req_ready & dp_ss_iniu_sys_req_vld;

always @(*) begin
    if (cpu_ss_iniu_sys_req_vld) begin
        dn_req_payload = cpu_ss_iniu_sys_req_pld;
    end
    else if (display_ss_iniu_sys_req_vld) begin
        dn_req_payload = display_ss_iniu_sys_req_pld;
    end
    else if (dp_ss_iniu_sys_req_vld) begin
        dn_req_payload = dp_ss_iniu_sys_req_pld;
    end
    else begin
        dn_req_payload = {32'h5354_5344, dn_domain_req_ctr};
    end
end

sts_async_bridge_slv #(
    .FIFO_DEPTH (STS_SOC_BRIDGE_FIFO_DEPTH),
    .DATA_WIDTH (STS_SOC_BRIDGE_DATA_WIDTH)
) u_sts_soc_harden_dn_async_bridge_slv (
    .clk        (clk_harden_dn_func),
    .rst_n      (rst_harden_dn_func_n),
    .stall      (1'b0),
    .clear      (1'b0),
    .full_zero  (),
    .in_req_vld (dn_req_valid),
    .in_req_rdy (dn_req_ready),
    .in_req_pld (dn_req_payload),
    .almost_full(),
    .wptr_async (async_wptr),
    .rptr_async (async_rptr),
    .rptr_sync  (async_rptr_sync),
    .pld_sync   (async_pld_sync)
);

sts_async_bridge_mst #(
    .FIFO_DEPTH (STS_SOC_BRIDGE_FIFO_DEPTH),
    .DATA_WIDTH (STS_SOC_BRIDGE_DATA_WIDTH)
) u_sts_soc_harden_up_async_bridge_mst (
    .clk          (clk_harden_up_func),
    .rst_n        (rst_harden_up_func_n),
    .stall        (1'b0),
    .clear        (1'b0),
    .full_zero    (),
    .idle         (),
    .out_rsp_vld  (up_rsp_valid),
    .out_rsp_pld  (up_rsp_payload),
    .out_rsp_rdy  (up_rsp_ready),
    .almost_empty (),
    .wptr_async   (async_wptr),
    .rptr_async   (async_rptr),
    .rptr_sync    (async_rptr_sync),
    .pld_sync     (async_pld_sync)
);

always @(posedge clk_harden_up_func or negedge rst_harden_up_func_n) begin
    if (!rst_harden_up_func_n) begin
        up_domain_rsp_ctr <= 32'h0;
    end else if (up_rsp_valid && up_rsp_ready) begin
        up_domain_rsp_ctr <= up_domain_rsp_ctr + 1'b1;
    end
end

always @(*) begin
    up_rsp_ready = aon_ss_tniu_sys_rsp_rdy | audio_ss_tniu_sys_rsp_rdy | camera_ss_tniu_sys_rsp_rdy | cpu_ss_sink_tniu_sys_rsp_rdy | ddr0_tniu_sys_rsp_rdy | ddr1_tniu_sys_rsp_rdy | ddr10_tniu_sys_rsp_rdy | ddr11_tniu_sys_rsp_rdy | ddr2_tniu_sys_rsp_rdy | ddr3_tniu_sys_rsp_rdy | ddr4_tniu_sys_rsp_rdy | ddr5_tniu_sys_rsp_rdy | ddr6_tniu_sys_rsp_rdy | ddr7_tniu_sys_rsp_rdy | ddr8_tniu_sys_rsp_rdy | ddr9_tniu_sys_rsp_rdy | debug_ss_tniu_sys_rsp_rdy | display_ss_sink_tniu_sys_rsp_rdy | dp_ss_sink_tniu_sys_rsp_rdy | dspss0_tniu_sys_rsp_rdy | dspss1_tniu_sys_rsp_rdy | dspss2_tniu_sys_rsp_rdy | dspss3_tniu_sys_rsp_rdy | dspss4_tniu_sys_rsp_rdy | dspss5_tniu_sys_rsp_rdy | gpu_ss0_tniu_sys_rsp_rdy | gpu_ss0_sink_tniu_sys_rsp_rdy | gpu_ss1_tniu_sys_rsp_rdy | mipi_ss_tniu_sys_rsp_rdy | pcie_eth_ss_tniu_sys_rsp_rdy | peri_ss_tniu_sys_rsp_rdy | ucie_ss0_tniu_sys_rsp_rdy | ucie_ss1_tniu_sys_rsp_rdy | ufs_ss_tniu_sys_rsp_rdy | vpu_ss_tniu_sys_rsp_rdy;
end

assign aon_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign aon_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign audio_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign audio_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign camera_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign camera_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign cpu_ss_sink_tniu_sys_rsp_vld = up_rsp_valid;
assign cpu_ss_sink_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr0_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr0_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr1_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr1_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr10_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr10_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr11_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr11_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr2_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr2_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr3_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr3_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr4_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr4_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr5_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr5_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr6_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr6_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr7_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr7_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr8_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr8_tniu_sys_rsp_pld = up_rsp_payload;
assign ddr9_tniu_sys_rsp_vld = up_rsp_valid;
assign ddr9_tniu_sys_rsp_pld = up_rsp_payload;
assign debug_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign debug_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign display_ss_sink_tniu_sys_rsp_vld = up_rsp_valid;
assign display_ss_sink_tniu_sys_rsp_pld = up_rsp_payload;
assign dp_ss_sink_tniu_sys_rsp_vld = up_rsp_valid;
assign dp_ss_sink_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss0_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss0_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss1_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss1_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss2_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss2_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss3_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss3_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss4_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss4_tniu_sys_rsp_pld = up_rsp_payload;
assign dspss5_tniu_sys_rsp_vld = up_rsp_valid;
assign dspss5_tniu_sys_rsp_pld = up_rsp_payload;
assign gpu_ss0_tniu_sys_rsp_vld = up_rsp_valid;
assign gpu_ss0_tniu_sys_rsp_pld = up_rsp_payload;
assign gpu_ss0_sink_tniu_sys_rsp_vld = up_rsp_valid;
assign gpu_ss0_sink_tniu_sys_rsp_pld = up_rsp_payload;
assign gpu_ss1_tniu_sys_rsp_vld = up_rsp_valid;
assign gpu_ss1_tniu_sys_rsp_pld = up_rsp_payload;
assign mipi_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign mipi_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign pcie_eth_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign pcie_eth_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign peri_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign peri_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign ucie_ss0_tniu_sys_rsp_vld = up_rsp_valid;
assign ucie_ss0_tniu_sys_rsp_pld = up_rsp_payload;
assign ucie_ss1_tniu_sys_rsp_vld = up_rsp_valid;
assign ucie_ss1_tniu_sys_rsp_pld = up_rsp_payload;
assign ufs_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign ufs_ss_tniu_sys_rsp_pld = up_rsp_payload;
assign vpu_ss_tniu_sys_rsp_vld = up_rsp_valid;
assign vpu_ss_tniu_sys_rsp_pld = up_rsp_payload;

endmodule

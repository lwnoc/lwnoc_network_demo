module sts_soc_harden_dn_wrap (
    input clk_harden_dn_func,
    input rst_harden_dn_func_n,
    input         cpu_ss_iniu_sys_req_vld,
    input  [63:0] cpu_ss_iniu_sys_req_pld,
    output        cpu_ss_iniu_sys_req_rdy,
    input         display_ss_iniu_sys_req_vld,
    input  [63:0] display_ss_iniu_sys_req_pld,
    output        display_ss_iniu_sys_req_rdy,
    input         dp_ss_iniu_sys_req_vld,
    input  [63:0] dp_ss_iniu_sys_req_pld,
    output        dp_ss_iniu_sys_req_rdy,
    output        dn_async_req_vld,
    output [63:0] dn_async_req_pld,
    input         dn_async_req_rdy
);


reg [31:0] dn_ingress_ctr;

always @(posedge clk_harden_dn_func or negedge rst_harden_dn_func_n) begin
    if (!rst_harden_dn_func_n) begin
        dn_ingress_ctr <= 32'h0;
    end else if (dn_async_req_vld && dn_async_req_rdy) begin
        dn_ingress_ctr <= dn_ingress_ctr + 1'b1;
    end
end

assign dn_async_req_vld = cpu_ss_iniu_sys_req_vld | display_ss_iniu_sys_req_vld | dp_ss_iniu_sys_req_vld;
assign cpu_ss_iniu_sys_req_rdy = dn_async_req_rdy & cpu_ss_iniu_sys_req_vld;
assign display_ss_iniu_sys_req_rdy = dn_async_req_rdy & display_ss_iniu_sys_req_vld;
assign dp_ss_iniu_sys_req_rdy = dn_async_req_rdy & dp_ss_iniu_sys_req_vld;

always @(*) begin
    if (cpu_ss_iniu_sys_req_vld) begin
        dn_async_req_pld = cpu_ss_iniu_sys_req_pld;
    end
    else if (display_ss_iniu_sys_req_vld) begin
        dn_async_req_pld = display_ss_iniu_sys_req_pld;
    end
    else if (dp_ss_iniu_sys_req_vld) begin
        dn_async_req_pld = dp_ss_iniu_sys_req_pld;
    end
    else begin
        dn_async_req_pld = {32'h444E_5251, dn_ingress_ctr};
    end
end

endmodule

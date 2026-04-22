module sts_soc_harden_top_pd (
    input clk_harden_dn_func,
    input rst_harden_dn_func_n,
    input clk_harden_up_func,
    input rst_harden_up_func_n,

    input  [1:0]   harden_dn_iniu_sys_req_vld,
    input  [127:0] harden_dn_iniu_sys_req_pld,
    output [1:0]   harden_dn_iniu_sys_req_rdy,

    output [5:0]   harden_up_tniu_sys_rsp_vld,
    output [383:0] harden_up_tniu_sys_rsp_pld,
    input  [5:0]   harden_up_tniu_sys_rsp_rdy
);

// PD harden top wrapper around DN/UP partitions across async boundary.
wire        dn_async_req_vld;
wire [63:0] dn_async_req_pld;
wire        dn_async_req_rdy;

assign dn_async_req_rdy = 1'b1;

sts_soc_harden_dn_wrap u_sts_soc_harden_dn_wrap (
    .clk_harden_dn_func (clk_harden_dn_func),
    .rst_harden_dn_func_n (rst_harden_dn_func_n),
    .iniu_sys_req_vld   (harden_dn_iniu_sys_req_vld),
    .iniu_sys_req_pld   (harden_dn_iniu_sys_req_pld),
    .iniu_sys_req_rdy   (harden_dn_iniu_sys_req_rdy),
    .dn_async_req_vld   (dn_async_req_vld),
    .dn_async_req_pld   (dn_async_req_pld),
    .dn_async_req_rdy   (dn_async_req_rdy)
);

sts_soc_harden_up_wrap u_sts_soc_harden_up_wrap (
    .clk_harden_up_func (clk_harden_up_func),
    .rst_harden_up_func_n (rst_harden_up_func_n),
    .up_async_rsp_vld   (dn_async_req_vld),
    .up_async_rsp_pld   (dn_async_req_pld),
    .up_async_rsp_rdy   (),
    .tniu_sys_rsp_vld   (harden_up_tniu_sys_rsp_vld),
    .tniu_sys_rsp_pld   (harden_up_tniu_sys_rsp_pld),
    .tniu_sys_rsp_rdy   (harden_up_tniu_sys_rsp_rdy)
);

endmodule

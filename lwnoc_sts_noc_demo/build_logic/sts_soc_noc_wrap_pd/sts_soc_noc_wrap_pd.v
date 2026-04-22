module sts_soc_noc_wrap_pd (
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

// Live PD compile ingress wrapper for STS SoC harden publication.
sts_soc_harden_top_pd u_sts_soc_harden_top_pd (
    .clk_harden_dn_func (clk_harden_dn_func),
    .rst_harden_dn_func_n (rst_harden_dn_func_n),
    .clk_harden_up_func (clk_harden_up_func),
    .rst_harden_up_func_n (rst_harden_up_func_n),
    .harden_dn_iniu_sys_req_vld (harden_dn_iniu_sys_req_vld),
    .harden_dn_iniu_sys_req_pld (harden_dn_iniu_sys_req_pld),
    .harden_dn_iniu_sys_req_rdy (harden_dn_iniu_sys_req_rdy),
    .harden_up_tniu_sys_rsp_vld (harden_up_tniu_sys_rsp_vld),
    .harden_up_tniu_sys_rsp_pld (harden_up_tniu_sys_rsp_pld),
    .harden_up_tniu_sys_rsp_rdy (harden_up_tniu_sys_rsp_rdy)
);

endmodule

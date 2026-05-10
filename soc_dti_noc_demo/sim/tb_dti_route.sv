// DTI route testbench with pchn_mst_vip
`timescale 1ns/1ps
module tb_dti_route;
    reg clk=0; always #5 clk=~clk;
    reg rst=0;
`ifdef FSDB
    // Optional FSDB dump when the simulator provides the FSDB tasks.
    initial begin
        $fsdbDumpfile("tb_dti_route.fsdb");
        $fsdbDumpvars(0, tb_dti_route);
        $fsdbDumpon;
    end
`endif
    localparam NI=21,NT=2;
    integer result;
    wire        iniu_paccept[0:NI-1];
    wire [1:0] iniu_pactive[0:NI-1];
    wire        iniu_pdeny[0:NI-1];
    wire        iniu_req_tready[0:NI-1];
    wire [79:0] iniu_rsp_tdata[0:NI-1];
    wire [9:0] iniu_rsp_tkeep[0:NI-1];
    wire        iniu_rsp_tlast[0:NI-1];
    wire [5:0] iniu_rsp_ttid[0:NI-1];
    wire        iniu_rsp_tvalid[0:NI-1];
    wire        iniu_rsp_twakeup[0:NI-1];
    wire        iniu_clk_noc[0:NI-1];
    wire        iniu_clk_sys[0:NI-1];
    wire        iniu_preq[0:NI-1];
    wire [1:0] iniu_pstate[0:NI-1];
    reg  [79:0] iniu_req_tdata[0:NI-1];
    reg  [9:0] iniu_req_tkeep[0:NI-1];
    reg         iniu_req_tlast[0:NI-1];
    reg  [5:0] iniu_req_ttid[0:NI-1];
    reg         iniu_req_tvalid[0:NI-1];
    reg         iniu_req_twakeup[0:NI-1];
    reg         iniu_rsp_tready[0:NI-1];
    wire        iniu_rst_noc_n[0:NI-1];
    wire        iniu_rst_sys_n[0:NI-1];
    reg  [9:0] iniu_timeout_val[0:NI-1];

    wire        tniu_paccept[0:NT-1];
    wire [1:0] tniu_pactive[0:NT-1];
    wire        tniu_pdeny[0:NT-1];
    wire [79:0] tniu_req_tdata[0:NT-1];
    wire [9:0] tniu_req_tkeep[0:NT-1];
    wire        tniu_req_tlast[0:NT-1];
    wire [5:0] tniu_req_ttid[0:NT-1];
    wire        tniu_req_tvalid[0:NT-1];
    wire        tniu_req_twakeup[0:NT-1];
    reg         tniu_req_tready[0:NT-1];
    reg  [79:0] tniu_rsp_tdata[0:NT-1];
    reg  [9:0] tniu_rsp_tkeep[0:NT-1];
    reg         tniu_rsp_tlast[0:NT-1];
    reg  [5:0] tniu_rsp_ttid[0:NT-1];
    reg         tniu_rsp_tvalid[0:NT-1];
    wire        tniu_rsp_tready[0:NT-1];
    reg         tniu_rsp_twakeup[0:NT-1];
    wire        tniu_clk_noc[0:NT-1];
    wire        tniu_clk_sys[0:NT-1];
    wire        tniu_preq[0:NT-1];
    wire [1:0] tniu_pstate[0:NT-1];
    wire        tniu_rst_noc_n[0:NT-1];
    wire        tniu_rst_sys_n[0:NT-1];

    // Continuous clock/reset drives for INIU nodes
    genvar gi;
    generate for(gi=0; gi<NI; gi=gi+1) begin : gen_iniu_cr
        assign iniu_clk_sys[gi]   = clk;
        assign iniu_rst_sys_n[gi] = rst;
        assign iniu_clk_noc[gi]   = clk;
        assign iniu_rst_noc_n[gi] = rst;
    end endgenerate
    // Continuous clock/reset drives for TNIU nodes
    generate for(gi=0; gi<NT; gi=gi+1) begin : gen_tniu_cr
        assign tniu_clk_sys[gi]   = clk;
        assign tniu_rst_sys_n[gi] = rst;
        assign tniu_clk_noc[gi]   = clk;
        assign tniu_rst_noc_n[gi] = rst;
    end endgenerate

    dti_logic_topo dut(
        .clk_noc(clk),
        .rst_noc_n(rst),
        .npu_ss3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[1]),
        .npu_ss3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[1]),
        .npu_ss3_iniu_node_clk_noc_porting(iniu_clk_noc[1]),
        .npu_ss3_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[1]),
        .npu_ss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[1]),
        .npu_ss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[1]),
        .npu_ss3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[1]),
        .npu_ss3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[1]),
        .npu_ss3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[1]),
        .npu_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[1]),
        .npu_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[1]),
        .npu_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[1]),
        .npu_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[1]),
        .npu_ss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[1]),
        .npu_ss4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[2]),
        .npu_ss4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[2]),
        .npu_ss4_iniu_node_clk_noc_porting(iniu_clk_noc[2]),
        .npu_ss4_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[2]),
        .npu_ss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[2]),
        .npu_ss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[2]),
        .npu_ss4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[2]),
        .npu_ss4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[2]),
        .npu_ss4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[2]),
        .npu_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[2]),
        .npu_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[2]),
        .npu_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[2]),
        .npu_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[2]),
        .npu_ss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[2]),
        .npu_ss2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[3]),
        .npu_ss2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[3]),
        .npu_ss2_iniu_node_clk_noc_porting(iniu_clk_noc[3]),
        .npu_ss2_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[3]),
        .npu_ss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[3]),
        .npu_ss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[3]),
        .npu_ss2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[3]),
        .npu_ss2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[3]),
        .npu_ss2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[3]),
        .npu_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[3]),
        .npu_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[3]),
        .npu_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[3]),
        .npu_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[3]),
        .npu_ss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[3]),
        .ufs_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[6]),
        .ufs_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[6]),
        .ufs_ss_iniu_node_clk_noc_porting(iniu_clk_noc[6]),
        .ufs_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[6]),
        .ufs_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[6]),
        .ufs_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[6]),
        .ufs_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[6]),
        .ufs_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[6]),
        .ufs_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[6]),
        .ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[6]),
        .ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[6]),
        .ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[6]),
        .ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[6]),
        .ufs_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[6]),
        .pcie_eth_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[7]),
        .pcie_eth_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[7]),
        .pcie_eth_ss_iniu_node_clk_noc_porting(iniu_clk_noc[7]),
        .pcie_eth_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[7]),
        .pcie_eth_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[7]),
        .pcie_eth_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[7]),
        .pcie_eth_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[7]),
        .pcie_eth_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[7]),
        .pcie_eth_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[7]),
        .pcie_eth_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[7]),
        .pcie_eth_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[7]),
        .pcie_eth_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[7]),
        .pcie_eth_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[7]),
        .pcie_eth_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[7]),
        .gpu_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[8]),
        .gpu_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[8]),
        .gpu_ss0_iniu_node_clk_noc_porting(iniu_clk_noc[8]),
        .gpu_ss0_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[8]),
        .gpu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[8]),
        .gpu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[8]),
        .gpu_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[8]),
        .gpu_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[8]),
        .gpu_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[8]),
        .gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[8]),
        .gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[8]),
        .gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[8]),
        .gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[8]),
        .gpu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[8]),
        .dspss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[9]),
        .dspss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[9]),
        .dspss0_iniu_node_clk_noc_porting(iniu_clk_noc[9]),
        .dspss0_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[9]),
        .dspss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[9]),
        .dspss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[9]),
        .dspss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[9]),
        .dspss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[9]),
        .dspss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[9]),
        .dspss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[9]),
        .dspss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[9]),
        .dspss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[9]),
        .dspss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[9]),
        .dspss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[9]),
        .dspss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[10]),
        .dspss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[10]),
        .dspss1_iniu_node_clk_noc_porting(iniu_clk_noc[10]),
        .dspss1_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[10]),
        .dspss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[10]),
        .dspss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[10]),
        .dspss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[10]),
        .dspss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[10]),
        .dspss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[10]),
        .dspss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[10]),
        .dspss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[10]),
        .dspss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[10]),
        .dspss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[10]),
        .dspss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[10]),
        .dspss2_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[11]),
        .dspss2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[11]),
        .dspss2_iniu_node_clk_noc_porting(iniu_clk_noc[11]),
        .dspss2_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[11]),
        .dspss2_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[11]),
        .dspss2_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[11]),
        .dspss2_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[11]),
        .dspss2_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[11]),
        .dspss2_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[11]),
        .dspss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[11]),
        .dspss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[11]),
        .dspss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[11]),
        .dspss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[11]),
        .dspss2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[11]),
        .dspss3_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[12]),
        .dspss3_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[12]),
        .dspss3_iniu_node_clk_noc_porting(iniu_clk_noc[12]),
        .dspss3_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[12]),
        .dspss3_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[12]),
        .dspss3_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[12]),
        .dspss3_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[12]),
        .dspss3_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[12]),
        .dspss3_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[12]),
        .dspss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[12]),
        .dspss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[12]),
        .dspss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[12]),
        .dspss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[12]),
        .dspss3_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[12]),
        .dspss4_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[13]),
        .dspss4_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[13]),
        .dspss4_iniu_node_clk_noc_porting(iniu_clk_noc[13]),
        .dspss4_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[13]),
        .dspss4_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[13]),
        .dspss4_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[13]),
        .dspss4_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[13]),
        .dspss4_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[13]),
        .dspss4_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[13]),
        .dspss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[13]),
        .dspss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[13]),
        .dspss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[13]),
        .dspss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[13]),
        .dspss4_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[13]),
        .dspss5_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[14]),
        .dspss5_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[14]),
        .dspss5_iniu_node_clk_noc_porting(iniu_clk_noc[14]),
        .dspss5_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[14]),
        .dspss5_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[14]),
        .dspss5_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[14]),
        .dspss5_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[14]),
        .dspss5_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[14]),
        .dspss5_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[14]),
        .dspss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[14]),
        .dspss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[14]),
        .dspss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[14]),
        .dspss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[14]),
        .dspss5_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[14]),
        .camera_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[15]),
        .camera_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[15]),
        .camera_ss_iniu_node_clk_noc_porting(iniu_clk_noc[15]),
        .camera_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[15]),
        .camera_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[15]),
        .camera_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[15]),
        .camera_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[15]),
        .camera_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[15]),
        .camera_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[15]),
        .camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[15]),
        .camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[15]),
        .camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[15]),
        .camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[15]),
        .camera_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[15]),
        .mipi_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[16]),
        .mipi_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[16]),
        .mipi_ss_iniu_node_clk_noc_porting(iniu_clk_noc[16]),
        .mipi_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[16]),
        .mipi_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[16]),
        .mipi_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[16]),
        .mipi_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[16]),
        .mipi_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[16]),
        .mipi_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[16]),
        .mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[16]),
        .mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[16]),
        .mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[16]),
        .mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[16]),
        .mipi_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[16]),
        .gpu_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[17]),
        .gpu_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[17]),
        .gpu_ss1_iniu_node_clk_noc_porting(iniu_clk_noc[17]),
        .gpu_ss1_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[17]),
        .gpu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[17]),
        .gpu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[17]),
        .gpu_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[17]),
        .gpu_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[17]),
        .gpu_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[17]),
        .gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[17]),
        .gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[17]),
        .gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[17]),
        .gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[17]),
        .gpu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[17]),
        .usb_dp_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[18]),
        .usb_dp_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[18]),
        .usb_dp_ss_iniu_node_clk_noc_porting(iniu_clk_noc[18]),
        .usb_dp_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[18]),
        .usb_dp_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[18]),
        .usb_dp_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[18]),
        .usb_dp_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[18]),
        .usb_dp_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[18]),
        .usb_dp_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[18]),
        .usb_dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[18]),
        .usb_dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[18]),
        .usb_dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[18]),
        .usb_dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[18]),
        .usb_dp_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[18]),
        .display_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[19]),
        .display_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[19]),
        .display_ss_iniu_node_clk_noc_porting(iniu_clk_noc[19]),
        .display_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[19]),
        .display_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[19]),
        .display_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[19]),
        .display_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[19]),
        .display_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[19]),
        .display_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[19]),
        .display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[19]),
        .display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[19]),
        .display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[19]),
        .display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[19]),
        .display_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[19]),
        .vpu_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[20]),
        .vpu_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[20]),
        .vpu_ss_iniu_node_clk_noc_porting(iniu_clk_noc[20]),
        .vpu_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[20]),
        .vpu_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[20]),
        .vpu_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[20]),
        .vpu_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[20]),
        .vpu_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[20]),
        .vpu_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[20]),
        .vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[20]),
        .vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[20]),
        .vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[20]),
        .vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[20]),
        .vpu_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[20]),
        .peri_ss_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[5]),
        .peri_ss_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[5]),
        .peri_ss_iniu_node_clk_noc_porting(iniu_clk_noc[5]),
        .peri_ss_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[5]),
        .peri_ss_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[5]),
        .peri_ss_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[5]),
        .peri_ss_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[5]),
        .peri_ss_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[5]),
        .peri_ss_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[5]),
        .peri_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[5]),
        .peri_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[5]),
        .peri_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[5]),
        .peri_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[5]),
        .peri_ss_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[5]),
        .npu_ss0_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[0]),
        .npu_ss0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[0]),
        .npu_ss0_iniu_node_clk_noc_porting(iniu_clk_noc[0]),
        .npu_ss0_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[0]),
        .npu_ss0_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[0]),
        .npu_ss0_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[0]),
        .npu_ss0_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[0]),
        .npu_ss0_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[0]),
        .npu_ss0_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[0]),
        .npu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[0]),
        .npu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[0]),
        .npu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[0]),
        .npu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[0]),
        .npu_ss0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[0]),
        .npu_ss1_iniu_node_clk_sys_porting_clk_sys_clk_sys_clk(iniu_clk_sys[4]),
        .npu_ss1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(iniu_rst_sys_n[4]),
        .npu_ss1_iniu_node_clk_noc_porting(iniu_clk_noc[4]),
        .npu_ss1_iniu_node_rst_noc_n_porting(iniu_rst_noc_n[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tdata(iniu_req_tdata[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tkeep(iniu_req_tkeep[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tlast(iniu_req_tlast[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tready(iniu_req_tready[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_ttid(iniu_req_ttid[4]),
        .npu_ss1_iniu_node_dti_req_porting_dti_req_dti_req_req_tvalid(iniu_req_tvalid[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(iniu_rsp_tdata[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(iniu_rsp_tlast[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(iniu_rsp_tready[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(iniu_rsp_ttid[4]),
        .npu_ss1_iniu_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[4]),
        .npu_ss1_iniu_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(iniu_req_twakeup[4]),
        .npu_ss1_iniu_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(iniu_rsp_twakeup[4]),
        .npu_ss1_iniu_node_timeout_val_porting_timeout_val_timeout_val_timeout_val(iniu_timeout_val[4]),
        .npu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(iniu_paccept[4]),
        .npu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(iniu_pactive[4]),
        .npu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(iniu_pdeny[4]),
        .npu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(iniu_preq[4]),
        .npu_ss1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(iniu_pstate[4]),
        .cpu_ss_tniu0_node_clk_sys_porting_clk_sys_clk_sys_clk(tniu_clk_sys[0]),
        .cpu_ss_tniu0_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(tniu_rst_sys_n[0]),
        .cpu_ss_tniu0_node_clk_noc_porting(tniu_clk_noc[0]),
        .cpu_ss_tniu0_node_rst_noc_n_porting(tniu_rst_noc_n[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_tdata(tniu_req_tdata[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_tkeep(tniu_req_tkeep[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_tlast(tniu_req_tlast[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_tready(tniu_req_tready[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_ttid(tniu_req_ttid[0]),
        .cpu_ss_tniu0_node_dti_req_porting_dti_req_dti_req_req_tvalid(tniu_req_tvalid[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(tniu_rsp_tdata[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(tniu_rsp_tkeep[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(tniu_rsp_tlast[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(tniu_rsp_tready[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(tniu_rsp_ttid[0]),
        .cpu_ss_tniu0_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(tniu_rsp_tvalid[0]),
        .cpu_ss_tniu0_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(tniu_req_twakeup[0]),
        .cpu_ss_tniu0_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(tniu_rsp_twakeup[0]),
        .cpu_ss_tniu0_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(tniu_paccept[0]),
        .cpu_ss_tniu0_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(tniu_pactive[0]),
        .cpu_ss_tniu0_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(tniu_pdeny[0]),
        .cpu_ss_tniu0_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(tniu_preq[0]),
        .cpu_ss_tniu0_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(tniu_pstate[0]),
        .cpu_ss_tniu1_node_clk_sys_porting_clk_sys_clk_sys_clk(tniu_clk_sys[1]),
        .cpu_ss_tniu1_node_rst_sys_n_porting_rst_sys_n_rst_sys_n_rst_n(tniu_rst_sys_n[1]),
        .cpu_ss_tniu1_node_clk_noc_porting(tniu_clk_noc[1]),
        .cpu_ss_tniu1_node_rst_noc_n_porting(tniu_rst_noc_n[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_tdata(tniu_req_tdata[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_tkeep(tniu_req_tkeep[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_tlast(tniu_req_tlast[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_tready(tniu_req_tready[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_ttid(tniu_req_ttid[1]),
        .cpu_ss_tniu1_node_dti_req_porting_dti_req_dti_req_req_tvalid(tniu_req_tvalid[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tdata(tniu_rsp_tdata[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tkeep(tniu_rsp_tkeep[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tlast(tniu_rsp_tlast[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tready(tniu_rsp_tready[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_ttid(tniu_rsp_ttid[1]),
        .cpu_ss_tniu1_node_dti_rsp_porting_dti_rsp_dti_rsp_rsp_tvalid(tniu_rsp_tvalid[1]),
        .cpu_ss_tniu1_node_req_twakeup_porting_req_twakeup_req_twakeup_req_twakeup(tniu_req_twakeup[1]),
        .cpu_ss_tniu1_node_rsp_twakeup_porting_rsp_twakeup_rsp_twakeup_rsp_twakeup(tniu_rsp_twakeup[1]),
        .cpu_ss_tniu1_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_paccept(tniu_paccept[1]),
        .cpu_ss_tniu1_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pactive(tniu_pactive[1]),
        .cpu_ss_tniu1_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pdeny(tniu_pdeny[1]),
        .cpu_ss_tniu1_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_preq(tniu_preq[1]),
        .cpu_ss_tniu1_node_pchnl_ctrl_porting_pchnl_ctrl_pchnl_ctrl_pstate(tniu_pstate[1])
    );

    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_npu0 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[0]),.pstate(iniu_pstate[0]),
        .pactive(iniu_pactive[0]),.paccept(iniu_paccept[0]),.pdeny(iniu_pdeny[0]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_npu3 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[1]),.pstate(iniu_pstate[1]),
        .pactive(iniu_pactive[1]),.paccept(iniu_paccept[1]),.pdeny(iniu_pdeny[1]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_npu4 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[2]),.pstate(iniu_pstate[2]),
        .pactive(iniu_pactive[2]),.paccept(iniu_paccept[2]),.pdeny(iniu_pdeny[2]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_npu2 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[3]),.pstate(iniu_pstate[3]),
        .pactive(iniu_pactive[3]),.paccept(iniu_paccept[3]),.pdeny(iniu_pdeny[3]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_npu1 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[4]),.pstate(iniu_pstate[4]),
        .pactive(iniu_pactive[4]),.paccept(iniu_paccept[4]),.pdeny(iniu_pdeny[4]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_peri (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[5]),.pstate(iniu_pstate[5]),
        .pactive(iniu_pactive[5]),.paccept(iniu_paccept[5]),.pdeny(iniu_pdeny[5]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_ufs (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[6]),.pstate(iniu_pstate[6]),
        .pactive(iniu_pactive[6]),.paccept(iniu_paccept[6]),.pdeny(iniu_pdeny[6]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_pcie_eth (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[7]),.pstate(iniu_pstate[7]),
        .pactive(iniu_pactive[7]),.paccept(iniu_paccept[7]),.pdeny(iniu_pdeny[7]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_gpu0 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[8]),.pstate(iniu_pstate[8]),
        .pactive(iniu_pactive[8]),.paccept(iniu_paccept[8]),.pdeny(iniu_pdeny[8]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp0 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[9]),.pstate(iniu_pstate[9]),
        .pactive(iniu_pactive[9]),.paccept(iniu_paccept[9]),.pdeny(iniu_pdeny[9]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp1 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[10]),.pstate(iniu_pstate[10]),
        .pactive(iniu_pactive[10]),.paccept(iniu_paccept[10]),.pdeny(iniu_pdeny[10]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp2 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[11]),.pstate(iniu_pstate[11]),
        .pactive(iniu_pactive[11]),.paccept(iniu_paccept[11]),.pdeny(iniu_pdeny[11]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp3 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[12]),.pstate(iniu_pstate[12]),
        .pactive(iniu_pactive[12]),.paccept(iniu_paccept[12]),.pdeny(iniu_pdeny[12]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp4 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[13]),.pstate(iniu_pstate[13]),
        .pactive(iniu_pactive[13]),.paccept(iniu_paccept[13]),.pdeny(iniu_pdeny[13]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_dsp5 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[14]),.pstate(iniu_pstate[14]),
        .pactive(iniu_pactive[14]),.paccept(iniu_paccept[14]),.pdeny(iniu_pdeny[14]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_camera (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[15]),.pstate(iniu_pstate[15]),
        .pactive(iniu_pactive[15]),.paccept(iniu_paccept[15]),.pdeny(iniu_pdeny[15]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_mipi (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[16]),.pstate(iniu_pstate[16]),
        .pactive(iniu_pactive[16]),.paccept(iniu_paccept[16]),.pdeny(iniu_pdeny[16]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_gpu1 (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[17]),.pstate(iniu_pstate[17]),
        .pactive(iniu_pactive[17]),.paccept(iniu_paccept[17]),.pdeny(iniu_pdeny[17]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_usb_dp (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[18]),.pstate(iniu_pstate[18]),
        .pactive(iniu_pactive[18]),.paccept(iniu_paccept[18]),.pdeny(iniu_pdeny[18]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_display (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[19]),.pstate(iniu_pstate[19]),
        .pactive(iniu_pactive[19]),.paccept(iniu_paccept[19]),.pdeny(iniu_pdeny[19]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_vpu (
        .clk(clk),.rst_n(rst),
        .preq(iniu_preq[20]),.pstate(iniu_pstate[20]),
        .pactive(iniu_pactive[20]),.paccept(iniu_paccept[20]),.pdeny(iniu_pdeny[20]));

    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_tniu0 (
        .clk(clk),.rst_n(rst),
        .preq(tniu_preq[0]),.pstate(tniu_pstate[0]),
        .pactive(tniu_pactive[0]),.paccept(tniu_paccept[0]),.pdeny(tniu_pdeny[0]));
    pchn_mst_vip #(.TIMEOUT_CYCLES(5000),.VERBOSE(1)) vip_tniu1 (
        .clk(clk),.rst_n(rst),
        .preq(tniu_preq[1]),.pstate(tniu_pstate[1]),
        .pactive(tniu_pactive[1]),.paccept(tniu_paccept[1]),.pdeny(tniu_pdeny[1]));

    integer leaf_lo[0:NI-1],leaf_tbu[0:NI-1];
    initial begin
        leaf_lo[0]=0;leaf_tbu[0]=1;
        leaf_lo[1]=1;leaf_tbu[1]=1;
        leaf_lo[2]=2;leaf_tbu[2]=1;
        leaf_lo[3]=3;leaf_tbu[3]=1;
        leaf_lo[4]=4;leaf_tbu[4]=1;
        leaf_lo[5]=5;leaf_tbu[5]=1;
        leaf_lo[6]=6;leaf_tbu[6]=1;
        leaf_lo[7]=7;leaf_tbu[7]=1;
        leaf_lo[8]=8;leaf_tbu[8]=1;
        leaf_lo[9]=9;leaf_tbu[9]=1;
        leaf_lo[10]=10;leaf_tbu[10]=1;
        leaf_lo[11]=11;leaf_tbu[11]=1;
        leaf_lo[12]=12;leaf_tbu[12]=1;
        leaf_lo[13]=13;leaf_tbu[13]=1;
        leaf_lo[14]=14;leaf_tbu[14]=1;
        leaf_lo[15]=15;leaf_tbu[15]=1;
        leaf_lo[16]=16;leaf_tbu[16]=1;
        leaf_lo[17]=17;leaf_tbu[17]=1;
        leaf_lo[18]=18;leaf_tbu[18]=1;
        leaf_lo[19]=19;leaf_tbu[19]=1;
        leaf_lo[20]=20;leaf_tbu[20]=2;
    end

    integer pass_cnt,fail_cnt,total,li,si; reg[5:0] tid,rsp_tti; reg tready_fail;
    initial begin
        pass_cnt=0;fail_cnt=0;total=0;
        // Init DTI signal defaults (rely on VIP for pchannel)
        for(li=0;li<NI;li=li+1) begin
            iniu_req_tvalid[li]=0;iniu_req_tlast[li]=1;iniu_req_tdata[li]=80'hBEEF;iniu_req_tkeep[li]=10'h3FF;
            iniu_req_ttid[li]=0;iniu_rsp_tready[li]=1;
            iniu_req_twakeup[li]=0;iniu_timeout_val[li]=10'd16;
        end
        for(li=0;li<NT;li=li+1) begin
            tniu_req_tready[li]=1;tniu_rsp_tvalid[li]=0;
            tniu_rsp_tdata[li]=0;tniu_rsp_tkeep[li]=10'h3FF;tniu_rsp_tlast[li]=1;tniu_rsp_ttid[li]=0;
        end

        // Reset
        rst=0;#100;rst=1;#500;

        // Power on all leaves via VIP
        $display("=== Power-on sequence ===");
        vip_npu0.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 0, result);
        vip_npu3.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 1, result);
        vip_npu4.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 2, result);
        vip_npu2.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 3, result);
        vip_npu1.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 4, result);
        vip_peri.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 5, result);
        vip_ufs.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 6, result);
        vip_pcie_eth.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 7, result);
        vip_gpu0.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 8, result);
        vip_dsp0.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 9, result);
        vip_dsp1.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 10, result);
        vip_dsp2.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 11, result);
        vip_dsp3.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 12, result);
        vip_dsp4.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 13, result);
        vip_dsp5.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 14, result);
        vip_camera.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 15, result);
        vip_mipi.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 16, result);
        vip_gpu1.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 17, result);
        vip_usb_dp.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 18, result);
        vip_display.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 19, result);
        vip_vpu.power_on(result);
        $display("  leaf %0d: power_on result=%0d", 20, result);

        // Power on TNIU nodes
        vip_tniu0.power_on(result);
        $display("  tniu0: power_on result=%0d", result);
        vip_tniu1.power_on(result);
        $display("  tniu1: power_on result=%0d", result);

        $display("=== DTI Route Test ===");
        for(li=0;li<NI;li=li+1)
            for(si=0;si<leaf_tbu[li];si=si+1) begin
            // sys-side req_ttid/rsp_ttid are leaf-local slot IDs, not routed IDs.
            tid=si;total=total+1;
                $display("Test %0d: leaf=%0d TTID=%0d",total,li,tid);
                iniu_req_ttid[li]=tid;iniu_req_twakeup[li]=1;iniu_req_tvalid[li]=1;
                tready_fail=0;
                fork
                    begin repeat(5000)@(posedge clk);
                        $display("  [FAIL] leaf=%0d TTID=%0d TREADY_TIMEOUT tready=%0d",li,tid,iniu_req_tready[li]);
                        fail_cnt=fail_cnt+1;iniu_req_tvalid[li]=0;iniu_req_twakeup[li]=0;tready_fail=1;end
                    begin @(posedge clk);while(!iniu_req_tready[li])@(posedge clk);@(posedge clk);iniu_req_tvalid[li]=0;iniu_req_twakeup[li]=0;end
                join_any;disable fork;
                if(tready_fail) continue;
                fork
                    begin while(!tniu_req_tvalid[0])@(posedge clk);
                        tniu_rsp_ttid[0]=tniu_req_ttid[0];tniu_rsp_tdata[0]=tniu_req_tdata[0];tniu_rsp_twakeup[0]=1;tniu_rsp_tvalid[0]=1;
                        @(posedge clk);while(!tniu_rsp_tready[0])@(posedge clk);@(posedge clk);tniu_rsp_tvalid[0]=0;tniu_rsp_twakeup[0]=0;end
                    begin while(!tniu_req_tvalid[1])@(posedge clk);
                        tniu_rsp_ttid[1]=tniu_req_ttid[1];tniu_rsp_tdata[1]=tniu_req_tdata[1];tniu_rsp_twakeup[1]=1;tniu_rsp_tvalid[1]=1;
                        @(posedge clk);while(!tniu_rsp_tready[1])@(posedge clk);@(posedge clk);tniu_rsp_tvalid[1]=0;tniu_rsp_twakeup[1]=0;end
                join_any;disable fork;
                fork
                    begin repeat(5000)@(posedge clk);$display("  [FAIL] leaf=%0d TTID=%0d TIMEOUT",li,tid);fail_cnt=fail_cnt+1;end
                    begin while(!iniu_rsp_tvalid[li])@(posedge clk);rsp_tti=iniu_rsp_ttid[li];@(posedge clk);
                        if(rsp_tti==tid) begin $display("  [PASS] leaf=%0d TTID=%0d",li,tid);pass_cnt=pass_cnt+1;end
                        else begin $display("  [FAIL] leaf=%0d TTID=%0d got_ttid=%0d",li,tid,rsp_tti);fail_cnt=fail_cnt+1;end end
                join_any;disable fork;#20000;
            end
        $display("=== %0d PASS, %0d FAIL (total %0d) ===",pass_cnt,fail_cnt,total);
        $display("FSDB dumped to tb_dti_route.fsdb");
        $finish;
    end
endmodule
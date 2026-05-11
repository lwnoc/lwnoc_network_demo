// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_dti_noc_demo/build_logic/dti_iniu_top_side_gpu_ss0/dti_iniu_top_gpu_ss0_dti_pr_iniu_async_top_side.sv
// Source top module: dti_iniu_top_gpu_ss0_dti_pr_iniu_async_top_side
// Boundary note: Representative DTI INIU top-side boundary: gpu_ss0.
module dti_iniu_top_side_stub (
    input  logic [0:0]        clk             ,  // clock input
    input  logic [0:0]        rst_n           ,  // active-low reset
    input  logic [0:0]        rsp_valid       ,  // DTI response valid/ready
    input  logic [89:0]       rsp_payload     ,  // DTI response payload
    input  logic [0:0]        rsp_last        ,  // DTI response last beat
    input  logic [5:0]        rsp_srcid       ,  // DTI response source ID
    input  logic [5:0]        rsp_tgtid       ,  // DTI response target ID
    input  logic [0:0]        rsp_qos         ,  // DTI response QoS
    output logic [0:0]        rsp_threshold   ,  // DTI response threshold
    output logic [0:0]        rsp_ready       ,  // DTI response valid/ready
    output logic [0:0]        req_valid       ,  // DTI request valid/ready
    output logic [89:0]       req_payload     ,  // DTI request payload
    output logic [0:0]        req_last        ,  // DTI request last beat
    output logic [5:0]        req_srcid       ,  // DTI request source ID
    output logic [5:0]        req_tgtid       ,  // DTI request target ID
    output logic [0:0]        req_qos         ,  // DTI request QoS
    input  logic [0:0]        req_threshold   ,  // DTI request threshold
    input  logic [0:0]        req_ready       ,  // DTI request valid/ready
    input  logic [15:0]       req_wptr_async  ,  // async FIFO write pointer
    output logic [15:0]       req_rptr_async  ,  // async FIFO read pointer (async)
    output logic [15:0]       req_rptr_sync   ,  // async FIFO read pointer (sync)
    input  logic [112:0]      req_pld_sync    ,  // async FIFO payload sync
    output logic [0:0]        req_afifo_sb_err,  // FUSA/ECC error flag
    output logic [0:0]        req_afifo_db_err,  // FUSA/ECC error flag
    output logic [15:0]       rsp_wptr_async  ,  // async FIFO write pointer
    input  logic [15:0]       rsp_rptr_async  ,  // async FIFO read pointer (async)
    input  logic [15:0]       rsp_rptr_sync   ,  // async FIFO read pointer (sync)
    output logic [112:0]      rsp_pld_sync    ,  // async FIFO payload sync
    input  logic [12:0]       lp_hub_rx_req   ,  // low-power interface
    output logic [12:0]       lp_hub_tx_req     // low-power interface
);

    // Review-only stub behavior: tie every output low.
    assign rsp_threshold = '0;
    assign rsp_ready = '0;
    assign req_valid = '0;
    assign req_payload = '0;
    assign req_last = '0;
    assign req_srcid = '0;
    assign req_tgtid = '0;
    assign req_qos = '0;
    assign req_rptr_async = '0;
    assign req_rptr_sync = '0;
    assign req_afifo_sb_err = '0;
    assign req_afifo_db_err = '0;
    assign rsp_wptr_async = '0;
    assign rsp_pld_sync = '0;
    assign lp_hub_tx_req = '0;

endmodule

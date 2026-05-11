// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_dti_noc_demo/build_logic/dti_tniu_top_side/dti_tniu_top_dti_tniu_async_top_side.sv
// Source top module: dti_tniu_top_dti_tniu_async_top_side
// Boundary note: Representative DTI TNIU top-side boundary.
module dti_tniu_top_side_stub (
    input  logic [0:0]        clk             ,  // clock input
    input  logic [0:0]        rst_n           ,  // active-low reset
    input  logic [0:0]        req_valid       ,  // DTI request valid/ready
    input  logic [89:0]       req_payload     ,  // DTI request payload
    input  logic [0:0]        req_last        ,  // DTI request last beat
    input  logic [5:0]        req_srcid       ,  // DTI request source ID
    input  logic [5:0]        req_tgtid       ,  // DTI request target ID
    input  logic [0:0]        req_qos         ,  // DTI request QoS
    output logic [0:0]        req_threshold   ,  // DTI request threshold
    output logic [0:0]        req_ready       ,  // DTI request valid/ready
    output logic [15:0]       req_wptr_async  ,  // async FIFO write pointer
    input  logic [15:0]       req_rptr_async  ,  // async FIFO read pointer (async)
    input  logic [15:0]       req_rptr_sync   ,  // async FIFO read pointer (sync)
    output logic [112:0]      req_pld_sync    ,  // async FIFO payload sync
    output logic [0:0]        rsp_valid       ,  // DTI response valid/ready
    output logic [89:0]       rsp_payload     ,  // DTI response payload
    output logic [0:0]        rsp_last        ,  // DTI response last beat
    output logic [5:0]        rsp_srcid       ,  // DTI response source ID
    output logic [5:0]        rsp_tgtid       ,  // DTI response target ID
    output logic [0:0]        rsp_qos         ,  // DTI response QoS
    input  logic [0:0]        rsp_threshold   ,  // DTI response threshold
    input  logic [0:0]        rsp_ready       ,  // DTI response valid/ready
    input  logic [15:0]       rsp_wptr_async  ,  // async FIFO write pointer
    output logic [15:0]       rsp_rptr_async  ,  // async FIFO read pointer (async)
    output logic [15:0]       rsp_rptr_sync   ,  // async FIFO read pointer (sync)
    input  logic [112:0]      rsp_pld_sync    ,  // async FIFO payload sync
    output logic [0:0]        rsp_afifo_sb_err,  // FUSA/ECC error flag
    output logic [0:0]        rsp_afifo_db_err,  // FUSA/ECC error flag
    input  logic [12:0]       lp_hub_rx_req   ,  // low-power interface
    output logic [12:0]       lp_hub_tx_req     // low-power interface
);

    // Review-only stub behavior: tie every output low.
    assign req_threshold = '0;
    assign req_ready = '0;
    assign req_wptr_async = '0;
    assign req_pld_sync = '0;
    assign rsp_valid = '0;
    assign rsp_payload = '0;
    assign rsp_last = '0;
    assign rsp_srcid = '0;
    assign rsp_tgtid = '0;
    assign rsp_qos = '0;
    assign rsp_rptr_async = '0;
    assign rsp_rptr_sync = '0;
    assign rsp_afifo_sb_err = '0;
    assign rsp_afifo_db_err = '0;
    assign lp_hub_tx_req = '0;

endmodule

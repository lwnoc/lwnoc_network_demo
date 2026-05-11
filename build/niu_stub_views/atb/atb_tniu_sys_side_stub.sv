// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_atb_noc/build_logic/peri_tniu_sys/peri_atb_tniu_sys.sv
// Source top module: peri_atb_tniu_sys
// Boundary note: Representative ATB TNIU system-side boundary: peri_atb_tniu_sys.
module atb_tniu_sys_side_stub (
    input  logic [0:0]   clk_atb_m            ,  // clock input
    input  logic [0:0]   rstn_atb_m           ,  // active-low reset
    output logic [0:0]   m_atvalid            ,  // ATB trace data valid/ready
    input  logic [0:0]   m_atready            ,  // ATB trace data valid/ready
    output logic [3:0]   m_atbytes            ,  // ATB trace byte count
    output logic [127:0] m_atdata             ,  // ATB trace data
    output logic [6:0]   m_atid               ,  // ATB trace ID
    input  logic [0:0]   m_afvalid            ,  // ATB flush valid/ready
    output logic [0:0]   m_afready            ,  // ATB flush valid/ready
    input  logic [0:0]   m_syncreq            ,  // ATB synchronization request
    output logic [0:0]   m_atwakeup           ,  // ATB wakeup
    input  logic [0:0]   preq                 ,  // P-channel request
    input  logic [1:0]   pstate               ,  // P-channel requested power state
    output logic [1:0]   pactive              ,  // P-channel active state
    output logic [0:0]   paccept              ,  // P-channel accept
    output logic [0:0]   pdeny                ,  // P-channel deny
    output logic [0:0]   syncreq_level        ,  // ATB synchronization request level
    output logic [0:0]   flush_req_level      ,  // flush request level
    output logic [0:0]   atb_tniu_afifo_sb_err,  // FUSA/ECC error flag
    output logic [0:0]   atb_tniu_afifo_db_err,  // FUSA/ECC error flag
    input  logic [12:0]  lw_rx_req            ,  // NoC low-power request channel
    output logic [12:0]  lw_tx_req            ,  // NoC low-power request channel
    input  logic [12:0]  afifo_slv_rx_req     ,  // AFIFO low-power request channel
    output logic [12:0]  afifo_slv_tx_req     ,  // AFIFO low-power request channel
    input  logic [15:0]  wptr_async           ,  // async FIFO write pointer
    output logic [15:0]  rptr_async           ,  // async FIFO read pointer (async)
    output logic [15:0]  rptr_sync            ,  // async FIFO read pointer (sync)
    input  logic [151:0] pld_sync             ,  // async FIFO payload sync
    input  logic [9:0]   timeout_val            // timeout value
);

    // Review-only stub behavior: tie every output low.
    assign m_atvalid = '0;
    assign m_atbytes = '0;
    assign m_atdata = '0;
    assign m_atid = '0;
    assign m_afready = '0;
    assign m_atwakeup = '0;
    assign pactive = '0;
    assign paccept = '0;
    assign pdeny = '0;
    assign syncreq_level = '0;
    assign flush_req_level = '0;
    assign atb_tniu_afifo_sb_err = '0;
    assign atb_tniu_afifo_db_err = '0;
    assign lw_tx_req = '0;
    assign afifo_slv_tx_req = '0;
    assign rptr_async = '0;
    assign rptr_sync = '0;

endmodule

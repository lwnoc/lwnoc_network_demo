// Manually generated review stub from build_logic source.
// Review-only boundary stub with expanded vector widths where source constants are known.
// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.
// Source file: soc_atb_noc/build_logic/peri_tniu_noc/peri_noc_atb_tniu_noc.sv
// Source top module: peri_noc_atb_tniu_noc
// Boundary note: Representative ATB TNIU NoC/top-side boundary: peri_noc_atb_tniu_noc.
module atb_tniu_top_side_stub (
    input  logic [0:0]   clk_atb_s         ,  // clock input
    input  logic [0:0]   rstn_atb_s        ,  // active-low reset
    input  logic [0:0]   s_atvalid         ,  // ATB trace data valid/ready
    output logic [0:0]   s_atready         ,  // ATB trace data valid/ready
    input  logic [3:0]   s_atbytes         ,  // ATB trace byte count
    input  logic [127:0] s_atdata          ,  // ATB trace data
    input  logic [6:0]   s_atid            ,  // ATB trace ID
    output logic [0:0]   s_afvalid         ,  // ATB flush valid/ready
    input  logic [0:0]   s_afready         ,  // ATB flush valid/ready
    output logic [0:0]   s_syncreq         ,  // ATB synchronization request
    input  logic [0:0]   s_atwakeup        ,  // ATB wakeup
    input  logic [0:0]   flush_req         ,  // flush request
    output logic [0:0]   aifo_slv_full_zero,
    output logic [15:0]  wptr_async        ,  // async FIFO write pointer
    input  logic [15:0]  rptr_async        ,  // async FIFO read pointer (async)
    input  logic [15:0]  rptr_sync         ,  // async FIFO read pointer (sync)
    output logic [151:0] pld_sync          ,  // async FIFO payload sync
    input  logic [0:0]   syncreq_level     ,  // ATB synchronization request level
    input  logic [12:0]  lw_rx_req         ,  // NoC low-power request channel
    output logic [12:0]  lw_tx_req         ,  // NoC low-power request channel
    input  logic [12:0]  afifo_slv_rx_req  ,  // AFIFO low-power request channel
    output logic [12:0]  afifo_slv_tx_req  ,  // AFIFO low-power request channel
    input  logic [9:0]   timeout_val         // timeout value
);

    // Review-only stub behavior: tie every output low.
    assign s_atready = '0;
    assign s_afvalid = '0;
    assign s_syncreq = '0;
    assign aifo_slv_full_zero = '0;
    assign wptr_async = '0;
    assign pld_sync = '0;
    assign lw_tx_req = '0;
    assign afifo_slv_tx_req = '0;

endmodule

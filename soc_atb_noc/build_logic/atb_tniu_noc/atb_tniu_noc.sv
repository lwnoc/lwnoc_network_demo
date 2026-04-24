module atb_tniu_noc
import lw_atb_noc_pack::*;
import lwnoc_lp_define_package::*;
import lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2,
    localparam int LP_REQ_WIDTH = $bits(lwnoc_lp_req_signal_t)
) (
    input   logic                       clk_atb_s,
    input   logic                       rstn_atb_s,

    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    output  logic                       s_syncreq,
    input   logic                       s_atwakeup,

    input   logic                       flush_req,
    // AFIFO slave
    output  logic                       aifo_slv_full_zero,

    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [ATB_PLD_WIDTH:0]     pld_sync,

    input   logic                       syncreq_level,

    input   logic [LP_REQ_WIDTH-1:0]    lw_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    lw_tx_req,

    input   logic [LP_REQ_WIDTH-1:0]    afifo_slv_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    afifo_slv_tx_req,

    input   logic [9:0]                 timeout_val
);

logic                       tmp_atvalid;
logic                       tmp_atready;
logic [ATB_BYTES_WIDTH-1:0] tmp_atbytes;
logic [ATB_DATA_WIDTH-1:0]  tmp_atdata;
logic [ATB_ID_WIDTH-1:0]    tmp_atid;
logic                       tmp_afvalid;
logic                       tmp_afready;
logic                       tmp_syncreq;
logic                       tmp_atwakeup;

logic                       pre_trace_atvalid;
logic                       pre_trace_atready;
logic [ATB_BYTES_WIDTH-1:0] pre_trace_atbytes;
logic [ATB_DATA_WIDTH-1:0]  pre_trace_atdata;
logic [ATB_ID_WIDTH-1:0]    pre_trace_atid;
logic                       pre_trace_afvalid;
logic                       pre_trace_afready;
logic                       pre_trace_syncreq;
logic                       pre_trace_atwakeup;

logic                       idle;
logic                       flush_hard_switch;
logic                       flush_switch_done;
logic                       trace_soft_switch;
logic                       trace_hard_switch;
logic                       trace_switch_done;

lwnoc_lp_req_signal_t       v_lp_hub_rx_req [3-1:0];
lwnoc_lp_req_signal_t       v_lp_hub_tx_req [3-1:0];
lwnoc_lp_req_signal_t       lp_flush_rx_req;
lwnoc_lp_req_signal_t       lp_flush_tx_req;
lwnoc_lp_req_signal_t       lp_trace_rx_req;
lwnoc_lp_req_signal_t       lp_trace_tx_req;
lwnoc_lp_req_signal_t       lp_afifo_slv_rx_req;
lwnoc_lp_req_signal_t       lp_afifo_slv_tx_req;

logic                       afifo_slv_stall;
logic                       afifo_slv_clear;

assign v_lp_hub_rx_req[0] = lwnoc_lp_req_signal_t'(lw_rx_req);
assign lw_tx_req          = v_lp_hub_tx_req[0];

assign v_lp_hub_rx_req[1] = lp_flush_tx_req;
assign lp_flush_rx_req    = v_lp_hub_tx_req[1];

assign v_lp_hub_rx_req[2] = lp_trace_tx_req;
assign lp_trace_rx_req    = v_lp_hub_tx_req[2];

assign lp_afifo_slv_rx_req = lwnoc_lp_req_signal_t'(afifo_slv_rx_req);
assign afifo_slv_tx_req    = lp_afifo_slv_tx_req;

lwnoc_lp_hub_3terminal u_lp_hub_3terminal (
    .v_rx_req (v_lp_hub_rx_req),
    .v_tx_req (v_lp_hub_tx_req)
);

flush_dummy_mst u_flush_dummy_mst (
    .clk        (clk_atb_s      ),
    .rst_n      (rstn_atb_s     ),
    .s_atvalid  (s_atvalid      ),
    .s_atready  (s_atready      ),
    .s_atbytes  (s_atbytes      ),
    .s_atdata   (s_atdata       ),
    .s_atid     (s_atid         ),
    .s_afvalid  (s_afvalid      ),
    .s_afready  (s_afready      ),
    .s_syncreq  (s_syncreq      ),
    .s_atwakeup (s_atwakeup     ),
    .m_atvalid  (pre_trace_atvalid  ),
    .m_atready  (pre_trace_atready  ),
    .m_atbytes  (pre_trace_atbytes  ),
    .m_atdata   (pre_trace_atdata   ),
    .m_atid     (pre_trace_atid     ),
    .m_afvalid  (pre_trace_afvalid  ),
    .m_afready  (pre_trace_afready  ),
    .m_syncreq  (pre_trace_syncreq  ),
    .m_atwakeup (pre_trace_atwakeup ),
    .swicth     (flush_hard_switch   ),
    .soft_switch(1'b0               ),
    .hard_switch(flush_hard_switch   ),
    .switch_done(flush_switch_done   )
);

trace_data_default_slv u_trace_data_default_slv (
    .clk        (clk_atb_s      ),
    .rst_n      (rstn_atb_s     ),
    .s_atvalid  (pre_trace_atvalid  ),
    .s_atready  (pre_trace_atready  ),
    .s_atbytes  (pre_trace_atbytes  ),
    .s_atdata   (pre_trace_atdata   ),
    .s_atid     (pre_trace_atid     ),
    .s_afvalid  (pre_trace_afvalid  ),
    .s_afready  (pre_trace_afready  ),
    .s_syncreq  (pre_trace_syncreq  ),
    .s_atwakeup (pre_trace_atwakeup ),
    .m_atvalid  (tmp_atvalid    ),
    .m_atready  (tmp_atready    ),
    .m_atbytes  (tmp_atbytes    ),
    .m_atdata   (tmp_atdata     ),
    .m_atid     (tmp_atid       ),
    .m_afvalid  (tmp_afvalid    ),
    .m_afready  (tmp_afready    ),
    .m_syncreq  (tmp_syncreq    ),
    .m_atwakeup (tmp_atwakeup   ),
    .idle       (idle           ),
    .soft_switch(trace_soft_switch   ),
    .hard_switch(trace_hard_switch   ),
    .switch_done(trace_switch_done   )
);

niu_atb_slv #(
    .FIFO_DEPTH   (FIFO_DEPTH),
    .AUTO_CLEAR_EN(AUTO_CLEAR_EN),
    .SYNC_STAGE   (SYNC_STAGE)
) u_niu_atb_slv (
    .clk_atb_s          (clk_atb_s      ),
    .rstn_atb_s         (rstn_atb_s     ),
    .s_atvalid          (tmp_atvalid    ),
    .s_atready          (tmp_atready    ),
    .s_atbytes          (tmp_atbytes    ),
    .s_atdata           (tmp_atdata     ),
    .s_atid             (tmp_atid       ),
    .s_afvalid          (tmp_afvalid    ),
    .s_afready          (tmp_afready    ),
    .s_syncreq          (tmp_syncreq    ),
    .s_atwakeup         (tmp_atwakeup   ),
    .flush_req          (flush_req      ),
    .afifo_slv_stall    (afifo_slv_stall         ),
    .afifo_slv_clear    (afifo_slv_clear         ),
    .afifo_slv_full_zero(aifo_slv_full_zero      ),
    .sync_buf_stall     (1'b0                   ),
    .sync_buf_clear     (1'b0                   ),
    .sync_buf_idle      (                       ),
    .wptr_async         (wptr_async     ),
    .rptr_async         (rptr_async     ),
    .rptr_sync          (rptr_sync      ),
    .pld_sync           (pld_sync       ),
    .syncreq_level      (syncreq_level  )
);

lwnoc_lp_tniu_async_bridge u_lp_tniu_afifo_slv_bridge (
    .clk       (clk_atb_s            ),
    .rst_n     (rstn_atb_s           ),
    .rx_req    (lp_afifo_slv_rx_req  ),
    .tx_req    (lp_afifo_slv_tx_req  ),
    .stall_ptr (afifo_slv_stall      ),
    .clear_ptr (afifo_slv_clear      ),
    // fcip_afifo_slv exposes only full_zero; it has no independent write-side
    // idle output.  trans_idle gates stage1 OFF ack; full_zero gates stage2
    // OFF ack.  Both are tied to aifo_slv_full_zero as a conservative proxy:
    // stage1 ack is held until the FIFO write-pointer has returned to empty,
    // which is stricter than a pure "no in-flight transactions" condition but
    // safe.  DO NOT tie trans_idle to 1'b1 — that acks stage1 OFF before the
    // write-side datapath is quiescent and may trigger premature power-off
    // while ATB frames are still draining.  For exact stage1 semantics, a
    // write-side quiesce signal would need to be exported from niu_atb_slv /
    // atb_niu_packer (see /memories/repo/pending-followups.md).
    .trans_idle(aifo_slv_full_zero   ),
    .full_zero (aifo_slv_full_zero   )
);

lwnoc_lp_tniu_dummy_mst u_lp_tniu_flush_dummy_mst (
    .clk        (clk_atb_s          ),
    .rst_n      (rstn_atb_s         ),
    .rx_req     (lp_flush_rx_req    ),
    .tx_req     (lp_flush_tx_req    ),
    .hard_switch(flush_hard_switch  ),
    .switch_done(flush_switch_done  ),
    .timeout_val(timeout_val        )
);

lwnoc_lp_tniu_default_slv u_lp_tniu_trace_slv (
    .clk        (clk_atb_s          ),
    .rst_n      (rstn_atb_s         ),
    .rx_req     (lp_trace_rx_req    ),
    .tx_req     (lp_trace_tx_req    ),
    .hard_switch(trace_hard_switch  ),
    .soft_switch(trace_soft_switch  ),
    .switch_done(trace_switch_done  ),
    .trans_idle (idle               ),
    .timeout_val(timeout_val        )
);

endmodule

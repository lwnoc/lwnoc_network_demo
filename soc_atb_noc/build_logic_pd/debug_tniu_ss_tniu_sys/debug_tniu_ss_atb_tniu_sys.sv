module debug_tniu_ss_atb_tniu_sys
import debug_tniu_ss_lw_atb_noc_pack::*;
import lwnoc_lp_define_package::*;
import lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2,
    localparam int LP_REQ_WIDTH = $bits(lwnoc_lp_req_signal_t)
)(
    input   logic                       clk_atb_m,
    input   logic                       rstn_atb_m,

    // Data
    output  logic                       m_atvalid,
    input   logic                       m_atready,
    output  logic [ATB_BYTES_WIDTH-1:0] m_atbytes,
    output  logic [ATB_DATA_WIDTH-1:0]  m_atdata,
    output  logic [ATB_ID_WIDTH-1:0]    m_atid,
    // Flush
    input   logic                       m_afvalid,
    output  logic                       m_afready,
    // Synchronization Request,sync directly
    input   logic                       m_syncreq,
    // Wakeup
    output  logic                       m_atwakeup,

    input   logic                       preq,
    input   lwnoc_pchannel_state_t      pstate,
    output  lwnoc_pchannel_active_t     pactive,
    output  logic                       paccept,
    output  logic                       pdeny,

    output  logic                       syncreq_level,
    output  logic                       flush_req_level,

    // LP channel: uplink to the external/global LP hub
    input   logic [LP_REQ_WIDTH-1:0]    lw_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    lw_tx_req,

    // LP channel: exported toward atb_tniu_noc AFIFO slave-side bridge
    input   logic [LP_REQ_WIDTH-1:0]    afifo_slv_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    afifo_slv_tx_req,

    // control signals
    input   logic [FIFO_DEPTH-1:0]      wptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_async,
    output  logic [FIFO_DEPTH-1:0]      rptr_sync,
    input   logic [ATB_PLD_WIDTH:0]     pld_sync,

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

logic                       flush_sync_stall;
logic                       flush_sync_idle;

logic                       afifo_mst_stall;
logic                       afifo_mst_clear;
logic                       afifo_mst_full_zero;
logic                       afifo_mst_read_idle;

lwnoc_lp_req_signal_t       v_lp_local_hub_rx_req [4-1:0];
lwnoc_lp_req_signal_t       v_lp_local_hub_tx_req [4-1:0];
lwnoc_lp_req_signal_t       v_lp_sub_hub_rx_req [3-1:0];
lwnoc_lp_req_signal_t       v_lp_sub_hub_tx_req [3-1:0];
lwnoc_lp_req_signal_t       lp_iniu_rx_req;
lwnoc_lp_req_signal_t       lp_iniu_tx_req;
lwnoc_lp_req_signal_t       lp_uplink_rx_req;
lwnoc_lp_req_signal_t       lp_uplink_tx_req;
lwnoc_lp_req_signal_t       lp_flush_rx_req;
lwnoc_lp_req_signal_t       lp_flush_tx_req;
lwnoc_lp_req_signal_t       lp_nest_main_rx_req;
lwnoc_lp_req_signal_t       lp_nest_main_tx_req;
lwnoc_lp_req_signal_t       lp_nest_sub_rx_req;
lwnoc_lp_req_signal_t       lp_nest_sub_tx_req;
lwnoc_lp_req_signal_t       lp_afifo_mst_rx_req;
lwnoc_lp_req_signal_t       lp_afifo_mst_tx_req;
lwnoc_lp_req_signal_t       lp_afifo_slv_rx_req;
lwnoc_lp_req_signal_t       lp_afifo_slv_tx_req;

assign lp_uplink_rx_req    = lwnoc_lp_req_signal_t'(lw_rx_req);
assign lw_tx_req           = lp_uplink_tx_req;

assign lp_afifo_slv_rx_req = lwnoc_lp_req_signal_t'(afifo_slv_rx_req);
assign afifo_slv_tx_req    = lp_afifo_slv_tx_req;

// Local 4-terminal LP hub:
// [0] pchannel ingress through lp_iniu
// [1] flush_sync stall_logic TNIU
// [2] lp_nest main-side port
// [3] uplink to external/global LP hub
assign v_lp_local_hub_rx_req[0] = lp_iniu_tx_req;
assign lp_iniu_rx_req           = v_lp_local_hub_tx_req[0];

assign v_lp_local_hub_rx_req[1] = lp_flush_tx_req;
assign lp_flush_rx_req          = v_lp_local_hub_tx_req[1];

assign v_lp_local_hub_rx_req[2] = lp_nest_main_tx_req;
assign lp_nest_main_rx_req      = v_lp_local_hub_tx_req[2];

assign v_lp_local_hub_rx_req[3] = lp_uplink_rx_req;
assign lp_uplink_tx_req         = v_lp_local_hub_tx_req[3];

// Local 3-terminal LP sub-hub after lp_nest:
// [0] lp_nest sub-side port
// [1] AFIFO master-side LP bridge
// [2] exported port toward atb_tniu_noc AFIFO slave-side bridge
assign v_lp_sub_hub_rx_req[0] = lp_nest_sub_tx_req;
assign lp_nest_sub_rx_req     = v_lp_sub_hub_tx_req[0];

assign v_lp_sub_hub_rx_req[1] = lp_afifo_mst_tx_req;
assign lp_afifo_mst_rx_req    = v_lp_sub_hub_tx_req[1];

assign v_lp_sub_hub_rx_req[2] = lp_afifo_slv_rx_req;
assign lp_afifo_slv_tx_req    = v_lp_sub_hub_tx_req[2];

debug_tniu_ss_niu_atb_mst #(
    .FIFO_DEPTH   (FIFO_DEPTH   ),
    .AUTO_CLEAR_EN(AUTO_CLEAR_EN),
    .SYNC_STAGE   (SYNC_STAGE   )
) u_niu_atb_mst (
    .clk_atb_m              (clk_atb_m          ),
    .rstn_atb_m             (rstn_atb_m         ),
    .m_atvalid              (tmp_atvalid        ),
    .m_atready              (tmp_atready        ),
    .m_atbytes              (tmp_atbytes        ),
    .m_atdata               (tmp_atdata         ),
    .m_atid                 (tmp_atid           ),
    .m_afvalid              (tmp_afvalid        ),
    .m_afready              (tmp_afready        ),
    .m_syncreq              (tmp_syncreq        ),
    .m_atwakeup             (tmp_atwakeup       ),
    .syncreq_level          (syncreq_level      ),
    .flush_req_level        (flush_req_level    ),
    .afifo_mst_stall        (afifo_mst_stall    ),
    .afifo_mst_clear        (afifo_mst_clear    ),
    .afifo_mst_full_zero    (afifo_mst_full_zero),
    .afifo_mst_read_idle    (afifo_mst_read_idle),
    .wptr_async             (wptr_async         ),
    .rptr_async             (rptr_async         ),
    .rptr_sync              (rptr_sync          ),
    .pld_sync               (pld_sync           )
);

debug_tniu_ss_flush_sync_stall u_flush_sync_stall (
    .clk         (clk_atb_m        ),
    .rst_n       (rstn_atb_m       ),
    .s_atvalid   (tmp_atvalid      ),
    .s_atready   (tmp_atready      ),
    .s_atbytes   (tmp_atbytes      ),
    .s_atdata    (tmp_atdata       ),
    .s_atid      (tmp_atid         ),
    .s_afvalid   (tmp_afvalid      ),
    .s_afready   (tmp_afready      ),
    .s_syncreq   (tmp_syncreq      ),
    .s_atwakeup  (tmp_atwakeup     ),
    .m_atvalid   (m_atvalid        ),
    .m_atready   (m_atready        ),
    .m_atbytes   (m_atbytes        ),
    .m_atdata    (m_atdata         ),
    .m_atid      (m_atid           ),
    .m_afvalid   (m_afvalid        ),
    .m_afready   (m_afready        ),
    .m_syncreq   (m_syncreq        ),
    .m_atwakeup  (m_atwakeup       ),
    .stall       (flush_sync_stall ),
    .idle        (flush_sync_idle  )
);

lwnoc_lp_iniu u_lp_iniu (
    .clk    (clk_atb_m               ),
    .rst_n  (rstn_atb_m              ),
    .rx_req (lp_iniu_rx_req          ),
    .tx_req (lp_iniu_tx_req          ),
    .preq   (preq                    ),
    .pstate (pstate                  ),
    .pactive(pactive                 ),
    .paccept(paccept                 ),
    .pdeny  (pdeny                   )
);

lwnoc_lp_hub_wrapper #(
    .NUM_TERMINAL(4)
) u_lp_local_hub (
    .clk     (clk_atb_m           ),
    .rst_n   (rstn_atb_m          ),
    .v_rx_req(v_lp_local_hub_rx_req),
    .v_tx_req(v_lp_local_hub_tx_req)
);

lwnoc_lp_nest u_lp_nest (
    .clk        (clk_atb_m           ),
    .rst_n      (rstn_atb_m          ),
    .rx_req_main(lp_nest_main_rx_req ),
    .tx_req_main(lp_nest_main_tx_req ),
    .rx_req_sub (lp_nest_sub_rx_req  ),
    .tx_req_sub (lp_nest_sub_tx_req  )
);

lwnoc_lp_hub_wrapper #(
    .NUM_TERMINAL(3)
) u_lp_sub_hub (
    .clk     (clk_atb_m           ),
    .rst_n   (rstn_atb_m          ),
    .v_rx_req(v_lp_sub_hub_rx_req),
    .v_tx_req(v_lp_sub_hub_tx_req)
);

lwnoc_lp_tniu_stall_logic u_lp_flush_sync_stall (
    .clk            (clk_atb_m          ),
    .rst_n          (rstn_atb_m         ),
    .rx_req         (lp_flush_rx_req    ),
    .tx_req         (lp_flush_tx_req    ),
    .stall          (flush_sync_stall   ),
    .trans_idle     (flush_sync_idle    ),
    .timeout_val    (timeout_val        )
);

lwnoc_lp_tniu_async_bridge u_lp_tniu_afifo_mst_bridge (
    .clk       (clk_atb_m            ),
    .rst_n     (rstn_atb_m           ),
    .rx_req    (lp_afifo_mst_rx_req  ),
    .tx_req    (lp_afifo_mst_tx_req  ),
    .stall_ptr (afifo_mst_stall      ),
    .clear_ptr (afifo_mst_clear      ),
    // niu_atb_mst exposes both read_idle and full_zero.  read_idle is the
    // proper stage1 OFF ack (no pending read-side transactions); full_zero
    // is the stage2 OFF ack (FIFO appears empty from the read pointer).
    .trans_idle(afifo_mst_read_idle  ),
    .full_zero (afifo_mst_full_zero  )
);

endmodule
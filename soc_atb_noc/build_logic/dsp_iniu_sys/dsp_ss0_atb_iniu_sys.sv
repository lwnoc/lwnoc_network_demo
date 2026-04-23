module dsp_ss0_atb_iniu_sys
import dsp_ss0_lw_atb_noc_pack::*;
import lwnoc_lp_define_package::*;
import lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0 ,
    parameter integer unsigned SYNC_STAGE   = 2 ,
    parameter integer unsigned SYNC_BUF_DEPTH = 2,
    localparam int LP_REQ_WIDTH = $bits(lwnoc_lp_req_signal_t)
)(
    input   logic                       clk_atb_s,
    input   logic                       rstn_atb_s,
    // Data
    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    // Flush
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    // Synchronization Request,sync directly
    output  logic                       s_syncreq,
    // Wakeup
    input   logic                       s_atwakeup,

    //===================================================
    // Flush and Synchronization
    //===================================================
    input   logic                       flush_req,

    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [ATB_PLD_WIDTH:0]     pld_sync,

    input   logic                       syncreq_level,

    //===================================================
    // Power Control: pchannel interface
    //===================================================
    input   logic                       preq,
    input   lwnoc_pchannel_state_t      pstate,
    output  lwnoc_pchannel_active_t     pactive,
    output  logic                       paccept,
    output  logic                       pdeny,

    //===================================================
    // LP Channels: two external req/tx pairs
    //===================================================
    // LP channel: exported toward atb_iniu_noc hub3t (connects to iniu_noc.lw_rx/tx)
    input   logic [LP_REQ_WIDTH-1:0]    lwnoc_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    lwnoc_tx_req,

    // LP channel: exported toward atb_tniu_noc AFIFO master-side bridge
    input   logic [LP_REQ_WIDTH-1:0]    afifo_slv_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    afifo_slv_tx_req,

    input   logic [9:0]                 timeout_val
);

    logic                       b4_pack_atvalid;
    logic                       b4_pack_atready;
    logic [ATB_BYTES_WIDTH-1:0] b4_pack_atbytes;
    logic [ATB_DATA_WIDTH-1:0]  b4_pack_atdata;
    logic [ATB_ID_WIDTH-1:0]    b4_pack_atid;
    logic                       b4_pack_afvalid;
    logic                       b4_pack_afready;
    logic                       b4_pack_syncreq;
    logic                       b4_pack_atwakeup;

    logic                       partial_reset;
    logic                       flush_partial_idle;
    logic                       afifo_slv_stall;
    logic                       afifo_slv_clear;
    logic                       afifo_slv_full_zero;
    logic                       sync_buf_stall;
    logic                       sync_buf_clear;
    logic                       sync_buf_idle;

    //=== Local 5-terminal LP hub ===
    lwnoc_lp_req_signal_t       v_lp_local_hub_rx_req [5-1:0];
    lwnoc_lp_req_signal_t       v_lp_local_hub_tx_req [5-1:0];
    //=== Sub-hub 3-terminal after nest ===
    lwnoc_lp_req_signal_t       v_lp_sub_hub_rx_req   [3-1:0];
    lwnoc_lp_req_signal_t       v_lp_sub_hub_tx_req   [3-1:0];

    //=== LP signal paths ===
    lwnoc_lp_req_signal_t       lp_iniu_rx_req;
    lwnoc_lp_req_signal_t       lp_iniu_tx_req;
    lwnoc_lp_req_signal_t       lp_lwnoc_rx_req;
    lwnoc_lp_req_signal_t       lp_lwnoc_tx_req;
    lwnoc_lp_req_signal_t       lp_flush_rx_req;
    lwnoc_lp_req_signal_t       lp_flush_tx_req;
    lwnoc_lp_req_signal_t       lp_sync_buf_rx_req;
    lwnoc_lp_req_signal_t       lp_sync_buf_tx_req;
    lwnoc_lp_req_signal_t       lp_nest_main_rx_req;
    lwnoc_lp_req_signal_t       lp_nest_main_tx_req;
    lwnoc_lp_req_signal_t       lp_nest_sub_rx_req;
    lwnoc_lp_req_signal_t       lp_nest_sub_tx_req;
    lwnoc_lp_req_signal_t       lp_afifo_slv_rx_req;
    lwnoc_lp_req_signal_t       lp_afifo_slv_tx_req;
    lwnoc_lp_req_signal_t       lp_afifo_slv_internal_rx_req;
    lwnoc_lp_req_signal_t       lp_afifo_slv_internal_tx_req;

    //=== Assign external ports to internal LP signals ===
    assign lp_lwnoc_rx_req     = lwnoc_lp_req_signal_t'(lwnoc_rx_req);
    assign lwnoc_tx_req        = lp_lwnoc_tx_req;

    assign lp_afifo_slv_rx_req = lwnoc_lp_req_signal_t'(afifo_slv_rx_req);
    assign afifo_slv_tx_req    = lp_afifo_slv_tx_req;

    //=== Local 5-terminal LP hub: pchannel -> lp_iniu -> hub5t ===
    // [0] lp_iniu: handles pchannel (preq/pstate/pactive)
    // [1] flush packer func_tniu (partial reset control)
    // [2] sync buffer LP bridge
    // [3] lp_nest main-side port
    // [4] lwnoc-side LP req port (toward iniu_noc hub3t)
    assign v_lp_local_hub_rx_req[0] = lp_iniu_tx_req;
    assign lp_iniu_rx_req           = v_lp_local_hub_tx_req[0];

    assign v_lp_local_hub_rx_req[1] = lp_flush_tx_req;
    assign lp_flush_rx_req          = v_lp_local_hub_tx_req[1];

    assign v_lp_local_hub_rx_req[2] = lp_sync_buf_tx_req;
    assign lp_sync_buf_rx_req       = v_lp_local_hub_tx_req[2];

    assign v_lp_local_hub_rx_req[3] = lp_nest_main_tx_req;
    assign lp_nest_main_rx_req      = v_lp_local_hub_tx_req[3];

    assign v_lp_local_hub_rx_req[4] = lp_lwnoc_rx_req;
    assign lp_lwnoc_tx_req          = v_lp_local_hub_tx_req[4];

    //=== Local 3-terminal LP sub-hub after lp_nest: async_fifo_slv chain ===
    // [0] lp_nest sub-side port
    // [1] internal AFIFO slave LP bridge
    // [2] exported port toward atb_tniu_noc AFIFO master-side bridge
    assign v_lp_sub_hub_rx_req[0] = lp_nest_sub_tx_req;
    assign lp_nest_sub_rx_req     = v_lp_sub_hub_tx_req[0];

    assign v_lp_sub_hub_rx_req[1] = lp_afifo_slv_internal_tx_req;
    assign lp_afifo_slv_internal_rx_req = v_lp_sub_hub_tx_req[1];

    assign v_lp_sub_hub_rx_req[2] = lp_afifo_slv_rx_req;
    assign lp_afifo_slv_tx_req    = v_lp_sub_hub_tx_req[2];

    dsp_ss0_flush_partial_reset u_flush_partial_reset (
        .clk            (clk_atb_s          ),
        .rst_n          (rstn_atb_s         ),
        .s_atvalid      (s_atvalid          ),
        .s_atready      (s_atready          ),
        .s_atbytes      (s_atbytes          ),
        .s_atdata       (s_atdata           ),
        .s_atid         (s_atid             ),
        .s_afvalid      (s_afvalid          ),
        .s_afready      (s_afready          ),
        .s_syncreq      (s_syncreq          ),
        .s_atwakeup     (s_atwakeup         ),
        .m_atvalid      (b4_pack_atvalid    ),
        .m_atready      (b4_pack_atready    ),
        .m_atbytes      (b4_pack_atbytes    ),
        .m_atdata       (b4_pack_atdata     ),
        .m_atid         (b4_pack_atid       ),
        .m_afvalid      (b4_pack_afvalid    ),
        .m_afready      (b4_pack_afready    ),
        .m_syncreq      (b4_pack_syncreq    ),
        .m_atwakeup     (b4_pack_atwakeup   ),
        .partial_reset  (partial_reset      ),
        .idle           (flush_partial_idle )
    );
    
    dsp_ss0_niu_atb_slv #(
        .FIFO_DEPTH     (FIFO_DEPTH    ),
        .AUTO_CLEAR_EN  (AUTO_CLEAR_EN ),
        .SYNC_STAGE     (SYNC_STAGE    ),
        .SYNC_BUF_EN    (1             ),
        .SYNC_BUF_DEPTH (SYNC_BUF_DEPTH)
    ) u_niu_atb_slv (
        .clk_atb_s          (clk_atb_s          ),
        .rstn_atb_s         (rstn_atb_s         ),
        .s_atvalid          (b4_pack_atvalid    ),
        .s_atready          (b4_pack_atready    ),
        .s_atbytes          (b4_pack_atbytes    ),
        .s_atdata           (b4_pack_atdata     ),
        .s_atid             (b4_pack_atid       ),
        .s_afvalid          (b4_pack_afvalid    ),
        .s_afready          (b4_pack_afready    ),
        .s_syncreq          (b4_pack_syncreq    ),
        .s_atwakeup         (b4_pack_atwakeup   ),
        .flush_req          (flush_req          ),
        .afifo_slv_stall    (afifo_slv_stall    ),
        .afifo_slv_clear    (afifo_slv_clear    ),
        .afifo_slv_full_zero(afifo_slv_full_zero),
        .sync_buf_stall     (sync_buf_stall     ),
        .sync_buf_clear     (sync_buf_clear     ),
        .sync_buf_idle      (sync_buf_idle      ),
        .wptr_async         (wptr_async         ),
        .rptr_async         (rptr_async         ),
        .rptr_sync          (rptr_sync          ),
        .pld_sync           (pld_sync           ),
        .syncreq_level      (syncreq_level      )
    );

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL(5)
    ) u_lp_local_hub (
        .v_rx_req(v_lp_local_hub_rx_req),
        .v_tx_req(v_lp_local_hub_tx_req)
    );

    lwnoc_lp_nest u_lp_nest (
        .clk        (clk_atb_s           ),
        .rst_n      (rstn_atb_s          ),
        .rx_req_main(lp_nest_main_rx_req ),
        .tx_req_main(lp_nest_main_tx_req ),
        .rx_req_sub (lp_nest_sub_rx_req  ),
        .tx_req_sub (lp_nest_sub_tx_req  )
    );

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL(3)
    ) u_lp_sub_hub (
        .v_rx_req(v_lp_sub_hub_rx_req),
        .v_tx_req(v_lp_sub_hub_tx_req)
    );

    lwnoc_lp_tniu_func_tniu u_lp_flush_packer (
        .clk            (clk_atb_s          ),
        .rst_n          (rstn_atb_s         ),
        .rx_req         (lp_flush_rx_req    ),
        .tx_req         (lp_flush_tx_req    ),
        .partial_reset  (partial_reset      ),
        .trans_idle     (flush_partial_idle ),
        .timeout_val    (timeout_val        )
    );

    lwnoc_lp_tniu_async_bridge u_lp_iniu_sync_buf_bridge (
        .clk       (clk_atb_s        ),
        .rst_n     (rstn_atb_s       ),
        .rx_req    (lp_sync_buf_rx_req),
        .tx_req    (lp_sync_buf_tx_req),
        .stall_ptr (sync_buf_stall   ),
        .clear_ptr (sync_buf_clear   ),
        // fcip_sync_fifo_reg currently exposes only idle. It has no separate
        // drained/full_zero signal, and the current library implementation does
        // not consume clear internally, so both LP stages conservatively wait
        // on the same idle observation.
        .trans_idle(sync_buf_idle    ),
        .full_zero (sync_buf_idle    )
    );

    lwnoc_lp_iniu u_lp_iniu (
        .clk    (clk_atb_s      ),
        .rst_n  (rstn_atb_s     ),
        .rx_req (lp_iniu_rx_req ),
        .tx_req (lp_iniu_tx_req ),
        .preq   (preq           ),
        .pstate (pstate         ),
        .pactive(pactive        ),
        .paccept(paccept        ),
        .pdeny  (pdeny          )
    );

    lwnoc_lp_tniu_async_bridge u_lp_iniu_afifo_slv_bridge (
        .clk       (clk_atb_s                  ),
        .rst_n     (rstn_atb_s                 ),
        .rx_req    (lp_afifo_slv_internal_rx_req ),
        .tx_req    (lp_afifo_slv_internal_tx_req ),
        .stall_ptr (afifo_slv_stall            ),
        .clear_ptr (afifo_slv_clear            ),
        // niu_atb_slv only exposes full_zero, so stage1 uses the same
        // conservative proxy as stage2 for safe OFF sequencing.
        .trans_idle(afifo_slv_full_zero        ),
        .full_zero (afifo_slv_full_zero        )
    );

endmodule
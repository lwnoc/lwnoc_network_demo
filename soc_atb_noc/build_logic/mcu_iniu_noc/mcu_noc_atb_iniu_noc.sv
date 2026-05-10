module mcu_noc_atb_iniu_noc
import mcu_noc_lw_atb_noc_pack::*;
import lwnoc_lp_define_package::*;
import lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned FIFO_DEPTH        = `mcu_noc_ATB_INIU_FIFO_DEPTH,
    parameter integer unsigned AUTO_CLEAR_EN     = `mcu_noc_ATB_INIU_AUTO_CLEAR_EN,
    parameter integer unsigned SYNC_STAGE        = `mcu_noc_ATB_INIU_SYNC_STAGE,
    parameter integer unsigned ERR_INT_CNT_WIDTH = `mcu_noc_ATB_INIU_ERR_INT_CNT_WIDTH,
    localparam int LP_REQ_WIDTH = ATB_LP_REQ_WIDTH
) (
    input   logic                       clk_atb_m,
    input   logic                       rstn_atb_m,
    //===================================================
    //Master Interface with downstream Trace module
    //===================================================
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

    //===================================================
    //Interface with niu slv
    //===================================================
    output  logic                       syncreq_level,
    output  logic                       flush_req_level,
    output  logic                       atb_iniu_afifo_sb_err,
    output  logic                       atb_iniu_afifo_db_err,

    // LP channel: AFIFO master-side bridge <-> LP hub
    input   logic [LP_REQ_WIDTH-1:0]    afifo_mst_rx_req,
    output  logic [LP_REQ_WIDTH-1:0]    afifo_mst_tx_req,

    //control signals
    input  logic [FIFO_DEPTH-1:0]   wptr_async,
    output logic [FIFO_DEPTH-1:0]   rptr_async,
    output logic [FIFO_DEPTH-1:0]   rptr_sync,
    input  logic [ATB_AFIFO_W:0]    pld_sync,

    input   logic [LP_REQ_WIDTH-1:0] lw_rx_req,
    output  logic [LP_REQ_WIDTH-1:0] lw_tx_req,

    input   logic [9:0]              timeout_val

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

    logic                       pre_flush_atvalid;
    logic                       pre_flush_atready;
    logic [ATB_BYTES_WIDTH-1:0] pre_flush_atbytes;
    logic [ATB_DATA_WIDTH-1:0]  pre_flush_atdata;
    logic [ATB_ID_WIDTH-1:0]    pre_flush_atid;
    logic                       pre_flush_afvalid;
    logic                       pre_flush_afready;
    logic                       pre_flush_syncreq;
    logic                       pre_flush_atwakeup;

    logic                       idle;
    logic                       flush_soft_switch;
    logic                       flush_switch_done;
    logic                       flush_hard_switch;
    logic                       unpacker_hard_switch;
    logic                       unpacker_switch_done;

    logic                       afifo_mst_stall;
    logic                       afifo_mst_clear;
    logic                       afifo_mst_full_zero;
    logic                       afifo_mst_read_idle;

    lwnoc_lp_req_signal_t       v_lp_hub_rx_req [3-1:0];
    lwnoc_lp_req_signal_t       v_lp_hub_tx_req [3-1:0];
    lwnoc_lp_req_signal_t       lp_uplink_rx_req;
    lwnoc_lp_req_signal_t       lp_unpacker_rx_req;
    lwnoc_lp_req_signal_t       lp_unpacker_tx_req;
    lwnoc_lp_req_signal_t       lp_flush_rx_req;
    lwnoc_lp_req_signal_t       lp_flush_tx_req;
    lwnoc_lp_req_signal_t       lp_afifo_mst_rx_req;
    lwnoc_lp_req_signal_t       lp_afifo_mst_tx_req;

    assign lp_uplink_rx_req    = lwnoc_lp_req_signal_t'(lw_rx_req);
    assign lw_tx_req           = v_lp_hub_tx_req[0];

    assign v_lp_hub_rx_req[0]  = lp_uplink_rx_req;
    assign v_lp_hub_rx_req[1]  = lp_unpacker_tx_req;
    assign lp_unpacker_rx_req  = v_lp_hub_tx_req[1];
    assign v_lp_hub_rx_req[2]  = lp_flush_tx_req;
    assign lp_flush_rx_req     = v_lp_hub_tx_req[2];

    assign lp_afifo_mst_rx_req = lwnoc_lp_req_signal_t'(afifo_mst_rx_req);
    assign afifo_mst_tx_req    = lp_afifo_mst_tx_req;

    lwnoc_lp_hub_3terminal u_lp_hub_3terminal (
        .v_rx_req (v_lp_hub_rx_req),
        .v_tx_req (v_lp_hub_tx_req)
    );

    mcu_noc_niu_atb_mst #(
        .FIFO_DEPTH   (FIFO_DEPTH   ),
        .AUTO_CLEAR_EN(AUTO_CLEAR_EN),
        .SYNC_STAGE   (SYNC_STAGE   ),
        .ERR_INT_CNT_WIDTH(ERR_INT_CNT_WIDTH)
    ) u_niu_atb_mst (
        .clk_atb_m              (clk_atb_m              ),
        .rstn_atb_m             (rstn_atb_m             ),
        .m_atvalid              (tmp_atvalid            ),
        .m_atready              (tmp_atready            ),
        .m_atbytes              (tmp_atbytes            ),
        .m_atdata               (tmp_atdata             ),
        .m_atid                 (tmp_atid               ),
        .m_afvalid              (tmp_afvalid            ),
        .m_afready              (tmp_afready            ),
        .m_syncreq              (tmp_syncreq            ),
        .m_atwakeup             (tmp_atwakeup           ),
        .syncreq_level          (syncreq_level          ),
        .flush_req_level        (flush_req_level        ),
        .afifo_mst_stall        (afifo_mst_stall        ),
        .afifo_mst_clear        (afifo_mst_clear        ),
        .afifo_mst_full_zero    (afifo_mst_full_zero    ),
        .afifo_mst_read_idle    (afifo_mst_read_idle    ),
        .afifo_mst_sb_err       (atb_iniu_afifo_sb_err  ),
        .afifo_mst_db_err       (atb_iniu_afifo_db_err  ),
        .wptr_async             (wptr_async             ),
        .rptr_async             (rptr_async             ),
        .rptr_sync              (rptr_sync              ),
        .pld_sync               (pld_sync               )
    );

    mcu_noc_flush_dummy_mst u_flush_unpacker (
        .clk        (clk_atb_m          ),
        .rst_n      (rstn_atb_m         ),
        .s_atvalid  (tmp_atvalid        ),
        .s_atready  (tmp_atready        ),
        .s_atbytes  (tmp_atbytes        ),
        .s_atdata   (tmp_atdata         ),
        .s_atid     (tmp_atid           ),
        .s_afvalid  (tmp_afvalid        ),
        .s_afready  (tmp_afready        ),
        .s_syncreq  (tmp_syncreq        ),
        .s_atwakeup (tmp_atwakeup       ),
        .m_atvalid  (pre_flush_atvalid  ),
        .m_atready  (pre_flush_atready  ),
        .m_atbytes  (pre_flush_atbytes  ),
        .m_atdata   (pre_flush_atdata   ),
        .m_atid     (pre_flush_atid     ),
        .m_afvalid  (pre_flush_afvalid  ),
        .m_afready  (pre_flush_afready  ),
        .m_syncreq  (pre_flush_syncreq  ),
        .m_atwakeup (pre_flush_atwakeup ),
        .swicth     (unpacker_hard_switch),
        .soft_switch(1'b0               ),
        .hard_switch(unpacker_hard_switch),
        .switch_done(unpacker_switch_done)
    );

    mcu_noc_flush_default_slv u_flush_default_slv (
        .clk        (clk_atb_m      ),
        .rst_n      (rstn_atb_m     ),
        .s_atvalid  (pre_flush_atvalid  ),
        .s_atready  (pre_flush_atready  ),
        .s_atbytes  (pre_flush_atbytes  ),
        .s_atdata   (pre_flush_atdata   ),
        .s_atid     (pre_flush_atid     ),
        .s_afvalid  (pre_flush_afvalid  ),
        .s_afready  (pre_flush_afready  ),
        .s_syncreq  (pre_flush_syncreq  ),
        .s_atwakeup (pre_flush_atwakeup ),
        .m_atvalid  (m_atvalid      ),
        .m_atready  (m_atready      ),
        .m_atbytes  (m_atbytes      ),
        .m_atdata   (m_atdata       ),
        .m_atid     (m_atid         ),
        .m_afvalid  (m_afvalid      ),
        .m_afready  (m_afready      ),
        .m_syncreq  (m_syncreq      ),
        .m_atwakeup (m_atwakeup     ),
        .idle       (idle           ),
        .soft_switch(flush_soft_switch),
        .hard_switch(flush_hard_switch),
        .switch_done(flush_switch_done)
    );

    lwnoc_lp_tniu_async_bridge u_lp_iniu_afifo_mst_bridge (
        .clk       (clk_atb_m           ),
        .rst_n     (rstn_atb_m          ),
        .rx_req    (lp_afifo_mst_rx_req ),
        .tx_req    (lp_afifo_mst_tx_req ),
        .stall_ptr (afifo_mst_stall     ),
        .clear_ptr (afifo_mst_clear     ),
        .trans_idle(afifo_mst_read_idle ),
        .full_zero (afifo_mst_full_zero )
    );

    lwnoc_lp_tniu_dummy_mst u_lp_iniu_unpacker_mst (
        .clk        (clk_atb_m          ),
        .rst_n      (rstn_atb_m         ),
        .rx_req     (lp_unpacker_rx_req ),
        .tx_req     (lp_unpacker_tx_req ),
        .hard_switch(unpacker_hard_switch),
        .switch_done(unpacker_switch_done),
        .timeout_val(timeout_val        )
    );

    lwnoc_lp_tniu_default_slv u_lp_iniu_flush_slv (
        .clk        (clk_atb_m          ),
        .rst_n      (rstn_atb_m         ),
        .rx_req     (lp_flush_rx_req    ),
        .tx_req     (lp_flush_tx_req    ),
        .hard_switch(flush_hard_switch  ),
        .soft_switch(flush_soft_switch  ),
        .switch_done(flush_switch_done  ),
        .trans_idle (idle               ),
        .timeout_val(timeout_val        )
    );

endmodule

module cpu_noc_niu_atb_mst
import cpu_noc_lw_atb_noc_pack::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2,
    parameter integer unsigned ERR_INT_CNT_WIDTH = 16,
    localparam integer unsigned DATA_WIDTH = ATB_TRANS_WIDTH
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

    //power down
    input  logic                        afifo_mst_stall,
    input  logic                        afifo_mst_clear,
    output logic                        afifo_mst_full_zero,
    output logic                        afifo_mst_read_idle,
    output logic                        afifo_mst_sb_err,
    output logic                        afifo_mst_db_err,

    //control signals
    input  logic [FIFO_DEPTH-1:0]       wptr_async,
    output logic [FIFO_DEPTH-1:0]       rptr_async,
    output logic [FIFO_DEPTH-1:0]       rptr_sync,
    input  logic [ATB_AFIFO_W:0]        pld_sync
);

    logic           atb_vld;
    logic           atb_rdy;
    atb_trans_typ   atb_pld;
    logic [ATB_AFIFO_W-1:0] atb_pld_ecc;
    logic [ATB_PLD_WIDTH-1:0] atb_pld_dec;
    logic           afifo_sb_err_raw;
    logic           afifo_db_err_raw;

assign atb_pld = atb_trans_typ'(atb_pld_dec);

fcip_afifo_mst #(
    .FIFO_DEPTH     (FIFO_DEPTH),
    .DATA_WIDTH     (ATB_AFIFO_W),
    .AUTO_CLEAR_EN  (AUTO_CLEAR_EN),
    .SYNC_STAGE     (SYNC_STAGE)
) u_afifo_mst(
    .clk        (clk_atb_m),
    .rst_n      (rstn_atb_m),

    .stall      (afifo_mst_stall),
    .clear      (afifo_mst_clear),
    .full_zero  (afifo_mst_full_zero),
    .idle       (afifo_mst_read_idle),

    .m_vld      (atb_vld),
    .m_pld      (atb_pld_ecc),
    .m_rdy      (atb_rdy),

    .almost_empty (                  ),

    .wptr_async (wptr_async),
    .rptr_async (rptr_async),
    .rptr_sync  (rptr_sync),
    .pld_sync   (pld_sync)
);

fcip_ecc_dec #(.DATA_WIDTH(ATB_PLD_WIDTH)) u_atb_afifo_ecc_dec (
    .encode_data(atb_pld_ecc),
    .data       (atb_pld_dec),
    .sb_err     (afifo_sb_err_raw),
    .db_err     (afifo_db_err_raw)
);

fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_atb_afifo_pulse_sb (
    .clk     (clk_atb_m),
    .rst_n   (rstn_atb_m),
    .err_in  (afifo_sb_err_raw),
    .intr_out(afifo_mst_sb_err)
);

fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_atb_afifo_pulse_db (
    .clk     (clk_atb_m),
    .rst_n   (rstn_atb_m),
    .err_in  (afifo_db_err_raw),
    .intr_out(afifo_mst_db_err)
);

cpu_noc_atb_niu_unpacker u_niu_atb_unpacker (
    .clk_atb_m      (clk_atb_m      ),
    .rstn_atb_m     (rstn_atb_m     ),
    .m_atvalid      (m_atvalid      ),
    .m_atready      (m_atready      ),
    .m_atbytes      (m_atbytes      ),
    .m_atdata       (m_atdata       ),
    .m_atid         (m_atid         ),
    .m_afvalid      (m_afvalid      ),
    .m_afready      (m_afready      ),
    .m_syncreq      (m_syncreq      ),
    .m_atwakeup     (m_atwakeup     ),
    .flush_req_async(flush_req_level),
    .sync_req_async (syncreq_level),
    .m_vld          (atb_vld        ),
    .m_rdy          (atb_rdy        ),
    .m_pld          (atb_pld        )
);


endmodule

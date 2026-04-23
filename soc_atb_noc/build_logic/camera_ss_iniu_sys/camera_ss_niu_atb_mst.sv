module camera_ss_niu_atb_mst
import camera_ss_lw_atb_noc_pack::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2,
    localparam integer unsigned DATA_WIDTH = $bits(atb_trans_typ)
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

    //control signals
    input  logic [FIFO_DEPTH-1:0]       wptr_async,
    output logic [FIFO_DEPTH-1:0]       rptr_async,
    output logic [FIFO_DEPTH-1:0]       rptr_sync,
    input  logic [ATB_PLD_WIDTH:0]      pld_sync
);

    logic           atb_vld;
    logic           atb_rdy;
    atb_trans_typ   atb_pld;

fcip_afifo_mst #(
    .FIFO_DEPTH     (FIFO_DEPTH),
    .DATA_WIDTH     (ATB_PLD_WIDTH),
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
    .m_pld      (atb_pld),
    .m_rdy      (atb_rdy),

    .wptr_async (wptr_async),
    .rptr_async (rptr_async),
    .rptr_sync  (rptr_sync),
    .pld_sync   (pld_sync)
);

camera_ss_atb_niu_unpacker u_niu_atb_unpacker (
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
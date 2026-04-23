module dsp_ss5_niu_atb_slv
import dsp_ss5_lw_atb_noc_pack::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2,
    parameter integer unsigned SYNC_BUF_EN  = 0,
    parameter integer unsigned SYNC_BUF_DEPTH = 2,
    localparam integer unsigned ATB_PLD_WIDTH = $bits(atb_trans_typ)

) (
    input   logic                       clk_atb_s,
    input   logic                       rstn_atb_s,
    //===================================================
    // Slave Interface,from Trace Source to niu slv
    //===================================================
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
    // Master Interface,from niu slv to niu mst
    //===================================================
    input   logic                       flush_req,

    // AFIFO slave
    input   logic                       afifo_slv_stall,
    input   logic                       afifo_slv_clear,
    output  logic                       afifo_slv_full_zero,

    input   logic                       sync_buf_stall,
    input   logic                       sync_buf_clear,
    output  logic                       sync_buf_idle,

    output  logic [FIFO_DEPTH-1:0]      wptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_async,
    input   logic [FIFO_DEPTH-1:0]      rptr_sync,
    output  logic [ATB_PLD_WIDTH:0]     pld_sync,

    input   logic                       syncreq_level

    // //lowpower
    // input   logic                       atb_pack_stall,
    // output  logic                       atb_pack_trans_idle

);
    localparam integer unsigned SYNC_BUF_ALMOST_FULL_THRESHOLD =
        (SYNC_BUF_DEPTH <= 2) ? 1 : (SYNC_BUF_DEPTH - 1);
    localparam integer unsigned SYNC_BUF_ALMOST_EMPTY_THRESHOLD = 1;

    logic                       atb_packer_vld;
    logic                       atb_packer_rdy;
    logic [ATB_PLD_WIDTH-1:0]   atb_packer_pld;
    logic                       atb_afifo_vld;
    logic                       atb_afifo_rdy;
    logic [ATB_PLD_WIDTH-1:0]   atb_afifo_pld;

    // pragma translate_off
    initial begin
        if (SYNC_BUF_EN && (SYNC_BUF_DEPTH < 2)) begin
            $error("[niu_atb_slv] SYNC_BUF_DEPTH (%0d) must be >= 2 when SYNC_BUF_EN is enabled",
                   SYNC_BUF_DEPTH);
        end
    end
    // pragma translate_on

    dsp_ss5_atb_niu_packer #(
        .FIFO_DEPTH   (FIFO_DEPTH),
        .AUTO_CLEAR_EN(AUTO_CLEAR_EN),
        .SYNC_STAGE   (SYNC_STAGE)
    ) u_niu_atb_packer (
        .clk_atb_s          (clk_atb_s       ),
        .rstn_atb_s         (rstn_atb_s      ),
        .s_atvalid          (s_atvalid       ),
        .s_atready          (s_atready       ),
        .s_atbytes          (s_atbytes       ),
        .s_atdata           (s_atdata        ),
        .s_atid             (s_atid          ),
        .s_afvalid          (s_afvalid       ),
        .s_afready          (s_afready       ),
        .s_syncreq          (s_syncreq       ),
        .s_atwakeup         (s_atwakeup      ),
        .flush_req_synced   (flush_req       ),
        .sync_req_synced    (syncreq_level   ),
        .m_vld              (atb_packer_vld  ),
        .m_rdy              (atb_packer_rdy  ),
        .m_pld              (atb_packer_pld  )
        // .stall              (atb_pack_stall     ),
        // .trans_idle         (atb_pack_trans_idle),
        // .syncreq_level      (syncreq_level   )
    );

    generate
        if (SYNC_BUF_EN) begin : g_sync_buf
            fcip_sync_fifo_reg #(
                .FIFO_DEPTH             (SYNC_BUF_DEPTH                  ),
                .FIFO_WIDTH             (ATB_PLD_WIDTH                   ),
                .ALMOST_FULL_THRESHOLD  (SYNC_BUF_ALMOST_FULL_THRESHOLD  ),
                .ALMOST_EMPTY_THRESHOLD (SYNC_BUF_ALMOST_EMPTY_THRESHOLD ),
                .FORWARD_EN             (1                               )
            ) u_sync_buf (
                .clk            (clk_atb_s       ),
                .rst_n          (rstn_atb_s      ),
                .stall          (sync_buf_stall  ),
                .clear          (sync_buf_clear  ),
                .idle           (sync_buf_idle   ),
                .write_req_vld  (atb_packer_vld  ),
                .write_req_pld  (atb_packer_pld  ),
                .write_req_rdy  (atb_packer_rdy  ),
                .read_resp_vld  (atb_afifo_vld   ),
                .read_resp_pld  (atb_afifo_pld   ),
                .read_resp_rdy  (atb_afifo_rdy   ),
                .almost_full    (                ),
                .almost_empty   (                ),
                .empty          (                ),
                .full           (                )
            );
        end
        else begin : g_bypass_sync_buf
            assign sync_buf_idle = 1'b1;
            assign atb_afifo_vld = atb_packer_vld;
            assign atb_afifo_pld = atb_packer_pld;
            assign atb_packer_rdy = atb_afifo_rdy;
        end
    endgenerate
 
    fcip_afifo_slv #(
        .FIFO_DEPTH     (FIFO_DEPTH    ),
        .DATA_WIDTH     (ATB_PLD_WIDTH ),
        .AUTO_CLEAR_EN  (AUTO_CLEAR_EN ),
        .SYNC_STAGE     (SYNC_STAGE    )
    ) u_afifo_slv (
        .clk            (clk_atb_s),
        .rst_n          (rstn_atb_s),
        .stall          (afifo_slv_stall),
        .clear          (afifo_slv_clear),
        .full_zero      (afifo_slv_full_zero),
        .s_vld          (atb_afifo_vld),
        .s_pld          (atb_afifo_pld),
        .s_rdy          (atb_afifo_rdy),
        .almost_full    (),
        .wptr_async     (wptr_async),
        .rptr_async     (rptr_async),
        .rptr_sync      (rptr_sync),
        .pld_sync       (pld_sync)
    );
    
endmodule
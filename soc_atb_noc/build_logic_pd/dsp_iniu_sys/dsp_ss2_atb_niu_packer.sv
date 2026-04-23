module dsp_ss2_atb_niu_packer
import dsp_ss2_lw_atb_noc_pack::*;
#(
    parameter integer unsigned FIFO_DEPTH   = 16,
    parameter integer unsigned AUTO_CLEAR_EN= 0,
    parameter integer unsigned SYNC_STAGE   = 2
) (
    input   logic clk_atb_s,
    input   logic rstn_atb_s,
    //===================================================
    // Slave Interface,from Trace Source to niu slv
    //===================================================
    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    output  logic                       s_syncreq,
    input   logic                       s_atwakeup,

    //===================================================
    // Master Interface,from niu slv to niu mst
    //===================================================
    input   logic                       flush_req_synced,
    input   logic                       sync_req_synced,

    output  logic                       m_vld,
    input   logic                       m_rdy,
    output  atb_trans_typ               m_pld

    // input   logic                       stall,
    // output  logic                       trans_idle,
    // input   logic                       syncreq_level
);

    logic s_atready_tmp;
    logic syncreq_d;

    logic                       atvalid_d;
    logic                       atready_d;
    logic [ATB_BYTES_WIDTH-1:0] atbytes_d;
    logic [ATB_DATA_WIDTH-1:0]  atdata_d;
    logic [ATB_ID_WIDTH-1:0]    atid_d;
    logic                       atwakeup_d;

    always_ff @(posedge clk_atb_s or negedge rstn_atb_s) begin
        if (!rstn_atb_s) begin
            atvalid_d   <= 1'b0;
            atready_d   <= 1'b0;
            atbytes_d   <= {ATB_BYTES_WIDTH{1'b0}};
            atdata_d    <= {ATB_DATA_WIDTH{1'b0}};
            atid_d      <= {ATB_ID_WIDTH{1'b0}};
            atwakeup_d  <= 1'b0;
        end else begin
            atvalid_d   <= s_atvalid;
            atready_d   <= s_atready;
            atbytes_d   <= s_atbytes;
            atdata_d    <= s_atdata;
            atid_d      <= s_atid;
            atwakeup_d  <= s_atwakeup;
        end
    end

    assign s_atready = s_atready_tmp;

    dsp_ss2_flag_ctrl u_flag_ctrl (
        .clk                (clk_atb_s          ),
        .rst_n               (rstn_atb_s         ),
        .s_atvalid          (atvalid_d          ),
        .s_atready          (s_atready_tmp      ),
        .s_atbytes          (atbytes_d          ),
        .s_atdata           (atdata_d           ),
        .s_atid             (atid_d             ),
        .s_afvalid          (s_afvalid          ),
        .s_afready          (s_afready          ),
        .s_syncreq          (s_syncreq          ),
        .s_atwakeup         (atwakeup_d         ),
        .flush_req_synced   (flush_req_synced   ),
        .sync_req_synced    (sync_req_synced    ),
        .m_vld              (m_vld              ),
        .m_rdy              (m_rdy              ),
        .m_pld              (m_pld              ),
        .flush_done         (flush_done         ) //used for stall TODO
    );



    
endmodule
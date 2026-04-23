module debug_tniu_ss_atb_niu_unpacker
import debug_tniu_ss_lw_atb_noc_pack::*;
(
    input   logic clk_atb_m,
    input   logic rstn_atb_m,
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
    output  logic                       flush_req_async,  
    output  logic                       sync_req_async,

    input   logic                       m_vld,
    output  logic                       m_rdy,
    input   atb_trans_typ               m_pld

    // input   logic                       stall,
    // output  logic                       trans_idle
);

logic m_vld_tmp;
logic m_afvalid_tmp;
logic sync_req_done;
logic flush_done_d;
logic flush_done_pulse;
logic flush_done_pending;
logic flush_resp_done;
logic has_trace_payload;
logic trace_can_flush;
logic trace_hs;
logic flush_done;

// assign m_vld_tmp  = m_vld && !stall;
assign m_vld_tmp  = m_vld;
assign {m_atdata, m_atid, m_atbytes, m_atwakeup,flush_done,sync_req_done} = m_pld;
assign has_trace_payload = (|m_atbytes) || (|m_atid) || (|m_atdata) || m_atwakeup;
assign m_atvalid  = m_vld_tmp && has_trace_payload;
assign m_rdy      = has_trace_payload ? m_atready : m_vld_tmp;
assign trace_can_flush = !m_atvalid || m_atready;
assign trace_hs = trace_can_flush;

always_ff @(posedge clk_atb_m or negedge rstn_atb_m) begin
    if (!rstn_atb_m) begin
        flush_done_d <= 1'b0;
    end else if(flush_done_d ^ flush_done) begin
        flush_done_d <= flush_done;
    end
end

always_ff @(posedge clk_atb_m or negedge rstn_atb_m) begin
    if (!rstn_atb_m) begin
        flush_done_pending <= 1'b0;
    end else if (m_afvalid && m_afready) begin
        flush_done_pending <= 1'b0;
    end else if (flush_done_pulse) begin
        flush_done_pending <= 1'b1;
    end
end

assign flush_done_pulse = flush_done && ~flush_done_d;
assign m_afready = flush_done_pending && m_afvalid && trace_can_flush;
assign flush_resp_done = m_afvalid && m_afready;

// assign m_afvalid_tmp = m_afvalid && !stall;
assign m_afvalid_tmp = m_afvalid;

debug_tniu_ss_trig_ctrl u_trig_ctrl (
    .clk            (clk_atb_m      ),
    .rst_n           (rstn_atb_m     ),
    .sync_req_out   (sync_req_async ),
    .sync_req_in    (m_syncreq      ),
    .sync_req_done  (sync_req_done  ),
    .flush_req_out  (flush_req_async),
    .flush_req_in   (m_afvalid      ),
    .flush_req_done (flush_resp_done)
);

endmodule
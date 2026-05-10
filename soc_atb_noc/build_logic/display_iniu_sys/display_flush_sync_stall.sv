// when receive a stall and a flush is done,stall new flush and sync
module display_flush_sync_stall
import display_lw_atb_noc_pack::*;
(
    input   logic                       clk,
    input   logic                       rst_n,

    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    output  logic                       s_syncreq,
    input   logic                       s_atwakeup,

    output  logic                       m_atvalid,
    input   logic                       m_atready,
    output  logic [ATB_BYTES_WIDTH-1:0] m_atbytes,
    output  logic [ATB_DATA_WIDTH-1:0]  m_atdata,
    output  logic [ATB_ID_WIDTH-1:0]    m_atid,
    input   logic                       m_afvalid,
    output  logic                       m_afready,
    input   logic                       m_syncreq,
    output  logic                       m_atwakeup,

    input   logic                       stall,
    output  logic                       idle
);

logic is_flush;
logic flush_pending;
logic m_afready_tmp;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        is_flush <= 1'b0;
    end else if(s_afvalid) begin
        if(s_afready) is_flush <= 1'b0;
        else is_flush <= 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        flush_pending <= 1'b0;
    end else begin
        if (s_afvalid) begin
            if (s_afready) flush_pending <= 1'b0;
        end else if (m_afvalid) begin
            flush_pending <= 1'b1;
        end
    end
end

always_comb begin
    idle = 1'b0;
    if (!s_atvalid) begin
        if (!m_afvalid) begin
            if (!m_syncreq) begin
                if (!flush_pending) idle = 1'b1;
            end
        end
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        m_afready_tmp <= 1'b0;
    end else begin
        if(m_afvalid) begin
            if(m_afready_tmp) m_afready_tmp <= 1'b0;
            else m_afready_tmp <= 1'b1;
        end
    end
end

always_comb begin
    if (stall) begin
        if (s_afvalid) m_afready = s_afready;
        else m_afready = 1'b0;
    end else begin
        m_afready = s_afready;
    end
end

assign s_atready = m_atready;
always_comb begin
    if (stall) begin
        s_afvalid = flush_pending;
    end else begin
        if (m_afvalid) s_afvalid = 1'b1;
        else s_afvalid = flush_pending;
    end
end

assign s_syncreq = m_syncreq;
assign m_atvalid = s_atvalid;
assign m_atbytes = s_atbytes;
assign m_atdata  = s_atdata;
assign m_atid    = s_atid;
assign m_atwakeup= s_atwakeup;

endmodule

module mcu_noc_trace_stall
import mcu_noc_lw_atb_noc_pack::*;
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
    // status indicate if there exist one flush in progress
    logic is_flush;
    logic trace_hs;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trace_hs <= 1'b1;
        end else if (s_atvalid && ~s_atready) begin
            trace_hs <= 1'b0;
        end else if (s_atvalid &&  s_atready) begin
            trace_hs <= 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) is_flush <= 1'b0;
        else if(m_afvalid && m_afready) is_flush <= 1'b0;
        else if(m_afvalid && !m_afready) is_flush <= 1'b1;
    end

    assign m_atvalid = !is_flush ? (stall&&trace_hs ? 1'b0 : s_atvalid) : s_atvalid;

    assign s_atready = m_atready;
    assign s_afvalid = m_afvalid;
    assign s_syncreq = m_syncreq;
    assign m_atbytes = s_atbytes;
    assign m_atdata  = s_atdata;
    assign m_atid    = s_atid;
    assign m_afready = s_afready;
    assign m_atwakeup= s_atwakeup;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) idle <= 1'b0;
        else if(!s_atvalid && !m_afvalid) idle <= 1'b1;
        else idle <= 1'b0;
    end


endmodule

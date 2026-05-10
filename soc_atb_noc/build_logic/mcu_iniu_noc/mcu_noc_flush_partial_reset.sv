module mcu_noc_flush_partial_reset
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

    input   logic                       partial_reset,
    output  logic                       idle
);

    logic is_flush;
    logic flush_pending;
    logic partial_release_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) is_flush <= 1'b0;
        else if(m_afvalid && m_afready) is_flush <= 1'b0;
        else if(m_afvalid && !m_afready) is_flush <= 1'b1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) partial_release_d <= 1'b0;
        else partial_release_d <= is_flush && partial_reset;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            flush_pending <= 1'b0;
        end else begin
            if (s_afvalid && s_afready) flush_pending <= 1'b0;
            else if (m_afvalid) flush_pending <= 1'b1;
        end
    end

    assign m_afready = partial_release_d ? 1'b1 : s_afready;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) idle <= 1'b0;
        else if(!s_atvalid && !m_afvalid && !flush_pending) idle <= 1'b1;
        else idle <= 1'b0;
    end

    assign m_atvalid = s_atvalid;
    assign s_atready = m_atready;
    assign s_afvalid = m_afvalid || flush_pending;
    assign s_syncreq = m_syncreq;
    assign m_atbytes = s_atbytes;
    assign m_atdata  = s_atdata;
    assign m_atid    = s_atid;
    assign m_atwakeup= s_atwakeup;


endmodule

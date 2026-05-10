// This module is used to handle mst side flush command
// when it receives a switch command from LP module,and mask s_atvalid.

module mipi_flush_dummy_mst
import mipi_lw_atb_noc_pack::*;
(
    input   logic                       clk     ,
    input   logic                       rst_n   ,

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

    input   logic                       swicth,
    input   logic                       soft_switch,
    input   logic                       hard_switch,
    output  logic                       switch_done
);

logic flush_pending;
logic switch_cmd;

assign switch_cmd = swicth;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        flush_pending <= 1'b0;
    end else begin
        if (s_afvalid && s_afready) begin
            flush_pending <= 1'b0;
        end else if (m_afvalid) begin
            flush_pending <= 1'b1;
        end
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        switch_done <= 1'b0;
    end else begin
        if(!switch_cmd) switch_done <= 1'b0;
        else if(!m_afvalid && !flush_pending) switch_done <= 1'b1;
    end
end

assign m_atvalid = s_atvalid;
assign s_atready = m_atready;

always_comb begin
    if (switch_cmd) begin
        s_afvalid = m_afvalid || flush_pending;
    end else begin
        s_afvalid = m_afvalid;
    end
end

assign m_afready = s_afready;

assign s_syncreq    = m_syncreq;
assign m_atbytes    = s_atbytes;
assign m_atdata     = s_atdata;
assign m_atid       = s_atid;
assign m_atwakeup   = s_atwakeup;

endmodule

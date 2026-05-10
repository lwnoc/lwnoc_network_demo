//1.when no flush,only trace,wait one beat trace done mask trace to downstream
//2.
module dsp_trace_data_default_slv
import dsp_lw_atb_noc_pack::*;
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

    output  logic                       idle,
    input   logic                       soft_switch,
    input   logic                       hard_switch,
    output  logic                       switch_done
);

logic is_flush;
logic switch_cmd;
logic trace_hs;
logic trace_hold_active;
logic [ATB_BYTES_WIDTH-1:0] hold_atbytes;
logic [ATB_DATA_WIDTH-1:0]  hold_atdata;
logic [ATB_ID_WIDTH-1:0]    hold_atid;
logic                       hold_atwakeup;

assign switch_cmd = hard_switch || soft_switch;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        is_flush <= 1'b0;
    end else if(m_afvalid) begin
        if(m_afready) is_flush <= 1'b0;
        else is_flush <= 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        switch_done <= 1'b0;
    end else begin
        if(!switch_cmd) switch_done <= 1'b0;
        else if(!is_flush && trace_hs && !trace_hold_active) switch_done <= 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        trace_hs <= 1'b1;
    end else if (m_atvalid) begin
        if (m_atready) trace_hs <= 1'b1;
        else trace_hs <= 1'b0;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        trace_hold_active <= 1'b0;
        hold_atbytes <= '0;
        hold_atdata <= '0;
        hold_atid <= '0;
        hold_atwakeup <= 1'b0;
    end else begin
        if (trace_hold_active) begin
            if (m_atready) trace_hold_active <= 1'b0;
        end else if (s_atvalid && s_atready && !m_atready) begin
            trace_hold_active <= 1'b1;
            hold_atbytes <= s_atbytes;
            hold_atdata <= s_atdata;
            hold_atid <= s_atid;
            hold_atwakeup <= s_atwakeup;
        end
    end
end

// trace_data_default_slv still tracks flush state for switch sequencing,
// but flush completion itself is handled by the dedicated flush wrapper.
assign m_afready = s_afready;
assign m_atvalid = trace_hold_active ? 1'b1 :
                   (switch_done      ? 1'b0 : s_atvalid);
assign s_atready = switch_done       ? 1'b1 :
                   (trace_hold_active ? 1'b0 : 1'b1);
assign s_afvalid = m_afvalid;
assign s_syncreq = switch_done ? 1'b0 : m_syncreq;
assign m_atbytes = trace_hold_active ? hold_atbytes : s_atbytes;
assign m_atdata  = trace_hold_active ? hold_atdata : s_atdata;
assign m_atid    = trace_hold_active ? hold_atid : s_atid;
assign m_atwakeup= trace_hold_active ? hold_atwakeup : s_atwakeup;

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        idle <= 1'b0;
    end else if(!s_atvalid) begin
        if(!m_afvalid) idle <= 1'b1;
        else idle <= 1'b0;
    end else begin
        idle <= 1'b0;
    end
end


endmodule

module cpu_noc_flush_default_slv
import cpu_noc_lw_atb_noc_pack::*;
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

logic m_afready_tmp;
logic is_flush;
logic flush_pending;
logic switch_cmd;
logic hold_trace_valid;
logic hold_trace_active;
logic [ATB_BYTES_WIDTH-1:0] hold_atbytes;
logic [ATB_DATA_WIDTH-1:0]  hold_atdata;
logic [ATB_ID_WIDTH-1:0]    hold_atid;
logic                       hold_atwakeup;

assign switch_cmd = hard_switch || soft_switch;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) is_flush <= 1'b0;
    else if(s_afvalid && s_afready) is_flush <= 1'b0;
    else if(s_afvalid) is_flush <= 1'b1;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        flush_pending <= 1'b0;
    end else begin
        if (m_afvalid) flush_pending <= 1'b1;
        else if (s_afvalid && s_afready) flush_pending <= 1'b0;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        hold_trace_valid <= 1'b0;
        hold_atbytes <= '0;
        hold_atdata <= '0;
        hold_atid <= '0;
        hold_atwakeup <= 1'b0;
    end else begin
        if (!switch_cmd && s_atvalid && !m_atready) begin
            hold_trace_valid <= 1'b1;
            hold_atbytes <= s_atbytes;
            hold_atdata <= s_atdata;
            hold_atid <= s_atid;
            hold_atwakeup <= s_atwakeup;
        end else if (hold_trace_active && m_atready) begin
            hold_trace_valid <= 1'b0;
        end else if (!switch_cmd) begin
            hold_trace_valid <= 1'b0;
        end
    end
end

assign hold_trace_active = switch_cmd && !is_flush && hold_trace_valid;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        switch_done <= 1'b0;
    end else begin
        if(!switch_cmd) switch_done <= 1'b0;
        else if(switch_cmd && !is_flush && !m_afvalid && !flush_pending && !hold_trace_active) switch_done <= 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) m_afready_tmp <= 1'b0;
    else begin
        if(m_afvalid && m_afready_tmp) m_afready_tmp <= 1'b0;
        else if(m_afvalid) m_afready_tmp <= 1'b1;
    end
end

assign m_afready = switch_cmd ? (!is_flush ? 1'b0 : m_afready_tmp) : s_afready;

assign m_atvalid = hold_trace_active ? 1'b1 : (switch_cmd ? (!is_flush ? 1'b0 : s_atvalid) : s_atvalid);

assign s_atready = hold_trace_active ? m_atready : (switch_cmd ? (!is_flush ? 1'b1 : m_atready) : m_atready);

assign s_afvalid = m_afvalid || flush_pending;


assign s_syncreq    = m_syncreq;
assign m_atbytes    = hold_trace_active ? hold_atbytes : s_atbytes;
assign m_atdata     = hold_trace_active ? hold_atdata : (switch_cmd ? {ATB_DATA_WIDTH{1'b0}} : s_atdata);
assign m_atid       = hold_trace_active ? hold_atid : (switch_cmd ? {ATB_ID_WIDTH{1'b0}} : s_atid);
assign m_atwakeup   = hold_trace_active ? hold_atwakeup : (switch_cmd ? 1'b0 : s_atwakeup);

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) idle <= 1'b0;
    else if(!s_atvalid && !m_afvalid && !flush_pending) idle <= 1'b1;
    else idle <= 1'b0;
end


endmodule

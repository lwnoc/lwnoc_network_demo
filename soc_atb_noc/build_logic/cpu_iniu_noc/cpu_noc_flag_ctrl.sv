module cpu_noc_flag_ctrl
import cpu_noc_lw_atb_noc_pack::*;
(
    input   logic                       clk  ,
    input   logic                       rst_n ,
    input   logic                       s_atvalid,
    output  logic                       s_atready,
    input   logic [ATB_BYTES_WIDTH-1:0] s_atbytes,
    input   logic [ATB_DATA_WIDTH-1:0]  s_atdata,
    input   logic [ATB_ID_WIDTH-1:0]    s_atid,
    output  logic                       s_afvalid,
    input   logic                       s_afready,
    output  logic                       s_syncreq,
    input   logic                       s_atwakeup,

    input   logic                       flush_req_synced,
    input   logic                       sync_req_synced,
    output  logic                       m_vld  ,
    input   logic                       m_rdy  ,
    output  atb_trans_typ               m_pld  ,
    output  logic                       flush_done
);

    logic flag_send;
    logic flush_req_d;
    logic flush_req_rise;
    logic sync_req_d;
    logic s_afvalid_tmp;
    logic flush_pkt_accepted;
    // the m comes from two part
    // 1.normal atb trace or flush
    // 2.continus empty or new data payload,wait flush done de-assert

    assign flag_send = flush_done || sync_req_synced;
    assign flush_pkt_accepted = m_vld && m_rdy && m_pld.flush_done;
    assign flush_req_rise = flush_req_synced && ~flush_req_d;

    always_ff @(posedge clk or negedge rst_n) begin : blockName
        if (!rst_n) begin
            m_vld <= 1'b0;
            m_pld <= '0;
        end else begin
            if (s_atvalid && (!m_vld || m_rdy)) begin
                m_vld           <= s_atvalid;
                m_pld.atdata    <= s_atdata;
                m_pld.atid      <= s_atid;
                m_pld.atbytes   <= s_atbytes;
                m_pld.atwakeup  <= s_atwakeup;
                m_pld.flush_done<= flush_done;
                m_pld.sync_req  <= sync_req_synced;
            end else if (flag_send && (!m_vld || m_rdy)) begin
                m_vld           <= 1'b1;
                m_pld.atdata    <= {ATB_DATA_WIDTH{1'b0}};
                m_pld.atid      <= {ATB_ID_WIDTH{1'b0}};
                m_pld.atbytes   <= {ATB_BYTES_WIDTH{1'b0}};
                m_pld.atwakeup  <= 1'b0;
                m_pld.flush_done<= flush_done;
                m_pld.sync_req  <= sync_req_synced;
            end else if(!flag_send && (!m_vld || m_rdy)) begin
                m_vld <= 1'b0;
                m_pld <= '0;
            end
        end
    end

    // ready only when the output channel is free; prevents incoming data
    // from corrupting m_pld while the downstream is stalled.
    assign s_atready = (!m_vld || m_rdy);

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) flush_req_d <= 1'b0;
        else flush_req_d <= flush_req_synced;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) sync_req_d <= 1'b0;
        else sync_req_d <= sync_req_synced;
    end

    assign s_syncreq = sync_req_synced && ~sync_req_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) flush_done <= 1'b0;
        else if(flush_req_rise) flush_done <= 1'b0;
        else if(s_afvalid && s_afready) flush_done <= 1'b1;
        else if(flush_pkt_accepted) flush_done <= 1'b0;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_afvalid_tmp <= 1'b0;
        end else if(flush_req_rise) begin
            s_afvalid_tmp <= 1'b1;
        end else if(s_afvalid && s_afready) begin
            s_afvalid_tmp <= 1'b0;
        end
    end

    assign s_afvalid = s_afvalid_tmp;

endmodule

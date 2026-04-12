module intr_ring_lnk_interrupt_req_ring_link
#(
    parameter integer unsigned PAYLOAD_WIDTH = 40,
    parameter integer unsigned SRCID_WIDTH   = 8,
    parameter integer unsigned TGTID_WIDTH   = 8,
    parameter integer unsigned QOS_WIDTH     = 4
)(
    input  logic                      clk       ,
    input  logic                      rst_n     ,
    input  logic                      s_valid   ,
    output logic                      s_ready   ,
    input  logic [PAYLOAD_WIDTH-1:0]  s_payload ,
    input  logic [SRCID_WIDTH-1:0]    s_srcid   ,
    input  logic [TGTID_WIDTH-1:0]    s_tgtid   ,
    input  logic [QOS_WIDTH-1:0]      s_qos     ,
    input  logic                      s_last    ,
    output logic                      m_valid   ,
    input  logic                      m_ready   ,
    output logic [PAYLOAD_WIDTH-1:0]  m_payload ,
    output logic [SRCID_WIDTH-1:0]    m_srcid   ,
    output logic [TGTID_WIDTH-1:0]    m_tgtid   ,
    output logic [QOS_WIDTH-1:0]      m_qos     ,
    output logic                      m_last
);

    logic                     full_q      ;
    logic [PAYLOAD_WIDTH-1:0] payload_q   ;
    logic [SRCID_WIDTH-1:0]   srcid_q     ;
    logic [TGTID_WIDTH-1:0]   tgtid_q     ;
    logic [QOS_WIDTH-1:0]     qos_q       ;
    logic                     last_q      ;

    assign s_ready   = ~full_q;
    assign m_valid   = full_q;
    assign m_payload = payload_q;
    assign m_srcid   = srcid_q;
    assign m_tgtid   = tgtid_q;
    assign m_qos     = qos_q;
    assign m_last    = last_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            full_q    <= 1'b0;
            payload_q <= '0;
            srcid_q   <= '0;
            tgtid_q   <= '0;
            qos_q     <= '0;
            last_q    <= 1'b0;
        end
        else if(full_q) begin
            if(m_ready) begin
                full_q <= 1'b0;
            end
        end
        else if(s_valid) begin
            full_q    <= 1'b1;
            payload_q <= s_payload;
            srcid_q   <= s_srcid;
            tgtid_q   <= s_tgtid;
            qos_q     <= s_qos;
            last_q    <= s_last;
        end
    end

endmodule

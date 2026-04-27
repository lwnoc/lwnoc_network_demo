module dti_link_pipe #(
    parameter integer unsigned PAYLOAD_WIDTH = 64,
    parameter integer unsigned TID_WIDTH = 6,
    parameter integer unsigned RS_TYPE = 0,
    localparam integer unsigned GPW = PAYLOAD_WIDTH + 1 + TID_WIDTH + TID_WIDTH + 1
)(
    input   logic                           clk,
    input   logic                           rst_n,
    input   logic                           s_valid,
    output  logic                           s_ready,
    input   logic [PAYLOAD_WIDTH-1:0]       s_payload,
    input   logic                           s_last,
    input   logic [TID_WIDTH-1:0]           s_srcid,
    input   logic [TID_WIDTH-1:0]           s_tgtid,
    input   logic                           s_qos,
    output  logic                           s_threshold,
    output  logic                           m_valid,
    input   logic                           m_ready,
    output  logic [PAYLOAD_WIDTH-1:0]       m_payload,
    output  logic                           m_last,
    output  logic [TID_WIDTH-1:0]           m_srcid,
    output  logic [TID_WIDTH-1:0]           m_tgtid,
    output  logic                           m_qos,
    input   logic                           m_threshold
);

    logic [GPW-1:0] s_pld;
    logic [GPW-1:0] m_pld;

    assign s_pld = {s_payload, s_last, s_srcid, s_tgtid, s_qos};
    assign {m_payload, m_last, m_srcid, m_tgtid, m_qos} = m_pld;
    assign s_threshold = m_threshold;

    fcip_reg_slice #(
        .PLD_TYPE   (logic [GPW-1:0]),
        .RS_TYPE    (RS_TYPE)
    ) u_fcip_reg_slice (
        .clk        (clk),
        .rst_n      (rst_n),
        .s_vld      (s_valid),
        .s_rdy      (s_ready),
        .s_pld      (s_pld),
        .m_vld      (m_valid),
        .m_rdy      (m_ready),
        .m_pld      (m_pld)
    );

endmodule

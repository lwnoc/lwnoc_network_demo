// atb_funnel_bridge_2to1.sv — 2-to-1 ATB round-robin bridge wrapper.
// Wraps atb_funnel_bridge #2 with individually-named per-channel ports
// for UHDL Bundle connect compatibility.

module atb_funnel_bridge_2to1 #(
    parameter int unsigned ATB_DATA_WIDTH = 128,
    parameter int unsigned ATB_ID_WIDTH = 7,
    parameter int unsigned HOLD_WIDTH = 8,
    parameter logic [HOLD_WIDTH-1:0] MIN_HOLD_TIME = '0
) (
    input  logic clk,
    input  logic resetn,
    input  logic ch0_m_atvalid,
    output logic ch0_m_atready,
    input  logic [3:0] ch0_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch0_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch0_m_atid,
    output logic ch0_m_afvalid,
    input  logic ch0_m_afready,
    output logic ch0_m_syncreq,
    input  logic ch0_m_atwakeup,
    input  logic ch1_m_atvalid,
    output logic ch1_m_atready,
    input  logic [3:0] ch1_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch1_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch1_m_atid,
    output logic ch1_m_afvalid,
    input  logic ch1_m_afready,
    output logic ch1_m_syncreq,
    input  logic ch1_m_atwakeup,
    output logic m_atvalid,
    input  logic m_atready,
    output logic [3:0] m_atbytes,
    output logic [ATB_DATA_WIDTH-1:0] m_atdata,
    output logic [ATB_ID_WIDTH-1:0] m_atid,
    input  logic m_afvalid,
    output logic m_afready,
    input  logic m_syncreq,
    output logic m_atwakeup
);

    logic [2-1:0] s_atvalids;
    logic [2-1:0] s_atreadys;
    logic [2-1:0][ATB_ID_WIDTH-1:0] s_atids;
    logic [2-1:0][ATB_DATA_WIDTH-1:0] s_atdatas;
    logic [2-1:0][3:0] s_atbytess;
    logic [2-1:0] s_afreadys;
    logic [2-1:0] s_afvalids;
    logic [2-1:0] s_syncreqs;
    logic [2-1:0] s_atwakeup_ins;

    assign s_atvalids[0] = ch0_m_atvalid;
    assign s_afreadys[0] = ch0_m_afready;
    assign s_atids[0] = ch0_m_atid;
    assign s_atdatas[0] = ch0_m_atdata;
    assign s_atbytess[0] = ch0_m_atbytes;
    assign s_atwakeup_ins[0] = ch0_m_atwakeup;
    assign ch0_m_atready = s_atreadys[0];
    assign ch0_m_afvalid = s_afvalids[0];
    assign ch0_m_syncreq = s_syncreqs[0];
    assign s_atvalids[1] = ch1_m_atvalid;
    assign s_afreadys[1] = ch1_m_afready;
    assign s_atids[1] = ch1_m_atid;
    assign s_atdatas[1] = ch1_m_atdata;
    assign s_atbytess[1] = ch1_m_atbytes;
    assign s_atwakeup_ins[1] = ch1_m_atwakeup;
    assign ch1_m_atready = s_atreadys[1];
    assign ch1_m_afvalid = s_afvalids[1];
    assign ch1_m_syncreq = s_syncreqs[1];

    atb_funnel_bridge #(
        .ATB_DATA_WIDTH (ATB_DATA_WIDTH),
        .ATB_ID_WIDTH   (ATB_ID_WIDTH),
        .N_ATB          (2),
        .HOLD_WIDTH     (HOLD_WIDTH),
        .MIN_HOLD_TIME  (MIN_HOLD_TIME)
    ) u_bridge (
        .clk          (clk),
        .resetn       (resetn),
        .s_atvalids   (s_atvalids),
        .s_atreadys   (s_atreadys),
        .s_afreadys   (s_afreadys),
        .s_afvalids   (s_afvalids),
        .s_syncreqs   (s_syncreqs),
        .s_atwakeups  (),
        .s_atids      (s_atids),
        .s_atdatas    (s_atdatas),
        .s_atbytess   (s_atbytess),
        .s_atwakeup_ins(s_atwakeup_ins),
        .m_atvalid    (m_atvalid),
        .m_atready    (m_atready),
        .m_atid       (m_atid),
        .m_atdata     (m_atdata),
        .m_atbytes    (m_atbytes),
        .m_atwakeup   (m_atwakeup),
        .m_afvalid    (m_afvalid),
        .m_afready    (m_afready),
        .m_syncreq    (m_syncreq)
    );

endmodule

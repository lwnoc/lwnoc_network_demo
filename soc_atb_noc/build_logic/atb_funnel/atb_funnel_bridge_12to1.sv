// atb_funnel_bridge_12to1.sv — 12-to-1 ATB round-robin bridge wrapper.
// Wraps atb_funnel_bridge #12 with individually-named per-channel ports
// for UHDL Bundle connect compatibility.

module atb_funnel_bridge_12to1 #(
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
    input  logic ch2_m_atvalid,
    output logic ch2_m_atready,
    input  logic [3:0] ch2_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch2_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch2_m_atid,
    output logic ch2_m_afvalid,
    input  logic ch2_m_afready,
    output logic ch2_m_syncreq,
    input  logic ch2_m_atwakeup,
    input  logic ch3_m_atvalid,
    output logic ch3_m_atready,
    input  logic [3:0] ch3_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch3_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch3_m_atid,
    output logic ch3_m_afvalid,
    input  logic ch3_m_afready,
    output logic ch3_m_syncreq,
    input  logic ch3_m_atwakeup,
    input  logic ch4_m_atvalid,
    output logic ch4_m_atready,
    input  logic [3:0] ch4_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch4_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch4_m_atid,
    output logic ch4_m_afvalid,
    input  logic ch4_m_afready,
    output logic ch4_m_syncreq,
    input  logic ch4_m_atwakeup,
    input  logic ch5_m_atvalid,
    output logic ch5_m_atready,
    input  logic [3:0] ch5_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch5_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch5_m_atid,
    output logic ch5_m_afvalid,
    input  logic ch5_m_afready,
    output logic ch5_m_syncreq,
    input  logic ch5_m_atwakeup,
    input  logic ch6_m_atvalid,
    output logic ch6_m_atready,
    input  logic [3:0] ch6_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch6_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch6_m_atid,
    output logic ch6_m_afvalid,
    input  logic ch6_m_afready,
    output logic ch6_m_syncreq,
    input  logic ch6_m_atwakeup,
    input  logic ch7_m_atvalid,
    output logic ch7_m_atready,
    input  logic [3:0] ch7_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch7_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch7_m_atid,
    output logic ch7_m_afvalid,
    input  logic ch7_m_afready,
    output logic ch7_m_syncreq,
    input  logic ch7_m_atwakeup,
    input  logic ch8_m_atvalid,
    output logic ch8_m_atready,
    input  logic [3:0] ch8_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch8_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch8_m_atid,
    output logic ch8_m_afvalid,
    input  logic ch8_m_afready,
    output logic ch8_m_syncreq,
    input  logic ch8_m_atwakeup,
    input  logic ch9_m_atvalid,
    output logic ch9_m_atready,
    input  logic [3:0] ch9_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch9_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch9_m_atid,
    output logic ch9_m_afvalid,
    input  logic ch9_m_afready,
    output logic ch9_m_syncreq,
    input  logic ch9_m_atwakeup,
    input  logic ch10_m_atvalid,
    output logic ch10_m_atready,
    input  logic [3:0] ch10_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch10_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch10_m_atid,
    output logic ch10_m_afvalid,
    input  logic ch10_m_afready,
    output logic ch10_m_syncreq,
    input  logic ch10_m_atwakeup,
    input  logic ch11_m_atvalid,
    output logic ch11_m_atready,
    input  logic [3:0] ch11_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch11_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch11_m_atid,
    output logic ch11_m_afvalid,
    input  logic ch11_m_afready,
    output logic ch11_m_syncreq,
    input  logic ch11_m_atwakeup,
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

    logic [12-1:0] s_atvalids;
    logic [12-1:0] s_atreadys;
    logic [12-1:0][ATB_ID_WIDTH-1:0] s_atids;
    logic [12-1:0][ATB_DATA_WIDTH-1:0] s_atdatas;
    logic [12-1:0][3:0] s_atbytess;
    logic [12-1:0] s_afreadys;
    logic [12-1:0] s_afvalids;
    logic [12-1:0] s_syncreqs;
    logic [12-1:0] s_atwakeup_ins;

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
    assign s_atvalids[2] = ch2_m_atvalid;
    assign s_afreadys[2] = ch2_m_afready;
    assign s_atids[2] = ch2_m_atid;
    assign s_atdatas[2] = ch2_m_atdata;
    assign s_atbytess[2] = ch2_m_atbytes;
    assign s_atwakeup_ins[2] = ch2_m_atwakeup;
    assign ch2_m_atready = s_atreadys[2];
    assign ch2_m_afvalid = s_afvalids[2];
    assign ch2_m_syncreq = s_syncreqs[2];
    assign s_atvalids[3] = ch3_m_atvalid;
    assign s_afreadys[3] = ch3_m_afready;
    assign s_atids[3] = ch3_m_atid;
    assign s_atdatas[3] = ch3_m_atdata;
    assign s_atbytess[3] = ch3_m_atbytes;
    assign s_atwakeup_ins[3] = ch3_m_atwakeup;
    assign ch3_m_atready = s_atreadys[3];
    assign ch3_m_afvalid = s_afvalids[3];
    assign ch3_m_syncreq = s_syncreqs[3];
    assign s_atvalids[4] = ch4_m_atvalid;
    assign s_afreadys[4] = ch4_m_afready;
    assign s_atids[4] = ch4_m_atid;
    assign s_atdatas[4] = ch4_m_atdata;
    assign s_atbytess[4] = ch4_m_atbytes;
    assign s_atwakeup_ins[4] = ch4_m_atwakeup;
    assign ch4_m_atready = s_atreadys[4];
    assign ch4_m_afvalid = s_afvalids[4];
    assign ch4_m_syncreq = s_syncreqs[4];
    assign s_atvalids[5] = ch5_m_atvalid;
    assign s_afreadys[5] = ch5_m_afready;
    assign s_atids[5] = ch5_m_atid;
    assign s_atdatas[5] = ch5_m_atdata;
    assign s_atbytess[5] = ch5_m_atbytes;
    assign s_atwakeup_ins[5] = ch5_m_atwakeup;
    assign ch5_m_atready = s_atreadys[5];
    assign ch5_m_afvalid = s_afvalids[5];
    assign ch5_m_syncreq = s_syncreqs[5];
    assign s_atvalids[6] = ch6_m_atvalid;
    assign s_afreadys[6] = ch6_m_afready;
    assign s_atids[6] = ch6_m_atid;
    assign s_atdatas[6] = ch6_m_atdata;
    assign s_atbytess[6] = ch6_m_atbytes;
    assign s_atwakeup_ins[6] = ch6_m_atwakeup;
    assign ch6_m_atready = s_atreadys[6];
    assign ch6_m_afvalid = s_afvalids[6];
    assign ch6_m_syncreq = s_syncreqs[6];
    assign s_atvalids[7] = ch7_m_atvalid;
    assign s_afreadys[7] = ch7_m_afready;
    assign s_atids[7] = ch7_m_atid;
    assign s_atdatas[7] = ch7_m_atdata;
    assign s_atbytess[7] = ch7_m_atbytes;
    assign s_atwakeup_ins[7] = ch7_m_atwakeup;
    assign ch7_m_atready = s_atreadys[7];
    assign ch7_m_afvalid = s_afvalids[7];
    assign ch7_m_syncreq = s_syncreqs[7];
    assign s_atvalids[8] = ch8_m_atvalid;
    assign s_afreadys[8] = ch8_m_afready;
    assign s_atids[8] = ch8_m_atid;
    assign s_atdatas[8] = ch8_m_atdata;
    assign s_atbytess[8] = ch8_m_atbytes;
    assign s_atwakeup_ins[8] = ch8_m_atwakeup;
    assign ch8_m_atready = s_atreadys[8];
    assign ch8_m_afvalid = s_afvalids[8];
    assign ch8_m_syncreq = s_syncreqs[8];
    assign s_atvalids[9] = ch9_m_atvalid;
    assign s_afreadys[9] = ch9_m_afready;
    assign s_atids[9] = ch9_m_atid;
    assign s_atdatas[9] = ch9_m_atdata;
    assign s_atbytess[9] = ch9_m_atbytes;
    assign s_atwakeup_ins[9] = ch9_m_atwakeup;
    assign ch9_m_atready = s_atreadys[9];
    assign ch9_m_afvalid = s_afvalids[9];
    assign ch9_m_syncreq = s_syncreqs[9];
    assign s_atvalids[10] = ch10_m_atvalid;
    assign s_afreadys[10] = ch10_m_afready;
    assign s_atids[10] = ch10_m_atid;
    assign s_atdatas[10] = ch10_m_atdata;
    assign s_atbytess[10] = ch10_m_atbytes;
    assign s_atwakeup_ins[10] = ch10_m_atwakeup;
    assign ch10_m_atready = s_atreadys[10];
    assign ch10_m_afvalid = s_afvalids[10];
    assign ch10_m_syncreq = s_syncreqs[10];
    assign s_atvalids[11] = ch11_m_atvalid;
    assign s_afreadys[11] = ch11_m_afready;
    assign s_atids[11] = ch11_m_atid;
    assign s_atdatas[11] = ch11_m_atdata;
    assign s_atbytess[11] = ch11_m_atbytes;
    assign s_atwakeup_ins[11] = ch11_m_atwakeup;
    assign ch11_m_atready = s_atreadys[11];
    assign ch11_m_afvalid = s_afvalids[11];
    assign ch11_m_syncreq = s_syncreqs[11];

    atb_funnel_bridge #(
        .ATB_DATA_WIDTH (ATB_DATA_WIDTH),
        .ATB_ID_WIDTH   (ATB_ID_WIDTH),
        .N_ATB          (12),
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

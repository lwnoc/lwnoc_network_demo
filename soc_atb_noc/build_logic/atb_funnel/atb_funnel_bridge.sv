// atb_funnel_bridge — N:1 ATB round-robin bridge
// Simplified design: no APB config, no ITC, all ports equal priority.
// Wraps atb_funnel_arbiter with tied-off configuration signals.

module atb_funnel_bridge #(
    parameter integer unsigned ATB_DATA_WIDTH  = 64,
    parameter integer unsigned ATB_BYTES_WIDTH =
        (ATB_DATA_WIDTH == 32)  ? 2 :
        (ATB_DATA_WIDTH == 64)  ? 3 :
        (ATB_DATA_WIDTH == 128) ? 4 : 3,
    parameter integer unsigned ATB_ID_WIDTH    = 7,
    parameter integer unsigned N_ATB           = 2,
    parameter integer unsigned HOLD_WIDTH      = 8,
    parameter integer unsigned SEL_WIDTH       = (N_ATB <= 1) ? 1 : $clog2(N_ATB),
    parameter integer unsigned PRI_WIDTH       = (N_ATB <= 2) ? 1 : $clog2(N_ATB),
    parameter logic [HOLD_WIDTH-1:0] MIN_HOLD_TIME = '0
) (
    input  logic                              clk,
    input  logic                              resetn,

    // ---- Slave ATB interfaces (N ports) ----
    input  logic [N_ATB-1:0]                  s_atvalids,
    output logic [N_ATB-1:0]                  s_atreadys,
    input  logic [N_ATB-1:0]                  s_afreadys,
    output logic [N_ATB-1:0]                  s_afvalids,
    output logic [N_ATB-1:0]                  s_syncreqs,
    output logic [N_ATB-1:0]                  s_atwakeups,
    input  logic [N_ATB-1:0][ATB_ID_WIDTH-1:0]    s_atids,
    input  logic [N_ATB-1:0][ATB_DATA_WIDTH-1:0]  s_atdatas,
    input  logic [N_ATB-1:0][ATB_BYTES_WIDTH-1:0] s_atbytess,
    input  logic [N_ATB-1:0]                  s_atwakeup_ins,

    // ---- Master ATB interface (1 port) ----
    output logic                              m_atvalid,
    input  logic                              m_atready,
    output logic [ATB_ID_WIDTH-1:0]           m_atid,
    output logic [ATB_DATA_WIDTH-1:0]         m_atdata,
    output logic [ATB_BYTES_WIDTH-1:0]        m_atbytes,
    output logic                              m_atwakeup,
    input  logic                              m_afvalid,
    output logic                              m_afready,
    input  logic                              m_syncreq
);

    // Tied-off configuration: all ports enabled, equal priority
    logic [N_ATB-1:0]                en_ports;
    logic [N_ATB-1:0][PRI_WIDTH-1:0] pri_ports;
    logic [N_ATB-1:0]                m_atvalids_s;

    assign en_ports  = {N_ATB{1'b1}};
    assign pri_ports = '0;

    atb_funnel_arbiter #(
        .ATB_DATA_WIDTH (ATB_DATA_WIDTH ),
        .ATB_BYTES_WIDTH(ATB_BYTES_WIDTH),
        .ATB_ID_WIDTH   (ATB_ID_WIDTH   ),
        .N_ATB          (N_ATB          ),
        .HOLD_WIDTH     (HOLD_WIDTH     ),
        .SEL_WIDTH      (SEL_WIDTH      ),
        .PRI_WIDTH      (PRI_WIDTH      )
    ) u_arbiter (
        .clk              (clk),
        .resetn           (resetn),
        .itc_reg          (1'b0),
        .it_atb_data_0_reg('0),
        .min_hold_time    (MIN_HOLD_TIME),
        .en_ports         (en_ports),
        .pri_ports        (pri_ports),
        .atvalids         (s_atvalids),
        .atreadys         (s_atreadys),
        .afreadys         (s_afreadys),
        .atids            (s_atids),
        .atdatas          (s_atdatas),
        .atbytess         (s_atbytess),
        .atreadym         (m_atready),
        .afvalidm         (m_afvalid),
        .syncreqm         (m_syncreq),
        .atvalidm         (m_atvalid),
        .afreadym         (m_afready),
        .atidm            (m_atid),
        .atdatam          (m_atdata),
        .atbytesm         (m_atbytes),
        .afvalids         (s_afvalids),
        .syncreqs         (s_syncreqs)
    );

    // Wakeup: direct fanout from master to all slaves
    assign s_atwakeups = {N_ATB{m_atwakeup}};

    // Wakeup output: OR of all slave wakeup inputs
    assign m_atwakeup = |s_atwakeup_ins;

endmodule

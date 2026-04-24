`ifndef _PREFIX_
`define _PREFIX_(x) x
`endif

// Compatibility wrappers: keep legacy/simple network-layer instance interfaces
// while binding to lwnoc_atb_noc/rtl canonical modules.

module atb_async_bridge_slv #(
    parameter int DATA_W = 139,
    parameter int FIFO_DEPTH = 16,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              clk,
    input  logic              clk_async,
    input  logic              rst_n,
    input  logic              in_valid,
    input  logic [DATA_W-1:0] in_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [ATB_BYTES_W-1:0] s_atbytes;
    logic [ATB_ID_W-1:0]    s_atid;
    logic [ATB_DATA_W-1:0]  s_atdata;
    logic [ATB_BYTES_W-1:0] m_atbytes;
    logic [ATB_ID_W-1:0]    m_atid;
    logic [ATB_DATA_W-1:0]  m_atdata;
    logic                   m_atvalid;

    assign {s_atbytes, s_atid, s_atdata} = in_data;
    assign out_valid = m_atvalid;
    assign out_data = {m_atbytes, m_atid, m_atdata};

    atb_async_bridge_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W)
    ) u_async_bridge_top (
        .clk_atb_s(clk),
        .rstn_atb_s(rst_n),
        .s_atvalid(in_valid),
        .s_atready(),
        .s_atbytes(s_atbytes),
        .s_atdata(s_atdata),
        .s_atid(s_atid),
        .s_afvalid(),
        .s_afready(1'b1),
        .s_syncreq(),
        .s_atwakeup(1'b0),
        .slv_full_zero(),
        .clk_atb_m(clk_async),
        .rstn_atb_m(rst_n),
        .m_atvalid(m_atvalid),
        .m_atready(1'b1),
        .m_atbytes(m_atbytes),
        .m_atdata(m_atdata),
        .m_atid(m_atid),
        .m_afvalid(1'b0),
        .m_afready(),
        .m_syncreq(1'b0),
        .m_atwakeup(),
        .mst_full_zero(),
        .mst_read_idle()
    );
endmodule

module atb_async_bridge_mst #(
    parameter int DATA_W = 139,
    parameter int FIFO_DEPTH = 16,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              clk,
    input  logic              clk_async,
    input  logic              rst_n,
    input  logic              in_valid,
    input  logic [DATA_W-1:0] in_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [ATB_BYTES_W-1:0] s_atbytes;
    logic [ATB_ID_W-1:0]    s_atid;
    logic [ATB_DATA_W-1:0]  s_atdata;
    logic [ATB_BYTES_W-1:0] m_atbytes;
    logic [ATB_ID_W-1:0]    m_atid;
    logic [ATB_DATA_W-1:0]  m_atdata;
    logic                   m_atvalid;

    assign {s_atbytes, s_atid, s_atdata} = in_data;
    assign out_valid = m_atvalid;
    assign out_data = {m_atbytes, m_atid, m_atdata};

    atb_async_bridge_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W)
    ) u_async_bridge_top (
        .clk_atb_s(clk_async),
        .rstn_atb_s(rst_n),
        .s_atvalid(in_valid),
        .s_atready(),
        .s_atbytes(s_atbytes),
        .s_atdata(s_atdata),
        .s_atid(s_atid),
        .s_afvalid(),
        .s_afready(1'b1),
        .s_syncreq(),
        .s_atwakeup(1'b0),
        .slv_full_zero(),
        .clk_atb_m(clk),
        .rstn_atb_m(rst_n),
        .m_atvalid(m_atvalid),
        .m_atready(1'b1),
        .m_atbytes(m_atbytes),
        .m_atdata(m_atdata),
        .m_atid(m_atid),
        .m_afvalid(1'b0),
        .m_afready(),
        .m_syncreq(1'b0),
        .m_atwakeup(),
        .mst_full_zero(),
        .mst_read_idle()
    );
endmodule

module atb_funnel3 #(
    parameter int DATA_W = 139,
    parameter int N_ATB = 3,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              in0_valid,
    input  logic [DATA_W-1:0] in0_data,
    input  logic              in1_valid,
    input  logic [DATA_W-1:0] in1_data,
    input  logic              in2_valid,
    input  logic [DATA_W-1:0] in2_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [N_ATB-1:0] atvalids, afreadys, atreadys, afvalids, syncreqs;
    logic [N_ATB-1:0][ATB_ID_W-1:0] atids;
    logic [N_ATB-1:0][ATB_DATA_W-1:0] atdatas;
    logic [N_ATB-1:0][ATB_BYTES_W-1:0] atbytess;
    logic [ATB_ID_W-1:0] atidm;
    logic [ATB_DATA_W-1:0] atdatam;
    logic [ATB_BYTES_W-1:0] atbytesm;
    logic atvalidm;

    assign atvalids = {in2_valid, in1_valid, in0_valid};
    assign afreadys = '1;
    assign {atbytess[0], atids[0], atdatas[0]} = in0_data;
    assign {atbytess[1], atids[1], atdatas[1]} = in1_data;
    assign {atbytess[2], atids[2], atdatas[2]} = in2_data;
    assign out_valid = atvalidm;
    assign out_data = {atbytesm, atidm, atdatam};

    atb_funnel #(
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W),
        .N_ATB(N_ATB),
        .FIXED_CONFIGURATION(1'b1),
        .FIXED_HOLD_TIME(4'b0011)
    ) u_atb_funnel (
        .clk(1'b0),
        .resetn(1'b1),
        .pclkendbg(1'b0),
        .pseldbg(1'b0),
        .penabledbg(1'b0),
        .pwritedbg(1'b0),
        .paddrdbg31(1'b0),
        .paddrdbg('0),
        .pwdatadbg('0),
        .atvalids(atvalids),
        .afreadys(afreadys),
        .atids(atids),
        .atdatas(atdatas),
        .atbytess(atbytess),
        .atreadym(1'b1),
        .afvalidm(1'b0),
        .syncreqm(1'b0),
        .preadydbg(),
        .pslverrdbg(),
        .prdatadbg(),
        .atvalidm(atvalidm),
        .afreadym(),
        .atidm(atidm),
        .atdatam(atdatam),
        .atbytesm(atbytesm),
        .atreadys(atreadys),
        .afvalids(afvalids),
        .syncreqs(syncreqs)
    );
endmodule

module atb_funnel6 #(
    parameter int DATA_W = 139,
    parameter int N_ATB = 6,
    parameter int ATB_ID_W = 7,
    parameter int ATB_BYTES_W = 4,
    parameter int ATB_DATA_W = DATA_W - ATB_ID_W - ATB_BYTES_W
) (
    input  logic              in0_valid,
    input  logic [DATA_W-1:0] in0_data,
    input  logic              in1_valid,
    input  logic [DATA_W-1:0] in1_data,
    input  logic              in2_valid,
    input  logic [DATA_W-1:0] in2_data,
    input  logic              in3_valid,
    input  logic [DATA_W-1:0] in3_data,
    input  logic              in4_valid,
    input  logic [DATA_W-1:0] in4_data,
    input  logic              in5_valid,
    input  logic [DATA_W-1:0] in5_data,
    output logic              out_valid,
    output logic [DATA_W-1:0] out_data
);
    logic [N_ATB-1:0] atvalids, afreadys, atreadys, afvalids, syncreqs;
    logic [N_ATB-1:0][ATB_ID_W-1:0] atids;
    logic [N_ATB-1:0][ATB_DATA_W-1:0] atdatas;
    logic [N_ATB-1:0][ATB_BYTES_W-1:0] atbytess;
    logic [ATB_ID_W-1:0] atidm;
    logic [ATB_DATA_W-1:0] atdatam;
    logic [ATB_BYTES_W-1:0] atbytesm;
    logic atvalidm;

    assign atvalids = {in5_valid, in4_valid, in3_valid, in2_valid, in1_valid, in0_valid};
    assign afreadys = '1;
    assign {atbytess[0], atids[0], atdatas[0]} = in0_data;
    assign {atbytess[1], atids[1], atdatas[1]} = in1_data;
    assign {atbytess[2], atids[2], atdatas[2]} = in2_data;
    assign {atbytess[3], atids[3], atdatas[3]} = in3_data;
    assign {atbytess[4], atids[4], atdatas[4]} = in4_data;
    assign {atbytess[5], atids[5], atdatas[5]} = in5_data;
    assign out_valid = atvalidm;
    assign out_data = {atbytesm, atidm, atdatam};

    atb_funnel #(
        .ATB_DATA_WIDTH(ATB_DATA_W),
        .ATB_ID_WIDTH(ATB_ID_W),
        .N_ATB(N_ATB),
        .FIXED_CONFIGURATION(1'b1),
        .FIXED_HOLD_TIME(4'b0011)
    ) u_atb_funnel (
        .clk(1'b0),
        .resetn(1'b1),
        .pclkendbg(1'b0),
        .pseldbg(1'b0),
        .penabledbg(1'b0),
        .pwritedbg(1'b0),
        .paddrdbg31(1'b0),
        .paddrdbg('0),
        .pwdatadbg('0),
        .atvalids(atvalids),
        .afreadys(afreadys),
        .atids(atids),
        .atdatas(atdatas),
        .atbytess(atbytess),
        .atreadym(1'b1),
        .afvalidm(1'b0),
        .syncreqm(1'b0),
        .preadydbg(),
        .pslverrdbg(),
        .prdatadbg(),
        .atvalidm(atvalidm),
        .afreadym(),
        .atidm(atidm),
        .atdatam(atdatam),
        .atbytesm(atbytesm),
        .atreadys(atreadys),
        .afvalids(afvalids),
        .syncreqs(syncreqs)
    );
endmodule

// dti_noc_switch_3to1_wrap.sv — 3-to-1 per-INIU DTI switch wrapper.
// Wraps dti_noc_switch #3 with individually-named per-channel ports
// for UHDL Bundle connect compatibility (positional SmartAssign).

module dti_sw3_dti_noc_switch_3to1_wrap #(
    parameter int unsigned TID_WIDTH     = 6                    ,
    parameter int unsigned PAYLOAD_WIDTH = 90                   ,
    parameter logic [1*32-1:0] TNIU_DECMIN = '0                 ,
    parameter logic [1*32-1:0] TNIU_DECMAX = '0                 ,
    parameter logic [3*32-1:0] INIU_DECMIN = '0                 ,
    parameter logic [3*32-1:0] INIU_DECMAX = '0
)(
    input  logic clk                                          ,
    input  logic rst_n                                        ,

    // ── INIU 0 REQ ───────────────────────────────────────────
    input iniu0_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu0_req_payload,
    input iniu0_req_last,
    input [TID_WIDTH-1:0] iniu0_req_srcid,
    input [TID_WIDTH-1:0] iniu0_req_tgtid,
    input iniu0_req_qos,
    output iniu0_req_threshold,
    output iniu0_req_ready,

    // ── INIU 1 REQ ───────────────────────────────────────────
    input iniu1_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu1_req_payload,
    input iniu1_req_last,
    input [TID_WIDTH-1:0] iniu1_req_srcid,
    input [TID_WIDTH-1:0] iniu1_req_tgtid,
    input iniu1_req_qos,
    output iniu1_req_threshold,
    output iniu1_req_ready,

    // ── INIU 2 REQ ───────────────────────────────────────────
    input iniu2_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu2_req_payload,
    input iniu2_req_last,
    input [TID_WIDTH-1:0] iniu2_req_srcid,
    input [TID_WIDTH-1:0] iniu2_req_tgtid,
    input iniu2_req_qos,
    output iniu2_req_threshold,
    output iniu2_req_ready,

    // ── INIU 0 RSP ───────────────────────────────────────────
    output iniu0_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu0_rsp_payload,
    output iniu0_rsp_last,
    output [TID_WIDTH-1:0] iniu0_rsp_srcid,
    output [TID_WIDTH-1:0] iniu0_rsp_tgtid,
    output iniu0_rsp_qos,
    input iniu0_rsp_threshold,
    input iniu0_rsp_ready,

    // ── INIU 1 RSP ───────────────────────────────────────────
    output iniu1_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu1_rsp_payload,
    output iniu1_rsp_last,
    output [TID_WIDTH-1:0] iniu1_rsp_srcid,
    output [TID_WIDTH-1:0] iniu1_rsp_tgtid,
    output iniu1_rsp_qos,
    input iniu1_rsp_threshold,
    input iniu1_rsp_ready,

    // ── INIU 2 RSP ───────────────────────────────────────────
    output iniu2_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu2_rsp_payload,
    output iniu2_rsp_last,
    output [TID_WIDTH-1:0] iniu2_rsp_srcid,
    output [TID_WIDTH-1:0] iniu2_rsp_tgtid,
    output iniu2_rsp_qos,
    input iniu2_rsp_threshold,
    input iniu2_rsp_ready,

    // ── TNIU REQ (single downstream port) ──────────────────────
    output tniu_req_valid,
    input tniu_req_ready,
    output [PAYLOAD_WIDTH-1:0] tniu_req_payload,
    output [TID_WIDTH-1:0] tniu_req_srcid,
    output [TID_WIDTH-1:0] tniu_req_tgtid,
    output tniu_req_qos,
    output tniu_req_last,
    input tniu_req_threshold,

    // ── TNIU RSP (single upstream port) ────────────────────────
    input tniu_rsp_valid,
    output tniu_rsp_ready,
    input [PAYLOAD_WIDTH-1:0] tniu_rsp_payload,
    input [TID_WIDTH-1:0] tniu_rsp_srcid,
    input [TID_WIDTH-1:0] tniu_rsp_tgtid,
    input tniu_rsp_qos,
    input tniu_rsp_last,
    output tniu_rsp_threshold,

    // ── TNIU RSP ────────────────────────────────────────────────
);

    // ─────────────────────────────────────────────────────────────
    // Internal dti_noc_switch instantiation
    // ─────────────────────────────────────────────────────────────
    dti_noc_switch #(
        .NUM_INIU     (3)                            ,
        .NUM_TNIU     (1)                             ,
        .TID_WIDTH    (TID_WIDTH)                     ,
        .PAYLOAD_WIDTH(PAYLOAD_WIDTH)                 ,
        .TNIU_DECMIN  (TNIU_DECMIN)                   ,
        .TNIU_DECMAX  (TNIU_DECMAX)                   ,
        .INIU_DECMIN  (INIU_DECMIN)                   ,
        .INIU_DECMAX  (INIU_DECMAX)
    ) u_sw (
        .clk                  (clk)                     ,
        .rst_n                (rst_n)                   ,

        .iniu_req_valid  ({iniu2_req_valid, iniu1_req_valid, iniu0_req_valid})              ,
        .iniu_req_payload  ({iniu2_req_payload, iniu1_req_payload, iniu0_req_payload})              ,
        .iniu_req_last  ({iniu2_req_last, iniu1_req_last, iniu0_req_last})              ,
        .iniu_req_srcid  ({iniu2_req_srcid, iniu1_req_srcid, iniu0_req_srcid})              ,
        .iniu_req_tgtid  ({iniu2_req_tgtid, iniu1_req_tgtid, iniu0_req_tgtid})              ,
        .iniu_req_qos  ({iniu2_req_qos, iniu1_req_qos, iniu0_req_qos})              ,
        .iniu_req_threshold  ({iniu2_req_threshold, iniu1_req_threshold, iniu0_req_threshold})              ,
        .iniu_req_ready  ({iniu2_req_ready, iniu1_req_ready, iniu0_req_ready})              ,

        .iniu_rsp_valid  ({iniu2_rsp_valid, iniu1_rsp_valid, iniu0_rsp_valid})              ,
        .iniu_rsp_payload  ({iniu2_rsp_payload, iniu1_rsp_payload, iniu0_rsp_payload})              ,
        .iniu_rsp_last  ({iniu2_rsp_last, iniu1_rsp_last, iniu0_rsp_last})              ,
        .iniu_rsp_srcid  ({iniu2_rsp_srcid, iniu1_rsp_srcid, iniu0_rsp_srcid})              ,
        .iniu_rsp_tgtid  ({iniu2_rsp_tgtid, iniu1_rsp_tgtid, iniu0_rsp_tgtid})              ,
        .iniu_rsp_qos  ({iniu2_rsp_qos, iniu1_rsp_qos, iniu0_rsp_qos})              ,
        .iniu_rsp_threshold  ({iniu2_rsp_threshold, iniu1_rsp_threshold, iniu0_rsp_threshold})              ,
        .iniu_rsp_ready  ({iniu2_rsp_ready, iniu1_rsp_ready, iniu0_rsp_ready})              ,

        .tniu_req_valid  (tniu_req_valid)           ,
        .tniu_req_ready  (tniu_req_ready)           ,
        .tniu_req_payload  (tniu_req_payload)           ,
        .tniu_req_srcid  (tniu_req_srcid)           ,
        .tniu_req_tgtid  (tniu_req_tgtid)           ,
        .tniu_req_qos  (tniu_req_qos)           ,
        .tniu_req_last  (tniu_req_last)           ,
        .tniu_req_threshold  (tniu_req_threshold)           ,

        .tniu_rsp_valid  (tniu_rsp_valid)           ,
        .tniu_rsp_ready  (tniu_rsp_ready)           ,
        .tniu_rsp_payload  (tniu_rsp_payload)           ,
        .tniu_rsp_srcid  (tniu_rsp_srcid)           ,
        .tniu_rsp_tgtid  (tniu_rsp_tgtid)           ,
        .tniu_rsp_qos  (tniu_rsp_qos)           ,
        .tniu_rsp_last  (tniu_rsp_last)           ,
        .tniu_rsp_threshold  (tniu_rsp_threshold)           ,

    );

endmodule

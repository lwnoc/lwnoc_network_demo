// dti_noc_switch_6to1_wrap.sv — 6-to-1 per-INIU DTI switch wrapper.
// Wraps dti_noc_switch #6 with individually-named per-channel ports
// for UHDL Bundle connect compatibility (positional SmartAssign).

module dti_sw3_dti_noc_switch_6to1_wrap #(
    parameter int unsigned TID_WIDTH       = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_TID_WIDTH       ,
    parameter int unsigned PAYLOAD_WIDTH   = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_PAYLOAD_WIDTH   ,
    parameter logic [1*32-1:0] TNIU_DECMIN = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMIN     ,
    parameter logic [1*32-1:0] TNIU_DECMAX = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_TNIU_DECMAX     ,
    parameter logic [6*32-1:0] INIU_DECMIN = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMIN     ,
    parameter logic [6*32-1:0] INIU_DECMAX = `dti_sw3_DTI_NOC_SWITCH_6TO1_WRAP_INIU_DECMAX
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

    // ── INIU 3 REQ ───────────────────────────────────────────
    input iniu3_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu3_req_payload,
    input iniu3_req_last,
    input [TID_WIDTH-1:0] iniu3_req_srcid,
    input [TID_WIDTH-1:0] iniu3_req_tgtid,
    input iniu3_req_qos,
    output iniu3_req_threshold,
    output iniu3_req_ready,

    // ── INIU 4 REQ ───────────────────────────────────────────
    input iniu4_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu4_req_payload,
    input iniu4_req_last,
    input [TID_WIDTH-1:0] iniu4_req_srcid,
    input [TID_WIDTH-1:0] iniu4_req_tgtid,
    input iniu4_req_qos,
    output iniu4_req_threshold,
    output iniu4_req_ready,

    // ── INIU 5 REQ ───────────────────────────────────────────
    input iniu5_req_valid,
    input [PAYLOAD_WIDTH-1:0] iniu5_req_payload,
    input iniu5_req_last,
    input [TID_WIDTH-1:0] iniu5_req_srcid,
    input [TID_WIDTH-1:0] iniu5_req_tgtid,
    input iniu5_req_qos,
    output iniu5_req_threshold,
    output iniu5_req_ready,

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

    // ── INIU 3 RSP ───────────────────────────────────────────
    output iniu3_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu3_rsp_payload,
    output iniu3_rsp_last,
    output [TID_WIDTH-1:0] iniu3_rsp_srcid,
    output [TID_WIDTH-1:0] iniu3_rsp_tgtid,
    output iniu3_rsp_qos,
    input iniu3_rsp_threshold,
    input iniu3_rsp_ready,

    // ── INIU 4 RSP ───────────────────────────────────────────
    output iniu4_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu4_rsp_payload,
    output iniu4_rsp_last,
    output [TID_WIDTH-1:0] iniu4_rsp_srcid,
    output [TID_WIDTH-1:0] iniu4_rsp_tgtid,
    output iniu4_rsp_qos,
    input iniu4_rsp_threshold,
    input iniu4_rsp_ready,

    // ── INIU 5 RSP ───────────────────────────────────────────
    output iniu5_rsp_valid,
    output [PAYLOAD_WIDTH-1:0] iniu5_rsp_payload,
    output iniu5_rsp_last,
    output [TID_WIDTH-1:0] iniu5_rsp_srcid,
    output [TID_WIDTH-1:0] iniu5_rsp_tgtid,
    output iniu5_rsp_qos,
    input iniu5_rsp_threshold,
    input iniu5_rsp_ready,

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
    output tniu_rsp_threshold

    // ── TNIU RSP ────────────────────────────────────────────────
);

    // ─────────────────────────────────────────────────────────────
    // Internal dti_noc_switch instantiation
    // ─────────────────────────────────────────────────────────────
    dti_sw3_dti_noc_switch #(
        .NUM_INIU     (6)                            ,
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

        .iniu_req_valid  ({iniu5_req_valid, iniu4_req_valid, iniu3_req_valid, iniu2_req_valid, iniu1_req_valid, iniu0_req_valid})              ,
        .iniu_req_payload  ({iniu5_req_payload, iniu4_req_payload, iniu3_req_payload, iniu2_req_payload, iniu1_req_payload, iniu0_req_payload})              ,
        .iniu_req_last  ({iniu5_req_last, iniu4_req_last, iniu3_req_last, iniu2_req_last, iniu1_req_last, iniu0_req_last})              ,
        .iniu_req_srcid  ({iniu5_req_srcid, iniu4_req_srcid, iniu3_req_srcid, iniu2_req_srcid, iniu1_req_srcid, iniu0_req_srcid})              ,
        .iniu_req_tgtid  ({iniu5_req_tgtid, iniu4_req_tgtid, iniu3_req_tgtid, iniu2_req_tgtid, iniu1_req_tgtid, iniu0_req_tgtid})              ,
        .iniu_req_qos  ({iniu5_req_qos, iniu4_req_qos, iniu3_req_qos, iniu2_req_qos, iniu1_req_qos, iniu0_req_qos})              ,
        .iniu_req_threshold  ({iniu5_req_threshold, iniu4_req_threshold, iniu3_req_threshold, iniu2_req_threshold, iniu1_req_threshold, iniu0_req_threshold})              ,
        .iniu_req_ready  ({iniu5_req_ready, iniu4_req_ready, iniu3_req_ready, iniu2_req_ready, iniu1_req_ready, iniu0_req_ready})              ,

        .iniu_rsp_valid  ({iniu5_rsp_valid, iniu4_rsp_valid, iniu3_rsp_valid, iniu2_rsp_valid, iniu1_rsp_valid, iniu0_rsp_valid})              ,
        .iniu_rsp_payload  ({iniu5_rsp_payload, iniu4_rsp_payload, iniu3_rsp_payload, iniu2_rsp_payload, iniu1_rsp_payload, iniu0_rsp_payload})              ,
        .iniu_rsp_last  ({iniu5_rsp_last, iniu4_rsp_last, iniu3_rsp_last, iniu2_rsp_last, iniu1_rsp_last, iniu0_rsp_last})              ,
        .iniu_rsp_srcid  ({iniu5_rsp_srcid, iniu4_rsp_srcid, iniu3_rsp_srcid, iniu2_rsp_srcid, iniu1_rsp_srcid, iniu0_rsp_srcid})              ,
        .iniu_rsp_tgtid  ({iniu5_rsp_tgtid, iniu4_rsp_tgtid, iniu3_rsp_tgtid, iniu2_rsp_tgtid, iniu1_rsp_tgtid, iniu0_rsp_tgtid})              ,
        .iniu_rsp_qos  ({iniu5_rsp_qos, iniu4_rsp_qos, iniu3_rsp_qos, iniu2_rsp_qos, iniu1_rsp_qos, iniu0_rsp_qos})              ,
        .iniu_rsp_threshold  ({iniu5_rsp_threshold, iniu4_rsp_threshold, iniu3_rsp_threshold, iniu2_rsp_threshold, iniu1_rsp_threshold, iniu0_rsp_threshold})              ,
        .iniu_rsp_ready  ({iniu5_rsp_ready, iniu4_rsp_ready, iniu3_rsp_ready, iniu2_rsp_ready, iniu1_rsp_ready, iniu0_rsp_ready})              ,

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
        .tniu_rsp_threshold  (tniu_rsp_threshold)

    );

endmodule

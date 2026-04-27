// atb_funnel_ingress_aggregator.sv
// Pure-wire pack/unpack: N scalar ATB m_chan inputs → N-wide vector funnel slave ports.
//
// Pack:  ch[i].m_atvalid → atvalids[i],  ch[i].m_atdata → atdatas[i], ...
// Unpack: atreadys[i]    → ch[i].m_atready, afvalids[i]  → ch[i].m_afvalid, ...
//
// No buffering or arbitration — pure combinational wiring.

module atb_funnel_ingress_aggregator #(
    parameter integer unsigned N_ATB           = 2,
    parameter integer unsigned ATB_DATA_WIDTH  = 64,
    parameter integer unsigned ATB_ID_WIDTH    = 7,
    parameter integer unsigned ATB_BYTES_WIDTH =
        (ATB_DATA_WIDTH == 32)  ? 2 :
        (ATB_DATA_WIDTH == 64)  ? 3 :
        (ATB_DATA_WIDTH == 128) ? 4 : $clog2(ATB_DATA_WIDTH / 8)
) (
    // ── N scalar ATB m_chan inputs (from SS top_side) ──────────────────
    input  logic [N_ATB-1:0]                         m_atvalid,
    output logic [N_ATB-1:0]                         m_atready,
    input  logic [N_ATB-1:0][ATB_BYTES_WIDTH-1:0]    m_atbytes,
    input  logic [N_ATB-1:0][ATB_DATA_WIDTH-1:0]     m_atdata,
    input  logic [N_ATB-1:0][ATB_ID_WIDTH-1:0]       m_atid,
    output logic [N_ATB-1:0]                         m_afvalid,
    input  logic [N_ATB-1:0]                         m_afready,
    output logic [N_ATB-1:0]                         m_syncreq,
    input  logic [N_ATB-1:0]                         m_atwakeup,

    // ── Vector funnel slave interface ──────────────────────────────────
    output logic [N_ATB-1:0]                         atvalids,
    output logic [N_ATB-1:0]                         afreadys,
    output logic [N_ATB-1:0][ATB_ID_WIDTH-1:0]       atids,
    output logic [N_ATB-1:0][ATB_DATA_WIDTH-1:0]     atdatas,
    output logic [N_ATB-1:0][ATB_BYTES_WIDTH-1:0]    atbytess,
    input  logic [N_ATB-1:0]                         atreadys,
    input  logic [N_ATB-1:0]                         afvalids,
    input  logic [N_ATB-1:0]                         syncreqs
);

    // ── Pack: SS m_chan → funnel slave vectors ─────────────────────────
    generate
        genvar i;
        for (i = 0; i < N_ATB; i++) begin : gen_pack
            assign atvalids[i] = m_atvalid[i];
            assign afreadys[i] = m_afready [i];
            assign atids   [i] = m_atid   [i];
            assign atdatas [i] = m_atdata [i];
            assign atbytess[i] = m_atbytes[i];
        end
    endgenerate

    // ── Unpack: funnel slave vectors → SS m_chan ───────────────────────
    generate
        for (i = 0; i < N_ATB; i++) begin : gen_unpack
            assign m_atready[i] = atreadys[i];
            assign m_afvalid[i] = afvalids[i];
            assign m_syncreq[i] = syncreqs [i];
        end
    endgenerate

endmodule

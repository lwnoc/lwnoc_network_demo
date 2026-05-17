// ============================================================
// sts_cti — Cross Trigger Interface (CTI)
//
// Full-featured CoreSight-600-compatible CTI.
//
// Features (matching CSS600 TRM chapter 6.2 / 9.15):
//   • Up to 32 trigger inputs, up to 32 trigger outputs
//   • 4 or 16 cross-trigger channels
//   • Per-trigger EVENT_IN_LEVEL (pulse=0 / level=1) via tie-off params
//   • Per-trigger SW_HANDSHAKE (pulse=0 / level=1) via tie-off params
//   • INEN matrix: trigger_in → channel mapping (RW register)
//   • OUTEN matrix: channel → trigger_out mapping (RW register)
//   • CTIGATE per-channel gate control
//   • CTIAPPSET / CTIAPPCLEAR / CTIAPPPULSE (software channel injection)
//   • CTIINTACK (level acknowledge)
//   • CTICONTROL with CTIEN global enable
//   • Status: TRIGINSTATUS, TRIGOUTSTATUS, CHINSTATUS, CHOUTSTATUS
//   • ASICCTRL external mux control
//   • Integration test: ITTRIGOUT, ITTRIGIN, ITCHOUT
//   • CoreSight lock (LOCKAR/LSR with 0xC5ACCE55 unlock)
//   • AUTHSTATUS authentication
//   • CoreSight ID registers (PIDR0-7, CIDR0-3, DEVARCH, DEVID, DEVTYPE)
//
// Parameters:
//   TRIG_IN_NUM    — number of trigger inputs (1..32)
//   TRIG_OUT_NUM   — number of trigger outputs (1..32)
//   CHANNEL_NUM    — number of cross-trigger channels (4 or 16)
//   EVENT_IN_LEVEL — per-trigger-in mode: 0=pulse, 1=level
//   SW_HANDSHAKE   — per-trigger-out mode: 0=pulse, 1=level
//   SYNC_STAGE     — synchronizer depth for async paths
//   APB_ADDR_WIDTH — APB address bus width
// ============================================================
module sts_noc_vdsp_ss1_tniu_sts_cti
import sts_noc_vdsp_ss1_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned TRIG_IN_NUM     = 8                 ,
    parameter integer unsigned TRIG_OUT_NUM    = 8                 ,
    parameter integer unsigned CHANNEL_NUM     = 4                 ,
    parameter logic [31:0]      EVENT_IN_LEVEL = '0                ,
    parameter logic [31:0]      SW_HANDSHAKE   = '0                ,
    parameter integer unsigned SYNC_STAGE      = 2                 ,
    parameter integer unsigned APB_ADDR_WIDTH  = 12
) (
    input   logic                               clk             ,
    input   logic                               rst_n           ,

    // ---- APB slave interface ----
    input   logic                               psel            ,
    input   logic                               penable         ,
    input   logic [APB_ADDR_WIDTH-1:0]          paddr           ,
    input   logic                               pwrite          ,
    input   logic [31:0]                        pwdata          ,
    output  logic [31:0]                        prdata          ,
    output  logic                               pready          ,
    output  logic                               pslverr         ,

    // ---- Trigger inputs (clock domain = clk) ----
    input   logic [TRIG_IN_NUM-1:0]             trig_in         ,

    // ---- Trigger outputs (clock domain = clk) ----
    output  logic [TRIG_OUT_NUM-1:0]            trig_out        ,

    // ---- Channel interface to CTM (pulse, clock domain = clk) ----
    input   logic [CHANNEL_NUM-1:0]             channel_in      ,
    output  logic [CHANNEL_NUM-1:0]             channel_out     ,

    // ---- ASICCTRL external mux control ----
    output  logic [7:0]                         asicctrl
);

    // =================================================================
    // Register address map (CSS600 CTI TRM table 9-388)
    // =================================================================
    localparam int ADDR_CTICONTROL       = 12'h000;
    localparam int ADDR_CTIINTACK        = 12'h010;
    localparam int ADDR_CTIAPPSET        = 12'h014;
    localparam int ADDR_CTIAPPCLEAR      = 12'h018;
    localparam int ADDR_CTIAPPPULSE      = 12'h01C;
    localparam int ADDR_CTIINEN_BASE     = 12'h020;  // + trig_idx*4  (0x020..0x09C)
    localparam int ADDR_CTIOUTEN_BASE    = 12'h0A0;  // + trig_out_idx*4 (0x0A0..0x11C)
    localparam int ADDR_CTITRIGINSTATUS  = 12'h130;
    localparam int ADDR_CTITRIGOUTSTATUS = 12'h134;
    localparam int ADDR_CTICHINSTATUS    = 12'h138;
    localparam int ADDR_CTICHOUTSTATUS   = 12'h13C;
    localparam int ADDR_CTIGATE          = 12'h140;
    localparam int ADDR_ASICCTRL         = 12'h144;
    localparam int ADDR_ITCHOUT          = 12'hEE4;
    localparam int ADDR_ITTRIGOUT        = 12'hEE8;
    localparam int ADDR_ITCHIN           = 12'hEF4;
    localparam int ADDR_ITTRIGIN         = 12'hEF8;
    localparam int ADDR_ITCTRL           = 12'hF00;
    localparam int ADDR_CLAIMSET         = 12'hFA0;
    localparam int ADDR_CLAIMCLR         = 12'hFA4;
    localparam int ADDR_DEVAFF0          = 12'hFA8;
    localparam int ADDR_DEVAFF1          = 12'hFAC;
    localparam int ADDR_LOCKAR           = 12'hFB0;
    localparam int ADDR_LSR              = 12'hFB4;
    localparam int ADDR_AUTHSTATUS       = 12'hFB8;
    localparam int ADDR_DEVARCH          = 12'hFBC;
    localparam int ADDR_DEVID            = 12'hFC8;
    localparam int ADDR_DEVTYPE          = 12'hFCC;
    localparam int ADDR_PIDR4            = 12'hFD0;
    localparam int ADDR_PIDR5            = 12'hFD4;
    localparam int ADDR_PIDR6            = 12'hFD8;
    localparam int ADDR_PIDR7            = 12'hFDC;
    localparam int ADDR_PIDR0            = 12'hFE0;
    localparam int ADDR_PIDR1            = 12'hFE4;
    localparam int ADDR_PIDR2            = 12'hFE8;
    localparam int ADDR_PIDR3            = 12'hFEC;
    localparam int ADDR_CIDR0            = 12'hFF0;
    localparam int ADDR_CIDR1            = 12'hFF4;
    localparam int ADDR_CIDR2            = 12'hFF8;
    localparam int ADDR_CIDR3            = 12'hFFC;

    // =================================================================
    // Register storage
    // =================================================================

    // CTICONTROL[0] = CTIEN (global enable)
    logic       cti_en;

    // CTIINTACK: one pulse per trigger output; self-clearing (1 cycle wide)
    logic [TRIG_OUT_NUM-1:0]   intack_pulse;

    // INEN[trig_idx][channel]: RW, reset 0
    logic [CHANNEL_NUM-1:0]    inen [TRIG_IN_NUM-1:0];

    // OUTEN[trig_out_idx][channel]: RW, reset 0
    logic [CHANNEL_NUM-1:0]    outen [TRIG_OUT_NUM-1:0];

        // CTIGATE[channel]: RW, reset 1 → gate open when =1
    logic [CHANNEL_NUM-1:0]    gate_en;

    // ASICCTRL[7:0]: RW, reset 0
    logic [7:0]                asicctrl_q;

    // Application channel state and software pulse injection
    // APPSET sets a sticky software channel until APPCLEAR clears it.
    // APPPULSE injects a one-cycle software pulse without touching the sticky state.
    logic [CHANNEL_NUM-1:0]    app_channel_q;
    logic [CHANNEL_NUM-1:0]    app_set_strobe;

    // Level-mode trigger output sticky state
    logic [TRIG_OUT_NUM-1:0]   trig_out_level;

    // Integration test registers
    logic [TRIG_OUT_NUM-1:0]   it_trigout_q;
    logic [CHANNEL_NUM-1:0]    it_chout_q;

    // CoreSight lock state (1=locked, 0=unlocked)
    logic                      locked;

    // Integration mode control
    logic                      itctrl_q;

    // Claim tag
    logic [3:0]                claim_q;

    // =================================================================
    // Trigger input processing
    // =================================================================
    logic [TRIG_IN_NUM-1:0]    trig_in_d1;
    logic [TRIG_IN_NUM-1:0]    trig_pulse;
    genvar                     gi;
    logic [TRIG_IN_NUM-1:0]    trig_pulse_gated;
    logic [CHANNEL_NUM-1:0]    ch_pulse_from_trig;
    logic [CHANNEL_NUM-1:0]    ch_pulse_internal;
    logic [CHANNEL_NUM-1:0]    ch_gated;
    logic [TRIG_OUT_NUM-1:0]   trig_pulse_out;
    logic [APB_ADDR_WIDTH-1:0] a;
    logic                      apb_write;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trig_in_d1 <= '0;
        end else begin
            trig_in_d1 <= trig_in;
        end
    end

    generate
        for (gi = 0; gi < TRIG_IN_NUM; gi = gi + 1) begin : g_trig_proc
            // EVENT_IN_LEVEL[gi] = 0 → pulse mode: trig_in IS the pulse
            // EVENT_IN_LEVEL[gi] = 1 → level mode: rising edge detect
            assign trig_pulse[gi] = (EVENT_IN_LEVEL[gi])
                ? (trig_in[gi] & ~trig_in_d1[gi])
                : trig_in[gi];
        end
    endgenerate

    // Global enable gate: when cti_en=0, all trigger pulses are masked
    assign trig_pulse_gated = trig_pulse & {TRIG_IN_NUM{cti_en}};

    // =================================================================
    // Channel activity aggregation
    // =================================================================
    // channel[k] = OR of all (trig_pulse_gated[i] & inen[i][k])
    //              | app_channel_q[k] | app_set_strobe[k] | channel_in[k]
    always_comb begin
        ch_pulse_from_trig = '0;
        for (int i = 0; i < TRIG_IN_NUM; i = i + 1) begin
            for (int k = 0; k < CHANNEL_NUM; k = k + 1) begin
                if (inen[i][k]) begin
                    ch_pulse_from_trig[k] = ch_pulse_from_trig[k]
                                          | trig_pulse_gated[i];
                end
            end
        end
    end

    // Internal channel activity = triggers | sticky app channel | app pulse | CTM input
    assign ch_pulse_internal = ch_pulse_from_trig
                             | app_channel_q
                             | app_set_strobe
                             | channel_in;

    // Gate: when gate_en[k]=1, channel output enabled; =0 blocked
    assign ch_gated = ch_pulse_internal & gate_en;

    // Integration test override is only active in integration mode.
    assign channel_out = ch_gated | (itctrl_q ? it_chout_q : '0);

    // =================================================================
    // Trigger output generation
    // =================================================================
    // For each trigger_out[y]:
    //   pulse = OR of (ch_pulse_internal[k] & outen[y][k])
    always_comb begin
        trig_pulse_out = '0;
        for (int y = 0; y < TRIG_OUT_NUM; y = y + 1) begin
            for (int k = 0; k < CHANNEL_NUM; k = k + 1) begin
                if (outen[y][k]) begin
                    trig_pulse_out[y] = trig_pulse_out[y]
                                      | ch_pulse_internal[k];
                end
            end
        end
    end

    // Level-mode trigger output: set on pulse, clear on CTIINTACK
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trig_out_level <= '0;
        end else begin
            for (int y = 0; y < TRIG_OUT_NUM; y = y + 1) begin
                if (trig_pulse_out[y]) begin
                    trig_out_level[y] <= 1'b1;
                end else if (intack_pulse[y]) begin
                    trig_out_level[y] <= 1'b0;
                end
            end
        end
    end

    // Final trigger output: SW_HANDSHAKE selects pulse/level.
    // ITTRIGOUT forces output high only in integration mode.
    generate
        for (gi = 0; gi < TRIG_OUT_NUM; gi = gi + 1) begin : g_trig_out
            assign trig_out[gi] = (itctrl_q && it_trigout_q[gi])
                ? 1'b1
                : (SW_HANDSHAKE[gi]
                    ? trig_out_level[gi]
                    : trig_pulse_out[gi]);
        end
    endgenerate

    // =================================================================
    // ASICCTRL output
    // =================================================================
    assign asicctrl = asicctrl_q;

    // =================================================================
    // APB interface
    // =================================================================
    // pready = 1 always (single-cycle APB transfer)
    // pslverr = 0 always (all addresses valid)
    assign pready  = 1'b1;
    assign pslverr = 1'b0;

    // Decode address
    assign a = paddr;

    // Write qualifier: APB write valid when psel & penable & pwrite
    assign apb_write = psel & penable & pwrite;

    // =================================================================
    // APB read
    // =================================================================
    always_comb begin
        prdata = '0;
        if (psel) begin
            // read mux converted from case to if-else for VCS 2016 compat
            if      (a == ADDR_CTICONTROL)  prdata[0] = cti_en;
            else if (a == ADDR_CTIAPPSET)  prdata[CHANNEL_NUM-1:0] = app_channel_q;
            else if (a == ADDR_CTITRIGINSTATUS)  prdata[TRIG_IN_NUM-1:0]  = trig_in;
            else if (a == ADDR_CTITRIGOUTSTATUS)  prdata[TRIG_OUT_NUM-1:0] = trig_out;
            else if (a == ADDR_CTICHINSTATUS)  prdata[CHANNEL_NUM-1:0]  = channel_in;
            else if (a == ADDR_CTICHOUTSTATUS)  prdata[CHANNEL_NUM-1:0]  = channel_out;
            else if (a == ADDR_CTIGATE)  prdata[CHANNEL_NUM-1:0]  = gate_en;
            else if (a == ADDR_ASICCTRL)  prdata[7:0]               = asicctrl_q;
            else if (a == ADDR_ITTRIGOUT)  prdata[TRIG_OUT_NUM-1:0] = it_trigout_q;
            else if (a == ADDR_ITTRIGIN)  prdata[TRIG_IN_NUM-1:0]  = trig_in;
            else if (a == ADDR_ITCHOUT)  prdata[CHANNEL_NUM-1:0]  = it_chout_q;
            else if (a == ADDR_ITCHIN)  prdata[CHANNEL_NUM-1:0]  = channel_in;
            else if (a == ADDR_ITCTRL)  prdata[0]                = itctrl_q;
            else if (a == ADDR_CLAIMSET)  prdata[3:0]              = claim_q;
            else if (a == ADDR_CLAIMCLR)  prdata[3:0]              = claim_q;
            else if (a == ADDR_DEVAFF0)  prdata = 32'h00000000;
            else if (a == ADDR_DEVAFF1)  prdata = 32'h00000000;
            else if (a == ADDR_LSR)  prdata[2:0] = {1'b0, locked, 1'b1};
            else if (a == ADDR_AUTHSTATUS)  prdata = 32'h11000000; // full non-invasive+invasive debug
            else if (a == ADDR_DEVARCH)  prdata = 32'h47701A14;  // ARM ECT
            else if (a == ADDR_DEVID)  prdata[3:0] = (CHANNEL_NUM == 16) ? 4'd1 : 4'd0;
            else if (a == ADDR_DEVTYPE)  prdata = 32'h00000014;  // CoreSight ECT
            else if (a == ADDR_PIDR0)  prdata = 32'h000000ED;
            else if (a == ADDR_PIDR1)  prdata = 32'h000000B9;
            else if (a == ADDR_PIDR2)  prdata = 32'h0000004B;
            else if (a == ADDR_PIDR3)  prdata = 32'h00000000;
            else if (a == ADDR_PIDR4)  prdata = 32'h00000004;
            // // PIDR5-7 reserved (0)
            else if (a == ADDR_CIDR0)  prdata = 32'h0000000D;
            else if (a == ADDR_CIDR1)  prdata = 32'h00000090;
            else if (a == ADDR_CIDR2)  prdata = 32'h00000005;
            else if (a == ADDR_CIDR3)  prdata = 32'h000000B1;

            // INEN read window
            if (a >= ADDR_CTIINEN_BASE &&
                a < ADDR_CTIINEN_BASE + TRIG_IN_NUM*4) begin
                int idx = (a - ADDR_CTIINEN_BASE) / 4;
                if (idx < TRIG_IN_NUM)
                    prdata[CHANNEL_NUM-1:0] = inen[idx];
            end

            // OUTEN read window
            if (a >= ADDR_CTIOUTEN_BASE &&
                a < ADDR_CTIOUTEN_BASE + TRIG_OUT_NUM*4) begin
                int idx = (a - ADDR_CTIOUTEN_BASE) / 4;
                if (idx < TRIG_OUT_NUM)
                    prdata[CHANNEL_NUM-1:0] = outen[idx];
            end
        end
    end

    // =================================================================
    // APB write (all on posedge clk)
    // =================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cti_en           <= 1'b0;
            gate_en          <= {CHANNEL_NUM{1'b1}}; // TRM: reset all-1s (all gates open)
            asicctrl_q       <= '0;
            app_channel_q    <= '0;
            app_set_strobe   <= '0;
            intack_pulse     <= '0;
            it_trigout_q     <= '0;
            it_chout_q       <= '0;
            itctrl_q         <= 1'b0;
            claim_q          <= 4'hF;  // TRM: CLAIMSET reset = 0xF
            locked           <= 1'b1;  // start locked per CoreSight convention
            // Clear all INEN
            for (int i = 0; i < TRIG_IN_NUM; i = i + 1) inen[i] <= '0;
            // Clear all OUTEN
            for (int y = 0; y < TRIG_OUT_NUM; y = y + 1) outen[y] <= '0;
        end else begin
            // Default: strobes self-clear (1 cycle)
            app_set_strobe   <= '0;
            intack_pulse     <= '0;

            if (apb_write) begin

                // LOCKAR: any write affects lock state (0xC5ACCE55 unlocks)
                if (a == ADDR_LOCKAR) begin
                    locked <= (pwdata != 32'hC5ACCE55);
                end

                // All other registers need unlocked state (or LOCKAR/LSR)
                if (!locked || a == ADDR_LOCKAR || a == ADDR_LSR) begin
                    if      (a == ADDR_CTICONTROL)   cti_en <= pwdata[0];
                    else if (a == ADDR_CTIINTACK)    intack_pulse <= pwdata[TRIG_OUT_NUM-1:0];
                    else if (a == ADDR_CTIAPPSET)    app_channel_q <= app_channel_q | pwdata[CHANNEL_NUM-1:0];
                    else if (a == ADDR_CTIAPPPULSE)  app_set_strobe <= pwdata[CHANNEL_NUM-1:0];
                    else if (a == ADDR_CTIAPPCLEAR)  app_channel_q <= app_channel_q & ~pwdata[CHANNEL_NUM-1:0];
                    else if (a == ADDR_CTIGATE)      gate_en <= pwdata[CHANNEL_NUM-1:0];
                    else if (a == ADDR_ASICCTRL)     asicctrl_q <= pwdata[7:0];
                    else if (a == ADDR_ITCHOUT)      it_chout_q   <= pwdata[CHANNEL_NUM-1:0];
                    else if (a == ADDR_ITTRIGOUT)    it_trigout_q <= pwdata[TRIG_OUT_NUM-1:0];
                    else if (a == ADDR_ITCTRL)       itctrl_q     <= pwdata[0];
                    else if (a == ADDR_CLAIMSET)     claim_q      <= claim_q | pwdata[3:0];
                    else if (a == ADDR_CLAIMCLR)     claim_q      <= claim_q & ~pwdata[3:0];

                    // INEN write window
                    if (a >= ADDR_CTIINEN_BASE &&
                        a < ADDR_CTIINEN_BASE + TRIG_IN_NUM*4) begin
                        int idx = (a - ADDR_CTIINEN_BASE) / 4;
                        if (idx < TRIG_IN_NUM)
                            inen[idx] <= pwdata[CHANNEL_NUM-1:0];
                    end

                    // OUTEN write window
                    if (a >= ADDR_CTIOUTEN_BASE &&
                        a < ADDR_CTIOUTEN_BASE + TRIG_OUT_NUM*4) begin
                        int idx = (a - ADDR_CTIOUTEN_BASE) / 4;
                        if (idx < TRIG_OUT_NUM)
                            outen[idx] <= pwdata[CHANNEL_NUM-1:0];
                    end
                end
            end
        end
    end

endmodule

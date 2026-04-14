// ============================================================
// sts_ctm — Cross Trigger Matrix (CTM)
//
// Generic N-interface, M-channel OR-crossbar with registered
// outputs. Each interface output = OR of all other interfaces'
// inputs (1-cycle latency), matching ARM CSS600 CTM semantics.
//
// Parameters:
//   NUM_INTF     — number of interfaces (≥ 2)
//   CHANNEL_WIDTH — bit-width per channel per interface
// ============================================================
module sts_ctm
#(
    parameter integer unsigned NUM_INTF      = 4  ,
    parameter integer unsigned CHANNEL_WIDTH = 8
)(
    input   logic                                       clk         ,
    input   logic                                       rst_n       ,

    // ---- Per-interface I/O (flat-packed) ----
    input   logic [NUM_INTF*CHANNEL_WIDTH-1:0]          ch_in       ,
    output  logic [NUM_INTF*CHANNEL_WIDTH-1:0]          ch_out
);

    // ----------------------------------------------------------------
    // Unpack flat input into per-interface array
    // ----------------------------------------------------------------
    logic [CHANNEL_WIDTH-1:0] ch_in_arr  [NUM_INTF-1:0];
    logic [CHANNEL_WIDTH-1:0] ch_nxt     [NUM_INTF-1:0];
    logic [CHANNEL_WIDTH-1:0] ch_out_arr [NUM_INTF-1:0];

    genvar gi;
    generate
        for (gi = 0; gi < NUM_INTF; gi = gi + 1) begin : g_unpack
            assign ch_in_arr[gi] = ch_in[gi*CHANNEL_WIDTH +: CHANNEL_WIDTH];
        end
    endgenerate

    // ----------------------------------------------------------------
    // Combinational OR crossbar: output[i] = OR of all input[j] where j≠i
    // ----------------------------------------------------------------
    always_comb begin
        for (int i = 0; i < NUM_INTF; i = i + 1) begin
            ch_nxt[i] = '0;
            for (int j = 0; j < NUM_INTF; j = j + 1) begin
                if (j != i) ch_nxt[i] = ch_nxt[i] | ch_in_arr[j];
            end
        end
    end

    // ----------------------------------------------------------------
    // Registered outputs (1-cycle latency)
    // ----------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < NUM_INTF; i = i + 1) begin
                ch_out_arr[i] <= '0;
            end
        end
        else begin
            for (int i = 0; i < NUM_INTF; i = i + 1) begin
                ch_out_arr[i] <= ch_nxt[i];
            end
        end
    end

    // ----------------------------------------------------------------
    // Pack per-interface array back to flat output
    // ----------------------------------------------------------------
    generate
        for (gi = 0; gi < NUM_INTF; gi = gi + 1) begin : g_pack
            assign ch_out[gi*CHANNEL_WIDTH +: CHANNEL_WIDTH] = ch_out_arr[gi];
        end
    endgenerate

endmodule

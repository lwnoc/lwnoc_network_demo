//============================================================================
// sts_iniu_addr_map — Parameterized AXI address-to-tgtid mapper
//
// Range-based (first-match priority):
//      hit = (start <= in_addr) && (in_addr <= end)
//    Parameter packing (flattened vectors, LSB = entry 0):
//      ADDR_START_TABLE : {start[N-1], ..., start[1], start[0]}
//      ADDR_END_TABLE   : {end[N-1],   ..., end[1],   end[0]}
//      TGT_ID_TABLE     : {tgtid[N-1], ..., tgtid[1], tgtid[0]}
//    Constraints:
//      - start <= end for every entry
//      - Entry 0 has highest priority; entries may overlap (first-match wins)
//      - Full AXI address width is compared unless masked by ADDR_MASK_BITS
//
// No match → DEFAULT_TGT_ID
//
// Example (non-power-of-two windows):
//   ENTRY_NUM         = 2
//   ADDR_START_TABLE  = {32'h0000_2000, 32'h0000_0000}
//   ADDR_END_TABLE    = {32'h0001_FFFF, 32'h0000_0FFF}
//   TGT_ID_TABLE      = {8'h41,         8'h40}
//   DEFAULT_TGT_ID    = 8'hFF
//============================================================================
module sts_iniu_addr_map
import lwnoc_sts_pack::*;
#(
    // --- Range-based entries ---
    parameter integer unsigned ENTRY_NUM = 1,
    parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_START_TABLE = '0,
    parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_END_TABLE   = '0,
    parameter logic [ENTRY_NUM*TGT_ID_WIDTH-1:0]   TGT_ID_TABLE     = '0,
    // --- Default ---
    parameter logic [TGT_ID_WIDTH-1:0]     DEFAULT_TGT_ID    = '0,
    // --- Addr compare mask (bit 0 = LSB) ---
    // Top N bits of the address are masked before comparison.
    // ADDR_MASK_BITS=0 -> all bits compared. ADDR_MASK_BITS=1 -> bit[31] ignored.
    parameter integer unsigned ADDR_MASK_BITS   = 0
)(
    input   logic [AXI_ADDR_WIDTH-1:0] in_addr,
    output  logic [TGT_ID_WIDTH-1:0]   out_tgt_id,
    output  logic                      out_hit
);

    // Cmp mask: top ADDR_MASK_BITS bits cleared; LSB side kept for comparison.
    localparam logic [AXI_ADDR_WIDTH-1:0] ADDR_CMP_MASK =
        (ADDR_MASK_BITS >= AXI_ADDR_WIDTH) ? '0
        : {{(AXI_ADDR_WIDTH-ADDR_MASK_BITS){1'b1}}, {ADDR_MASK_BITS{1'b0}}};

    // --- Range-based match (first-hit priority) ---
    logic table_hit;
    logic [TGT_ID_WIDTH-1:0] table_tgt_id;

    always_comb begin
        table_tgt_id = DEFAULT_TGT_ID;
        table_hit    = 1'b0;

        for (int entry_idx = 0; entry_idx < ENTRY_NUM; entry_idx++) begin
            automatic logic [AXI_ADDR_WIDTH-1:0] addr_start;
            automatic logic [AXI_ADDR_WIDTH-1:0] addr_end;
            automatic logic [TGT_ID_WIDTH-1:0]   tgt_id;

            addr_start = ADDR_START_TABLE[entry_idx*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH];
            addr_end   = ADDR_END_TABLE  [entry_idx*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH];
            tgt_id     = TGT_ID_TABLE    [entry_idx*TGT_ID_WIDTH   +: TGT_ID_WIDTH];

            if (!table_hit && ((in_addr & ADDR_CMP_MASK) >= (addr_start & ADDR_CMP_MASK))
                           && ((in_addr & ADDR_CMP_MASK) <= (addr_end   & ADDR_CMP_MASK))) begin
                table_tgt_id = tgt_id;
                table_hit    = 1'b1;
            end
        end
    end

    // --- Table hit or default ---
    assign out_hit    = table_hit;
    assign out_tgt_id = table_hit ? table_tgt_id : DEFAULT_TGT_ID;

endmodule

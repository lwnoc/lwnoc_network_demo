//============================================================================
// sts_iniu_addr_map — Parameterized AXI address-to-tgtid mapper
//
// Two decode modes (can work together, table has higher priority):
//
// 1) Table-based (irregular targets, first-match priority):
//      hit = (in_addr & MASK) == (BASE & MASK)
//    Parameter packing (flattened vectors, LSB = entry 0):
//      ADDR_BASE_TABLE : {base[N-1], ..., base[1], base[0]}
//      ADDR_MASK_TABLE : {mask[N-1], ..., mask[1], mask[0]}
//      TGT_ID_TABLE    : {tgtid[N-1], ..., tgtid[1], tgtid[0]}
//    Constraints:
//      - BASE naturally aligned to MASK (BASE & ~MASK == 0)
//      - MASK is contiguous high bits (e.g. 32'hFFFF_F000)
//      - Entry 0 has highest priority; entries should not overlap
//
// 2) Linear region (regularly-spaced targets, e.g. 32 NIUs × 8KB):
//      tgt_id = LINEAR_TGT_BASE + (in_addr - LINEAR_BASE) >> LINEAR_STRIDE_LOG2
//    Enabled by LINEAR_EN = 1.
//    Constraints:
//      - All targets same size = 2^LINEAR_STRIDE_LOG2 bytes
//      - LINEAR_NUM targets, contiguous from LINEAR_BASE
//      - LINEAR_TGT_BASE + LINEAR_NUM - 1 must fit in TGT_ID_WIDTH
//
// Priority: table > linear > DEFAULT_TGT_ID
//
// Example (regbank 4KB + RSC 4KB + 32 NIUs × 8KB):
//   ENTRY_NUM       = 2
//   ADDR_BASE_TABLE = {32'h0000_1000, 32'h0000_0000}   // RSC, regbank
//   ADDR_MASK_TABLE = {32'hFFFF_F000, 32'hFFFF_F000}
//   TGT_ID_TABLE    = {8'h41,         8'h40}
//   LINEAR_EN       = 1
//   LINEAR_BASE     = 32'h0000_2000
//   LINEAR_NUM      = 32
//   LINEAR_STRIDE_LOG2 = 13    // 8KB = 2^13
//   LINEAR_TGT_BASE = 8'h00   // NIU#0 → 0x00, NIU#31 → 0x1F
//   DEFAULT_TGT_ID  = 8'hFF
//============================================================================
module ddr9_tniu_sts_iniu_addr_map
import ddr9_tniu_lwnoc_sts_pack::*;
#(
    // --- Table-based entries (irregular targets) ---
    parameter integer unsigned ENTRY_NUM = 1,
    parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_BASE_TABLE = '0,
    parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MASK_TABLE = '0,
    parameter logic [ENTRY_NUM*TGT_ID_WIDTH-1:0]   TGT_ID_TABLE    = '0,
    // --- Linear region (regularly-spaced targets) ---
    parameter bit                          LINEAR_EN         = 0,
    parameter logic [AXI_ADDR_WIDTH-1:0]   LINEAR_BASE       = '0,  // base addr of first target
    parameter integer unsigned             LINEAR_NUM        = 1,   // number of targets
    parameter integer unsigned             LINEAR_STRIDE_LOG2 = 0,  // log2(bytes per target)
    parameter logic [TGT_ID_WIDTH-1:0]     LINEAR_TGT_BASE   = '0, // tgt_id of first target
    // --- Default ---
    parameter logic [TGT_ID_WIDTH-1:0]     DEFAULT_TGT_ID    = '0
)(
    input   logic [AXI_ADDR_WIDTH-1:0] in_addr,
    output  logic [TGT_ID_WIDTH-1:0]   out_tgt_id,
    output  logic                      out_hit
);

    // --- Table-based match ---
    logic table_hit;
    logic [TGT_ID_WIDTH-1:0] table_tgt_id;

    always_comb begin
        table_tgt_id = '0;
        table_hit    = 1'b0;

        for (int entry_idx = 0; entry_idx < ENTRY_NUM; entry_idx++) begin
            if (
                !table_hit &&
                ((in_addr & ADDR_MASK_TABLE[entry_idx*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH]) ==
                 (ADDR_BASE_TABLE[entry_idx*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH] &
                  ADDR_MASK_TABLE[entry_idx*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH]))
            ) begin
                table_tgt_id = TGT_ID_TABLE[entry_idx*TGT_ID_WIDTH +: TGT_ID_WIDTH];
                table_hit    = 1'b1;
            end
        end
    end

    // --- Linear region match ---
    logic linear_hit;
    logic [TGT_ID_WIDTH-1:0] linear_tgt_id;

    generate
        if (LINEAR_EN) begin : g_linear
            logic [AXI_ADDR_WIDTH-1:0] linear_offset;
            logic [AXI_ADDR_WIDTH-1:0] linear_limit;

            assign linear_offset = in_addr - LINEAR_BASE;
            assign linear_limit  = AXI_ADDR_WIDTH'(LINEAR_NUM) << LINEAR_STRIDE_LOG2;

            assign linear_hit    = (in_addr >= LINEAR_BASE) && (linear_offset < linear_limit);
            assign linear_tgt_id = LINEAR_TGT_BASE + TGT_ID_WIDTH'(linear_offset >> LINEAR_STRIDE_LOG2);
        end else begin : g_no_linear
            assign linear_hit    = 1'b0;
            assign linear_tgt_id = '0;
        end
    endgenerate

    // --- Priority: table > linear > default ---
    assign out_hit    = table_hit || linear_hit;
    assign out_tgt_id = table_hit  ? table_tgt_id  :
                        linear_hit ? linear_tgt_id :
                                     DEFAULT_TGT_ID;

endmodule

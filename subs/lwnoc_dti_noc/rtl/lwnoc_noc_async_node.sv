// lwnoc_noc_async_node — Generic bidirectional async crossing node
//
// Bridges a req/rsp pair across two independent clock domains (clk_a / clk_b).
// Internally instantiates four fcip_afifo_slv/mst half-FIFOs connected by ptr
// wires — REQ flows from domain-A write to domain-B read; RSP is the reverse.
//
// Protocol variants (controlled by HAS_LAST parameter):
//   HAS_LAST=0 : Pure vld/rdy/pld — use for STS-style switch nodes
//                (last ports exist but are tied to 0 / ignored)
//   HAS_LAST=1 : vld/rdy/pld/last — use for DTI/GNPD-style NIU/switch nodes
//                (last is packed as bit[0] inside the async FIFO payload)
//
// REQ_PLD_WIDTH and RSP_PLD_WIDTH are independent — caller passes
// $bits(<packed_struct>) for struct-typed payloads.
//
// LP control (stall/clear/full_zero/idle) is exposed as ports and should be
// driven by external lwnoc_lp_tniu_async_bridge instances.  Tie to 0 if LP
// is not needed.
//
// Usage — STS butterfly switch async port (no last, symmetric widths):
//   lwnoc_noc_async_node #(
//       .REQ_PLD_WIDTH($bits(sts_req_typ)),
//       .RSP_PLD_WIDTH($bits(sts_rsp_typ)),
//       .HAS_LAST(0)
//   ) u_sts_async_node (...);
//
// Usage — DTI/GNPD NIU boundary (with last, asymmetric widths possible):
//   lwnoc_noc_async_node #(
//       .REQ_PLD_WIDTH(CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH+TBU_NUM_WIDTH*2+1),
//       .RSP_PLD_WIDTH(CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH+TBU_NUM_WIDTH*2+1),
//       .HAS_LAST(1)
//   ) u_dti_async_node (...);

`ifndef _PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

module `_PREFIX_(lwnoc_noc_async_node) #(
    parameter integer unsigned REQ_PLD_WIDTH = 32   ,   // req payload width (excl. last)
    parameter integer unsigned RSP_PLD_WIDTH = 32   ,   // rsp payload width (excl. last)
    parameter integer unsigned HAS_LAST      = 0    ,   // 1=pack last into FIFO, 0=no last
    parameter integer unsigned FIFO_DEPTH    = 16   ,   // async FIFO depth (power of 2)
    parameter integer unsigned SYNC_STAGE    = 2        // CDC sync chain stages
)(
    // ── Domain A (initiator / source side) ───────────────────────────────────
    input  logic                             clk_a           ,
    input  logic                             rst_a_n         ,

    // REQ slave: accept req from domain-A and forward to domain-B
    input  logic                             req_s_vld_a     ,
    output logic                             req_s_rdy_a     ,
    input  logic [REQ_PLD_WIDTH-1:0]         req_s_pld_a     ,
    input  logic                             req_s_last_a    ,   // used when HAS_LAST=1

    // RSP master: deliver rsp returning from domain-B to domain-A
    output logic                             rsp_m_vld_a     ,
    input  logic                             rsp_m_rdy_a     ,
    output logic [RSP_PLD_WIDTH-1:0]         rsp_m_pld_a     ,
    output logic                             rsp_m_last_a    ,   // valid when HAS_LAST=1

    // LP control (domain-A side): connect to LP bridge or tie to 0
    input  logic                             req_stall_a     ,
    input  logic                             req_clear_a     ,
    output logic                             req_full_zero_a ,   // for LP wakeup logic
    input  logic                             rsp_stall_a     ,
    input  logic                             rsp_clear_a     ,
    output logic                             rsp_idle_a      ,   // FIFO body-only idle (NOT LP bridge input). LP bridge uses rsp_full_zero_b. For full in-transit detection: (~rsp_idle_a || rsp_m_vld_a)

    // ── Domain B (target / destination side) ─────────────────────────────────
    input  logic                             clk_b           ,
    input  logic                             rst_b_n         ,

    // REQ master: output req to domain-B logic
    output logic                             req_m_vld_b     ,
    input  logic                             req_m_rdy_b     ,
    output logic [REQ_PLD_WIDTH-1:0]         req_m_pld_b     ,
    output logic                             req_m_last_b    ,   // valid when HAS_LAST=1

    // RSP slave: accept rsp from domain-B logic and return to domain-A
    input  logic                             rsp_s_vld_b     ,
    output logic                             rsp_s_rdy_b     ,
    input  logic [RSP_PLD_WIDTH-1:0]         rsp_s_pld_b     ,
    input  logic                             rsp_s_last_b    ,   // used when HAS_LAST=1

    // LP control (domain-B side): connect to LP bridge or tie to 0
    input  logic                             req_stall_b     ,
    input  logic                             req_clear_b     ,
    output logic                             req_idle_b      ,   // FIFO body-only idle (NOT LP bridge input). LP bridge uses req_full_zero_a. For full in-transit detection: (~req_idle_b || req_m_vld_b)
    input  logic                             rsp_stall_b     ,
    input  logic                             rsp_clear_b     ,
    output logic                             rsp_full_zero_b     // for LP wakeup logic
);

    // ──────────────────────────────────────────────────────────────────────────
    // Internal FIFO payload width = protocol payload + 1 bit for `last` when
    // HAS_LAST=1.  last is always packed as bit[0]; pld occupies [WIDTH-1:1].
    // ──────────────────────────────────────────────────────────────────────────
    localparam integer unsigned REQ_FIFO_WIDTH = REQ_PLD_WIDTH + HAS_LAST ;
    localparam integer unsigned RSP_FIFO_WIDTH = RSP_PLD_WIDTH + HAS_LAST ;

    // REQ pointer wires: domain-A (write) ↔ domain-B (read)
    logic [FIFO_DEPTH-1:0]       req_wptr_async  ;
    logic [FIFO_DEPTH-1:0]       req_rptr_async  ;
    logic [FIFO_DEPTH-1:0]       req_rptr_sync   ;
    logic [REQ_FIFO_WIDTH:0]     req_pld_sync    ;   // DATA_WIDTH:0 = DW+1 bits

    // RSP pointer wires: domain-B (write) ↔ domain-A (read)
    logic [FIFO_DEPTH-1:0]       rsp_wptr_async  ;
    logic [FIFO_DEPTH-1:0]       rsp_rptr_async  ;
    logic [FIFO_DEPTH-1:0]       rsp_rptr_sync   ;
    logic [RSP_FIFO_WIDTH:0]     rsp_pld_sync    ;   // DATA_WIDTH:0 = DW+1 bits

    // Packed FIFO payloads
    logic [REQ_FIFO_WIDTH-1:0]   req_s_pld_packed    ;
    logic [REQ_FIFO_WIDTH-1:0]   req_m_pld_packed    ;
    logic [RSP_FIFO_WIDTH-1:0]   rsp_s_pld_packed    ;
    logic [RSP_FIFO_WIDTH-1:0]   rsp_m_pld_packed    ;

    // ──────────────────────────────────────────────────────────────────────────
    // Pack / unpack `last` into/from FIFO payload
    // ──────────────────────────────────────────────────────────────────────────
    generate
        if (HAS_LAST) begin : g_with_last
            // REQ: {pld, last} → FIFO → {pld, last}
            assign req_s_pld_packed             = {req_s_pld_a,  req_s_last_a};
            assign req_m_pld_b                  = req_m_pld_packed[REQ_FIFO_WIDTH-1:1];
            assign req_m_last_b                 = req_m_pld_packed[0];
            // RSP: {pld, last} → FIFO → {pld, last}
            assign rsp_s_pld_packed             = {rsp_s_pld_b,  rsp_s_last_b};
            assign rsp_m_pld_a                  = rsp_m_pld_packed[RSP_FIFO_WIDTH-1:1];
            assign rsp_m_last_a                 = rsp_m_pld_packed[0];
        end else begin : g_no_last
            assign req_s_pld_packed             = req_s_pld_a;
            assign req_m_pld_b                  = req_m_pld_packed;
            assign req_m_last_b                 = 1'b0;
            assign rsp_s_pld_packed             = rsp_s_pld_b;
            assign rsp_m_pld_a                  = rsp_m_pld_packed;
            assign rsp_m_last_a                 = 1'b0;
        end
    endgenerate

    // ──────────────────────────────────────────────────────────────────────────
    // REQ path: domain-A writes, domain-B reads
    // ──────────────────────────────────────────────────────────────────────────
    fcip_afifo_slv #(
        .DATA_WIDTH         (REQ_FIFO_WIDTH     ),
        .FIFO_DEPTH         (FIFO_DEPTH         ),
        .SYNC_STAGE         (SYNC_STAGE         )
    ) u_req_slv (
        .clk                (clk_a              ),
        .rst_n              (rst_a_n            ),
        .stall              (req_stall_a        ),
        .clear              (req_clear_a        ),
        .full_zero          (req_full_zero_a    ),
        .s_vld              (req_s_vld_a        ),
        .s_pld              (req_s_pld_packed   ),
        .s_rdy              (req_s_rdy_a        ),
        .almost_full        (                   ),
        .wptr_async         (req_wptr_async     ),
        .rptr_async         (req_rptr_async     ),
        .rptr_sync          (req_rptr_sync      ),
        .pld_sync           (req_pld_sync       )
    );

    fcip_afifo_mst #(
        .DATA_WIDTH         (REQ_FIFO_WIDTH     ),
        .FIFO_DEPTH         (FIFO_DEPTH         ),
        .SYNC_STAGE         (SYNC_STAGE         )
    ) u_req_mst (
        .clk                (clk_b              ),
        .rst_n              (rst_b_n            ),
        .stall              (req_stall_b        ),
        .clear              (req_clear_b        ),
        .full_zero          (                   ),
        .idle               (req_idle_b         ),
        .m_vld              (req_m_vld_b        ),
        .m_pld              (req_m_pld_packed   ),
        .m_rdy              (req_m_rdy_b        ),
        .almost_empty       (                   ),
        .wptr_async         (req_wptr_async     ),
        .rptr_async         (req_rptr_async     ),
        .rptr_sync          (req_rptr_sync      ),
        .pld_sync           (req_pld_sync       )
    );

    // ──────────────────────────────────────────────────────────────────────────
    // RSP path: domain-B writes, domain-A reads
    // ──────────────────────────────────────────────────────────────────────────
    fcip_afifo_slv #(
        .DATA_WIDTH         (RSP_FIFO_WIDTH     ),
        .FIFO_DEPTH         (FIFO_DEPTH         ),
        .SYNC_STAGE         (SYNC_STAGE         )
    ) u_rsp_slv (
        .clk                (clk_b              ),
        .rst_n              (rst_b_n            ),
        .stall              (rsp_stall_b        ),
        .clear              (rsp_clear_b        ),
        .full_zero          (rsp_full_zero_b    ),
        .s_vld              (rsp_s_vld_b        ),
        .s_pld              (rsp_s_pld_packed   ),
        .s_rdy              (rsp_s_rdy_b        ),
        .almost_full        (                   ),
        .wptr_async         (rsp_wptr_async     ),
        .rptr_async         (rsp_rptr_async     ),
        .rptr_sync          (rsp_rptr_sync      ),
        .pld_sync           (rsp_pld_sync       )
    );

    fcip_afifo_mst #(
        .DATA_WIDTH         (RSP_FIFO_WIDTH     ),
        .FIFO_DEPTH         (FIFO_DEPTH         ),
        .SYNC_STAGE         (SYNC_STAGE         )
    ) u_rsp_mst (
        .clk                (clk_a              ),
        .rst_n              (rst_a_n            ),
        .stall              (rsp_stall_a        ),
        .clear              (rsp_clear_a        ),
        .full_zero          (                   ),
        .idle               (rsp_idle_a         ),
        .m_vld              (rsp_m_vld_a        ),
        .m_pld              (rsp_m_pld_packed   ),
        .m_rdy              (rsp_m_rdy_a        ),
        .almost_empty       (                   ),
        .wptr_async         (rsp_wptr_async     ),
        .rptr_async         (rsp_rptr_async     ),
        .rptr_sync          (rsp_rptr_sync      ),
        .pld_sync           (rsp_pld_sync       )
    );

endmodule

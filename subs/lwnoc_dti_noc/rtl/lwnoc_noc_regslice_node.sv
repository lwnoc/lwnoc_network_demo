// lwnoc_noc_regslice_node — Generic bidirectional pipeline register (插拍) node
//
// Inserts a register-slice stage on both the req and rsp channels of a
// standard vld/rdy/pld handshake interface.  Single clock domain — use for
// pipeline retiming or timing-path cutting within one clock domain.
//
// Protocol variants (controlled by HAS_LAST parameter):
//   HAS_LAST=0 : Pure vld/rdy/pld — use for STS-style switch nodes
//                (last ports exist but are tied to 0 / ignored)
//   HAS_LAST=1 : vld/rdy/pld/last — use for DTI/GNPD-style NIU/switch nodes
//                (last is packed as bit[0] through the register slice)
//
// RS_TYPE controls the register-slice implementation (from fcip_reg_slice):
//   0 = Full (2-entry, fully registered vld+rdy — best timing, 1-cycle latency)
//   1 = Forward (registered forward path, combinational ready — min area)
//   2 = Backward (combinational forward, registered ready — cuts rdy timing)
//
// REQ_PLD_WIDTH and RSP_PLD_WIDTH are independent.  Pass $bits(<struct>) for
// packed-struct payloads.
//
// Usage — STS switch regslice node (no last):
//   lwnoc_noc_regslice_node #(
//       .REQ_PLD_WIDTH($bits(sts_req_typ)), .RSP_PLD_WIDTH($bits(sts_rsp_typ)),
//       .HAS_LAST(0), .RS_TYPE(1)
//   ) u_sts_rs_node (...);
//
// Usage — DTI/GNPD regslice node (with last):
//   lwnoc_noc_regslice_node #(
//       .REQ_PLD_WIDTH(REQ_W), .RSP_PLD_WIDTH(RSP_W),
//       .HAS_LAST(1), .RS_TYPE(1)
//   ) u_dti_rs_node (...);

`ifndef _PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

module `_PREFIX_(lwnoc_noc_regslice_node) #(
    parameter integer unsigned REQ_PLD_WIDTH = 32   ,   // req payload width (excl. last)
    parameter integer unsigned RSP_PLD_WIDTH = 32   ,   // rsp payload width (excl. last)
    parameter integer unsigned HAS_LAST      = 0    ,   // 1=pass last through RS, 0=no last
    parameter integer          RS_TYPE       = 1        // 0:full, 1:forward, 2:backward
)(
    input  logic                         clk             ,
    input  logic                         rst_n           ,

    // REQ slave → master (data flows from slv to mst)
    input  logic                         req_s_vld       ,
    output logic                         req_s_rdy       ,
    input  logic [REQ_PLD_WIDTH-1:0]     req_s_pld       ,
    input  logic                         req_s_last      ,   // used when HAS_LAST=1

    output logic                         req_m_vld       ,
    input  logic                         req_m_rdy       ,
    output logic [REQ_PLD_WIDTH-1:0]     req_m_pld       ,
    output logic                         req_m_last      ,   // valid when HAS_LAST=1

    // RSP slave → master (data flows opposite direction; naming follows protocol)
    input  logic                         rsp_s_vld       ,
    output logic                         rsp_s_rdy       ,
    input  logic [RSP_PLD_WIDTH-1:0]     rsp_s_pld       ,
    input  logic                         rsp_s_last      ,   // used when HAS_LAST=1

    output logic                         rsp_m_vld       ,
    input  logic                         rsp_m_rdy       ,
    output logic [RSP_PLD_WIDTH-1:0]     rsp_m_pld       ,
    output logic                         rsp_m_last          // valid when HAS_LAST=1
);

    // ──────────────────────────────────────────────────────────────────────────
    // Internal RS payload width: pack `last` as bit[0] when HAS_LAST=1
    // ──────────────────────────────────────────────────────────────────────────
    localparam integer unsigned REQ_RS_WIDTH = REQ_PLD_WIDTH + HAS_LAST ;
    localparam integer unsigned RSP_RS_WIDTH = RSP_PLD_WIDTH + HAS_LAST ;

    logic [REQ_RS_WIDTH-1:0]  req_s_pld_packed    ;
    logic [REQ_RS_WIDTH-1:0]  req_m_pld_packed    ;
    logic [RSP_RS_WIDTH-1:0]  rsp_s_pld_packed    ;
    logic [RSP_RS_WIDTH-1:0]  rsp_m_pld_packed    ;

    // ──────────────────────────────────────────────────────────────────────────
    // Pack / unpack `last`
    // ──────────────────────────────────────────────────────────────────────────
    generate
        if (HAS_LAST) begin : g_with_last
            assign req_s_pld_packed             = {req_s_pld,  req_s_last};
            assign req_m_pld                    = req_m_pld_packed[REQ_RS_WIDTH-1:1];
            assign req_m_last                   = req_m_pld_packed[0];
            assign rsp_s_pld_packed             = {rsp_s_pld,  rsp_s_last};
            assign rsp_m_pld                    = rsp_m_pld_packed[RSP_RS_WIDTH-1:1];
            assign rsp_m_last                   = rsp_m_pld_packed[0];
        end else begin : g_no_last
            assign req_s_pld_packed             = req_s_pld;
            assign req_m_pld                    = req_m_pld_packed;
            assign req_m_last                   = 1'b0;
            assign rsp_s_pld_packed             = rsp_s_pld;
            assign rsp_m_pld                    = rsp_m_pld_packed;
            assign rsp_m_last                   = 1'b0;
        end
    endgenerate

    // ──────────────────────────────────────────────────────────────────────────
    // REQ register slice (slave → master direction)
    // ──────────────────────────────────────────────────────────────────────────
    fcip_reg_slice #(
        .PLD_TYPE           (logic [REQ_RS_WIDTH-1:0]   ),
        .RS_TYPE            (RS_TYPE                    )
    ) u_req_rs (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .s_vld              (req_s_vld                  ),
        .s_rdy              (req_s_rdy                  ),
        .s_pld              (req_s_pld_packed           ),
        .m_vld              (req_m_vld                  ),
        .m_rdy              (req_m_rdy                  ),
        .m_pld              (req_m_pld_packed           )
    );

    // ──────────────────────────────────────────────────────────────────────────
    // RSP register slice (slave → master direction, flows opposite to req)
    // ──────────────────────────────────────────────────────────────────────────
    fcip_reg_slice #(
        .PLD_TYPE           (logic [RSP_RS_WIDTH-1:0]   ),
        .RS_TYPE            (RS_TYPE                    )
    ) u_rsp_rs (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .s_vld              (rsp_s_vld                  ),
        .s_rdy              (rsp_s_rdy                  ),
        .s_pld              (rsp_s_pld_packed           ),
        .m_vld              (rsp_m_vld                  ),
        .m_rdy              (rsp_m_rdy                  ),
        .m_pld              (rsp_m_pld_packed           )
    );

endmodule

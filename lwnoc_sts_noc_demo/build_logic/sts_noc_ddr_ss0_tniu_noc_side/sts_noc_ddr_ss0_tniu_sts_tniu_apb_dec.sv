// Parameterized APB 1-to-M decoder — routes by tgt_id (base/mask match)
// MASTER_NUM: number of downstream master ports
// ROUTE_BASE/ROUTE_MASK: per-master tgt_id routing table
// Decode miss returns pslverr = 1.
module sts_noc_ddr_ss0_tniu_sts_tniu_apb_dec
import sts_noc_ddr_ss0_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned APB_ADDR_WIDTH = 32,
    parameter integer unsigned MASTER_NUM     = 2,
    parameter logic [MASTER_NUM*TGT_ID_WIDTH-1:0] ROUTE_BASE = '0,
    parameter logic [MASTER_NUM*TGT_ID_WIDTH-1:0] ROUTE_MASK = '0
) (
    input   logic                               clk         ,
    input   logic                               rst_n       ,

    input   logic                               s_psel      ,
    input   logic                               s_penable   ,
    input   logic [APB_ADDR_WIDTH-1:0]          s_paddr     ,
    input   logic [TGT_ID_WIDTH-1:0]            s_ptgt_id   ,
    input   logic                               s_pwrite    ,
    input   logic [31:0]                        s_pwdata    ,
    output  logic [31:0]                        s_prdata    ,
    output  logic                               s_pready    ,
    input   logic [3:0]                         s_pstrb     ,
    input   logic [2:0]                         s_pprot     ,
    output  logic                               s_pslverr   ,

    output  logic [MASTER_NUM-1:0]              m_psel      ,
    output  logic [APB_ADDR_WIDTH-1:0]          m_paddr     ,
    input   logic [MASTER_NUM-1:0]              m_pready    ,
    input   logic [MASTER_NUM*32-1:0]           m_prdata    ,
    input   logic [MASTER_NUM-1:0]              m_pslverr   ,
    output  logic [2:0]                         m_pprot     ,
    output  logic                               m_penable   ,
    output  logic                               m_pwrite    ,
    output  logic [31:0]                        m_pwdata    ,
    output  logic [3:0]                         m_pstrb
);

logic [MASTER_NUM-1:0] hit;
logic                  dec_miss;

genvar gi;
generate
    for (gi = 0; gi < MASTER_NUM; gi = gi + 1) begin : g_route
        logic [TGT_ID_WIDTH-1:0] base_i;
        logic [TGT_ID_WIDTH-1:0] mask_i;
        assign base_i = ROUTE_BASE[gi*TGT_ID_WIDTH +: TGT_ID_WIDTH];
        assign mask_i = ROUTE_MASK[gi*TGT_ID_WIDTH +: TGT_ID_WIDTH];
        assign hit[gi] = s_psel && ((s_ptgt_id & mask_i) == (base_i & mask_i));
    end
endgenerate

assign dec_miss = s_psel && !(|hit);
assign m_psel   = hit;

always_comb begin
    s_prdata  = '0;
    s_pready  = dec_miss;
    s_pslverr = dec_miss;
    for (int i = 0; i < MASTER_NUM; i = i + 1) begin
        if (hit[i]) begin
            s_prdata  = m_prdata[i*32 +: 32];
            s_pready  = m_pready[i];
            s_pslverr = m_pslverr[i];
        end
    end
end

assign m_paddr   = s_paddr;
assign m_pprot   = s_pprot;
assign m_penable = s_penable;
assign m_pwrite  = s_pwrite;
assign m_pwdata  = s_pwdata;
assign m_pstrb   = s_pstrb;

endmodule

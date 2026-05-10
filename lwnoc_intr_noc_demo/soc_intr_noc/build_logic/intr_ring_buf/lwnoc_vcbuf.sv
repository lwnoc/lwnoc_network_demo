module lwnoc_vcbuf #(
    parameter  integer unsigned PLD_WIDTH   = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter  integer unsigned ID_WIDTH    = `INTR_NETWORK_RING_ID_WIDTH,
    parameter  integer unsigned QOS_WIDTH   = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter  integer unsigned BUF_DEP     = `INTR_NETWORK_RING_BUF_DEP,
    parameter  integer unsigned AFULL_LEVEL = `INTR_NETWORK_VCBUF_AFULL_LEVEL
)(
    input  logic                        clk     ,
    input  logic                        rst_n   ,

    input  logic                        vld_src   ,
    input  logic [PLD_WIDTH-1:0]        pld_src   ,
    input  logic [ID_WIDTH-1:0]         srcid_src ,
    input  logic [ID_WIDTH-1:0]         tgtid_src ,
    input  logic [QOS_WIDTH-1:0]        qos_src   ,
    input  logic                        tail_src  ,
    input  logic                        vcid_src  ,
    output logic [1:0]                  vc_rdy_src,

    output logic                        vld_dst     ,
    output logic [PLD_WIDTH-1:0]        pld_dst     ,
    output logic [ID_WIDTH-1:0]         srcid_dst   ,
    output logic [ID_WIDTH-1:0]         tgtid_dst   ,
    output logic [QOS_WIDTH-1:0]        qos_dst     ,
    output logic                        tail_dst    ,
    output logic                        vcid_dst    ,
    input  logic [1:0]                  vc_rdy_dst
);

localparam integer unsigned FIFO_WID = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 1;
localparam integer unsigned FIX_ARB_WID = FIFO_WID + 1;

logic [1:0]                  vc_rdy_dff1;
logic [FIFO_WID-1:0]         vc_buf_dat_in;
logic [1:0]                  vc_buf_wren;
logic [1:0]                  vc_buf_rden;
logic [1:0]                  vc_buf_afull;
logic [1:0]                  vc_buf_full;
logic [1:0]                  vc_buf_empty;
logic [FIFO_WID-1:0]         vc_buf_dat_out [1:0];
logic [1:0]                  arb_s_vld;
logic                        arb_s_rdy;
logic                        arb_s_rdy_unused;
logic [FIX_ARB_WID-1:0]      arb_s_pld [1:0];
logic                        arb_m_vld;
logic [FIX_ARB_WID-1:0]      arb_m_pld;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)           vc_rdy_dff1 <= 2'd0;
    else                 vc_rdy_dff1 <= vc_rdy_dst;
end

assign vc_rdy_src = ~vc_buf_afull;

assign vc_buf_dat_in = {pld_src, srcid_src, tgtid_src, qos_src, tail_src};

assign vc_buf_rden[1] = vc_rdy_dff1[1];
assign vc_buf_rden[0] = vc_rdy_dff1[0] && arb_s_rdy;

genvar i;
generate for(i=0; i<2; i++) begin: GEN_VCBUF
    assign arb_s_vld  [i] =  vc_buf_rden[i] && !vc_buf_empty[i];
    assign vc_buf_wren[i] =  vld_src        && (vcid_src == i[0]) && !vc_buf_full[i];
    assign arb_s_pld  [i] = {vc_buf_dat_out[i], i[0]};

    lwnoc_sfifo #(
        .FIFO_WIDTH  (FIFO_WID        ),
        .BUF_DEP     (BUF_DEP         ),
        .AFULL_LEVEL (AFULL_LEVEL     )
    ) u_vc_buf (
        .clk        (clk              ),
        .rst_n      (rst_n            ),
        .data_in    (vc_buf_dat_in    ),
        .data_out   (vc_buf_dat_out[i]),
        .wr_en      (vc_buf_wren   [i]),
        .rd_en      (vc_buf_rden   [i]),
        .afull      (vc_buf_afull  [i]),
        .full       (vc_buf_full   [i]),
        .empty      (vc_buf_empty  [i])
    );
end
endgenerate

// synthesis translate_off
`ifndef SYNTHESIS
assert property (@(posedge clk) disable iff (!rst_n)
    vld_src |-> !(vc_buf_full[vcid_src])
) else $error("[lwnoc_vcbuf] write-when-full: vcid_src=%0d", vcid_src);
`endif
// synthesis translate_on


fcip_fix_arb #(
    .PLD_TYPE  (logic [FIX_ARB_WID-1:0])
) u_arb (
    .clk                (clk              ),
    .rst_n              (rst_n            ),

    .s_vld_priority     (arb_s_vld[1]     ),
    .s_rdy_priority     (arb_s_rdy_unused ),
    .s_pld_priority     (arb_s_pld[1]     ),
    .s_vld              (arb_s_vld[0]     ),
    .s_rdy              (arb_s_rdy        ),
    .s_pld              (arb_s_pld[0]     ),

    .m_vld              (arb_m_vld        ),
    .m_rdy              (1'b1             ),
    .m_pld              (arb_m_pld        )
);

assign vld_dst      = arb_m_vld;
assign {pld_dst, srcid_dst, tgtid_dst, qos_dst, tail_dst, vcid_dst} = arb_m_pld;

endmodule

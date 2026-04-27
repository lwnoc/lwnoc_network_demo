module sts_iniu_wr_channel
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned ADDR_MAP_ENTRY_NUM = 1,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_BASE_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_MASK_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = '0,
    parameter bit                          ADDR_MAP_LINEAR_EN         = 0,
    parameter logic [AXI_ADDR_WIDTH-1:0]   ADDR_MAP_LINEAR_BASE       = '0,
    parameter integer unsigned             ADDR_MAP_LINEAR_NUM        = 1,
    parameter integer unsigned             ADDR_MAP_LINEAR_STRIDE_LOG2 = 0,
    parameter logic [TGT_ID_WIDTH-1:0]     ADDR_MAP_LINEAR_TGT_BASE   = '0,
    parameter logic [TGT_ID_WIDTH-1:0]                      ADDR_MAP_DEFAULT_TGT_ID = '0
)
(
    input logic                     clk,
    input logic                     rst_n,
    input logic [SRC_ID_WIDTH-1:0]  node_id,

    input   logic                   upstrm_aw_vld,
    output  logic                   upstrm_aw_rdy,
    input   sts_iniu_axi_aw_chnl    upstrm_aw_pld,

    input   logic                   upstrm_w_vld,
    output  logic                   upstrm_w_rdy,
    input   sts_iniu_axi_w_chnl     upstrm_w_pld,

    output  logic                   upstrm_b_vld,
    input   logic                   upstrm_b_rdy,
    output  sts_iniu_axi_b_chnl     upstrm_b_pld,

    output  logic                   out_req_vld,
    input   logic                   out_req_rdy,
    output  sts_req_typ             out_req_pld,

    input   logic                   in_rsp_vld,
    output  logic                   in_rsp_rdy,
    input   sts_rsp_typ             in_rsp_pld
);

logic                   aw_hold_vld;
logic                   w_hold_vld;
logic                   aw_stage_seen;
logic                   w_stage_seen;
sts_iniu_axi_aw_chnl    aw_hold_pld;
sts_iniu_axi_w_chnl     w_hold_pld;
logic                   fifo_out_aw_vld;
logic                   fifo_out_aw_rdy;
sts_iniu_axi_aw_chnl    fifo_out_aw_pld;
logic                   fifo_out_w_vld;
logic                   fifo_out_w_rdy;
sts_iniu_axi_w_chnl     fifo_out_w_pld;

// Merged Write Request Channel
logic                   merged_req_vld;
logic                   merged_req_rdy;
sts_req_typ             merged_req_pld;

logic                   rs_out_vld;
logic                   rs_out_rdy;
sts_req_typ             rs_out_pld;

logic [TXN_ID_WIDTH-1:0]                    alloc_id;
logic                                        alloc_vld;
logic                                        alloc_rdy;
logic                                        complete_rdy;
logic                                        retire_vld;
logic                                        retire_rdy;
logic [$clog2(STS_INIU_OT_TOTAL)-1:0]       complete_idx;
logic [$clog2(STS_INIU_OT_TOTAL)-1:0]       wr_id_alloc;

logic [AXI_AWID_WIDTH-1:0]                  check_id;
logic [STS_RSP_WIDTH-1:0]              retire_rsp_pld_flat;
sts_rsp_typ                                 retire_rsp_pld;

logic                   fifo_in_rsp_vld;
logic                   fifo_in_rsp_rdy;
sts_iniu_axi_b_chnl     fifo_in_rsp_pld;
logic [TGT_ID_WIDTH-1:0] mapped_aw_tgt_id;
logic                    mapped_aw_tgt_hit;

sts_iniu_addr_map #(
    .ENTRY_NUM      (ADDR_MAP_ENTRY_NUM),
    .ADDR_BASE_TABLE(ADDR_MAP_BASE_TABLE),
    .ADDR_MASK_TABLE(ADDR_MAP_MASK_TABLE),
    .TGT_ID_TABLE   (ADDR_MAP_TGT_ID_TABLE),
    .LINEAR_EN         (ADDR_MAP_LINEAR_EN),
    .LINEAR_BASE       (ADDR_MAP_LINEAR_BASE),
    .LINEAR_NUM        (ADDR_MAP_LINEAR_NUM),
    .LINEAR_STRIDE_LOG2(ADDR_MAP_LINEAR_STRIDE_LOG2),
    .LINEAR_TGT_BASE   (ADDR_MAP_LINEAR_TGT_BASE),
    .DEFAULT_TGT_ID (ADDR_MAP_DEFAULT_TGT_ID)
) u_aw_addr_map (
    .in_addr    (aw_hold_pld.awaddr),
    .out_tgt_id (mapped_aw_tgt_id    ),
    .out_hit    (mapped_aw_tgt_hit   )
);

assign merged_req_vld = aw_hold_vld && w_hold_vld;
assign fifo_out_aw_vld = aw_hold_vld;
assign fifo_out_aw_rdy = upstrm_aw_rdy;
assign fifo_out_aw_pld = aw_hold_pld;
assign fifo_out_w_vld  = w_hold_vld;
assign fifo_out_w_rdy  = upstrm_w_rdy;
assign fifo_out_w_pld  = w_hold_pld;
// data path pld map
always_comb begin:wr_pld_map
    merged_req_pld.cmn.src_id   = node_id;
    merged_req_pld.cmn.txn_id   = aw_hold_pld.awid;
    merged_req_pld.cmn.tgt_id   = mapped_aw_tgt_id;
    merged_req_pld.cmn.opcode   = cfgOpcode_WrReq;
    merged_req_pld.cmn.qos      = aw_hold_pld.awqos;

    merged_req_pld.req.addr     = aw_hold_pld.awaddr;
    merged_req_pld.req.burst    = aw_hold_pld.awburst;
    merged_req_pld.req.size     = aw_hold_pld.awsize;
    merged_req_pld.req.len      = aw_hold_pld.awlen;
    merged_req_pld.req.lock     = aw_hold_pld.awlock;
    merged_req_pld.req.user     = aw_hold_pld.awuser;
    merged_req_pld.req.data     = w_hold_pld.wdata;
    merged_req_pld.req.strb     = w_hold_pld.wstrb;
    merged_req_pld.req.last     = w_hold_pld.wlast;
end

assign upstrm_aw_rdy = ~aw_hold_vld && aw_stage_seen;
assign upstrm_w_rdy  = ~w_hold_vld && w_stage_seen;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        aw_hold_vld   <= 1'b0;
        aw_stage_seen <= 1'b0;
        aw_hold_pld   <= '0;
    end else begin
        if (merged_req_vld && merged_req_rdy) begin
            aw_hold_vld <= 1'b0;
        end

        if (~aw_hold_vld && upstrm_aw_vld && ~aw_stage_seen) begin
            aw_stage_seen <= 1'b1;
        end

        if (upstrm_aw_vld && upstrm_aw_rdy) begin
            aw_stage_seen <= 1'b0;
            aw_hold_vld <= 1'b1;
            aw_hold_pld <= upstrm_aw_pld;
        end else if (!upstrm_aw_vld) begin
            aw_stage_seen <= 1'b0;
        end
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        w_hold_vld   <= 1'b0;
        w_stage_seen <= 1'b0;
        w_hold_pld   <= '0;
    end else begin
        if (merged_req_vld && merged_req_rdy) begin
            w_hold_vld <= 1'b0;
        end

        if (~w_hold_vld && upstrm_w_vld && ~w_stage_seen) begin
            w_stage_seen <= 1'b1;
        end

        if (upstrm_w_vld && upstrm_w_rdy) begin
            w_stage_seen <= 1'b0;
            w_hold_vld <= 1'b1;
            w_hold_pld <= upstrm_w_pld;
        end else if (!upstrm_w_vld) begin
            w_stage_seen <= 1'b0;
        end
    end
end

fcip_reg_slice #(
    .PLD_TYPE  (sts_req_typ),
    .RS_TYPE   (0)
) u_req_rs_full (
    .clk    (clk),
    .rst_n  (rst_n),
    .s_vld  (merged_req_vld),
    .s_rdy  (merged_req_rdy),
    .s_pld  (merged_req_pld),
    .m_vld  (rs_out_vld),
    .m_rdy  (rs_out_rdy),
    .m_pld  (rs_out_pld)
);

lwring_id_remap #(
    .DEPTH    (STS_INIU_OT_TOTAL),
    .ID_WIDTH (AXI_ARID_WIDTH),
    .PLD_WIDTH(STS_RSP_WIDTH)
) u_r_id_remap (
    .clk           (clk                ),
    .rst_n         (rst_n              ),
    .alloc_vld     (alloc_vld          ),
    .alloc_rdy     (alloc_rdy          ),
    .alloc_id      (alloc_id           ),
    .alloc_remap_id(wr_id_alloc        ),
    .complete_vld  (in_rsp_vld         ),
    .complete_rdy  (complete_rdy       ),
    .complete_idx  (complete_idx       ),
    .complete_pld  (in_rsp_pld         ),
    .retire_vld    (retire_vld         ),
    .retire_rdy    (retire_rdy         ),
    .retire_id     (check_id           ),
    .retire_pld    (retire_rsp_pld_flat)
);

// Allocate a remap entry only when the request actually handshakes downstream.
assign alloc_vld = rs_out_vld && out_req_rdy && alloc_rdy;
assign alloc_id  = rs_out_pld.cmn.txn_id;

//rs rdy is assert when wr channel req is alloced then win arb with rd channel
assign rs_out_rdy = out_req_rdy && alloc_rdy;

assign complete_idx = in_rsp_pld.cmn.txn_id;

assign out_req_vld = rs_out_vld && alloc_rdy;

always_comb begin : out_req_pld_map
    out_req_pld.cmn        = rs_out_pld.cmn;
    out_req_pld.cmn.txn_id = wr_id_alloc; //remaped txn id
    out_req_pld.req        = rs_out_pld.req;
end

cmn_vrp_reg_fifo #(
    .PLD_TYPE  (sts_iniu_axi_b_chnl),
    .ADDR_WIDTH($clog2(STS_INIU_REQ_FIFO_DEPTH))
) u_b_fifo (
    .clk    (clk),
    .rst_n  (rst_n),
    .in_vld (fifo_in_rsp_vld),
    .in_rdy (fifo_in_rsp_rdy),
    .in_pld (fifo_in_rsp_pld),
    .out_vld(upstrm_b_vld),
    .out_rdy(upstrm_b_rdy),
    .out_pld(upstrm_b_pld)
);

assign retire_rsp_pld = sts_rsp_typ'(retire_rsp_pld_flat);
assign fifo_in_rsp_vld = retire_vld;
assign retire_rdy      = fifo_in_rsp_rdy;
assign in_rsp_rdy      = complete_rdy;

always_comb begin
    fifo_in_rsp_pld.bid = check_id;
    fifo_in_rsp_pld.bresp = retire_rsp_pld.rsp.resp;
end

endmodule

module display_ss_iniu_sts_iniu_rd_channel
import display_ss_iniu_lwnoc_sts_pack::*;
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
    input   logic                       clk    ,
    input   logic                       rst_n  ,
    input   logic [SRC_ID_WIDTH-1:0]    node_id,

    input   logic                       upstrm_ar_vld,
    output  logic                       upstrm_ar_rdy,
    input   sts_iniu_axi_ar_chnl        upstrm_ar_pld,

    output  logic                       upstrm_r_vld,
    input   logic                       upstrm_r_rdy,
    output  sts_iniu_axi_r_chnl         upstrm_r_pld,

    output  logic                       out_req_vld,
    input   logic                       out_req_rdy,
    output  sts_req_typ                 out_req_pld,

    input   logic                       in_rsp_vld,
    output  logic                       in_rsp_rdy,
    input   sts_rsp_typ                 in_rsp_pld
);

logic                   ar_in_hold_vld;
sts_iniu_axi_ar_chnl    ar_in_hold_pld;
sts_iniu_axi_ar_chnl    ar_in_sel_pld;

logic                   fifo_in_ar_vld;
logic                   fifo_in_ar_rdy;
sts_req_typ             fifo_in_ar_pld;

logic                   fifo_out_ar_vld;
logic                   fifo_out_ar_rdy;
sts_req_typ             fifo_out_ar_pld;
logic                   ar_stage_seen;
logic                   ar_hold_vld;
sts_req_typ             ar_hold_pld;

logic                   fifo_in_rsp_vld;
logic                   fifo_in_rsp_rdy;
sts_iniu_axi_r_chnl     fifo_in_rsp_pld;
logic [TGT_ID_WIDTH-1:0] mapped_ar_tgt_id;
logic                    mapped_ar_tgt_hit;

display_ss_iniu_sts_iniu_addr_map #(
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
) u_ar_addr_map (
    .in_addr    (ar_in_sel_pld.araddr),
    .out_tgt_id (mapped_ar_tgt_id   ),
    .out_hit    (mapped_ar_tgt_hit  )
);

logic [AXI_ARID_WIDTH-1:0]              check_id;
logic [AXI_ARID_WIDTH-1:0]              alloc_id;
logic                                    alloc_vld;
logic                                    alloc_rdy;
logic                                    check_ack;
logic [$clog2(STS_INIU_OT_TOTAL)-1:0]   rd_id_alloc;
logic [$clog2(STS_INIU_OT_TOTAL)-1:0]   check_idx;

assign ar_in_sel_pld  = ar_in_hold_vld ? ar_in_hold_pld : upstrm_ar_pld;
assign fifo_in_ar_vld = ar_in_hold_vld || upstrm_ar_vld;
assign upstrm_ar_rdy  = ~ar_in_hold_vld && fifo_in_ar_rdy;

always_comb begin
    fifo_in_ar_pld.cmn.src_id = node_id;
    fifo_in_ar_pld.cmn.txn_id = ar_in_sel_pld.arid;
    fifo_in_ar_pld.cmn.tgt_id = mapped_ar_tgt_id;
    fifo_in_ar_pld.cmn.opcode = cfgOpcode_RdReq;
    fifo_in_ar_pld.cmn.qos    = ar_in_sel_pld.arqos;

    fifo_in_ar_pld.req.addr   = ar_in_sel_pld.araddr;
    fifo_in_ar_pld.req.burst  = ar_in_sel_pld.arburst;
    fifo_in_ar_pld.req.size   = ar_in_sel_pld.arsize;
    fifo_in_ar_pld.req.len    = ar_in_sel_pld.arlen;
    fifo_in_ar_pld.req.lock   = ar_in_sel_pld.arlock;
    fifo_in_ar_pld.req.user   = ar_in_sel_pld.aruser;
    fifo_in_ar_pld.req.data   = 'b0;
    fifo_in_ar_pld.req.strb   = 'b0;
    fifo_in_ar_pld.req.last   = 1'b1;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ar_in_hold_vld   <= 1'b0;
        ar_in_hold_pld   <= '0;
    end else begin
        if (ar_in_hold_vld && fifo_in_ar_rdy) begin
            ar_in_hold_vld <= 1'b0;
        end else if (~ar_in_hold_vld && upstrm_ar_vld && ~fifo_in_ar_rdy) begin
            ar_in_hold_vld <= 1'b1;
            ar_in_hold_pld <= upstrm_ar_pld;
        end
    end
end

cmn_vrp_reg_fifo #(
    .PLD_TYPE  (sts_req_typ),
    .ADDR_WIDTH($clog2(STS_INIU_REQ_FIFO_DEPTH))
) u_ar_fifo (
    .clk    (clk),
    .rst_n  (rst_n),
    .in_vld (fifo_in_ar_vld),
    .in_rdy (fifo_in_ar_rdy),
    .in_pld (fifo_in_ar_pld),
    .out_vld(fifo_out_ar_vld),
    .out_rdy(fifo_out_ar_rdy),
    .out_pld(fifo_out_ar_pld)
);

cmn_vrp_reg_fifo #(
    .PLD_TYPE  (sts_iniu_axi_r_chnl),
    .ADDR_WIDTH($clog2(STS_INIU_REQ_FIFO_DEPTH))
) u_r_fifo (
    .clk    (clk),
    .rst_n  (rst_n),
    .in_vld (fifo_in_rsp_vld),
    .in_rdy (fifo_in_rsp_rdy),
    .in_pld (fifo_in_rsp_pld),
    .out_vld(upstrm_r_vld),
    .out_rdy(upstrm_r_rdy),
    .out_pld(upstrm_r_pld)
);

assign fifo_in_rsp_vld = in_rsp_vld;
assign in_rsp_rdy = fifo_in_rsp_rdy;

always_comb begin
    fifo_in_rsp_pld = 'b0;
    fifo_in_rsp_pld.rid    = check_id;
    fifo_in_rsp_pld.rdata  = in_rsp_pld.rsp.data;
    fifo_in_rsp_pld.rresp  = in_rsp_pld.rsp.resp;
    fifo_in_rsp_pld.rlast  = in_rsp_pld.rsp.last;
end


lwring_id_remap #(
    .DEPTH   (STS_INIU_OT_TOTAL),
    .ID_WIDTH(AXI_ARID_WIDTH)
) u_r_id_remap (
    .clk           (clk         ),
    .rst_n         (rst_n       ),
    .alloc_vld     (alloc_vld   ),
    .alloc_rdy     (alloc_rdy   ),
    .alloc_id      (alloc_id    ),//the original txn id from req pkt
    .alloc_remap_id(rd_id_alloc ),//the txn id remapped
    .check_ack     (check_ack   ),//end of rsp pkt
    .check_idx     (check_idx   ),//txn id from rsp pkt
    .check_id      (check_id    ) //the responde id concevt by check_idx
);

assign alloc_vld = ar_hold_vld && out_req_rdy && alloc_rdy;
assign alloc_id  = ar_hold_pld.cmn.txn_id;

assign fifo_out_ar_rdy = fifo_out_ar_vld && ar_stage_seen && ~ar_hold_vld;

assign check_idx = in_rsp_pld.cmn.txn_id;
assign check_ack = in_rsp_vld && in_rsp_rdy && in_rsp_pld.rsp.last;

assign out_req_vld = ar_hold_vld && alloc_rdy;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ar_stage_seen <= 1'b0;
        ar_hold_vld   <= 1'b0;
        ar_hold_pld   <= '0;
    end else begin
        if (ar_stage_seen && fifo_out_ar_rdy) begin
            ar_stage_seen <= 1'b0;
            ar_hold_vld   <= 1'b1;
        end else if (out_req_vld && out_req_rdy) begin
            ar_hold_vld <= 1'b0;
        end else if (~ar_hold_vld && ~ar_stage_seen && fifo_out_ar_vld) begin
            ar_stage_seen <= 1'b1;
            ar_hold_pld   <= fifo_out_ar_pld;
        end else if (~fifo_out_ar_vld) begin
            ar_stage_seen <= 1'b0;
        end
    end
end

always_comb begin : out_req_pld_map
    out_req_pld = 'b0;
    out_req_pld.cmn        = ar_hold_pld.cmn;
    out_req_pld.cmn.txn_id = rd_id_alloc; //remaped txn id
    out_req_pld.req        = ar_hold_pld.req;
end




endmodule

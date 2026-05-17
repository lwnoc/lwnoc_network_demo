module sts_noc_aon_ss_iniu_sts_iniu_axi_iniu
import sts_noc_aon_ss_iniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned NODE_NUM = 2,
    parameter integer unsigned ADDR_MAP_ENTRY_NUM = 1,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_START_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_END_TABLE   = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = '0,
    parameter logic [TGT_ID_WIDTH-1:0]                      ADDR_MAP_DEFAULT_TGT_ID = '0,
    parameter integer unsigned ADDR_MASK_BITS  = 0,
    parameter logic                        SAFETY_TIMEOUT_EN          = 1'b1,
    parameter integer unsigned             SAFETY_TIMEOUT_CYCLES      = 1024,
    localparam int REQ_PLD_WIDTH = STS_REQ_WIDTH,
    localparam int RSP_PLD_WIDTH = STS_RSP_WIDTH
)(
    input logic clk       ,
    input logic rst_n     ,

    input logic [SRC_ID_WIDTH-1:0]  node_id,

    input   logic                   upstrm_aw_vld   ,
    output  logic                   upstrm_aw_rdy   ,
    input   sts_iniu_axi_aw_chnl    upstrm_aw_pld   ,
    input   logic                   upstrm_w_vld    ,
    output  logic                   upstrm_w_rdy    ,
    input   sts_iniu_axi_w_chnl     upstrm_w_pld    ,
    output  logic                   upstrm_b_vld    ,
    input   logic                   upstrm_b_rdy    ,
    output  sts_iniu_axi_b_chnl     upstrm_b_pld    ,
    input   logic                   upstrm_ar_vld   ,
    output  logic                   upstrm_ar_rdy   ,
    input   sts_iniu_axi_ar_chnl    upstrm_ar_pld   ,
    output  logic                   upstrm_r_vld    ,
    input   logic                   upstrm_r_rdy    ,
    output  sts_iniu_axi_r_chnl     upstrm_r_pld    ,

    output  logic                   out_req_vld,
    input   logic                   out_req_rdy,
    output  sts_req_typ             out_req_pld,
    input   logic                   in_rsp_vld ,
    output  logic                   in_rsp_rdy ,
    input   sts_rsp_typ             in_rsp_pld ,

    output  logic                   safety_req_timeout_err,
    output  logic                   safety_rsp_timeout_err,
    output  logic                   safety_aw_timeout_err,
    output  logic                   safety_w_timeout_err,
    output  logic                   safety_ar_timeout_err,
    output  logic                   safety_arb_lockstep_err,
    output  logic                   addr_map_wr_err,
    output  logic                   addr_map_rd_err
);

    logic           wr_req_vld;
    logic           wr_req_rdy;
    sts_req_typ     wr_req_pld;

    logic           wr_rsp_vld;
    logic           wr_rsp_rdy;
    sts_rsp_typ     wr_rsp_pld;

    logic           rd_req_vld;
    logic           rd_req_rdy;
    sts_req_typ     rd_req_pld;

    logic           rd_rsp_vld;
    logic           rd_rsp_rdy;
    sts_rsp_typ     rd_rsp_pld;

    logic           alloc_en;
    logic [1:0]     v_alloc ;
    logic [1:0]     vv_age_matrix[1:0];
    logic [1:0]     v_arb_vld;

    logic [1:0]     v_req_vld;
    logic [1:0]     v_req_rdy;
    sts_req_typ     v_req_pld[1:0];

    logic           arb_vld;
    logic           arb_rdy;
    sts_req_typ     arb_pld;
    logic           arb_shd_vld;
    sts_req_typ     arb_shd_pld;

    localparam integer unsigned SAFETY_TIMEOUT_WIDTH =
        (SAFETY_TIMEOUT_CYCLES <= 1) ? 1 : $clog2(SAFETY_TIMEOUT_CYCLES + 1);

    logic [SAFETY_TIMEOUT_WIDTH-1:0]         req_timeout_cnt;
    logic [SAFETY_TIMEOUT_WIDTH-1:0]         rsp_timeout_cnt;
    logic [SAFETY_TIMEOUT_WIDTH-1:0]         aw_valid_hold_cnt;
    logic [SAFETY_TIMEOUT_WIDTH-1:0]         w_valid_hold_cnt;
    logic [SAFETY_TIMEOUT_WIDTH-1:0]         ar_valid_hold_cnt;
    logic [$clog2(STS_INIU_OT_TOTAL + 1)-1:0] pending_rsp_cnt;
    logic                                    req_issue_hsk;
    logic                                    rsp_accept_hsk;
    logic                                    req_stall_active;
    logic                                    rsp_wait_active;

//============ Request Generation ================//

    assign v_req_vld[0] = wr_req_vld;
    assign v_req_pld[0] = wr_req_pld;
    assign wr_req_rdy   = v_req_rdy[0];

    assign v_req_vld[1] = rd_req_vld;
    assign v_req_pld[1] = rd_req_pld;
    assign rd_req_rdy   = v_req_rdy[1];

    // Primary arbiter
    fcip_arb_vrp#(
        .MODE     (2), .HSK_MODE (0), .WIDTH (2), .PRIORITY (0), .PLD_WIDTH(REQ_PLD_WIDTH)
    ) u_req_arb (
        .clk(clk), .rst_n(rst_n), .v_vld_s(v_req_vld), .v_rdy_s(v_req_rdy), .v_pld_s(v_req_pld),
        .vld_m(arb_vld), .rdy_m(arb_rdy), .pld_m(arb_pld)
    );
    // Shadow arbiter for ASIL-D lock-step
    fcip_arb_vrp#(
        .MODE     (2), .HSK_MODE (0), .WIDTH (2), .PRIORITY (0), .PLD_WIDTH(REQ_PLD_WIDTH)
    ) u_req_arb_shadow (
        .clk(clk), .rst_n(rst_n), .v_vld_s(v_req_vld), .v_rdy_s(), .v_pld_s(v_req_pld),
        .vld_m(arb_shd_vld), .rdy_m(arb_rdy), .pld_m(arb_shd_pld)
    );
    // Lock-step comparator (cycle-level, flop-compare on posedge)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            safety_arb_lockstep_err <= 1'b0;
        end
        else if ({arb_vld, arb_pld} != {arb_shd_vld, arb_shd_pld}) begin
            safety_arb_lockstep_err <= 1'b1;
        end
    end

    // `_PREFIX_(lwnoc_flow_ctrl_chk) #(
    //     .NODE_NUM           (NODE_NUM       ),
    //     .PLD_TYPE           (sts_req_typ    )
    // ) u_flow_ctrl_req (
    //     .flow_ctrl_busy     (flow_ctrl_busy ),
    //     .in_vld             (arb_vld        ),
    //     .in_rdy             (arb_rdy        ),
    //     .in_pld             (arb_pld        ),
    //     .out_vld            (out_req_vld    ),
    //     .out_rdy            (out_req_rdy    ),
    //     .out_pld            (out_req_pld    )
    // );

    // Flow-control gating is disabled after removing flow_ctrl_* interface.
    assign out_req_vld = arb_vld;
    assign arb_rdy     = out_req_rdy;
    assign out_req_pld = arb_pld;

    assign req_issue_hsk  = out_req_vld && out_req_rdy;
    assign rsp_accept_hsk = in_rsp_vld && in_rsp_rdy;
    assign req_stall_active = arb_vld && ~out_req_rdy;
    assign rsp_wait_active  = (pending_rsp_cnt != '0) && ~in_rsp_vld;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pending_rsp_cnt         <= '0;
            req_timeout_cnt         <= '0;
            rsp_timeout_cnt         <= '0;
            safety_req_timeout_err  <= 1'b0;
            safety_rsp_timeout_err  <= 1'b0;
        end
        else begin
            case ({req_issue_hsk, rsp_accept_hsk})
                2'b10: begin
                    if (pending_rsp_cnt < STS_INIU_OT_TOTAL) begin
                        pending_rsp_cnt <= pending_rsp_cnt + 1'b1;
                    end
                end
                2'b01: begin
                    if (pending_rsp_cnt != '0) begin
                        pending_rsp_cnt <= pending_rsp_cnt - 1'b1;
                    end
                end
                default: begin
                    pending_rsp_cnt <= pending_rsp_cnt;
                end
            endcase

            if (!SAFETY_TIMEOUT_EN || !req_stall_active || safety_req_timeout_err) begin
                req_timeout_cnt <= '0;
            end
            else if (req_timeout_cnt == SAFETY_TIMEOUT_CYCLES - 1) begin
                req_timeout_cnt        <= req_timeout_cnt;
                safety_req_timeout_err <= 1'b1;
            end
            else begin
                req_timeout_cnt <= req_timeout_cnt + 1'b1;
            end

            if (!SAFETY_TIMEOUT_EN || !rsp_wait_active || in_rsp_vld || safety_rsp_timeout_err) begin
                rsp_timeout_cnt <= '0;
            end
            else if (rsp_timeout_cnt == SAFETY_TIMEOUT_CYCLES - 1) begin
                rsp_timeout_cnt        <= rsp_timeout_cnt;
                safety_rsp_timeout_err <= 1'b1;
            end
            else begin
                rsp_timeout_cnt <= rsp_timeout_cnt + 1'b1;
            end

            // AW valid-hold timeout
            if (!SAFETY_TIMEOUT_EN || !upstrm_aw_vld || upstrm_aw_rdy || safety_aw_timeout_err) begin
                aw_valid_hold_cnt <= '0;
            end
            else if (aw_valid_hold_cnt == SAFETY_TIMEOUT_CYCLES - 1) begin
                aw_valid_hold_cnt   <= aw_valid_hold_cnt;
                safety_aw_timeout_err <= 1'b1;
            end
            else begin
                aw_valid_hold_cnt <= aw_valid_hold_cnt + 1'b1;
            end

            // W valid-hold timeout
            if (!SAFETY_TIMEOUT_EN || !upstrm_w_vld || upstrm_w_rdy || safety_w_timeout_err) begin
                w_valid_hold_cnt <= '0;
            end
            else if (w_valid_hold_cnt == SAFETY_TIMEOUT_CYCLES - 1) begin
                w_valid_hold_cnt    <= w_valid_hold_cnt;
                safety_w_timeout_err <= 1'b1;
            end
            else begin
                w_valid_hold_cnt <= w_valid_hold_cnt + 1'b1;
            end

            // AR valid-hold timeout
            if (!SAFETY_TIMEOUT_EN || !upstrm_ar_vld || upstrm_ar_rdy || safety_ar_timeout_err) begin
                ar_valid_hold_cnt <= '0;
            end
            else if (ar_valid_hold_cnt == SAFETY_TIMEOUT_CYCLES - 1) begin
                ar_valid_hold_cnt   <= ar_valid_hold_cnt;
                safety_ar_timeout_err <= 1'b1;
            end
            else begin
                ar_valid_hold_cnt <= ar_valid_hold_cnt + 1'b1;
            end
        end
    end

//============ Response Generation ================//
assign wr_rsp_vld = in_rsp_vld && in_rsp_pld.cmn.opcode == cfgOpcode_WrRsp;
assign wr_rsp_pld = in_rsp_pld;

assign rd_rsp_vld = in_rsp_vld && in_rsp_pld.cmn.opcode == cfgOpcode_RdRsp;
assign rd_rsp_pld = in_rsp_pld;

always_comb begin : rsp_ready_logic
    in_rsp_rdy = 1'b0;
    if (in_rsp_pld.cmn.opcode == cfgOpcode_WrRsp) begin
        in_rsp_rdy = wr_rsp_rdy;
    end else if (in_rsp_pld.cmn.opcode == cfgOpcode_RdRsp) begin
        in_rsp_rdy = rd_rsp_rdy;
    end
end

//============ Write & Read Channel ================//
    sts_noc_aon_ss_iniu_sts_iniu_wr_channel #(
        .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_START_TABLE    (ADDR_MAP_START_TABLE),
        .ADDR_MAP_END_TABLE    (ADDR_MAP_END_TABLE),
        .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID),
        .ADDR_MASK_BITS       (ADDR_MASK_BITS)
    ) u_iniu_wr_chnl (
        .clk            (clk            ),
        .rst_n          (rst_n          ),
        .node_id        (node_id        ),
        .upstrm_aw_vld  (upstrm_aw_vld  ),
        .upstrm_aw_rdy  (upstrm_aw_rdy  ),
        .upstrm_aw_pld  (upstrm_aw_pld  ),
        .upstrm_w_vld   (upstrm_w_vld   ),
        .upstrm_w_rdy   (upstrm_w_rdy   ),
        .upstrm_w_pld   (upstrm_w_pld   ),
        .upstrm_b_vld   (upstrm_b_vld   ),
        .upstrm_b_rdy   (upstrm_b_rdy   ),
        .upstrm_b_pld   (upstrm_b_pld   ),
        .out_req_vld    (wr_req_vld     ),
        .out_req_rdy    (wr_req_rdy     ),
        .out_req_pld    (wr_req_pld     ),
        .in_rsp_vld     (wr_rsp_vld     ),
        .in_rsp_rdy     (wr_rsp_rdy     ),
        .in_rsp_pld     (wr_rsp_pld     ),
        .addr_map_wr_err(addr_map_wr_err)
    );

    sts_noc_aon_ss_iniu_sts_iniu_rd_channel #(
        .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_START_TABLE    (ADDR_MAP_START_TABLE),
        .ADDR_MAP_END_TABLE    (ADDR_MAP_END_TABLE),
        .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID),
        .ADDR_MASK_BITS       (ADDR_MASK_BITS)
    ) u_iniu_rd_chnl (
        .clk            (clk            ),
        .rst_n          (rst_n          ),
        .node_id        (node_id        ),
        .upstrm_ar_vld  (upstrm_ar_vld  ),
        .upstrm_ar_rdy  (upstrm_ar_rdy  ),
        .upstrm_ar_pld  (upstrm_ar_pld  ),
        .upstrm_r_vld   (upstrm_r_vld   ),
        .upstrm_r_rdy   (upstrm_r_rdy   ),
        .upstrm_r_pld   (upstrm_r_pld   ),
        .out_req_vld    (rd_req_vld     ),
        .out_req_rdy    (rd_req_rdy     ),
        .out_req_pld    (rd_req_pld     ),
        .in_rsp_vld     (rd_rsp_vld     ),
        .in_rsp_rdy     (rd_rsp_rdy     ),
        .in_rsp_pld     (rd_rsp_pld     ),
        .addr_map_rd_err(addr_map_rd_err)
    );



endmodule

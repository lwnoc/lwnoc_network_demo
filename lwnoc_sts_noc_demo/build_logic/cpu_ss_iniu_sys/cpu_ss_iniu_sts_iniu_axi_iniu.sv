module cpu_ss_iniu_sts_iniu_axi_iniu
import cpu_ss_iniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned NODE_NUM = 2,
    parameter integer unsigned ADDR_MAP_ENTRY_NUM = 1,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_BASE_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MAP_MASK_TABLE = '0,
    parameter logic [ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0]   ADDR_MAP_TGT_ID_TABLE = '0,
    parameter bit                          ADDR_MAP_LINEAR_EN         = 0,
    parameter logic [AXI_ADDR_WIDTH-1:0]   ADDR_MAP_LINEAR_BASE       = '0,
    parameter integer unsigned             ADDR_MAP_LINEAR_NUM        = 1,
    parameter integer unsigned             ADDR_MAP_LINEAR_STRIDE_LOG2 = 0,
    parameter logic [TGT_ID_WIDTH-1:0]     ADDR_MAP_LINEAR_TGT_BASE   = '0,
    parameter logic [TGT_ID_WIDTH-1:0]                      ADDR_MAP_DEFAULT_TGT_ID = '0,
    localparam int REQ_PLD_WIDTH = $bits(sts_req_typ),
    localparam int RSP_PLD_WIDTH = $bits(sts_rsp_typ)
)(
    input logic clk       ,
    input logic rst_n     ,

    input logic [SRC_ID_WIDTH-1:0]  node_id,
    input logic [NODE_NUM-1:0]      flow_ctrl_busy  ,
    input logic                     flow_ctrl_update,

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
    input   sts_rsp_typ             in_rsp_pld
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

//============ Request Generation ================//

    assign v_req_vld[0] = wr_req_vld;
    assign v_req_pld[0] = wr_req_pld;
    assign wr_req_rdy   = v_req_rdy[0];

    assign v_req_vld[1] = rd_req_vld;
    assign v_req_pld[1] = rd_req_pld;
    assign rd_req_rdy   = v_req_rdy[1];

    fcip_arb_vrp#(
        .MODE     (2),// 0: Fix_Priority 1:Round_Robin 2:Age_Matrix 3: PLRU
        .HSK_MODE (0),// 0: Pass 1: 1-Cycle
        .WIDTH    (2),
        .PRIORITY (0),
        .PLD_WIDTH(REQ_PLD_WIDTH)
    ) u_req_arb (
        .clk            (clk            ),
        .rst_n          (rst_n          ),
        .v_vld_s        (v_req_vld      ),
        .v_rdy_s        (v_req_rdy      ),
        .v_pld_s        (v_req_pld      ),
        .vld_m          (arb_vld        ),
        .rdy_m          (arb_rdy        ),
        .pld_m          (arb_pld        )
    );

    cpu_ss_iniu_lwnoc_flow_ctrl_chk #(
        .NODE_NUM           (NODE_NUM       ),
        .PLD_TYPE           (sts_req_typ    )
    ) u_flow_ctrl_req (
        .flow_ctrl_busy     (flow_ctrl_busy ),
        .in_vld             (arb_vld        ),
        .in_rdy             (arb_rdy        ),
        .in_pld             (arb_pld        ),
        .out_vld            (out_req_vld    ),
        .out_rdy            (out_req_rdy    ),
        .out_pld            (out_req_pld    )
    );

//============ Response Generation ================//
// why lwnoc_cfg use lwnoc_flow_ctrl_buf for rsp? TODO
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
    cpu_ss_iniu_sts_iniu_wr_channel #(
        .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_BASE_TABLE    (ADDR_MAP_BASE_TABLE),
        .ADDR_MAP_MASK_TABLE    (ADDR_MAP_MASK_TABLE),
        .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_LINEAR_EN         (ADDR_MAP_LINEAR_EN),
        .ADDR_MAP_LINEAR_BASE       (ADDR_MAP_LINEAR_BASE),
        .ADDR_MAP_LINEAR_NUM        (ADDR_MAP_LINEAR_NUM),
        .ADDR_MAP_LINEAR_STRIDE_LOG2(ADDR_MAP_LINEAR_STRIDE_LOG2),
        .ADDR_MAP_LINEAR_TGT_BASE   (ADDR_MAP_LINEAR_TGT_BASE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID)
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
        .in_rsp_pld     (wr_rsp_pld     )
    );

    cpu_ss_iniu_sts_iniu_rd_channel #(
        .ADDR_MAP_ENTRY_NUM     (ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_BASE_TABLE    (ADDR_MAP_BASE_TABLE),
        .ADDR_MAP_MASK_TABLE    (ADDR_MAP_MASK_TABLE),
        .ADDR_MAP_TGT_ID_TABLE  (ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_LINEAR_EN         (ADDR_MAP_LINEAR_EN),
        .ADDR_MAP_LINEAR_BASE       (ADDR_MAP_LINEAR_BASE),
        .ADDR_MAP_LINEAR_NUM        (ADDR_MAP_LINEAR_NUM),
        .ADDR_MAP_LINEAR_STRIDE_LOG2(ADDR_MAP_LINEAR_STRIDE_LOG2),
        .ADDR_MAP_LINEAR_TGT_BASE   (ADDR_MAP_LINEAR_TGT_BASE),
        .ADDR_MAP_DEFAULT_TGT_ID(ADDR_MAP_DEFAULT_TGT_ID)
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
        .in_rsp_pld     (rd_rsp_pld     )
    );



endmodule

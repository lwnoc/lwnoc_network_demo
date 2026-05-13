module sts_noc_dec_node_1to2_wrap
import lwnoc_sts_pack::*;
#(
    parameter logic [(1 << TGT_ID_WIDTH)-1:0] ROUTE_VLD_TABLE = `STS_NOC_DEC_NODE_1TO2_WRAP_ROUTE_VLD_TABLE,
    parameter logic [((1 << TGT_ID_WIDTH) * $clog2(2))-1:0] ROUTE_DST_TABLE = `STS_NOC_DEC_NODE_1TO2_WRAP_ROUTE_DST_TABLE,
    parameter logic [2*TGT_ID_WIDTH-1:0] ROUTE_BASE = `STS_NOC_DEC_NODE_1TO2_WRAP_ROUTE_BASE,
    parameter logic [2*TGT_ID_WIDTH-1:0] ROUTE_MASK = `STS_NOC_DEC_NODE_1TO2_WRAP_ROUTE_MASK,
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = `STS_NETWORK_DEC_DBG_TIMESTAMP_WIDTH,
    parameter integer unsigned DBG_DATA_WIDTH      = `STS_NETWORK_DEC_DBG_DATA_WIDTH
)(
    input   logic                               clk                 ,
    input   logic                               rst_n               ,

    // ---- MST REQ -------------------------------------------------
    input   logic                               mst_req_vld         ,
    output  logic                               mst_req_rdy         ,
    input   logic [STS_REQ_WIDTH-1:0]           mst_req_pld         ,

    // ---- MST RSP -------------------------------------------------
    output  logic                               mst_rsp_vld         ,
    input   logic                               mst_rsp_rdy         ,
    output  logic [STS_RSP_WIDTH-1:0]           mst_rsp_pld         ,

    // ---- S0 REQ --------------------------------------------------
    output  logic                               s0_req_vld          ,
    input   logic                               s0_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s0_req_pld          ,

    // ---- S0 RSP --------------------------------------------------
    input   logic                               s0_rsp_vld          ,
    output  logic                               s0_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s0_rsp_pld          ,

    // ---- S0 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s0_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s0_cti_channel_out  ,

    // ---- S0 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s0_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s0_dbg_data         ,

    // ---- S1 REQ --------------------------------------------------
    output  logic                               s1_req_vld          ,
    input   logic                               s1_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s1_req_pld          ,

    // ---- S1 RSP --------------------------------------------------
    input   logic                               s1_rsp_vld          ,
    output  logic                               s1_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s1_rsp_pld          ,

    // ---- S1 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s1_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s1_cti_channel_out  ,

    // ---- S1 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s1_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s1_dbg_data         ,

    // ---- MST CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       mst_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       mst_cti_channel_out ,

    // ---- MST DBG -------------------------------------------------
    input   logic [DBG_TIMESTAMP_WIDTH-1:0]     mst_dbg_timestamp   ,
    output  logic [DBG_DATA_WIDTH-1:0]          mst_dbg_data
);

    logic [STS_REQ_WIDTH-1:0]         s_req_pld_s;
    logic [STS_RSP_WIDTH-1:0]         s_rsp_pld_s [2-1:0];
    logic [2*CHANNEL_TOTAL_WIDTH-1:0]   s_cti_channel_out_s;
    logic [2*DBG_TIMESTAMP_WIDTH-1:0] s_dbg_timestamp_s;

    assign s_rsp_pld_s[0] = s0_rsp_pld;
    assign s_rsp_pld_s[1] = s1_rsp_pld;

    sts_noc_dec_node #(
        .SLAVE_NUM          (2                  ),
        .ROUTE_VLD_TABLE    (ROUTE_VLD_TABLE    ),
        .ROUTE_DST_TABLE    (ROUTE_DST_TABLE    ),
        .ROUTE_BASE         (ROUTE_BASE         ),
        .ROUTE_MASK         (ROUTE_MASK         ),
        .DBG_TIMESTAMP_WIDTH(DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (DBG_DATA_WIDTH     )
    ) u_dec_node (
        .clk                (clk                                   ),
        .rst_n              (rst_n                                 ),
        .mst_req_vld        (mst_req_vld                           ),
        .mst_req_rdy        (mst_req_rdy                           ),
        .mst_req_pld        (mst_req_pld                           ),
        .mst_rsp_vld        (mst_rsp_vld                           ),
        .mst_rsp_rdy        (mst_rsp_rdy                           ),
        .mst_rsp_pld        (mst_rsp_pld                           ),
        .slv_req_vld        ({s1_req_vld, s0_req_vld}              ),
        .slv_req_rdy        ({s1_req_rdy, s0_req_rdy}              ),
        .slv_req_pld        (s_req_pld_s                           ),
        .slv_rsp_vld        ({s1_rsp_vld, s0_rsp_vld}              ),
        .slv_rsp_rdy        ({s1_rsp_rdy, s0_rsp_rdy}              ),
        .slv_rsp_pld        (s_rsp_pld_s                           ),
        .mst_cti_channel_in (mst_cti_channel_in                    ),
        .mst_cti_channel_out(mst_cti_channel_out                   ),
        .slv_cti_channel_in ({s1_cti_channel_in, s0_cti_channel_in}),
        .slv_cti_channel_out(s_cti_channel_out_s                   ),
        .mst_dbg_timestamp  (mst_dbg_timestamp                     ),
        .slv_dbg_timestamp  (s_dbg_timestamp_s                     ),
        .slv_dbg_data       ({s1_dbg_data, s0_dbg_data}            ),
        .mst_dbg_data       (mst_dbg_data                          )
    );

    assign s0_req_pld         = s_req_pld_s;
    assign s1_req_pld         = s_req_pld_s;
    assign s0_cti_channel_out = s_cti_channel_out_s[0 +: CHANNEL_TOTAL_WIDTH];
    assign s1_cti_channel_out = s_cti_channel_out_s[CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s0_dbg_timestamp   = s_dbg_timestamp_s[0 +: DBG_TIMESTAMP_WIDTH];
    assign s1_dbg_timestamp   = s_dbg_timestamp_s[DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];

endmodule

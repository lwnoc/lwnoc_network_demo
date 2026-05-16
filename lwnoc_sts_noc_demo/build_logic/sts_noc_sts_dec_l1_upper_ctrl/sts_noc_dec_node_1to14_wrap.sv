module sts_noc_dec_node_1to14_wrap
import lwnoc_sts_pack::*;
#(
    parameter logic [(1 << TGT_ID_WIDTH)-1:0] ROUTE_VLD_TABLE = `STS_NOC_DEC_NODE_1TO14_WRAP_ROUTE_VLD_TABLE,
    parameter logic [((1 << TGT_ID_WIDTH) * $clog2(14))-1:0] ROUTE_DST_TABLE = `STS_NOC_DEC_NODE_1TO14_WRAP_ROUTE_DST_TABLE,
    parameter logic [14*TGT_ID_WIDTH-1:0] ROUTE_BASE = `STS_NOC_DEC_NODE_1TO14_WRAP_ROUTE_BASE,
    parameter logic [14*TGT_ID_WIDTH-1:0] ROUTE_MASK = `STS_NOC_DEC_NODE_1TO14_WRAP_ROUTE_MASK,
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

    // ---- S0 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s0_reserved_bits ,

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

    // ---- S1 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s1_reserved_bits ,

    // ---- S2 REQ --------------------------------------------------
    output  logic                               s2_req_vld          ,
    input   logic                               s2_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s2_req_pld          ,

    // ---- S2 RSP --------------------------------------------------
    input   logic                               s2_rsp_vld          ,
    output  logic                               s2_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s2_rsp_pld          ,

    // ---- S2 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s2_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s2_cti_channel_out  ,

    // ---- S2 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s2_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s2_dbg_data         ,

    // ---- S2 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s2_reserved_bits ,

    // ---- S3 REQ --------------------------------------------------
    output  logic                               s3_req_vld          ,
    input   logic                               s3_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s3_req_pld          ,

    // ---- S3 RSP --------------------------------------------------
    input   logic                               s3_rsp_vld          ,
    output  logic                               s3_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s3_rsp_pld          ,

    // ---- S3 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s3_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s3_cti_channel_out  ,

    // ---- S3 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s3_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s3_dbg_data         ,

    // ---- S3 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s3_reserved_bits ,

    // ---- S4 REQ --------------------------------------------------
    output  logic                               s4_req_vld          ,
    input   logic                               s4_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s4_req_pld          ,

    // ---- S4 RSP --------------------------------------------------
    input   logic                               s4_rsp_vld          ,
    output  logic                               s4_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s4_rsp_pld          ,

    // ---- S4 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s4_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s4_cti_channel_out  ,

    // ---- S4 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s4_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s4_dbg_data         ,

    // ---- S4 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s4_reserved_bits ,

    // ---- S5 REQ --------------------------------------------------
    output  logic                               s5_req_vld          ,
    input   logic                               s5_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s5_req_pld          ,

    // ---- S5 RSP --------------------------------------------------
    input   logic                               s5_rsp_vld          ,
    output  logic                               s5_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s5_rsp_pld          ,

    // ---- S5 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s5_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s5_cti_channel_out  ,

    // ---- S5 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s5_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s5_dbg_data         ,

    // ---- S5 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s5_reserved_bits ,

    // ---- S6 REQ --------------------------------------------------
    output  logic                               s6_req_vld          ,
    input   logic                               s6_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s6_req_pld          ,

    // ---- S6 RSP --------------------------------------------------
    input   logic                               s6_rsp_vld          ,
    output  logic                               s6_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s6_rsp_pld          ,

    // ---- S6 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s6_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s6_cti_channel_out  ,

    // ---- S6 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s6_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s6_dbg_data         ,

    // ---- S6 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s6_reserved_bits ,

    // ---- S7 REQ --------------------------------------------------
    output  logic                               s7_req_vld          ,
    input   logic                               s7_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s7_req_pld          ,

    // ---- S7 RSP --------------------------------------------------
    input   logic                               s7_rsp_vld          ,
    output  logic                               s7_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s7_rsp_pld          ,

    // ---- S7 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s7_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s7_cti_channel_out  ,

    // ---- S7 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s7_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s7_dbg_data         ,

    // ---- S7 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s7_reserved_bits ,

    // ---- S8 REQ --------------------------------------------------
    output  logic                               s8_req_vld          ,
    input   logic                               s8_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s8_req_pld          ,

    // ---- S8 RSP --------------------------------------------------
    input   logic                               s8_rsp_vld          ,
    output  logic                               s8_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s8_rsp_pld          ,

    // ---- S8 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s8_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s8_cti_channel_out  ,

    // ---- S8 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s8_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s8_dbg_data         ,

    // ---- S8 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s8_reserved_bits ,

    // ---- S9 REQ --------------------------------------------------
    output  logic                               s9_req_vld          ,
    input   logic                               s9_req_rdy          ,
    output  logic [STS_REQ_WIDTH-1:0]           s9_req_pld          ,

    // ---- S9 RSP --------------------------------------------------
    input   logic                               s9_rsp_vld          ,
    output  logic                               s9_rsp_rdy          ,
    input   logic [STS_RSP_WIDTH-1:0]           s9_rsp_pld          ,

    // ---- S9 CTI --------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s9_cti_channel_in   ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s9_cti_channel_out  ,

    // ---- S9 DBG --------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s9_dbg_timestamp    ,
    input   logic [DBG_DATA_WIDTH-1:0]          s9_dbg_data         ,

    // ---- S9 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s9_reserved_bits ,

    // ---- S10 REQ -------------------------------------------------
    output  logic                               s10_req_vld         ,
    input   logic                               s10_req_rdy         ,
    output  logic [STS_REQ_WIDTH-1:0]           s10_req_pld         ,

    // ---- S10 RSP -------------------------------------------------
    input   logic                               s10_rsp_vld         ,
    output  logic                               s10_rsp_rdy         ,
    input   logic [STS_RSP_WIDTH-1:0]           s10_rsp_pld         ,

    // ---- S10 CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s10_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s10_cti_channel_out ,

    // ---- S10 DBG -------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s10_dbg_timestamp   ,
    input   logic [DBG_DATA_WIDTH-1:0]          s10_dbg_data        ,

    // ---- S10 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s10_reserved_bits ,

    // ---- S11 REQ -------------------------------------------------
    output  logic                               s11_req_vld         ,
    input   logic                               s11_req_rdy         ,
    output  logic [STS_REQ_WIDTH-1:0]           s11_req_pld         ,

    // ---- S11 RSP -------------------------------------------------
    input   logic                               s11_rsp_vld         ,
    output  logic                               s11_rsp_rdy         ,
    input   logic [STS_RSP_WIDTH-1:0]           s11_rsp_pld         ,

    // ---- S11 CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s11_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s11_cti_channel_out ,

    // ---- S11 DBG -------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s11_dbg_timestamp   ,
    input   logic [DBG_DATA_WIDTH-1:0]          s11_dbg_data        ,

    // ---- S11 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s11_reserved_bits ,

    // ---- S12 REQ -------------------------------------------------
    output  logic                               s12_req_vld         ,
    input   logic                               s12_req_rdy         ,
    output  logic [STS_REQ_WIDTH-1:0]           s12_req_pld         ,

    // ---- S12 RSP -------------------------------------------------
    input   logic                               s12_rsp_vld         ,
    output  logic                               s12_rsp_rdy         ,
    input   logic [STS_RSP_WIDTH-1:0]           s12_rsp_pld         ,

    // ---- S12 CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s12_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s12_cti_channel_out ,

    // ---- S12 DBG -------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s12_dbg_timestamp   ,
    input   logic [DBG_DATA_WIDTH-1:0]          s12_dbg_data        ,

    // ---- S12 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s12_reserved_bits ,

    // ---- S13 REQ -------------------------------------------------
    output  logic                               s13_req_vld         ,
    input   logic                               s13_req_rdy         ,
    output  logic [STS_REQ_WIDTH-1:0]           s13_req_pld         ,

    // ---- S13 RSP -------------------------------------------------
    input   logic                               s13_rsp_vld         ,
    output  logic                               s13_rsp_rdy         ,
    input   logic [STS_RSP_WIDTH-1:0]           s13_rsp_pld         ,

    // ---- S13 CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       s13_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       s13_cti_channel_out ,

    // ---- S13 DBG -------------------------------------------------
    output  logic [DBG_TIMESTAMP_WIDTH-1:0]     s13_dbg_timestamp   ,
    input   logic [DBG_DATA_WIDTH-1:0]          s13_dbg_data        ,

    // ---- S13 Reserved Bits ---------------------------------------------
    output  logic [RESERVE_WIDTH-1:0]        s13_reserved_bits ,

    // ---- MST CTI -------------------------------------------------
    input   logic [CHANNEL_TOTAL_WIDTH-1:0]       mst_cti_channel_in  ,
    output  logic [CHANNEL_TOTAL_WIDTH-1:0]       mst_cti_channel_out ,

    // ---- MST DBG -------------------------------------------------
    input   logic [DBG_TIMESTAMP_WIDTH-1:0]     mst_dbg_timestamp   ,
    output  logic [DBG_DATA_WIDTH-1:0]          mst_dbg_data,

    // ---- MST Reserved Bits -----------------------------------------
    input   logic [RESERVE_WIDTH-1:0]        mst_reserved_bits
);

    logic [STS_REQ_WIDTH-1:0]          s_req_pld_s;
    logic [STS_RSP_WIDTH-1:0]          s_rsp_pld_s [14-1:0];
    logic [14*CHANNEL_TOTAL_WIDTH-1:0]   s_cti_channel_out_s;
    logic [14*DBG_TIMESTAMP_WIDTH-1:0] s_dbg_timestamp_s;
    logic [14*RESERVE_WIDTH-1:0]      s_reserved_bits_s;

    assign s_rsp_pld_s[0]  = s0_rsp_pld;
    assign s_rsp_pld_s[1]  = s1_rsp_pld;
    assign s_rsp_pld_s[2]  = s2_rsp_pld;
    assign s_rsp_pld_s[3]  = s3_rsp_pld;
    assign s_rsp_pld_s[4]  = s4_rsp_pld;
    assign s_rsp_pld_s[5]  = s5_rsp_pld;
    assign s_rsp_pld_s[6]  = s6_rsp_pld;
    assign s_rsp_pld_s[7]  = s7_rsp_pld;
    assign s_rsp_pld_s[8]  = s8_rsp_pld;
    assign s_rsp_pld_s[9]  = s9_rsp_pld;
    assign s_rsp_pld_s[10] = s10_rsp_pld;
    assign s_rsp_pld_s[11] = s11_rsp_pld;
    assign s_rsp_pld_s[12] = s12_rsp_pld;
    assign s_rsp_pld_s[13] = s13_rsp_pld;

    sts_noc_dec_node #(
        .SLAVE_NUM          (14                 ),
        .ROUTE_VLD_TABLE    (ROUTE_VLD_TABLE    ),
        .ROUTE_DST_TABLE    (ROUTE_DST_TABLE    ),
        .ROUTE_BASE         (ROUTE_BASE         ),
        .ROUTE_MASK         (ROUTE_MASK         ),
        .DBG_TIMESTAMP_WIDTH(DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH     (DBG_DATA_WIDTH     )
    ) u_dec_node (
        .clk                (clk                                                                                                                    ),
        .rst_n              (rst_n                                                                                                                  ),
        .mst_req_vld        (mst_req_vld                                                                                                            ),
        .mst_req_rdy        (mst_req_rdy                                                                                                            ),
        .mst_req_pld        (mst_req_pld                                                                                                            ),
        .mst_rsp_vld        (mst_rsp_vld                                                                                                            ),
        .mst_rsp_rdy        (mst_rsp_rdy                                                                                                            ),
        .mst_rsp_pld        (mst_rsp_pld                                                                                                            ),
        .slv_req_vld        ({s13_req_vld, s12_req_vld, s11_req_vld, s10_req_vld, s9_req_vld, s8_req_vld, s7_req_vld, s6_req_vld, s5_req_vld, s4_req_vld, s3_req_vld, s2_req_vld, s1_req_vld, s0_req_vld}),
        .slv_req_rdy        ({s13_req_rdy, s12_req_rdy, s11_req_rdy, s10_req_rdy, s9_req_rdy, s8_req_rdy, s7_req_rdy, s6_req_rdy, s5_req_rdy, s4_req_rdy, s3_req_rdy, s2_req_rdy, s1_req_rdy, s0_req_rdy}),
        .slv_req_pld        (s_req_pld_s                                                                                                            ),
        .slv_rsp_vld        ({s13_rsp_vld, s12_rsp_vld, s11_rsp_vld, s10_rsp_vld, s9_rsp_vld, s8_rsp_vld, s7_rsp_vld, s6_rsp_vld, s5_rsp_vld, s4_rsp_vld, s3_rsp_vld, s2_rsp_vld, s1_rsp_vld, s0_rsp_vld}),
        .slv_rsp_rdy        ({s13_rsp_rdy, s12_rsp_rdy, s11_rsp_rdy, s10_rsp_rdy, s9_rsp_rdy, s8_rsp_rdy, s7_rsp_rdy, s6_rsp_rdy, s5_rsp_rdy, s4_rsp_rdy, s3_rsp_rdy, s2_rsp_rdy, s1_rsp_rdy, s0_rsp_rdy}),
        .slv_rsp_pld        (s_rsp_pld_s                                                                                                            ),
        .mst_cti_channel_in (mst_cti_channel_in                                                                                                     ),
        .mst_cti_channel_out(mst_cti_channel_out                                                                                                    ),
        .slv_cti_channel_in ({s13_cti_channel_in, s12_cti_channel_in, s11_cti_channel_in, s10_cti_channel_in, s9_cti_channel_in, s8_cti_channel_in, s7_cti_channel_in, s6_cti_channel_in, s5_cti_channel_in, s4_cti_channel_in, s3_cti_channel_in, s2_cti_channel_in, s1_cti_channel_in, s0_cti_channel_in}),
        .slv_cti_channel_out(s_cti_channel_out_s                                                                                                    ),
        .mst_dbg_timestamp  (mst_dbg_timestamp                                                                                                      ),
        .slv_dbg_timestamp  (s_dbg_timestamp_s                                                                                                      ),
        .slv_dbg_data       ({s13_dbg_data, s12_dbg_data, s11_dbg_data, s10_dbg_data, s9_dbg_data, s8_dbg_data, s7_dbg_data, s6_dbg_data, s5_dbg_data, s4_dbg_data, s3_dbg_data, s2_dbg_data, s1_dbg_data, s0_dbg_data}),
        .mst_dbg_data       (mst_dbg_data                                                                                                           ),
        .mst_reserved_bits (mst_reserved_bits                    ),
        .slv_reserved_bits (s_reserved_bits_s                    )
    );

    assign s0_req_pld          = s_req_pld_s;
    assign s1_req_pld          = s_req_pld_s;
    assign s2_req_pld          = s_req_pld_s;
    assign s3_req_pld          = s_req_pld_s;
    assign s4_req_pld          = s_req_pld_s;
    assign s5_req_pld          = s_req_pld_s;
    assign s6_req_pld          = s_req_pld_s;
    assign s7_req_pld          = s_req_pld_s;
    assign s8_req_pld          = s_req_pld_s;
    assign s9_req_pld          = s_req_pld_s;
    assign s10_req_pld         = s_req_pld_s;
    assign s11_req_pld         = s_req_pld_s;
    assign s12_req_pld         = s_req_pld_s;
    assign s13_req_pld         = s_req_pld_s;
    assign s0_cti_channel_out  = s_cti_channel_out_s[0 +: CHANNEL_TOTAL_WIDTH];
    assign s1_cti_channel_out  = s_cti_channel_out_s[1*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s2_cti_channel_out  = s_cti_channel_out_s[2*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s3_cti_channel_out  = s_cti_channel_out_s[3*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s4_cti_channel_out  = s_cti_channel_out_s[4*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s5_cti_channel_out  = s_cti_channel_out_s[5*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s6_cti_channel_out  = s_cti_channel_out_s[6*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s7_cti_channel_out  = s_cti_channel_out_s[7*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s8_cti_channel_out  = s_cti_channel_out_s[8*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s9_cti_channel_out  = s_cti_channel_out_s[9*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s10_cti_channel_out = s_cti_channel_out_s[10*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s11_cti_channel_out = s_cti_channel_out_s[11*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s12_cti_channel_out = s_cti_channel_out_s[12*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s13_cti_channel_out = s_cti_channel_out_s[13*CHANNEL_TOTAL_WIDTH +: CHANNEL_TOTAL_WIDTH];
    assign s0_dbg_timestamp    = s_dbg_timestamp_s[0 +: DBG_TIMESTAMP_WIDTH];
    assign s0_reserved_bits = s_reserved_bits_s[0 +: RESERVE_WIDTH];
    assign s1_dbg_timestamp    = s_dbg_timestamp_s[1*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s1_reserved_bits = s_reserved_bits_s[1*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s2_dbg_timestamp    = s_dbg_timestamp_s[2*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s2_reserved_bits = s_reserved_bits_s[2*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s3_dbg_timestamp    = s_dbg_timestamp_s[3*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s3_reserved_bits = s_reserved_bits_s[3*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s4_dbg_timestamp    = s_dbg_timestamp_s[4*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s4_reserved_bits = s_reserved_bits_s[4*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s5_dbg_timestamp    = s_dbg_timestamp_s[5*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s5_reserved_bits = s_reserved_bits_s[5*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s6_dbg_timestamp    = s_dbg_timestamp_s[6*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s6_reserved_bits = s_reserved_bits_s[6*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s7_dbg_timestamp    = s_dbg_timestamp_s[7*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s7_reserved_bits = s_reserved_bits_s[7*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s8_dbg_timestamp    = s_dbg_timestamp_s[8*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s8_reserved_bits = s_reserved_bits_s[8*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s9_dbg_timestamp    = s_dbg_timestamp_s[9*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s9_reserved_bits = s_reserved_bits_s[9*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s10_dbg_timestamp   = s_dbg_timestamp_s[10*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s10_reserved_bits = s_reserved_bits_s[10*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s11_dbg_timestamp   = s_dbg_timestamp_s[11*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s11_reserved_bits = s_reserved_bits_s[11*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s12_dbg_timestamp   = s_dbg_timestamp_s[12*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s12_reserved_bits = s_reserved_bits_s[12*RESERVE_WIDTH +: RESERVE_WIDTH];
    assign s13_dbg_timestamp   = s_dbg_timestamp_s[13*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH];
    assign s13_reserved_bits = s_reserved_bits_s[13*RESERVE_WIDTH +: RESERVE_WIDTH];

endmodule

module sts_demo_dec4_sts_demo_dec4_wrap
    import sts_demo_dec4_lwnoc_sts_pack::*;
(
    input   logic       clk,
    input   logic       rst_n,

    input   logic       mst_req_vld,
    output  logic       mst_req_rdy,
    input   sts_req_typ mst_req_pld,
    output  logic       mst_rsp_vld,
    input   logic       mst_rsp_rdy,
    output  sts_rsp_typ mst_rsp_pld,

    output  logic       slv0_req_vld,
    input   logic       slv0_req_rdy,
    output  sts_req_typ slv0_req_pld,
    input   logic       slv0_rsp_vld,
    output  logic       slv0_rsp_rdy,
    input   sts_rsp_typ slv0_rsp_pld,

    output  logic       slv1_req_vld,
    input   logic       slv1_req_rdy,
    output  sts_req_typ slv1_req_pld,
    input   logic       slv1_rsp_vld,
    output  logic       slv1_rsp_rdy,
    input   sts_rsp_typ slv1_rsp_pld,

    output  logic       slv2_req_vld,
    input   logic       slv2_req_rdy,
    output  sts_req_typ slv2_req_pld,
    input   logic       slv2_rsp_vld,
    output  logic       slv2_rsp_rdy,
    input   sts_rsp_typ slv2_rsp_pld,

    output  logic       slv3_req_vld,
    input   logic       slv3_req_rdy,
    output  sts_req_typ slv3_req_pld,
    input   logic       slv3_rsp_vld,
    output  logic       slv3_rsp_rdy,
    input   sts_rsp_typ slv3_rsp_pld
);

    logic [3:0]   slv_req_vld_bus;
    logic [3:0]   slv_req_rdy_bus;
    logic [3:0]   slv_rsp_vld_bus;
    logic [3:0]   slv_rsp_rdy_bus;
    sts_req_typ   slv_req_pld_bus;
    sts_rsp_typ   slv_rsp_pld_bus [3:0];

    assign slv_req_rdy_bus = {slv3_req_rdy, slv2_req_rdy, slv1_req_rdy, slv0_req_rdy};
    assign slv_rsp_vld_bus = {slv3_rsp_vld, slv2_rsp_vld, slv1_rsp_vld, slv0_rsp_vld};
    assign slv_rsp_pld_bus[0] = slv0_rsp_pld;
    assign slv_rsp_pld_bus[1] = slv1_rsp_pld;
    assign slv_rsp_pld_bus[2] = slv2_rsp_pld;
    assign slv_rsp_pld_bus[3] = slv3_rsp_pld;

    assign slv0_req_vld = slv_req_vld_bus[0];
    assign slv1_req_vld = slv_req_vld_bus[1];
    assign slv2_req_vld = slv_req_vld_bus[2];
    assign slv3_req_vld = slv_req_vld_bus[3];
    assign slv0_req_pld = slv_req_pld_bus;
    assign slv1_req_pld = slv_req_pld_bus;
    assign slv2_req_pld = slv_req_pld_bus;
    assign slv3_req_pld = slv_req_pld_bus;

    assign slv0_rsp_rdy = slv_rsp_rdy_bus[0];
    assign slv1_rsp_rdy = slv_rsp_rdy_bus[1];
    assign slv2_rsp_rdy = slv_rsp_rdy_bus[2];
    assign slv3_rsp_rdy = slv_rsp_rdy_bus[3];

    sts_demo_dec4_sts_noc_dec_node #(
        .SLAVE_NUM            (`sts_demo_dec4_STS_DEMO_DEC_SLAVE_NUM),
        .ROUTE_BASE           (`sts_demo_dec4_STS_DEMO_ROUTE_BASE),
        .ROUTE_MASK           (`sts_demo_dec4_STS_DEMO_ROUTE_MASK),
        .DBG_TIMESTAMP_WIDTH  (`sts_demo_dec4_STS_DEMO_DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH       (`sts_demo_dec4_STS_DEMO_DBG_DATA_WIDTH)
    ) u_sts_noc_dec_node (
        .clk                 (clk),
        .rst_n               (rst_n),
        .mst_req_vld         (mst_req_vld),
        .mst_req_rdy         (mst_req_rdy),
        .mst_req_pld         (mst_req_pld),
        .mst_rsp_vld         (mst_rsp_vld),
        .mst_rsp_rdy         (mst_rsp_rdy),
        .mst_rsp_pld         (mst_rsp_pld),
        .slv_req_vld         (slv_req_vld_bus),
        .slv_req_rdy         (slv_req_rdy_bus),
        .slv_req_pld         (slv_req_pld_bus),
        .slv_rsp_vld         (slv_rsp_vld_bus),
        .slv_rsp_rdy         (slv_rsp_rdy_bus),
        .slv_rsp_pld         (slv_rsp_pld_bus),
        .mst_cti_channel_in  ('0),
        .mst_cti_channel_out (),
        .slv_cti_channel_in  ('0),
        .slv_cti_channel_out (),
        .mst_cti_event_in    ('0),
        .mst_cti_event_out   (),
        .slv_cti_event_in    ('0),
        .slv_cti_event_out   (),
        .mst_dbg_timestamp   ('0),
        .slv_dbg_timestamp   (),
        .slv_dbg_data        ('0),
        .mst_dbg_data        ()
    );

endmodule

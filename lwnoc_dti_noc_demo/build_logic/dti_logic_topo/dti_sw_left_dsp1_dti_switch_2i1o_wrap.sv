module dti_sw_left_dsp1_dti_switch_2i1o_wrap #(
    parameter int unsigned DTI_INIU0_MIN = 0,
    parameter int unsigned DTI_INIU0_MAX = 0,
    parameter int unsigned DTI_INIU1_MIN = 0,
    parameter int unsigned DTI_INIU1_MAX = 0,
    parameter int unsigned DTI_TNIU_MIN  = 0,
    parameter int unsigned DTI_TNIU_MAX  = 0
) (
    input   logic           clk,
    input   logic           rst_n,

    input   logic           iniu0_req_valid,
    output  logic           iniu0_req_ready,
    input   logic [89:0]    iniu0_req_payload,
    input   logic [5:0]     iniu0_req_srcid,
    input   logic           iniu0_req_last,
    output  logic           iniu0_rsp_valid,
    input   logic           iniu0_rsp_ready,
    output  logic [89:0]    iniu0_rsp_payload,
    output  logic [5:0]     iniu0_rsp_srcid,
    output  logic           iniu0_rsp_last,

    input   logic           iniu1_req_valid,
    output  logic           iniu1_req_ready,
    input   logic [89:0]    iniu1_req_payload,
    input   logic [5:0]     iniu1_req_srcid,
    input   logic           iniu1_req_last,
    output  logic           iniu1_rsp_valid,
    input   logic           iniu1_rsp_ready,
    output  logic [89:0]    iniu1_rsp_payload,
    output  logic [5:0]     iniu1_rsp_srcid,
    output  logic           iniu1_rsp_last,

    output  logic           tniu_req_valid,
    input   logic           tniu_req_ready,
    output  logic [89:0]    tniu_req_payload,
    output  logic [5:0]     tniu_req_srcid,
    output  logic           tniu_req_last,
    input   logic           tniu_rsp_valid,
    output  logic           tniu_rsp_ready,
    input   logic [89:0]    tniu_rsp_payload,
    input   logic [5:0]     tniu_rsp_srcid,
    input   logic           tniu_rsp_last
);

    logic [1:0]        iniu_req_valid_bus;
    logic [1:0]        iniu_req_ready_bus;
    logic [1:0][89:0]  iniu_req_payload_bus;
    logic [1:0][5:0]   iniu_req_srcid_bus;
    logic [1:0]        iniu_req_last_bus;
    logic [1:0]        iniu_rsp_valid_bus;
    logic [1:0][89:0]  iniu_rsp_payload_bus;
    logic [1:0][5:0]   iniu_rsp_srcid_bus;
    logic [1:0]        iniu_rsp_last_bus;
    logic [1:0]        iniu_rsp_threshold_unused;

    logic [0:0]        tniu_req_valid_bus;
    logic [0:0]        tniu_req_ready_bus;
    logic [0:0][89:0]  tniu_req_payload_bus;
    logic [0:0][5:0]   tniu_req_srcid_bus;
    logic [0:0]        tniu_req_last_bus;
    logic [0:0]        tniu_req_threshold_unused;
    logic [0:0]        tniu_rsp_valid_bus;
    logic [0:0]        tniu_rsp_ready_bus;
    logic [0:0][89:0]  tniu_rsp_payload_bus;
    logic [0:0][5:0]   tniu_rsp_srcid_bus;
    logic [0:0]        tniu_rsp_last_bus;

    assign iniu_req_valid_bus = {iniu1_req_valid, iniu0_req_valid};
    assign iniu_req_payload_bus[0] = iniu0_req_payload;
    assign iniu_req_payload_bus[1] = iniu1_req_payload;
    assign iniu_req_srcid_bus[0] = iniu0_req_srcid;
    assign iniu_req_srcid_bus[1] = iniu1_req_srcid;
    assign iniu_req_last_bus = {iniu1_req_last, iniu0_req_last};
    assign {iniu1_req_ready, iniu0_req_ready} = iniu_req_ready_bus;

    assign iniu0_rsp_valid = iniu_rsp_valid_bus[0];
    assign iniu1_rsp_valid = iniu_rsp_valid_bus[1];
    assign iniu0_rsp_payload = iniu_rsp_payload_bus[0];
    assign iniu1_rsp_payload = iniu_rsp_payload_bus[1];
    assign iniu0_rsp_srcid = iniu_rsp_srcid_bus[0];
    assign iniu1_rsp_srcid = iniu_rsp_srcid_bus[1];
    assign iniu0_rsp_last = iniu_rsp_last_bus[0];
    assign iniu1_rsp_last = iniu_rsp_last_bus[1];

    assign tniu_req_valid = tniu_req_valid_bus[0];
    assign tniu_req_payload = tniu_req_payload_bus[0];
    assign tniu_req_srcid = tniu_req_srcid_bus[0];
    assign tniu_req_last = tniu_req_last_bus[0];
    assign tniu_req_ready_bus[0] = tniu_req_ready;
    assign tniu_rsp_valid_bus[0] = tniu_rsp_valid;
    assign tniu_rsp_payload_bus[0] = tniu_rsp_payload;
    assign tniu_rsp_srcid_bus[0] = tniu_rsp_srcid;
    assign tniu_rsp_last_bus[0] = tniu_rsp_last;
    assign tniu_rsp_ready = tniu_rsp_ready_bus[0];

    dti_sw_left_dsp1_dti_noc_switch #(
        .NUM_INIU      (2),
        .NUM_TNIU      (1),
        .TID_WIDTH     (6),
        .PAYLOAD_WIDTH (90),
        .TNIU_DECMIN   (DTI_TNIU_MIN),
        .TNIU_DECMAX   (DTI_TNIU_MAX),
        .INIU_DECMIN   ({DTI_INIU1_MIN, DTI_INIU0_MIN}),
        .INIU_DECMAX   ({DTI_INIU1_MAX, DTI_INIU0_MAX})
    ) u_dti_noc_switch (
        .clk                (clk),
        .rst_n              (rst_n),
        .iniu_req_valid     (iniu_req_valid_bus),
        .iniu_req_ready     (iniu_req_ready_bus),
        .iniu_req_payload   (iniu_req_payload_bus),
        .iniu_req_srcid     (iniu_req_srcid_bus),
        .iniu_req_last      (iniu_req_last_bus),
        .iniu_rsp_valid     (iniu_rsp_valid_bus),
        .iniu_rsp_ready     ({iniu1_rsp_ready, iniu0_rsp_ready}),
        .iniu_rsp_payload   (iniu_rsp_payload_bus),
        .iniu_rsp_srcid     (iniu_rsp_srcid_bus),
        .iniu_rsp_last      (iniu_rsp_last_bus),
        .iniu_rsp_threshold (iniu_rsp_threshold_unused),
        .tniu_req_valid     (tniu_req_valid_bus),
        .tniu_req_ready     (tniu_req_ready_bus),
        .tniu_req_payload   (tniu_req_payload_bus),
        .tniu_req_srcid     (tniu_req_srcid_bus),
        .tniu_req_last      (tniu_req_last_bus),
        .tniu_req_threshold (tniu_req_threshold_unused),
        .tniu_rsp_valid     (tniu_rsp_valid_bus),
        .tniu_rsp_ready     (tniu_rsp_ready_bus),
        .tniu_rsp_payload   (tniu_rsp_payload_bus),
        .tniu_rsp_srcid     (tniu_rsp_srcid_bus),
        .tniu_rsp_last      (tniu_rsp_last_bus)
    );

endmodule

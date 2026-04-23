module intr_ring_buf_wrap #(
    parameter integer unsigned RING_ID          = 0,
    parameter integer unsigned NODE_NUM         = 4,
    parameter integer unsigned PLD_WIDTH        = 40,
    parameter integer unsigned ID_WIDTH         = 8,
    parameter integer unsigned QOS_WIDTH        = 4,
    parameter integer unsigned SINGLE_THR_WIDTH = 1,
    parameter logic            HAS_INIU         = 1'b0,
    parameter logic            HAS_TNIU         = 1'b0,
    localparam integer unsigned ARB_PLD_WIDTH   = PLD_WIDTH + ID_WIDTH * 2 + QOS_WIDTH + 2,
    localparam integer unsigned SRAM_ADDR_WIDTH = $clog2(32) + 2
)(
    input  logic                    clk,
    input  logic                    rst_n,

    input  logic                    pring_in_if_valid,
    output logic                    pring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]    pring_in_if_payload,
    input  logic [ID_WIDTH-1:0]     pring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]     pring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]    pring_in_if_qos,
    input  logic                    pring_in_if_last,

    output logic                    pring_out_if_valid,
    input  logic                    pring_out_if_ready,
    output logic [PLD_WIDTH-1:0]    pring_out_if_payload,
    output logic [ID_WIDTH-1:0]     pring_out_if_srcid,
    output logic [ID_WIDTH-1:0]     pring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]    pring_out_if_qos,
    output logic                    pring_out_if_last,

    input  logic                    nring_in_if_valid,
    output logic                    nring_in_if_ready,
    input  logic [PLD_WIDTH-1:0]    nring_in_if_payload,
    input  logic [ID_WIDTH-1:0]     nring_in_if_srcid,
    input  logic [ID_WIDTH-1:0]     nring_in_if_tgtid,
    input  logic [QOS_WIDTH-1:0]    nring_in_if_qos,
    input  logic                    nring_in_if_last,

    output logic                    nring_out_if_valid,
    input  logic                    nring_out_if_ready,
    output logic [PLD_WIDTH-1:0]    nring_out_if_payload,
    output logic [ID_WIDTH-1:0]     nring_out_if_srcid,
    output logic [ID_WIDTH-1:0]     nring_out_if_tgtid,
    output logic [QOS_WIDTH-1:0]    nring_out_if_qos,
    output logic                    nring_out_if_last,

    input  logic                    local_tx_valid,
    output logic                    local_tx_ready,
    input  logic [PLD_WIDTH-1:0]    local_tx_payload,
    input  logic [ID_WIDTH-1:0]     local_tx_srcid,
    input  logic [ID_WIDTH-1:0]     local_tx_tgtid,
    input  logic [QOS_WIDTH-1:0]    local_tx_qos,
    input  logic                    local_tx_last,

    output logic                    local_rx_valid,
    input  logic                    local_rx_ready,
    output logic [PLD_WIDTH-1:0]    local_rx_payload,
    output logic [ID_WIDTH-1:0]     local_rx_srcid,
    output logic [ID_WIDTH-1:0]     local_rx_tgtid,
    output logic [QOS_WIDTH-1:0]    local_rx_qos,
    output logic                    local_rx_last
);

    logic                   buf_out_vld;
    logic [PLD_WIDTH-1:0]   buf_out_payload;
    logic [ID_WIDTH-1:0]    buf_out_srcid;
    logic [ID_WIDTH-1:0]    buf_out_tgtid;
    logic [QOS_WIDTH-1:0]   buf_out_qos;
    logic                   buf_out_tail;
    logic                   buf_out_vcid;
    logic [1:0]             buf_out_vc_rdy;

    logic [1:0]             ring_in_vc_rdy;
    logic [1:0]             ring_out_vc_rdy;

    logic [SRAM_ADDR_WIDTH-1:0] sram_addr;
    logic [ARB_PLD_WIDTH-1:0]   sram_din;
    logic [ARB_PLD_WIDTH-1:0]   sram_dout;
    logic                       sram_en;
    logic                       sram_wren;
    logic [ARB_PLD_WIDTH-1:0]   sram_bit_en;

    logic                   sta_dn_valid;
    logic [PLD_WIDTH-1:0]   sta_dn_payload;
    logic [ID_WIDTH-1:0]    sta_dn_srcid;
    logic [ID_WIDTH-1:0]    sta_dn_tgtid;
    logic [QOS_WIDTH-1:0]   sta_dn_qos;
    logic                   sta_dn_tail;
    logic                   sta_up_ready;

    assign pring_in_if_ready = ring_in_vc_rdy[0];
    assign ring_out_vc_rdy   = {1'b0, pring_out_if_ready};

    lwnoc_ring_buf #(
        .PLD_WIDTH        (PLD_WIDTH),
        .ID_WIDTH         (ID_WIDTH),
        .QOS_WIDTH        (QOS_WIDTH),
        .BUF_DEP          (2),
        .THRESHOLD_EN     (1'b0),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM)
    ) u_ring_buf (
        .clk           (clk),
        .rst_n         (rst_n),
        .threshold_src ('0),
        .threshold_dst (),
        .vld_src       (pring_in_if_valid),
        .payload_src   (pring_in_if_payload),
        .srcid_src     (pring_in_if_srcid),
        .tgtid_src     (pring_in_if_tgtid),
        .qos_src       (pring_in_if_qos),
        .tail_src      (pring_in_if_last),
        .vcid_src      (1'b0),
        .vc_rdy_src    (ring_in_vc_rdy),
        .vld_dst       (buf_out_vld),
        .payload_dst   (buf_out_payload),
        .srcid_dst     (buf_out_srcid),
        .tgtid_dst     (buf_out_tgtid),
        .qos_dst       (buf_out_qos),
        .tail_dst      (buf_out_tail),
        .vcid_dst      (buf_out_vcid),
        .vc_rdy_dst    (buf_out_vc_rdy)
    );

    lwnoc_ring_station #(
        .PLD_WIDTH        (PLD_WIDTH),
        .ID_WIDTH         (ID_WIDTH),
        .QOS_WIDTH        (QOS_WIDTH),
        .THRESHOLD_EN     (1'b0),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM)
    ) u_ring_station (
        .clk                  (clk),
        .rst_n                (rst_n),
        .ring_id              (ID_WIDTH'(RING_ID)),
        .threshold_cur_station('0),
        .threshold_src        ('0),
        .threshold_dst        (),
        .vld_src              (buf_out_vld),
        .payload_src          (buf_out_payload),
        .srcid_src            (buf_out_srcid),
        .tgtid_src            (buf_out_tgtid),
        .qos_src              (buf_out_qos),
        .tail_src             (buf_out_tail),
        .vcid_src             (buf_out_vcid),
        .vc_rdy_src           (buf_out_vc_rdy),
        .vld_dst              (pring_out_if_valid),
        .payload_dst          (pring_out_if_payload),
        .srcid_dst            (pring_out_if_srcid),
        .tgtid_dst            (pring_out_if_tgtid),
        .qos_dst              (pring_out_if_qos),
        .tail_dst             (pring_out_if_last),
        .vcid_dst             (),
        .vc_rdy_dst           (ring_out_vc_rdy),
        .vld_dn               (sta_dn_valid),
        .payload_dn           (sta_dn_payload),
        .srcid_dn             (sta_dn_srcid),
        .tgtid_dn             (sta_dn_tgtid),
        .qos_dn               (sta_dn_qos),
        .tail_dn              (sta_dn_tail),
        .vcid_dn              (),
        .rdy_dn               (HAS_TNIU ? local_rx_ready : 1'b1),
        .vld_up               (HAS_INIU ? local_tx_valid : 1'b0),
        .payload_up           (HAS_INIU ? local_tx_payload : '0),
        .srcid_up             (HAS_INIU ? local_tx_srcid : '0),
        .tgtid_up             (HAS_INIU ? local_tx_tgtid : '0),
        .qos_up               (HAS_INIU ? local_tx_qos : '0),
        .tail_up              (HAS_INIU ? local_tx_last : 1'b0),
        .vcid_up              (1'b0),
        .rdy_up               (sta_up_ready),
        .sram_addr            (sram_addr),
        .sram_din             (sram_din),
        .sram_dout            (sram_dout),
        .sram_en              (sram_en),
        .sram_wren            (sram_wren),
        .sram_bit_en          (sram_bit_en)
    );

    intr_station_temp_mem_model #(
        .ADDR_WIDTH (SRAM_ADDR_WIDTH),
        .DATA_WIDTH (ARB_PLD_WIDTH)
    ) u_mem_model (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (sram_en),
        .wen   (sram_wren),
        .addr  (sram_addr),
        .wdata (sram_din),
        .rdata (sram_dout)
    );

    assign local_tx_ready   = HAS_INIU ? sta_up_ready : 1'b0;
    assign local_rx_valid   = HAS_TNIU ? sta_dn_valid : 1'b0;
    assign local_rx_payload = HAS_TNIU ? sta_dn_payload : '0;
    assign local_rx_srcid   = HAS_TNIU ? sta_dn_srcid : '0;
    assign local_rx_tgtid   = HAS_TNIU ? sta_dn_tgtid : '0;
    assign local_rx_qos     = HAS_TNIU ? sta_dn_qos : '0;
    assign local_rx_last    = HAS_TNIU ? sta_dn_tail : 1'b0;

    assign nring_out_if_valid   = nring_in_if_valid;
    assign nring_out_if_payload = nring_in_if_payload;
    assign nring_out_if_srcid   = nring_in_if_srcid;
    assign nring_out_if_tgtid   = nring_in_if_tgtid;
    assign nring_out_if_qos     = nring_in_if_qos;
    assign nring_out_if_last    = nring_in_if_last;
    assign nring_in_if_ready    = nring_out_if_ready;

endmodule

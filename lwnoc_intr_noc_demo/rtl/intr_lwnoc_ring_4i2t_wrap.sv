module `_PREFIX_(intr_lwnoc_ring_4i2t_wrap)
#(
    parameter integer unsigned INIU_NUM         = 4,
    parameter integer unsigned TNIU_NUM         = 2,
    parameter integer unsigned PAYLOAD_WIDTH    = 40,
    parameter integer unsigned SRCID_WIDTH      = 8,
    parameter integer unsigned TGTID_WIDTH      = 8,
    parameter integer unsigned QOS_WIDTH        = 4,
    parameter integer unsigned SINGLE_THR_WIDTH = 1,
    localparam integer unsigned NODE_NUM        = INIU_NUM + TNIU_NUM,
    localparam integer unsigned ARB_PLD_WIDTH   = PAYLOAD_WIDTH + SRCID_WIDTH * 2 + QOS_WIDTH + 2,
    localparam integer unsigned SRAM_ADDR_WIDTH = $clog2(32) + 2
)(
    input  logic                     clk_noc,
    input  logic                     rst_noc_n,

    input  logic                     iniu0_up_valid,
    output logic                     iniu0_up_ready,
    input  logic [PAYLOAD_WIDTH-1:0] iniu0_up_payload,
    input  logic [SRCID_WIDTH-1:0]   iniu0_up_srcid,
    input  logic [TGTID_WIDTH-1:0]   iniu0_up_tgtid,
    input  logic [QOS_WIDTH-1:0]     iniu0_up_qos,
    input  logic                     iniu0_up_last,

    input  logic                     iniu1_up_valid,
    output logic                     iniu1_up_ready,
    input  logic [PAYLOAD_WIDTH-1:0] iniu1_up_payload,
    input  logic [SRCID_WIDTH-1:0]   iniu1_up_srcid,
    input  logic [TGTID_WIDTH-1:0]   iniu1_up_tgtid,
    input  logic [QOS_WIDTH-1:0]     iniu1_up_qos,
    input  logic                     iniu1_up_last,

    input  logic                     iniu2_up_valid,
    output logic                     iniu2_up_ready,
    input  logic [PAYLOAD_WIDTH-1:0] iniu2_up_payload,
    input  logic [SRCID_WIDTH-1:0]   iniu2_up_srcid,
    input  logic [TGTID_WIDTH-1:0]   iniu2_up_tgtid,
    input  logic [QOS_WIDTH-1:0]     iniu2_up_qos,
    input  logic                     iniu2_up_last,

    input  logic                     iniu3_up_valid,
    output logic                     iniu3_up_ready,
    input  logic [PAYLOAD_WIDTH-1:0] iniu3_up_payload,
    input  logic [SRCID_WIDTH-1:0]   iniu3_up_srcid,
    input  logic [TGTID_WIDTH-1:0]   iniu3_up_tgtid,
    input  logic [QOS_WIDTH-1:0]     iniu3_up_qos,
    input  logic                     iniu3_up_last,

    output logic                     tniu0_dn_valid,
    input  logic                     tniu0_dn_ready,
    output logic [PAYLOAD_WIDTH-1:0] tniu0_dn_payload,
    output logic [SRCID_WIDTH-1:0]   tniu0_dn_srcid,
    output logic [TGTID_WIDTH-1:0]   tniu0_dn_tgtid,
    output logic [QOS_WIDTH-1:0]     tniu0_dn_qos,
    output logic                     tniu0_dn_last,

    output logic                     tniu1_dn_valid,
    input  logic                     tniu1_dn_ready,
    output logic [PAYLOAD_WIDTH-1:0] tniu1_dn_payload,
    output logic [SRCID_WIDTH-1:0]   tniu1_dn_srcid,
    output logic [TGTID_WIDTH-1:0]   tniu1_dn_tgtid,
    output logic [QOS_WIDTH-1:0]     tniu1_dn_qos,
    output logic                     tniu1_dn_last
);

    localparam integer unsigned INIU0_IDX = 0;
    localparam integer unsigned INIU1_IDX = 1;
    localparam integer unsigned INIU2_IDX = 2;
    localparam integer unsigned INIU3_IDX = 3;
    localparam integer unsigned TNIU0_IDX = 4;
    localparam integer unsigned TNIU1_IDX = 5;

    logic                     v_local_tx_valid   [NODE_NUM-1:0];
    logic                     v_local_tx_ready   [NODE_NUM-1:0];
    logic [PAYLOAD_WIDTH-1:0] v_local_tx_payload [NODE_NUM-1:0];
    logic [SRCID_WIDTH-1:0]   v_local_tx_srcid   [NODE_NUM-1:0];
    logic [TGTID_WIDTH-1:0]   v_local_tx_tgtid   [NODE_NUM-1:0];
    logic [QOS_WIDTH-1:0]     v_local_tx_qos     [NODE_NUM-1:0];
    logic                     v_local_tx_last    [NODE_NUM-1:0];

    logic                     v_local_rx_valid   [NODE_NUM-1:0];
    logic                     v_local_rx_ready   [NODE_NUM-1:0];
    logic [PAYLOAD_WIDTH-1:0] v_local_rx_payload [NODE_NUM-1:0];
    logic [SRCID_WIDTH-1:0]   v_local_rx_srcid   [NODE_NUM-1:0];
    logic [TGTID_WIDTH-1:0]   v_local_rx_tgtid   [NODE_NUM-1:0];
    logic [QOS_WIDTH-1:0]     v_local_rx_qos     [NODE_NUM-1:0];
    logic                     v_local_rx_last    [NODE_NUM-1:0];

    logic                     v_ring_valid       [NODE_NUM:0];
    logic [PAYLOAD_WIDTH-1:0] v_ring_payload     [NODE_NUM:0];
    logic [SRCID_WIDTH-1:0]   v_ring_srcid       [NODE_NUM:0];
    logic [TGTID_WIDTH-1:0]   v_ring_tgtid       [NODE_NUM:0];
    logic [QOS_WIDTH-1:0]     v_ring_qos         [NODE_NUM:0];
    logic                     v_ring_tail        [NODE_NUM:0];
    logic                     v_ring_vcid        [NODE_NUM:0];
    logic [1:0]               v_ring_vc_rdy      [NODE_NUM:0];

    logic                     v_buf_out_valid    [NODE_NUM-1:0];
    logic [PAYLOAD_WIDTH-1:0] v_buf_out_payload  [NODE_NUM-1:0];
    logic [SRCID_WIDTH-1:0]   v_buf_out_srcid    [NODE_NUM-1:0];
    logic [TGTID_WIDTH-1:0]   v_buf_out_tgtid    [NODE_NUM-1:0];
    logic [QOS_WIDTH-1:0]     v_buf_out_qos      [NODE_NUM-1:0];
    logic                     v_buf_out_tail     [NODE_NUM-1:0];
    logic                     v_buf_out_vcid     [NODE_NUM-1:0];
    logic [1:0]               v_buf_out_vc_rdy   [NODE_NUM-1:0];

    logic                     v_station_dn_valid [NODE_NUM-1:0];
    logic [PAYLOAD_WIDTH-1:0] v_station_dn_payload [NODE_NUM-1:0];
    logic [SRCID_WIDTH-1:0]   v_station_dn_srcid [NODE_NUM-1:0];
    logic [TGTID_WIDTH-1:0]   v_station_dn_tgtid [NODE_NUM-1:0];
    logic [QOS_WIDTH-1:0]     v_station_dn_qos   [NODE_NUM-1:0];
    logic                     v_station_dn_tail  [NODE_NUM-1:0];
    logic                     v_station_dn_vcid  [NODE_NUM-1:0];
    logic                     v_station_up_ready [NODE_NUM-1:0];

    logic [SRAM_ADDR_WIDTH-1:0] v_sram_addr      [NODE_NUM-1:0];
    logic [ARB_PLD_WIDTH-1:0]   v_sram_din       [NODE_NUM-1:0];
    logic [ARB_PLD_WIDTH-1:0]   v_sram_dout      [NODE_NUM-1:0];
    logic                       v_sram_en        [NODE_NUM-1:0];
    logic                       v_sram_wren      [NODE_NUM-1:0];
    logic [ARB_PLD_WIDTH-1:0]   v_sram_bit_en    [NODE_NUM-1:0];

    assign v_local_tx_valid[INIU0_IDX]   = iniu0_up_valid;
    assign v_local_tx_payload[INIU0_IDX] = iniu0_up_payload;
    assign v_local_tx_srcid[INIU0_IDX]   = iniu0_up_srcid;
    assign v_local_tx_tgtid[INIU0_IDX]   = iniu0_up_tgtid;
    assign v_local_tx_qos[INIU0_IDX]     = iniu0_up_qos;
    assign v_local_tx_last[INIU0_IDX]    = iniu0_up_last;
    assign iniu0_up_ready                = v_local_tx_ready[INIU0_IDX];

    assign v_local_tx_valid[INIU1_IDX]   = iniu1_up_valid;
    assign v_local_tx_payload[INIU1_IDX] = iniu1_up_payload;
    assign v_local_tx_srcid[INIU1_IDX]   = iniu1_up_srcid;
    assign v_local_tx_tgtid[INIU1_IDX]   = iniu1_up_tgtid;
    assign v_local_tx_qos[INIU1_IDX]     = iniu1_up_qos;
    assign v_local_tx_last[INIU1_IDX]    = iniu1_up_last;
    assign iniu1_up_ready                = v_local_tx_ready[INIU1_IDX];

    assign v_local_tx_valid[INIU2_IDX]   = iniu2_up_valid;
    assign v_local_tx_payload[INIU2_IDX] = iniu2_up_payload;
    assign v_local_tx_srcid[INIU2_IDX]   = iniu2_up_srcid;
    assign v_local_tx_tgtid[INIU2_IDX]   = iniu2_up_tgtid;
    assign v_local_tx_qos[INIU2_IDX]     = iniu2_up_qos;
    assign v_local_tx_last[INIU2_IDX]    = iniu2_up_last;
    assign iniu2_up_ready                = v_local_tx_ready[INIU2_IDX];

    assign v_local_tx_valid[INIU3_IDX]   = iniu3_up_valid;
    assign v_local_tx_payload[INIU3_IDX] = iniu3_up_payload;
    assign v_local_tx_srcid[INIU3_IDX]   = iniu3_up_srcid;
    assign v_local_tx_tgtid[INIU3_IDX]   = iniu3_up_tgtid;
    assign v_local_tx_qos[INIU3_IDX]     = iniu3_up_qos;
    assign v_local_tx_last[INIU3_IDX]    = iniu3_up_last;
    assign iniu3_up_ready                = v_local_tx_ready[INIU3_IDX];

    assign v_local_tx_valid[TNIU0_IDX]   = 1'b0;
    assign v_local_tx_payload[TNIU0_IDX] = '0;
    assign v_local_tx_srcid[TNIU0_IDX]   = '0;
    assign v_local_tx_tgtid[TNIU0_IDX]   = '0;
    assign v_local_tx_qos[TNIU0_IDX]     = '0;
    assign v_local_tx_last[TNIU0_IDX]    = 1'b0;
    assign v_local_tx_valid[TNIU1_IDX]   = 1'b0;
    assign v_local_tx_payload[TNIU1_IDX] = '0;
    assign v_local_tx_srcid[TNIU1_IDX]   = '0;
    assign v_local_tx_tgtid[TNIU1_IDX]   = '0;
    assign v_local_tx_qos[TNIU1_IDX]     = '0;
    assign v_local_tx_last[TNIU1_IDX]    = 1'b0;

    assign v_local_rx_ready[INIU0_IDX] = 1'b0;
    assign v_local_rx_ready[INIU1_IDX] = 1'b0;
    assign v_local_rx_ready[INIU2_IDX] = 1'b0;
    assign v_local_rx_ready[INIU3_IDX] = 1'b0;
    assign v_local_rx_ready[TNIU0_IDX] = tniu0_dn_ready;
    assign v_local_rx_ready[TNIU1_IDX] = tniu1_dn_ready;

    assign tniu0_dn_valid   = v_local_rx_valid[TNIU0_IDX];
    assign tniu0_dn_payload = v_local_rx_payload[TNIU0_IDX];
    assign tniu0_dn_srcid   = v_local_rx_srcid[TNIU0_IDX];
    assign tniu0_dn_tgtid   = v_local_rx_tgtid[TNIU0_IDX];
    assign tniu0_dn_qos     = v_local_rx_qos[TNIU0_IDX];
    assign tniu0_dn_last    = v_local_rx_last[TNIU0_IDX];

    assign tniu1_dn_valid   = v_local_rx_valid[TNIU1_IDX];
    assign tniu1_dn_payload = v_local_rx_payload[TNIU1_IDX];
    assign tniu1_dn_srcid   = v_local_rx_srcid[TNIU1_IDX];
    assign tniu1_dn_tgtid   = v_local_rx_tgtid[TNIU1_IDX];
    assign tniu1_dn_qos     = v_local_rx_qos[TNIU1_IDX];
    assign tniu1_dn_last    = v_local_rx_last[TNIU1_IDX];

    initial begin
        if ((INIU_NUM != 4) || (TNIU_NUM != 2) || (NODE_NUM != 6)) begin
            $error("[intr_lwnoc_ring_4i2t_wrap] fixed role map requires INIU_NUM=4, TNIU_NUM=2, NODE_NUM=6");
        end
        if (SRCID_WIDTH != TGTID_WIDTH) begin
            $error("[intr_lwnoc_ring_4i2t_wrap] lwnoc_ring_station requires SRCID_WIDTH == TGTID_WIDTH");
        end
    end

    genvar station_idx;
    generate
        for (station_idx = 0; station_idx < NODE_NUM; station_idx = station_idx + 1) begin: GEN_STATION
            localparam bit IS_INIU_NODE = (station_idx < INIU_NUM);
            localparam bit IS_TNIU_NODE = (station_idx >= INIU_NUM);

            assign v_local_tx_ready[station_idx]   = IS_INIU_NODE ? v_station_up_ready[station_idx] : 1'b0;
            assign v_local_rx_valid[station_idx]   = IS_TNIU_NODE ? v_station_dn_valid[station_idx] : 1'b0;
            assign v_local_rx_payload[station_idx] = IS_TNIU_NODE ? v_station_dn_payload[station_idx] : '0;
            assign v_local_rx_srcid[station_idx]   = IS_TNIU_NODE ? v_station_dn_srcid[station_idx] : '0;
            assign v_local_rx_tgtid[station_idx]   = IS_TNIU_NODE ? v_station_dn_tgtid[station_idx] : '0;
            assign v_local_rx_qos[station_idx]     = IS_TNIU_NODE ? v_station_dn_qos[station_idx] : '0;
            assign v_local_rx_last[station_idx]    = IS_TNIU_NODE ? v_station_dn_tail[station_idx] : 1'b0;

            lwnoc_ring_buf #(
                .PLD_WIDTH        (PAYLOAD_WIDTH),
                .ID_WIDTH         (SRCID_WIDTH),
                .QOS_WIDTH        (QOS_WIDTH),
                .BUF_DEP          (2),
                .THRESHOLD_EN     (1'b0),
                .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
                .NODE_NUM         (NODE_NUM)
            ) u_ring_buf (
                .clk           (clk_noc),
                .rst_n         (rst_noc_n),
                .threshold_src ('0),
                .threshold_dst (),
                .vld_src       (v_ring_valid[station_idx]),
                .payload_src   (v_ring_payload[station_idx]),
                .srcid_src     (v_ring_srcid[station_idx]),
                .tgtid_src     (v_ring_tgtid[station_idx]),
                .qos_src       (v_ring_qos[station_idx]),
                .tail_src      (v_ring_tail[station_idx]),
                .vcid_src      (v_ring_vcid[station_idx]),
                .vc_rdy_src    (v_ring_vc_rdy[station_idx]),
                .vld_dst       (v_buf_out_valid[station_idx]),
                .payload_dst   (v_buf_out_payload[station_idx]),
                .srcid_dst     (v_buf_out_srcid[station_idx]),
                .tgtid_dst     (v_buf_out_tgtid[station_idx]),
                .qos_dst       (v_buf_out_qos[station_idx]),
                .tail_dst      (v_buf_out_tail[station_idx]),
                .vcid_dst      (v_buf_out_vcid[station_idx]),
                .vc_rdy_dst    (v_buf_out_vc_rdy[station_idx])
            );

            lwnoc_ring_station #(
                .PLD_WIDTH        (PAYLOAD_WIDTH),
                .ID_WIDTH         (SRCID_WIDTH),
                .QOS_WIDTH        (QOS_WIDTH),
                .THRESHOLD_EN     (1'b0),
                .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
                .NODE_NUM         (NODE_NUM)
            ) u_station (
                .clk                   (clk_noc),
                .rst_n                 (rst_noc_n),
                .ring_id               (SRCID_WIDTH'(station_idx)),
                .threshold_cur_station ('0),
                .threshold_src         ('0),
                .threshold_dst         (),
                .vld_src               (v_buf_out_valid[station_idx]),
                .payload_src           (v_buf_out_payload[station_idx]),
                .srcid_src             (v_buf_out_srcid[station_idx]),
                .tgtid_src             (v_buf_out_tgtid[station_idx]),
                .qos_src               (v_buf_out_qos[station_idx]),
                .tail_src              (v_buf_out_tail[station_idx]),
                .vcid_src              (v_buf_out_vcid[station_idx]),
                .vc_rdy_src            (v_buf_out_vc_rdy[station_idx]),
                .vld_dst               (v_ring_valid[station_idx + 1]),
                .payload_dst           (v_ring_payload[station_idx + 1]),
                .srcid_dst             (v_ring_srcid[station_idx + 1]),
                .tgtid_dst             (v_ring_tgtid[station_idx + 1]),
                .qos_dst               (v_ring_qos[station_idx + 1]),
                .tail_dst              (v_ring_tail[station_idx + 1]),
                .vcid_dst              (v_ring_vcid[station_idx + 1]),
                .vc_rdy_dst            (v_ring_vc_rdy[station_idx + 1]),
                .vld_dn                (v_station_dn_valid[station_idx]),
                .payload_dn            (v_station_dn_payload[station_idx]),
                .srcid_dn              (v_station_dn_srcid[station_idx]),
                .tgtid_dn              (v_station_dn_tgtid[station_idx]),
                .qos_dn                (v_station_dn_qos[station_idx]),
                .tail_dn               (v_station_dn_tail[station_idx]),
                .vcid_dn               (v_station_dn_vcid[station_idx]),
                .rdy_dn                (IS_TNIU_NODE ? v_local_rx_ready[station_idx] : 1'b0),
                .vld_up                (IS_INIU_NODE ? v_local_tx_valid[station_idx] : 1'b0),
                .payload_up            (IS_INIU_NODE ? v_local_tx_payload[station_idx] : '0),
                .srcid_up              (IS_INIU_NODE ? v_local_tx_srcid[station_idx] : '0),
                .tgtid_up              (IS_INIU_NODE ? v_local_tx_tgtid[station_idx] : '0),
                .qos_up                (IS_INIU_NODE ? v_local_tx_qos[station_idx] : '0),
                .tail_up               (IS_INIU_NODE ? v_local_tx_last[station_idx] : 1'b0),
                .vcid_up               (1'b0),
                .rdy_up                (v_station_up_ready[station_idx]),
                .sram_addr             (v_sram_addr[station_idx]),
                .sram_din              (v_sram_din[station_idx]),
                .sram_dout             (v_sram_dout[station_idx]),
                .sram_en               (v_sram_en[station_idx]),
                .sram_wren             (v_sram_wren[station_idx]),
                .sram_bit_en           (v_sram_bit_en[station_idx])
            );

            `_PREFIX_(intr_station_temp_mem_model) #(
                .ADDR_WIDTH (SRAM_ADDR_WIDTH),
                .DATA_WIDTH (ARB_PLD_WIDTH)
            ) u_station_mem (
                .clk   (clk_noc),
                .rst_n (rst_noc_n),
                .en    (v_sram_en[station_idx]),
                .wen   (v_sram_wren[station_idx]),
                .addr  (v_sram_addr[station_idx]),
                .wdata (v_sram_din[station_idx]),
                .rdata (v_sram_dout[station_idx])
            );
        end
    endgenerate

    lwnoc_ring_sp #(
        .PLD_WIDTH        (PAYLOAD_WIDTH),
        .ID_WIDTH         (SRCID_WIDTH),
        .QOS_WIDTH        (QOS_WIDTH),
        .THRESHOLD_EN     (1'b0),
        .SINGLE_THR_WIDTH (SINGLE_THR_WIDTH),
        .NODE_NUM         (NODE_NUM)
    ) u_ring_sp (
        .clk           (clk_noc),
        .threshold_src ('0),
        .threshold_dst (),
        .vld_src       (v_ring_valid[NODE_NUM]),
        .payload_src   (v_ring_payload[NODE_NUM]),
        .srcid_src     (v_ring_srcid[NODE_NUM]),
        .tgtid_src     (v_ring_tgtid[NODE_NUM]),
        .qos_src       (v_ring_qos[NODE_NUM]),
        .tail_src      (v_ring_tail[NODE_NUM]),
        .vcid_src      (v_ring_vcid[NODE_NUM]),
        .vc_rdy_src    (v_ring_vc_rdy[NODE_NUM]),
        .vld_dst       (v_ring_valid[0]),
        .payload_dst   (v_ring_payload[0]),
        .srcid_dst     (v_ring_srcid[0]),
        .tgtid_dst     (v_ring_tgtid[0]),
        .qos_dst       (v_ring_qos[0]),
        .tail_dst      (v_ring_tail[0]),
        .vcid_dst      (v_ring_vcid[0]),
        .vc_rdy_dst    (v_ring_vc_rdy[0])
    );

endmodule
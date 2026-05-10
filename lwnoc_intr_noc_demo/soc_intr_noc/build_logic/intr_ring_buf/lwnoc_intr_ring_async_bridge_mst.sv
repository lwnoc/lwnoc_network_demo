module lwnoc_intr_ring_async_bridge_mst #(
    parameter  integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter  integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter  integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter  bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter  integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter  integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,
    parameter  integer unsigned SYNC_LEVEL       = `INTR_NETWORK_RING_SYNC_LEVEL,
    parameter  integer unsigned AFIFO_DEP        = `INTR_NETWORK_RING_AFIFO_DEP,
    parameter  integer unsigned ERR_INT_CNT_WIDTH = `INTR_NETWORK_RING_ERR_INT_CNT_WIDTH,

    localparam integer unsigned THR_WID        = SINGLE_THR_WIDTH * NODE_NUM,
    localparam integer unsigned FIFO_WID       = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 2,
    localparam integer unsigned ECC_CODE_WIDTH =
        (($clog2(FIFO_WID) + FIFO_WID + 1 <= (1 << $clog2(FIFO_WID))) ?
            $clog2(FIFO_WID) : ($clog2(FIFO_WID) + 1)),
    localparam integer unsigned ECC_OVERHEAD   = ECC_CODE_WIDTH + 1,
    localparam integer unsigned AFIFO_WID      = FIFO_WID + ECC_OVERHEAD
)(
    // threshold sync into dst domain
    input   logic [THR_WID-1:0]        threshold_src,
    output  logic [THR_WID-1:0]        threshold_dst,

    // dst clock domain
    input   logic                      clk_dst,
    input   logic                      rst_dst_n,
    output  logic                      vld_dst,
    output  logic [PLD_WIDTH-1:0]      payload_dst,
    output  logic [ID_WIDTH-1:0]       srcid_dst,
    output  logic [ID_WIDTH-1:0]       tgtid_dst,
    output  logic [QOS_WIDTH-1:0]      qos_dst,
    output  logic                      tail_dst,
    output  logic                      vcid_dst,
    input   logic [1:0]                vc_rdy_dst,

    // async FIFO cross-domain wiring
    input   logic [AFIFO_DEP-1:0]      wptr_async,
    output  logic [AFIFO_DEP-1:0]      rptr_async,
    output  logic [AFIFO_DEP-1:0]      rptr_sync,
    input   logic [AFIFO_WID:0]        pld_sync,

    // feedback towards src domain
    output  logic [1:0]                vc_buf_rdy,
    // FUSA ECC error outputs (pulse-stretched)
    output  logic                      sb_err,
    output  logic                      db_err
);

    localparam  integer unsigned BUF_DEP          = AFIFO_DEP*2;

    // Threshold sync lives in dst domain
    generate
        if(THRESHOLD_EN) begin: GEN_THR_EN_DST
            lwnoc_sync_cell #(
                .INIT_VALUE ({THR_WID{1'b1}} ),
                .WIDTH      (THR_WID         ),
                .SYNC_LEVEL (SYNC_LEVEL      )
            ) u_threshold_sync (
                .din   (threshold_src ),
                .clk   (clk_dst       ),
                .rst_n (rst_dst_n     ),
                .dout  (threshold_dst )
            );
        end else begin: GEN_THR_BYPASS
            assign threshold_dst = '0;
        end
    endgenerate

    logic                  afifo_m_vld;
    logic [AFIFO_WID-1:0]  afifo_rddata;
    logic [FIFO_WID-1:0]   afifo_rddata_dec;
    logic [PLD_WIDTH-1:0]  payload_dec;
    logic [ID_WIDTH-1:0]   srcid_dec;
    logic [ID_WIDTH-1:0]   tgtid_dec;
    logic [QOS_WIDTH-1:0]  qos_dec;
    logic                  tail_dec;
    logic                  vcid_dec;

    logic                 ecc_sb_raw, ecc_db_raw;
    fcip_ecc_dec #(.DATA_WIDTH(FIFO_WID)) u_bridge_ecc_dec (
        .encode_data(afifo_rddata    ),
        .data       (afifo_rddata_dec),
        .sb_err     (ecc_sb_raw      ),
        .db_err     (ecc_db_raw      )
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_sb (
        .clk(clk_dst), .rst_n(rst_dst_n), .err_in(ecc_sb_raw), .intr_out(sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_db (
        .clk(clk_dst), .rst_n(rst_dst_n), .err_in(ecc_db_raw), .intr_out(db_err)
    );

    fcip_afifo_mst #(
        .FIFO_DEPTH            (AFIFO_DEP            ),
        .DATA_WIDTH            (AFIFO_WID            ),
        .AUTO_CLEAR_EN         (0                    ),
        .THRESHOLD_EN          (THRESHOLD_EN         ),
        .ALMOST_EMPTY_THRESHOLD(4                    ),
        .SYNC_STAGE            (SYNC_LEVEL           ),
        .VT_TYPE               (1                    )
    ) u_afifo_mst (
        .clk          (clk_dst            ),
        .rst_n        (rst_dst_n          ),
        .stall        (1'b0               ),
        .clear        (1'b0               ),
        .full_zero    (/* unused */       ),
        .idle         (/* unused */       ),
        .m_vld        (afifo_m_vld        ),
        .m_pld        (afifo_rddata       ),
        .m_rdy        (vc_buf_rdy[vcid_dec]),  // gate on target VC capacity; m_pld is stable in reg-slice when m_vld=1
        .almost_empty (/* unused */       ),
        .wptr_async   (wptr_async         ),
        .rptr_async   (rptr_async         ),
        .rptr_sync    (rptr_sync          ),
        .pld_sync     (pld_sync           )
    );

    assign {payload_dec, srcid_dec, tgtid_dec, qos_dec, tail_dec, vcid_dec} = afifo_rddata_dec;

    lwnoc_vcbuf #(
        .PLD_WIDTH   (PLD_WIDTH      ),
        .ID_WIDTH    (ID_WIDTH       ),
        .QOS_WIDTH   (QOS_WIDTH      ),
        .BUF_DEP     (BUF_DEP        ),
        .AFULL_LEVEL (BUF_DEP - (SYNC_LEVEL*2+1) )
    ) u_vcbuf (
        .clk        (clk_dst        ),
        .rst_n      (rst_dst_n      ),

        .vld_src    (afifo_m_vld    ),
        .pld_src    (payload_dec    ),
        .srcid_src  (srcid_dec      ),
        .tgtid_src  (tgtid_dec      ),
        .qos_src    (qos_dec        ),
        .tail_src   (tail_dec       ),
        .vcid_src   (vcid_dec       ),
        .vc_rdy_src (vc_buf_rdy     ),

        .vld_dst    (vld_dst        ),
        .pld_dst    (payload_dst    ),
        .srcid_dst  (srcid_dst      ),
        .tgtid_dst  (tgtid_dst      ),
        .qos_dst    (qos_dst        ),
        .tail_dst   (tail_dst       ),
        .vcid_dst   (vcid_dst       ),
        .vc_rdy_dst (vc_rdy_dst     )
    );
endmodule

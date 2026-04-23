module lwnoc_ring_async_bridge_mst #(
    parameter  integer unsigned PLD_WIDTH        = 512,
    parameter  integer unsigned ID_WIDTH         = 4,
    parameter  integer unsigned QOS_WIDTH        = 4,
    parameter  bit              THRESHOLD_EN     = 1'b1,
    parameter  integer unsigned SINGLE_THR_WIDTH = 1,
    parameter  integer unsigned NODE_NUM         = 16,
    parameter  integer unsigned SYNC_LEVEL       = 3,
    parameter  integer unsigned AFIFO_DEP        = 8,

    localparam integer unsigned THR_WID   = SINGLE_THR_WIDTH * NODE_NUM,
    localparam integer unsigned FIFO_WID  = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 2,
    localparam integer unsigned AFIFO_WID = FIFO_WID
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
    output  logic [1:0]                vc_buf_rdy
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
    logic [PLD_WIDTH-1:0]  payload_dec;
    logic [ID_WIDTH-1:0]   srcid_dec;
    logic [ID_WIDTH-1:0]   tgtid_dec;
    logic [QOS_WIDTH-1:0]  qos_dec;
    logic                  tail_dec;
    logic                  vcid_dec;

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

    assign {payload_dec, srcid_dec, tgtid_dec, qos_dec, tail_dec, vcid_dec} = afifo_rddata;

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

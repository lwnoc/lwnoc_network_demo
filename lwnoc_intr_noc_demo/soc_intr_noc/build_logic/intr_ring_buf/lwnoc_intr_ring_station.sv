module lwnoc_intr_ring_station #(
    parameter  integer unsigned PLD_WIDTH        = `INTR_NETWORK_RING_PLD_WIDTH,
    parameter  integer unsigned ID_WIDTH         = `INTR_NETWORK_RING_ID_WIDTH,
    parameter  integer unsigned QOS_WIDTH        = `INTR_NETWORK_RING_QOS_WIDTH,
    parameter  bit              THRESHOLD_EN     = `INTR_NETWORK_RING_THRESHOLD_EN,
    parameter  integer unsigned SINGLE_THR_WIDTH = `INTR_NETWORK_RING_SINGLE_THR_WIDTH,
    parameter  integer unsigned NODE_NUM         = `INTR_NETWORK_RING_NODE_NUM,

    localparam integer unsigned THR_WID = SINGLE_THR_WIDTH * NODE_NUM,
    localparam integer unsigned ARB_PLD_WIDTH = PLD_WIDTH + ID_WIDTH*2 + QOS_WIDTH + 1 + 1,
    localparam integer unsigned SRAM_ADDR_WIDTH = $clog2(32) + 2
)(
    input   logic                               clk                  ,
    input   logic                               rst_n                ,
    input   logic [ID_WIDTH-1:0]                ring_id              ,
    // Threshold ports always present (feature gated inside)
    input   logic [SINGLE_THR_WIDTH-1:0]        threshold_cur_station,
    input   logic [THR_WID-1:0]                 threshold_src        ,
    output  logic [THR_WID-1:0]                 threshold_dst        ,

    input   logic                               vld_src     ,
    input   logic [PLD_WIDTH-1:0]               payload_src ,
    input   logic [ID_WIDTH-1:0]                srcid_src   ,
    input   logic [ID_WIDTH-1:0]                tgtid_src   ,
    input   logic [QOS_WIDTH-1:0]               qos_src     ,
    input   logic                               tail_src    ,
    input   logic                               vcid_src    ,
    output  logic [1:0]                         vc_rdy_src  ,

    output  logic                               vld_dst     ,
    output  logic [PLD_WIDTH-1:0]               payload_dst ,
    output  logic [ID_WIDTH-1:0]                srcid_dst   ,
    output  logic [ID_WIDTH-1:0]                tgtid_dst   ,
    output  logic [QOS_WIDTH-1:0]               qos_dst     ,
    output  logic                               tail_dst    ,
    output  logic                               vcid_dst    ,
    input   logic [1:0]                         vc_rdy_dst  ,

    output  logic                               vld_dn      ,
    output  logic [PLD_WIDTH-1:0]               payload_dn  ,
    output  logic [ID_WIDTH-1:0]                srcid_dn    ,
    output  logic [ID_WIDTH-1:0]                tgtid_dn    ,
    output  logic [QOS_WIDTH-1:0]               qos_dn      ,
    output  logic                               tail_dn     ,
    output  logic                               vcid_dn     ,
    input   logic                               rdy_dn      ,

    input   logic                               vld_up      ,
    input   logic [PLD_WIDTH-1:0]               payload_up  ,
    input   logic [ID_WIDTH-1:0]                srcid_up    ,
    input   logic [ID_WIDTH-1:0]                tgtid_up    ,
    input   logic [QOS_WIDTH-1:0]               qos_up      ,
    input   logic                               tail_up     ,
    input   logic                               vcid_up     ,
    output  logic                               rdy_up      ,

    // Station buffer SRAM interface (external)
    output  logic [SRAM_ADDR_WIDTH-1:0]         sram_addr   ,
    output  logic [ARB_PLD_WIDTH-1:0]           sram_din    ,
    input   logic [ARB_PLD_WIDTH-1:0]           sram_dout   ,
    output  logic                               sram_en     ,
    output  logic                               sram_wren   ,
    output  logic [ARB_PLD_WIDTH-1:0]           sram_bit_en
);

typedef struct packed {
    logic [PLD_WIDTH-1:0] payload;
    logic [ID_WIDTH-1:0]  srcid  ;
    logic [ID_WIDTH-1:0]  tgtid  ;
    logic [QOS_WIDTH-1:0] qos    ;
    logic                 tail   ;
    logic                 vcid   ;
} ring_pkt_t;

logic                     vld_up_arb;
logic                     rdy_up_arb;

ring_pkt_t                rb_in_pld             ;
logic                     rb_in_vld             ;
logic [1:0]               rb_in_vcid            ;

logic [1:0]               vc_rdy_dst_dff1       ;

logic                     id_match              ;
logic                     rb_in_en_id_match     ;
logic                     rb_in_en_id_not_match ;
logic [2:0]               rb_in_rdy             ;
logic                     rb_out_vld            ;
ring_pkt_t                rb_out_pld            ;
logic                     rb_out_is_dn          ;
logic                     rb_out_rdy            ;

logic                     dnstream_from_ring_vld;
ring_pkt_t                dnstream_from_ring_pld;
logic                     unused_dnstream_from_ring_rdy;

logic                     dnstream_from_rb_vld;
ring_pkt_t                dnstream_from_rb_pld;
logic                     dnstream_from_rb_rdy;

logic                     ring_from_src_vld;
ring_pkt_t                ring_from_src_pld;
logic                     unused_ring_from_src_rdy;

logic                     ring_from_rb_vld;
ring_pkt_t                ring_from_rb_pld;
logic                     ring_from_rb_rdy;

ring_pkt_t                packed_pld_up;

logic                     rs_dn_vld   ;
logic                     rs_dn_rdy   ;
ring_pkt_t                rs_dn_pld   ;
logic                     rs_dn_m_vld ;
ring_pkt_t                rs_dn_m_pld ;

logic                     ring_out_vld;
ring_pkt_t                ring_out_pld;
logic                     ring_out_rdy;

logic                     up_m_vld    ;
ring_pkt_t                up_m_pld    ;

assign id_match = (tgtid_src == ring_id);

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        vc_rdy_dst_dff1 <= 2'b00;
    end else begin
        vc_rdy_dst_dff1 <= vc_rdy_dst;
    end
end


always @(*) begin
    if(rs_dn_rdy) begin // downstream is ready, no need to write into RB
        rb_in_en_id_match = 1'b0;
    end else if(vcid_src) begin // VC1: must write into RB chan 2
        rb_in_en_id_match = 1'b1;
    end else if(rb_in_rdy[2]) begin // VC0: have space in RB chan 2, so write into RB chan 2, goto downstream after dn_rdy is ready.
        rb_in_en_id_match = 1'b1;
    end else if(~vc_rdy_dst[0]) begin // VC0: no space in RB chan 2, and VC0 of ring is not ready, must write into RB chan 0
        rb_in_en_id_match = 1'b1;
    end else begin // VC0: no space in RB chan 2, but VC0 of ring is ready, do not write into RB
        rb_in_en_id_match = 1'b0;
    end
end

always @(*) begin
    if(vc_rdy_dst[vcid_src]) begin // target VC is ready, do not write into RB
        rb_in_en_id_not_match = 1'b0;
    end else begin // target VC is not ready, write into RB
        rb_in_en_id_not_match = 1'b1;
    end
end

always @(*) begin
    if(id_match) begin
        if(vcid_src) begin // VC1: must write into RB chan 2
            rb_in_vcid = 2'b10;
        end else if(rb_in_rdy[2]) begin // VC0: have space in RB chan 2, so write into RB chan 2, goto downstream after dn_rdy is ready.
            rb_in_vcid = 2'b10;
        end else begin // VC0: no space in RB chan 2, write into RB chan 0, goto downstream in vc1 later.
            rb_in_vcid = 2'b00;
        end
    end else begin // not current station, write into RB chan according to vcid_src
        rb_in_vcid = {1'b0, vcid_src};
    end
end

assign rb_in_vld  = vld_src && (id_match ? rb_in_en_id_match : rb_in_en_id_not_match);
assign rb_in_pld.payload = payload_src;
assign rb_in_pld.srcid   = srcid_src  ;
assign rb_in_pld.tgtid   = tgtid_src  ;
assign rb_in_pld.qos     = qos_src    ;
assign rb_in_pld.tail    = tail_src   ;
assign rb_in_pld.vcid    = vcid_src   ;

assign dnstream_from_ring_vld = vld_src && (tgtid_src == ring_id) && rs_dn_rdy;
assign dnstream_from_ring_pld = rb_in_pld;

assign dnstream_from_rb_vld = rb_out_vld && rb_out_is_dn;
assign dnstream_from_rb_pld = rb_out_pld;

assign ring_from_rb_vld     = rb_out_vld && ~rb_out_is_dn && vc_rdy_dst_dff1[rb_out_pld.vcid];
assign ring_from_rb_pld     = rb_out_pld;

assign rb_out_rdy           = rb_out_is_dn ? dnstream_from_rb_rdy : ring_from_rb_rdy && vc_rdy_dst_dff1[rb_out_pld.vcid];

assign ring_from_src_vld = vld_src && ((tgtid_src != ring_id) ? vc_rdy_dst[vcid_src] : (~rs_dn_rdy && ~rb_in_rdy[2] && ~vcid_src && vc_rdy_dst[0]));
assign ring_from_src_pld = rb_in_pld;

// src rdy geneartion: for vc0, just need to check dst rdy and rb chan0 rdy;
// for vc1, need to check dnstream and dst direction must both have space
assign vc_rdy_src = {rs_dn_rdy | rb_in_rdy[2], 1'b1} & {vc_rdy_dst | rb_in_rdy[1:0]};

lwnoc_station_buffer #(
    .VC_BUF_DEPTH     (32),
    .VC_AFULL_LEVEL   (4),
    .PLD_WIDTH        (ARB_PLD_WIDTH)
) u_station_rb (
    .clk      (clk         ),
    .rst_n    (rst_n       ),
    .wr_en    (rb_in_vld   ),
    .wr_data  (rb_in_pld   ),
    .wr_vcid  (rb_in_vcid  ),
    .wr_rdy   (rb_in_rdy   ),
    .rd_vld   (rb_out_vld  ),
    .rd_data  (rb_out_pld  ),
    .rd_is_dn (rb_out_is_dn),
    .rd_rdy   (rb_out_rdy  ),
    .sram_addr   (sram_addr   ),
    .sram_din    (sram_din    ),
    .sram_dout   (sram_dout   ),
    .sram_en     (sram_en     ),
    .sram_wren   (sram_wren   ),
    .sram_bit_en (sram_bit_en )
);

// downstream fixed priority arbiter, downstream from ring is high priority, downstream from rb is low priority
fcip_fix_arb #(
    .PLD_TYPE ( ring_pkt_t )
) u_dn_fix_arb (
    .clk                (clk                            ),
    .rst_n              (rst_n                          ),
    .s_vld_priority     (dnstream_from_ring_vld         ),
    .s_rdy_priority     (unused_dnstream_from_ring_rdy  ),
    .s_pld_priority     (dnstream_from_ring_pld         ),
    .s_vld              (dnstream_from_rb_vld           ),
    .s_rdy              (dnstream_from_rb_rdy           ),
    .s_pld              (dnstream_from_rb_pld           ),
    .m_vld              (rs_dn_vld                      ),
    .m_rdy              (rs_dn_rdy                      ),
    .m_pld              (rs_dn_pld                      )
);

fcip_reg_slice #(
        .RS_TYPE(0),
        .PLD_TYPE   ( ring_pkt_t )
) u_dn_regslice (
    .clk    (clk            ),
    .rst_n  (rst_n          ),
    .s_vld  (rs_dn_vld      ),
    .s_rdy  (rs_dn_rdy      ),
    .s_pld  (rs_dn_pld      ),
    .m_vld  (rs_dn_m_vld    ),
    .m_rdy  (rdy_dn         ),
    .m_pld  (rs_dn_m_pld    )
);

// ring fixed priority arbiter, ring from src is high priority, ring from rb is low priority
fcip_fix_arb #(
    .PLD_TYPE (ring_pkt_t)
) u_ring_fix_arb (
    .clk                (clk                     ),
    .rst_n              (rst_n                   ),
    .s_vld_priority     (ring_from_src_vld       ),
    .s_rdy_priority     (unused_ring_from_src_rdy),
    .s_pld_priority     (ring_from_src_pld       ),
    .s_vld              (ring_from_rb_vld        ),
    .s_rdy              (ring_from_rb_rdy        ),
    .s_pld              (ring_from_rb_pld        ),
    .m_vld              (ring_out_vld            ),
    .m_rdy              (ring_out_rdy            ),
    .m_pld              (ring_out_pld            )
);

assign packed_pld_up.payload = payload_up;
assign packed_pld_up.srcid   = srcid_up  ;
assign packed_pld_up.tgtid   = tgtid_up  ;
assign packed_pld_up.qos     = qos_up    ;
assign packed_pld_up.tail    = tail_up   ;
assign packed_pld_up.vcid    = vcid_up   ;

// upstream fixed priority arbiter, upstream from ring is high priority, upstream from port is low priority
fcip_fix_arb #(
    .PLD_TYPE (ring_pkt_t)
) u_up_fix_arb (
    .clk                (clk                                 ),
    .rst_n              (rst_n                               ),
    .s_vld_priority     (ring_out_vld                        ),
    .s_rdy_priority     (ring_out_rdy                        ),
    .s_pld_priority     (ring_out_pld                        ),
    .s_vld              (vld_up_arb                          ),
    .s_rdy              (rdy_up_arb                          ),
    .s_pld              (packed_pld_up                       ),
    .m_vld              (up_m_vld                            ),
    .m_rdy              (1'b1                                ),
    .m_pld              (up_m_pld                            )
);

assign vld_up_arb             = vld_up     && vc_rdy_dst_dff1[vcid_up];
assign rdy_up                 = rdy_up_arb && vc_rdy_dst_dff1[vcid_up];

assign vld_dn                 = rs_dn_m_vld;
assign payload_dn             = rs_dn_m_pld.payload;
assign srcid_dn               = rs_dn_m_pld.srcid;
assign tgtid_dn               = rs_dn_m_pld.tgtid;
assign qos_dn                 = rs_dn_m_pld.qos;
assign tail_dn                = rs_dn_m_pld.tail;
assign vcid_dn                = rs_dn_m_pld.vcid;

assign vld_dst                = up_m_vld;
assign payload_dst            = up_m_pld.payload;
assign srcid_dst              = up_m_pld.srcid;
assign tgtid_dst              = up_m_pld.tgtid;
assign qos_dst                = up_m_pld.qos;
assign tail_dst               = up_m_pld.tail;
assign vcid_dst               = up_m_pld.vcid;

// threshold generation
genvar i;
generate
    if(THRESHOLD_EN) begin: GEN_THRE_LOGIC
        for (i=0; i<NODE_NUM; i=i+1) begin: GEN_THR_UPDATE
            assign threshold_dst[i*SINGLE_THR_WIDTH +: SINGLE_THR_WIDTH] =
                (ring_id == i[ID_WIDTH-1:0]) ? threshold_cur_station : threshold_src[i*SINGLE_THR_WIDTH +: SINGLE_THR_WIDTH];
        end
    end else begin: GEN_THR_BYPASS
        // Disabled: drive outputs to all-zero, avoid floating
        assign threshold_dst = '0;
    end
endgenerate
endmodule

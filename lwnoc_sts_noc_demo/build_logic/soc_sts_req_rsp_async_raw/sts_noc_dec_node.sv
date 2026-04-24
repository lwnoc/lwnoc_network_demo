module sts_noc_dec_node
import lwnoc_sts_pack::*;
#(
    parameter integer unsigned SLAVE_NUM  = 2,
    parameter logic [SLAVE_NUM*TGT_ID_WIDTH-1:0] ROUTE_BASE = '0,
    parameter logic [SLAVE_NUM*TGT_ID_WIDTH-1:0] ROUTE_MASK = '0,
    parameter integer unsigned DBG_TIMESTAMP_WIDTH = 64,
    parameter integer unsigned DBG_DATA_WIDTH      = 32
)(
    input   logic               clk         ,
    input   logic               rst_n       ,

    // ---- Master port (upstream: INIU or parent dec_node) ----
    input   logic               mst_req_vld ,
    output  logic               mst_req_rdy ,
    input   sts_req_typ         mst_req_pld ,

    output  logic               mst_rsp_vld ,
    input   logic               mst_rsp_rdy ,
    output  sts_rsp_typ         mst_rsp_pld ,

    // ---- Slave ports (downstream: TNIU or child dec_node) ----
    output  logic [SLAVE_NUM-1:0]   slv_req_vld ,
    input   logic [SLAVE_NUM-1:0]   slv_req_rdy ,
    output  sts_req_typ             slv_req_pld ,

    input   logic [SLAVE_NUM-1:0]   slv_rsp_vld ,
    output  logic [SLAVE_NUM-1:0]   slv_rsp_rdy ,
    input   sts_rsp_typ             slv_rsp_pld [SLAVE_NUM-1:0],

    // ---- CTI Channel — CTM crossbar (master + slaves) ----
    input   logic [CTI_CHANNEL_WIDTH-1:0]              mst_cti_channel_in  ,
    output  logic [CTI_CHANNEL_WIDTH-1:0]              mst_cti_channel_out ,
    input   logic [SLAVE_NUM*CTI_CHANNEL_WIDTH-1:0]    slv_cti_channel_in  ,
    output  logic [SLAVE_NUM*CTI_CHANNEL_WIDTH-1:0]    slv_cti_channel_out ,

    // ---- CTI Event — CTM crossbar (master + slaves) ----
    input   logic [CTI_EVENT_WIDTH-1:0]                mst_cti_event_in    ,
    output  logic [CTI_EVENT_WIDTH-1:0]                mst_cti_event_out   ,
    input   logic [SLAVE_NUM*CTI_EVENT_WIDTH-1:0]      slv_cti_event_in    ,
    output  logic [SLAVE_NUM*CTI_EVENT_WIDTH-1:0]      slv_cti_event_out   ,

    // ---- Debug Timestamp — Fanout (master → all slaves) ----
    input   logic [DBG_TIMESTAMP_WIDTH-1:0]            mst_dbg_timestamp   ,
    output  logic [SLAVE_NUM*DBG_TIMESTAMP_WIDTH-1:0]  slv_dbg_timestamp   ,

    // ---- Debug Data — OR (all slaves → master) ----
    input   logic [SLAVE_NUM*DBG_DATA_WIDTH-1:0]       slv_dbg_data        ,
    output  logic [DBG_DATA_WIDTH-1:0]                 mst_dbg_data
);

    // ================================================================
    // Req Decoder: base/mask match on tgt_id
    // ================================================================

    logic [SLAVE_NUM-1:0] hit;
    logic                 hit_any;

    genvar gi;
    generate
        for (gi = 0; gi < SLAVE_NUM; gi = gi + 1) begin : g_route_match
            logic [TGT_ID_WIDTH-1:0] base_i;
            logic [TGT_ID_WIDTH-1:0] mask_i;

            assign base_i = ROUTE_BASE[gi*TGT_ID_WIDTH +: TGT_ID_WIDTH];
            assign mask_i = ROUTE_MASK[gi*TGT_ID_WIDTH +: TGT_ID_WIDTH];

            assign hit[gi] = (mst_req_pld.cmn.tgt_id & mask_i)
                          == (base_i                  & mask_i);
        end
    endgenerate

    assign hit_any = |hit;

    // Slave req: gated valid, broadcast payload
    assign slv_req_vld = hit & {SLAVE_NUM{mst_req_vld}};
    assign slv_req_pld = mst_req_pld;

    // Master req rdy: from the hit slave, or from decerr path
    logic hit_slave_rdy;

    always_comb begin
        hit_slave_rdy = 1'b0;
        for (int i = 0; i < SLAVE_NUM; i = i + 1) begin
            if (hit[i]) begin
                hit_slave_rdy = slv_req_rdy[i];
            end
        end
    end

    // ================================================================
    // DECERR response generator
    // ================================================================

    logic       decerr_rsp_vld;
    logic       decerr_rsp_rdy;
    sts_rsp_typ decerr_rsp_pld;

    assign decerr_rsp_vld             = mst_req_vld && !hit_any;

    assign decerr_rsp_pld.cmn.src_id  = mst_req_pld.cmn.src_id;
    assign decerr_rsp_pld.cmn.txn_id  = mst_req_pld.cmn.txn_id;
    assign decerr_rsp_pld.cmn.tgt_id  = mst_req_pld.cmn.tgt_id;
    assign decerr_rsp_pld.cmn.opcode  = (mst_req_pld.cmn.opcode == cfgOpcode_RdReq)
                                       ? cfgOpcode_RdRsp : cfgOpcode_WrRsp;
    assign decerr_rsp_pld.cmn.qos     = mst_req_pld.cmn.qos;
    assign decerr_rsp_pld.rsp.resp    = 2'b11;
    assign decerr_rsp_pld.rsp.data    = {AXI_DATA_WIDTH{1'b0}};
    assign decerr_rsp_pld.rsp.last    = 1'b1;

    // Master req rdy mux
    assign mst_req_rdy = hit_any ? hit_slave_rdy : decerr_rsp_rdy;

    // ================================================================
    // Rsp Arbiter: round-robin for slaves + DECERR (as equal participant)
    // DECERR is input [SLAVE_NUM] — participates in round-robin instead
    // of bypassing and blocking the arbiter.
    // ================================================================

    localparam integer unsigned RSP_PLD_WIDTH = $bits(sts_rsp_typ);
    localparam integer unsigned ARB_WIDTH     = SLAVE_NUM + 1;  // +1 for DECERR

    logic                       arb_rsp_vld;
    logic [RSP_PLD_WIDTH-1:0]   arb_rsp_pld_flat;

    // Pack slave rsp structs + DECERR into flat bit-vectors for arb_vrp
    // NOTE: arb_vrp declares v_pld_s [WIDTH-1:0] (descending), so we must
    // match that range; [N] (ascending) would reverse the mapping.
    logic [RSP_PLD_WIDTH-1:0]   arb_pld_in  [ARB_WIDTH-1:0];
    logic [ARB_WIDTH-1:0]       arb_vld_in;
    logic [ARB_WIDTH-1:0]       arb_rdy_out;

    generate
        for (gi = 0; gi < SLAVE_NUM; gi = gi + 1) begin : g_rsp_pack
            assign arb_pld_in[gi] = slv_rsp_pld[gi];
        end
    endgenerate

    // DECERR as the last arbiter input
    assign arb_pld_in[SLAVE_NUM] = decerr_rsp_pld;
    assign arb_vld_in            = {decerr_rsp_vld, slv_rsp_vld};

    fcip_arb_vrp #(
        .MODE       (1),               // Round-Robin
        .HSK_MODE   (0),               // Pass-through (combinational)
        .WIDTH      (ARB_WIDTH),
        .PLD_WIDTH  (RSP_PLD_WIDTH)
    ) u_rsp_arb (
        .clk        (clk),
        .rst_n      (rst_n),
        .v_vld_s    (arb_vld_in),
        .v_rdy_s    (arb_rdy_out),
        .v_pld_s    (arb_pld_in),
        .vld_m      (arb_rsp_vld),
        .rdy_m      (mst_rsp_rdy),
        .pld_m      (arb_rsp_pld_flat)
    );

    // Arbiter outputs directly to master rsp port
    assign mst_rsp_vld = arb_rsp_vld;
    assign mst_rsp_pld = sts_rsp_typ'(arb_rsp_pld_flat);

    // Route arbiter ready outputs back to slaves and DECERR
    assign slv_rsp_rdy    = arb_rdy_out[SLAVE_NUM-1:0];
    assign decerr_rsp_rdy = arb_rdy_out[SLAVE_NUM];

    // ================================================================
    // CTI Channel — CTM (Cross Trigger Matrix)
    // intf[0] = master, intf[1..SLAVE_NUM] = slaves
    // ================================================================

    localparam integer unsigned CTM_NUM_INTF = SLAVE_NUM + 1;

    logic [CTM_NUM_INTF*CTI_CHANNEL_WIDTH-1:0] ctm_ch_in_flat;
    logic [CTM_NUM_INTF*CTI_CHANNEL_WIDTH-1:0] ctm_ch_out_flat;

    assign ctm_ch_in_flat = {slv_cti_channel_in, mst_cti_channel_in};

    sts_ctm #(
        .NUM_INTF       (CTM_NUM_INTF       ),
        .CHANNEL_WIDTH  (CTI_CHANNEL_WIDTH  )
    ) u_ctm_channel (
        .clk            (clk                ),
        .rst_n          (rst_n              ),
        .ch_in          (ctm_ch_in_flat     ),
        .ch_out         (ctm_ch_out_flat    )
    );

    assign mst_cti_channel_out = ctm_ch_out_flat[0 +: CTI_CHANNEL_WIDTH];
    assign slv_cti_channel_out = ctm_ch_out_flat[CTI_CHANNEL_WIDTH +: SLAVE_NUM*CTI_CHANNEL_WIDTH];

    // ================================================================
    // CTI Event — CTM (same structure as channel CTM)
    // ================================================================

    logic [CTM_NUM_INTF*CTI_EVENT_WIDTH-1:0] ctm_ev_in_flat;
    logic [CTM_NUM_INTF*CTI_EVENT_WIDTH-1:0] ctm_ev_out_flat;

    assign ctm_ev_in_flat = {slv_cti_event_in, mst_cti_event_in};

    sts_ctm #(
        .NUM_INTF       (CTM_NUM_INTF       ),
        .CHANNEL_WIDTH  (CTI_EVENT_WIDTH    )
    ) u_ctm_event (
        .clk            (clk                ),
        .rst_n          (rst_n              ),
        .ch_in          (ctm_ev_in_flat     ),
        .ch_out         (ctm_ev_out_flat    )
    );

    assign mst_cti_event_out = ctm_ev_out_flat[0 +: CTI_EVENT_WIDTH];
    assign slv_cti_event_out = ctm_ev_out_flat[CTI_EVENT_WIDTH +: SLAVE_NUM*CTI_EVENT_WIDTH];

    // ================================================================
    // Debug Timestamp — Fanout (master → all slaves, combinational)
    // ================================================================

    generate
        for (gi = 0; gi < SLAVE_NUM; gi = gi + 1) begin : g_ts_fanout
            assign slv_dbg_timestamp[gi*DBG_TIMESTAMP_WIDTH +: DBG_TIMESTAMP_WIDTH] = mst_dbg_timestamp;
        end
    endgenerate

    // ================================================================
    // Debug Data — OR (all slaves → master, combinational)
    // ================================================================

    always_comb begin
        mst_dbg_data = '0;
        for (int i = 0; i < SLAVE_NUM; i = i + 1) begin
            mst_dbg_data = mst_dbg_data | slv_dbg_data[i*DBG_DATA_WIDTH +: DBG_DATA_WIDTH];
        end
    end

endmodule

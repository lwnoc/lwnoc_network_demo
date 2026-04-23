// =============================================================================
// Module  : dti_noc_switch
// Purpose : Stateless N-INIU × M-TNIU crossbar switch on the gnpd internal bus.
//
// REQ path (INIU→TNIU):
//   TNIU[j] receives a REQ when:
//     TNIU_DECMIN[j] <= req_srcid (= TTID) <= TNIU_DECMAX[j]
//   Multiple INIUs may simultaneously target the same TNIU.
//   Packet stickiness prevents mid-packet arbiter switch.
//
// RSP path (TNIU→INIU):
//   INIU[i] receives an RSP when:
//     INIU_DECMIN[i] <= rsp_srcid (= echoed TTID) <= INIU_DECMAX[i]
//   Stateless: no route_owner table required, provided each INIU is
//   assigned a non-overlapping TID range (see ID allocation document).
//
// Parameters TNIU_DECMIN/MAX and INIU_DECMIN/MAX are packed as flat
// 32-bit integer arrays: slot j occupies bits [j*32+31 : j*32].
//
// Notes:
//   - threshold pins stay boundary-visible but remain tied to 1'b1 internally.
//   - qos / tgtid channels are forwarded transparently but not used for routing.
// =============================================================================

module soc_dti_sw_io5_dti_noc_switch #(
    parameter int unsigned NUM_INIU      = 4                        ,
    parameter int unsigned NUM_TNIU      = 2                        ,
    parameter int unsigned TID_WIDTH     = 6                        ,
    parameter int unsigned PAYLOAD_WIDTH = 90                       ,

    parameter logic [NUM_TNIU*32-1:0] TNIU_DECMIN  = '0            ,
    parameter logic [NUM_TNIU*32-1:0] TNIU_DECMAX  = '0            ,
    parameter logic [NUM_INIU*32-1:0] INIU_DECMIN  = '0            ,
    parameter logic [NUM_INIU*32-1:0] INIU_DECMAX  = '0
)(
    input  logic clk                                                ,
    input  logic rst_n                                              ,

    input  logic [NUM_INIU-1:0]                     iniu_req_valid   ,
    output logic [NUM_INIU-1:0]                     iniu_req_ready   ,
    input  logic [NUM_INIU-1:0][PAYLOAD_WIDTH-1:0] iniu_req_payload ,
    input  logic [NUM_INIU-1:0][TID_WIDTH-1:0]     iniu_req_srcid   ,
    input  logic [NUM_INIU-1:0][TID_WIDTH-1:0]     iniu_req_tgtid   ,
    input  logic [NUM_INIU-1:0]                    iniu_req_qos     ,
    input  logic [NUM_INIU-1:0]                    iniu_req_last    ,
    output logic [NUM_INIU-1:0]                    iniu_req_threshold,

    output logic [NUM_INIU-1:0]                    iniu_rsp_valid   ,
    input  logic [NUM_INIU-1:0]                    iniu_rsp_ready   ,
    output logic [NUM_INIU-1:0][PAYLOAD_WIDTH-1:0] iniu_rsp_payload ,
    output logic [NUM_INIU-1:0][TID_WIDTH-1:0]     iniu_rsp_srcid   ,
    output logic [NUM_INIU-1:0][TID_WIDTH-1:0]     iniu_rsp_tgtid   ,
    output logic [NUM_INIU-1:0]                    iniu_rsp_qos     ,
    output logic [NUM_INIU-1:0]                    iniu_rsp_last    ,
    input  logic [NUM_INIU-1:0]                    iniu_rsp_threshold,

    output logic [NUM_TNIU-1:0]                    tniu_req_valid   ,
    input  logic [NUM_TNIU-1:0]                    tniu_req_ready   ,
    output logic [NUM_TNIU-1:0][PAYLOAD_WIDTH-1:0] tniu_req_payload ,
    output logic [NUM_TNIU-1:0][TID_WIDTH-1:0]     tniu_req_srcid   ,
    output logic [NUM_TNIU-1:0][TID_WIDTH-1:0]     tniu_req_tgtid   ,
    output logic [NUM_TNIU-1:0]                    tniu_req_qos     ,
    output logic [NUM_TNIU-1:0]                    tniu_req_last    ,
    input  logic [NUM_TNIU-1:0]                    tniu_req_threshold,

    input  logic [NUM_TNIU-1:0]                    tniu_rsp_valid   ,
    output logic [NUM_TNIU-1:0]                    tniu_rsp_ready   ,
    input  logic [NUM_TNIU-1:0][PAYLOAD_WIDTH-1:0] tniu_rsp_payload ,
    input  logic [NUM_TNIU-1:0][TID_WIDTH-1:0]     tniu_rsp_srcid   ,
    input  logic [NUM_TNIU-1:0][TID_WIDTH-1:0]     tniu_rsp_tgtid   ,
    input  logic [NUM_TNIU-1:0]                    tniu_rsp_qos     ,
    input  logic [NUM_TNIU-1:0]                    tniu_rsp_last    ,
    output logic [NUM_TNIU-1:0]                    tniu_rsp_threshold
);

    localparam int unsigned GPW        = PAYLOAD_WIDTH + (2 * TID_WIDTH) + 2;
    localparam int unsigned INIU_IDX_W = (NUM_INIU > 1) ? $clog2(NUM_INIU) : 1;
    localparam int unsigned TNIU_IDX_W = (NUM_TNIU > 1) ? $clog2(NUM_TNIU) : 1;

    assign iniu_req_threshold = {NUM_INIU{1'b1}};
    assign tniu_rsp_threshold = {NUM_TNIU{1'b1}};

    logic [NUM_INIU-1:0][GPW-1:0] req_gpld_in ;
    logic [NUM_TNIU-1:0][GPW-1:0] req_gpld_out;
    logic [NUM_TNIU-1:0][GPW-1:0] rsp_gpld_in ;
    logic [NUM_INIU-1:0][GPW-1:0] rsp_gpld_out;

    logic [NUM_TNIU-1:0][NUM_INIU-1:0]   req_hit      ;
    logic [NUM_TNIU-1:0][NUM_INIU-1:0]   req_grant_oh ;
    logic [NUM_TNIU-1:0]                 req_in_pkt_q ;
    logic [NUM_TNIU-1:0][INIU_IDX_W-1:0] req_locked_q ;
    logic [NUM_TNIU-1:0][INIU_IDX_W-1:0] req_rr_ptr_q ;

    logic [NUM_INIU-1:0][NUM_TNIU-1:0]   rsp_hit      ;
    logic [NUM_INIU-1:0][NUM_TNIU-1:0]   rsp_grant_oh ;
    logic [NUM_INIU-1:0]                 rsp_in_pkt_q ;
    logic [NUM_INIU-1:0][TNIU_IDX_W-1:0] rsp_locked_q ;
    logic [NUM_INIU-1:0][TNIU_IDX_W-1:0] rsp_rr_ptr_q ;

    genvar gi, gj, gk;

    generate
        for (gi = 0; gi < NUM_INIU; gi++) begin : g_req_pack
            assign req_gpld_in[gi] = {
                iniu_req_payload[gi],
                iniu_req_srcid[gi],
                iniu_req_tgtid[gi],
                iniu_req_qos[gi],
                iniu_req_last[gi]
            };
        end
        for (gj = 0; gj < NUM_TNIU; gj++) begin : g_rsp_pack
            assign rsp_gpld_in[gj] = {
                tniu_rsp_payload[gj],
                tniu_rsp_srcid[gj],
                tniu_rsp_tgtid[gj],
                tniu_rsp_qos[gj],
                tniu_rsp_last[gj]
            };
        end
    endgenerate

    generate
        for (gj = 0; gj < NUM_TNIU; gj++) begin : g_req_hit
            for (gi = 0; gi < NUM_INIU; gi++) begin : g_req_hit_iniu
                assign req_hit[gj][gi] =
                    iniu_req_valid[gi] &&
                    ($unsigned(iniu_req_srcid[gi]) >= TNIU_DECMIN[gj*32 +: 32]) &&
                    ($unsigned(iniu_req_srcid[gi]) <= TNIU_DECMAX[gj*32 +: 32]);
            end
        end
    endgenerate

    generate
        for (gj = 0; gj < NUM_TNIU; gj++) begin : g_req_arb
            always_comb begin : req_grant_comb
                req_grant_oh[gj] = '0;
                if (req_in_pkt_q[gj]) begin
                    if (req_hit[gj][req_locked_q[gj]]) begin
                        req_grant_oh[gj][req_locked_q[gj]] = 1'b1;
                    end
                end else begin
                    for (int unsigned offset = 0; offset < NUM_INIU; offset++) begin
                        automatic int idx;
                        idx = (int'(req_rr_ptr_q[gj]) + offset) % NUM_INIU;
                        if (req_hit[gj][idx]) begin
                            req_grant_oh[gj][idx] = 1'b1;
                            break;
                        end
                    end
                end
            end

            always_ff @(posedge clk or negedge rst_n) begin : req_state_ff
                if (!rst_n) begin
                    req_in_pkt_q[gj] <= 1'b0;
                    req_locked_q[gj] <= '0;
                    req_rr_ptr_q[gj] <= '0;
                end else if (tniu_req_valid[gj] && tniu_req_ready[gj]) begin
                    if (tniu_req_last[gj]) begin
                        req_in_pkt_q[gj] <= 1'b0;
                        req_rr_ptr_q[gj] <= INIU_IDX_W'(req_locked_q[gj] + 1'b1);
                    end else if (!req_in_pkt_q[gj]) begin
                        req_in_pkt_q[gj] <= 1'b1;
                        for (int unsigned k = 0; k < NUM_INIU; k++) begin
                            if (req_grant_oh[gj][k]) begin
                                req_locked_q[gj] <= INIU_IDX_W'(k);
                            end
                        end
                    end
                end
            end

            assign tniu_req_valid[gj]   = |req_grant_oh[gj];
            assign tniu_req_last[gj]    = req_gpld_out[gj][0];
            assign tniu_req_qos[gj]     = req_gpld_out[gj][1];
            assign tniu_req_tgtid[gj]   = req_gpld_out[gj][TID_WIDTH+1:2];
            assign tniu_req_srcid[gj]   = req_gpld_out[gj][(2*TID_WIDTH)+1:TID_WIDTH+2];
            assign tniu_req_payload[gj] = req_gpld_out[gj][GPW-1:(2*TID_WIDTH)+2];
        end
    endgenerate

    generate
        for (gj = 0; gj < NUM_TNIU; gj++) begin : g_req_mux_tniu
            for (gk = 0; gk < GPW; gk++) begin : g_req_mux_bit
                logic [NUM_INIU-1:0] req_src_bits;
                for (gi = 0; gi < NUM_INIU; gi++) begin : g_req_mux_iniu
                    assign req_src_bits[gi] = req_gpld_in[gi][gk];
                end
                assign req_gpld_out[gj][gk] = |(req_src_bits & req_grant_oh[gj]);
            end
        end
    endgenerate

    generate
        for (gi = 0; gi < NUM_INIU; gi++) begin : g_iniu_req_ready
            always_comb begin : iniu_req_ready_comb
                iniu_req_ready[gi] = 1'b0;
                for (int unsigned j = 0; j < NUM_TNIU; j++) begin
                    if (req_grant_oh[j][gi]) begin
                        iniu_req_ready[gi] = tniu_req_ready[j];
                    end
                end
            end
        end
    endgenerate

    generate
        for (gi = 0; gi < NUM_INIU; gi++) begin : g_rsp_hit
            for (gj = 0; gj < NUM_TNIU; gj++) begin : g_rsp_hit_tniu
                assign rsp_hit[gi][gj] =
                    tniu_rsp_valid[gj] &&
                    ($unsigned(tniu_rsp_srcid[gj]) >= INIU_DECMIN[gi*32 +: 32]) &&
                    ($unsigned(tniu_rsp_srcid[gj]) <= INIU_DECMAX[gi*32 +: 32]);
            end
        end
    endgenerate

    generate
        for (gi = 0; gi < NUM_INIU; gi++) begin : g_rsp_arb
            always_comb begin : rsp_grant_comb
                rsp_grant_oh[gi] = '0;
                if (rsp_in_pkt_q[gi]) begin
                    if (rsp_hit[gi][rsp_locked_q[gi]]) begin
                        rsp_grant_oh[gi][rsp_locked_q[gi]] = 1'b1;
                    end
                end else begin
                    for (int unsigned offset = 0; offset < NUM_TNIU; offset++) begin
                        automatic int idx;
                        idx = (int'(rsp_rr_ptr_q[gi]) + offset) % NUM_TNIU;
                        if (rsp_hit[gi][idx]) begin
                            rsp_grant_oh[gi][idx] = 1'b1;
                            break;
                        end
                    end
                end
            end

            always_ff @(posedge clk or negedge rst_n) begin : rsp_state_ff
                if (!rst_n) begin
                    rsp_in_pkt_q[gi] <= 1'b0;
                    rsp_locked_q[gi] <= '0;
                    rsp_rr_ptr_q[gi] <= '0;
                end else if (iniu_rsp_valid[gi] && iniu_rsp_ready[gi]) begin
                    if (iniu_rsp_last[gi]) begin
                        rsp_in_pkt_q[gi] <= 1'b0;
                        rsp_rr_ptr_q[gi] <= TNIU_IDX_W'(rsp_locked_q[gi] + 1'b1);
                    end else if (!rsp_in_pkt_q[gi]) begin
                        rsp_in_pkt_q[gi] <= 1'b1;
                        for (int unsigned k = 0; k < NUM_TNIU; k++) begin
                            if (rsp_grant_oh[gi][k]) begin
                                rsp_locked_q[gi] <= TNIU_IDX_W'(k);
                            end
                        end
                    end
                end
            end

            assign iniu_rsp_valid[gi]   = |rsp_grant_oh[gi];
            assign iniu_rsp_last[gi]    = rsp_gpld_out[gi][0];
            assign iniu_rsp_qos[gi]     = rsp_gpld_out[gi][1];
            assign iniu_rsp_tgtid[gi]   = rsp_gpld_out[gi][TID_WIDTH+1:2];
            assign iniu_rsp_srcid[gi]   = rsp_gpld_out[gi][(2*TID_WIDTH)+1:TID_WIDTH+2];
            assign iniu_rsp_payload[gi] = rsp_gpld_out[gi][GPW-1:(2*TID_WIDTH)+2];
        end
    endgenerate

    generate
        for (gi = 0; gi < NUM_INIU; gi++) begin : g_rsp_mux_iniu
            for (gk = 0; gk < GPW; gk++) begin : g_rsp_mux_bit
                logic [NUM_TNIU-1:0] rsp_src_bits;
                for (gj = 0; gj < NUM_TNIU; gj++) begin : g_rsp_mux_tniu
                    assign rsp_src_bits[gj] = rsp_gpld_in[gj][gk];
                end
                assign rsp_gpld_out[gi][gk] = |(rsp_src_bits & rsp_grant_oh[gi]);
            end
        end
    endgenerate

    generate
        for (gj = 0; gj < NUM_TNIU; gj++) begin : g_tniu_rsp_ready
            always_comb begin : tniu_rsp_ready_comb
                tniu_rsp_ready[gj] = 1'b0;
                for (int unsigned i = 0; i < NUM_INIU; i++) begin
                    if (rsp_grant_oh[i][gj]) begin
                        tniu_rsp_ready[gj] = iniu_rsp_ready[i];
                    end
                end
            end
        end
    endgenerate

endmodule

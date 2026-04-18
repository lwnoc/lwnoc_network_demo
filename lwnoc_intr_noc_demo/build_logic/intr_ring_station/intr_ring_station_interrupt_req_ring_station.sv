module intr_ring_station_interrupt_req_ring_station
#(
    parameter integer unsigned NODE_ID       = 0,
    parameter integer unsigned NODE_COUNT    = 6,
    parameter bit              HAS_INIU      = 1'b1,
    parameter bit              HAS_TNIU      = 1'b0,
    parameter integer unsigned PAYLOAD_WIDTH = 40,
    parameter integer unsigned SRCID_WIDTH   = 8,
    parameter integer unsigned TGTID_WIDTH   = 8,
    parameter integer unsigned QOS_WIDTH     = 4
)(
    input  logic                      local_tx_valid   ,
    output logic                      local_tx_ready   ,
    input  logic [PAYLOAD_WIDTH-1:0]  local_tx_payload ,
    input  logic [SRCID_WIDTH-1:0]    local_tx_srcid   ,
    input  logic [TGTID_WIDTH-1:0]    local_tx_tgtid   ,
    input  logic [QOS_WIDTH-1:0]      local_tx_qos     ,
    input  logic                      local_tx_last    ,

    output logic                      local_rx_valid   ,
    input  logic                      local_rx_ready   ,
    output logic [PAYLOAD_WIDTH-1:0]  local_rx_payload ,
    output logic [SRCID_WIDTH-1:0]    local_rx_srcid   ,
    output logic [TGTID_WIDTH-1:0]    local_rx_tgtid   ,
    output logic [QOS_WIDTH-1:0]      local_rx_qos     ,
    output logic                      local_rx_last    ,

    input  logic                      cw_in_valid      ,
    output logic                      cw_in_ready      ,
    input  logic [PAYLOAD_WIDTH-1:0]  cw_in_payload    ,
    input  logic [SRCID_WIDTH-1:0]    cw_in_srcid      ,
    input  logic [TGTID_WIDTH-1:0]    cw_in_tgtid      ,
    input  logic [QOS_WIDTH-1:0]      cw_in_qos        ,
    input  logic                      cw_in_last       ,
    output logic                      cw_out_valid     ,
    input  logic                      cw_out_ready     ,
    output logic [PAYLOAD_WIDTH-1:0]  cw_out_payload   ,
    output logic [SRCID_WIDTH-1:0]    cw_out_srcid     ,
    output logic [TGTID_WIDTH-1:0]    cw_out_tgtid     ,
    output logic [QOS_WIDTH-1:0]      cw_out_qos       ,
    output logic                      cw_out_last      ,

    input  logic                      ccw_in_valid     ,
    output logic                      ccw_in_ready     ,
    input  logic [PAYLOAD_WIDTH-1:0]  ccw_in_payload   ,
    input  logic [SRCID_WIDTH-1:0]    ccw_in_srcid     ,
    input  logic [TGTID_WIDTH-1:0]    ccw_in_tgtid     ,
    input  logic [QOS_WIDTH-1:0]      ccw_in_qos       ,
    input  logic                      ccw_in_last      ,
    output logic                      ccw_out_valid    ,
    input  logic                      ccw_out_ready    ,
    output logic [PAYLOAD_WIDTH-1:0]  ccw_out_payload  ,
    output logic [SRCID_WIDTH-1:0]    ccw_out_srcid    ,
    output logic [TGTID_WIDTH-1:0]    ccw_out_tgtid    ,
    output logic [QOS_WIDTH-1:0]      ccw_out_qos      ,
    output logic                      ccw_out_last
);

    localparam logic [TGTID_WIDTH-1:0] NODE_ID_VALUE = TGTID_WIDTH'(NODE_ID);

    logic cw_hit          ;
    logic ccw_hit         ;
    logic cw_pass_valid   ;
    logic ccw_pass_valid  ;
    logic cw_pick_local   ;
    logic ccw_pick_local  ;
    logic inject_to_ccw   ;
    logic cw_inject_valid ;
    logic ccw_inject_valid;

    function automatic logic route_to_ccw(input logic [TGTID_WIDTH-1:0] tgt_id);
        int unsigned tgt_idx   ;
        int unsigned cw_dist   ;
        int unsigned ccw_dist  ;
        begin
            tgt_idx = int'(tgt_id);
            if(tgt_idx >= NODE_COUNT) begin
                route_to_ccw = 1'b0;
            end
            else begin
                cw_dist      = (tgt_idx + NODE_COUNT - NODE_ID) % NODE_COUNT;
                ccw_dist     = (NODE_ID + NODE_COUNT - tgt_idx) % NODE_COUNT;
                route_to_ccw = (ccw_dist < cw_dist);
            end
        end
    endfunction

    assign cw_hit         = HAS_TNIU && cw_in_valid  && (cw_in_tgtid  == NODE_ID_VALUE);
    assign ccw_hit        = HAS_TNIU && ccw_in_valid && (ccw_in_tgtid == NODE_ID_VALUE);
    assign cw_pass_valid  = cw_in_valid  && ~cw_hit;
    assign ccw_pass_valid = ccw_in_valid && ~ccw_hit;
    assign cw_pick_local  = cw_hit;
    assign ccw_pick_local = ~cw_hit && ccw_hit;
    assign inject_to_ccw  = route_to_ccw(local_tx_tgtid);

    assign local_rx_valid   = cw_pick_local | ccw_pick_local;
    assign local_rx_payload = cw_pick_local ? cw_in_payload : ccw_in_payload;
    assign local_rx_srcid   = cw_pick_local ? cw_in_srcid   : ccw_in_srcid;
    assign local_rx_tgtid   = cw_pick_local ? cw_in_tgtid   : ccw_in_tgtid;
    assign local_rx_qos     = cw_pick_local ? cw_in_qos     : ccw_in_qos;
    assign local_rx_last    = cw_pick_local ? cw_in_last    : ccw_in_last;

    assign cw_in_ready  = cw_pick_local  ? local_rx_ready : (~cw_hit  && cw_out_ready);
    assign ccw_in_ready = ccw_pick_local ? local_rx_ready : (~ccw_hit && ccw_out_ready);

    assign cw_inject_valid  = HAS_INIU && local_tx_valid && ~inject_to_ccw && ~cw_pass_valid;
    assign ccw_inject_valid = HAS_INIU && local_tx_valid &&  inject_to_ccw && ~ccw_pass_valid;

    always_comb begin
        cw_out_valid   = 1'b0;
        cw_out_payload = '0;
        cw_out_srcid   = '0;
        cw_out_tgtid   = '0;
        cw_out_qos     = '0;
        cw_out_last    = 1'b0;

        if(cw_pass_valid) begin
            cw_out_valid   = 1'b1;
            cw_out_payload = cw_in_payload;
            cw_out_srcid   = cw_in_srcid;
            cw_out_tgtid   = cw_in_tgtid;
            cw_out_qos     = cw_in_qos;
            cw_out_last    = cw_in_last;
        end
        else if(cw_inject_valid) begin
            cw_out_valid   = 1'b1;
            cw_out_payload = local_tx_payload;
            cw_out_srcid   = local_tx_srcid;
            cw_out_tgtid   = local_tx_tgtid;
            cw_out_qos     = local_tx_qos;
            cw_out_last    = local_tx_last;
        end
    end

    always_comb begin
        ccw_out_valid   = 1'b0;
        ccw_out_payload = '0;
        ccw_out_srcid   = '0;
        ccw_out_tgtid   = '0;
        ccw_out_qos     = '0;
        ccw_out_last    = 1'b0;

        if(ccw_pass_valid) begin
            ccw_out_valid   = 1'b1;
            ccw_out_payload = ccw_in_payload;
            ccw_out_srcid   = ccw_in_srcid;
            ccw_out_tgtid   = ccw_in_tgtid;
            ccw_out_qos     = ccw_in_qos;
            ccw_out_last    = ccw_in_last;
        end
        else if(ccw_inject_valid) begin
            ccw_out_valid   = 1'b1;
            ccw_out_payload = local_tx_payload;
            ccw_out_srcid   = local_tx_srcid;
            ccw_out_tgtid   = local_tx_tgtid;
            ccw_out_qos     = local_tx_qos;
            ccw_out_last    = local_tx_last;
        end
    end

    always_comb begin
        local_tx_ready = 1'b0;
        if(HAS_INIU && local_tx_valid) begin
            if(inject_to_ccw) begin
                local_tx_ready = ~ccw_pass_valid && ccw_out_ready;
            end
            else begin
                local_tx_ready = ~cw_pass_valid && cw_out_ready;
            end
        end
    end

endmodule

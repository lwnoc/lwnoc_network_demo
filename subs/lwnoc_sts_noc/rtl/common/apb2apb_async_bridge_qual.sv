module apb2apb_async_bridge_qual
#(
    parameter integer unsigned ADDR_WIDTH = 32,
    parameter integer unsigned SYNC_STAGE = 2
) (
    input   logic                     clk_s,
    input   logic                     rstn_s,
    input   logic                     clk_m,
    input   logic                     rstn_m,

    input   logic                     psel_s,
    input   logic                     penable_s,
    input   logic [ADDR_WIDTH-1:0]    paddr_s,
    input   logic                     pwrite_s,
    input   logic [31:0]              pwdata_s,
    output  logic [31:0]              prdata_s,
    output  logic                     pready_s,
    input   logic [3:0]               pstrb_s,
    input   logic [2:0]               pprot_s,
    output  logic                     pslverr_s,

    output  logic                     psel_m,
    output  logic                     penable_m,
    output  logic [ADDR_WIDTH-1:0]    paddr_m,
    output  logic                     pwrite_m,
    output  logic [31:0]              pwdata_m,
    input   logic [31:0]              prdata_m,
    input   logic                     pready_m,
    output  logic [3:0]               pstrb_m,
    output  logic [2:0]               pprot_m,
    input   logic                     pslverr_m
);

logic req_s2m;
logic req_s2m_sync;
logic req_s2m_sync_d;
logic ack_m2s;
logic new_req;
logic pulse_s2m_edge;
logic req_s_pending;

logic [ADDR_WIDTH-1:0]  paddr_s_d;
logic                   pwrite_s_d;
logic [31:0]            pwdata_s_d;
logic [3:0]             pstrb_s_d;
logic [2:0]             pprot_s_d;

logic ack_m2s_sync_d;
logic pulse_m2s_edge;
logic [31:0] prdata_m_done;
logic        pslverr_m_done;

assign new_req = psel_s && ~penable_s;

// use a level(long enough) to indicate a apb transfer
always_ff @(posedge clk_s or negedge rstn_s) begin
    if (!rstn_s) begin
        req_s2m <= 1'b0;  
    end else if(new_req & ~req_s_pending) begin
        req_s2m <= ~req_s2m;
    end 
end

//latch s2m info
always_ff @(posedge clk_s or negedge rstn_s) begin
    if (!rstn_s) begin
        paddr_s_d  <= {ADDR_WIDTH{1'b0}};
        pwrite_s_d <= 1'b0;
        pwdata_s_d <= 32'b0;
        pstrb_s_d  <= 4'b0;
        pprot_s_d  <= 3'b0;
    end else if(new_req & ~req_s_pending) begin
        paddr_s_d  <= paddr_s;
        pwrite_s_d <= pwrite_s;
        pwdata_s_d <= pwdata_s;
        pstrb_s_d  <= pstrb_s;
        pprot_s_d  <= pprot_s;
    end
end

// pending:when new_req arrival s domain,0->1,when ack arrival s domain,1->0
always_ff @(posedge clk_s or negedge rstn_s) begin
    if (!rstn_s) begin
        req_s_pending <= 1'b0;  
    end else if(pulse_m2s_edge) begin
        req_s_pending <= 1'b0;
    end else if(new_req) begin
        req_s_pending <= 1'b1;
    end
end

assign pready_s = ~req_s_pending;

fcip_sync_cell #(
    .DATA_WIDTH  (1),
    .SYN_STAGE   (SYNC_STAGE), // must upper than 1
    .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
    .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
) u_req_s2m_sync (
    .clk         (clk_m  ),
    .rst_n       (rstn_m),
    .d           (req_s2m),
    .q           (req_s2m_sync)
);

// edge detect to initial transfer in clk_m domain
always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        req_s2m_sync_d <= 1'b0;  
    end else begin
        req_s2m_sync_d <= req_s2m_sync;
    end 
end

assign pulse_s2m_edge = req_s2m_sync ^ req_s2m_sync_d;
assign trans_done_m = psel_m & penable_m & pready_m;

always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        prdata_m_done  <= 32'b0;
        pslverr_m_done <= 1'b0;
    end else if (trans_done_m) begin
        prdata_m_done  <= prdata_m;
        pslverr_m_done <= pslverr_m;
    end
end

always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        psel_m <= 1'b0;  
    end else if(trans_done_m) begin
        psel_m <= 1'b0;
    end else if(pulse_s2m_edge) begin
        psel_m <= 1'b1;
    end
end

always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        penable_m <= 1'b0;  
    end else if(trans_done_m) begin
        penable_m <= 1'b0;
    end else if(psel_m) begin
        penable_m <= 1'b1;
    end
end

always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        paddr_m <= {ADDR_WIDTH{1'b0}};
        pwrite_m <= 1'b0;
        pwdata_m <= 32'b0;
        pstrb_m <= 4'b0;
        pprot_m <= 3'b0;
    end else if(pulse_s2m_edge) begin
        paddr_m  <= paddr_s_d;
        pwrite_m <= pwrite_s_d;
        pwdata_m <= pwdata_s_d;
        pstrb_m  <= pstrb_s_d;
        pprot_m  <= pprot_s_d;
    end
end

// use a level(long enough) to indicate a mst apb transfer done
always_ff @(posedge clk_m or negedge rstn_m) begin
    if (!rstn_m) begin
        ack_m2s <= 1'b0;  
    end else if(trans_done_m) begin
        ack_m2s <= ~ack_m2s;
    end 
end

fcip_sync_cell #(
    .DATA_WIDTH  (1),
    .SYN_STAGE   (SYNC_STAGE),
    .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
    .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
) u_ack_m2s_sync (
    .clk         (clk_s  ),
    .rst_n       (rstn_s),
    .d           (ack_m2s),
    .q           (ack_m2s_sync)
);

always_ff @(posedge clk_s or negedge rstn_s) begin
    if (!rstn_s) begin
        ack_m2s_sync_d <= 1'b0;  
    end else begin
        ack_m2s_sync_d <= ack_m2s_sync;
    end 
end
assign pulse_m2s_edge = ack_m2s_sync ^ ack_m2s_sync_d;

always_ff @(posedge clk_s or negedge rstn_s) begin
    if (!rstn_s) begin
        prdata_s <= 32'b0;
        pslverr_s <= 1'b0;
    end else if(pulse_m2s_edge) begin
        prdata_s <= prdata_m_done;
        pslverr_s <= pslverr_m_done;
    end
end

endmodule
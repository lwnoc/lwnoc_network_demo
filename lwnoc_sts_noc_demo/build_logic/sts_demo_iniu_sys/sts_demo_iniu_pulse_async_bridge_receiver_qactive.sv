module pulse_async_bridge_receiver_qactive
#(
    parameter integer unsigned DATA_WIDTH     = 1,
    parameter integer unsigned FF_SYNC_DEPTH  = 2
) (
    input   logic                   clk_rx          ,
    input   logic                   rstn_rx         ,
    input   logic [DATA_WIDTH-1:0]  pulse_in        ,
    output  logic [DATA_WIDTH-1:0]  pulse_req       ,
    input   logic [DATA_WIDTH-1:0]  pulse_ack       ,
    output  logic                   clk_rx_qactive
);

    localparam integer unsigned WIDTH = (DATA_WIDTH > 0 && DATA_WIDTH < 33) ? DATA_WIDTH : 1;
    localparam integer unsigned STAGE = (FF_SYNC_DEPTH == 3) ? FF_SYNC_DEPTH : 2;

    logic [WIDTH-1:0]   pulse_in_q_next;
    logic [WIDTH-1:0]   pulse_in_q;
    logic [WIDTH-1:0]   pulse_in_pulse;
    logic [WIDTH-1:0]   pulse_req_next;
    logic [WIDTH-1:0]   pulse_req_int;
    logic [WIDTH-1:0]   pulse_req_q;
    logic [WIDTH-1:0]   pulse_ack_sync;
    logic [2*WIDTH-1:0] or_inputs;

    genvar i;

    assign pulse_in_q_next = pulse_in & ~pulse_req_q & ~pulse_ack_sync;

    always_ff @(posedge clk_rx or negedge rstn_rx) begin
        if (!rstn_rx) begin
            pulse_in_q <= {WIDTH{1'b0}};
        end else begin
            pulse_in_q <= pulse_in_q_next;
        end
    end

    assign pulse_in_pulse = pulse_in & ~pulse_in_q;
    assign pulse_req_int  = pulse_req_q;
    assign pulse_req_next = (pulse_in_pulse & ~pulse_ack_sync) | (pulse_req_q & ~pulse_ack_sync);

    always_ff @( posedge clk_rx or negedge rstn_rx ) begin
        if (!rstn_rx) begin
            pulse_req_q <= {WIDTH{1'b0}};
        end else begin
            pulse_req_q <= pulse_req_next;
        end
    end

    assign or_inputs = {pulse_req_q, pulse_ack_sync};

    // TODO:need to replace by OR stdcell ip
    assign clk_rx_qactive = |or_inputs;

    generate
        for (i = 0; i<WIDTH; i=i+1) begin : gen_ack_sync_no_cdc
            fcip_sync_cell #(
                .DATA_WIDTH  (1),
                .SYN_STAGE   (STAGE), // must upper than 1
                .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
                .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
            ) u_sync_ack (
                .clk         (clk_rx          ),
                .rst_n       (rstn_rx         ),
                .d           (pulse_ack[i]    ),
                .q           (pulse_ack_sync[i])
            );
        end
    endgenerate

    assign pulse_req = pulse_req_int;
endmodule

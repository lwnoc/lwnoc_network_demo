module pulse_async_bridge_transmitter_qactive
#(
    parameter integer unsigned DATA_WIDTH     = 1,
    parameter integer unsigned FF_SYNC_DEPTH  = 2
) (
    input  logic                    clk_tx,
    input  logic                    rstn_tx,
    output logic [DATA_WIDTH-1:0]   pulse_out,
    input  logic [DATA_WIDTH-1:0]   pulse_req,
    output logic [DATA_WIDTH-1:0]   pulse_ack,
    output logic                    clk_tx_qactive
);
    localparam integer unsigned WIDTH = (DATA_WIDTH > 0 && DATA_WIDTH < 33) ? DATA_WIDTH : 1;
    localparam integer unsigned STAGE = (FF_SYNC_DEPTH == 3) ? FF_SYNC_DEPTH : 2;

    logic [WIDTH-1:0] pulse_ack_int;
    logic [WIDTH-1:0] pulse_ack_q;
    logic [WIDTH-1:0] pulse_req_sync;
    logic [2*WIDTH-1:0] or_inputs;

    genvar i;

    assign pulse_ack_int = pulse_req_sync;

    always_ff @(posedge clk_tx or negedge rstn_tx) begin
        if (!rstn_tx) begin
            pulse_ack_q <= {WIDTH{1'b0}};
        end else begin
            pulse_ack_q <= pulse_ack_int;
        end
    end

    assign pulse_out = pulse_ack_int & ~pulse_ack_q;

    assign or_inputs = {pulse_req, pulse_ack_q};

    // TODO:need to replace by or stdcell ip
    assign clk_tx_qactive = |or_inputs;

    generate
        for (i = 0; i<WIDTH; i=i+1) begin : gen_req_sync_no_cdc
            soc_sts_util_sync_cell #(
                .DATA_WIDTH  (1),
                .SYN_STAGE   (STAGE), // must upper than 1
                .VT_TYPE     (1), // 0: LVT, 1: SVT, 2: ULVT, 7: LVTLL, 8: ULVTLL
                .RST_VALUE   (0)// 0: sync_arst, 1: sync_aset
            ) u_sync_req (
                .clk         (clk_tx          ),
                .rst_n       (rstn_tx         ),
                .d           (pulse_req[i]    ),
                .q           (pulse_req_sync[i])
            );
        end
    endgenerate

    assign pulse_ack = pulse_ack_q;

endmodule

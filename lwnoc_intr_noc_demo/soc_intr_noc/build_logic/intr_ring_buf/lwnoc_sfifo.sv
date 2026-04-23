module lwnoc_sfifo #(
    parameter  integer unsigned BUF_DEP     = 2,
    parameter  integer unsigned FIFO_WIDTH  = 512,
    parameter  integer unsigned AFULL_LEVEL = 1
)(
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic [FIFO_WIDTH-1:0]       data_in,
    output logic [FIFO_WIDTH-1:0]       data_out,
    input  logic                        wr_en,
    input  logic                        rd_en,
    output logic                        empty,
    output logic                        afull,
    output logic                        full
);

// sync_sfifo_reg #(
//     .WIDTH      (FIFO_WIDTH    ),
//     .DEPTH      (BUF_DEP       ),
//     .AF_LEVEL   (AFULL_LEVEL   ),
//     .BYPASS     (0             )
// ) u_vcbuf (
//     .clk                    (clk         ),
//     .rst_n                  (rst_n       ),
//     .clr                    (1'b0        ),
//     .data_in                (data_in     ),
//     .data_out               (data_out    ),
//     .wr_en                  (wr_en       ),
//     .rd_en                  (rd_en       ),
//     .full                   (/* unused */),
//     .empty                  (empty       ),
//     .almost_full            (afull       ),
//     .almost_empty           (/* unused */),
//     .word_cnt               (/* unused */),
//     .error                  (/* unused */)
// );

logic rsp_vld;
logic wr_req_rdy;

fcip_sync_fifo_reg #(
    .FIFO_DEPTH             ( BUF_DEP     ),
    .FIFO_WIDTH             ( FIFO_WIDTH  ),
    .ALMOST_FULL_THRESHOLD  ( AFULL_LEVEL ),
    .ALMOST_EMPTY_THRESHOLD ( 1           ),
    .FORWARD_EN ( 0 )
) u_sync_fifo (
    .clk               (clk        ),
    .rst_n             (rst_n      ),

    .stall      (1'b0      ),
    .clear      (1'b0      ),
    .idle       (/* unused */),

    .write_req_vld  (wr_en      ),
    .write_req_pld  (data_in    ),
    .write_req_rdy  (wr_req_rdy ),

    .read_resp_vld  (rsp_vld    ),
    .read_resp_pld  (data_out   ),
    .read_resp_rdy  (rd_en      ),

    .almost_full    (afull      ),
    .almost_empty   (/* unused */),
    .empty          (empty      ),
    .full           (full       )
);

endmodule

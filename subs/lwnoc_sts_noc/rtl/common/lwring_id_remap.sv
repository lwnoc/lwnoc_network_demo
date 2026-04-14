module lwring_id_remap
#(
    parameter  DEPTH     = 512,
    parameter  ID_WIDTH  = 16,
    localparam IDX_WIDTH = $clog2(DEPTH)
)(
    input  logic                 clk,
    input  logic                 rst_n,

    input  logic                 alloc_vld,
    output logic                 alloc_rdy,
    input  logic [ID_WIDTH-1:0]  alloc_id,
    output logic [IDX_WIDTH-1:0] alloc_remap_id,              

    input  logic                 check_ack,
    input  logic [IDX_WIDTH-1:0] check_idx,
    output logic [ID_WIDTH-1:0]  check_id
);

    //=====================================
    // internal signals
    //=====================================
    logic [DEPTH-1:0]       v_prealloc_vld;
    logic [DEPTH-1:0]       v_prealloc_rdy;
    logic [2**IDX_WIDTH-1:0]v_alloc_ack;
    logic [2**IDX_WIDTH-1:0]v_check_ack;
    logic [ID_WIDTH-1:0]    v_check_id     [DEPTH-1:0];
    logic                   prealloc_vld;
    logic                   prealloc_rdy;
    logic [IDX_WIDTH-1:0]   prealloc_pld;

    logic                   fifo_vld;
    logic                   fifo_rdy;
    logic [IDX_WIDTH-1:0]   fifo_pld;
    logic                   fifo_en;


    //=====================================
    // interface
    //=====================================
    assign alloc_rdy       = fifo_vld;
    assign alloc_remap_id  = fifo_pld;
    assign check_id        = v_check_id[check_idx];


    //=====================================
    // preallocator
    //=====================================
    assign fifo_rdy = alloc_vld;
    assign fifo_en  = fifo_vld && fifo_rdy;

    fcip_rob_prealloc #(
        .ROB_ENTRY_NUM(DEPTH)
    ) u_prealloc (
        .v_in_vld  (v_prealloc_vld),
        .v_in_rdy  (v_prealloc_rdy),
        .out_vld   (prealloc_vld  ),
        .out_rdy   (prealloc_rdy  ),
        .out_pld   (prealloc_pld  ),
        .out_pld_oh(              )
    );

    cmn_vrp_reg_fifo #(
        .PLD_TYPE  (logic [IDX_WIDTH-1:0]),
        .ADDR_WIDTH(8                    )
    ) u_id_fifo (
        .clk    (clk         ),
        .rst_n  (rst_n       ),
        .in_vld (prealloc_vld),
        .in_rdy (prealloc_rdy),
        .in_pld (prealloc_pld),
        .out_vld(fifo_vld    ),
        .out_rdy(fifo_rdy    ),
        .out_pld(fifo_pld    )
    );

    fcip_rob_id_dec #(
        .BIN_WIDTH(IDX_WIDTH)
    ) u_alloc_id_dec (
        .in_en   (fifo_en    ),
        .in_index(fifo_pld   ),
        .v_out_en(v_alloc_ack)
    );


    fcip_rob_id_dec #(
        .BIN_WIDTH(IDX_WIDTH)
    ) u_check_id_dec (
        .in_en   (check_ack  ),
        .in_index(check_idx  ),
        .v_out_en(v_check_ack)
    );

    //=====================================
    // entry
    //=====================================
    generate
        for(genvar i = 0; i < DEPTH; i=i+1) begin: GEN_ENTRY
            lwring_id_remap_entry #(
                .ID_WIDTH(ID_WIDTH)
            ) u_entry (
                .clk         (clk              ),
                .rst_n       (rst_n            ),
                .prealloc_vld(v_prealloc_vld[i]),
                .prealloc_rdy(v_prealloc_rdy[i]),
                .alloc_ack   (v_alloc_ack[i]   ),
                .alloc_id    (alloc_id         ),
                .check_ack   (v_check_ack[i]   ),
                .check_id    (v_check_id[i]    )
            );
        end
    endgenerate

endmodule
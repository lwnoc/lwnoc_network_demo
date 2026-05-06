module lwring_id_remap
#(
    parameter  DEPTH      = 512,
    parameter  ID_WIDTH   = 16,
    parameter  PLD_WIDTH  = 1,
    localparam IDX_WIDTH  = $clog2(DEPTH),
    localparam ID_COUNT   = (1 << ID_WIDTH)
)(
    input  logic                     clk,
    input  logic                     rst_n,

    input  logic                     alloc_vld,
    output logic                     alloc_rdy,
    input  logic [ID_WIDTH-1:0]      alloc_id,
    output logic [IDX_WIDTH-1:0]     alloc_remap_id,

    input  logic                     complete_vld,
    output logic                     complete_rdy,
    input  logic [IDX_WIDTH-1:0]     complete_idx,
    input  logic [PLD_WIDTH-1:0]     complete_pld,

    output logic                     retire_vld,
    input  logic                     retire_rdy,
    output logic [ID_WIDTH-1:0]      retire_id,
    output logic [PLD_WIDTH-1:0]     retire_pld
);

    //=====================================
    // internal signals
    //=====================================
    logic [DEPTH-1:0]           v_prealloc_vld;
    logic [DEPTH-1:0]           v_prealloc_rdy;
    logic [2**IDX_WIDTH-1:0]    v_alloc_ack;
    logic [2**IDX_WIDTH-1:0]    v_complete_ack;
    logic [2**IDX_WIDTH-1:0]    v_retire_ack;
    logic [DEPTH-1:0]           v_link_ack;
    logic [ID_WIDTH-1:0]        v_entry_id       [DEPTH-1:0];
    logic [IDX_WIDTH-1:0]       v_entry_next_idx [DEPTH-1:0];
    logic [PLD_WIDTH-1:0]       v_entry_pld      [DEPTH-1:0];
    logic [IDX_WIDTH-1:0]       v_id_head_idx    [ID_COUNT-1:0];
    logic [IDX_WIDTH-1:0]       v_id_tail_idx    [ID_COUNT-1:0];
    logic [IDX_WIDTH-1:0]       v_id_head_idx_nxt[ID_COUNT-1:0];
    logic [IDX_WIDTH-1:0]       v_id_tail_idx_nxt[ID_COUNT-1:0];
    logic [DEPTH-1:0]           v_entry_next_vld;
    logic [DEPTH-1:0]           v_entry_done;
    logic [ID_COUNT-1:0]        v_id_head_vld;
    logic [ID_COUNT-1:0]        v_id_head_vld_nxt;
    logic                       prealloc_vld;
    logic                       prealloc_rdy;
    logic [IDX_WIDTH-1:0]       prealloc_pld;

    logic                       fifo_vld;
    logic                       fifo_rdy;
    logic [IDX_WIDTH-1:0]       fifo_pld;
    logic                       fifo_en;
    logic                       alloc_fire;
    logic                       complete_fire;
    logic                       retire_fire;
    logic                       retire_found;
    logic [IDX_WIDTH-1:0]       retire_idx;
    logic [ID_WIDTH-1:0]        retire_entry_id;
    logic [IDX_WIDTH-1:0]       retire_entry_next_idx;
    logic                       retire_entry_next_vld;
    logic                       alloc_link_prev;
    logic [IDX_WIDTH-1:0]       alloc_link_idx;
    //=====================================
    // interface
    //=====================================
    assign alloc_rdy       = fifo_vld;
    assign alloc_remap_id  = fifo_pld;
    assign complete_rdy    = 1'b1;
    assign retire_vld      = retire_found;
    assign retire_id       = v_entry_id[retire_idx];
    assign retire_pld      = v_entry_pld[retire_idx];


    //=====================================
    // preallocator
    //=====================================
    assign fifo_rdy = alloc_vld;
    assign fifo_en  = fifo_vld && fifo_rdy;
    assign alloc_fire    = alloc_vld && alloc_rdy;
    assign complete_fire = complete_vld && complete_rdy;
    assign retire_fire   = retire_vld && retire_rdy;

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

    fcip_sync_fifo_reg #(
        .FIFO_DEPTH (256      ),
        .FIFO_WIDTH (IDX_WIDTH),
        .FORWARD_EN (0        )
    ) u_id_fifo (
        .clk            (clk             ),
        .rst_n          (rst_n           ),
        .stall          (1'b0            ),
        .clear          (1'b0            ),
        .idle           (                ),
        .write_req_vld  (prealloc_vld    ),
        .write_req_pld  (prealloc_pld    ),
        .write_req_rdy  (prealloc_rdy    ),
        .read_resp_vld  (fifo_vld        ),
        .read_resp_pld  (fifo_pld        ),
        .read_resp_rdy  (fifo_rdy        ),
        .almost_full    (                ),
        .almost_empty   (                ),
        .empty          (                ),
        .full           (                )
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
    ) u_complete_id_dec (
        .in_en   (complete_fire),
        .in_index(complete_idx ),
        .v_out_en(v_complete_ack)
    );

    fcip_rob_id_dec #(
        .BIN_WIDTH(IDX_WIDTH)
    ) u_retire_id_dec (
        .in_en   (retire_fire),
        .in_index(retire_idx ),
        .v_out_en(v_retire_ack)
    );

    always_comb begin
        for (int id_idx = 0; id_idx < ID_COUNT; id_idx = id_idx + 1) begin
            v_id_head_vld_nxt[id_idx] = v_id_head_vld[id_idx];
            v_id_head_idx_nxt[id_idx] = v_id_head_idx[id_idx];
            v_id_tail_idx_nxt[id_idx] = v_id_tail_idx[id_idx];
        end

        if (retire_fire) begin
            if (retire_entry_next_vld) begin
                v_id_head_vld_nxt[retire_entry_id] = 1'b1;
                v_id_head_idx_nxt[retire_entry_id] = retire_entry_next_idx;
            end
            else begin
                v_id_head_vld_nxt[retire_entry_id] = 1'b0;
                v_id_head_idx_nxt[retire_entry_id] = '0;
                v_id_tail_idx_nxt[retire_entry_id] = '0;
            end
        end

        alloc_link_prev = 1'b0;
        alloc_link_idx  = '0;
        if (alloc_fire) begin
            alloc_link_prev = v_id_head_vld_nxt[alloc_id];
            alloc_link_idx  = v_id_tail_idx_nxt[alloc_id];

            if (!v_id_head_vld_nxt[alloc_id]) begin
                v_id_head_vld_nxt[alloc_id] = 1'b1;
                v_id_head_idx_nxt[alloc_id] = fifo_pld;
                v_id_tail_idx_nxt[alloc_id] = fifo_pld;
            end
            else begin
                v_id_tail_idx_nxt[alloc_id] = fifo_pld;
            end
        end
    end

    always_comb begin
        for (int entry_idx = 0; entry_idx < DEPTH; entry_idx = entry_idx + 1) begin
            v_link_ack[entry_idx] = alloc_fire && alloc_link_prev && (alloc_link_idx == entry_idx[IDX_WIDTH-1:0]);
        end
    end

    always_comb begin
        retire_found          = 1'b0;
        retire_idx            = '0;
        retire_entry_id       = '0;
        retire_entry_next_idx = '0;
        retire_entry_next_vld = 1'b0;

        for (int entry_idx = 0; entry_idx < DEPTH; entry_idx = entry_idx + 1) begin
            if (!retire_found && !v_prealloc_vld[entry_idx] && v_entry_done[entry_idx] &&
                v_id_head_vld[v_entry_id[entry_idx]] && (v_id_head_idx[v_entry_id[entry_idx]] == entry_idx[IDX_WIDTH-1:0])) begin
                retire_found          = 1'b1;
                retire_idx            = entry_idx[IDX_WIDTH-1:0];
                retire_entry_id       = v_entry_id[entry_idx];
                retire_entry_next_idx = v_entry_next_idx[entry_idx];
                retire_entry_next_vld = v_entry_next_vld[entry_idx];
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int id_idx = 0; id_idx < ID_COUNT; id_idx = id_idx + 1) begin
                v_id_head_vld[id_idx] <= 1'b0;
                v_id_head_idx[id_idx] <= '0;
                v_id_tail_idx[id_idx] <= '0;
            end
        end
        else begin
            for (int id_idx = 0; id_idx < ID_COUNT; id_idx = id_idx + 1) begin
                v_id_head_vld[id_idx] <= v_id_head_vld_nxt[id_idx];
                v_id_head_idx[id_idx] <= v_id_head_idx_nxt[id_idx];
                v_id_tail_idx[id_idx] <= v_id_tail_idx_nxt[id_idx];
            end
        end
    end

    //=====================================
    // entry
    //=====================================
    generate
        for(genvar gi = 0; gi < DEPTH; gi=gi+1) begin: GEN_ENTRY
            lwring_id_remap_entry #(
                .ID_WIDTH (ID_WIDTH ),
                .IDX_WIDTH(IDX_WIDTH),
                .PLD_WIDTH(PLD_WIDTH)
            ) u_entry (
                .clk           (clk                ),
                .rst_n         (rst_n              ),
                .prealloc_vld  (v_prealloc_vld[gi]  ),
                .prealloc_rdy  (v_prealloc_rdy[gi]  ),
                .alloc_ack     (v_alloc_ack[gi]     ),
                .alloc_id      (alloc_id           ),
                .link_ack      (v_link_ack[gi]      ),
                .link_next_idx (fifo_pld           ),
                .complete_ack  (v_complete_ack[gi]  ),
                .complete_pld  (complete_pld       ),
                .retire_ack    (v_retire_ack[gi]    ),
                .entry_id      (v_entry_id[gi]      ),
                .entry_next_idx(v_entry_next_idx[gi]),
                .entry_next_vld(v_entry_next_vld[gi]),
                .entry_done    (v_entry_done[gi]    ),
                .entry_pld     (v_entry_pld[gi]     )
            );
        end
    endgenerate

endmodule
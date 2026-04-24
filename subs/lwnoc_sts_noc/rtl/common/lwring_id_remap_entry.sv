module lwring_id_remap_entry
#(
    parameter ID_WIDTH   = 16,
    parameter IDX_WIDTH  = 8,
    parameter PLD_WIDTH  = 1
)(
    input  logic                   clk,
    input  logic                   rst_n,
    output logic                   prealloc_vld,
    input  logic                   prealloc_rdy,
    input  logic                   alloc_ack,
    input  logic [ID_WIDTH-1:0]    alloc_id,
    input  logic                   link_ack,
    input  logic [IDX_WIDTH-1:0]   link_next_idx,
    input  logic                   complete_ack,
    input  logic [PLD_WIDTH-1:0]   complete_pld,
    input  logic                   retire_ack,
    output logic [ID_WIDTH-1:0]    entry_id,
    output logic [IDX_WIDTH-1:0]   entry_next_idx,
    output logic                   entry_next_vld,
    output logic                   entry_done,
    output logic [PLD_WIDTH-1:0]   entry_pld
);

    //=====================================
    // internal signals
    //=====================================
    logic                       entry_idle;
    logic                       entry_prealloc;


    //=====================================
    // interface
    //=====================================
    assign prealloc_vld = entry_idle;

    //=====================================
    // state machine
    //=====================================
    assign entry_prealloc = prealloc_vld && prealloc_rdy;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            entry_idle     <= 1'b1;
            entry_id       <= '0;
            entry_next_idx <= '0;
            entry_next_vld <= 1'b0;
            entry_done     <= 1'b0;
            entry_pld      <= '0;
        end
        else begin
            if(retire_ack) begin
                entry_idle     <= 1'b1;
                entry_next_idx <= '0;
                entry_next_vld <= 1'b0;
                entry_done     <= 1'b0;
                entry_pld      <= '0;
            end
            else if(entry_prealloc) begin
                entry_idle     <= 1'b0;
                entry_next_idx <= '0;
                entry_next_vld <= 1'b0;
                entry_done     <= 1'b0;
                entry_pld      <= '0;
            end

            if(alloc_ack) begin
                entry_id <= alloc_id;
            end

            if(link_ack) begin
                entry_next_idx <= link_next_idx;
                entry_next_vld <= 1'b1;
            end

            if(complete_ack) begin
                entry_done <= 1'b1;
                entry_pld  <= complete_pld;
            end
        end
    end

endmodule 
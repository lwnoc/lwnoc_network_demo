module lwring_id_remap_entry
#(
    parameter ID_WIDTH  = 16
)(
    input  logic                clk,
    input  logic                rst_n,
    output logic                prealloc_vld,
    input  logic                prealloc_rdy,
    input  logic                alloc_ack,
    input  logic [ID_WIDTH-1:0] alloc_id,
    input  logic                check_ack,
    output logic [ID_WIDTH-1:0] check_id
);

    //=====================================
    // internal signals
    //=====================================
    logic                       entry_idle;
    // logic                       entry_vld;
    logic [ID_WIDTH-1:0]        entry_id;
    logic                       entry_prealloc;


    //=====================================
    // interface
    //=====================================
    assign prealloc_vld = entry_idle;
    assign check_id     = entry_id;

    //=====================================
    // state machine
    //=====================================
    assign entry_prealloc = prealloc_vld && prealloc_rdy;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                          entry_idle <= 1'b1;
        else if(check_ack)                  entry_idle <= 1'b1;
        else if(entry_prealloc)             entry_idle <= 1'b0;
    end

    // always_ff @(posedge clk or negedge rst_n) begin
    //     if(~rst_n)                          entry_vld <= 1'b0;
    //     else if(check_ack)                  entry_vld <= 1'b0;
    //     else if(alloc_ack)                  entry_vld <= 1'b1;
    // end


    //=====================================
    // buf id
    //=====================================
    always_ff @(posedge clk) begin
        if(alloc_ack)                  entry_id <= alloc_id;
    end

endmodule 
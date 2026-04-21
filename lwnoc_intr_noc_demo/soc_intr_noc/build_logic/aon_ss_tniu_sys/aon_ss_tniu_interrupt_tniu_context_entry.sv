module aon_ss_tniu_interrupt_tniu_context_entry
    import aon_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input logic                            clk,
    input logic                            rst_n,

    output logic                           entry_idle,
    input  logic                           entry_alloc_en,

    input  logic                           context_en,
    input  event_pkg                       context_pld,
    input  logic                           context_head,
    input  logic [CONTEXT_NUM_WIDTH-1:0]   advanced_context_id,

    output logic [INTERRUPT_NUM_WIDTH-1:0] context_intr_id,
    output logic                           context_tail,
    input  logic                           context_tail_cancel,

    output logic                           entry_rel_vld,
    input  logic                           entry_rel_rdy,

    input  logic [CONTEXT_NUM-1     :0]    v_link_rel_en,

    output logic                           intr_vld,
    input  logic                           intr_rdy,
    output intr_repeater_pkg               intr_pld

);
//==============================================================
// logic declarations
//==============================================================
    logic                           entry_rel_en;
    logic                           advance_en;
    logic                           toggle_flag_temp;
    logic [TIMER_COUNT_WIDTH-1:0]   timer;
    logic [CONTEXT_NUM_WIDTH-1:0]   advanced_context_id_reg;
//==============================================================
// entry idle
//==============================================================
    assign entry_rel_en = entry_rel_vld && entry_rel_rdy;
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            entry_idle <= 1'b1;
        end else if (entry_alloc_en) begin
            entry_idle <= 1'b0;
        end else if (entry_rel_en) begin
            entry_idle <= 1'b1;
        end
    end
//==============================================================
// timer && release
//==============================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            timer <= 0;
        end
        else if (intr_vld && intr_rdy) begin
            timer <= 1;
        end
        else if (timer>0 && timer < TIMER_COUNT) begin
            timer <= timer + 1;
        end
        else if (entry_rel_en) begin
            timer <= 0;
        end
    end

    assign entry_rel_vld = (timer == TIMER_COUNT);

//==============================================================
// link
//==============================================================

    //tail
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            context_tail <= 1'b0;
        end
        else if (context_en) begin
            context_tail <= 1'b1;
        end
        else if (context_tail_cancel || entry_rel_en) begin
            context_tail <= 1'b0;
        end

    end
    //pre context index
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            advance_en <= 1'b0;
            advanced_context_id_reg <= 0;
        end
        else if(context_en && ~context_head) begin
            advance_en <= 1'b1;
            advanced_context_id_reg <= advanced_context_id;
        end
        else if (entry_rel_en) begin
            advance_en <= 1'b0;
        end

    end
//==============================================================
// intr output
//==============================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            intr_vld <= 1'b0;
        end
        else if (context_en && ~context_head && v_link_rel_en[CONTEXT_NUM'(advanced_context_id)]) begin
            intr_vld <= 1'b1;
        end
        else if (context_en && context_head) begin
            intr_vld <= 1'b1;
        end
        else if (v_link_rel_en[CONTEXT_NUM'(advanced_context_id_reg)] && advance_en) begin
            intr_vld <= 1'b1;
        end
        else if (intr_vld && intr_rdy)begin
            intr_vld <= 1'b0;
        end
    end

    // always_ff @(posedge clk or negedge rst_n) begin
    //     if(~rst_n) begin
    //         toggle_flag_temp <= 1'b0;
    //         context_intr_id <= 0;
    //     end
    //     else if (context_en) begin
    //         toggle_flag_temp <= context_pld.toggle_flag;
    //         context_intr_id <= context_pld.tgt_intr_id;
    //     end
    // end
    always_ff @(posedge clk) begin
        if (context_en) begin
            toggle_flag_temp <= context_pld.toggle_flag;
            context_intr_id <= context_pld.tgt_intr_id;
        end
    end
    assign intr_pld.toggle_flag = toggle_flag_temp;
    assign intr_pld.tgt_intr_id = context_intr_id;

endmodule

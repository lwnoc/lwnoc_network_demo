module display_ss_iniu_interrupt_iniu_event_recorder
    import display_ss_iniu_interrupt_iniu_pkg::*;
#(
    parameter integer unsigned INTERRUPT_ID = 0
)(
    input  logic                                clk,
    input  logic                                rst_n,

    input  logic                                enable,
    input  logic                                interrupt,
    output logic                                event_vld,
    input  logic                                event_rdy,
    output recorder_pkg                         event_pld,

    input  logic                                stall,
    input  logic                                partial_rst,
    output logic                                idle,

    input  logic                                intr_type   // 0=level, 1=pulse
);
    //===========================================================================
    // logic declarations
    //===========================================================================
    logic                               interrupt_d1;
    logic                               interrupt_rise;
    logic                               event_xor;
    logic                               event_gate;
    logic                               event_gate_eff;
    logic                               event_state;
    logic [EVENT_COUNT_WIDTH-1  :0]     event_count;

    logic                               event_en;
    logic                               event_normal;
    logic                               toggle_flag;
    logic                               overflow;

    //===========================================================================
    // output assignments
    //===========================================================================
    assign idle = ~event_vld;

    assign event_pld.toggle_flag = intr_type ? 1'b1 : toggle_flag;
    assign event_pld.overflow    = overflow;
    assign event_pld.intr_addr   = INTERRUPT_MAXNUM_WIDTH'(INTERRUPT_ID);

    assign event_en = event_vld & event_rdy;
    assign event_normal = event_en & ~overflow;

    always_comb begin
        if(overflow)begin
            event_vld = 1'b1;
        end
        else if(event_count > 0)begin
            event_vld = 1'b1;
        end
        else if(toggle_flag && partial_rst) begin
            event_vld = 1'b1;
        end
        else begin
            event_vld = 1'b0;
        end

    end

    //===========================================================================
    // event state machine
    //===========================================================================

    assign interrupt_rise = interrupt & ~interrupt_d1;
    assign event_xor      = intr_type ? interrupt_rise : (interrupt ^ event_state);
    assign event_gate     = enable && ~partial_rst && (intr_type ? ~stall : (~stall || event_state));
    assign event_gate_eff = event_gate && event_xor;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            interrupt_d1 <= 1'b0;
        end
        else if(partial_rst) begin
            interrupt_d1 <= 1'b0;
        end
        else begin
            interrupt_d1 <= interrupt;
        end
    end

    always_ff @(posedge clk or negedge rst_n ) begin
        if(~rst_n)begin
            event_state <= 1'b0;
        end
        else if(partial_rst)begin
            event_state <= 1'b0;
        end
        else if(~intr_type && event_gate_eff)begin
            event_state <= interrupt;
        end
    end

    always_ff @(posedge clk or negedge rst_n ) begin
        if(~rst_n)begin
            event_count <= 0;
        end
        else if(partial_rst) begin
            event_count <= 0;
        end
        else if(overflow)begin
            if(intr_type) begin
                event_count <= 0;
            end
            else if(toggle_flag == interrupt) begin
                event_count <= 2;
            end
            else begin
                event_count <= 3;
            end
        end
        else if(event_count < EVENT_COUNT_MAX) begin
            if(event_gate_eff | event_normal) begin
                event_count <= event_count + event_gate_eff - event_normal;
            end
        end
        else if(event_normal) begin
            event_count <= event_count - event_normal;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            overflow <= 1'b0;
        end
        else if(partial_rst) begin
            overflow <= 1'b0;
        end
        else if((event_count == EVENT_COUNT_MAX) && event_gate_eff) begin
            overflow <= 1'b1;
        end
        else if(event_en && overflow) begin
            overflow <= 1'b0;
        end
    end

    always_ff @( posedge clk or negedge rst_n ) begin
        if(~rst_n) begin
            toggle_flag <= 1'b1;
        end
        else if(event_normal) begin
            toggle_flag <= ~toggle_flag;
        end
    end



endmodule

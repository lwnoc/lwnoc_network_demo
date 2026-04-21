module display_ss_tniu_interrupt_tniu_event_repeater
    import display_ss_tniu_interrupt_tniu_pkg::*;
(
    input  logic                            clk,
    input  logic                            rst_n,

    input  logic                            intr_set,
    input  logic                            intr_clr,

    input  logic                            intr_en,
    input  logic                            intr_toggle,

    input  logic                            intr_type,  // 0=level, 1=pulse

    output logic                            interrupt,

    input  logic                            partial_reset,
    output logic                            idle
);

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            interrupt <= 1'b0;
        end else if(partial_reset)begin
            interrupt <= 1'b0;
        end else if (intr_set) begin
            interrupt <= 1'b1;
        end else if (intr_clr) begin
            interrupt <= 1'b0;
        end else if (intr_en) begin
            // pulse mode: always assert 1; level mode: track toggle_flag
            interrupt <= intr_type ? 1'b1 : intr_toggle;
        end else if (intr_type && interrupt) begin
            // pulse mode auto-clear: deassert the cycle after intr_en
            interrupt <= 1'b0;
        end
    end

    assign idle = ~interrupt;

endmodule

module dspss4_tniu_interrupt_tniu_event_merge
    import dspss4_tniu_interrupt_tniu_pkg::*;
(
    input  logic                            clk,
    input  logic                            rst_n,

    input  logic [31:0]                     intr_mask,

    input  logic [31:0]                     intr_en,
    output logic                            intr_merge
);

    assign intr_merge = |(intr_en & ~intr_mask);

endmodule

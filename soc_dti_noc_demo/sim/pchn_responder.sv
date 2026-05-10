// pchn responder - simple handshake for testbench
// Drives paccept/pactive based on preq/pstate from DUT
// Reset: pactive=P_POWER_ON(0), no request pending

module pchn_responder (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       preq,
    input  logic [1:0] pstate,  // lwnoc_pchannel_state_t
    output logic       paccept,
    output logic [1:0] pactive,  // lwnoc_pchannel_active_t
    output logic       pdeny
);
    reg preq_q;
    always_ff @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            preq_q <= 0;
            paccept <= 0;
            pdeny   <= 0;
            pactive <= 0;  // P_POWER_ON
        end else begin
            preq_q <= preq;
            paccept <= 0;
            pdeny   <= 0;
            // If preq rises with valid pstate, accept immediately
            if (preq && !preq_q) begin
                paccept <= 1;
                pactive <= pstate;
            end
        end
endmodule

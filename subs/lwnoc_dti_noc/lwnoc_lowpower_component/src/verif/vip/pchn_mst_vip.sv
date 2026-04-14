// P-channel Master VIP
// - Drives preq/pstate
// - Waits for paccept/pdeny
// - Auto-deasserts preq after accept/deny
// - send_request returns: 0=ACCEPT, 1=DENY, -1=TIMEOUT
module pchn_mst_vip 
    import lwnoc_lp_define_package::*;
#(
    parameter int TIMEOUT_CYCLES = 1000,
    parameter bit VERBOSE = 1
)(
    input  logic                   clk,
    input  logic                   rst_n,
    // P-channel signals to DUT
    output logic                   preq,
    output lwnoc_pchannel_state_t  pstate,
    input  lwnoc_pchannel_active_t pactive,
    input  logic                   paccept,
    input  logic                   pdeny
);

    // Init defaults
    initial begin
        preq   = 1'b0;
        pstate = P_POWER_ON;
    end

    // Optional simple monitor
    generate if (VERBOSE) begin : g_v
        initial begin
            $display("[%0t] PCH VIP online", $time);
        end
    end endgenerate

    // Blocking request: drive preq/pstate, wait for accept/deny or timeout
    // result: 0=accept, 1=deny, -1=timeout
    task automatic send_request(
        input  lwnoc_pchannel_state_t t_state,
        output int                    result,
        input  int                    timeout_cycles = TIMEOUT_CYCLES
    );
        int    cycles;
        string s_state;
        string s_done;
        // drive
        @(posedge clk);
        pstate <= t_state;
        preq   <= 1'b1;
        // pretty name
        case (t_state)
            P_POWER_ON:   s_state = "P_POWER_ON";
            P_LEVEL1_OFF: s_state = "P_LEVEL1_OFF";
            P_LEVEL2_OFF: s_state = "P_LEVEL2_OFF";
            P_LEVEL3_OFF: s_state = "P_LEVEL3_OFF";
            default:      s_state = $sformatf("UNKNOWN(%0d)", t_state);
        endcase
        if (VERBOSE)
            $display("[%0t] PCH VIP: SEND request state=%s (preq=1)", $time, s_state);
        cycles = 0;
        // wait loop
        forever begin
            @(posedge clk);
            cycles++;
            if (paccept) begin
                result = 0;
                s_done = "ACCEPT";
                break;
            end
            if (pdeny) begin
                result = 1;
                s_done = "DENY";
                break;
            end
            if (timeout_cycles >= 0 && cycles >= timeout_cycles) begin
                result = -1;
                s_done = "TIMEOUT";
                break;
            end
        end
        if (VERBOSE)
            $display("[%0t] PCH VIP: DONE result=%s after %0d cycles (state=%s, pactive=%0d)",
                     $time, s_done, cycles, s_state, pactive);
        // auto deassert preq after decision
        @(posedge clk);
        preq <= 1'b0;
        if (VERBOSE)
            $display("[%0t] PCH VIP: CLEAR request (preq=0)", $time);
    endtask

    // Convenience wrappers
    task automatic power_on(output int result, input int timeout_cycles = TIMEOUT_CYCLES);
        send_request(P_POWER_ON, result, timeout_cycles);
    endtask
    task automatic level1_off(output int result, input int timeout_cycles = TIMEOUT_CYCLES);
        send_request(P_LEVEL1_OFF, result, timeout_cycles);
    endtask
    task automatic level2_off(output int result, input int timeout_cycles = TIMEOUT_CYCLES);
        send_request(P_LEVEL2_OFF, result, timeout_cycles);
    endtask
    task automatic level3_off(output int result, input int timeout_cycles = TIMEOUT_CYCLES);
        send_request(P_LEVEL3_OFF, result, timeout_cycles);
    endtask

endmodule

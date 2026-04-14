/*
 * File: lwnoc_lp_hub_tiny_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 26th August 2025 10:28:33 pm
 * Author: Zou Zhili
 * -----
 * Description:
 *  tiny hub (terminal <=3) wrapper
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:11:10 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_hub_tiny_wrapper
    import dti_sw_right4_lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned NUM_TERMINAL = 3
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  lwnoc_lp_req_signal_t v_rx_req[NUM_TERMINAL-1:0],
    output lwnoc_lp_req_signal_t v_tx_req[NUM_TERMINAL-1:0]
);

    // ===========================================================================
    // Tiny wrapper uArch (NUM_TERMINAL <= 3)
    //
    // One lwnoc_lp_hub_3terminal is used. The first NUM_TERMINAL terminals are
    // exposed to the wrapper interface. Any remaining hub terminals are internally
    // terminated by lwnoc_lp_endpoint to avoid floating signals.
    //
    // ASCII diagram (example NUM_TERMINAL=2):
    //
    //   External IF
    //     v_rx_req[0]
    //         |
    //   +-------------------+
    //   |                   |
    //   |  HUB_3T           |
    //   |  term[0] <-----> v_tx_req[0]
    //   |  term[1] <-----> v_tx_req[1]
    //   |  term[2] <-----> (endpoint)
    //   +-------------------+
    //                 ^
    //                 |
    //            endpoint.rx_req <- hub.tx_req[2]
    //
    // Mapping:
    //   for i in [0..NUM_TERMINAL-1]
    //     v_rx_req_hub[i] = v_rx_req[i]
    //     v_tx_req[i]     = v_tx_req_hub[i]
    //   for i in [NUM_TERMINAL..2]
    //     endpoint connects v_rx_req_hub[i] <-> v_tx_req_hub[i]
    // ===========================================================================

    //===========================================================================
    // Internal Logic
    //===========================================================================
    lwnoc_lp_req_signal_t v_tx_req_hub[3-1:0];
    lwnoc_lp_req_signal_t v_rx_req_hub[3-1:0];

    //===========================================================================
    // Hub
    //===========================================================================
    lwnoc_lp_hub_3terminal u_hub_3terminal (
        .v_rx_req(v_rx_req_hub),
        .v_tx_req(v_tx_req_hub)
    );

    //===========================================================================
    // Terminal allocation
    //===========================================================================
    generate
        for (genvar i = 0; i < NUM_TERMINAL; i++) begin : gen_terminal_alloc
            assign v_tx_req[i]     = v_tx_req_hub[i];
            assign v_rx_req_hub[i] = v_rx_req[i];
        end
    endgenerate

    //===========================================================================
    // Connect unused terminal to endpoint
    //===========================================================================
    generate
        if (NUM_TERMINAL < 3) begin : gen_unsued
            // Connect unused terminal to endpoint
            for (genvar i = NUM_TERMINAL; i < 3; i++) begin : gen_endpoint
                lwnoc_lp_endpoint u_endpoint (
                    .clk   (clk),
                    .rst_n (rst_n),
                    .tx_req(v_rx_req_hub[i]),
                    .rx_req(v_tx_req_hub[i])
                );
            end
        end
    endgenerate

endmodule

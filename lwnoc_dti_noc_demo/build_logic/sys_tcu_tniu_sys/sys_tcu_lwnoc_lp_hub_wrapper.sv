/*
 * File: lwnoc_lp_hub_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Wednesday, 27th August 2025 1:14:31 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  Wrapper for low-power hub with variable number of terminals.
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:11:32 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_hub_wrapper
    import sys_tcu_lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned NUM_TERMINAL = 5
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  lwnoc_lp_req_signal_t v_rx_req[NUM_TERMINAL-1:0],
    output lwnoc_lp_req_signal_t v_tx_req[NUM_TERMINAL-1:0]
);

    //===========================================================================
    // Internal logic
    //===========================================================================
    generate
        if (NUM_TERMINAL <= 3) begin : gen_tiny_hub
            lwnoc_lp_hub_tiny_wrapper #(
                .NUM_TERMINAL(NUM_TERMINAL)
            ) u_tiny_hub (
                .clk     (clk),
                .rst_n   (rst_n),
                .v_rx_req(v_rx_req),
                .v_tx_req(v_tx_req)
            );
        end
        else if (NUM_TERMINAL == 4) begin : gen_small_hub
            lwnoc_lp_hub_small_wrapper u_small_hub (
                .v_rx_req(v_rx_req),
                .v_tx_req(v_tx_req)
            );
        end
        else begin : gen_large_hub
            lwnoc_lp_hub_large_wrapper #(
                .NUM_TERMINAL(NUM_TERMINAL)
            ) u_large_hub (
                .v_rx_req(v_rx_req),
                .v_tx_req(v_tx_req)
            );
        end
    endgenerate
endmodule

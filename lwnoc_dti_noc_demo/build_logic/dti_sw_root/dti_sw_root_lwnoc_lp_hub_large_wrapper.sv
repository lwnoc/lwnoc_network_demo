/*
 * File: lwnoc_lp_hub_large_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 26th August 2025 3:29:57 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  large size (TERMINAL >= 5) hub wrapper
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:10:01 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_hub_large_wrapper
    import dti_sw_root_lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned NUM_TERMINAL = 5
) (
    input  lwnoc_lp_req_signal_t v_rx_req [NUM_TERMINAL-1:0],
    output lwnoc_lp_req_signal_t v_tx_req [NUM_TERMINAL-1:0]
);

// ===========================================================================
// Large wrapper uArch (NUM_TERMINAL >= 5)
//
// Topology:
//   - Head hub exposes 2 terminals to the wrapper (t0->IF[0], t1->IF[1]) and uses t2
//     to cascade to the next hub via a bidirectional "prev" link.
//   - Each Internal hub exposes 1 terminal (t1->IF[2..NUM_TERMINAL-3]) and uses
//     t0/t2 to cascade with its previous/next neighbor.
//   - Tail hub exposes 2 terminals (t1->IF[NUM_TERMINAL-2], t2->IF[NUM_TERMINAL-1])
//     and uses t0 to connect to the last prev link.
//
//   NUM_INTER_HUB = NUM_TERMINAL - 4
//   Total hubs = 2 (head, tail) + NUM_INTER_HUB
//
// ASCII diagram (example NUM_TERMINAL=7 -> NUM_INTER_HUB=3):
//
//   IF[0]             IF[2]            IF[3]            IF[4]        IF[5]       IF[6]
//     |                 |                |                |            |           |
//   +-----+         +--------+       +--------+       +--------+   +-----+     +-----+
//   | t0  |         |  t1    |       |  t1    |       |  t1    |   | t1  |     | t2  |
//   |     |         |        |       |        |       |        |   |     |     |     |
//   |HEAD |         | INT[0] |       | INT[1] |       | INT[2] |   |TAIL |     |TAIL |
//   |     |         |        |       |        |       |        |   |     |     |     |
//   | t2=====================t0=====>|        |<=====t2======================t0     |
//   +-----+           ^    ^         +--------+       ^    ^       +-----+     +-----+
//                     |    |                          |    |
//      |         prev[0]  prev[1]                 prev[2]  prev[3]
//    IF[1]
// Legend:
//   - "prev[i]" are bidirectional bundles implemented as v_rx_req_prev[i]/v_tx_req_prev[i]
//     carrying the hub signal struct; connections are made by cross-assigning rx/tx.
//   - Exposed IF mapping:
//       IF[0]  <-> HEAD.t0
//       IF[1]  <-> HEAD.t1
//       IF[2]  <-> INT[0].t1
//       ...
//       IF[NUM_TERMINAL-3] <-> INT[NUM_INTER_HUB-1].t1
//       IF[NUM_TERMINAL-2] <-> TAIL.t1
//       IF[NUM_TERMINAL-1] <-> TAIL.t2
//   - Cascade links:
//       HEAD.t2 <==prev[0]==> INT[0].t0
//       INT[i].t2 <==prev[i+1]==> INT[i+1].t0
//       INT[NUM_INTER_HUB-1].t2 <==prev[NUM_INTER_HUB]==> TAIL.t0
// ===========================================================================

//===========================================================================
// Local param
//===========================================================================
    // How many internal hub used
    localparam integer unsigned NUM_INTER_HUB = NUM_TERMINAL-4;

//===========================================================================
// Internal signal
//===========================================================================
    // HEAD HUB
    lwnoc_lp_req_signal_t v_rx_req_head_hub [3-1:0];
    lwnoc_lp_req_signal_t v_tx_req_head_hub [3-1:0];

    // INTERNAL HUB
    lwnoc_lp_req_signal_t v_rx_req_inter_hub [NUM_INTER_HUB-1:0][3-1:0];
    lwnoc_lp_req_signal_t v_tx_req_inter_hub [NUM_INTER_HUB-1:0][3-1:0];

    // Tail HUB
    lwnoc_lp_req_signal_t v_rx_req_tail_hub [3-1:0];
    lwnoc_lp_req_signal_t v_tx_req_tail_hub [3-1:0];

    // Prev wire
    lwnoc_lp_req_signal_t v_rx_req_prev [NUM_INTER_HUB:0];
    lwnoc_lp_req_signal_t v_tx_req_prev [NUM_INTER_HUB:0];


//===========================================================================
// Head Hub
//===========================================================================
    lwnoc_lp_hub_3terminal u_hub_head (
        .v_rx_req (v_rx_req_head_hub),
        .v_tx_req (v_tx_req_head_hub)
    );

    // terminal 0 to interface
    assign v_rx_req_head_hub[0] = v_rx_req[0];
    assign v_tx_req[0]          = v_tx_req_head_hub[0];
    // terminal 1 to interface
    assign v_rx_req_head_hub[1] = v_rx_req[1];
    assign v_tx_req[1]          = v_tx_req_head_hub[1];
    // terminal 2 is first previous wire
    assign v_rx_req_head_hub[2] = v_rx_req_prev[0];
    assign v_tx_req_prev[0]     = v_tx_req_head_hub[2];


//===========================================================================
// Internal Hub
//===========================================================================
    generate
        for (genvar i = 0; i < NUM_INTER_HUB; i++) begin : gen_inter_hub
            lwnoc_lp_hub_3terminal u_hub_inter (
                .v_rx_req (v_rx_req_inter_hub[i]),
                .v_tx_req (v_tx_req_inter_hub[i])
            );

            // terminal 0: prev[i]
            assign v_rx_req_prev[i]         = v_tx_req_inter_hub[i][0];
            assign v_rx_req_inter_hub[i][0] = v_tx_req_prev[i];
            // terminal 1: interface
            assign v_rx_req_inter_hub[i][1] = v_rx_req[i+2];
            assign v_tx_req[i+2]            = v_tx_req_inter_hub[i][1];
            // terminal 2: prev[i+1]
            assign v_tx_req_prev[i+1]       = v_tx_req_inter_hub[i][2];
            assign v_rx_req_inter_hub[i][2] = v_rx_req_prev[i+1];

        end
    endgenerate

//===========================================================================
// Tail Hub
//===========================================================================
    lwnoc_lp_hub_3terminal u_hub_tail (
        .v_rx_req (v_rx_req_tail_hub),
        .v_tx_req (v_tx_req_tail_hub)
    );

    // terminal 0: connect to last prev
    assign v_rx_req_tail_hub[0] = v_tx_req_prev[NUM_INTER_HUB];
    assign v_rx_req_prev[NUM_INTER_HUB] = v_tx_req_tail_hub[0];

    // terminal 1: connect to interface
    assign v_rx_req_tail_hub[1] = v_rx_req[NUM_TERMINAL-2];
    assign v_tx_req[NUM_TERMINAL-2] = v_tx_req_tail_hub[1];

    // terminal 2: connect to interface
    assign v_rx_req_tail_hub[2] = v_rx_req[NUM_TERMINAL-1];
    assign v_tx_req[NUM_TERMINAL-1] = v_tx_req_tail_hub[2];

endmodule
